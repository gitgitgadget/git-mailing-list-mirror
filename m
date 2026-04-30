Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D53D9043
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534518; cv=none; b=tMl4ydgGLso20VGw0PxBS2TTepKMA6SDI2nq+4N+RXSsVyXlbx3TqtbOXJ+OqZlBpvJJhMKUHptcpwWoMBjTiWnxScvUFPClo+nFpB4DdNKiXuxcivuIfmzRRjQBMxlcU7HBOQV/vDlNeM9usA0ZojJyjeydyUztKHLF+1LiIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534518; c=relaxed/simple;
	bh=Rj2HU7lu3BfMdEWgjaubM6mBFe4pIrut/MgRBPc+wX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TKFrDQV5YufS8dK5pgA9PWHfnR7hA48gAcC0OVm7FTof/XM/K2iq22uR94yXDbgIvzHENQYoeoe1KoegPxrKQy61Oih0rwdWNcpuoIDAQKjuQVwdArxEwILQkv8BWl76mMWFSIR7VJC9fDQRh7SBBX2JnlIFO4viKkB6rHlHcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXI/wrL/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXI/wrL/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8f83efb5729so71043885a.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534508; x=1778139308; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81ftFhFg/hBR4FsBLGYmNvk+0tT6IiAiH7nmS5Nje8o=;
        b=gXI/wrL/yGpyvLg6n9L0qplVIEoDZXihcB/zUwB3gPp7iC4HA412cyB1ELT26gmWAX
         cefH7tc5pjd459GfvpkQDuqqx3pk+Rh8srgkrTwiz27DZOenMXHPv9swjApU1BxBxL5J
         99XC//acusx1dMauzgI4Lrz9KRn45/Sdnnd8LRsi7sU6CskUK+5jPDpl3bG2C/dmDMX3
         1809SOCpI1veEqiC/+ZdJ2Lt3/ROzhEtcr50bdJIBfzcorFl0wQ8jbrlHvCnr9xSNJkd
         vPaZNMGbucpO3np49lwGu4kceoz1geaAYx3N9Uv+r2GsKls7t3Wd6tihcssi32kIOvDF
         xdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534508; x=1778139308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81ftFhFg/hBR4FsBLGYmNvk+0tT6IiAiH7nmS5Nje8o=;
        b=cfuSRybDa2XIGvvT6zGKtQ2aJCsgpiqHBpWqqoCF41EAJiHemUGKF3sv5vKY2Jngkb
         o9mfvmrpxtwypjKyzSE7A+HR8u4NKb5EY5d0XKQs7r7Kceb+9xtD+ePXnLcGRxs5p3bB
         gJyL/fU5u6no0XlKM8oD53w/nTvX0blXo3eKUIKwO6FkCOFWxrpt7D5i1K5eMlYqI8DD
         iklzezV7h3lN8MtvBkJvzQwMIDfp+wae3Y67TCuxk/TUKb/wWMQJzhdZP7+yHI8dYXu7
         awH8fuYAQFMgZXqd2N3B7FBpFnYCKUvdwgRmXrO8m9JicCR9OFsmM5g8RIXMLo7ArS+c
         L2iQ==
X-Gm-Message-State: AOJu0YxyAfyoX9T8F4kEbWgGp1z1inLFoAtb4dimKkj351zx7Y6BjwX8
	cuqvJvA2dfsFbUriGKbCYlb1KGn+Nj6MU2+LKcu4T82zciQkpt4znxlIwyBHtQ==
X-Gm-Gg: AeBDietfcxBCX7sH1bH66JqfwSZfrHH8WVMoen9kbcrjjNlQaV2nJmt/HquKQuCjS3L
	FWCt4AbiWX8r/DbN4V26iM0Husr0A40IWTkVuX7NJ8HdWkWlpERU0YxP5seWDL8CswxJytKxVhV
	n3QEOQrKC79hVsftCfC40qPgHx8vgVAQ6Omaa8K3UEsM4NypFGHtPNanxAJS5ZMju6f96Mfn7mZ
	yLjRAreplU5Z00w5HBnLV8xA5dE0M2EJoPPxXSmnBCLrnjZJREhJ3UbE11rSVfVdLSTjVhTp618
	9bkgFpAW7jekHBZqq5UoEehkBNgDZ8UhxZuo1/Ktzyh8YstS+ww65DQH/QeS4hCFKwDJA6TgNdW
	FcrQ6onoEWiwktLSXOZ2qS164nhHn1cGPqy8/pkQAVmVaTBQ+a2gs7Xrlug/z6IgjwoJIWapHcI
	eRQBOYtP42b/3sCzf707ZIRmOU/GsZOWsTY4Zp
X-Received: by 2002:a05:620a:d4d:b0:8fb:1d9e:6607 with SMTP id af79cd13be357-8fb1d9e6a71mr31505385a.36.1777534508047;
        Thu, 30 Apr 2026 00:35:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93c80aae6sm364905785a.2.2026.04.30.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:07 -0700 (PDT)
Message-Id: <5694ca10167f683c55151672a1e5bcf6482b2a43.1777534500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
	<pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:34:58 +0000
Subject: [PATCH v3 4/6] ci: bump actions/checkout from v5 to v6
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

