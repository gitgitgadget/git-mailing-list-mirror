Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F71249E1
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXHv1Kb/"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2C3C0E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:50:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ce4e0e2bdso734030276.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699555853; x=1700160653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOtA1IYqOpX4c93LlYPUaRF3p6VzSgj2O9uC5Pjovg4=;
        b=GXHv1Kb/Eu7jWl1C1zLaL5KmcZk7vmHPRRAQiWuf+Oj78RzaqDZi9jy3u0xdn0/itt
         BEt1zj50ObAbcnzvjbkXT7xyFLnBsT+iV9uFoyZg1TwiTdS3clQZ4+5kimeXi/MbDTiS
         XdcqBWJLx1tgfieVk1zjG5lMUwoQMzLYazx6Bq9iuRrvMqrl1XxXYbQLzj6imllORXhY
         MgDwX4HUxzBK8oQA+DH9FjFWiBdLNIBMxmtuHnxJ3UVpyp92hMzMm+6XujFObTWm3Ij7
         I9461J1jLtglrOcEKyJ6WEZ4KrXUgXnNMt7QT+3yJ1mYI/ga+Uk2WNceBnJ5r2wH3rUI
         Gxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555853; x=1700160653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOtA1IYqOpX4c93LlYPUaRF3p6VzSgj2O9uC5Pjovg4=;
        b=mt8kPD4l8KSlhBsUJ/g+yYksUagALfmpi1c9lz5TnkZobKF9iiXoxv+RmF01Zswlem
         CMDkwfN0pkf/aof9kvtZ3WMYvUabCed1bt0DoqRs9FJgJLN5o+h6MCdC1tz1Kbun66eF
         2MDxaN5bjQxb0kwMvO8Sjg64r3RgAyQGocVsKBpynEiyEMrfYMRI7MCK5IPzV3aWamO6
         9kmays2dYJKk3w0VV3tRjJTwhWZYw8hw7LUmyj5aD3n9ttdD+QUEeuz3Ur0WTHLoXr32
         ZcD6Ge+vzJxvWCLKgaDucKbwdGYZL1UKDnMR0eXSUMkjvr96/xrbMaxnLVRurOY8/kGA
         vjqQ==
X-Gm-Message-State: AOJu0Yy+WhYzcMcO8uFnPv+4hUXu/4eYuQQBLaK2srm0UvLW+Iy+JnRH
	de3sSj9SEGGu4XyR4beCpgOEedkCderuG/IoroBIPlhYABY5I3hdDHyUSMkk/RieKz9LHXtlCM5
	F7MEPY+uGFPBpSKI97cXzxrUiK/4bYTznm0YbQEir0xQoMw1awnzTWO23mj4BSXE=
X-Google-Smtp-Source: AGHT+IFvjUiXY47AyKvGMexv2h72YMvwAh9q4U9HJ/6NHJSzpZr4Nrv4GcWXSoNF2pu5ZQ4Im7xGsZo7Zq95eQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5c8e:97b9:4fad:1ea4])
 (user=steadmon job=sendgmr) by 2002:a25:6b43:0:b0:d9a:c588:38a with SMTP id
 o3-20020a256b43000000b00d9ac588038amr152973ybm.4.1699555853677; Thu, 09 Nov
 2023 10:50:53 -0800 (PST)
Date: Thu,  9 Nov 2023 10:50:44 -0800
In-Reply-To: <cover.1699555664.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1699555664.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <0129ec062c8f7ac2a87cc273454a1ca63705fc55.1699555664.git.steadmon@google.com>
Subject: [PATCH v10 3/3] ci: run unit tests in CI
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com, oswald.buddenhagen@gmx.de, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Run unit tests in both Cirrus and GitHub CI. For sharded CI instances
(currently just Windows on GitHub), run only on the first shard. This is
OK while we have only a single unit test executable, but we may wish to
distribute tests more evenly when we add new unit tests in the future.

We may also want to add more status output in our unit test framework,
so that we can do similar post-processing as in
ci/lib.sh:handle_failed_tests().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .cirrus.yml               | 2 +-
 ci/run-build-and-tests.sh | 2 ++
 ci/run-test-slice.sh      | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 4860bebd32..b6280692d2 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -19,4 +19,4 @@ freebsd_12_task:
   build_script:
     - su git -c gmake
   test_script:
-    - su git -c 'gmake test'
+    - su git -c 'gmake DEFAULT_UNIT_TEST_TARGET=unit-tests-prove test unit-tests'
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2528f25e31..7a1466b868 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -50,6 +50,8 @@ if test -n "$run_tests"
 then
 	group "Run tests" make test ||
 	handle_failed_tests
+	group "Run unit tests" \
+		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests
 fi
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index a3c67956a8..ae8094382f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -15,4 +15,9 @@ group "Run tests" make --quiet -C t T="$(cd t &&
 	tr '\n' ' ')" ||
 handle_failed_tests
 
+# We only have one unit test at the moment, so run it in the first slice
+if [ "$1" == "0" ] ; then
+	group "Run unit tests" make --quiet -C t unit-tests-prove
+fi
+
 check_unignored_build_artifacts
-- 
2.42.0.869.gea05f2083d-goog

