Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1D1C695
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780079; cv=none; b=onwzZrKydSH9ZARxn3mFAzvFpAjCCgk19SRAXOWwHv7sBLsUU6Ssn4Mh5zypxRnpM83ymd6Aqqghl0p8QQxSrxrA3kCHRMdzRu/F+S2fvPepWlAiguStsYiS/+yDAdYDkQIJUIMJAPq/SFK9jGspR46lU6zdO59CM9KdMuOinbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780079; c=relaxed/simple;
	bh=+aLRITv0QPSO3GJscXp85HRN0EfbGZ/RsfOSVEpj/Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX0Px1QPXmRN/F5ydYr8ZcsNJb7CuCktcKMrp5p5FjBcCNqyeENiZ58jbbTPYPd0aCdivqrK5mv80c/kuZAs+ZoESyIXPwXsYO1EnSwHFOagiwfeXattp58eZUHKG3Bq+omhXctWVsxXL20y8jq6xv0XCcna0h5xifSN/O5Gm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOHF2wFd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOHF2wFd"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ee651e419so2131771f8f.3
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780076; x=1746384876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTXAdn4ujQyXf8ZfFrYCq4rkPK+gdRR33T76xHUDnLY=;
        b=OOHF2wFdHrk1mrj4+FsplJ60ev/Ki2+ZFiNOpV0idPtq1DHskBlPk2/BBw8xe8Oy8L
         ks0C4eO9iLngJns26w6eZ3OonzJtqsnEsGNtazMJG/9ZsU2izpQv7CJqjGJ6KUE7BLnT
         J1D3JsfsIkodnmXSHQpdKtv72PR8++pYj6F5HRE6rG3YlFdbbZDUSRypBqwyXhLWeXYT
         zNJ/QqFUXerVkeW1r0V31HP8qXZqhhmSHUsZkULAnC/KfBlCoUAsk41YgKez5KOZrgsv
         cgn4RyD39ef+7KmcL6acw4DssiieeJrjVHnKxCQEDbSIxa0gU6QFOaQJWrqiurBA87su
         KGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780076; x=1746384876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTXAdn4ujQyXf8ZfFrYCq4rkPK+gdRR33T76xHUDnLY=;
        b=MrYR1hGzvFvf6tZfvPprvvSlSyl4LUwfxPzB62i9hU9zwMywi3g/xMWGCnjuLUwLl5
         DbpUNRad2GkGa3RhOYIMvddq02XpbB0CgynMtzFFhUeW4iQ2ohzp5ElCqrgdplyHCZP7
         ojKNW5eBxqc5gtr/2HwjbSkZ1cKV2W7eMHSaF0mw1nApeuBzA91P1q8IP2D8Qxa0qq5m
         j7/+DemtghHCWoqIio31O9Ah6Htp8ehqwOEIaUplKdhR5eDQJ2aB59qDzXkaZS4hzU/i
         q9+RGVqi3hr9tEuwgVc26PKTfMimhZ8FGtZKS7WnJqp9uSOltyEMcK6tikN2RZO8BwhN
         RUgA==
X-Gm-Message-State: AOJu0YzAGSUgCwY7rRMnmdzWjXU6kPo489TAm0W04suppMFFUUPFc1+6
	st18CDW/cVGCY4hXRDkyiQQR2V/E2nR/8EpXXG3d1FIqhzN3n7wnK0BP02uy5Viksg==
X-Gm-Gg: ASbGnct0hMiawSwMl36yav8HrapqkPOIBm/z60Fcdnr9EzTUfWNA3wsEb+lBBzSKLOi
	qWMTPXz1ibjVwFe2VpxxzkivPhdmaECDEjloQi/06Wmm7rAvFuoBdIzOxoBCqX9LkP1PZ9cMrDA
	004RPLMJ6XeXndbuy0F6jRUJT/fd6iPwpCLaWkAvXiUr73JdQqT4GnatehBeZVduAoHHXCKcuVT
	NsXvhgIzzYa2Mi3aJIf8qst+vLEdn/nHXWlSpQMLRJwlAvG+i/Jy53EGJfd4Sg7HqP7Zsn32yjH
	akaWCX/D2E+DuETEE/23ThbIi+y+3ylQyUkP
X-Google-Smtp-Source: AGHT+IHuHQHopAWJvBgJdmKBFr+Dn46firdsH1Qb1MpF7dMxtTGolxUtpMJ3+6KPJz3f28ahc1qG5w==
X-Received: by 2002:a05:6000:1a88:b0:39c:1257:febb with SMTP id ffacd0b85a97d-3a074fafc80mr7504284f8f.59.1745780075636;
        Sun, 27 Apr 2025 11:54:35 -0700 (PDT)
