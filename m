Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1B2B9B1
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082121; cv=none; b=ay/KKXmVvs+0+GZd8denoH5Swmk7Q4th0GJrHt6lrZOr5IXaDQ0A8iKPhvT/28/e7Vr0NLdlzNC3oHLhFN4odGBD71j/XdCWEhlgCK2zo7+LXfCgBdNpbLYhHcoReH5yAiCKgL0fdhYxU5si8On4jjoOYa7L3MLxfVD3B/9u2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082121; c=relaxed/simple;
	bh=9stDF05v8TaU7aRouus1oV4/hJX2HsdktPyGcUfSn+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwQS+7HPzOcA63ktSh12d8ZnaFm+aKWtdzbuOl2dh/d+jZX8sIbpj+Mw8/7ARveviTk7TvIvKk3X8awTqUyx8XB9vdfaNtxPXuzul/ygbFULTI3Tx/D2VIiBUMnQHP1vj2R0ysKlHxP9F/agUNz1jPVbZ/L8tKjNVy93UKTA2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVnuUKGp; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVnuUKGp"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so946638a12.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710082118; x=1710686918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWuGrh7RCRsepeG74uJJE7wYLN1pDlFl/Z20Rk30acg=;
        b=JVnuUKGpdsBtGp0rdlbIFbonxe2z/R9ySrkYFWT49PMfqobtLf0Wb+I41FegfUWrzV
         xeORo9RTDR/c0skNgG4UcJQ7o9vBN4Aa9bUiB1HHmAKTzmSLLn8WsCNX4MT0g0LKjNf6
         2d43X8l8TGaody9W1z0bUhri7P1R/NZAY1tQDj5RL/VecPUFHz4N2AKfqsPlt5kLM+Yh
         PsoVX5Qxeg+ooaBGUqlAzaMEaW3vSE5AdHgy/mBk+6uxCoi27wX0Dcv+wcMigZawPSlL
         4JGD7RHqc7rFEcK1YuXO26W1Gogk0IJyjKVNlfUrK3MmPqE4ArdTYKRYxrq9mIw3osSW
         bCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710082118; x=1710686918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWuGrh7RCRsepeG74uJJE7wYLN1pDlFl/Z20Rk30acg=;
        b=WO8JRM+P0OtxcxMiUc+2RfYwKCCJggy5x0FdrmvZm9gIAXNvJMEjiDOVIEk2I64UaP
         uykYKR7AZdDXARSDxiMlqyziw1N9Iv7h4z18zzmLvfvRoazA2jRClEBgsgWVU/6rfx1Z
         wTFoG/ISe7qciKxrgM9hjYMtcll8UJ/8Xx5gpWUf0omDqqGtJwS6hxJfDAKRlnRspiPU
         eMYVvcDyJJX1OjsDYdHKx/54V94l/LE83oWCN5wVpwfdIBrl1uXS3jzdlDcNQ08SO3+T
         BcDx3dUVuPrb/mo8Aa899YU7o4AH2H0eXkpt/FxsGAE835o6Z4wp6EzqCgBInuo5dSdl
         f/gg==
X-Gm-Message-State: AOJu0Yw3TFY+WI3+ij948SPpgHevxZ1rFRNztFEC27xCKTHjgtiJbdo9
	aYP9wm7CU9q6Vpnjmx+6/B08XCHtdg/vYHgcOtGGn/bf/B8TTVqRVHAmR/fs623J4w==
X-Google-Smtp-Source: AGHT+IHXQJwj1rx+nystEQJKG4Grbx2+sP3gmljVihJTUP/xEzlgNjNv/lBbOEUYP/IwusaTFgiZaA==
X-Received: by 2002:a17:906:f209:b0:a44:9e7e:64c3 with SMTP id gt9-20020a170906f20900b00a449e7e64c3mr2314023ejb.10.1710082117623;
        Sun, 10 Mar 2024 07:48:37 -0700 (PDT)
