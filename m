Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561119F487
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560308; cv=none; b=SwXGsej2M+zd8Ss9TDfUaGSPZV/icF7l7rbNahR2438AiNGzVqxZBgcR1DMBZ3v9QrHsow/2z8w2j3hRVWAuit8H01J4MupMgIQjR8kQFRhfZnEc+lSQ+JDdjFJIo8ZjGm3qxwyHDR8Izgbt29SPVJwW2mP1IzNsIakeC3zoW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560308; c=relaxed/simple;
	bh=2jLr4R8xPquiBAxbQeXyRcp1gZgxqlFe1zck5BzGWp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbPnCreKkFrXQUaL+Qw7fy6duuCgnQIOM1OQiTgYAMWhzcGcOrOG0IHbdOyZ0ByO0jYaq6H3/ButrP0NFXmGDHut6c8EI9Kx6P8ow53kGQeOmgvO4HQMO3DPspYbG7PMFHDVd0fAx/Na8eiXuLZIi6kGuoWyoPUTph96ONU1f50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN7jU0nT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN7jU0nT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc56fd4de1so37297975ad.0
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560305; x=1724165105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EulyO6aRg+n6NzY1//l3aLt1d1nE8W+szMj8Lpc70s=;
        b=WN7jU0nT/MgzcNjkkAPMUXpS5aoCwpvvVOSscOETp5SOZ6AlSCgRF35sgTRS6P+j1y
         kaaKiq9Ho6oP1moGYBxihQfmudHyXCiqX2EApGog+OIWitZQXvniKFqJhQxh2AfxEHpP
         oEEMSlz9XqmXNNtXa8lIyQX0ub7fX9IozWxLQtG25RlvUZrqW55dHG8fegWjBRxBpEha
         slZ1IEcV97IGaJs+enInHVQZx1/Nc+I3Nc4ECd60n5XSTqzcUCrTByoYUJ8lhO3L7Wsv
         dBs8i5eu393dUCCUAdr56OUVFjpUMfAYnQilyAEhpJxw0SchYRuEH8jE5wyzKBPK9Ffm
         bNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560305; x=1724165105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EulyO6aRg+n6NzY1//l3aLt1d1nE8W+szMj8Lpc70s=;
        b=VW7gyMBIUBUIKh3F11nBlshdLlvQ/wTzpYenzKe7wybDqj5loSer9fnYDWOaUL84Iq
         +3k8AkRwFhr8BHIAv0Eu1Azvl50WP4BPoRKhPtDuSSTyv7qq23gqoPyrcYphioVeb4CG
         SXFTIDBN3N76Fyi+hfIjbxVlfXXAzjaqVkL7i/9TEJwNKS8NCb4aE/MksBO6/xVG8VaI
         FGUcigoY68BDFwIZGddNgSNpcqydF03/s79zAW8DCzc6nNBMmJ4YyypLyaxhKRgzARJO
         WIFs6mOqsHWxrtFyPZYO5Ull4IOG+0AFI9P0JcLymSAuBL+uslmEuhh2BBZF9hsUaYe2
         fbfg==
X-Gm-Message-State: AOJu0Yz8tGWPJJBG1UjAyVNIeWA+z/tt7lh6TFEXGgrBh8CuAiCHgyN2
	btWGmLLR2PZ4p1hUwcArhdCsEB0hIl+OAKfSJEnDmm7oO7yo3EvLF1WB0tIDOVM=
X-Google-Smtp-Source: AGHT+IGTRjh5/Uir+Iy4u/QJ7VrDZx9OXQJq1nMZIPDiLCZhdGai4VG2zzwf9vLOt3BlQv0DZiu9lQ==
X-Received: by 2002:a17:903:228e:b0:1fd:6033:f94e with SMTP id d9443c01a7336-201cbc959d7mr49625005ad.27.1723560304352;
        Tue, 13 Aug 2024 07:45:04 -0700 (PDT)
