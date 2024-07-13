Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81613A411
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878332; cv=none; b=tpMwApAsb//W7FCq9GS/MlJrqSf4YukY8qxTAgQ+uiab1SYUAlj09GaMOC/eiVR8wCX2Tc07a06kwFx1lUm2fbGWX7yOy+L69g9q9JaUVWXNPKlGCV+lUj+TfyFEleP5Yhapf43NKRG3NdfqWawsd5jW3rc4sk3zRP5jVLSEHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878332; c=relaxed/simple;
	bh=krxAM8P0Xd8jzQgWMTv4y8IruzbtSA7t9AhLurZyFk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCS5qwDqy58Dg+mHF0CPGb3mTlc9R6+Zx20KTcM2B77LF3tnN3qUCH/93pCUNUtNr+IbJ/sxLHznQWhcHzlfQYFhbz6H3HAEm5rHa92XjUkOqzeoMGDdE1x+kiEh5tYQ8JcDSHFswxsFdkztuxs/twSD1m77J1b9MtMJbzm3oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiUG0uY6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiUG0uY6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-426526d30aaso19816885e9.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878329; x=1721483129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZJir4sNNdcJ/TphbPyVDtPS9PromycX/J6csVA69UE=;
        b=YiUG0uY6iYJ+umtqrGlr6vRWS4TEvwNxRf2MGfJoncBOE0eNAClSjymwSGX9ldpiXt
         gjOopxAGYzxJBVVou0ulxxhvXKUVbMvDgq3hn2x841mwlx6n5Cwf3MVj7hgKLTOwwxD/
         VpEqDBE65klBR64/CZ0259Ba/nwjQllJ/fRHnfFdJzd4CKcDkq6SE7elxDtJhK41v1L3
         nkeEz9+3x717KtN+Qp7lJ7FqPIdMnhbqZmOpX+ixzeVazflDchadM7VLIou6IwO9EbWP
         SuS1EkImW697o+29zJ04VKMlro+xcThpGklCrtF9KnTlxxPNCIyhLhytDGip038snJOt
         zEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878329; x=1721483129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZJir4sNNdcJ/TphbPyVDtPS9PromycX/J6csVA69UE=;
        b=N+RTuG8dss7OREIzKceoT+Fr6JNPu567EiuUfeZEwIhkM8+oYNyJniFh0LWQ0UusEF
         B0iNZcmkBRsmF3IJ2i7CE5WuM5KoPwnjABy/IjT/iPPX0fF8g0KPRVZgl8bdLTzJuATa
         GCBA3WOgPAOV7qsgd6+gEHw5i4QMjWacxFNmEqOVJmD1qKM3QR8AvYN+RbUtZFhZd1MV
         ZiEustSHA8S0elfOFv2ImsuDRS2l/cgdsl4f4XI3ZlJEf69iPZgUyYshFK848yVX6RJP
         DI5q3sb3kGtgZjDG04xi5ceSbzpY13LQS9m8PipynRWwyuoS+6KBXp6S5vGBIhG24kJm
         HuNA==
X-Forwarded-Encrypted: i=1; AJvYcCVuJv99gKuchcokr0R/t2GGZa4YDMLOqPWGJIpF1hZrpjD+uCdKpGtPvxIZeyY85luPz21bxBOQaKyho3DgNbYx4IcI
X-Gm-Message-State: AOJu0YzmDbS0Yl2GgbazOQCT8BpP9smUfJFt1RT7n11PBB9RxTtXrioR
	3l+Xojw5OvIY07pzfl9YZsDCLBMhRg0LmHKkIxMfbhI5drICWhdb
X-Google-Smtp-Source: AGHT+IFlQlX4+n4Y7qvsZExBR3dyALzUmgtGzw117KXh1UaLa5G0l/NOuJCHBfpggZSMwvhy+Q62wA==
X-Received: by 2002:adf:ae59:0:b0:366:f994:33c with SMTP id ffacd0b85a97d-367ceacb515mr10678497f8f.56.1720878328919;
        Sat, 13 Jul 2024 06:45:28 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 7/8] check-whitespace: detect if no base_commit is provided
Date: Sat, 13 Jul 2024 15:45:17 +0200
Message-ID: <20240713134518.773053-8-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'check-whitespace' CI script exits gracefully if no base commit is
provided or if an invalid revision is provided. This is not good because
if a particular CI provides an incorrect base_commit, it would fail
successfully.

This is exactly the case with the GitLab CI. The CI is using the
"$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" variable to get the base commit
SHA, but variable is only defined for _merged_ pipelines. So it is empty
for regular pipelines [1]. This should've failed the check-whitespace
job.

Let's fallback to 'CI_MERGE_REQUEST_DIFF_BASE_SHA' if
"CI_MERGE_REQUEST_TARGET_BRANCH_SHA" isn't available in GitLab CI,
similar to the previous commit. Let's also add a check for incorrect
base_commit in the 'check-whitespace.sh' script. While here, fix a small
typo too.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .gitlab-ci.yml         | 14 +++++++++++++-
 ci/check-whitespace.sh | 10 ++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 14f9d3dc8e..0596a01b68 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -118,8 +118,20 @@ check-whitespace:
   image: ubuntu:latest
   before_script:
     - ./ci/install-dependencies.sh
+  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
+  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
+  # be defined in all pipelines.
   script:
-    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+    - |
+      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+      then
+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+      then
+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+      else
+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
+      fi
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
index db399097a5..c40804394c 100755
--- a/ci/check-whitespace.sh
+++ b/ci/check-whitespace.sh
@@ -9,7 +9,7 @@ baseCommit=$1
 outputFile=$2
 url=$3
 
-if test "$#" -ne 1 && test "$#" -ne 3
+if test "$#" -ne 1 && test "$#" -ne 3 || test -z "$1"
 then
 	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
 	exit 1
@@ -21,6 +21,12 @@ commitText=
 commitTextmd=
 goodParent=
 
+if ! git rev-parse --quiet --verify "${baseCommit}"
+then
+    echo "Invalid <BASE_COMMIT> '${baseCommit}'"
+    exit 1
+fi
+
 while read dash sha etc
 do
 	case "${dash}" in
@@ -67,7 +73,7 @@ then
 		goodParent=${baseCommit: 0:7}
 	fi
 
-	echo "A whitespace issue was found in onen of more of the commits."
+	echo "A whitespace issue was found in one or more of the commits."
 	echo "Run the following command to resolve whitespace issues:"
 	echo "git rebase --whitespace=fix ${goodParent}"
 
-- 
2.45.2

