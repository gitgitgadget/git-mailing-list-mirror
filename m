Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51B36680E
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775330; cv=none; b=BNbjE6ypTHmyhpd3vx2qRYv6pVSVUOwGVDw+anOep2ygklC2tfirKaciyVa3J21k6/Ud9RL/3uzcQ+KJRVnlnj8ixyq+O238xCy8+ADiIPhjXIWMBaY4Sw+ECSeEuLqg9DGfwUBni1e/iMaKosnx7wCeb9hVJccQ0RAag8CNgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775330; c=relaxed/simple;
	bh=npS15YFuEKhoJcgn7NZGntKnehRVmFgdekKgHMzz5dE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iqB5Rm0fANd7mc5hMLtDqcxEq3neX8m5c/S9qXzLGmYcTZzfb+J0sJdHAKEHlAB/wcj8FY0uRluIDt52Nn5X8m/Lw+NyoaPji9tomUf2+I27rVvaS2y2LQtwDQrTyz/BWy+cR7Vr9JENY6eQ3PGJ5OhDOqyHzrnZJDfV0uwaBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meoUI8RO; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meoUI8RO"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8ccc7755so2774860c88.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775327; x=1777380127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ5AQlDQO0dWrMsLT68hGbAW+P4tfvnLcvDlhTuNHZE=;
        b=meoUI8ROjP+3RAAHAq13cARGYcX+0HftIXHcCgY0tFKU4AaOy080jI0yPZK/QWYpKf
         xqVd9awnq0QtJaOaMc0I7VCTs0qvc2V1pI8J1GYCiGbjGbQfYBjCHrquK76VZiwVWCBh
         RVAOMsqF0FRVxmzHwVjyFTqWm6zXiNsrrxpIpOh4fOESaflCesHZIGOpCetQ8wNcdCiT
         SpquzKRkuEZMfPLzV8D5HCEDpt4bSGsTDTpfZz+tgeVu/EOQ7buglGCmewubV8CnN/C2
         Z0ZA56UZqpIH4W1iEfObyggEB2di64tbJQeXC7YzXC9bPgaj96J3qNbjHMexJLvn1Aoa
         Cpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775327; x=1777380127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJ5AQlDQO0dWrMsLT68hGbAW+P4tfvnLcvDlhTuNHZE=;
        b=sXQDKxeJsmOiQZH999QDPixeSqF/EOW1koxek05EbX8Jq2g5ABUQCfLMABAr6IKSjf
         5pDWFe7K0RYgPlRvSrEaWkzaWdTkSVfNsCGTWtbvO5xY90yXgxAq9mi7LYL7fy+fMtVh
         Kxt+oq+aiN2o5CdnlZimeVIeMUHv4YRVUIXPTXehNnHgBjuxncovGZ+PQe96mt+PPmNs
         yg1TfoWmKkYtFKRVjoNEFkGzmlbq6TrDXpCdTH2FAU1U6WBROgg1rK1SDLcTdsTBnj1e
         yrx3rFPMWTZjU6SdRSowYKTnUNr5Bht6ZMkJMcfBFlIphqXRixpAnArN9FW0S34Aid/+
         Z5rA==
X-Gm-Message-State: AOJu0Yxycs8r4EMHL3n7+IysjjhTJFOnHbKEMZDZ3tjGcyGSNymfR1sR
	rC+hRfE2oLddG2hWtMwcxT5qOR+vwTDmX5Wdct4dNAftU3IpGJoafqzKwKvXhg==
X-Gm-Gg: AeBDievHMcy3DYDkBEG9DXUeyZBlHSbMKvESsPFvUQIqMxKR5pyN+tP0Iyon7dMT1Fs
	p8WGa83rPbqnwmH1SYV1xg/cHN4BaNVPPRBtvaO8TsVTWCrOd2VQEjL91NZ1aRXxW9VqrhIdVN+
	lklhjz+WZX6inrgczMJMj5XMkjdoT9EQn4lLIUqZkITNu217RxwsE76z1eRaCkPCdQFDmehEJwa
	OozoRF0rc9+Z53+eN0ZyKgbo6p2zFrW0efI+gr+FC5AlpRMIV4x7qXWchfNMgzBEANSp44WEXAk
	cLLtU5AwfbcCgo/TmTshx+u4W3vTB7sVSlNPeXvi9Jm5Yih/5Pr5qN5UV00bljlZoN8QIjm6UP6
	0J3Ouy5Ra6trgSYdNek9q5FD5eytfoPhFrdQfCW3qJa7UMb1t9EcNbTVXLcx+jpG3NoxImlhrxS
	waasn516fjvM1l5t9VvQwbQ8/QaVAJ5HzX0M4=
