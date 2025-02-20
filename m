Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A741EB19A
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040224; cv=none; b=onSdwih7kNGLMjZaYzO9CDUgaaO4f2RNMTbaprQdCILOxh8VoWkhqOtO/DDDSri5PzpELgtaTH0tKkiu2SVcxUQdMzSaN9LXvAcmTsgWoTKTN4s7PiIps1+98zNaf4xSI+epc/vIon6C6nK81jWwvBK+FDHvFZKaxpCGy9YFMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040224; c=relaxed/simple;
	bh=r08WGRJR85V8Ugbppb01qn/Cn8xBlRgMH8Qc94B5YxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4Dyku1S1hnC8hpFtGFudweUiJfmAQzGcqx+IdeGSKVqJlTPYsgFBpLT69nCkKuEQaGMDWVY/Qf/PX3M4IeDKCtoh91NJfEEAUhYyiyWhFAtu8OYvOzba9CO+H7AyZA86yM+AH6wXnXl9hPjCDhy5qYN4Jil3Knp2qwWGv+zmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVOr3yvl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVOr3yvl"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso824258a12.1
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040221; x=1740645021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMNe0KNVZ0ezW/BXclTfZ4dcGv1NO3f0HWS3/rdroXA=;
        b=VVOr3yvlPkz0lUROXG1c8AMpqKSKdVEf+w7aAlJRc0qMsSK9kx9zNueI2/0p+NKSNB
         0N2vimOjZHd5rWdqslIGLmilo+0obOIBDVTS8Evts9US1nXlTy6XgWSDs8GO/6MCen3l
         TSur1fQOeWbw97BpwOdJB8Y082qXAbh/xaKzvcoxP6v7q80pFynYbVHeAI71dD0kvqFX
         p6JgDIE03RQoS9CMrY8MTXJsZ4AAbl6Q7IOhrZhvqMfZWL+JJchS3CVzPbvA7ALWAZ1K
         BNs046P2zpjsqHf5/dvIRxhjkRYJvGR7OOuIPfUBhP17yLJU6yHkfoKf0knUQ2K49/lr
         Nx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040221; x=1740645021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMNe0KNVZ0ezW/BXclTfZ4dcGv1NO3f0HWS3/rdroXA=;
        b=P8wVWyiQa8pi1Rg8ZvbKTKjAKtAq3MLqinLcwkdTVWbPPlm0iTKncP65QGKevdID8T
         LRHLQ9VGFCmwtJmH82t0z1HLOZggiWv/gu7OKvt8ls7tvoWk2EMU5W831B2+VEDtfFHS
         wbLEVJ5jpbzS5MD4/hnjOhu8QWy3qzeKXI+X9k+DuEcYbUZhoPe8y92gz0ZIqXKdtuFC
         GcJCxutoFKOIlTfIjdMjChy+Sy5PAfTTY1H1UtHWiIDDJ1HYPd9I6dNJfg7DJpyUzJMv
         Ro+qcxiFISxRESar66LhyxEshC8nS1qLgLxwlmtvZVoFJa85BvWoAorMSHu6hvo3W2TO
         arnw==
X-Gm-Message-State: AOJu0YwUMz7p/y/Exlaoz2Gj+XU9UlboTBNgvxFcTIYG6cDOCCx7GR8q
	c4VEFpTU+cjL0Okm1A9dgqyh61B2xjNxguEhgupba1rOP1z+ItGEJZiPXdlOZ9qJ4A==
X-Gm-Gg: ASbGncvQ3RNpleXheeWIQqfr6vZdhPO/pwpsFXnsyJEgV67iLLnqJs88fjnEGCd7kZl
	g+ptUItBZbKh0pf9kGmhWEdP1tq6FVTo0mq8w409Ek+6pbgjklaXjnHaskNR6Z0HsselD5qD5wi
	MSVlQLhXJDEojnlD40b1BxW1UnmYW0aGY9aZCYUsWJ3vqfmfgHyQpGHcSlcWQJ58kxBjuYktHb8
	BT4/2ARxO4BaDmuO74dxYTLJmN/sn2Jy5SzIGDWqcVLnxXBsDk0cpv2qaSiHJcB3mZNkZfWActC
	6FSacaog97DoJ/1Al/PkRAIq6qI=