Received: from Ubuntu.. ([27.61.226.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd14b1c8sm14388805ad.78.2024.08.13.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:45:03 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/4] t: move reftable/readwrite_test.c to the unit testing framework
Date: Tue, 13 Aug 2024 20:04:47 +0530
Message-ID: <20240813144440.4602-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240813144440.4602-1-chandrapratap3519@gmail.com>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/readwrite_test.c exercises the functions defined in
reftable/reader.{c,h} and reftable/writer.{c,h}. Migrate
reftable/readwrite_test.c to the unit testing framework. Migration
involves refactoring the tests to use the unit testing framework
instead of reftable's test framework and renaming the tests to
align with unit-tests' naming conventions.

Since some tests in reftable/readwrite_test.c use the functions
set_test_hash(), noop_flush() and strbuf_add_void() defined in
reftable/test_framework.{c,h} but these files are not #included
in the ported unit test, copy these functions in the new test file.

While at it, ensure structs are 0-initialized with '= { 0 }'
instead of '= { NULL }'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |   2 +-
 reftable/reftable-tests.h                     |   1 -
 t/helper/test-reftable.c                      |   1 -
 .../unit-tests/t-reftable-readwrite.c         | 418 +++++++++---------
 4 files changed, 210 insertions(+), 212 deletions(-)
 rename reftable/readwrite_test.c => t/unit-tests/t-reftable-readwrite.c (70%)

diff --git a/Makefile b/Makefile
index 3863e60b66..76e4d1c1ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1341,6 +1341,7 @@ UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-merged
+UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
@@ -2682,7 +2683,6 @@ REFTABLE_OBJS += reftable/writer.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
-REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index d5e03dcc1b..7d955393d2 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -13,7 +13,6 @@ int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
 int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
-int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
 int tree_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da..d371e9f9dd 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -8,7 +8,6 @@ int cmd__reftable(int argc, const char **argv)
 	block_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
-	readwrite_test_main(argc, argv);
 	stack_test_main(argc, argv);
 	return 0;
 }
diff --git a/reftable/readwrite_test.c b/t/unit-tests/t-reftable-readwrite.c
similarity index 70%
rename from reftable/readwrite_test.c
rename to t/unit-tests/t-reftable-readwrite.c
index f411abfe9c..d0eb85fc38 100644
--- a/reftable/readwrite_test.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -6,37 +6,48 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "system.h"
-
-#include "basics.h"
-#include "block.h"
-#include "blocksource.h"
-#include "reader.h"
-#include "record.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
-#include "reftable-writer.h"
+#include "test-lib.h"
+#include "reftable/blocksource.h"
+#include "reftable/reader.h"
+#include "reftable/reftable-error.h"
+#include "reftable/reftable-writer.h"
 
 static const int update_index = 5;
 
-static void test_buffer(void)
+static void set_test_hash(uint8_t *p, int i)
+{
+	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
+}
+
+static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
+{
+	strbuf_add(b, data, sz);
+	return sz;
+}
+
+static int noop_flush(void *arg)
+{
+	return 0;
+}
+
+static void t_buffer(void)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_block_source source = { NULL };
-	struct reftable_block out = { NULL };
+	struct reftable_block_source source = { 0 };
+	struct reftable_block out = { 0 };
 	int n;
 	uint8_t in[] = "hello";
 	strbuf_add(&buf, in, sizeof(in));
 	block_source_from_strbuf(&source, &buf);
-	EXPECT(block_source_size(&source) == 6);
+	check_int(block_source_size(&source), ==, 6);
 	n = block_source_read_block(&source, &out, 0, sizeof(in));
-	EXPECT(n == sizeof(in));
-	EXPECT(!memcmp(in, out.data, n));
+	check_int(n, ==, sizeof(in));
+	check(!memcmp(in, out.data, n));
 	reftable_block_done(&out);
 
 	n = block_source_read_block(&source, &out, 1, 2);
-	EXPECT(n == 2);
-	EXPECT(!memcmp(out.data, "el", 2));
+	check_int(n, ==, 2);
+	check(!memcmp(out.data, "el", 2));
 
 	reftable_block_done(&out);
 	block_source_close(&source);
@@ -52,9 +63,9 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 	};
 	struct reftable_writer *w =
 		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
-	struct reftable_ref_record ref = { NULL };
+	struct reftable_ref_record ref = { 0 };
 	int i = 0, n;
-	struct reftable_log_record log = { NULL };
+	struct reftable_log_record log = { 0 };
 	const struct reftable_stats *stats = NULL;
 
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
@@ -73,7 +84,7 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 		(*names)[i] = xstrdup(name);
 
 		n = reftable_writer_add_ref(w, &ref);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -89,27 +100,25 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 		log.value.update.message = (char *) "message";
 
 		n = reftable_writer_add_log(w, &log);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 	}
 
 	n = reftable_writer_close(w);
