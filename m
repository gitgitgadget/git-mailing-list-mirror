Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDF86353
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437580; cv=none; b=nGqzGDhuOIf1z2rWq7zjbIcTRfvRyClf2OMVytdcb0eE+SDncXLOamw0tTN/iDao7klpIMulchNhG2+Ot8bwR9Ym9/MsMdHiEATmouqk0zp3ybUjry6B1Tka7U9QJKurS0vQSliZRbdD3x5+9OGcjjpiDf8nTtPYEsJpd24S3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437580; c=relaxed/simple;
	bh=MQYIvhriq/AvhNDicgxD2awlPLhYXagYDaE8i7l/vGo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=h6PPyFtVYmKdZ1FE9AAG5KQDhtnsHjhK7XurD/9uFLNxOrGKnyAd3Q8W+dv8AJZY3KvwVjNe/WCPWT4M69WuysHrgTlTgBkR+hUj9ahjKVVI3Mk3QMCRUnfPCS6GNqRzzCmg2sO9GHs5is28OnenxA+yp2V82PjetbBcC8r87CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0eCq+YW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0eCq+YW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so832891a91.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437578; x=1763042378; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2KciljZ4YkvjJ286A8TrqEmy2E5OZJvgXBwd8tVxiQE=;
        b=O0eCq+YWr/cHvPFblxKfd5fDvKVeDT5fGOourCi81jiHvzyVQ6Pz/kA7Q30BWHHTD2
         A37s8w8C3WVlFMvUzHQCy+h47E+CoeJwpc9QxVs65HxYh4wOFszRnzLxtZklJCCPNi+e
         cS8X5J4jkIQPYZY+Ct5geOlxIPSjVVm/FOjc8A0no4cn4qX3W14/0rYLCaUSqpz7CGx8
         zZa1cG904odmoX3lheR/1+imJr8yuL/H3/XrnM66PkQQje7v4y8giSpSx+mnZ3gD6dGt
         1lhqpIuQqm2vFbbPP4HTCYW23s59WqueuWnP+zWA1QjDBW568qd09mbRVyBZQx8Vbl2f
         YwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437578; x=1763042378;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KciljZ4YkvjJ286A8TrqEmy2E5OZJvgXBwd8tVxiQE=;
        b=ZADevkVXKWGCcluhcGIt32sG5EINSnLlRyS2zEFfIBWY/C3PkJrI0go6Rw210FBKM7
         gbMwKVqNjC12rp0CQ67wrhoH4sOk3Nu6xyRWMijcxW/4yukvOjL6/UXlO/BhFG3DmsDG
         cGehQGl96VxA7R4fmO00hgcb/l9jc5NEs3/Oct1bML1sSK5tu+sbf+dvkeFdmPhvaPS+
         utHRVm2MvmHDbNoUwY/H30v6d8t33+o/rIPN92CbX4GoCAEvXUV+anaWKcVu2nYywIUO
         cNPwxUsnOxHuZHWHzRKm8QdW+8wig486faFbqvKpoPW7QOFBNfK+Ch/4vlnFfQj3Vlo0
         h+iA==
X-Gm-Message-State: AOJu0YzGpTuYaU9yDZ0A8fnkMWiHPuhUr890K5j285tlVzAU4iCDo3p6
	z0UwmDxdatyupIwgOa7sth7vLCGlKGyElmvn4eO8N+WfIdUAszdPF6Nw40geLw==
X-Gm-Gg: ASbGncvedIyileOUQPbj/CL4XRtG7KnV0Yye5FkQbhGfInlOwA3rt8W3SvUsYlDcOF2
	+H22H51k1ISX4aqppXBCDVIu7q3iJo+qcn7SRvtggceCjIRHaLrmXKeLyLcB61ZY6XDhu+K2rPD
	3Zib1J/OJ32BSXjVmhQq0GsmbfT+sV/2XE85Uy0nSmoKDwa1ixjjpjfQEVRBBLn8bCtCLUnRH70
	k+yjd1rANfbi9dxqZVhWyV5L6R7mzlW8g+AJ3qJaSSiOWVgRq4lm8SwVKwoK67yGvWqgbOIEIcI
	xoiJWZBJZSKym+LH82yxUhAoKLxB7PaAG/ifbikAJQruyoU9z1/Y+zwm5K/ovpzUsf9dyFuO4Au
	ffbhNrC2a96RJRgh/cFoL3Fj+1xYvNlZtl59csZncg7rd7NJKaFhBYU25SGdJ8+o3keEFDkW4Sv
	WGfJg=
X-Google-Smtp-Source: AGHT+IEZbumwfKfCOBCvHX+/DiIIBGjYhGWmD4giFQ/CSKIIecYwP+xvyrjG3DBpQkBGaBTJ3g3/lw==
X-Received: by 2002:a17:90b:3bcc:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-341a6c4ce13mr8084489a91.9.1762437577971;
        Thu, 06 Nov 2025 05:59:37 -0800 (PST)
Received: from [127.0.0.1] ([172.182.203.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a6993b43sm6415252a91.15.2025.11.06.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:59:37 -0800 (PST)
Message-Id: <pull.1996.git.1762437576488.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Nov 2025 13:59:36 +0000
Subject: [PATCH] ci: update {download,upload}-artifact Action versions
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

Bumps `actions/upload-artifact` from 4 to 5.
- [Release notes](https://github.com/actions/upload-artifact/releases)
- [Commits](https://github.com/actions/upload-artifact/compare/v4...v5)

---
    ci: update {download,upload}-artifact Action versions
    
    These changes correspond to
    https://github.com/git-for-windows/git/pull/5914 and
    https://github.com/git-for-windows/git/pull/5916.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1996%2Fdscho%2Factions-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1996/dscho/actions-updates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1996

updated-dependencies:
- dependency-name: actions/upload-artifact
  dependency-version: '5'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Bumps `actions/download-artifact` from 5 to 6.
- [Release notes](https://github.com/actions/download-artifact/releases)
- [Commits](https://github.com/actions/download-artifact/compare/v5...v6)

---
updated-dependencies:
- dependency-name: actions/download-artifact
  dependency-version: '6'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cc54824c38..6334ae6a77 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,7 +123,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: windows-artifacts
         path: artifacts
@@ -140,7 +140,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v5
+      uses: actions/download-artifact@v6
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -157,7 +157,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: failed-tests-windows-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -208,7 +208,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: vs-artifacts
         path: artifacts
@@ -226,7 +226,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v5
+      uses: actions/download-artifact@v6
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -244,7 +244,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: failed-tests-windows-vs-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -270,7 +270,7 @@ jobs:
       shell: pwsh
       run: meson compile -C build
     - name: Upload build artifacts
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: windows-meson-artifacts
         path: build
@@ -292,7 +292,7 @@ jobs:
       shell: pwsh
       run: pip install meson ninja
     - name: Download build artifacts
-      uses: actions/download-artifact@v5
+      uses: actions/download-artifact@v6
       with:
         name: windows-meson-artifacts
         path: build
@@ -339,7 +339,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -439,7 +439,7 @@ jobs:
       run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v4
+      uses: actions/upload-artifact@v5
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}

base-commit: 4cf919bd7b946477798af5414a371b23fd68bf93
-- 
gitgitgadget
