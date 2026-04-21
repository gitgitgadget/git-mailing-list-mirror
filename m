Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E0382F19
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775336; cv=none; b=WpTHdsyQytXOC+UdOkZxu3k8Y08b1LC3tBHKUKa7vPA7jNhiPGLN7/ILz5sVYbSsIkmkDUcx2TgfeOphfqbJupxwGE+HU+PpmvBb9TY6uhra3atONXmxQMcX/noasMn9bQQ8JUNj7FYEfxMov16Zp6Z3PD+oG+71cxXds/MOJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775336; c=relaxed/simple;
	bh=Rj2HU7lu3BfMdEWgjaubM6mBFe4pIrut/MgRBPc+wX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CNMziEwMEe73An2a1jvNiP3eVMTYaQtJX2dLLD7QIRy580HZy7DtHM1/jKnnsy29pkiQYEnx/4tcBFhhk3uLR5uVGzj3zTgWOMO7IV+tADyxP1gBXE45ff5AmUDZLTRFX8lfxI1cbgqiCYxlc6u6ffdDRWcOk0/2IyfBxw5xPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2xQ8s35; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2xQ8s35"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2e221a71e19so3906777eec.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775333; x=1777380133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81ftFhFg/hBR4FsBLGYmNvk+0tT6IiAiH7nmS5Nje8o=;
        b=i2xQ8s35P+Pybu/V+YlkgVsLYCxEnEm79R8jvrrZCBU62O699naA2BcEivA3dZeHW0
         nVB8Zr5JhuJs+E7HP1e5ZGJ4xeiHHQZ3wZsu/kEE0YZIBYGl4KpI4iwfECN9aOPk59QL
         SCjYJ7MYcNqaGyUuKfuDKbYPuoeEp8ls7CHGJVv7SaBlkWV4aycqHxlU7aGSYYTouORV
         hs+lTaEzxyiCZeqPGiD8IkxCOrapQDzsl4iM8DXGZikRdUO4Qi4sNk7frETDQWE8sCyf
         b7nZZ77swcXMNlY2Ukqn358tUzg6LKbdAGuxYJBbgiijejPaIOwZRFUjJcPcKn8n8HBk
         H4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775333; x=1777380133;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81ftFhFg/hBR4FsBLGYmNvk+0tT6IiAiH7nmS5Nje8o=;
        b=lfVCW0ErcS/9qkJ6Di19cpIzG7o6FT/sAdfacd58jE+Yg2LB9H7I5VHaL+4O2aUGZ0
         AOQD9/lzY+f3Ypa4KrV1mP/pdOl3heZPeZ6Bnqbu+IoYGZcywPTRtANbM1SUjOWTlg0r
         ObKYSkf0fzFB5HTlSnEn4HfDYQMq7/Yp8hM4mRASd1hVms0z/LoG5zMM/xgGkudoCzEk
         UCcxF9xivla3JZrbIN6cLGFy1ujhapK6R09L+OhI2WtHgAbULmqpt4tN36WEBpBGJCTx
         q/+Ci/iG0dhEbnbrbMFpwQYJXBvdpz+T0ioByy+vSM6GwaqaISsWKAqs8iPwqC/eZG0a
         tRUw==
X-Gm-Message-State: AOJu0YyCS69AqyXtNb1VY6XmJXUsVw+PMC4voxinWpT7sEEdPxLUGgLi
	HiJCPU4dFSNwMOci4qUE5z/Kcg+6KzGSQplmpmFtMw1AhgjgUWHfjaFWhjVCVg==
X-Gm-Gg: AeBDieuTiWIXO6MFn5OJBZeZuZEZnvuS094iwWMKfLv9CpuiAQD04qHG6+0SbNlWuQy
	QiStlb1h+mfni4To5dHxX50UR3AsGto+Kw3xl6UU4zTR2QL99stufvXOjLO/DxULmZjgV1a98xG
	iH6bafRv25benDzAhr24pBKKYfw1sf0SfFiL5cCkkYYB/TZD8CeimFpU11BbSkMP7BPrchGVbln
	hWf0fWO4ip0t9eFLSQ04HHFiJVIHQ3bKLVV6jKhDiZbR24bCEtUs+UAAkI7SjDF6a9FDIxTCnp1
	6ux68im/62ZD4QmyDNtYp3gCPHjHmQ4q8mNE/18FkHbFyS1mG/dU7s5fNUsQElQNP7izI1f+pNN
	NsoshNZx5pIWm5Qsb1pYJIDLGpxM3eqEVzsMcr/VFg6AM3QhMJgnfgFlgTnokWHGEdYVQegjElf
	YWsyFaunuMZfotU3cJzyKpolIERmZysonIzN4=
X-Received: by 2002:a05:7300:dc05:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2e466044086mr8729871eec.4.1776775332858;
        Tue, 21 Apr 2026 05:42:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.55.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2ce98csm18164658eec.20.2026.04.21.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:42:10 -0700 (PDT)
Message-Id: <5694ca10167f683c55151672a1e5bcf6482b2a43.1776775319.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 12:41:59 +0000
Subject: [PATCH 4/4] ci: bump actions/checkout from v5 to v6
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
