Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2ED217F3D
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867217; cv=none; b=NeuRA8q35+MI++itAVJv4gQW4S+vBvVG9VAfUdjpN6AI4PfeJbjc2ZZXrKCEAgorlz0mf0Z1RiNOyqsgHVGyjd71oPW4ncRRQCzojDNLLje4yIik+QlAoR9EfXuhyDgaXkj1u/z5PUar7iKGTRnW6U2N2q7OIOBUvSM3TiKfj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867217; c=relaxed/simple;
	bh=KPN1l1YTuxFos699TAcmOyFjeArZjc6JhF5qAMvzlAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2PhRH86NS9W7lnp6TRg+wmYDjOPSmwGDlzMlgeEsdcvpK04UcZUgIa+ZK93S8oDZnayRJCg164W2xZ2i+eqaQ53+sQGnpI0pFPqn+oZOFENftKMB7ECSv71T1k52ADCzd1TIFnjs+bQs/awzcweyxYFWXkdWn7GX2Nih+fpTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHEvB7K1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHEvB7K1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so11951445e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867213; x=1749472013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NprqxQsqDETwHzVHOCn/ZpQb0fTUu0AJsyhmUNLme1o=;
        b=FHEvB7K15jj30b2YvRqD/oQ9Rngo0jEY5dTbe0j8wFDMXdEoZ12iVlz0ep0sy+9ReM
         AfJg8iZ9OwPBp5s1oJy003YJra8dRMKNZ+VyKNthJSznAqqRB6HYgK5yOEkY2gRfTcRH
         o2vwnsTYfHFsSXqQZgwarLNJnp9/gpCFz5WTdYf7uW5f41S4R2GebqawoXBmEbc5aGmH
         K3ppunJCdoAhtys9jM2Tr/Wa40grE9h8m6Xd5CpvWDm3rdUc6g8yqEoaDer+LBYUgTv0
         4f4CYI9JxiuXOZNko6OYx7KOxWWHjZtZrq3SBaY0yz5fZjL4c1DvZjhgE3F3NNG8Iuxa
         xEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867213; x=1749472013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NprqxQsqDETwHzVHOCn/ZpQb0fTUu0AJsyhmUNLme1o=;
        b=YDFQqr3T+vOgJkduHZb1HRMYhQQ3KKdqbWmZ6nMdCCyiQrZ4lz6rA7te7+074scPgt
         /dksP2Sv9Zqz8klJ6g/VI0ywqQbvarz5Xb1YxlEnjBH4/fxZ9wN8jsGEwYv81lVFGm1/
         BtboUbWA9azPmt/VrlMf+vnAPIKOLDHOsvqMgv+V1h0dUEzGimT3BUdoTm/jplBUbah/
         PCVRnjwgcuwyospoEMaf9oDHw7X5JjJzLuRBM0s0ZNXFq+ThzqfDLhl12uzlH2UBtJxW
         LLSciWQU20tErftHRW2+Mac/1E5uK5wjWUR/v5Z0wIt9eBBPB5Uq75N/XLuq9ONTL6ZM
         rw7w==
X-Gm-Message-State: AOJu0YxvMvZeYSzFcoum2V5V4ifEDV3t1i/KVH61Uenk3KhJC0+Uj/q9
	kAk7QTnKFypwFbk5utaf4hFcm7vV+1H4UiAxVhWo8T650NCzrEXX2+M2xhou+ocbYVk=
X-Gm-Gg: ASbGnctIo6UT2B/kayO4ISVfZ9iHohm+QI/J56yPfALcYKCFU6JPVUe9Nzx7vYQQzzy
	fXBoXrPqqCgyxcupzqTTFprJDyU3Z4+kqHAW4ytXo3DxdNhBv4Ep7Uyltn2VxsaHZ18J/GDBB3E
	HXAEiJ6JsV5tTqeUM24iyMmp62VkDzkpn10/Lg9t3pJk3Bi9YHAM7C5Z5c4D5Pii3QAL134mmMo
	YmaUaNzycAzF3blU0IhPu7wUjKn7rAKcE09oWSL+2APDiCaZjKXueWICchNwNNN43xSzAA7Edkj
	cmytN3W58awc0cGvNDKV2LuL40aG+69Qb+NyfUhgRhbFypcAV/TCMm8n/a1/XBKfeg==