Received: from localhost.localdomain ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id lv9-20020a170906bc8900b00a45abeb7d12sm1954654ejb.109.2024.03.10.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 07:48:37 -0700 (PDT)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH] Port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.c
Date: Sun, 10 Mar 2024 15:48:19 +0100
Message-ID: <20240310144819.4379-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (8bf6fbd (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

Let's migrate the unit tests for strcmp-offset functionality from the
legacy approach using the test-tool command `test-tool strcmp-offset` in
helper/test-strcmp-offset.c to the new unit testing framework
(t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 Makefile                       |  2 +-
 t/helper/test-strcmp-offset.c  | 23 -----------------------
 t/helper/test-tool.c           |  1 -
 t/helper/test-tool.h           |  1 -
 t/t0065-strcmp-offset.sh       | 22 ----------------------
 t/unit-tests/t-strcmp-offset.c | 31 +++++++++++++++++++++++++++++++
 6 files changed, 32 insertions(+), 48 deletions(-)
 delete mode 100644 t/helper/test-strcmp-offset.c
 delete mode 100755 t/t0065-strcmp-offset.sh
 create mode 100644 t/unit-tests/t-strcmp-offset.c

diff --git a/Makefile b/Makefile
index 4e255c81f2..b8d7019ad7 100644
--- a/Makefile
+++ b/Makefile
@@ -850,7 +850,6 @@ TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-simple-ipc.o
-TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
@@ -1347,6 +1346,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
deleted file mode 100644
index d8473cf2fc..0000000000
--- a/t/helper/test-strcmp-offset.c
+++ /dev/null
@@ -1,23 +0,0 @@
-#include "test-tool.h"
-#include "read-cache-ll.h"
-
-int cmd__strcmp_offset(int argc UNUSED, const char **argv)
-{
-	int result;
-	size_t offset;
-
-	if (!argv[1] || !argv[2])
-		die("usage: %s <string1> <string2>", argv[0]);
-
-	result = strcmp_offset(argv[1], argv[2], &offset);
-
-	/*
-	 * Because different CRTs behave differently, only rely on signs
-	 * of the result values.
-	 */
-	result = (result < 0 ? -1 :
-			  result > 0 ? 1 :
-			  0);
-	printf("%d %"PRIuMAX"\n", result, (uintmax_t)offset);
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 482a1e58a4..3d56de82fd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -76,7 +76,6 @@ static struct test_cmd cmds[] = {
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "simple-ipc", cmd__simple_ipc },
-	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule", cmd__submodule },
 	{ "submodule-config", cmd__submodule_config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b1be7cfcf5..8d76a8c1e1 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -69,7 +69,6 @@ int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
-int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
deleted file mode 100755
index 94e34c83ed..0000000000
--- a/t/t0065-strcmp-offset.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-
-test_description='Test strcmp_offset functionality'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-while read s1 s2 expect
-do
-	test_expect_success "strcmp_offset($s1, $s2)" '
-		echo "$expect" >expect &&
-		test-tool strcmp-offset "$s1" "$s2" >actual &&
-		test_cmp expect actual
-	'
-done <<-EOF
-abc abc 0 3
-abc def -1 0
-abc abz -1 2
-abc abcdef -1 3
-EOF
-
-test_done
diff --git a/t/unit-tests/t-strcmp-offset.c b/t/unit-tests/t-strcmp-offset.c
new file mode 100644
index 0000000000..176d2ed04a
--- /dev/null
+++ b/t/unit-tests/t-strcmp-offset.c
@@ -0,0 +1,31 @@
+#include "test-lib.h"
+#include "read-cache-ll.h"
+
+static void check_strcmp_offset(const char *string1, const char *string2, int expect_result,  uintmax_t expect_offset)
+{
+	int result;
+	size_t offset;
+
+	result = strcmp_offset(string1, string2, &offset);
+
+	/* Because different CRTs behave differently, only rely on signs of the result values. */
+	result = (result < 0 ? -1 :
+			  result > 0 ? 1 :
+			  0);
+
+	check_int(result, ==, expect_result);
+	check_uint((uintmax_t)offset, ==, expect_offset);
+}
+
+#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offset) \
+		TEST(check_strcmp_offset(string1, string2, expect_result, expect_offset), \
+			"strcmp_offset(%s, %s) works", #string1, #string2)
+
+int cmd_main(int argc, const char **argv) {
+	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
+	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
+	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);
+	TEST_STRCMP_OFFSET("abc", "abcdef", -1, 3);
+
+	return test_done();
+}
--
2.43.0.windows.1

