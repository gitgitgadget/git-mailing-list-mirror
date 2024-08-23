Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923C18455E
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414762; cv=none; b=U+I4pI6TlZpl/kZyhmO6KsX1ltCi0Pe/YXfdatA6XM4EcVj5VJBQP88NOHBT7UXHKwtq0/pNZ5TmuMeTCnobKpSONhVHWdSHG2DZutLySD6Sv3FkowSE32nZ5aXmmwdvhMmcSSgkMwa7iRJTgQXJQgQA1zXEDVc+bg7L4J68Hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414762; c=relaxed/simple;
	bh=RIq4Aszl0kvcpFP1pN11VSTX9AoZ1V+qcQ/flrFD7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAPmX/pPrf9QXSIqOLOP9MmKpSyYj7tTwARyvovxz+qVlhEIFVGWQ9ONMESNzM+u/JQrMUc7CQhCFbAda5ln4h4sX4J7N8AEd8z5lvgf7xyUm1nwJd8XxN/UQzwJd8pitWBHNEOxePAkhmWeDqOMiO3KIfV9IryjCWTjd9I/X7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNB//U91; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNB//U91"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fba05363so15369725ad.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414758; x=1725019558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB0zrUSpV1vUkdhES+59KLen130rqZtxea8oLCFrVKE=;
        b=cNB//U91xIGttX44i4g3g0KNslvuqgqWkD2BIa9hpwo2iAlfvPZTQDc8ZBSlGzazbs
         GeAqAD3beVyRNEJw+uqCceael/4uXzVCInzVIqRCibiwaKXWn4xhbfaB90alYr8pybIL
         AF2MFXW1n5irix1Z90RafmGEpnQvhcgiCRLEs55ZwVZm7wvoWuaM2panRtCQyPtUP3H6
         FE0wu2kwNkBO92RZBsm5kA3Dn8dbpyZIb6OCj6FCK4fNwm8xbwuLOBAC5If5y2roKfkS
         yoZvM6jZ+bO8a074RbU5AY1w9MvuDQRUmj/DCA3TOmBMNS4vT30SuZ3qYQ8l0mPNJmy/
         5Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414758; x=1725019558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB0zrUSpV1vUkdhES+59KLen130rqZtxea8oLCFrVKE=;
        b=d3I84QDzePoRemv0LdLQckYtp3hc5PCfpK+JvcKlDhwJo7Nuz99Zmo/pYiqfNVLBne
         lPpyBvbh4b3Z84Z+QuuCLiH4ARcRmT41k0ZxE204xnnjzsj/5ykcQgxlav/r9CFBjFAR
         Q41eDxWK/Eb/ZiU/6zBEbpF/qnljanyxazOKrt717/eXol/NzQKtewdpXJnHMjHybpyL
         UjecFgdByp4k1uNkPH2s4V+3wijlVhQ9rqojnresFWFsJIK6oBewvzmUga6yYf3Zqyhx
         EQEBpc2xEJh7lxJi3MfuzE0Cl01cNxJXSzQ9j6So/OlaJhAazvnaqqtIM3oXtC8x4p+8
         MwMA==
X-Gm-Message-State: AOJu0YwdSIcIuEjL8JMKAdcN1skqF6D9+60n8ZGr395XhIg9Fb4MVEBC
	BA4zGDfC/dPyp9+LSNtiElhBsSYR7ErGSWqtcJq7KDBOt3GytithaVOxsQ==
X-Google-Smtp-Source: AGHT+IFpe22CC31Z5bXR5HS5Utr/TdjXuaxocna6OzkWBIp3uexM63Y/D7XCpYbMS9MzgVgv0EPRNA==
X-Received: by 2002:a17:902:d512:b0:202:51ca:9831 with SMTP id d9443c01a7336-2039e570630mr18968795ad.49.1724414757622;
        Fri, 23 Aug 2024 05:05:57 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:05:57 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/6] t: move reftable/stack_test.c to the unit testing framework
Date: Fri, 23 Aug 2024 17:18:46 +0530
Message-ID: <20240823120514.11070-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
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
 .../unit-tests/t-reftable-stack.c             | 374 +++++++++---------
 4 files changed, 187 insertions(+), 191 deletions(-)
 rename reftable/stack_test.c => t/unit-tests/t-reftable-stack.c (77%)

diff --git a/Makefile b/Makefile
index a87e18b317..a63b3d8381 100644
--- a/Makefile
+++ b/Makefile
@@ -1344,6 +1344,7 @@ UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-record
+UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
@@ -2685,7 +2686,6 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
-REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 4b666810af..2ed2aa7a86 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -13,7 +13,6 @@ int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
-int stack_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
 
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 623cf3f0f5..8a817ca9d9 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -7,7 +7,6 @@ int cmd__reftable(int argc, const char **argv)
 	/* test from simple to complex. */
 	block_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
-	stack_test_main(argc, argv);
 	return 0;
 }
 