-	EXPECT(n == 0);
+	check_int(n, ==, 0);
 
 	stats = reftable_writer_stats(w);
 	for (i = 0; i < stats->ref_stats.blocks; i++) {
 		int off = i * opts.block_size;
-		if (off == 0) {
-			off = header_size(
-				(hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
-		}
-		EXPECT(buf->buf[off] == 'r');
+		if (!off)
+			off = header_size((hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
+		check_char(buf->buf[off], ==, 'r');
 	}
 
-	EXPECT(stats->log_stats.blocks > 0);
+	check_int(stats->log_stats.blocks, >, 0);
 	reftable_writer_free(w);
 }
 
-static void test_log_buffer_size(void)
+static void t_log_buffer_size(void)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_write_options opts = {
@@ -140,14 +149,14 @@ static void test_log_buffer_size(void)
 	}
 	reftable_writer_set_limits(w, update_index, update_index);
 	err = reftable_writer_add_log(w, &log);
-	EXPECT_ERR(err);
+	check(!err);
 	err = reftable_writer_close(w);
-	EXPECT_ERR(err);
+	check(!err);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
 
-static void test_log_overflow(void)
+static void t_log_overflow(void)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char msg[256] = { 0 };
@@ -177,12 +186,12 @@ static void test_log_overflow(void)
 	memset(msg, 'x', sizeof(msg) - 1);
 	reftable_writer_set_limits(w, update_index, update_index);
 	err = reftable_writer_add_log(w, &log);
-	EXPECT(err == REFTABLE_ENTRY_TOO_BIG_ERROR);
+	check_int(err, ==, REFTABLE_ENTRY_TOO_BIG_ERROR);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
 
-static void test_log_write_read(void)
+static void t_log_write_read(void)
 {
 	int N = 2;
 	char **names = reftable_calloc(N + 1, sizeof(*names));
@@ -190,13 +199,13 @@ static void test_log_write_read(void)
 	struct reftable_write_options opts = {
 		.block_size = 256,
 	};
-	struct reftable_ref_record ref = { NULL };
+	struct reftable_ref_record ref = { 0 };
 	int i = 0;
-	struct reftable_log_record log = { NULL };
+	struct reftable_log_record log = { 0 };
 	int n;
-	struct reftable_iterator it = { NULL };
-	struct reftable_reader rd = { NULL };
-	struct reftable_block_source source = { NULL };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
@@ -204,17 +213,17 @@ static void test_log_write_read(void)
 	reftable_writer_set_limits(w, 0, N);
 	for (i = 0; i < N; i++) {
 		char name[256];
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
 		names[i] = xstrdup(name);
 		ref.refname = name;
 		ref.update_index = i;
 
 		err = reftable_writer_add_ref(w, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 	for (i = 0; i < N; i++) {
-		struct reftable_log_record log = { NULL };
+		struct reftable_log_record log = { 0 };
 
 		log.refname = names[i];
 		log.update_index = i;
@@ -223,33 +232,33 @@ static void test_log_write_read(void)
 		set_test_hash(log.value.update.new_hash, i + 1);
 
 		err = reftable_writer_add_log(w, &log);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	n = reftable_writer_close(w);
-	EXPECT(n == 0);
+	check_int(n, ==, 0);
 
 	stats = reftable_writer_stats(w);
-	EXPECT(stats->log_stats.blocks > 0);
+	check_int(stats->log_stats.blocks, >, 0);
 	reftable_writer_free(w);
 	w = NULL;
 
 	block_source_from_strbuf(&source, &buf);
 
 	err = init_reader(&rd, &source, "file.log");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_reader_init_ref_iterator(&rd, &it);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_iterator_next_ref(&it, &ref);
-	EXPECT_ERR(err);
+	check(!err);
 
 	/* end of iteration. */
 	err = reftable_iterator_next_ref(&it, &ref);
-	EXPECT(0 < err);
+	check_int(err, >, 0);
 
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
@@ -257,23 +266,21 @@ static void test_log_write_read(void)
 	reftable_reader_init_log_iterator(&rd, &it);
 
 	err = reftable_iterator_seek_log(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 
 	i = 0;
 	while (1) {
 		int err = reftable_iterator_next_log(&it, &log);
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
-
-		EXPECT_ERR(err);
-		EXPECT_STREQ(names[i], log.refname);
-		EXPECT(i == log.update_index);
+		check(!err);
+		check_str(names[i], log.refname);
+		check_int(i, ==, log.update_index);
 		i++;
 		reftable_log_record_release(&log);
 	}
 
-	EXPECT(i == N);
+	check_int(i, ==, N);
 	reftable_iterator_destroy(&it);
 
 	/* cleanup. */
@@ -282,7 +289,7 @@ static void test_log_write_read(void)
 	reader_close(&rd);
 }
 
-static void test_log_zlib_corruption(void)
+static void t_log_zlib_corruption(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 256,
@@ -316,13 +323,13 @@ static void test_log_zlib_corruption(void)
 	reftable_writer_set_limits(w, 1, 1);
 
 	err = reftable_writer_add_log(w, &log);
-	EXPECT_ERR(err);
+	check(!err);
 
 	n = reftable_writer_close(w);
-	EXPECT(n == 0);
+	check_int(n, ==, 0);
 
 	stats = reftable_writer_stats(w);
-	EXPECT(stats->log_stats.blocks > 0);
+	check_int(stats->log_stats.blocks, >, 0);
 	reftable_writer_free(w);
 	w = NULL;
 
@@ -332,11 +339,11 @@ static void test_log_zlib_corruption(void)
 	block_source_from_strbuf(&source, &buf);
 
 	err = init_reader(&rd, &source, "file.log");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_reader_init_log_iterator(&rd, &it);
 	err = reftable_iterator_seek_log(&it, "refname");
-	EXPECT(err == REFTABLE_ZLIB_ERROR);
+	check_int(err, ==, REFTABLE_ZLIB_ERROR);
 
 	reftable_iterator_destroy(&it);
 
@@ -345,14 +352,14 @@ static void test_log_zlib_corruption(void)
 	reader_close(&rd);
 }
 
-static void test_table_read_write_sequential(void)
+static void t_table_read_write_sequential(void)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
 	int N = 50;
-	struct reftable_iterator it = { NULL };
-	struct reftable_block_source source = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_iterator it = { 0 };
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader rd = { 0 };
 	int err = 0;
 	int j = 0;
 
@@ -361,26 +368,25 @@ static void test_table_read_write_sequential(void)
 	block_source_from_strbuf(&source, &buf);
 
 	err = init_reader(&rd, &source, "file.ref");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_reader_init_ref_iterator(&rd, &it);
 	err = reftable_iterator_seek_ref(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 
 	while (1) {
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 		int r = reftable_iterator_next_ref(&it, &ref);
-		EXPECT(r >= 0);
-		if (r > 0) {
+		check_int(r, >=, 0);
+		if (r > 0)
 			break;
-		}
-		EXPECT(0 == strcmp(names[j], ref.refname));
-		EXPECT(update_index == ref.update_index);
+		check_str(names[j], ref.refname);
+		check_int(update_index, ==, ref.update_index);
 
 		j++;
 		reftable_ref_record_release(&ref);
 	}
-	EXPECT(j == N);
+	check_int(j, ==, N);
 	reftable_iterator_destroy(&it);
 	strbuf_release(&buf);
 	free_names(names);
@@ -388,90 +394,88 @@ static void test_table_read_write_sequential(void)
 	reader_close(&rd);
 }
 
-static void test_table_write_small_table(void)
+static void t_table_write_small_table(void)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
 	int N = 1;
 	write_table(&names, &buf, N, 4096, GIT_SHA1_FORMAT_ID);
-	EXPECT(buf.len < 200);
+	check_int(buf.len, <, 200);
 	strbuf_release(&buf);
 	free_names(names);
 }
 
-static void test_table_read_api(void)
+static void t_table_read_api(void)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
 	int N = 50;
-	struct reftable_reader rd = { NULL };
-	struct reftable_block_source source = { NULL };
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
 	int err;
 	int i;
-	struct reftable_log_record log = { NULL };
-	struct reftable_iterator it = { NULL };
+	struct reftable_log_record log = { 0 };
+	struct reftable_iterator it = { 0 };
 
 	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
 
 	block_source_from_strbuf(&source, &buf);
 
 	err = init_reader(&rd, &source, "file.ref");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_reader_init_ref_iterator(&rd, &it);
 	err = reftable_iterator_seek_ref(&it, names[0]);
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_iterator_next_log(&it, &log);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < N; i++)
 		reftable_free(names[i]);
-	}
 	reftable_iterator_destroy(&it);
 	reftable_free(names);
 	reader_close(&rd);
 	strbuf_release(&buf);
 }
 
-static void test_table_read_write_seek(int index, int hash_id)
+static void t_table_read_write_seek(int index, int hash_id)
 {
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
 	int N = 50;
-	struct reftable_reader rd = { NULL };
-	struct reftable_block_source source = { NULL };
+	struct reftable_reader rd = { 0 };
+	struct reftable_block_source source = { 0 };
 	int err;
 	int i = 0;
 
-	struct reftable_iterator it = { NULL };
+	struct reftable_iterator it = { 0 };
 	struct strbuf pastLast = STRBUF_INIT;
-	struct reftable_ref_record ref = { NULL };
+	struct reftable_ref_record ref = { 0 };
 
 	write_table(&names, &buf, N, 256, hash_id);
 
 	block_source_from_strbuf(&source, &buf);
 
 	err = init_reader(&rd, &source, "file.ref");
-	EXPECT_ERR(err);
-	EXPECT(hash_id == reftable_reader_hash_id(&rd));
+	check(!err);
+	check_int(hash_id, ==, reftable_reader_hash_id(&rd));
 
-	if (!index) {
+	if (!index)
 		rd.ref_offsets.index_offset = 0;
-	} else {
-		EXPECT(rd.ref_offsets.index_offset > 0);
-	}
+	else
+		check_int(rd.ref_offsets.index_offset, >, 0);
 
 	for (i = 1; i < N; i++) {
 		reftable_reader_init_ref_iterator(&rd, &it);
 		err = reftable_iterator_seek_ref(&it, names[i]);
-		EXPECT_ERR(err);
+		check(!err);
 		err = reftable_iterator_next_ref(&it, &ref);
-		EXPECT_ERR(err);
-		EXPECT(0 == strcmp(names[i], ref.refname));
-		EXPECT(REFTABLE_REF_VAL1 == ref.value_type);
-		EXPECT(i == ref.value.val1[0]);
+		check(!err);
+		check_str(names[i], ref.refname);
+		check_int(REFTABLE_REF_VAL1, ==, ref.value_type);
+		check_int(i, ==, ref.value.val1[0]);
 
 		reftable_ref_record_release(&ref);
 		reftable_iterator_destroy(&it);
@@ -483,40 +487,39 @@ static void test_table_read_write_seek(int index, int hash_id)
 	reftable_reader_init_ref_iterator(&rd, &it);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 		int err = reftable_iterator_next_ref(&it, &ref);
-		EXPECT(err > 0);
+		check_int(err, >, 0);
 	} else {
-		EXPECT(err > 0);
+		check_int(err, >, 0);
 	}
 
 	strbuf_release(&pastLast);
 	reftable_iterator_destroy(&it);
 
 	strbuf_release(&buf);
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < N; i++)
 		reftable_free(names[i]);
-	}
 	reftable_free(names);
 	reader_close(&rd);
 }
 
-static void test_table_read_write_seek_linear(void)
+static void t_table_read_write_seek_linear(void)
 {
-	test_table_read_write_seek(0, GIT_SHA1_FORMAT_ID);
+	t_table_read_write_seek(0, GIT_SHA1_FORMAT_ID);
 }
 
-static void test_table_read_write_seek_linear_sha256(void)
+static void t_table_read_write_seek_linear_sha256(void)
 {
-	test_table_read_write_seek(0, GIT_SHA256_FORMAT_ID);
+	t_table_read_write_seek(0, GIT_SHA256_FORMAT_ID);
 }
 
-static void test_table_read_write_seek_index(void)
+static void t_table_read_write_seek_index(void)
 {
-	test_table_read_write_seek(1, GIT_SHA1_FORMAT_ID);
+	t_table_read_write_seek(1, GIT_SHA1_FORMAT_ID);
 }
 
-static void test_table_refs_for(int indexed)
+static void t_table_refs_for(int indexed)
 {
 	int N = 50;
 	char **want_names = reftable_calloc(N + 1, sizeof(*want_names));
@@ -526,18 +529,18 @@ static void test_table_refs_for(int indexed)
 	struct reftable_write_options opts = {
 		.block_size = 256,
 	};
-	struct reftable_ref_record ref = { NULL };
+	struct reftable_ref_record ref = { 0 };
 	int i = 0;
 	int n;
 	int err;
 	struct reftable_reader rd;
-	struct reftable_block_source source = { NULL };
+	struct reftable_block_source source = { 0 };
 
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 
-	struct reftable_iterator it = { NULL };
+	struct reftable_iterator it = { 0 };
 	int j;
 
 	set_test_hash(want_hash, 4);
@@ -546,7 +549,7 @@ static void test_table_refs_for(int indexed)
 		uint8_t hash[GIT_SHA1_RAWSZ];
 		char fill[51] = { 0 };
 		char name[100];
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 
 		memset(hash, i, sizeof(hash));
 		memset(fill, 'x', 50);
@@ -563,16 +566,15 @@ static void test_table_refs_for(int indexed)
 		 */
 		/* blocks. */
 		n = reftable_writer_add_ref(w, &ref);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
 		if (!memcmp(ref.value.val2.value, want_hash, GIT_SHA1_RAWSZ) ||
-		    !memcmp(ref.value.val2.target_value, want_hash, GIT_SHA1_RAWSZ)) {
+		    !memcmp(ref.value.val2.target_value, want_hash, GIT_SHA1_RAWSZ))
 			want_names[want_names_len++] = xstrdup(name);
-		}
 	}
 
 	n = reftable_writer_close(w);