Received: from localhost.localdomain ([105.113.116.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm9150175f8f.11.2025.04.27.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 11:54:35 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 2/9] t/unit-tests: convert reftable basics test to use clar test framework
Date: Sun, 27 Apr 2025 19:53:44 +0100
Message-ID: <20250427185351.82520-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427185351.82520-1-kuforiji98@gmail.com>
References: <20250427185351.82520-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable basics test file to clar by using clar assertions
where necessary.Break up test edge case to improve modularity and
clarity.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |   2 +-
 t/meson.build                    |   2 +-
 t/unit-tests/t-reftable-basics.c | 219 -------------------------------
 t/unit-tests/u-reftable-basics.c | 195 +++++++++++++++++++++++++++
 4 files changed, 197 insertions(+), 221 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-basics.c

diff --git a/Makefile b/Makefile
index 1a0f8c30cd..07e37bd1f3 100644
--- a/Makefile
+++ b/Makefile
@@ -1362,6 +1362,7 @@ CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
+CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1375,7 +1376,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
diff --git a/t/meson.build b/t/meson.build
index 0102894b6f..9add1b3d8b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -8,6 +8,7 @@ clar_test_suites = [
   'unit-tests/u-oidmap.c',
   'unit-tests/u-oidtree.c',
   'unit-tests/u-prio-queue.c',
+  'unit-tests/u-reftable-basics.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -55,7 +56,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
deleted file mode 100644
index c9e751e49e..0000000000
--- a/t/unit-tests/t-reftable-basics.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/basics.h"
-
-struct integer_needle_lesseq_args {
-	int needle;
-	int *haystack;
-};
-
-static int integer_needle_lesseq(size_t i, void *_args)
-{
-	struct integer_needle_lesseq_args *args = _args;
-	return args->needle <= args->haystack[i];
-}
-
-static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
-{
-	return NULL;
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	if_test ("binary search with binsearch works") {
-		int haystack[] = { 2, 4, 6, 8, 10 };
-		struct {
-			int needle;
-			size_t expected_idx;
-		} testcases[] = {
-			{-9000, 0},
-			{-1, 0},
-			{0, 0},
-			{2, 0},
-			{3, 1},
-			{4, 1},
-			{7, 3},
-			{9, 4},
-			{10, 4},
-			{11, 5},
-			{9000, 5},
-		};
-
-		for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
-			struct integer_needle_lesseq_args args = {
-				.haystack = haystack,
-				.needle = testcases[i].needle,
-			};
-			size_t idx;
-
-			idx = binsearch(ARRAY_SIZE(haystack),
-					&integer_needle_lesseq, &args);
-			check_int(idx, ==, testcases[i].expected_idx);
-		}
-	}
-
-	if_test ("names_length returns size of a NULL-terminated string array") {
-		const char *a[] = { "a", "b", NULL };
-		check_int(names_length(a), ==, 2);
-	}
-
-	if_test ("names_equal compares NULL-terminated string arrays") {
-		const char *a[] = { "a", "b", "c", NULL };
-		const char *b[] = { "a", "b", "d", NULL };
-		const char *c[] = { "a", "b", NULL };
-
-		check(names_equal(a, a));
-		check(!names_equal(a, b));
-		check(!names_equal(a, c));
-	}
-
-	if_test ("parse_names works for basic input") {
-		char in1[] = "line\n";
-		char in2[] = "a\nb\nc";
-		char **out = parse_names(in1, strlen(in1));
-		check(out != NULL);
-		check_str(out[0], "line");
-		check(!out[1]);
-		free_names(out);
-
-		out = parse_names(in2, strlen(in2));
-		check(out != NULL);
-		check_str(out[0], "a");
-		check_str(out[1], "b");
-		check_str(out[2], "c");
-		check(!out[3]);
-		free_names(out);
-	}
-
-	if_test ("parse_names drops empty string") {
-		char in[] = "a\n\nb\n";
-		char **out = parse_names(in, strlen(in));
-		check(out != NULL);
-		check_str(out[0], "a");
-		/* simply '\n' should be dropped as empty string */
-		check_str(out[1], "b");
-		check(!out[2]);
-		free_names(out);
-	}
-
-	if_test ("common_prefix_size works") {
-		struct reftable_buf a = REFTABLE_BUF_INIT;
-		struct reftable_buf b = REFTABLE_BUF_INIT;
-		struct {
-			const char *a, *b;
-			int want;
-		} cases[] = {
-			{"abcdef", "abc", 3},
-			{ "abc", "ab", 2 },
-			{ "", "abc", 0 },
-			{ "abc", "abd", 2 },
-			{ "abc", "pqr", 0 },
-		};
-
-		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
-			check(!reftable_buf_addstr(&a, cases[i].a));
-			check(!reftable_buf_addstr(&b, cases[i].b));
-			check_uint(common_prefix_size(&a, &b), ==, cases[i].want);
-			reftable_buf_reset(&a);
-			reftable_buf_reset(&b);
-		}
-		reftable_buf_release(&a);
-		reftable_buf_release(&b);
-	}
-
-	if_test ("reftable_put_be64 and reftable_get_be64 work") {
-		uint64_t in = 0x1122334455667788;
-		uint8_t dest[8];
-		uint64_t out;
-		reftable_put_be64(dest, in);
-		out = reftable_get_be64(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("reftable_put_be32 and reftable_get_be32 work") {
-		uint32_t in = 0x11223344;
-		uint8_t dest[4];
-		uint32_t out;
-		reftable_put_be32(dest, in);
-		out = reftable_get_be32(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("reftable_put_be24 and reftable_get_be24 work") {
-		uint32_t in = 0x112233;
-		uint8_t dest[3];
-		uint32_t out;
-		reftable_put_be24(dest, in);
-		out = reftable_get_be24(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("put_be16 and get_be16 work") {
-		uint32_t in = 0xfef1;
-		uint8_t dest[3];
-		uint32_t out;
-		reftable_put_be16(dest, in);
-		out = reftable_get_be16(dest);
-		check_int(in, ==, out);
-	}
-
-	if_test ("REFTABLE_ALLOC_GROW works") {
-		int *arr = NULL, *old_arr;
-		size_t alloc = 0, old_alloc;
-
-		check(!REFTABLE_ALLOC_GROW(arr, 1, alloc));
-		check(arr != NULL);
-		check_uint(alloc, >=, 1);
-		arr[0] = 42;
-
-		old_alloc = alloc;
-		old_arr = arr;
-		reftable_set_alloc(NULL, realloc_stub, NULL);
-		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
-		check(arr == old_arr);
-		check_uint(alloc, ==, old_alloc);
-
-		old_alloc = alloc;
-		reftable_set_alloc(NULL, NULL, NULL);
-		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
-		check(arr != NULL);
-		check_uint(alloc, >, old_alloc);
-		arr[alloc - 1] = 42;
-
-		reftable_free(arr);
-	}
-
-	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
-		int *arr = NULL;
-		size_t alloc = 0, old_alloc;
-
-		REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
-		check(arr != NULL);
-		check_uint(alloc, >=, 1);
-		arr[0] = 42;
-
-		old_alloc = alloc;
-		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
-		check(arr != NULL);
-		check_uint(alloc, >, old_alloc);
-		arr[alloc - 1] = 42;
-
-		old_alloc = alloc;
-		reftable_set_alloc(NULL, realloc_stub, NULL);
-		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
-		check(arr == NULL);
-		check_uint(alloc, ==, 0);
-		reftable_set_alloc(NULL, NULL, NULL);
-
-		reftable_free(arr);
-	}
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
new file mode 100644
index 0000000000..63dd568faf
--- /dev/null
+++ b/t/unit-tests/u-reftable-basics.c
@@ -0,0 +1,195 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/basics.h"
+
+struct integer_needle_lesseq_args {
+	int needle;
+	int *haystack;
+};
+
+static int integer_needle_lesseq(size_t i, void *_args)
+{
+	struct integer_needle_lesseq_args *args = _args;
+	return args->needle <= args->haystack[i];
+}
+
+static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
+{
+	return NULL;
+}
+
+void test_reftable_basics__binsearch(void)
+{
+	int haystack[] = { 2, 4, 6, 8, 10 };
+	struct {
+		int needle;
+		size_t expected_idx;
+	} testcases[] = {
+		{-9000, 0},
+		{-1, 0},
+		{0, 0},
+		{2, 0},
+		{3, 1},
+		{4, 1},
+		{7, 3},
+		{9, 4},
+		{10, 4},
+		{11, 5},
+		{9000, 5},
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
+		struct integer_needle_lesseq_args args = {
+			.haystack = haystack,
+			.needle = testcases[i].needle,
+		};
+		size_t idx;
+
+		idx = binsearch(ARRAY_SIZE(haystack),
+				&integer_needle_lesseq, &args);
+		cl_assert_equal_i(idx, testcases[i].expected_idx);
+	}
+
+}
+
+void test_reftable_basics__names_length(void)
+{
+	const char *a[] = { "a", "b", NULL };
+	cl_assert_equal_i(names_length(a), 2);
+}
+
+void test_reftable_basics__names_equal(void)
+{
+	const char *a[] = { "a", "b", "c", NULL };
+	const char *b[] = { "a", "b", "d", NULL };
+	const char *c[] = { "a", "b", NULL };
+
+	cl_assert(names_equal(a, a));
+	cl_assert(!names_equal(a, b));
+	cl_assert(!names_equal(a, c));
+}
+
+void test_reftable_basics__parse_names(void)
+{
+	char in1[] = "line\n";
+	char in2[] = "a\nb\nc";
+	char **out = parse_names(in1, strlen(in1));
+	cl_assert(out != NULL);
+	cl_assert_equal_s(out[0], "line");
+	cl_assert(!out[1]);
+	free_names(out);
+
+	out = parse_names(in2, strlen(in2));
+	cl_assert(out != NULL);
+	cl_assert_equal_s(out[0], "a");
+	cl_assert_equal_s(out[1], "b");
+	cl_assert_equal_s(out[2], "c");
+	cl_assert(!out[3]);
+	free_names(out);
+}
+
+void test_reftable_basics__common_prefix_size(void)
+{
+	struct reftable_buf a = REFTABLE_BUF_INIT;
+	struct reftable_buf b = REFTABLE_BUF_INIT;
+	struct {
+		const char *a, *b;
+		int want;
+	} cases[] = {
+		{"abcdef", "abc", 3},
+		{ "abc", "ab", 2 },
+		{ "", "abc", 0 },
+		{ "abc", "abd", 2 },
+		{ "abc", "pqr", 0 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
+		reftable_buf_reset(&a);
+		reftable_buf_reset(&b);
+		cl_assert_equal_i(reftable_buf_addstr(&a, cases[i].a), 0);
+		cl_assert_equal_i(reftable_buf_addstr(&b, cases[i].b), 0);
+		cl_assert_equal_i(common_prefix_size(&a, &b), cases[i].want);
+	}
+	reftable_buf_release(&a);
+	reftable_buf_release(&b);
+}
+
+void test_reftable_basics__put_get_be24(void)
+{
+	uint32_t in = 0x112233;
+	uint8_t dest[3];
+	uint32_t out;
+	reftable_put_be24(dest, in);
+	out = reftable_get_be24(dest);
+	cl_assert_equal_i(in, out);
+}
+
+void test_reftable_basics__put_get_be16(void)
+{
+	uint32_t in = 0xfef1;
+	uint8_t dest[3];
+	uint32_t out;
+	reftable_put_be16(dest, in);
+	out = reftable_get_be16(dest);
+	cl_assert_equal_i(in, out);
+}
+
+void test_reftable_basics__grow_alloc(void)
+{
+	int *arr = NULL, *old_arr;
+	size_t alloc = 0, old_alloc;
+
+	cl_assert_equal_i(REFTABLE_ALLOC_GROW(arr, 1, alloc), 0);
+	cl_assert(arr != NULL);
+	cl_assert(alloc >= 1);
+	arr[0] = 42;
+
+	old_alloc = alloc;
+	old_arr = arr;
+	reftable_set_alloc(NULL, realloc_stub, NULL);
+	cl_assert(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
+	cl_assert(arr == old_arr);
+	cl_assert_equal_i(alloc, old_alloc);
+
+	old_alloc = alloc;
+	reftable_set_alloc(NULL, NULL, NULL);
+	cl_assert_equal_i(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc), 0);
+	cl_assert(arr != NULL);
+	cl_assert(alloc > old_alloc);
+	arr[alloc - 1] = 42;
+
+	reftable_free(arr);
+}
+
+void test_reftable_basics__grow_alloc_or_null(void)
+{
+	int *arr = NULL;
+	size_t alloc = 0, old_alloc;
+
+	REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
+	cl_assert(arr != NULL);
+	cl_assert(alloc >= 1);
+	arr[0] = 42;
+
+	old_alloc = alloc;
+	REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
+	cl_assert(arr != NULL);
+	cl_assert(alloc > old_alloc);
+	arr[alloc - 1] = 42;
+
+	old_alloc = alloc;
+	reftable_set_alloc(NULL, realloc_stub, NULL);
+	REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
+	cl_assert(arr == NULL);
+	cl_assert_equal_i(alloc, 0);
+	reftable_set_alloc(NULL, NULL, NULL);
+
+	reftable_free(arr);
+}
-- 
2.43.0