diff --git a/reftable/stack_test.c b/t/unit-tests/t-reftable-stack.c
similarity index 77%
rename from reftable/stack_test.c
rename to t/unit-tests/t-reftable-stack.c
index 8c36590ff0..cae86b4b91 100644
--- a/reftable/stack_test.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -6,21 +6,18 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "stack.h"
-
-#include "system.h"
-
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
@@ -72,11 +69,11 @@ static char *get_tmp_template(int linenumber)
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
@@ -86,17 +83,17 @@ static void test_read_file(void)
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
@@ -130,7 +127,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		set_test_hash(ref.value.val1, i);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	st->opts.disable_auto_compact = disable_auto_compact;
@@ -150,7 +147,7 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 	return reftable_writer_add_log(wr, wla->log);
 }
 
-static void test_reftable_stack_add_one(void)
+static void t_reftable_stack_add_one(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct strbuf scratch = STRBUF_INIT;
@@ -169,29 +166,29 @@ static void test_reftable_stack_add_one(void)
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
 
 	printf("testing print functionality:\n");
 	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
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
@@ -199,8 +196,8 @@ static void test_reftable_stack_add_one(void)
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
@@ -212,7 +209,7 @@ static void test_reftable_stack_add_one(void)
 	umask(mask);
 }
 
-static void test_reftable_stack_uptodate(void)
+static void t_reftable_stack_uptodate(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL;
@@ -238,28 +235,28 @@ static void test_reftable_stack_uptodate(void)
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
@@ -276,32 +273,32 @@ static void test_reftable_stack_transaction_api(void)
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
@@ -310,7 +307,7 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 	int i, n = 20, err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -331,13 +328,13 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
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
 
@@ -347,16 +344,16 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->stack_len == i + 1);
+			check_int(st->merged->stack_len, ==, i + 1);
 		else