X-Google-Smtp-Source: AGHT+IF7gA3IWByoPBDVf2DJC+w7Qn1aJ4skQ3gPfkK1T1CpPAQ7SqEkv7OSIeAv3YlxZJDzlsRUGw==
X-Received: by 2002:a17:907:6d0a:b0:ab7:e8d6:3b12 with SMTP id a640c23a62f3a-abbccc51169mr721332366b.1.1740040220548;
        Thu, 20 Feb 2025 00:30:20 -0800 (PST)
Received: from localhost.localdomain ([154.118.9.41])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abbdf53d765sm230533966b.39.2025.02.20.00.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:19 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 4/5] t/unit-tests: convert oidtree test to use clar
Date: Thu, 20 Feb 2025 09:29:58 +0100
Message-ID: <20250220082959.10854-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250220082959.10854-1-kuforiji98@gmail.com>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt oidtree test script to clar framework by using clar assertions
where necessary. `cl_parse_any_oid` handles the necessary checks needed
for the test to run smoothly.

Introduce 'test_oidtree__initialize` handles the to set up of the global
oidtree variable and `test_oidtree__cleanup` frees the oidtree when all
tests are completed.

This streamlines the test suite, making individual tests self-contained
and reducing redundant code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                  |  2 +-
 t/meson.build                             |  2 +-
 t/unit-tests/{t-oidtree.c => u-oidtree.c} | 78 +++++++++--------------
 3 files changed, 32 insertions(+), 50 deletions(-)
 rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (44%)

diff --git a/Makefile b/Makefile
index 58a6af1eb0..feb01702c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1358,6 +1358,7 @@ CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
+CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
@@ -1368,7 +1369,6 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
diff --git a/t/meson.build b/t/meson.build
index f9e0ae15df..0b412a7c16 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
+  'unit-tests/u-oidtree.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
@@ -50,7 +51,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-oidtree.c',
   'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/u-oidtree.c
similarity index 44%
rename from t/unit-tests/t-oidtree.c
rename to t/unit-tests/u-oidtree.c
index a38754b066..de6f6bd292 100644
--- a/t/unit-tests/t-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -1,10 +1,11 @@
-#include "test-lib.h"
-#include "lib-oid.h"
+#include "unit-test.h"
 #include "oidtree.h"
 #include "hash.h"
 #include "hex.h"
 #include "strvec.h"
 
+static struct oidtree ot;
+
 #define FILL_TREE(tree, ...)                                       \
 	do {                                                       \
 		const char *hexes[] = { __VA_ARGS__ };             \
@@ -16,8 +17,7 @@ static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
 {
 	for (size_t i = 0; i < n; i++) {
 		struct object_id oid;
-		if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), ==, 0))
-			return -1;
+		cl_parse_any_oid(hexes[i], &oid);
 		oidtree_insert(ot, &oid);
 	}
 	return 0;
