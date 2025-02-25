Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AC25EF8A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478383; cv=none; b=sHN8En3/zmJnVpwfGcSt4S5NIS3tLRTOfJTOm4CZWYrGpE3Bj/+7OukvBB8dw1g7NXCBSey+bVhKJl5stok86+7Qq84x0qnapFgSB1FR6HljMlvOfH8J+/dtYeNhT/C5Wt50D2Kj2Hait0MhJtDdVjJQ6SWqHPUlnjAWs2hAKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478383; c=relaxed/simple;
	bh=Jy8UAsmv0M9Ianz70QW37WeM/FMtgRFue80XQrAXUSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoCM5Xh6Bd+h3x+Nzp1OfhJ1VHMk3eV485jTWMLtMg5vfC90xBfzCtVTTWj2GTZkS522dUKKqk6CITMIdiTK/9m4Kaxi2IiD5LBQcQ77tDdtI2Z2PRexoqED3cnuWjOEwko/ptvzghgQX4yMVhYj3QO9tir0WjzZrKmmVML4470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK3chy4P; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK3chy4P"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso992183266b.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740478379; x=1741083179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NgQ/SeUGRi4k7g9nIO1t+BNpYgEGEVWcRY2g0N2lSM=;
        b=KK3chy4PhEu3vwjTW7ki+YkUE7LcPht0eBbPylk/UKbT5ifNNV5Rr0jK5mCp2gjA/G
         O+Qg7IlyeStzE6PEAUu3iT2I9zo/xSRjLtHkn4AZPR50wpM9+p36z48Ga/I6LM4y0BeR
         9YnjbaHRDGCbPO+CeTl9XRAD42IHQUNyCY3N17oVBLcPP98ohQlSvP7u/8iySi4CdC/m
         S6wUGapumbZ4qwwA/U4P9AVzJgvQAZNIuNPO/Xu4/mZ/QSiboGnJk6HUbOD3UJl0tyrU
         VO+Azu4OWFOAM4W+Vek9Zvm1zVqePL6JkToy0+bxM28x8XG7UDGoA3CWxRPakDkGmdh5
         ItIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478379; x=1741083179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NgQ/SeUGRi4k7g9nIO1t+BNpYgEGEVWcRY2g0N2lSM=;
        b=g6B9nEYN4RRU5/3WbGtjGfB9zHMZRgJqbCx9OvFPGQy0E5/X/fLTfdE2KQwK0GZK7B
         JT5mjTGYC9a874JXL5v51Y7pXXHlQ3UQDE0Mt1Ai0CZb3VDwJUjzIS3Gjjp8ktZhdEnP
         1qPChlUpI0z4sfThZRqsY1dEtGnEIkLcT8t6AsNrSHLtKqIAPwuZ4RNftJUoI46A17Lm
         dA/nee9PUr468jBvMk5OqNb6YGju/bpswgmjBamS0Tl73SRsfQ/PmvHxebtDlvQKa/Mx
         xz9/9ndBLf7ifiIAY4YOtx7nQWlbTz3Ns+/mX4n59gL00kCIx227Iss04DzGxbz4bNyw
         Ss6g==
X-Gm-Message-State: AOJu0Yxu0oIVrkziS6bZy3qaBRl9guAoIRINdNzviy9Ysq9SiN8/JRGk
	9+/ArBHFwmmuT7ZhvZifdSOoPkLPWrIiL+CAko1pNwXtQCZOsOQX/ILE4yjwyg6rWA==
X-Gm-Gg: ASbGncsvnkPABkMTn+VFIiMxoY7KK97b7CGw5URkVPzFnjR9gI3QF7ZhbPO8f8SsNTU
	zO0C7SBrvuxtM4LmGdskG1Fb3Br76jffOvNot2wDDc4/NRQ07CQ9IKs5NtkXLvSstKFDk4AUZuw
	4X4SUzE8GGQNsf7dIBvni1Rx7RW5icwkRE8yaVXvn13XtQm0f+xK+u9+r/I7Mkbw1aXL3MgO9X3
	iD89aD/IBiRBbUnLgEYg2UjXZ/ceJAXJFTbavAFE9NTtn09Pc+LIeaJMoSVG1qjQUYj+5EeCzv4
	dDabmGhtMUdOVCiPBtKMObSs4OnS6fxLIGmi5Nw=