-			EXPECT(st->merged->stack_len == 1);
+			check_int(st->merged->stack_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_auto_compaction_fails_gracefully(void)
+static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 {
 	struct reftable_ref_record ref = {
 		.refname = (char *) "refs/heads/master",
@@ -371,13 +368,13 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	EXPECT_ERR(err);
-	EXPECT(st->merged->stack_len == 1);
-	EXPECT(st->stats.attempts == 0);
-	EXPECT(st->stats.failures == 0);
+	check(!err);
+	check_int(st->merged->stack_len, ==, 1);
+	check_int(st->stats.attempts, ==, 0);
+	check_int(st->stats.failures, ==, 0);
 
 	/*
 	 * Lock the newly written table such that it cannot be compacted.
@@ -389,10 +386,10 @@ static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 
 	ref.update_index = 2;
 	err = reftable_stack_add(st, write_test_ref, &ref);
-	EXPECT_ERR(err);
-	EXPECT(st->merged->stack_len == 2);
-	EXPECT(st->stats.attempts == 1);
-	EXPECT(st->stats.failures == 1);
+	check(!err);
+	check_int(st->merged->stack_len, ==, 2);
+	check_int(st->stats.attempts, ==, 1);
+	check_int(st->stats.failures, ==, 1);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&table_path);
@@ -404,7 +401,7 @@ static int write_error(struct reftable_writer *wr, void *arg)
 	return *((int *)arg);
 }
 
-static void test_reftable_stack_update_index_check(void)
+static void t_reftable_stack_update_index_check(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -424,18 +421,18 @@ static void test_reftable_stack_update_index_check(void)
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
@@ -443,17 +440,17 @@ static void test_reftable_stack_lock_failure(void)
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
@@ -471,7 +468,7 @@ static void test_reftable_stack_add(void)
 	int N = ARRAY_SIZE(refs);
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
@@ -490,7 +487,7 @@ static void test_reftable_stack_add(void)
 
 	for (i = 0; i < N; i++) {
 		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -499,18 +496,18 @@ static void test_reftable_stack_add(void)
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
@@ -518,8 +515,8 @@ static void test_reftable_stack_add(void)
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
@@ -528,8 +525,8 @@ static void test_reftable_stack_add(void)
 	strbuf_addstr(&path, dir);
 	strbuf_addstr(&path, "/tables.list");
 	err = stat(path.buf, &stat_result);
-	EXPECT(!err);
-	EXPECT((stat_result.st_mode & 0777) == opts.default_permissions);
+	check(!err);
+	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
 
 	strbuf_reset(&path);
 	strbuf_addstr(&path, dir);
@@ -537,8 +534,8 @@ static void test_reftable_stack_add(void)
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
@@ -553,7 +550,7 @@ static void test_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_log_normalize(void)
+static void t_reftable_stack_log_normalize(void)
 {
 	int err = 0;
 	struct reftable_write_options opts = {
@@ -581,27 +578,27 @@ static void test_reftable_stack_log_normalize(void)
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
@@ -609,7 +606,7 @@ static void test_reftable_stack_log_normalize(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_tombstone(void)
+static void t_reftable_stack_tombstone(void)
 {
 	int i = 0;
 	char *dir = get_tmp_dir(__LINE__);
@@ -623,7 +620,7 @@ static void test_reftable_stack_tombstone(void)
 	struct reftable_log_record log_dest = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* even entries add the refs, odd entries delete them. */
 	for (i = 0; i < N; i++) {
@@ -647,7 +644,7 @@ static void test_reftable_stack_tombstone(void)
 	}
 	for (i = 0; i < N; i++) {
 		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -656,25 +653,25 @@ static void test_reftable_stack_tombstone(void)
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
 
@@ -687,7 +684,7 @@ static void test_reftable_stack_tombstone(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_hash_id(void)
+static void t_reftable_stack_hash_id(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
@@ -707,47 +704,47 @@ static void test_reftable_stack_hash_id(void)
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
@@ -762,7 +759,7 @@ static void test_reflog_expire(void)
 	struct reftable_log_record log = { NULL };
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 1; i <= N; i++) {
 		char buf[256];
@@ -782,30 +779,30 @@ static void test_reflog_expire(void)
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
@@ -822,7 +819,7 @@ static int write_nothing(struct reftable_writer *wr, void *arg)
 	return 0;
 }
 
-static void test_empty_add(void)
+static void t_empty_add(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -831,13 +828,13 @@ static void test_empty_add(void)
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
@@ -853,7 +850,7 @@ static int fastlog2(uint64_t sz)
 	return l - 1;
 }
 
-static void test_reftable_stack_auto_compaction(void)
+static void t_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -864,7 +861,7 @@ static void test_reftable_stack_auto_compaction(void)
 	int N = 100;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -877,21 +874,21 @@ static void test_reftable_stack_auto_compaction(void)
 		snprintf(name, sizeof(name), "branch%04d", i);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		err = reftable_stack_auto_compact(st);
-		EXPECT_ERR(err);
-		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+		check(!err);
+		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
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
@@ -902,10 +899,10 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	write_n_ref_tables(st, 5);
-	EXPECT(st->merged->stack_len == 5);
+	check_int(st->merged->stack_len, ==, 5);
 
 	/*
 	 * Given that all tables we have written should be roughly the same
@@ -923,16 +920,16 @@ static void test_reftable_stack_auto_compaction_with_locked_tables(void)
 	 * only compact the newest two tables.
 	 */
 	err = reftable_stack_auto_compact(st);
-	EXPECT_ERR(err);
-	EXPECT(st->stats.failures == 0);
-	EXPECT(st->merged->stack_len == 4);
+	check(!err);
+	check_int(st->stats.failures, ==, 0);
+	check_int(st->merged->stack_len, ==, 4);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_add_performs_auto_compaction(void)
+static void t_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
@@ -941,7 +938,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	int err, i, n = 20;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	for (i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
@@ -962,7 +959,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		ref.refname = refname.buf;
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 
 		/*
 		 * The stack length should grow continuously for all runs where
@@ -970,9 +967,9 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		 * all tables in the stack.
 		 */
 		if (i != n)
-			EXPECT(st->merged->stack_len == i + 1);
+			check_int(st->merged->stack_len, ==, i + 1);
 		else
-			EXPECT(st->merged->stack_len == 1);
+			check_int(st->merged->stack_len, ==, 1);
 	}
 
 	reftable_stack_destroy(st);
@@ -980,7 +977,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_compaction_with_locked_tables(void)
+static void t_reftable_stack_compaction_with_locked_tables(void)
 {
 	struct reftable_write_options opts = {
 		.disable_auto_compact = 1,
@@ -991,10 +988,10 @@ static void test_reftable_stack_compaction_with_locked_tables(void)
 	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
-	EXPECT_ERR(err);
+	check(!err);
 
 	write_n_ref_tables(st, 3);
-	EXPECT(st->merged->stack_len == 3);
+	check_int(st->merged->stack_len, ==, 3);
 
 	/* Lock one of the tables that we're about to compact. */
 	strbuf_reset(&buf);
@@ -1006,16 +1003,16 @@ static void test_reftable_stack_compaction_with_locked_tables(void)
 	 * compact all tables.
 	 */
 	err = reftable_stack_compact_all(st, NULL);
-	EXPECT(err == REFTABLE_LOCK_ERROR);
-	EXPECT(st->stats.failures == 1);
-	EXPECT(st->merged->stack_len == 3);
+	check_int(err, ==, REFTABLE_LOCK_ERROR);
+	check_int(st->stats.failures, ==, 1);
+	check_int(st->merged->stack_len, ==, 3);
 
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
 	clear_dir(dir);
 }
 
-static void test_reftable_stack_compaction_concurrent(void)
+static void t_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
@@ -1023,19 +1020,19 @@ static void test_reftable_stack_compaction_concurrent(void)
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
 
@@ -1050,7 +1047,7 @@ static void unclean_stack_close(struct reftable_stack *st)
 	FREE_AND_NULL(st->readers);
 }
 
-static void test_reftable_stack_compaction_concurrent_clean(void)
+static void t_reftable_stack_compaction_concurrent_clean(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
@@ -1058,24 +1055,24 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
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
@@ -1084,29 +1081,30 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 	clear_dir(dir);
 }
 
-int stack_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
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

