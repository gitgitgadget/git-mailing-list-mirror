Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6651DC75F
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462121; cv=none; b=hM/0yOE06X5dw7JSbOJJP/VM2b+v5eL/M0+CQgWiuQ/RDI6rbskoO41l2OP+JUP13MaDLDtgX/zlYnI8c13p0+c05aApjvivS2RVgWGrSi/w92NKIkgtC1fAbntxbvytJYcMNTgxklinqSR4pX4OnE+xOOfSfHqi4yHDErVb1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462121; c=relaxed/simple;
	bh=K4jdOw5gZdwuH4M+VQoWHzcbAotAI1xV3J6pc9a3uEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQu0+kgeA/3DNwfGzsMYsZ9xqZD8pa2nv1806TuxZzLhV30yv4NuOOYm2L1cgQHQdvhnQ7I7SPXhwhZexOVSeL1DOlt/nvNdZPGF1FiHJKudIqcTOxC6dmCZnETBo8fAxC0+ZbAc+phgjOo1sfuTEKuBwwvDWsCg2XctpTbWXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTgXV/P6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTgXV/P6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so7982685ad.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462118; x=1726066918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1fnySPnujthWyNh28Qinon78UZvS/fZPKWzOqixGoU=;
        b=jTgXV/P6g2/Ht+3r5QPcWeu0NQvZPICa0zth19dRzNZwjA6yxH4IpyXf7FYplB5Ec6
         rKga6Z7Ou9B7y12QtLs/aUzflkTPSdex9aO/RO0Ir7Pf0RUPdXm8qkwXAM0rl8HUjb55
         mriRC2p53DyB1gavob/gEIgaeQFsSipcc5HI8f5kBlUR46ZCHw1/Ik1MeUbdFc14au5u
         OKMbU+u7zf36xJvwDgFR72KX3MTQri7qsWS1/v3eDVfqTmKPcVwIZU0TR6p8jWIdUIwX
         sUyrUCDBvIGobVOjSrGOOdC6vApOKu2fiDam/FcXQ4Xb+7vZxt2H+TaflZi5mUysKkGw
         S44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462118; x=1726066918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1fnySPnujthWyNh28Qinon78UZvS/fZPKWzOqixGoU=;
        b=f3GnXb6AIxvpqSQzKIAhnfkVJLl9FDTyIh91WDTIUXjEkdH+rgtsLWUYGJd2GRAZbu
         ysKeqZPl4vsyrodjo7Bia9Rc4U1Z5zxN5it5YSMA03Wrd7QHUXI1xmFZT/2Y5P+HPao8
         NxICQupTA+jWMaDRRgxkM2qs4TlZzlKsuQoSSnB34cvcb7EMKRqTf8dykmZfM3I/Je1x
         Qy3yr5DrLwW7CtkKdxf4qpoPnnwgeNLs59BgR5QGvGO/8Ay9CB8xADzyqkYoA9nNdFHh
         RWpEgRLZC6jRrIaJI9MBjQScpQmzmEc2n6qsCXaLAnl+BjYs9zPBYnG/RWUcS11uxyg1
         6dFg==
X-Gm-Message-State: AOJu0YzXRXrtf1JIdaM7unJudas8LO176KCxspfDbBEhRcuQQteG0xOc
	POdO+7nEzAovngrYNhafmIaM07LhrP0VmTQOvtDY2onku/rOc3YfzFoc1iN+
X-Google-Smtp-Source: AGHT+IEutdxYGfPx1yBG49uOm/AF2zo2BTw7RzXuZjogKsYpIY3+pW0/DMlkPFZOX/AQGrSN6zlFdQ==
X-Received: by 2002:a17:902:d2cd:b0:205:5f54:75a2 with SMTP id d9443c01a7336-2055f5478femr152120115ad.51.1725462117677;
        Wed, 04 Sep 2024 08:01:57 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:01:57 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit testing framework
Date: Wed,  4 Sep 2024 20:08:01 +0530
Message-ID: <20240904150132.11567-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240904150132.11567-1-chandrapratap3519@gmail.com>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/stack_test.c exercises the functions defined in
reftable/stack.{c, h}. Migrate reftable/stack_test.c to the
unit testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework and renaming the tests to be in-line with unit-tests'
standards.

