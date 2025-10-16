Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6334F482
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629699; cv=none; b=c8mixZlFj/Iqj463llJ3urtMiXr/p0qdBoqrm87WJv7RFZtVdvVmGHlj121LvPHWUC5kS+g54kLIiEcdnwjLEJrYwdV0ibCVVhTHo6ivB5kjamn8CVn7TfWjKD5ZU3+Lv+x4NAf1nOPHPJUfzCjh80gMCILYPoQ9UIy7OGOhTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629699; c=relaxed/simple;
	bh=MCxCueKyXEFFncQpTiG6LfD0WSgMxZylzLwWGL8PxWM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e2LO8uuQ9dUVb9LiQDELyzseHwyTp2AKvnGKxH93UFld35LA0W7TaCl7k7FWmOyft6h6RFtH18ohQS4nd2LrhyJuv/8uTyxa+4LhICQeS7z8MMD+edH7mO7FIh7Do7yQANKpx271Ll22D/l3ihDXWBRUM+SYBq6kkuqpzbBssPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0kfvQZn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0kfvQZn"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f79ae58d9so128953485a.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629696; x=1761234496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F96p40Fm8j1cf2btwtwB/xeKump+fR0l1yAHOyga/I4=;
        b=k0kfvQZnzEx/RBFufEj9vpMH5ekNQsdasRLEq8oM/n6lfwCVACrgUYg59fBrtX2t0U
         MfUfMLz2tasz21nfav33DsZpFeBYXXB+nLdSRjMRNRTlejA1NCVihusIpPAbkI1FOT4G
         itnqX/Gqt1ZU7Xj5n346JVBC+RK2QqTlCN88hvek8eNA+juImVLn7hl3Og7f+cYV2vo7
         O1PoientXROkRo/k8MhGDkIIxSDAAzVH+y+rW8fXktZVLXNx8opM1eZ/ZxBhxGiplomj
         5ssQ2MvuifVs2unmfIogzr92W4JDqtaDUCcfWg9WsH073+BCEApE+4Hc4pgnZ9IcWV95
         sK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629696; x=1761234496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F96p40Fm8j1cf2btwtwB/xeKump+fR0l1yAHOyga/I4=;
        b=GNdAxZvsysI9Ug5WGeYSJzJNubox0zRWfKOOG/sU2F9mTisuz2iqLMgmb9D/0B8LXj
         2uB1pEt4BBitt7Hbp4zT2pOB4RUEm3sWJ4LGkAKZ81Ygmg81WzC17//LnmCm5c+OzBCE
         a/JH39N5V5QdxRnxlzjLd09CC+m7Ayqqvcbbozv2XfRJ4to7J2C7CvhhhbsowE+zrrdI
         LXTYZ9HM51eXciprvchsPMnNeBD5hh7oX3zRNpHKJ4PzV1K2JJH4UTHPIJSg3Wxh2SYc
         0Pa8nth6Ipq/BxHd/xE6rGXvdbMMbN8iNvrwbA0iR0XaacjoTWdfHNrxuL1QX28Xz0vo
         92sg==
X-Gm-Message-State: AOJu0YzWgbLEIyUilQ8sRS4BYnect7q9eoI2ARlWbkpuyRc6HZK8fUCy
	TkIfV6YQfgXLphg/2bWQ8zpo2Q8nRrAukOzOBGKe4HXQ2teBy6ofbWIvC6bwGg==
X-Gm-Gg: ASbGncvsKJ/x0NYpZVNac9l4GRIyWlsgtQk26Dkj3s1PqjqqFDvxgaMdsv+k8NmcTE7
	ehyGSKrhyc/wBNzK7ZXiKQfSoClMGib1q2EcISpT6BV7vQlZkxx5hFA90ANPmg6EjvZTQyINyHq
	DpWFy16mx9ikov1gtbrjC627PGSrWOG4hxl8SHH84Qw6+AHgJ7XZaRcPP7RNRv8fRLkIRJZ8Dy/
	ta9F5yFPHcUiMNUsTeU2B1ihshfTY0qH/YFLGNHrAaGJg4Gb4dkid9LEEKtLQF97+24ixyc2A9A
	7PajZxqgwQysD8aL+UPRiPnQ82wnNbfuQaImG0m4XXpsJBXSegsYR6fel0d+7RQkSpwgnvLOHOI
	i3lPIC+oZEBJFNwLOroyak9F4GfpvFTygWoGSRc+mhncVB69tzzvZXUYKu+W9rMno78AW9xqxis
	ACFw==
