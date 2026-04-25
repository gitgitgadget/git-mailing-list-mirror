Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A839656E
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114731; cv=none; b=A0DbrFywbHjGqKvSWNSNPLnbZnkl9h0fOIO0LlNs/C7QDDU1D15a3y4galn0tBK6JBSRTvlW/53hnAlKs9dhN0a71DxHOQG4GHFMVVIOMyJjWS2YR3206ShDCfj66ApErHRJyvnFJazfP0Qrk9SROj7eAlP+AGvhO0qVhl+PUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114731; c=relaxed/simple;
	bh=Rj2HU7lu3BfMdEWgjaubM6mBFe4pIrut/MgRBPc+wX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i3ePPP1jOAqgp7PQPKQ6nmL0pB+xBwrEcloEGh8hdPZFh5G9z8NnL9NLNaGgyCJmCnBNFWsZSMqF3Ih+Yd0SioOfg9ISEbmTH0ykHphPR1xuE61XtAGBIX43q6uKdu5gjfz/EQnZ0qsEXfJbqEkR0Lyj2mlNeyOnl/kLARKpebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtL0ipM8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtL0ipM8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e5b55062fso59061981cf.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114728; x=1777719528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81ftFhFg/hBR4FsBLGYmNvk+0tT6IiAiH7nmS5Nje8o=;
        b=jtL0ipM8f2BR8gsoUa0NbICwu+XyaQSCbuOZMnyNsvH1w2RelJ+RYtEMC7TWLX2iNK
         ke0BDzy/feVbGa3o/0RFL0Y/BotsvuNpm7RG7KZ7sj/7LvCqvSIGgP8HI+8JFYkgiGtY
         /QAqicSOCIt3nUZacrJBocxV5hJ7rUPBrcX1Cq2c53Tr6a6vx/Ol7DKr+sLDjA0GPKw4
         9tHMq2RT/Cujl9upbTwv1+QBL/JQy2S5UnEkMcznVhoO9YcfhnfeJAMbhgGMeuJr866j
         d9Ui7rigqNKCGYrMySYjFwYt0/CtAjbKpkCC9VgrCR5Rr0wyk1Z4HAGHdhjnKg37+YDW
         peRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114728; x=1777719528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81ftFhFg/hBR4FsBLGYmNvk+0tT6IiAiH7nmS5Nje8o=;
        b=bOO+Cu4fYI1wo0z5VUhrHr+zbjCdRqRcd3j6zqW1mQmZNyGaGDlX2SOPW4FGDTaP0t
         vaLuwfJjfGu0kcZMjKrPDzY0QEcWxKXAIijzFakV0rOOYkj+RCFBn5DCN620ZbOOQw6r
         PyrLHgGrtaHxbkFplMpsTKW51uHsLR+7QHvPog/vxYTbdttGSgU9hpn5qtmpQIFCOacx
         a71bxWztMqWKagyeeL/3tmrWmdxXvtCTP5PcBjxAf18wXvGM9Yt5v/338chyMM706MK+
         8SM+n+2eFgeKoSJohof40YK0dkShnjdN2t5PqUEq849D/LR+aTUP+G0Xl5a317OzQ07b
         kEhg==
X-Gm-Message-State: AOJu0Yzd/to3VAV8Fny/leSdbNfSWugIeDxUtT02tYTozKQ0PuHodpCz
	E+1NbXFoKL1KLey5jQLR9sI/Ed1Bls2eKyc3ffezy6tkJKYsPUA6x8U7f1shsA==
X-Gm-Gg: AeBDievTQFEtlnnigGl+jKS1OIDc11qiJneerTh0sQ/dEFCxV1K5xYP55SKGES9aGVV
	cd4URdWPMtkPchfXdeJrvjqEqyNNbJUy++cnvpiacV32H7thEwMluWMmGuJp34v3Dl136u9O9Mr
	I5Oz+4DH9QVrAEq5iQf+tPyEuap7928CcsWL7shqOEyNzfZ37krCpPf0uwV7In7vhtJClzPxbuy
	sjxHLoNMkKCiYFhqj3Wfq3znEOkdH5NlkGHUlDPs2gzQerqLL/DSkAgtF+dW9pi+RaXZXvZ2PPq
	G/FJZjSMitjC3jalPI0ErPGSi/L8/jdFlTg917RK+c5pFdCrLEZ34wzch9Qe7LT3qIgvkZB9WhQ
	5wa4T5it7DG+i/vXn2dahN8/La4NDfBBgGKSBTDGLQm1rhvZIP1/reA5FiU2Uyw8iptjKcXbsBO
	0W882DJxOX3b7xu6s3vv7vzLfNCage7y7WgzlFVYNeNJEtaLVv