Since some of the tests use set_test_hash() defined by
reftable/test_framework.{c, h} but these files are not
'#included' in the test file, copy this function in the
ported test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 reftable/reftable-tests.h                     |   1 -
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-stack.c             | 429 +++++++++---------
 4 files changed, 214 insertions(+), 219 deletions(-)
 rename reftable/stack_test.c => t/unit-tests/t-reftable-stack.c (76%)

diff --git a/Makefile b/Makefile
index 91f65d7dc5..1cbc2d61ae 100644
--- a/Makefile
+++ b/Makefile
@@ -1349,6 +1349,7 @@ UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
+UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
@@ -2691,7 +2692,6 @@ REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
-REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 5d725c69c7..05f8d2d5bc 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -9,6 +9,5 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_TESTS_H
 #define REFTABLE_TESTS_H
 
-int stack_test_main(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index ce5a94fbd3..d27d7ee798 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -12,7 +12,6 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
-	stack_test_main(argc, argv);
 	return 0;
 }
 
diff --git a/reftable/stack_test.c b/t/unit-tests/t-reftable-stack.c
similarity index 76%
rename from reftable/stack_test.c
rename to t/unit-tests/t-reftable-stack.c
index 89cb2be19f..de28fac466 100644
--- a/reftable/stack_test.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -6,22 +6,18 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "stack.h"
-
-#include "system.h"
-
-#include "copy.h"
-#include "reftable-reader.h"
-#include "merged.h"
-#include "basics.h"
-#include "record.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
-#include "reader.h"
-
-#include <sys/types.h>
+#include "test-lib.h"
+#include "reftable/merged.h"
+#include "reftable/reader.h"
+#include "reftable/reftable-error.h"
+#include "reftable/stack.h"
 #include <dirent.h>
 
+static void set_test_hash(uint8_t *p, int i)
+{
+	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
+}
+
 static void clear_dir(const char *dirname)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -73,11 +69,11 @@ static char *get_tmp_template(int linenumber)
 static char *get_tmp_dir(int linenumber)
 {
 	char *dir = get_tmp_template(linenumber);
-	EXPECT(mkdtemp(dir));
+	check(mkdtemp(dir) != NULL);
 	return dir;
 }
 
-static void test_read_file(void)
+static void t_read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
 	int fd = mkstemp(fn);
@@ -87,17 +83,17 @@ static void test_read_file(void)
 	const char *want[] = { "line1", "line2", "line3" };
 	int i = 0;
 
-	EXPECT(fd > 0);
+	check_int(fd, >, 0);
 	n = write_in_full(fd, out, strlen(out));
-	EXPECT(n == strlen(out));
+	check_int(n, ==, strlen(out));
 	err = close(fd);
-	EXPECT(err >= 0);
+	check_int(err, >=, 0);
 
 	err = read_lines(fn, &names);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; names[i]; i++) {
-		EXPECT(0 == strcmp(want[i], names[i]));
+		check_str(want[i], names[i]);
 	}
 	free_names(names);
 	(void) remove(fn);
@@ -132,7 +128,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		set_test_hash(ref.value.val1, i);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	st->opts.disable_auto_compact = disable_auto_compact;
@@ -152,7 +148,7 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 	return reftable_writer_add_log(wr, wla->log);
 }
 
