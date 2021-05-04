#! /bin/bash
# Copyright 2020 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDIcd TIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# `-e` enables the script to automatically fail when a command fails
set -e

# Kokoro setup
if [ -n "$KOKORO_GFILE_DIR" ]; then
  # Move into project directory
  cd github/cloud-sql-python-connector
  # source secrets
  source "${KOKORO_GFILE_DIR}/TEST_SECRETS.sh"
  export GOOGLE_APPLICATION_CREDENTIALS="${KOKORO_GFILE_DIR}/testing-service-account.json"
fi

# Add python and pip to PATH
export PATH=/c/python37:/c/python37/scripts:$PATH

# install nox for testing
pip install --user -q nox

# add nox to path
export PATH="/c/Users/kbuilder/AppData/Roaming/Python/Python37/Scripts:$PATH"

echo -e "******************** Running tests... ********************\n"
nox -s "$RUN_TESTS_SESSION"
echo -e "******************** Tests complete.  ********************\n"