-	EXPECT(n == 0);
+	check_int(n, ==, 0);
 
 	reftable_writer_free(w);
 	w = NULL;
@@ -580,33 +582,30 @@ static void test_table_refs_for(int indexed)
 	block_source_from_strbuf(&source, &buf);
 
 	err = init_reader(&rd, &source, "file.ref");
-	EXPECT_ERR(err);
-	if (!indexed) {
+	check(!err);
+	if (!indexed)
 		rd.obj_offsets.is_present = 0;
-	}
 
 	reftable_reader_init_ref_iterator(&rd, &it);
 	err = reftable_iterator_seek_ref(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 	reftable_iterator_destroy(&it);
 
 	err = reftable_reader_refs_for(&rd, &it, want_hash);
-	EXPECT_ERR(err);
+	check(!err);
 
 	j = 0;
 	while (1) {
 		int err = reftable_iterator_next_ref(&it, &ref);
-		EXPECT(err >= 0);
-		if (err > 0) {
+		check_int(err, >=, 0);
+		if (err > 0)
 			break;
-		}
-
-		EXPECT(j < want_names_len);
-		EXPECT(0 == strcmp(ref.refname, want_names[j]));
+		check_int(j, <, want_names_len);
+		check_str(ref.refname, want_names[j]);
 		j++;
 		reftable_ref_record_release(&ref);
 	}
-	EXPECT(j == want_names_len);
+	check_int(j, ==, want_names_len);
 
 	strbuf_release(&buf);
 	free_names(want_names);
@@ -614,54 +613,54 @@ static void test_table_refs_for(int indexed)
 	reader_close(&rd);
 }
 
