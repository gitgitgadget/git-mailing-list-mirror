Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C861C695
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780111; cv=none; b=imRhotagraavcWAk7yvKLYYKkf54PudrDj66Q1gNLCO/5AQQAt93UpPdThnLQmj+KRPr32Zzajs8CWTBoy5r8DxwFkuGoRjrqiiGBhqeMV1LZyuElqDNwqnfOyzTUWj7OfOP7Z5ZWnxjCX/N0s9IYsOt8GAlyxqVOpnQlose9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780111; c=relaxed/simple;
	bh=9h+5XH3rG9Oq/YW4wA/vEaLrONKGauk0RlCysneQnh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx9p/oi5rNQdTumE12wLW67AQGbpZAoC8Z9p3HTEWe+N3G/XbWPhJ+OoQvVFCX0FI+CXOkApe66W5ah+XkoU+e8lebiRHhX22hUb7NQPoSVBkM8xSG8RDuXG/tqigf+pq9I4Kwxl204fdoaPqaQlf/ojqafcZlxp0bnwm1qfsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwzGgjgr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwzGgjgr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso4696054f8f.0
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780105; x=1746384905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llku+B4mQyVGPqTC4ld5PirXghmnoMjhAJ2B/5A5AKM=;
        b=dwzGgjgr4mrbg061RuL6vSInG351gtz7gCaTaCZCulRSXozEh7/I+CSpqcqGH1LDVF
         o0rSgTNjIigFvzvzaj6PIjR9SNvgHOaWnC9aD7j8nKjS6nEX5W/gy8dBlwGFtZKSdzqD
         NVUtCkl12IeIVWIXlP0J/+bPB7iKXWO6qE7YWbU66/bQsu0LgouvWKGl2vJN+eqVjSy8
         TPXkVNiRHojySUPd4M0dx8hzpbFpNdtD9bVh+LI9gXUTe5oIhr3kawmyTxBWs6y8yn4I
         3CNFzTmHNg/SXKZhVvdP0ly/te4hFTw5iXnDXPlY3IWwpcHyMajq4oOs+nERcYYqaPVp
         ovbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780105; x=1746384905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llku+B4mQyVGPqTC4ld5PirXghmnoMjhAJ2B/5A5AKM=;
        b=LEdIHgo5AojLWJYnmLiIAjN5H+52m81lkYRP4KcyCLpmGrOVTK2KTTIw0p0phUn5cn
         7RWNZLoFvvd7QzFh+VA6PFomlNMoNO1WlmA98XhiMmpjhlaEZ0Ci7w+1geczVHeAp4LX
         NIe8JyH4kbx8diEwzo2sSP15W8R5mTtu+J79Amid6WRRo+2aRrZik4LQbG/lKi9jDFlw
         Q7qPvkKEUsjTG0nXufVw8W+lmZXAtcM70ujbk3xxFK7M+DV6vWKKuLaEE3gTf7ffwMn+
         z0ZB0AS6FwHJ/FRu0cAQ9I99ht+gM4ZUoOuUMWAouqIyyup7O6ZiRhm4pR0gjXuUeI/I
         ARkA==
X-Gm-Message-State: AOJu0Yx27WuEu5rlObfpCt+eL29VpjzmlUlgsHRFIZXsJIw/3yJ6NS1h
	+ngvvTdWKGKBeizVA+ry8m0hISUb5D1D58pxplNseT9nbXAKTQeZV2xFFw51CHNxug==
X-Gm-Gg: ASbGncv8l6ueH4OapVm9lcum4nHsY+zObEN6dvXzPbmYrHtMwLSmQsDCOoZjqnaGebA
	fSrVB+osd4of+Jk4oviHpEnZpLtsFwGnRc9MASi6w+0cC/haxJDBmTfHUmVrxVZKzA6l6qUEa5P
	6yshQdfsDbldTuZ+qFsWjkDjkXW+wWQCoh5ijx+I6gie9z5l7nx2+Y9GYbAK2Y5u9TyhF1rdi5c
	rtRQqxTNK+mZAYSJiq/Nza8OoDm8EVu9RZozcPe8c4Y/3IZct8vZB3oWeOW1fxHf8f409QVjms1
	aAIyxhbfu3FZJKC7vxLy53dc3ps8EyaU6ZhV
X-Google-Smtp-Source: AGHT+IEJKmNh3z9NEmoBv5U5PCORlL+64VzRIz83x8rmj5VJzA3pxmBY4V7UC8PvOdSGid1X9OA9DA==
X-Received: by 2002:a05:6000:186c:b0:399:737f:4e02 with SMTP id ffacd0b85a97d-3a074f2ee55mr6896762f8f.39.1745780104354;
        Sun, 27 Apr 2025 11:55:04 -0700 (PDT)