X-Google-Smtp-Source: AGHT+IGBJyyrF2oHUL2dDXXghi4jo3qtU+U9XVP6PpcQULVQhvzhd+4812Yy+7L5DzWt8pJaB/pYCg==
X-Received: by 2002:a17:907:a317:b0:ab7:46c4:a7be with SMTP id a640c23a62f3a-abbeda28000mr1874241766b.2.1740478379164;
        Tue, 25 Feb 2025 02:12:59 -0800 (PST)
Received: from localhost.localdomain ([41.217.53.197])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abed20b7513sm115120566b.177.2025.02.25.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:12:58 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 4/4] t/unit-tests: convert oidtree test to use clar test framework
Date: Tue, 25 Feb 2025 11:10:44 +0100
Message-ID: <20250225101044.84210-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250225101044.84210-1-kuforiji98@gmail.com>
References: <20250224152704.70289-1-kuforiji98@gmail.com>
 <20250225101044.84210-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt oidtree test script to clar framework by using clar assertions
where necessary. `cl_parse_any_oid()` ensures the hash algorithm is set
before parsing. This prevents issues from an uninitialized or invalid
hash algorithm.

Introduce 'test_oidtree__initialize` handles the to set up of the global
oidtree variable and `test_oidtree__cleanup` frees the oidtree when all
tests are completed.

With this change, `check_each` stops at the first error encountered,
making it easier to address it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                  |  2 +-
 t/meson.build                             |  2 +-
 t/unit-tests/{t-oidtree.c => u-oidtree.c} | 79 +++++++++--------------
 3 files changed, 34 insertions(+), 49 deletions(-)
 rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (45%)

diff --git a/Makefile b/Makefile
index e4e85e6007..2b134efc70 100644
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
@@ -1369,7 +1370,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
diff --git a/t/meson.build b/t/meson.build
index d5b83cdb72..91699917ff 100644
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
@@ -51,7 +52,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-oidtree.c',
   'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/u-oidtree.c
similarity index 45%
rename from t/unit-tests/t-oidtree.c
rename to t/unit-tests/u-oidtree.c
index a38754b066..e6eede2740 100644
--- a/t/unit-tests/t-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -1,10 +1,12 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "lib-oid.h"
 #include "oidtree.h"
 #include "hash.h"
 #include "hex.h"
 #include "strvec.h"
 
+static struct oidtree ot;
+
 #define FILL_TREE(tree, ...)                                       \
 	do {                                                       \
 		const char *hexes[] = { __VA_ARGS__ };             \
@@ -16,8 +18,7 @@ static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
 {
 	for (size_t i = 0; i < n; i++) {
 		struct object_id oid;
-		if (!check_int(get_oid_arbitrary_hex(hexes[i], &oid), ==, 0))
-			return -1;
+		cl_parse_any_oid(hexes[i], &oid);
 		oidtree_insert(ot, &oid);
 	}
 	return 0;
@@ -27,10 +28,8 @@ static void check_contains(struct oidtree *ot, const char *hex, int expected)
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
@@ -44,19 +43,11 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
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
@@ -75,48 +66,42 @@ static void check_each(struct oidtree *ot, const char *query, ...)
 		strvec_push(&hex_iter.expected_hexes, arg);
 	va_end(hex_args);
 
-	if (!check_int(get_oid_arbitrary_hex(query, &oid), ==, 0))
-		return;
+	cl_parse_any_oid(query, &oid);
 	oidtree_each(ot, &oid, strlen(query), check_each_cb, &hex_iter);
 
-	if (!check_int(hex_iter.i, ==, hex_iter.expected_hexes.nr))
-		test_msg("error: could not find some 'object_id's for query ('%s')", query);
+	if (hex_iter.i != hex_iter.expected_hexes.nr)
+		cl_failf("error: could not find some 'object_id's for query ('%s')", query);
+
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

