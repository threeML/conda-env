#!/bin/bash

export channels="-c conda-forge -c fermi -c threeML"

export MPLBACKEND='Agg'

# First, let's build the meta package
# This downloads all packages as specified into recipe/meta.yaml
conda build ${channels} recipe --python=2

# Now let's create and env with the package just built
# This will contain all dependencies
conda create -y --name threeML_env --use-local ${channels} threeML_meta

# Build the tar file
source activate threeML_env

python -c "import ROOT"
python -c "import pygmo"

conda pack -o threeML_env.tar.gz

echo "Package size: "`du -h threeML_env.tar.gz`
