Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5882749E8
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132491; cv=none; b=JGUPFJfy0oa7jnEY5HzQbd2WD+OexRir9h50N7PizC5H1/pjGd7oRlXScaptGSKA9IYztCdJxvfrK3bwc9wMMNnS5xTauoT6RyC4lyKVY4l1LVz89nM5VdNZmKzl+br8PF1rOjaxdapLt5OYxKftH/LppfH+m406JBuEp1e1r00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132491; c=relaxed/simple;
	bh=Ba/PoHMq5x7W+A5gteAN7AYpY1jwC9VcLsf4d+h9fZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdr+/PCWRaTdvJzeXVLWtLprBgxqk4IvPNDc3XMiM0kHrQLgT/iQU8PzT7MZnxeCpe/bTDVUIQ2v68BMstQYZhk6jFEfShlrdqcED8pXUmmQS1+TLK8d5bvjtEoItGCeRdupL6gmKHrXDrgFmAG95p/7tdQdgtZlko0HN77HeCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nomA3nz5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nomA3nz5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so12101815e9.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132487; x=1749737287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6IqUbk2Ehud6WX3HRK9HLxjDiHNd0fyFL7eveOpPTg=;
        b=nomA3nz5C6KryGRDGNvc+iOdpVB5WxYsFBCWch70S8W9JvqJJJVREn+N2vduG/p8gr
         n6tGbSHE/M/0LoRe8GcOevADyvgB1BUJJBf9HTS9forxe4VnlynmeGBMXXkxcOip8WK3
         G9CLPuhEgs6Hp62/Zz+Ms5gibYVJYhs1Atir6qAU5VutxfZuf6YYnMj2wSxhkdzMF3yF
         Z5+2qrRqwOeSeRbfPE6wkFUihbKKhCJuVPzvmRvVzK6xj7GmBnLRoxDLY1M7aTQVaXVC
         Zj4SDsh56fYfGzpxs743KpvnFdKB6TDWcItZRS+LJ/bn0l0dCluYMfcp6CG72UpZGuI0
         v58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132487; x=1749737287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6IqUbk2Ehud6WX3HRK9HLxjDiHNd0fyFL7eveOpPTg=;
        b=fOVTYWo/vBMGB8PBPM6GiErcMiQePQ8T6JFRG08u+ohuhHoSFv8qh7HcT09DHXDpoz
         pSBfcUm3r4sNBUHej101AOEvkbKnNgysKMGx4AsZAcIsVJCLs+rK7tckVcs6MQ5bAB3W
         hXCuZh/SQjMHqzC0j7WXdX1fD0JyYLrYWvek7osXzw1gSLP5svY04BSpdZzIEGmUQRZV
         +nu7AtgKohZhlwzZm9h74/eM0CqhXuoILje6JAQ5ZHQf5SlGNdlB3pIhQh7E2nmJNhIQ
         FSWglwypUXB/2iEf0iqRZELdFTsU8dVtaepjQ7UFqHwiBrkd9lo645IqSP23wOPA8At3
         KjJg==
X-Gm-Message-State: AOJu0Yz9OYIL/HBcq32sE+LJEw6H3sFBFeUdlt37NdaJi3IZEBG7Adfd
	d6h6EeKVAnaaneFwm/jnP8EBqvJSLkbeO/fyI8zf9Aj9mGOH8wuvq5VDhGPCuoatowk=
X-Gm-Gg: ASbGncsG+xWqdmRtC59fQB/L7msPERiH/Rg/3o3X0EmYQHGJOxOh1cJdtD1ggkSUzYo
	C7fiqLwbWvLTLPt91sdTV+jHPgdzC9Bt9Dw5kb/HRnFFtnWNJ+8bRfP6Cx8IxTVBi/7jumBLa30
	DM3/RY3ge+3pMih9mMw4sXLdQadaVxUP2yPYo61Ott+pGsApsUXvCssX3jrFVfxEpo6V4RddBo4
	PtfJOUGcKYf44mRc1/jP2yXWtwsis8SeBe8F2SaoqeT9UvS4WCengJMFbDerQB7GcNekXUOtvtn
	yUG1TYNbIDYK7fKKT7RIeAawZDtF9C+g9IFtJRK55pspHA==
X-Google-Smtp-Source: AGHT+IFef4P8Ac8lAWE15X4JAEjwxBiTjOG3bESagPW4Ir20cAys/hFLJoKwjNfVnfNreXeOlMK/JQ==
X-Received: by 2002:a05:600c:3e88:b0:43a:b0ac:b10c with SMTP id 5b1f17b1804b1-451f0b2696dmr55639165e9.26.1749132485502;
        Thu, 05 Jun 2025 07:08:05 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:08:05 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 03/10] t/unit-tests: convert reftable block test to use clar
Date: Thu,  5 Jun 2025 15:06:37 +0100
Message-ID: <20250605140644.239199-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
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
index 52f1dae1c9..97a1348563 100644
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
+void test_reftable_block__read_write(void)
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
+	cl_assert(!ret);
 
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
+	cl_assert(!ret);
 
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
+	cl_assert(!ret);
 
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
+	cl_assert(!ret);
 
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

