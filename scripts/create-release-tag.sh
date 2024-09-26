#!/bin/bash

set -e

# To stash any changes created by dapper CI run
git stash

# Remove the 'release-' prefix to create the tag name
TAG="${RELEASE_BRANCH#release-}"

echo "[INFO] Creating the tag: $TAG for branch: $RELEASE_BRANCH"
# Create the tag
if ! git tag "$TAG" "$RELEASE_BRANCH"; then
    echo "[WARN] Failed while creating the tag $TAG in the repository."
    exit 1
fi

# Push the tag to origin
if ! git push origin "$TAG"; then
    echo "[WARN] Failed while pushing the tag $TAG to the repository."
    exit 1
else
    echo "[INFO] Successfully pushed tag $TAG: https://github.com/rancher/kubernetes/releases/tag/$TAG"
fi