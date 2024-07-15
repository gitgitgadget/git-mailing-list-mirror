Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90102187355
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035859; cv=none; b=EohVXanFdbgXSzQjchJMMYg1gjnaooiRvwVGYRTLzv1HbIms7u4kAPjwH8Prd4gKGdMxjaMHHakmzU6bQvo99VWEvdTwMEgQCxtEQIfq1LsXCaHwU5YTQDxcIQ4OjbxrxdVDIn4hotoyYUgEsqRAA1uIHHrPSmfHhDrhw7GRrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035859; c=relaxed/simple;
	bh=2lgQB6I70/+c5TtA+dqO+HAj/PI7Et/DPBkRgtFdj7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dax1D8/dMGi0FBSNcTxxs4T+Z3sObiNXLfLIuEOoYQr+aAl4K59dyWUbkqBgd0p/5emRAAdWIBP2HDjs8CfFnXyS6izyd/q2DCEhVe0egoEDjPlBZUu3St2GRZ62Lq7BkMYn5u3H/JrckCCmWPod4ZXtutZGkc2EkmyvBAG8Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMguqf6I; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMguqf6I"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36796aee597so2428356f8f.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035856; x=1721640656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDraPsAtIa+FpZu72CXLg32Cinrj7CrujYCEokX5RMM=;
        b=hMguqf6INY42LsInRKGAg5qhw6Wic/l0crh+/K26zvZ33+MO0Nwm+BIUIgWhu9KNA1
         cinVjDJ3rPr8oJbHgbIZrgaIPNZO5rxFXN8ml+jA9LMI7qQ74AnfW+NYJdBPe6CbKWj5
         Hsi29yx7A8irjnFuhZCg+uFe3cgqqTJTNU4sOOX6Qc5dSRIeskKHCQrkrhGyaD0qEdIm
         VNsMmpoh8J/mwgH/fIappSB7UhyO/bwxGCyBr6qkwSFQ+X53DKXHxq6uDhM35Y03AM3z
         JXEMhDna/ePJKBThvalYW9ngRUuU4+/JXAuFJ8yoYUg0VYeHQQLN2uHrypWWh6C7tqBl
         OCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035856; x=1721640656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDraPsAtIa+FpZu72CXLg32Cinrj7CrujYCEokX5RMM=;
        b=AAR+KXmm5rzqr9fOzGsziHpzoaEa4XS+OmGV2s1xez7WrHeTGgpGPvf7xipTNluKrA
         pusSJ34mhJvnJYe9RDSpv/k9TYcGxYDscoEgsD1OW0MGrKgs2sxgyq+X7R68+ZOWzKHf
         GDy6CfAcp9azzRbTlMMaO55KsGZgQddLkaZ6J1j8jtapYraMdgpQNbGBOXLODzOfSEPg
         P26VPPnazKlLzOaQJoRFrOAwvWFQlOTyo/OuzvkvzB4MDKNCSb0kq9U8k0bRTLsEjHGF
         zaUIOWuuKZ5zs5eaaCP10WVXn7nJH8oclZQkLwIkqwiZptvSZhzU07x3hpDv+mpr+uL/
         lzhA==
X-Forwarded-Encrypted: i=1; AJvYcCXV3fhr7YGJoUyc3oQFvXktOVIyV90rf4qkZXcyuoZY7yTfPuSlb4YOjL99FxG17iTMFSvqKcNqALMJVmIVe9ODrFER
X-Gm-Message-State: AOJu0Yyr6qajrLsVQFfhnNKmhrycBXAsMIG6CumVhCnjc3fswQ2fEHys
	i8V3SSJ9ECeOjETse5DB3BSdNTo8EJUPKtPB+fSr3KVAfC5Iyh6+
X-Google-Smtp-Source: AGHT+IEvksIP/v5cGyZXvA0QCJIb2k0NhVcNsre7qlhZ/65x2D/un5N2JEEcTCGO5ZxYVpALOqp5WA==
X-Received: by 2002:a5d:64e8:0:b0:367:9828:f42d with SMTP id ffacd0b85a97d-367ceacb446mr17094520f8f.53.1721035855820;
        Mon, 15 Jul 2024 02:30:55 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 6/8] ci: run style check on GitHub and GitLab
Date: Mon, 15 Jul 2024 11:30:45 +0200
Message-ID: <20240715093047.49321-7-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't run style checks on our CI, even though we have a
'.clang-format' setup in the repository. Let's add one, the job will
validate only against the new commits added and will only run on merge
requests. Since we're introducing it for the first time, let's allow
this job to fail, so we can validate if this is useful and eventually
enforce it.

For GitHub, we allow the job to pass by adding 'continue-on-error: true'
to the workflow. This means the job would show as passed, even if the
style check failed. To know the status of the job, users have to
manually check the logs.

For GitLab, we allow the job to pass by adding 'allow_failure: true', to
the job. Unlike GitHub, here the job will show as failed with a yellow
warning symbol, but the pipeline would still show as passed.

Also for GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA'
variable by default to obtain the base SHA of the merged pipeline (which
is only available for merged pipelines [1]). Otherwise we use the
'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .github/workflows/check-style.yml | 34 +++++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 24 ++++++++++++++++++++++
 ci/install-dependencies.sh        |  6 +++++-
 ci/run-style-check.sh             |  8 ++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
new file mode 100644
index 0000000000..c052a5df23
--- /dev/null
+++ b/.github/workflows/check-style.yml
@@ -0,0 +1,34 @@
+name: check-style
+
+# Get the repository with all commits to ensure that we can analyze
+# all of the commits contributed via the Pull Request.
+
+on:
+  pull_request:
+    types: [opened, synchronize]
+
+# Avoid unnecessary builds. Unlike the main CI jobs, these are not
+# ci-configurable (but could be).
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
+jobs:
+  check-style:
+    env:
+      CC: clang
+      jobname: ClangFormat
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v4
+      with:
+        fetch-depth: 0
+
+    - run: ci/install-dependencies.sh
+
+    - name: git clang-format
+      continue-on-error: true
+      id: check_out
+      run: |
+        ./ci/run-style-check.sh \
+          "${{github.event.pull_request.base.sha}}"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 37b991e080..817266226e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -123,6 +123,30 @@ check-whitespace:
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
+check-style:
+  image: ubuntu:latest
+  allow_failure: true
+  variables:
+    CC: clang
+    jobname: ClangFormat
+  before_script:
+    - ./ci/install-dependencies.sh
+  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
+  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
+  # be defined in all pipelines.
+  script:
+    - |
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
+
+      if test -z "$R"
+      then
+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
+        exit 1
+      fi
+      ./ci/run-style-check.sh "$R"
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
+
 documentation:
   image: ubuntu:latest
   variables:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ec0f85972..8b01bfb89f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -43,7 +43,7 @@ ubuntu-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
+		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE clang-format
 
 	mkdir --parents "$CUSTOM_PATH"
 	wget --quiet --directory-prefix="$CUSTOM_PATH" \
@@ -87,6 +87,10 @@ macos-*)
 esac
 
 case "$jobname" in
+ClangFormat)
+	sudo apt-get -q update
+	sudo apt-get -q -y install clang-format
+	;;
 StaticAnalysis)
 	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
new file mode 100755
index 0000000000..76dd37d22b
--- /dev/null
+++ b/ci/run-style-check.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Perform style check
+#
+
+baseCommit=$1
+
+git clang-format --style file --diff --extensions c,h "$baseCommit"
-- 
2.45.2