Received: from localhost.localdomain ([105.113.116.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm9150175f8f.11.2025.04.27.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 11:55:03 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 7/9] t/unit-tests: convert reftable readwrite test to use clar
Date: Sun, 27 Apr 2025 19:53:49 +0100
Message-ID: <20250427185351.82520-8-kuforiji98@gmail.com>
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

Adapt reftable readwrite test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                            |   2 +-
 t/meson.build                       |   2 +-
 t/unit-tests/t-reftable-readwrite.c | 985 ----------------------------
 t/unit-tests/u-reftable-readwrite.c | 870 ++++++++++++++++++++++++
 4 files changed, 872 insertions(+), 987 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-readwrite.c
 create mode 100644 t/unit-tests/u-reftable-readwrite.c

diff --git a/Makefile b/Makefile
index 948eff1c5c..7511959baf 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,6 +1367,7 @@ CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-reader
+CLAR_TEST_SUITES += u-reftable-readwrite
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1380,7 +1381,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
diff --git a/t/meson.build b/t/meson.build
index 43d52c4753..b9e9648f7c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -13,6 +13,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-pq.c',
   'unit-tests/u-reftable-reader.c',
+  'unit-tests/u-reftable-readwrite.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -60,7 +61,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
 ]
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
deleted file mode 100644
index c9626831da..0000000000
--- a/t/unit-tests/t-reftable-readwrite.c
+++ /dev/null
@@ -1,985 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
-#include "test-lib.h"
-#include "lib-reftable.h"
-#include "reftable/basics.h"
-#include "reftable/blocksource.h"
-#include "reftable/reader.h"
-#include "reftable/reftable-error.h"
-#include "reftable/reftable-writer.h"
-#include "strbuf.h"
-
-static const int update_index = 5;
-
-static void t_buffer(void)
-{
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_block_source source = { 0 };
-	struct reftable_block out = { 0 };
-	int n;
-	uint8_t in[] = "hello";
-	check(!reftable_buf_add(&buf, in, sizeof(in)));
-	block_source_from_buf(&source, &buf);
-	check_int(block_source_size(&source), ==, 6);
-	n = block_source_read_block(&source, &out, 0, sizeof(in));
-	check_int(n, ==, sizeof(in));
-	check(!memcmp(in, out.data, n));
-	reftable_block_done(&out);
-
-	n = block_source_read_block(&source, &out, 1, 2);
-	check_int(n, ==, 2);
-	check(!memcmp(out.data, "el", 2));
-
-	reftable_block_done(&out);
-	block_source_close(&source);
-	reftable_buf_release(&buf);
-}
-
-static void write_table(char ***names, struct reftable_buf *buf, int N,
-			int block_size, enum reftable_hash hash_id)
-{
-	struct reftable_write_options opts = {
-		.block_size = block_size,
-		.hash_id = hash_id,
-	};
-	struct reftable_ref_record *refs;
-	struct reftable_log_record *logs;
-	int i;
-
-	REFTABLE_CALLOC_ARRAY(*names, N + 1);
-	check(*names != NULL);
-	REFTABLE_CALLOC_ARRAY(refs, N);
-	check(refs != NULL);
-	REFTABLE_CALLOC_ARRAY(logs, N);
-	check(logs != NULL);
-
-	for (i = 0; i < N; i++) {
-		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
-		refs[i].update_index = update_index;
-		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
-	}
-
-	for (i = 0; i < N; i++) {
-		logs[i].refname = (*names)[i];
-		logs[i].update_index = update_index;
-		logs[i].value_type = REFTABLE_LOG_UPDATE;
-		t_reftable_set_hash(logs[i].value.update.new_hash, i,
-				    REFTABLE_HASH_SHA1);
-		logs[i].value.update.message = (char *) "message";
-	}
-
-	t_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
-
-	reftable_free(refs);
-	reftable_free(logs);
-}
-
-static void t_log_buffer_size(void)
-{
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_write_options opts = {
-		.block_size = 4096,
-	};
-	int err;
-	int i;
-	struct reftable_log_record
-		log = { .refname = (char *) "refs/heads/master",
-			.update_index = update_index,
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value = { .update = {
-					   .name = (char *) "Han-Wen Nienhuys",
-					   .email = (char *) "hanwen@google.com",
-					   .tz_offset = 100,
-					   .time = 0x5e430672,
-					   .message = (char *) "commit: 9\n",
-				   } } };
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-
-	/* This tests buffer extension for log compression. Must use a random
-	   hash, to ensure that the compressed part is larger than the original.
-	*/
-	for (i = 0; i < REFTABLE_HASH_SIZE_SHA1; i++) {
-		log.value.update.old_hash[i] = (uint8_t)(git_rand(0) % 256);
-		log.value.update.new_hash[i] = (uint8_t)(git_rand(0) % 256);
-	}
-	reftable_writer_set_limits(w, update_index, update_index);
-	err = reftable_writer_add_log(w, &log);
-	check(!err);
-	err = reftable_writer_close(w);
-	check(!err);
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_log_overflow(void)
-{
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	char msg[256] = { 0 };
-	struct reftable_write_options opts = {
-		.block_size = ARRAY_SIZE(msg),
-	};
-	int err;
-	struct reftable_log_record log = {
-		.refname = (char *) "refs/heads/master",
-		.update_index = update_index,
-		.value_type = REFTABLE_LOG_UPDATE,
-		.value = {
-			.update = {
-				.old_hash = { 1 },
-				.new_hash = { 2 },
-				.name = (char *) "Han-Wen Nienhuys",
-				.email = (char *) "hanwen@google.com",
-				.tz_offset = 100,
-				.time = 0x5e430672,
-				.message = msg,
-			},
-		},
-	};
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-
-	memset(msg, 'x', sizeof(msg) - 1);
-	reftable_writer_set_limits(w, update_index, update_index);
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, REFTABLE_ENTRY_TOO_BIG_ERROR);
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_log_write_limits(void)
-{
-	struct reftable_write_options opts = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_log_record log = {
-		.refname = (char *)"refs/head/master",
-		.update_index = 0,
-		.value_type = REFTABLE_LOG_UPDATE,
-		.value = {
-			.update = {
-				.old_hash = { 1 },
-				.new_hash = { 2 },
-				.name = (char *)"Han-Wen Nienhuys",
-				.email = (char *)"hanwen@google.com",
-				.tz_offset = 100,
-				.time = 0x5e430672,
-			},
-		},
-	};
-	int err;
-
-	reftable_writer_set_limits(w, 1, 1);
-
-	/* write with update_index (0) below set limits (1, 1) */
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, 0);
-
-	/* write with update_index (1) in the set limits (1, 1) */
-	log.update_index = 1;
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, 0);
-
-	/* write with update_index (3) above set limits (1, 1) */
-	log.update_index = 3;
-	err = reftable_writer_add_log(w, &log);
-	check_int(err, ==, REFTABLE_API_ERROR);
-
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_log_write_read(void)
-{
-	struct reftable_write_options opts = {
-		.block_size = 256,
-	};
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_log_record log = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_block_source source = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	const struct reftable_stats *stats = NULL;
-	int N = 2, err, i, n;
-	char **names;
-
-	names = reftable_calloc(N + 1, sizeof(*names));
-	check(names != NULL);
-
-	reftable_writer_set_limits(w, 0, N);
-
-	for (i = 0; i < N; i++) {
-		char name[256];
-		struct reftable_ref_record ref = { 0 };
-		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
-		names[i] = xstrdup(name);
-		ref.refname = name;
-		ref.update_index = i;
-
-		err = reftable_writer_add_ref(w, &ref);
-		check(!err);
-	}
-
-	for (i = 0; i < N; i++) {
-		struct reftable_log_record log = { 0 };
-
-		log.refname = names[i];
-		log.update_index = i;
-		log.value_type = REFTABLE_LOG_UPDATE;
-		t_reftable_set_hash(log.value.update.old_hash, i,
-				    REFTABLE_HASH_SHA1);
-		t_reftable_set_hash(log.value.update.new_hash, i + 1,
-				    REFTABLE_HASH_SHA1);
-
-		err = reftable_writer_add_log(w, &log);
-		check(!err);
-	}
-
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
-
-	stats = reftable_writer_stats(w);
-	check_int(stats->log_stats.blocks, >, 0);
-	reftable_writer_free(w);
-	w = NULL;
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&reader, &source, "file.log");
-	check(!err);
-
-	err = reftable_reader_init_ref_iterator(reader, &it);
-	check(!err);
-
-	err = reftable_iterator_seek_ref(&it, names[N - 1]);
-	check(!err);
-
-	err = reftable_iterator_next_ref(&it, &ref);
-	check(!err);
-
-	/* end of iteration. */
-	err = reftable_iterator_next_ref(&it, &ref);
-	check_int(err, >, 0);
-
-	reftable_iterator_destroy(&it);
-	reftable_ref_record_release(&ref);
-
-	err = reftable_reader_init_log_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_log(&it, "");
-	check(!err);
-
-	for (i = 0; ; i++) {
-		int err = reftable_iterator_next_log(&it, &log);
-		if (err > 0)
-			break;
-		check(!err);
-		check_str(names[i], log.refname);
-		check_int(i, ==, log.update_index);
-		reftable_log_record_release(&log);
-	}
-
-	check_int(i, ==, N);
-	reftable_iterator_destroy(&it);
-
-	/* cleanup. */
-	reftable_buf_release(&buf);
-	free_names(names);
-	reftable_reader_decref(reader);
-}
-
-static void t_log_zlib_corruption(void)
-{
-	struct reftable_write_options opts = {
-		.block_size = 256,
-	};
-	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_block_source source = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	const struct reftable_stats *stats = NULL;
-	char message[100] = { 0 };
-	int err, i, n;
-	struct reftable_log_record log = {
-		.refname = (char *) "refname",
-		.value_type = REFTABLE_LOG_UPDATE,
-		.value = {
-			.update = {
-				.new_hash = { 1 },
-				.old_hash = { 2 },
-				.name = (char *) "My Name",
-				.email = (char *) "myname@invalid",
-				.message = message,
-			},
-		},
-	};
-
-	for (i = 0; i < sizeof(message) - 1; i++)
-		message[i] = (uint8_t)(git_rand(0) % 64 + ' ');
-
-	reftable_writer_set_limits(w, 1, 1);
-
-	err = reftable_writer_add_log(w, &log);
-	check(!err);
-
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
-
-	stats = reftable_writer_stats(w);
-	check_int(stats->log_stats.blocks, >, 0);
-	reftable_writer_free(w);
-	w = NULL;
-
-	/* corrupt the data. */
-	buf.buf[50] ^= 0x99;
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&reader, &source, "file.log");
-	check(!err);
-
-	err = reftable_reader_init_log_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_log(&it, "refname");
-	check_int(err, ==, REFTABLE_ZLIB_ERROR);
-
-	reftable_iterator_destroy(&it);
-
-	/* cleanup. */
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-}
-
-static void t_table_read_write_sequential(void)
-{
-	char **names;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int N = 50;
-	struct reftable_iterator it = { 0 };
-	struct reftable_block_source source = { 0 };
-	struct reftable_reader *reader;
-	int err = 0;
-	int j = 0;
-
-	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&reader, &source, "file.ref");
-	check(!err);
-
-	err = reftable_reader_init_ref_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
-
-	for (j = 0; ; j++) {
-		struct reftable_ref_record ref = { 0 };
-		int r = reftable_iterator_next_ref(&it, &ref);
-		check_int(r, >=, 0);
-		if (r > 0)
-			break;
-		check_str(names[j], ref.refname);
-		check_int(update_index, ==, ref.update_index);
-		reftable_ref_record_release(&ref);
-	}
-	check_int(j, ==, N);
-
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-	free_names(names);
-}
-
-static void t_table_write_small_table(void)
-{
-	char **names;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int N = 1;
-	write_table(&names, &buf, N, 4096, REFTABLE_HASH_SHA1);
-	check_int(buf.len, <, 200);
-	reftable_buf_release(&buf);
-	free_names(names);
-}
-
-static void t_table_read_api(void)
-{
-	char **names;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int N = 50;
-	struct reftable_reader *reader;
-	struct reftable_block_source source = { 0 };
-	int err;
-	struct reftable_log_record log = { 0 };
-	struct reftable_iterator it = { 0 };
-
-	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&reader, &source, "file.ref");
-	check(!err);
-
-	err = reftable_reader_init_ref_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, names[0]);
-	check(!err);
-
-	err = reftable_iterator_next_log(&it, &log);
-	check_int(err, ==, REFTABLE_API_ERROR);
-
-	reftable_buf_release(&buf);
-	free_names(names);
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-}
-
-static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
-{
-	char **names;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int N = 50;
-	struct reftable_reader *reader;
-	struct reftable_block_source source = { 0 };
-	int err;
-	int i = 0;
-
-	struct reftable_iterator it = { 0 };
-	struct reftable_buf pastLast = REFTABLE_BUF_INIT;
-	struct reftable_ref_record ref = { 0 };
-
-	write_table(&names, &buf, N, 256, hash_id);
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&reader, &source, "file.ref");
-	check(!err);
-	check_int(hash_id, ==, reftable_reader_hash_id(reader));
-
-	if (!index) {
-		reader->ref_offsets.index_offset = 0;
-	} else {
-		check_int(reader->ref_offsets.index_offset, >, 0);
-	}
-
-	for (i = 1; i < N; i++) {
-		err = reftable_reader_init_ref_iterator(reader, &it);
-		check(!err);
-		err = reftable_iterator_seek_ref(&it, names[i]);
-		check(!err);
-		err = reftable_iterator_next_ref(&it, &ref);
-		check(!err);
-		check_str(names[i], ref.refname);
-		check_int(REFTABLE_REF_VAL1, ==, ref.value_type);
-		check_int(i, ==, ref.value.val1[0]);
-
-		reftable_ref_record_release(&ref);
-		reftable_iterator_destroy(&it);
-	}
-
-	check(!reftable_buf_addstr(&pastLast, names[N - 1]));
-	check(!reftable_buf_addstr(&pastLast, "/"));
-
-	err = reftable_reader_init_ref_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, pastLast.buf);
-	if (err == 0) {
-		struct reftable_ref_record ref = { 0 };
-		int err = reftable_iterator_next_ref(&it, &ref);
-		check_int(err, >, 0);
-	} else {
-		check_int(err, >, 0);
-	}
-
-	reftable_buf_release(&pastLast);
-	reftable_iterator_destroy(&it);
-
-	reftable_buf_release(&buf);
-	free_names(names);
-	reftable_reader_decref(reader);
-}
-
-static void t_table_read_write_seek_linear(void)
-{
-	t_table_read_write_seek(0, REFTABLE_HASH_SHA1);
-}
-
-static void t_table_read_write_seek_linear_sha256(void)
-{
-	t_table_read_write_seek(0, REFTABLE_HASH_SHA256);
-}
-
-static void t_table_read_write_seek_index(void)
-{
-	t_table_read_write_seek(1, REFTABLE_HASH_SHA1);
-}
-
-static void t_table_refs_for(int indexed)
-{
-	char **want_names;
-	int want_names_len = 0;
-	uint8_t want_hash[REFTABLE_HASH_SIZE_SHA1];
-
-	struct reftable_write_options opts = {
-		.block_size = 256,
-	};
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_block_source source = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_iterator it = { 0 };
-	int N = 50, n, j, err, i;
-
-	want_names = reftable_calloc(N + 1, sizeof(*want_names));
-	check(want_names != NULL);
-
-	t_reftable_set_hash(want_hash, 4, REFTABLE_HASH_SHA1);
-
-	for (i = 0; i < N; i++) {
-		uint8_t hash[REFTABLE_HASH_SIZE_SHA1];
-		char fill[51] = { 0 };
-		char name[100];
-		struct reftable_ref_record ref = { 0 };
-
-		memset(hash, i, sizeof(hash));
-		memset(fill, 'x', 50);
-		/* Put the variable part in the start */
-		snprintf(name, sizeof(name), "br%02d%s", i, fill);
-		name[40] = 0;
-		ref.refname = name;
-
-		ref.value_type = REFTABLE_REF_VAL2;
-		t_reftable_set_hash(ref.value.val2.value, i / 4,
-				    REFTABLE_HASH_SHA1);
-		t_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
-				    REFTABLE_HASH_SHA1);
-
-		/* 80 bytes / entry, so 3 entries per block. Yields 17
-		 */
-		/* blocks. */
-		n = reftable_writer_add_ref(w, &ref);
-		check_int(n, ==, 0);
-
-		if (!memcmp(ref.value.val2.value, want_hash, REFTABLE_HASH_SIZE_SHA1) ||
-		    !memcmp(ref.value.val2.target_value, want_hash, REFTABLE_HASH_SIZE_SHA1))
-			want_names[want_names_len++] = xstrdup(name);
-	}
-
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
-
-	reftable_writer_free(w);
-	w = NULL;
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&reader, &source, "file.ref");
-	check(!err);
-	if (!indexed)
-		reader->obj_offsets.is_present = 0;
-
-	err = reftable_reader_init_ref_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
-	reftable_iterator_destroy(&it);
-
-	err = reftable_reader_refs_for(reader, &it, want_hash);
-	check(!err);
-
-	for (j = 0; ; j++) {
-		int err = reftable_iterator_next_ref(&it, &ref);
-		check_int(err, >=, 0);
-		if (err > 0)
-			break;
-		check_int(j, <, want_names_len);
-		check_str(ref.refname, want_names[j]);
-		reftable_ref_record_release(&ref);
-	}
-	check_int(j, ==, want_names_len);
-
-	reftable_buf_release(&buf);
-	free_names(want_names);
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-}
-
-static void t_table_refs_for_no_index(void)
-{
-	t_table_refs_for(0);
-}
-
-static void t_table_refs_for_obj_index(void)
-{
-	t_table_refs_for(1);
-}
-
-static void t_write_empty_table(void)
-{
-	struct reftable_write_options opts = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_block_source source = { 0 };
-	struct reftable_reader *rd = NULL;
-	struct reftable_ref_record rec = { 0 };
-	struct reftable_iterator it = { 0 };
-	int err;
-
-	reftable_writer_set_limits(w, 1, 1);
-
-	err = reftable_writer_close(w);
-	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
-	reftable_writer_free(w);
-
-	check_uint(buf.len, ==, header_size(1) + footer_size(1));
-
-	block_source_from_buf(&source, &buf);
-
-	err = reftable_reader_new(&rd, &source, "filename");
-	check(!err);
-
-	err = reftable_reader_init_ref_iterator(rd, &it);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, "");
-	check(!err);
-
-	err = reftable_iterator_next_ref(&it, &rec);
-	check_int(err, >, 0);
-
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(rd);
-	reftable_buf_release(&buf);
-}
-
-static void t_write_object_id_min_length(void)
-{
-	struct reftable_write_options opts = {
-		.block_size = 75,
-	};
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_ref_record ref = {
-		.update_index = 1,
-		.value_type = REFTABLE_REF_VAL1,
-		.value.val1 = {42},
-	};
-	int err;
-	int i;
-
-	reftable_writer_set_limits(w, 1, 1);
-
-	/* Write the same hash in many refs. If there is only 1 hash, the
-	 * disambiguating prefix is length 0 */
-	for (i = 0; i < 256; i++) {
-		char name[256];
-		snprintf(name, sizeof(name), "ref%05d", i);
-		ref.refname = name;
-		err = reftable_writer_add_ref(w, &ref);
-		check(!err);
-	}
-
-	err = reftable_writer_close(w);
-	check(!err);
-	check_int(reftable_writer_stats(w)->object_id_len, ==, 2);
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_write_object_id_length(void)
-{
-	struct reftable_write_options opts = {
-		.block_size = 75,
-	};
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_ref_record ref = {
-		.update_index = 1,
-		.value_type = REFTABLE_REF_VAL1,
-		.value.val1 = {42},
-	};
-	int err;
-	int i;
-
-	reftable_writer_set_limits(w, 1, 1);
-
-	/* Write the same hash in many refs. If there is only 1 hash, the
-	 * disambiguating prefix is length 0 */
-	for (i = 0; i < 256; i++) {
-		char name[256];
-		snprintf(name, sizeof(name), "ref%05d", i);
-		ref.refname = name;
-		ref.value.val1[15] = i;
-		err = reftable_writer_add_ref(w, &ref);
-		check(!err);
-	}
-
-	err = reftable_writer_close(w);
-	check(!err);
-	check_int(reftable_writer_stats(w)->object_id_len, ==, 16);
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_write_empty_key(void)
-{
-	struct reftable_write_options opts = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_ref_record ref = {
-		.refname = (char *) "",
-		.update_index = 1,
-		.value_type = REFTABLE_REF_DELETION,
-	};
-	int err;
-
-	reftable_writer_set_limits(w, 1, 1);
-	err = reftable_writer_add_ref(w, &ref);
-	check_int(err, ==, REFTABLE_API_ERROR);
-
-	err = reftable_writer_close(w);
-	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_write_key_order(void)
-{
-	struct reftable_write_options opts = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
-	struct reftable_ref_record refs[2] = {
-		{
-			.refname = (char *) "b",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_SYMREF,
-			.value = {
-				.symref = (char *) "target",
-			},
-		}, {
-			.refname = (char *) "a",
-			.update_index = 1,
-			.value_type = REFTABLE_REF_SYMREF,
-			.value = {
-				.symref = (char *) "target",
-			},
-		}
-	};
-	int err;
-
-	reftable_writer_set_limits(w, 1, 1);
-	err = reftable_writer_add_ref(w, &refs[0]);
-	check(!err);
-	err = reftable_writer_add_ref(w, &refs[1]);
-	check_int(err, ==, REFTABLE_API_ERROR);
-
-	refs[0].update_index = 2;
-	err = reftable_writer_add_ref(w, &refs[0]);
-	check_int(err, ==, REFTABLE_API_ERROR);
-
-	reftable_writer_close(w);
-	reftable_writer_free(w);
-	reftable_buf_release(&buf);
-}
-
-static void t_write_multiple_indices(void)
-{
-	struct reftable_write_options opts = {
-		.block_size = 100,
-	};
-	struct reftable_buf writer_buf = REFTABLE_BUF_INIT;
-	struct reftable_block_source source = { 0 };
-	struct reftable_iterator it = { 0 };
-	const struct reftable_stats *stats;
-	struct reftable_writer *writer;
-	struct reftable_reader *reader;
-	char buf[128];
-	int err, i;
-
-	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
-	reftable_writer_set_limits(writer, 1, 1);
-	for (i = 0; i < 100; i++) {
-		struct reftable_ref_record ref = {
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = {i},
-		};
-
-		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
-		ref.refname = buf;
-
-		err = reftable_writer_add_ref(writer, &ref);
-		check(!err);
-	}
-
-	for (i = 0; i < 100; i++) {
-		struct reftable_log_record log = {
-			.update_index = 1,
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value.update = {
-				.old_hash = { i },
-				.new_hash = { i },
-			},
-		};
-
-		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
-		log.refname = buf;
-
-		err = reftable_writer_add_log(writer, &log);
-		check(!err);
-	}
-
-	reftable_writer_close(writer);
-
-	/*
-	 * The written data should be sufficiently large to result in indices
-	 * for each of the block types.
-	 */
-	stats = reftable_writer_stats(writer);
-	check_int(stats->ref_stats.index_offset, >, 0);
-	check_int(stats->obj_stats.index_offset, >, 0);
-	check_int(stats->log_stats.index_offset, >, 0);
-
-	block_source_from_buf(&source, &writer_buf);
-	err = reftable_reader_new(&reader, &source, "filename");
-	check(!err);
-
-	/*
-	 * Seeking the log uses the log index now. In case there is any
-	 * confusion regarding indices we would notice here.
-	 */
-	err = reftable_reader_init_log_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_log(&it, "");
-	check(!err);
-
-	reftable_iterator_destroy(&it);
-	reftable_writer_free(writer);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&writer_buf);
-}
-
-static void t_write_multi_level_index(void)
-{
-	struct reftable_write_options opts = {
-		.block_size = 100,
-	};
-	struct reftable_buf writer_buf = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
-	struct reftable_block_source source = { 0 };
-	struct reftable_iterator it = { 0 };
-	const struct reftable_stats *stats;
-	struct reftable_writer *writer;
-	struct reftable_reader *reader;
-	int err;
-
-	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
-	reftable_writer_set_limits(writer, 1, 1);
-	for (size_t i = 0; i < 200; i++) {
-		struct reftable_ref_record ref = {
-			.update_index = 1,
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = {i},
-		};
-		char buf[128];
-
-		snprintf(buf, sizeof(buf), "refs/heads/%03" PRIuMAX, (uintmax_t)i);
-		ref.refname = buf;
-
-		err = reftable_writer_add_ref(writer, &ref);
-		check(!err);
-	}
-	reftable_writer_close(writer);
-
-	/*
-	 * The written refs should be sufficiently large to result in a
-	 * multi-level index.
-	 */
-	stats = reftable_writer_stats(writer);
-	check_int(stats->ref_stats.max_index_level, ==, 2);
-
-	block_source_from_buf(&source, &writer_buf);
-	err = reftable_reader_new(&reader, &source, "filename");
-	check(!err);
-
-	/*
-	 * Seeking the last ref should work as expected.
-	 */
-	err = reftable_reader_init_ref_iterator(reader, &it);
-	check(!err);
-	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
-	check(!err);
-
-	reftable_iterator_destroy(&it);
-	reftable_writer_free(writer);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&writer_buf);
-	reftable_buf_release(&buf);
-}
-
-static void t_corrupt_table_empty(void)
-{
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_block_source source = { 0 };
-	struct reftable_reader *reader;
-	int err;
-
-	block_source_from_buf(&source, &buf);
-	err = reftable_reader_new(&reader, &source, "file.log");
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-}
-
-static void t_corrupt_table(void)
-{
-	uint8_t zeros[1024] = { 0 };
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	struct reftable_block_source source = { 0 };
-	struct reftable_reader *reader;
-	int err;
-	check(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
-
-	block_source_from_buf(&source, &buf);
-	err = reftable_reader_new(&reader, &source, "file.log");
-	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-
-	reftable_buf_release(&buf);
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_buffer(), "strbuf works as blocksource");
-	TEST(t_corrupt_table(), "read-write on corrupted table");
-	TEST(t_corrupt_table_empty(), "read-write on an empty table");
-	TEST(t_log_buffer_size(), "buffer extension for log compression");
-	TEST(t_log_overflow(), "log overflow returns expected error");
-	TEST(t_log_write_limits(), "writer limits for writing log records");
-	TEST(t_log_write_read(), "read-write on log records");
-	TEST(t_log_zlib_corruption(), "reading corrupted log record returns expected error");
-	TEST(t_table_read_api(), "read on a table");
-	TEST(t_table_read_write_seek_index(), "read-write on a table with index");
-	TEST(t_table_read_write_seek_linear(), "read-write on a table without index (SHA1)");
-	TEST(t_table_read_write_seek_linear_sha256(), "read-write on a table without index (SHA256)");
-	TEST(t_table_read_write_sequential(), "sequential read-write on a table");
-	TEST(t_table_refs_for_no_index(), "refs-only table with no index");
-	TEST(t_table_refs_for_obj_index(), "refs-only table with index");
-	TEST(t_table_write_small_table(), "write_table works");
-	TEST(t_write_empty_key(), "write on refs with empty keys");
-	TEST(t_write_empty_table(), "read-write on empty tables");
-	TEST(t_write_key_order(), "refs must be written in increasing order");
-	TEST(t_write_multi_level_index(), "table with multi-level index");
-	TEST(t_write_multiple_indices(), "table with indices for multiple block types");
-	TEST(t_write_object_id_length(), "prefix compression on writing refs");
-	TEST(t_write_object_id_min_length(), "prefix compression on writing refs");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-readwrite.c b/t/unit-tests/u-reftable-readwrite.c
new file mode 100644
index 0000000000..3d6bdcfceb
--- /dev/null
+++ b/t/unit-tests/u-reftable-readwrite.c
@@ -0,0 +1,870 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "unit-test.h"
+#include "lib-reftable.h"
+#include "reftable/basics.h"
+#include "reftable/blocksource.h"
+#include "reftable/reader.h"
+#include "reftable/reftable-error.h"
+#include "reftable/reftable-writer.h"
+#include "strbuf.h"
+
+static const int update_index = 5;
+
+void test_reftable_readwrite__buffer(void)
+{
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_block_source source = { 0 };
+	struct reftable_block out = { 0 };
+	int n;
+	uint8_t in[] = "hello";
+	cl_assert(reftable_buf_add(&buf, in, sizeof(in)) == 0);
+	block_source_from_buf(&source, &buf);
+	cl_assert_equal_i(block_source_size(&source), 6);
+	n = block_source_read_block(&source, &out, 0, sizeof(in));
+	cl_assert_equal_i(n, sizeof(in));
+	cl_assert(memcmp(in, out.data, n) == 0);
+	reftable_block_done(&out);
+
+	cl_assert_equal_i(block_source_read_block(&source, &out, 1, 2), 2);
+	cl_assert(memcmp(out.data, "el", 2) == 0);
+
+	reftable_block_done(&out);
+	block_source_close(&source);
+	reftable_buf_release(&buf);
+}
+
+static void write_table(char ***names, struct reftable_buf *buf, int N,
+			int block_size, enum reftable_hash hash_id)
+{
+	struct reftable_write_options opts = {
+		.block_size = block_size,
+		.hash_id = hash_id,
+	};
+	struct reftable_ref_record *refs;
+	struct reftable_log_record *logs;
+	int i;
+
+	REFTABLE_CALLOC_ARRAY(*names, N + 1);
+	cl_assert(*names != NULL);
+	REFTABLE_CALLOC_ARRAY(refs, N);
+	cl_assert(refs != NULL);
+	REFTABLE_CALLOC_ARRAY(logs, N);
+	cl_assert(logs != NULL);
+
+	for (i = 0; i < N; i++) {
+		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
+		refs[i].update_index = update_index;
+		refs[i].value_type = REFTABLE_REF_VAL1;
+		cl_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
+	}
+
+	for (i = 0; i < N; i++) {
+		logs[i].refname = (*names)[i];
+		logs[i].update_index = update_index;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
+				    REFTABLE_HASH_SHA1);
+		logs[i].value.update.message = (char *) "message";
+	}
+
+	cl_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
+
+	reftable_free(refs);
+	reftable_free(logs);
+}
+
+void test_reftable_readwrite__log_buffer_size(void)
+{
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_write_options opts = {
+		.block_size = 4096,
+	};
+	int i;
+	struct reftable_log_record
+		log = { .refname = (char *) "refs/heads/master",
+			.update_index = update_index,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = { .update = {
+					   .name = (char *) "Han-Wen Nienhuys",
+					   .email = (char *) "hanwen@google.com",
+					   .tz_offset = 100,
+					   .time = 0x5e430672,
+					   .message = (char *) "commit: 9\n",
+				   } } };
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+
+	/* This tests buffer extension for log compression. Must use a random
+	   hash, to ensure that the compressed part is larger than the original.
+	*/
+	for (i = 0; i < REFTABLE_HASH_SIZE_SHA1; i++) {
+		log.value.update.old_hash[i] = (uint8_t)(git_rand(0) % 256);
+		log.value.update.new_hash[i] = (uint8_t)(git_rand(0) % 256);
+	}
+	reftable_writer_set_limits(w, update_index, update_index);
+	cl_assert(reftable_writer_add_log(w, &log) == 0);
+	cl_assert(reftable_writer_close(w) == 0);
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__log_overflow(void)
+{
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	char msg[256] = { 0 };
+	struct reftable_write_options opts = {
+		.block_size = ARRAY_SIZE(msg),
+	};
+	struct reftable_log_record log = {
+		.refname = (char *) "refs/heads/master",
+		.update_index = update_index,
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.old_hash = { 1 },
+				.new_hash = { 2 },
+				.name = (char *) "Han-Wen Nienhuys",
+				.email = (char *) "hanwen@google.com",
+				.tz_offset = 100,
+				.time = 0x5e430672,
+				.message = msg,
+			},
+		},
+	};
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+
+	memset(msg, 'x', sizeof(msg) - 1);
+	reftable_writer_set_limits(w, update_index, update_index);
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), REFTABLE_ENTRY_TOO_BIG_ERROR);
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__log_write_limits(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_log_record log = {
+		.refname = (char *)"refs/head/master",
+		.update_index = 0,
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.old_hash = { 1 },
+				.new_hash = { 2 },
+				.name = (char *)"Han-Wen Nienhuys",
+				.email = (char *)"hanwen@google.com",
+				.tz_offset = 100,
+				.time = 0x5e430672,
+			},
+		},
+	};
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* write with update_index (0) below set limits (1, 1) */
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
+
+	/* write with update_index (1) in the set limits (1, 1) */
+	log.update_index = 1;
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
+
+	/* write with update_index (3) above set limits (1, 1) */
+	log.update_index = 3;
+	cl_assert_equal_i(reftable_writer_add_log(w, &log), REFTABLE_API_ERROR);
+
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__log_write_read(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_log_record log = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_block_source source = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	int N = 2, i;
+	char **names;
+
+	names = reftable_calloc(N + 1, sizeof(*names));
+	cl_assert(names != NULL);
+
+	reftable_writer_set_limits(w, 0, N);
+
+	for (i = 0; i < N; i++) {
+		char name[256];
+		struct reftable_ref_record ref = { 0 };
+		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
+		names[i] = xstrdup(name);
+		ref.refname = name;
+		ref.update_index = i;
+
+		cl_assert(reftable_writer_add_ref(w, &ref) == 0);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct reftable_log_record log = { 0 };
+
+		log.refname = names[i];
+		log.update_index = i;
+		log.value_type = REFTABLE_LOG_UPDATE;
+		cl_reftable_set_hash(log.value.update.old_hash, i,
+				    REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(log.value.update.new_hash, i + 1,
+				    REFTABLE_HASH_SHA1);
+
+		cl_assert(reftable_writer_add_log(w, &log) == 0);
+	}
+
+	cl_assert_equal_i(reftable_writer_close(w), 0);
+
+	stats = reftable_writer_stats(w);
+	cl_assert(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "file.log") == 0);
+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_ref(&it, names[N - 1]) == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
+
+	/* end of iteration. */
+	cl_assert(reftable_iterator_next_ref(&it, &ref) > 0);
+
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_release(&ref);
+
+	cl_assert(reftable_reader_init_log_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_log(&it, "") == 0);
+
+	for (i = 0; ; i++) {
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err > 0)
+			break;
+		cl_assert(err == 0);
+		cl_assert_equal_s(names[i], log.refname);
+		cl_assert_equal_i(i, log.update_index);
+		reftable_log_record_release(&log);
+	}
+
+	cl_assert_equal_i(i, N);
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	reftable_buf_release(&buf);
+	free_names(names);
+	reftable_reader_decref(reader);
+}
+
+void test_reftable_readwrite__log_zlib_corruption(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_block_source source = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	const struct reftable_stats *stats = NULL;
+	char message[100] = { 0 };
+	int i;
+	struct reftable_log_record log = {
+		.refname = (char *) "refname",
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.new_hash = { 1 },
+				.old_hash = { 2 },
+				.name = (char *) "My Name",
+				.email = (char *) "myname@invalid",
+				.message = message,
+			},
+		},
+	};
+
+	for (i = 0; i < sizeof(message) - 1; i++)
+		message[i] = (uint8_t)(git_rand(0) % 64 + ' ');
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	cl_assert(reftable_writer_add_log(w, &log) == 0);
+	cl_assert_equal_i(reftable_writer_close(w), 0);
+
+	stats = reftable_writer_stats(w);
+	cl_assert(stats->log_stats.blocks > 0);
+	reftable_writer_free(w);
+	w = NULL;
+
+	/* corrupt the data. */
+	buf.buf[50] ^= 0x99;
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "file.log") == 0);
+	cl_assert(reftable_reader_init_log_iterator(reader, &it) == 0);
+	cl_assert_equal_i(reftable_iterator_seek_log(&it, "refname"), REFTABLE_ZLIB_ERROR);
+
+	reftable_iterator_destroy(&it);
+
+	/* cleanup. */
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__table_read_write_sequential(void)
+{
+	char **names;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	int N = 50;
+	struct reftable_iterator it = { 0 };
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *reader;
+	int j = 0;
+
+	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+
+	for (j = 0; ; j++) {
+		struct reftable_ref_record ref = { 0 };
+		int r = reftable_iterator_next_ref(&it, &ref);
+		cl_assert(r >= 0);
+		if (r > 0)
+			break;
+		cl_assert_equal_s(names[j], ref.refname);
+		cl_assert_equal_i(update_index, ref.update_index);
+		reftable_ref_record_release(&ref);
+	}
+	cl_assert_equal_i(j, N);
+
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+	free_names(names);
+}
+
+void test_reftable_readwrite__table_write_small_table(void)
+{
+	char **names;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	int N = 1;
+	write_table(&names, &buf, N, 4096, REFTABLE_HASH_SHA1);
+	cl_assert(buf.len < 200);
+	reftable_buf_release(&buf);
+	free_names(names);
+}
+
+void test_reftable_readwrite__table_read_api(void)
+{
+	char **names;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	int N = 50;
+	struct reftable_reader *reader;
+	struct reftable_block_source source = { 0 };
+	struct reftable_log_record log = { 0 };
+	struct reftable_iterator it = { 0 };
+
+	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_ref(&it, names[0]) == 0);
+
+	cl_assert_equal_i(reftable_iterator_next_log(&it, &log), REFTABLE_API_ERROR);
+
+	reftable_buf_release(&buf);
+	free_names(names);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+}
+
+static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
+{
+	char **names;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	int N = 50;
+	struct reftable_reader *reader;
+	struct reftable_block_source source = { 0 };
+	int err;
+	int i = 0;
+
+	struct reftable_iterator it = { 0 };
+	struct reftable_buf pastLast = REFTABLE_BUF_INIT;
+	struct reftable_ref_record ref = { 0 };
+
+	write_table(&names, &buf, N, 256, hash_id);
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
+	cl_assert_equal_i(hash_id, reftable_reader_hash_id(reader));
+
+	if (!index) {
+		reader->ref_offsets.index_offset = 0;
+	} else {
+		cl_assert(reader->ref_offsets.index_offset > 0);
+	}
+
+	for (i = 1; i < N; i++) {
+		cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+		cl_assert(reftable_iterator_seek_ref(&it, names[i]) == 0);
+		cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
+		cl_assert_equal_s(names[i], ref.refname);
+		cl_assert_equal_i(REFTABLE_REF_VAL1, ref.value_type);
+		cl_assert_equal_i(i, ref.value.val1[0]);
+
+		reftable_ref_record_release(&ref);
+		reftable_iterator_destroy(&it);
+	}
+
+	cl_assert(reftable_buf_addstr(&pastLast, names[N - 1]) == 0);
+	cl_assert(reftable_buf_addstr(&pastLast, "/") == 0);
+
+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+	err = reftable_iterator_seek_ref(&it, pastLast.buf);
+	if (err == 0) {
+		struct reftable_ref_record ref = { 0 };
+		int err = reftable_iterator_next_ref(&it, &ref);
+		cl_assert(err > 0);
+	} else {
+		cl_assert(err > 0);
+	}
+
+	reftable_buf_release(&pastLast);
+	reftable_iterator_destroy(&it);
+
+	reftable_buf_release(&buf);
+	free_names(names);
+	reftable_reader_decref(reader);
+}
+
+void test_reftable_readwrite__table_read_write_seek_linear(void)
+{
+	t_table_read_write_seek(0, REFTABLE_HASH_SHA1);
+}
+
+void test_reftable_readwrite__table_read_write_seek_linear_sha256(void)
+{
+	t_table_read_write_seek(0, REFTABLE_HASH_SHA256);
+}
+
+void test_reftable_readwrite__table_read_write_seek_index(void)
+{
+	t_table_read_write_seek(1, REFTABLE_HASH_SHA1);
+}
+
+static void t_table_refs_for(int indexed)
+{
+	char **want_names;
+	int want_names_len = 0;
+	uint8_t want_hash[REFTABLE_HASH_SIZE_SHA1];
+
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_block_source source = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_iterator it = { 0 };
+	int N = 50, j, i;
+
+	want_names = reftable_calloc(N + 1, sizeof(*want_names));
+	cl_assert(want_names != NULL);
+
+	cl_reftable_set_hash(want_hash, 4, REFTABLE_HASH_SHA1);
+
+	for (i = 0; i < N; i++) {
+		uint8_t hash[REFTABLE_HASH_SIZE_SHA1];
+		char fill[51] = { 0 };
+		char name[100];
+		struct reftable_ref_record ref = { 0 };
+
+		memset(hash, i, sizeof(hash));
+		memset(fill, 'x', 50);
+		/* Put the variable part in the start */
+		snprintf(name, sizeof(name), "br%02d%s", i, fill);
+		name[40] = 0;
+		ref.refname = name;
+
+		ref.value_type = REFTABLE_REF_VAL2;
+		cl_reftable_set_hash(ref.value.val2.value, i / 4,
+				    REFTABLE_HASH_SHA1);
+		cl_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
+				    REFTABLE_HASH_SHA1);
+
+		/* 80 bytes / entry, so 3 entries per block. Yields 17
+		 */
+		/* blocks. */
+		cl_assert_equal_i(reftable_writer_add_ref(w, &ref), 0);
+
+		if (!memcmp(ref.value.val2.value, want_hash, REFTABLE_HASH_SIZE_SHA1) ||
+		    !memcmp(ref.value.val2.target_value, want_hash, REFTABLE_HASH_SIZE_SHA1))
+			want_names[want_names_len++] = xstrdup(name);
+	}
+
+	cl_assert_equal_i(reftable_writer_close(w), 0);
+
+	reftable_writer_free(w);
+	w = NULL;
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
+	if (!indexed)
+		reader->obj_offsets.is_present = 0;
+
+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+	reftable_iterator_destroy(&it);
+
+	cl_assert(reftable_reader_refs_for(reader, &it, want_hash) == 0);
+
+	for (j = 0; ; j++) {
+		int err = reftable_iterator_next_ref(&it, &ref);
+		cl_assert(err >= 0);
+		if (err > 0)
+			break;
+		cl_assert(j < want_names_len);
+		cl_assert_equal_s(ref.refname, want_names[j]);
+		reftable_ref_record_release(&ref);
+	}
+	cl_assert_equal_i(j, want_names_len);
+
+	reftable_buf_release(&buf);
+	free_names(want_names);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+}
+
+void test_reftable_readwrite__table_refs_for_no_index(void)
+{
+	t_table_refs_for(0);
+}
+
+void test_reftable_readwrite__table_refs_for_obj_index(void)
+{
+	t_table_refs_for(1);
+}
+
+void test_reftable_readwrite__write_empty_table(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *rd = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	cl_assert_equal_i(reftable_writer_close(w), REFTABLE_EMPTY_TABLE_ERROR);
+	reftable_writer_free(w);
+
+	cl_assert_equal_i(buf.len, header_size(1) + footer_size(1));
+
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&rd, &source, "filename") == 0);
+	cl_assert(reftable_reader_init_ref_iterator(rd, &it) == 0);
+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
+
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(rd);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__write_object_id_min_length(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 75,
+	};
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_ref_record ref = {
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = {42},
+	};
+	int i;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* Write the same hash in many refs. If there is only 1 hash, the
+	 * disambiguating prefix is length 0 */
+	for (i = 0; i < 256; i++) {
+		char name[256];
+		snprintf(name, sizeof(name), "ref%05d", i);
+		ref.refname = name;
+		cl_assert(reftable_writer_add_ref(w, &ref) == 0);
+	}
+
+	cl_assert(reftable_writer_close(w) == 0);
+	cl_assert_equal_i(reftable_writer_stats(w)->object_id_len, 2);
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__write_object_id_length(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 75,
+	};
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_ref_record ref = {
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = {42},
+	};
+	int i;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* Write the same hash in many refs. If there is only 1 hash, the
+	 * disambiguating prefix is length 0 */
+	for (i = 0; i < 256; i++) {
+		char name[256];
+		snprintf(name, sizeof(name), "ref%05d", i);
+		ref.refname = name;
+		ref.value.val1[15] = i;
+		cl_assert(reftable_writer_add_ref(w, &ref) == 0);
+	}
+
+	cl_assert(reftable_writer_close(w) == 0);
+	cl_assert_equal_i(reftable_writer_stats(w)->object_id_len, 16);
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__write_empty_key(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_ref_record ref = {
+		.refname = (char *) "",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_DELETION,
+	};
+
+	reftable_writer_set_limits(w, 1, 1);
+	cl_assert_equal_i(reftable_writer_add_ref(w, &ref), REFTABLE_API_ERROR);
+	cl_assert_equal_i(reftable_writer_close(w), REFTABLE_EMPTY_TABLE_ERROR);
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__write_key_order(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_ref_record refs[2] = {
+		{
+			.refname = (char *) "b",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_SYMREF,
+			.value = {
+				.symref = (char *) "target",
+			},
+		}, {
+			.refname = (char *) "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_SYMREF,
+			.value = {
+				.symref = (char *) "target",
+			},
+		}
+	};
+
+	reftable_writer_set_limits(w, 1, 1);
+	cl_assert(reftable_writer_add_ref(w, &refs[0]) == 0);
+	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[1]), REFTABLE_API_ERROR);
+
+	refs[0].update_index = 2;
+	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[0]), REFTABLE_API_ERROR);
+
+	reftable_writer_close(w);
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__write_multiple_indices(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 100,
+	};
+	struct reftable_buf writer_buf = REFTABLE_BUF_INIT;
+	struct reftable_block_source source = { 0 };
+	struct reftable_iterator it = { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	struct reftable_reader *reader;
+	char buf[128];
+	int i;
+
+	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
+	reftable_writer_set_limits(writer, 1, 1);
+	for (i = 0; i < 100; i++) {
+		struct reftable_ref_record ref = {
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = {i},
+		};
+
+		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
+		ref.refname = buf;
+
+		cl_assert(reftable_writer_add_ref(writer, &ref) == 0);
+	}
+
+	for (i = 0; i < 100; i++) {
+		struct reftable_log_record log = {
+			.update_index = 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.old_hash = { i },
+				.new_hash = { i },
+			},
+		};
+
+		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
+		log.refname = buf;
+
+		cl_assert(reftable_writer_add_log(writer, &log) == 0);
+	}
+
+	reftable_writer_close(writer);
+
+	/*
+	 * The written data should be sufficiently large to result in indices
+	 * for each of the block types.
+	 */
+	stats = reftable_writer_stats(writer);
+	cl_assert(stats->ref_stats.index_offset > 0);
+	cl_assert(stats->obj_stats.index_offset > 0);
+	cl_assert(stats->log_stats.index_offset > 0);
+
+	block_source_from_buf(&source, &writer_buf);
+	cl_assert(reftable_reader_new(&reader, &source, "filename") == 0);
+
+	/*
+	 * Seeking the log uses the log index now. In case there is any
+	 * confusion regarding indices we would notice here.
+	 */
+	cl_assert(reftable_reader_init_log_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_log(&it, "") == 0);
+
+	reftable_iterator_destroy(&it);
+	reftable_writer_free(writer);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&writer_buf);
+}
+
+void test_reftable_readwrite__write_multi_level_index(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 100,
+	};
+	struct reftable_buf writer_buf = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
+	struct reftable_block_source source = { 0 };
+	struct reftable_iterator it = { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	struct reftable_reader *reader;
+
+	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
+	reftable_writer_set_limits(writer, 1, 1);
+	for (size_t i = 0; i < 200; i++) {
+		struct reftable_ref_record ref = {
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = {i},
+		};
+		char buf[128];
+
+		snprintf(buf, sizeof(buf), "refs/heads/%03" PRIuMAX, (uintmax_t)i);
+		ref.refname = buf;
+
+		cl_assert(reftable_writer_add_ref(writer, &ref) == 0);
+	}
+	reftable_writer_close(writer);
+
+	/*
+	 * The written refs should be sufficiently large to result in a
+	 * multi-level index.
+	 */
+	stats = reftable_writer_stats(writer);
+	cl_assert_equal_i(stats->ref_stats.max_index_level, 2);
+
+	block_source_from_buf(&source, &writer_buf);
+	cl_assert(reftable_reader_new(&reader, &source, "filename") == 0);
+
+	/*
+	 * Seeking the last ref should work as expected.
+	 */
+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
+	cl_assert(reftable_iterator_seek_ref(&it, "refs/heads/199") == 0);
+
+	reftable_iterator_destroy(&it);
+	reftable_writer_free(writer);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&writer_buf);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_readwrite__corrupt_table_empty(void)
+{
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *reader;
+
+	block_source_from_buf(&source, &buf);
+	cl_assert_equal_i(reftable_reader_new(&reader, &source,
+										  "file.log"),REFTABLE_FORMAT_ERROR);
+}
+
+void test_reftable_readwrite__corrupt_table(void)
+{
+	uint8_t zeros[1024] = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_block_source source = { 0 };
+	struct reftable_reader *reader;
+	cl_assert(reftable_buf_add(&buf, zeros, sizeof(zeros)) == 0);
+
+	block_source_from_buf(&source, &buf);
+	cl_assert_equal_i(reftable_reader_new(&reader, &source,
+										  "file.log"), REFTABLE_FORMAT_ERROR);
+
+	reftable_buf_release(&buf);
+}
-- 
2.43.0