X-Google-Smtp-Source: AGHT+IGRs+Pt1Zn60sNx97QU5+dpq44WK8VDnqRa3FN+tDFb2Hmj63jbo+OnUdOILicP8N64K7afAA==
X-Received: by 2002:a05:620a:4052:b0:85e:3ab2:9627 with SMTP id af79cd13be357-89070fc8b32mr49396085a.60.1760629695811;
        Thu, 16 Oct 2025 08:48:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f38bf42dasm215344985a.63.2025.10.16.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:48:15 -0700 (PDT)
Message-Id: <2443e519f0ff6160e058d391495dd51256595a48.1760629692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
References: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 15:48:10 +0000
Subject: [PATCH 2/4] build(deps): bump actions/checkout from 4 to 5
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

Bumps [actions/checkout](https://github.com/actions/checkout) from 4 to 5.
- [Release notes](https://github.com/actions/checkout/releases)
- [Changelog](https://github.com/actions/checkout/blob/main/CHANGELOG.md)
- [Commits](https://github.com/actions/checkout/compare/v4...v5)

---
updated-dependencies:
- dependency-name: actions/checkout
  dependency-version: '5'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/check-style.yml      |  2 +-
 .github/workflows/check-whitespace.yml |  2 +-
 .github/workflows/coverity.yml         |  2 +-
 .github/workflows/main.yml             | 22 +++++++++++-----------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
index c052a5df23..19a145d4ad 100644
--- a/.github/workflows/check-style.yml
+++ b/.github/workflows/check-style.yml
@@ -20,7 +20,7 @@ jobs:
       jobname: ClangFormat
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
       with:
         fetch-depth: 0
 
diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index d0a78fc426..928fd4cfe2 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -19,7 +19,7 @@ jobs:
   check-whitespace:
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
       with:
         fetch-depth: 0
 
diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 01a0437b2f..cfa17d394a 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -38,7 +38,7 @@ jobs:
       COVERITY_LANGUAGE: cxx
       COVERITY_PLATFORM: overridden-below
     steps:
-      - uses: actions/checkout@v4
+      - uses: actions/checkout@v5
       - name: install minimal Git for Windows SDK
         if: contains(matrix.os, 'windows')
         uses: git-for-windows/setup-git-for-windows-sdk@v1
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index a1c76c4641..6bcd129b85 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -112,7 +112,7 @@ jobs:
       group: windows-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
       shell: bash
@@ -173,10 +173,10 @@ jobs:
       group: vs-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
-      uses: actions/checkout@v4
+      uses: actions/checkout@v5
       with:
         repository: 'microsoft/vcpkg'
         path: 'compat/vcbuild/vcpkg'
@@ -258,7 +258,7 @@ jobs:
       group: windows-meson-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - uses: actions/setup-python@v5
     - name: Set up dependencies
       shell: pwsh
@@ -286,7 +286,7 @@ jobs:
       group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - uses: actions/setup-python@v5
     - name: Set up dependencies
       shell: pwsh
@@ -331,7 +331,7 @@ jobs:
       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -352,7 +352,7 @@ jobs:
       CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-minimal-fuzzers.sh
   dockerized:
@@ -429,7 +429,7 @@ jobs:
         else
           apt-get -q update && apt-get -q -y install git
         fi
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home
     - run: chown -R builder .
@@ -454,7 +454,7 @@ jobs:
       group: static-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
@@ -469,7 +469,7 @@ jobs:
       group: sparse-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - name: Install other dependencies
       run: ci/install-dependencies.sh
     - run: make sparse
@@ -485,6 +485,6 @@ jobs:
       CI_JOB_IMAGE: ubuntu-latest
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
-- 
gitgitgadget