@@ -27,10 +27,8 @@ static void check_contains(struct oidtree *ot, const char *hex, int expected)
 {
 	struct object_id oid;
 
-	if (!check_int(get_oid_arbitrary_hex(hex, &oid), ==, 0))
-		return;
-	if (!check_int(oidtree_contains(ot, &oid), ==, expected))
-		test_msg("oid: %s", oid_to_hex(&oid));
+	cl_parse_any_oid(hex, &oid);
+	cl_assert_equal_i(oidtree_contains(ot, &oid), expected);
 }
 
 struct expected_hex_iter {
@@ -44,19 +42,11 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
 	struct expected_hex_iter *hex_iter = data;
 	struct object_id expected;
 
-	if (!check_int(hex_iter->i, <, hex_iter->expected_hexes.nr)) {
-		test_msg("error: extraneous callback for query: ('%s'), object_id: ('%s')",
-			 hex_iter->query, oid_to_hex(oid));
-		return CB_BREAK;
-	}
-
-	if (!check_int(get_oid_arbitrary_hex(hex_iter->expected_hexes.v[hex_iter->i],
-					     &expected), ==, 0))
-		; /* the data is bogus and cannot be used */
-	else if (!check(oideq(oid, &expected)))
-		test_msg("expected: %s\n       got: %s\n     query: %s",
-			 oid_to_hex(&expected), oid_to_hex(oid), hex_iter->query);
+	cl_assert(hex_iter->i < hex_iter->expected_hexes.nr);
 
+	cl_parse_any_oid(hex_iter->expected_hexes.v[hex_iter->i],
+			 &expected);
+	cl_assert_equal_s(oid_to_hex(oid), oid_to_hex(&expected));
 	hex_iter->i += 1;
 	return CB_CONTINUE;
 }
@@ -75,48 +65,40 @@ static void check_each(struct oidtree *ot, const char *query, ...)
 		strvec_push(&hex_iter.expected_hexes, arg);
 	va_end(hex_args);
 
-	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
-		return;
+	cl_parse_any_oid(query, &oid);
 	oidtree_each(ot, &oid, strlen(query), check_each_cb, &hex_iter);
 
-	if (!check_int(hex_iter.i, ==, hex_iter.expected_hexes.nr))
-		test_msg("error: could not find some 'object_id's for query ('%s')", query);
+	cl_assert_equal_i(hex_iter.i, hex_iter.expected_hexes.nr);
 	strvec_clear(&hex_iter.expected_hexes);
 }
 
-static void setup(void (*f)(struct oidtree *ot))
+void test_oidtree__initialize(void)
 {
-	struct oidtree ot;
-
 	oidtree_init(&ot);
-	f(&ot);
-	oidtree_clear(&ot);
 }
 
-static void t_contains(struct oidtree *ot)
+void test_oidtree__cleanup(void)
 {
-	FILL_TREE(ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
-	check_contains(ot, "44", 0);
-	check_contains(ot, "441", 0);
-	check_contains(ot, "440", 0);
-	check_contains(ot, "444", 1);
-	check_contains(ot, "4440", 1);
-	check_contains(ot, "4444", 0);
+	oidtree_clear(&ot);
 }
 
-static void t_each(struct oidtree *ot)
+void test_oidtree__contains(void)
 {
-	FILL_TREE(ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
-	check_each(ot, "12300", "123", NULL);
-	check_each(ot, "3211", NULL); /* should not reach callback */
-	check_each(ot, "3210", "321", NULL);
-	check_each(ot, "32100", "321", NULL);
-	check_each(ot, "32", "320", "321", NULL);
+	FILL_TREE(&ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
+	check_contains(&ot, "44", 0);
+	check_contains(&ot, "441", 0);
+	check_contains(&ot, "440", 0);
+	check_contains(&ot, "444", 1);
+	check_contains(&ot, "4440", 1);
+	check_contains(&ot, "4444", 0);
 }
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_oidtree__each(void)
 {
-	TEST(setup(t_contains), "oidtree insert and contains works");
-	TEST(setup(t_each), "oidtree each works");
-	return test_done();
+	FILL_TREE(&ot, "f", "9", "8", "123", "321", "320", "a", "b", "c", "d", "e");
+	check_each(&ot, "12300", "123", NULL);
+	check_each(&ot, "3211", NULL); /* should not reach callback */
+	check_each(&ot, "3210", "321", NULL);
+	check_each(&ot, "32100", "321", NULL);
+	check_each(&ot, "32", "320", "321", NULL);
 }
-- 
2.47.0.86.g15030f9556