-static void test_table_refs_for_no_index(void)
+static void t_table_refs_for_no_index(void)
 {
-	test_table_refs_for(0);
+	t_table_refs_for(0);
 }
 
-static void test_table_refs_for_obj_index(void)
+static void t_table_refs_for_obj_index(void)
 {
-	test_table_refs_for(1);
+	t_table_refs_for(1);
 }
 
-static void test_write_empty_table(void)
+static void t_write_empty_table(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-	struct reftable_block_source source = { NULL };
+	struct reftable_block_source source = { 0 };
 	struct reftable_reader *rd = NULL;
-	struct reftable_ref_record rec = { NULL };
-	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
 	int err;
 
 	reftable_writer_set_limits(w, 1, 1);
 
 	err = reftable_writer_close(w);
-	EXPECT(err == REFTABLE_EMPTY_TABLE_ERROR);
+	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
 
-	EXPECT(buf.len == header_size(1) + footer_size(1));
+	check_int(buf.len, ==, header_size(1) + footer_size(1));
 
 	block_source_from_strbuf(&source, &buf);
 
 	err = reftable_new_reader(&rd, &source, "filename");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_reader_init_ref_iterator(rd, &it);
 	err = reftable_iterator_seek_ref(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 
 	err = reftable_iterator_next_ref(&it, &rec);
-	EXPECT(err > 0);
+	check_int(err, >, 0);
 
 	reftable_iterator_destroy(&it);
 	reftable_reader_free(rd);
 	strbuf_release(&buf);
 }
 
-static void test_write_object_id_min_length(void)
+static void t_write_object_id_min_length(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 75,
@@ -686,17 +685,17 @@ static void test_write_object_id_min_length(void)
 		snprintf(name, sizeof(name), "ref%05d", i);
 		ref.refname = name;
 		err = reftable_writer_add_ref(w, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_writer_close(w);
-	EXPECT_ERR(err);
-	EXPECT(reftable_writer_stats(w)->object_id_len == 2);
+	check(!err);
+	check_int(reftable_writer_stats(w)->object_id_len, ==, 2);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
 
-static void test_write_object_id_length(void)
+static void t_write_object_id_length(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 75,
@@ -722,17 +721,17 @@ static void test_write_object_id_length(void)
 		ref.refname = name;
 		ref.value.val1[15] = i;
 		err = reftable_writer_add_ref(w, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	err = reftable_writer_close(w);
-	EXPECT_ERR(err);
-	EXPECT(reftable_writer_stats(w)->object_id_len == 16);
+	check(!err);
+	check_int(reftable_writer_stats(w)->object_id_len, ==, 16);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
 
-static void test_write_empty_key(void)
+static void t_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
@@ -747,15 +746,15 @@ static void test_write_empty_key(void)
 
 	reftable_writer_set_limits(w, 1, 1);
 	err = reftable_writer_add_ref(w, &ref);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 
 	err = reftable_writer_close(w);
-	EXPECT(err == REFTABLE_EMPTY_TABLE_ERROR);
+	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
 
-static void test_write_key_order(void)
+static void t_write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
@@ -782,15 +781,15 @@ static void test_write_key_order(void)
 
 	reftable_writer_set_limits(w, 1, 1);
 	err = reftable_writer_add_ref(w, &refs[0]);
-	EXPECT_ERR(err);
+	check(!err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	EXPECT(err == REFTABLE_API_ERROR);
+	check_int(err, ==, REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
 	strbuf_release(&buf);
 }
 
-static void test_write_multiple_indices(void)
+static void t_write_multiple_indices(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 100,
@@ -817,7 +816,7 @@ static void test_write_multiple_indices(void)
 		ref.refname = buf.buf,
 
 		err = reftable_writer_add_ref(writer, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	for (i = 0; i < 100; i++) {
@@ -835,7 +834,7 @@ static void test_write_multiple_indices(void)
 		log.refname = buf.buf,
 
 		err = reftable_writer_add_log(writer, &log);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 
 	reftable_writer_close(writer);
@@ -845,13 +844,13 @@ static void test_write_multiple_indices(void)
 	 * for each of the block types.
 	 */
 	stats = reftable_writer_stats(writer);
-	EXPECT(stats->ref_stats.index_offset > 0);
-	EXPECT(stats->obj_stats.index_offset > 0);
-	EXPECT(stats->log_stats.index_offset > 0);
+	check_int(stats->ref_stats.index_offset, >, 0);
+	check_int(stats->obj_stats.index_offset, >, 0);
+	check_int(stats->log_stats.index_offset, >, 0);
 
 	block_source_from_strbuf(&source, &writer_buf);
 	err = reftable_new_reader(&reader, &source, "filename");
-	EXPECT_ERR(err);
+	check(!err);
 
 	/*
 	 * Seeking the log uses the log index now. In case there is any
@@ -859,7 +858,7 @@ static void test_write_multiple_indices(void)
 	 */
 	reftable_reader_init_log_iterator(reader, &it);
 	err = reftable_iterator_seek_log(&it, "");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
@@ -868,7 +867,7 @@ static void test_write_multiple_indices(void)
 	strbuf_release(&buf);
 }
 
-static void test_write_multi_level_index(void)
+static void t_write_multi_level_index(void)
 {
 	struct reftable_write_options opts = {
 		.block_size = 100,
@@ -895,7 +894,7 @@ static void test_write_multi_level_index(void)
 		ref.refname = buf.buf,
 
 		err = reftable_writer_add_ref(writer, &ref);
-		EXPECT_ERR(err);
+		check(!err);
 	}
 	reftable_writer_close(writer);
 
@@ -904,18 +903,18 @@ static void test_write_multi_level_index(void)
 	 * multi-level index.
 	 */
 	stats = reftable_writer_stats(writer);
-	EXPECT(stats->ref_stats.max_index_level == 2);
+	check_int(stats->ref_stats.max_index_level, ==, 2);
 
 	block_source_from_strbuf(&source, &writer_buf);
 	err = reftable_new_reader(&reader, &source, "filename");
-	EXPECT_ERR(err);
+	check(!err);
 
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
 	reftable_reader_init_ref_iterator(reader, &it);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
-	EXPECT_ERR(err);
+	check(!err);
 
 	reftable_iterator_destroy(&it);
 	reftable_writer_free(writer);
@@ -924,56 +923,57 @@ static void test_write_multi_level_index(void)
 	strbuf_release(&buf);
 }
 
-static void test_corrupt_table_empty(void)
+static void t_corrupt_table_empty(void)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_block_source source = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader rd = { 0 };
 	int err;
 
 	block_source_from_strbuf(&source, &buf);
 	err = init_reader(&rd, &source, "file.log");
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 }
 
-static void test_corrupt_table(void)
+static void t_corrupt_table(void)
 {
 	uint8_t zeros[1024] = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_block_source source = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader rd = { 0 };
 	int err;
 	strbuf_add(&buf, zeros, sizeof(zeros));
 
 	block_source_from_strbuf(&source, &buf);
 	err = init_reader(&rd, &source, "file.log");
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 	strbuf_release(&buf);
 }
 
-int readwrite_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_log_zlib_corruption);
-	RUN_TEST(test_corrupt_table);
-	RUN_TEST(test_corrupt_table_empty);
-	RUN_TEST(test_log_write_read);
-	RUN_TEST(test_write_key_order);
-	RUN_TEST(test_table_read_write_seek_linear_sha256);
-	RUN_TEST(test_log_buffer_size);
-	RUN_TEST(test_table_write_small_table);
-	RUN_TEST(test_buffer);
-	RUN_TEST(test_table_read_api);
-	RUN_TEST(test_table_read_write_sequential);
-	RUN_TEST(test_table_read_write_seek_linear);
-	RUN_TEST(test_table_read_write_seek_index);
-	RUN_TEST(test_table_refs_for_no_index);
-	RUN_TEST(test_table_refs_for_obj_index);
-	RUN_TEST(test_write_empty_key);
-	RUN_TEST(test_write_empty_table);
-	RUN_TEST(test_log_overflow);
-	RUN_TEST(test_write_object_id_length);
-	RUN_TEST(test_write_object_id_min_length);
-	RUN_TEST(test_write_multiple_indices);
-	RUN_TEST(test_write_multi_level_index);
-	return 0;
+	TEST(t_buffer(), "strbuf works as blocksource");
+	TEST(t_corrupt_table(), "read-write on corrupted table");
+	TEST(t_corrupt_table_empty(), "read-write on an empty table");
+	TEST(t_log_buffer_size(), "buffer extension for log compression");
+	TEST(t_log_overflow(), "log overflow returns expected error");
+	TEST(t_log_write_read(), "read-write on log records");
+	TEST(t_log_zlib_corruption(), "reading corrupted log record returns expected error");
+	TEST(t_table_read_api(), "read on a table");
+	TEST(t_table_read_write_seek_index(), "read-write on a table with index");
+	TEST(t_table_read_write_seek_linear(), "read-write on a table without index (SHA1)");
+	TEST(t_table_read_write_seek_linear_sha256(), "read-write on a table without index (SHA256)");
+	TEST(t_table_read_write_sequential(), "sequential read-write on a table");
+	TEST(t_table_refs_for_no_index(), "refs-only table with no index");
+	TEST(t_table_refs_for_obj_index(), "refs-only table with index");
+	TEST(t_table_write_small_table(), "write_table works");
+	TEST(t_write_empty_key(), "write on refs with empty keys");
+	TEST(t_write_empty_table(), "read-write on empty tables");
+	TEST(t_write_key_order(), "refs must be written in increasing order");
+	TEST(t_write_multi_level_index(), "table with multi-level index");
+	TEST(t_write_multiple_indices(), "table with indices for multiple block types");
+	TEST(t_write_object_id_length(), "prefix compression on writing refs");
+	TEST(t_write_object_id_min_length(), "prefix compression on writing refs");
+
+	return test_done();
 }
-- 
2.45.GIT