-static void test_reftable_stack_add_one(void)
+static void t_reftable_stack_add_one(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct strbuf scratch = STRBUF_INIT;
@@ -171,22 +167,22 @@ static void test_reftable_stack_add_one(void)
 	struct reftable_ref_record dest = { NULL };
 	struct stat stat_result = { 0 };
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(0 == strcmp("master", dest.value.symref));
-	EXPECT(st->readers_len > 0);
+	check(!err);
+	check_str("master", dest.value.symref);
+	check_int(st->readers_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
 	strbuf_addstr(&scratch, dir);
 	strbuf_addstr(&scratch, "/tables.list");
 	err = stat(scratch.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	strbuf_reset(&scratch);
 	strbuf_addstr(&scratch, dir);
@@ -194,8 +190,8 @@ static void test_reftable_stack_add_one(void)
 	/* do not try at home; not an external API for reftable. */
 	strbuf_addstr(&scratch, st->readers[0]->name);
 	err = stat(scratch.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -207,7 +203,7 @@ static void test_reftable_stack_add_one(void)
 	umask(mask);
 }
 
-static void test_reftable_stack_uptodate(void)
+static void t_reftable_stack_uptodate(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL;
@@ -233,28 +229,28 @@ static void test_reftable_stack_uptodate(void)
 	   by creating two stacks for the same directory.
 	 */
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st1, &write_test_ref, &ref1);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st2, &write_test_ref, &ref2);
-	EXPECT(err == REFTABLE_OUTDATED_ERROR);
+	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
 
 	err = reftable_stack_reload(st2);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st2, &write_test_ref, &ref2);
-	EXPECT_ERR(err);
+	check(!err);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_transaction_api(void)
+static void t_reftable_stack_transaction_api(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -271,32 +267,32 @@ static void test_reftable_stack_transaction_api(void)
 	struct reftable_ref_record dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_addition_destroy(add);
 
 	err = reftable_stack_new_addition(&add, st);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_addition_add(add, &write_test_ref, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_addition_commit(add);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_addition_destroy(add);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(REFTABLE_REF_SYMREF == dest.value_type);
-	EXPECT(0 == strcmp("master", dest.value.symref));
+	check(!err);
+	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
+	check_str("master", dest.value.symref);
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
+static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = {0};
@@ -305,7 +301,7 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 	int i, n = 20, err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -326,13 +322,13 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		st->opts.disable_auto_compact = i != n;
 
 		err = reftable_stack_new_addition(&add, st);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_addition_add(add, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_addition_commit(add);
-		EXPECT_ERR(err);
+		check(!err);
 
 		reftable_addition_destroy(add);
 
@@ -342,16 +338,16 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->readers_len == i + 1);
+			check_int(st->merged->readers_len, ==, i + 1);
 		else
-			EXPECT(st->merged->readers_len == 1);
+			check_int(st->merged->readers_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_auto_compaction_fails_gracefully(void)
+static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 {
 	struct reftable_ref_record ref = {
 		.refname = (char *) "refs/heads/master",
@@ -366,13 +362,13 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	EXPECT_ERR(err);
-	EXPECT(st->merged->readers_len == 1);
-	EXPECT(st->stats.attempts == 0);
-	EXPECT(st->stats.failures == 0);
+	check(!err);
+	check_int(st->merged->readers_len, ==, 1);
+	check_int(st->stats.attempts, ==, 0);
+	check_int(st->stats.failures, ==, 0);
 
 	/*
 	 * Lock the newly written table such that it cannot be compacted.
@@ -384,10 +380,10 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 
 	ref.update_index = 2;
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	EXPECT_ERR(err);
-	EXPECT(st->merged->readers_len == 2);
-	EXPECT(st->stats.attempts == 1);
-	EXPECT(st->stats.failures == 1);
+	check(!err);
+	check_int(st->merged->readers_len, ==, 2);
+	check_int(st->stats.attempts, ==, 1);
+	check_int(st->stats.failures, ==, 1);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&table_path);
@@ -399,7 +395,7 @@ static int write_error(struct reftable_writer *wr UNUSED, void *arg)
 	return *((int *)arg);
 }
 
-static void test_reftable_stack_update_index_check(void)
+static void t_reftable_stack_update_index_check(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -419,18 +415,18 @@ static void test_reftable_stack_update_index_check(void)
 	};
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref1);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref2);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_lock_failure(void)
+static void t_reftable_stack_lock_failure(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -438,17 +434,17 @@ static void test_reftable_stack_lock_failure(void)
 	int err, i;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
 		err = reftable_stack_add(st, &write_error, &i);
-		EXPECT(err == i);
+		check_int(err, ==, i);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_add(void)
+static void t_reftable_stack_add(void)
 {
 	int i = 0;
 	int err = 0;
@@ -466,7 +462,7 @@ static void test_reftable_stack_add(void)
 	int N = ARRAY_SIZE(refs);
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
@@ -485,7 +481,7 @@ static void test_reftable_stack_add(void)
 
 	for (i = 0; i < N; i++) {
 		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -494,18 +490,18 @@ static void test_reftable_stack_add(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		int err = reftable_stack_add(st, &write_test_log, &arg);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		struct reftable_ref_record dest = { NULL };
 
 		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
-		EXPECT_ERR(err);
-		EXPECT(reftable_ref_record_equal(&dest, refs + i,
+		check(!err);
+		check(reftable_ref_record_equal(&dest, refs + i,
 						 GIT_SHA1_RAWSZ));
 		reftable_ref_record_release(&dest);
 	}
@@ -513,8 +509,8 @@ static void test_reftable_stack_add(void)
 	for (i = 0; i < N; i++) {
 		struct reftable_log_record dest = { NULL };
 		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
-		EXPECT_ERR(err);
-		EXPECT(reftable_log_record_equal(&dest, logs + i,
+		check(!err);
+		check(reftable_log_record_equal(&dest, logs + i,
 						 GIT_SHA1_RAWSZ));
 		reftable_log_record_release(&dest);
 	}
@@ -523,8 +519,8 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, dir);
 	strbuf_addstr(&path, "/tables.list");
 	err = stat(path.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	strbuf_reset(&path);
 	strbuf_addstr(&path, dir);
@@ -532,8 +528,8 @@ static void test_reftable_stack_add(void)
 	/* do not try at home; not an external API for reftable. */
 	strbuf_addstr(&path, st->readers[0]->name);
 	err = stat(path.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 #else
 	(void) stat_result;
 #endif
@@ -548,7 +544,7 @@ static void test_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_log_normalize(void)
+static void t_reftable_stack_log_normalize(void)
 {
 	int err = 0;
 	struct reftable_write_options opts = {
@@ -576,27 +572,27 @@ static void test_reftable_stack_log_normalize(void)
 	};
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	input.value.update.message = (char *) "one\ntwo";
 	err = reftable_stack_add(st, &write_test_log, &arg);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
 	err = reftable_stack_add(st, &write_test_log, &arg);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_log(st, input.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(0 == strcmp(dest.value.update.message, "one\n"));
+	check(!err);
+	check_str(dest.value.update.message, "one\n");
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
 	err = reftable_stack_add(st, &write_test_log, &arg);
-	EXPECT_ERR(err);
+	check(!err);
 	err = reftable_stack_read_log(st, input.refname, &dest);
-	EXPECT_ERR(err);
-	EXPECT(0 == strcmp(dest.value.update.message, "two\n"));
+	check(!err);
+	check_str(dest.value.update.message, "two\n");
 
 	/* cleanup */
 	reftable_stack_destroy(st);
@@ -604,7 +600,7 @@ static void test_reftable_stack_log_normalize(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_tombstone(void)
+static void t_reftable_stack_tombstone(void)
 {
 	int i = 0;
 	char *dir = get_tmp_dir(__LINE__);
@@ -618,7 +614,7 @@ static void test_reftable_stack_tombstone(void)
 	struct reftable_log_record log_dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* even entries add the refs, odd entries delete them. */
 	for (i = 0; i < N; i++) {
@@ -642,7 +638,7 @@ static void test_reftable_stack_tombstone(void)
 	}
 	for (i = 0; i < N; i++) {
 		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -651,25 +647,25 @@ static void test_reftable_stack_tombstone(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		int err = reftable_stack_add(st, &write_test_log, &arg);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_stack_read_ref(st, "branch", &dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 	reftable_ref_record_release(&dest);
 
 	err = reftable_stack_read_log(st, "branch", &log_dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 	reftable_log_record_release(&log_dest);
 
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_ref(st, "branch", &dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 
 	err = reftable_stack_read_log(st, "branch", &log_dest);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 	reftable_ref_record_release(&dest);
 	reftable_log_record_release(&log_dest);
 
@@ -682,7 +678,7 @@ static void test_reftable_stack_tombstone(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_hash_id(void)
+static void t_reftable_stack_hash_id(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -702,47 +698,47 @@ static void test_reftable_stack_hash_id(void)
 	struct reftable_ref_record dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_test_ref, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* can't read it with the wrong hash ID. */
 	err = reftable_new_stack(&st32, dir, &opts32);
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
 	/* check that we can read it back with default opts too. */
 	err = reftable_new_stack(&st_default, dir, &opts_default);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_ref(st_default, "master", &dest);
-	EXPECT_ERR(err);
+	check(!err);
 
-	EXPECT(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st_default);
 	clear_dir(dir);
 }
 
-static void test_suggest_compaction_segment(void)
+static void t_suggest_compaction_segment(void)
 {
 	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
-	EXPECT(min.start == 1);
-	EXPECT(min.end == 10);
+	check_int(min.start, ==, 1);
+	check_int(min.end, ==, 10);
 }
 
-static void test_suggest_compaction_segment_nothing(void)
+static void t_suggest_compaction_segment_nothing(void)
 {
 	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
 	struct segment result =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
-	EXPECT(result.start == result.end);
+	check_int(result.start, ==, result.end);
 }
 
-static void test_reflog_expire(void)
+static void t_reflog_expire(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -757,7 +753,7 @@ static void test_reflog_expire(void)
 	struct reftable_log_record log = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 1; i <= N; i++) {
 		char buf[256];
@@ -777,30 +773,30 @@ static void test_reflog_expire(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		int err = reftable_stack_add(st, &write_test_log, &arg);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_compact_all(st, &expiry);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_log(st, logs[9].refname, &log);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 
 	err = reftable_stack_read_log(st, logs[11].refname, &log);
-	EXPECT_ERR(err);
+	check(!err);
 
 	expiry.min_update_index = 15;
 	err = reftable_stack_compact_all(st, &expiry);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_read_log(st, logs[14].refname, &log);
-	EXPECT(err == 1);
+	check_int(err, ==, 1);
 
 	err = reftable_stack_read_log(st, logs[16].refname, &log);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* cleanup */
 	reftable_stack_destroy(st);
@@ -817,7 +813,7 @@ static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
 	return 0;
 }
 
-static void test_empty_add(void)
+static void t_empty_add(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -826,13 +822,13 @@ static void test_empty_add(void)
 	struct reftable_stack *st2 = NULL;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, &write_nothing, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st2);
@@ -848,7 +844,7 @@ static int fastlog2(uint64_t sz)
 	return l - 1;
 }
 
-static void test_reftable_stack_auto_compaction(void)
+static void t_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -859,7 +855,7 @@ static void test_reftable_stack_auto_compaction(void)
 	int N = 100;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -872,21 +868,21 @@ static void test_reftable_stack_auto_compaction(void)
 		snprintf(name, sizeof(name), "branch%04d", i);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_stack_auto_compact(st);
-		EXPECT_ERR(err);
-		EXPECT(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
+		check(!err);
+		check(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
 	}
 
-	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
+	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
 	       (uint64_t)(N * fastlog2(N)));
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_auto_compaction_with_locked_tables(void)
+static void t_reftable_stack_auto_compaction_with_locked_tables(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -897,10 +893,10 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	write_n_ref_tables(st, 5);
-	EXPECT(st->merged->readers_len == 5);
+	check_int(st->merged->readers_len, ==, 5);
 
 	/*
 	 * Given that all tables we have written should be roughly the same
@@ -918,16 +914,16 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * only compact the newest two tables.
 	 */
 	err = reftable_stack_auto_compact(st);
-	EXPECT_ERR(err);
-	EXPECT(st->stats.failures == 0);
-	EXPECT(st->merged->readers_len == 4);
+	check(!err);
+	check_int(st->stats.failures, ==, 0);
+	check_int(st->merged->readers_len, ==, 4);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_add_performs_auto_compaction(void)
+static void t_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -936,7 +932,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	int err, i, n = 20;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -957,7 +953,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		ref.refname = refname.buf;
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		/*
 		 * The stack length should grow continuously for all runs where
@@ -965,9 +961,9 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->readers_len == i + 1);
+			check_int(st->merged->readers_len, ==, i + 1);
 		else
-			EXPECT(st->merged->readers_len == 1);
+			check_int(st->merged->readers_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -975,7 +971,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_compaction_with_locked_tables(void)
+static void t_reftable_stack_compaction_with_locked_tables(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -986,10 +982,10 @@ static void test_reftable_stack_compaction_with_locked_tables(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	write_n_ref_tables(st, 3);
-	EXPECT(st->merged->readers_len == 3);
+	check_int(st->merged->readers_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
 	strbuf_reset(&buf);
@@ -1001,16 +997,16 @@ static void test_reftable_stack_compaction_with_locked_tables(void)
 	 * compact all tables.
 	 */
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT(err == REFTABLE_LOCK_ERROR);
-	EXPECT(st->stats.failures == 1);
-	EXPECT(st->merged->readers_len == 3);
+	check_int(err, ==, REFTABLE_LOCK_ERROR);
+	check_int(st->stats.failures, ==, 1);
+	check_int(st->merged->readers_len, ==, 3);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_compaction_concurrent(void)
+static void t_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
@@ -1018,19 +1014,19 @@ static void test_reftable_stack_compaction_concurrent(void)
 	int err;
 
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	write_n_ref_tables(st1, 3);
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_compact_all(st1, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 
-	EXPECT(count_dir_entries(dir) == 2);
+	check_int(count_dir_entries(dir), ==, 2);
 	clear_dir(dir);
 }
 
@@ -1043,7 +1039,7 @@ static void unclean_stack_close(struct reftable_stack *st)
 	FREE_AND_NULL(st->readers);
 }
 
-static void test_reftable_stack_compaction_concurrent_clean(void)
+static void t_reftable_stack_compaction_concurrent_clean(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
@@ -1051,24 +1047,24 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	int err;
 
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	write_n_ref_tables(st1, 3);
 
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_compact_all(st1, NULL);
-	EXPECT_ERR(err);
+	check(!err);
 
 	unclean_stack_close(st1);
 	unclean_stack_close(st2);
 
 	err = reftable_new_stack(&st3, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_clean(st3);
-	EXPECT_ERR(err);
-	EXPECT(count_dir_entries(dir) == 2);
+	check(!err);
+	check_int(count_dir_entries(dir), ==, 2);
 
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
@@ -1077,7 +1073,7 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_read_across_reload(void)
+static void t_reftable_stack_read_across_reload(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
@@ -1088,36 +1084,36 @@ static void test_reftable_stack_read_across_reload(void)
 
 	/* Create a first stack and set up an iterator for it. */
 	err = reftable_new_stack(&st1, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	write_n_ref_tables(st1, 2);
-	EXPECT(st1->merged->readers_len == 2);
+	check_int(st1->merged->readers_len, ==, 2);
 	reftable_stack_init_ref_iterator(st1, &it);
 	err = reftable_iterator_seek_ref(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* Set up a second stack for the same directory and compact it. */
 	err = reftable_new_stack(&st2, dir, &opts);
-	EXPECT_ERR(err);
-	EXPECT(st2->merged->readers_len == 2);
+	check(!err);
+	check_int(st2->merged->readers_len, ==, 2);
 	err = reftable_stack_compact_all(st2, NULL);
-	EXPECT_ERR(err);
-	EXPECT(st2->merged->readers_len == 1);
+	check(!err);
+	check_int(st2->merged->readers_len, ==, 1);
 
 	/*
 	 * Verify that we can continue to use the old iterator even after we
 	 * have reloaded its stack.
 	 */
 	err = reftable_stack_reload(st1);
-	EXPECT_ERR(err);
-	EXPECT(st1->merged->readers_len == 1);
+	check(!err);
+	check_int(st1->merged->readers_len, ==, 1);
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT_ERR(err);
-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
+	check(!err);
+	check_str(rec.refname, "refs/heads/branch-0000");
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT_ERR(err);
-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
+	check(!err);
+	check_str(rec.refname, "refs/heads/branch-0001");
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT(err > 0);
+	check_int(err, >, 0);
 
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
@@ -1126,7 +1122,7 @@ static void test_reftable_stack_read_across_reload(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_reload_with_missing_table(void)
+static void t_reftable_stack_reload_with_missing_table(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -1138,12 +1134,12 @@ static void test_reftable_stack_reload_with_missing_table(void)
 
 	/* Create a first stack and set up an iterator for it. */
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 	write_n_ref_tables(st, 2);
-	EXPECT(st->merged->readers_len == 2);
+	check_int(st->merged->readers_len, ==, 2);
 	reftable_stack_init_ref_iterator(st, &it);
 	err = reftable_iterator_seek_ref(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 
 	/*
 	 * Update the tables.list file with some garbage data, while reusing
@@ -1156,24 +1152,24 @@ static void test_reftable_stack_reload_with_missing_table(void)
 	strbuf_addf(&table_path, "%s.lock", st->list_file);
 	write_file_buf(table_path.buf, content.buf, content.len);
 	err = rename(table_path.buf, st->list_file);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_reload(st);
-	EXPECT(err == -4);
-	EXPECT(st->merged->readers_len == 2);
+	check_int(err, ==, -4);
+	check_int(st->merged->readers_len, ==, 2);
 
 	/*
 	 * Even though the reload has failed, we should be able to continue
 	 * using the iterator.
 	*/
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT_ERR(err);
-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
+	check(!err);
+	check_str(rec.refname, "refs/heads/branch-0000");
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT_ERR(err);
-	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
+	check(!err);
+	check_str(rec.refname, "refs/heads/branch-0001");
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT(err > 0);
+	check_int(err, >, 0);
 
 	reftable_ref_record_release(&rec);
 	reftable_iterator_destroy(&it);
@@ -1183,31 +1179,32 @@ static void test_reftable_stack_reload_with_missing_table(void)
 	clear_dir(dir);
 }
 
-int stack_test_main(int argc UNUSED, const char *argv[] UNUSED)
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
-	RUN_TEST(test_empty_add);
-	RUN_TEST(test_read_file);
-	RUN_TEST(test_reflog_expire);
-	RUN_TEST(test_reftable_stack_add);
-	RUN_TEST(test_reftable_stack_add_one);
-	RUN_TEST(test_reftable_stack_auto_compaction);
-	RUN_TEST(test_reftable_stack_auto_compaction_with_locked_tables);
-	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
-	RUN_TEST(test_reftable_stack_compaction_concurrent);
-	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
-	RUN_TEST(test_reftable_stack_compaction_with_locked_tables);
-	RUN_TEST(test_reftable_stack_hash_id);
-	RUN_TEST(test_reftable_stack_lock_failure);
-	RUN_TEST(test_reftable_stack_log_normalize);
-	RUN_TEST(test_reftable_stack_tombstone);
-	RUN_TEST(test_reftable_stack_transaction_api);
-	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compaction);
-	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
-	RUN_TEST(test_reftable_stack_update_index_check);
-	RUN_TEST(test_reftable_stack_uptodate);
-	RUN_TEST(test_reftable_stack_read_across_reload);
-	RUN_TEST(test_reftable_stack_reload_with_missing_table);
-	RUN_TEST(test_suggest_compaction_segment);
-	RUN_TEST(test_suggest_compaction_segment_nothing);
-	return 0;
+	TEST(t_empty_add(), "empty addition to stack");
+	TEST(t_read_file(), "read_lines works");
+	TEST(t_reflog_expire(), "expire reflog entries");
+	TEST(t_reftable_stack_add(), "add multiple refs and logs to stack");
+	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
+	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
+	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
+	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
+	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
+	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
+	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
+	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
+	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
+	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
+	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
+	TEST(t_reftable_stack_read_across_reload(), "stack iterators work across reloads");
+	TEST(t_reftable_stack_reload_with_missing_table(), "stack iteration with garbage tables");
+	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
+	TEST(t_reftable_stack_transaction_api(), "update transaction to stack");
+	TEST(t_reftable_stack_transaction_api_performs_auto_compaction(), "update transaction triggers auto-compaction");
+	TEST(t_reftable_stack_update_index_check(), "update transactions with equal update indices");
+	TEST(t_reftable_stack_uptodate(), "stack must be reloaded before ref update");
+	TEST(t_suggest_compaction_segment(), "suggest_compaction_segment with basic input");
+	TEST(t_suggest_compaction_segment_nothing(), "suggest_compaction_segment with pre-compacted input");
+
+	return test_done();
 }
-- 
2.45.GIT