X-Google-Smtp-Source: AGHT+IF09xLFlQKw2rhKoYSf9yq2hMEqX5xxFDcbV8Qk64uRTRJadlRlxoc4YWFAgaabR7yCpV5+Pw==
X-Received: by 2002:a05:600c:4eca:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-450d6546333mr106730145e9.23.1748867212477;
        Mon, 02 Jun 2025 05:26:52 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:26:52 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 03/10] t/unit-tests: convert reftable block test to use clar
Date: Mon,  2 Jun 2025 13:25:51 +0100
Message-ID: <20250602122559.208780-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602122559.208780-1-kuforiji98@gmail.com>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable block test file to use clar testing framework by using
clar assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |   2 +-
 t/meson.build                                 |   2 +-
 ...{t-reftable-block.c => u-reftable-block.c} | 164 +++++++++---------
 3 files changed, 80 insertions(+), 88 deletions(-)
 rename t/unit-tests/{t-reftable-block.c => u-reftable-block.c} (74%)

diff --git a/Makefile b/Makefile
index a01103e3a6..d01dfd179b 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,6 +1365,7 @@ CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
+CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1378,7 +1379,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
-UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
diff --git a/t/meson.build b/t/meson.build
index e00e8d41d6..b1d9dea9e7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -9,6 +9,7 @@ clar_test_suites = [
   'unit-tests/u-oidtree.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-basics.c',
+  'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -56,7 +57,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
   'unit-tests/t-reftable-pq.c',
   'unit-tests/t-reftable-readwrite.c',
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/u-reftable-block.c
similarity index 74%
rename from t/unit-tests/t-reftable-block.c
rename to t/unit-tests/u-reftable-block.c
index 52f1dae1c9..5d1419b801 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -6,14 +6,15 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "test-lib.h"
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
 #include "reftable/block.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/reftable-error.h"
 #include "strbuf.h"
 
-static void t_ref_block_read_write(void)
+void test_reftable_block__index_read_write(void)
 {
 	const int header_off = 21; /* random */
 	struct reftable_record recs[30];
@@ -34,17 +35,18 @@ static void t_ref_block_read_write(void)
 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
-	check(block_data.buf != NULL);
+	cl_assert(block_data.buf != NULL);
 	block_data.len = block_size;
 
-	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_REF, (uint8_t *) block_data.buf, block_size,
+	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_REF,
+				(uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
+	cl_assert(ret == 0);
 
 	rec.u.ref.refname = (char *) "";
 	rec.u.ref.value_type = REFTABLE_REF_DELETION;
 	ret = block_writer_add(&bw, &rec);
-	check_int(ret, ==, REFTABLE_API_ERROR);
+	cl_assert_equal_i(ret, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
 		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
@@ -55,11 +57,11 @@ static void t_ref_block_read_write(void)
 		ret = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 	}
 
 	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
+	cl_assert(ret > 0);
 
 	block_writer_release(&bw);
 
@@ -71,32 +73,32 @@ static void t_ref_block_read_write(void)
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
+		cl_assert(ret >= 0);
 		if (ret > 0) {
-			check_int(i, ==, N);
+			cl_assert_equal_i(i, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	for (i = 0; i < N; i++) {
 		reftable_record_key(&recs[i], &want);
 
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	reftable_block_release(&block);
@@ -108,7 +110,7 @@ static void t_ref_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
-static void t_log_block_read_write(void)
+void test_reftable_block__log_read_write(void)
 {
 	const int header_off = 21;
 	struct reftable_record recs[30];
@@ -129,12 +131,12 @@ static void t_log_block_read_write(void)
 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
-	check(block_data.buf != NULL);
+	cl_assert(block_data.buf != NULL);
 	block_data.len = block_size;
 
 	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_LOG, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
+	cl_assert(ret == 0);
 
 	for (i = 0; i < N; i++) {
 		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
@@ -145,11 +147,11 @@ static void t_log_block_read_write(void)
 		ret = block_writer_add(&bw, &rec);
 		rec.u.log.refname = NULL;
 		rec.u.log.value_type = REFTABLE_LOG_DELETION;
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 	}
 
 	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
+	cl_assert(ret > 0);
 
 	block_writer_release(&bw);
 
@@ -161,33 +163,33 @@ static void t_log_block_read_write(void)
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
+		cl_assert(ret >= 0);
 		if (ret > 0) {
-			check_int(i, ==, N);
+			cl_assert_equal_i(i, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	for (i = 0; i < N; i++) {
 		reftable_buf_reset(&want);
-		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
+		cl_assert(reftable_buf_addstr(&want, recs[i].u.log.refname) == 0);
 
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	reftable_block_release(&block);
@@ -199,7 +201,7 @@ static void t_log_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
-static void t_obj_block_read_write(void)
+void test_reftable_block__obj_read_write(void)
 {
 	const int header_off = 21;
 	struct reftable_record recs[30];
@@ -220,12 +222,12 @@ static void t_obj_block_read_write(void)
 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
-	check(block_data.buf != NULL);
+	cl_assert(block_data.buf != NULL);
 	block_data.len = block_size;
 
 	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
+	cl_assert(ret == 0);
 
 	for (i = 0; i < N; i++) {
 		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
@@ -238,11 +240,11 @@ static void t_obj_block_read_write(void)
 		ret = block_writer_add(&bw, &rec);
 		rec.u.obj.hash_prefix = NULL;
 		rec.u.obj.hash_prefix_len = 0;
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 	}
 
 	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
+	cl_assert(ret > 0);
 
 	block_writer_release(&bw);
 
@@ -254,24 +256,24 @@ static void t_obj_block_read_write(void)
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
+		cl_assert(ret >= 0);
 		if (ret > 0) {
-			check_int(i, ==, N);
+			cl_assert_equal_i(i, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	for (i = 0; i < N; i++) {
 		reftable_record_key(&recs[i], &want);
 
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	reftable_block_release(&block);
@@ -283,7 +285,7 @@ static void t_obj_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
-static void t_index_block_read_write(void)
+void test_reftable_block__ref_read_write(void)
 {
 	const int header_off = 21;
 	struct reftable_record recs[30];
@@ -305,12 +307,12 @@ static void t_index_block_read_write(void)
 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
-	check(block_data.buf != NULL);
+	cl_assert(block_data.buf != NULL);
 	block_data.len = block_size;
 
 	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_INDEX, (uint8_t *) block_data.buf, block_size,
 				header_off, hash_size(REFTABLE_HASH_SHA1));
-	check(!ret);
+	cl_assert(ret == 0);
 
 	for (i = 0; i < N; i++) {
 		char buf[128];
@@ -319,15 +321,15 @@ static void t_index_block_read_write(void)
 
 		reftable_buf_init(&recs[i].u.idx.last_key);
 		recs[i].type = REFTABLE_BLOCK_TYPE_INDEX;
-		check(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
+		cl_assert(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
 		recs[i].u.idx.offset = i;
 
 		ret = block_writer_add(&bw, &recs[i]);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 	}
 
 	ret = block_writer_finish(&bw);
-	check_int(ret, >, 0);
+	cl_assert(ret > 0);
 
 	block_writer_release(&bw);
 
@@ -339,32 +341,32 @@ static void t_index_block_read_write(void)
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, >=, 0);
+		cl_assert(ret >= 0);
 		if (ret > 0) {
-			check_int(i, ==, N);
+			cl_assert_equal_i(i, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	for (i = 0; i < N; i++) {
 		reftable_record_key(&recs[i], &want);
 
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &want);
-		check_int(ret, ==, 0);
+		cl_assert_equal_i(ret, 0);
 
 		ret = block_iter_next(&it, &rec);
-		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
 	}
 
 	reftable_block_release(&block);
@@ -376,7 +378,7 @@ static void t_index_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
-static void t_block_iterator(void)
+void test_reftable_block__iterator(void)
 {
 	struct reftable_block_source source = { 0 };
 	struct block_writer writer = {
@@ -391,11 +393,12 @@ static void t_block_iterator(void)
 
 	data.len = 1024;
 	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
-	check(data.buf != NULL);
+	cl_assert(data.buf != NULL);
 
-	err = block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF, (uint8_t *) data.buf, data.len,
+	err = block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
+				(uint8_t *) data.buf, data.len,
 				0, hash_size(REFTABLE_HASH_SHA1));
-	check(!err);
+	cl_assert(!err);
 
 	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++) {
 		expected_refs[i] = (struct reftable_record) {
@@ -408,42 +411,42 @@ static void t_block_iterator(void)
 		memset(expected_refs[i].u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
 
 		err = block_writer_add(&writer, &expected_refs[i]);
-		check_int(err, ==, 0);
+		cl_assert_equal_i(err, 0);
 	}
 
 	err = block_writer_finish(&writer);
-	check_int(err, >, 0);
+	cl_assert(err > 0);
 
 	block_source_from_buf(&source, &data);
 	reftable_block_init(&block, &source, 0, 0, data.len,
 			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF);
 
 	err = reftable_block_init_iterator(&block, &it);
-	check_int(err, ==, 0);
+	cl_assert_equal_i(err, 0);
 
 	for (size_t i = 0; ; i++) {
 		err = reftable_iterator_next_ref(&it, &ref);
 		if (err > 0) {
-			check_int(i, ==, ARRAY_SIZE(expected_refs));
+			cl_assert_equal_i(i, ARRAY_SIZE(expected_refs));
 			break;
 		}
-		check_int(err, ==, 0);
+		cl_assert_equal_i(err, 0);
 
-		check(reftable_ref_record_equal(&ref, &expected_refs[i].u.ref,
-						REFTABLE_HASH_SIZE_SHA1));
+		cl_assert(reftable_ref_record_equal(&ref,
+						    &expected_refs[i].u.ref, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	err = reftable_iterator_seek_ref(&it, "refs/heads/does-not-exist");
-	check_int(err, ==, 0);
+	cl_assert_equal_i(err, 0);
 	err = reftable_iterator_next_ref(&it, &ref);
-	check_int(err, ==, 1);
+	cl_assert_equal_i(err, 1);
 
 	err = reftable_iterator_seek_ref(&it, "refs/heads/branch-13");
-	check_int(err, ==, 0);
+	cl_assert_equal_i(err, 0);
 	err = reftable_iterator_next_ref(&it, &ref);
-	check_int(err, ==, 0);
-	check(reftable_ref_record_equal(&ref, &expected_refs[13].u.ref,
-					REFTABLE_HASH_SIZE_SHA1));
+	cl_assert_equal_i(err, 0);
+	cl_assert(reftable_ref_record_equal(&ref,
+					    &expected_refs[13].u.ref,REFTABLE_HASH_SIZE_SHA1));
 
 	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++)
 		reftable_free(expected_refs[i].u.ref.refname);
@@ -453,14 +456,3 @@ static void t_block_iterator(void)
 	block_writer_release(&writer);
 	reftable_buf_release(&data);
 }
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_index_block_read_write(), "read-write operations on index blocks work");
-	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
-	TEST(t_obj_block_read_write(), "read-write operations on obj blocks work");
-	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
-	TEST(t_block_iterator(), "block iterator works");
-
-	return test_done();
-}
-- 
2.43.0