X-Received: by 2002:a05:7022:12b:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12c73fa8d16mr9810815c88.34.1776775327256;
        Tue, 21 Apr 2026 05:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.55.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c7b62fe87sm15310487c88.2.2026.04.21.05.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:42:05 -0700 (PDT)
Message-Id: <5d719b3729e39d63ec0a1a474b0c1ff57570133e.1776775319.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 12:41:57 +0000
Subject: [PATCH 2/4] ci: bump actions/{upload,download}-artifact to v7 and v8
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`actions/upload-artifact` and `actions/download-artifact` are tightly
coupled: the upload action writes artifact archives in a format that
the download action then reads. Because of this coupling, the two
actions should always be bumped together so that the artifact format
contract between them is satisfied.

All of our `actions/upload-artifact` uses are still on v5, with one
stray v4 occurrence. Keeping them on these versions would leave the
artifact-upload steps running on Node.js 20, which GitHub is phasing
out, and would eventually cause all upload steps to fail.

Going from v5 directly to v7 folds in two release bumps:

- v6 switches the action's default runtime from Node.js 20 to
  Node.js 24 (v5 had preliminary Node 24 support but still defaulted
  to Node 20). This is the main motivation for bumping now: it gets
  us off the deprecated runtime.
- v7 adds two opt-in features: direct (unzipped) single-file uploads
  via a new `archive: false` parameter, and an internal conversion of
  the action to ESM to match the updated `@actions/*` packages.

Risk analysis: we never pass `archive`, so the zip-as-usual behavior
is unchanged. We also do not `require('@actions/*')` from any calling
workflow, so the ESM migration cannot affect us. The upload steps we
care about -- tracked files/build artifacts and failing-test
directories -- keep the same inputs (`name`, `path`) and outputs, so
the diff is purely the `@vN` identifier. The main precondition is a
recent Actions Runner (>= 2.327.1), which the github.com-hosted
runners used by our CI already satisfy.

While at it, align the one remaining `@v4` occurrence with the rest
so that every `upload-artifact` step uses the same version.

See also:

- Release notes: https://github.com/actions/upload-artifact/releases
- Compare: https://github.com/actions/upload-artifact/compare/v5...v7

We use `actions/download-artifact` to pass build artifacts between
the "windows-build" / "vs-build" / "windows-meson-build" jobs and
their corresponding test jobs. All callers are currently on v6;
bumping to v8 keeps this action in lockstep with the `upload-artifact`
bump above.

What v7 and v8 change:

- v7 switches the default runtime from Node.js 20 to Node.js 24 (v6
  had preliminary Node 24 support but still defaulted to Node 20).
  This is the main motivation: it gets us off the deprecated runtime.
- v8 makes three further changes:
  * The package is converted to ESM (invisible to workflow authors).
  * The action now checks the `Content-Type` header before
    attempting to unzip a download, so that directly-uploaded
    (unzipped) artifacts from `upload-artifact` v7 are downloaded
    correctly.
  * The `digest-mismatch` behaviour is changed from warn-and-
    continue to a hard failure by default.

Risk analysis: defaulting hash-mismatch to a hard failure is
strictly safer than the previous warn-and-continue behaviour -- a
mismatch points to real corruption or tampering and should stop the
run. We download archives that the same workflow just uploaded, on
the same runner fleet, so false positives are not expected. Our
usage is limited to the `name` and `path` inputs, which are
unchanged between v6 and v8, so the diff is purely the `@vN`
identifier.

See also:

- Release notes: https://github.com/actions/download-artifact/releases
- Compare: https://github.com/actions/download-artifact/compare/v6...v8

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0d3e0e42a4..da31b10c79 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,7 +123,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: windows-artifacts
         path: artifacts
@@ -140,7 +140,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v6
+      uses: actions/download-artifact@v8
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -157,7 +157,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-windows-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -208,7 +208,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: vs-artifacts
         path: artifacts
@@ -226,7 +226,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v6
+      uses: actions/download-artifact@v8
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -244,7 +244,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-windows-vs-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -270,7 +270,7 @@ jobs:
       shell: pwsh
       run: meson compile -C build
     - name: Upload build artifacts
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: windows-meson-artifacts
         path: build
@@ -292,7 +292,7 @@ jobs:
       shell: pwsh
       run: pip install meson ninja
     - name: Download build artifacts
-      uses: actions/download-artifact@v6
+      uses: actions/download-artifact@v8
       with:
         name: windows-meson-artifacts
         path: build
@@ -305,7 +305,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-windows-meson-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -349,7 +349,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -449,7 +449,7 @@ jobs:
       run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v5
+      uses: actions/upload-artifact@v7
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
gitgitgadget

