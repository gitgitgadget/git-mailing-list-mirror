Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C7391517
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114728; cv=none; b=tZ8E3lggIUXMJhxOBZR3S08AUn6co1ajfgscCdnZxB7IA/1kihbDCsYCzJgxzNygHTD4Lwlf5pHTthHYvPkMThXmLVsB4pTRdvutHMxGgBa6Xl43o4mPwjyH1T9IdVqK4vtXRjt92XKNdTepAMIXLqGJo7s1baJD+6Nd/p8Y7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114728; c=relaxed/simple;
	bh=npS15YFuEKhoJcgn7NZGntKnehRVmFgdekKgHMzz5dE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KuK7d+PMn3hH/b2IxoZPBXIYq10FiE1eRtx5skIsj8rK31z4ghFa+H6Pk+prHewryvnWjmwJOudf153c4u5m3XndPEv5QCNxHtjb0NBOgZZ9eNkHfT8iDTF7jNPtQ2ZaCvjdTgkvYYywel3MUSk+Njs8txNlORZ1Ny8zrKUADEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXjakLqf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXjakLqf"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a154cc6a48so96463416d6.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114725; x=1777719525; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ5AQlDQO0dWrMsLT68hGbAW+P4tfvnLcvDlhTuNHZE=;
        b=dXjakLqff8NnXPOWXXNXDQ166AGGbzZUENyEQmR8bo3ju+4wr1ELwCR8UpE7ekoxbM
         duEX1bwHP/QHUrgj1w7uj1CHPTBRwJXhctekreBERNpYHA4/IbY0jJBzlu2h5+cSH27G
         JFHZGThK5lr60/jXmUEjCoudDB8jYTr2HsQkQ8UNJ7/wfQ3NurKQhVBjfKVDYhDAzouH
         ycvzw0akbCWFhzLJp/BoTnJd+/vuwlU59GPaSamGnsaUyjmae4AtPFbeooFWzTwGX6sY
         eCFGgw4X/h3H2eNCNpLLr6YE8umVix4YRNKzuiZfPzig7mooy25PXHBx6z6sLuKFu8qk
         Htjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114725; x=1777719525;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJ5AQlDQO0dWrMsLT68hGbAW+P4tfvnLcvDlhTuNHZE=;
        b=TxTgqAaPDGLjQ5CKNJ9QYxt6MBycSWBg+CCCXKQoj610v32fxUPLhk0po5A02zzahI
         MpDLF6G3zU313t7I+kdMMSuEk6PiFov6bi+KJV3oQXY5ah1fBJaLJNPvFsED5gy5Kks/
         bUxwjKm++72e1ikxQjmTNmry3dZCjG/Kf3KMom+KZHdsCPxXv4uQy3fsheA/tWkec7Hf
         CwEnFi5FdQg9vdjJa2qqZc5VMdQOtnTQvDvfuDeJltO7pNO+us1Lkx1suYM81KEgO78C
         DrZjniF3Z7ZX/CUuTKu5dAgZJ7A3vJjL1Q/rGslEbefm5Hy6y3AhdGd0D6Mw9rNiOVU4
         ok8Q==
X-Gm-Message-State: AOJu0Yyo1PPBdGU8Uc93wB/y7H9sZRkLKIGCZIvoDGY3jnYa5lVGMtON
	7Ykb3WXJScoFJoehGSighY7tFNyf2Cwm63hOyE3OBVaL3xoKMtccH14/LaT6dQ==
X-Gm-Gg: AeBDietwXPhmn9tMpeDjEDyt/ig9iXLznnr/OXe/lFVx3auvdOToQgcVEO0MOKAEpDy
	MX1g1oHBMLIX/6O9plBVDbxtsyp5/gPH1YSarEctE3JJnbL4h4cZ8VySDP+u9ICRNivceMB40eL
	7tjW9kGWpQ6HtKVh2u7m9k+V16QVB5ja4F728tbCtQwTrA6ACNSPLa8YW5+eNvyHzQxCkYRIUHJ
	KHnFssusQAGsou1+bti55p8mIQoMZqCiPMX06foLxYkmXFLCm+8hGoTtu1GnmCiCYvw+dz6lzCn
	ThXJ/9e5K2mqTZjOnjtV3aEDikldbRhMFfoFeCG8TqFFZmBuJywnnclGFP3kwCYjG0YrWj+Djhf
	bHyRTyra5UBJf7I86o0pLo9m2HWwid8P3X+SqmcAccG8dJl5T20OYOgnfkiWAn0DBgQbB+fmpBD
	Ghp285Cm96eEFufXWzFmsmiyFctSfkS0mZmHJIyw==
X-Received: by 2002:a05:6214:5f83:b0:8ac:b43a:42d8 with SMTP id 6a1803df08f44-8b028012743mr499971296d6.12.1777114725074;
        Sat, 25 Apr 2026 03:58:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae88d5fsm264935246d6.39.2026.04.25.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:58:44 -0700 (PDT)
Message-Id: <5d719b3729e39d63ec0a1a474b0c1ff57570133e.1777114720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
	<pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 10:58:37 +0000
Subject: [PATCH v2 2/5] ci: bump actions/{upload,download}-artifact to v7 and
 v8
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
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

