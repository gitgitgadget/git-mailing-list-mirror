Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1015AADE
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686658; cv=none; b=NtVtpIx1gudUmIxEQB2DXNVY2/lc54LD2es7TFC3+FKHorekYC0dK1pcmBjMJMhvHoKYkbidd/i7rndeYO+5Wbj6T4Hqot58sc+oHZvsmqqfBXdVwq1qbOI64M8booJTQRnVIvifAs7avV1Qux48+frkySXEbivnK4Ov/PUaFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686658; c=relaxed/simple;
	bh=FY7iq+o9Jdlvx6uO13rMRxAKbPkrnBgYppJ6U9yNyfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh5veXd/i4jfAUUNjl4icvzzT3TDxOgKHUizzVLJzmXrBDkAsqVy4AWjSUKrhr6TF2lGS2+fuxGrIah/nmaz3nuydNTe1bsO755bHNJEhAVuivfXwEymbHu+EgUVs3ksh7nEglE0uAmgvLUukaybeczhS1sHZy2AVW6+pojbI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMa+KVRC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMa+KVRC"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eebc76119aso6835781fa.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686654; x=1721291454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5SUSF9m7+RPYWOPd0jRlpGmlM9LjgaKphpw+G8CHMY=;
        b=mMa+KVRCoGcL13Sw0FlctGSNVdXyGXBH0T674jIQaUckq5stlBBj4ridUnl5yzZacn
         JUQzs2Ejj3CisSNJaemUopIsKU88Awg5CTTyi7Y/2+Lhdso0rixg3/KkT1db31vmMW0B
         Iv0xpucMKiRUigBXhr/w5tKlZ1XoidFGUMNZfkC+kKLM3oGsMltTQZUH3blA7+eMj26/
         Nt5Fmzs7sKv/tGNL9ViUGY7BScsqH3dlY0u36Atmv/wvm17r+Tp3Y9b72w//+aU4X17s
         piWLB1HxrwYOxHUgXUDH1/ed1h/gb/YZt0AfydZSEAoBjOVMgP70WnmxdKqJuA8cGYCj
         unqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686654; x=1721291454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5SUSF9m7+RPYWOPd0jRlpGmlM9LjgaKphpw+G8CHMY=;
        b=jbTJbntc7xGkDxH60ZHwaixVtHsPtE6GT1QE+5a9RouSUaRLTL9GYmnfOv+ULWnXou
         OlwTqMSOA4VJz8/ewRp+tKT84ewjweeNAcD5Zeah0/BwU8PyXpTzITZkSNs8xQHWw9tS
         jcJBWDDSyDaYvXDNb7hEO2p6/CZGPNaggnZmGDNSmK91naNpRVQDDkjnS1yDnbIEgA0h
         0ElFSh+tF3PXNIqifr+nbXGR9abQodnC4ZVEuK1q3zFjNriNKT/T+ag4w7ogQWa5Hv9/
         r4+kgUeX2CjFE2LACmuHjnUD18fPLAnYWCaBxXShdrjfUFleKi4jwT77DFIxJf8lk4vJ
         NLVA==
X-Forwarded-Encrypted: i=1; AJvYcCWkAWWUMTsM3RewFj7IbDx4Cg0thfbc7pxF56+30NuL19McaN84zp3+Cy2arEmi8tXt9iqFdCxX2yPYOuSTJSxJSD7d
X-Gm-Message-State: AOJu0YxCitojn2krHqnBe26TgcFVZi6J59/4RgYKO4GAEGddAnfZ2N6P
	KG2OA2jhwkvjjoDo3ZTFFEgkRCPhrSoQjIvwo4WdQZ+O2Y3SfV20
X-Google-Smtp-Source: AGHT+IHUafPQiBQzkXT5erPC6+td211BpeZrNG9XGXqIikQVEkY02ZjrnYjj09JcUxZ8QDYpFkvx3Q==
X-Received: by 2002:a05:651c:1a0f:b0:2ec:5ff1:2274 with SMTP id 38308e7fff4ca-2eeb31027acmr72220461fa.25.1720686653454;
        Thu, 11 Jul 2024 01:30:53 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 7/8] ci: run style check on GitHub and GitLab
Date: Thu, 11 Jul 2024 10:30:42 +0200
Message-ID: <20240711083043.1732288-8-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
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

For GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA' variable by
default to obtain the base SHA of the merged pipeline (which is only
available for merged pipelines [1]). Otherwise we use the
'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .github/workflows/check-style.yml | 29 +++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 17 +++++++++++++++++
 ci/install-dependencies.sh        |  2 +-
 ci/run-style-check.sh             |  8 ++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
new file mode 100644
index 0000000000..27276dfe5e
--- /dev/null
+++ b/.github/workflows/check-style.yml
@@ -0,0 +1,29 @@
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
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v4
+      with:
+        fetch-depth: 0
+
+    - name: git clang-format
+      continue-on-error: true
+      id: check_out
+      run: |
+        ./ci/run-style-check.sh \
+          "${{github.event.pull_request.base.sha}}"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 37b991e080..dc43fc8ba8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -123,6 +123,23 @@ check-whitespace:
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
+check-style:
+  image: ubuntu:latest
+  allow_failure: true
+  variables:
+    CC: clang
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - |
+      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+      else
+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+      fi
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
+
 documentation:
   image: ubuntu:latest
   variables:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ec0f85972..46fe12a690 100755
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
2.45.1