X-Received: by 2002:ac8:5845:0:b0:50f:b61c:ec53 with SMTP id d75a77b69052e-50fb61cf1bemr277057441cf.38.1777114728045;
        Sat, 25 Apr 2026 03:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39449e36sm273145871cf.21.2026.04.25.03.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:58:47 -0700 (PDT)
Message-Id: <5694ca10167f683c55151672a1e5bcf6482b2a43.1777114720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
	<pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 10:58:39 +0000
Subject: [PATCH v2 4/5] ci: bump actions/checkout from v5 to v6
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

Every workflow currently pins `actions/checkout` to v5, which was
introduced primarily to move to the Node.js 24 runtime. v6 is the
next release and worth picking up so we stay on a maintained version
of the action.

The one behaviorally interesting change in v6:

  `persist-credentials` now stores the helper credentials under
  `$RUNNER_TEMP` instead of writing them directly into the local
  `.git/config`. Two implications follow:

  1. In the normal case this is an unambiguous improvement -- the
     token no longer lands in `.git/config`, reducing the risk of
     inadvertently leaking it through workspace archiving
     (`upload-artifact` snapshots, cache entries, core dumps, ...).

  2. Docker container actions require an Actions Runner of at least
     v2.329.0 to find the credentials in their new location. The
     github.com-hosted runners our CI uses are already past that
     version, so this does not affect us. Downstream users running
     self-hosted runners may need to update them before adopting
     this version of the action.

Risk analysis: our checkout steps either check out the default
repository (no special credential requirements) or, in the `vs-build`
job, explicitly set `repository: microsoft/vcpkg` and
`path: compat/vcbuild/vcpkg`. Neither case relies on the precise
location of the persisted credentials -- subsequent steps interact
with the API via the runner-provided `GITHUB_TOKEN` directly -- so
the v6 credential-storage change is transparent to our workflows.
The diff is purely the `@vN` identifier; there are no input or
output changes.

See also:

- Release notes: https://github.com/actions/checkout/releases
- Changelog: https://github.com/actions/checkout/blob/main/CHANGELOG.md
- Compare: https://github.com/actions/checkout/compare/v5...v6

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/check-style.yml      |  2 +-
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/main.yml             | 24 ++++++++++++------------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
index 19a145d4ad..108a2de903 100644
--- a/.github/workflows/check-style.yml
+++ b/.github/workflows/check-style.yml
@@ -20,7 +20,7 @@ jobs:
       jobname: ClangFormat
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
       with:
         fetch-depth: 0
 
diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 928fd4cfe2..ea6f49f742 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -19,7 +19,7 @@ jobs:
   check-whitespace:
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
       with:
         fetch-depth: 0
 
diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 3435baeca2..89bef26727 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -38,7 +38,7 @@ jobs:
       COVERITY_LANGUAGE: cxx
       COVERITY_PLATFORM: overridden-below
     steps:
-      - uses: actions/checkout@v5
+      - uses: actions/checkout@v6
       - name: install minimal Git for Windows SDK
         if: contains(matrix.os, 'windows')
         uses: git-for-windows/setup-git-for-windows-sdk@v1
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6d7f26e71e..0ea266f27c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -112,7 +112,7 @@ jobs:
       group: windows-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
       shell: bash
@@ -173,10 +173,10 @@ jobs:
       group: vs-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
-      uses: actions/checkout@v5
+      uses: actions/checkout@v6
       with:
         repository: 'microsoft/vcpkg'
         path: 'compat/vcbuild/vcpkg'
@@ -258,7 +258,7 @@ jobs:
       group: windows-meson-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - uses: actions/setup-python@v6
     - name: Set up dependencies
       shell: pwsh
@@ -286,7 +286,7 @@ jobs:
       group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - uses: actions/setup-python@v6
     - name: Set up dependencies
       shell: pwsh
@@ -341,7 +341,7 @@ jobs:
       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -362,7 +362,7 @@ jobs:
       CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-minimal-fuzzers.sh
   dockerized:
@@ -439,7 +439,7 @@ jobs:
         else
           apt-get -q update && apt-get -q -y install git
         fi
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home
     - run: chown -R builder .
@@ -464,7 +464,7 @@ jobs:
       group: static-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
@@ -480,7 +480,7 @@ jobs:
       group: rust-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - run: ci/install-dependencies.sh
     - run: ci/run-rust-checks.sh
   sparse:
@@ -494,7 +494,7 @@ jobs:
       group: sparse-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - name: Install other dependencies
       run: ci/install-dependencies.sh
     - run: make sparse
@@ -510,6 +510,6 @@ jobs:
       CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v5
+    - uses: actions/checkout@v6
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
-- 
gitgitgadget

