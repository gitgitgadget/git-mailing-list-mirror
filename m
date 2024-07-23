Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424D14C5A3
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722881; cv=none; b=NnQ/ouAOW2nWpbuylFzJKHzcb4WkLucwkU6HeFloOaT1Y63rZAsL68IASngo5YyOYYLGhmyAw/LaIj5EvRQhEAxrug/C2QepgbvCQTXJnxwXqG3RciObtDsBkQqMcibtG18N4YreqyoL6BgpJ7WOH9gQLBIXqviFyxW90lFpkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722881; c=relaxed/simple;
	bh=JV1siI40LndpnIDpcaC07sguvI6SKi+46aqYb3rnADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fq8MuTNPEOR//sFzkhb0G4jtjyn99/5bL4UH+xS7Wsn6oIHb9JGMrHucrrCMsZnrpJxZEG75NIGTUOCqrsqqu7vuT3xXd2OJdrdneef7Rz1HT4vM2Y1r3O5bbjy+Iry0BAzJPW8NX31BG0qIw9WAguH/y9gPhR2grIFYqAyU0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl8Ucr7B; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl8Ucr7B"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso31319366b.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722878; x=1722327678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGxYvQ1YI4q+Ou8UA80fbAMtDN96R/upAdUWOi/3hmk=;
        b=Jl8Ucr7BGLqNBmJK97N1Lo1IzYJvy37sCOWhayh7Cn1mAoMTA9RypQ7yx4BFDcHMI5
         YeEhwvpfGh3qPOf/rhodsNwwNbVoSSGE1OzgKw7o0LQhmgLJ1IFrXR8p6WlbU8mgTdW7
         utGSprifYVoUhW7eJts87CDBWFVyOfIMAPeW2cYsDG9wAlRBsnXU8Ewu3zIgF9tIcL07
         amu9iCJDpNo7eSbMYda0Dya6xOqIHqtVPadYUONHqid8C6kMee1HyvJUcHtE6/pn2p9G
         DUIGKI8fJD2tXJAbbf/W2FXdyXwOGfebPxZA7W+UoPKyQ0FUI0FINKP2v10z2CnCspFo
         frtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722878; x=1722327678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGxYvQ1YI4q+Ou8UA80fbAMtDN96R/upAdUWOi/3hmk=;
        b=QxSoQbRdpZmtuf71C1KehAM4uSXGp566raTw9k6mxKPDHiCaXSJSxrfnVeXPfBOIxX
         +uGW+xhIRSPxSCeOPqQ5GtcZTUllKESJU9bkRzjHzVcd//adlApUD5iOuc/J3MZtBejR
         w4ilLOojUatm/yQimmprmn2LkvCRFzzK6HiduuY+MBtHl1u/riCqOiRgEahHYOQES5Xc
         hSEk+y5fbAwNmn0MflLXLgBuMY2zbeMXjx79g2n5ZcwdH1XLM2jfMkcPOB9890Bha5Xy
         1G0XvpqWj6L6HVCxYDDpphXx55UsszX7skAFYZivYi3fcPRG7ahHSJQWuzPxSHh9whW6
         NBIw==
X-Forwarded-Encrypted: i=1; AJvYcCUnkjCi85E8IQ3gzQjDPIyzRCU2UmZ3kZEZDbb4fd/p8LyoCpCdcgAM/t7XTnOp9GPa825IomPc0BoOG5UTEp4dWgH0
X-Gm-Message-State: AOJu0YysiJvTbn57zbFW/YSFW32ykVj0d6jfCfVH7f2X50Petvdy6wae
	ZkN9nFfBWezuLl/mo5Glfcnw7qWfB9Ut6Zm+ZcrWFpwXpNgabK3Y
X-Google-Smtp-Source: AGHT+IEBj7QL76flD3I0rwcPZtRSCWU6lrUnD5Y5fq5DXO93Pa5AXMv9SVdbXnsINj57kGNBmL7OlQ==
X-Received: by 2002:a17:906:c142:b0:a77:dd5c:d7f4 with SMTP id a640c23a62f3a-a7a4bf39ab2mr573074566b.15.1721722877926;
        Tue, 23 Jul 2024 01:21:17 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 4/6] ci: run style check on GitHub and GitLab
Date: Tue, 23 Jul 2024 10:21:09 +0200
Message-ID: <20240723082111.874382-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082111.874382-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
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
 .gitlab-ci.yml                    | 18 ++++++++++++++++
 ci/install-dependencies.sh        |  4 ++++
 ci/run-style-check.sh             |  8 ++++++++
 4 files changed, 64 insertions(+)
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
index 37b991e080..2886f6e182 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -123,6 +123,24 @@ check-whitespace:
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
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
+      ./ci/run-style-check.sh "$R"
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
+
 documentation:
   image: ubuntu:latest
   variables:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ec0f85972..fb34ced8f0 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
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

