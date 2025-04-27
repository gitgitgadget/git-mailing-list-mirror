Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D301519AC
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780097; cv=none; b=uLXuEwrQQK1vQIDxvAfckyqeb9b+gDJa5oM3VR/nJrcQ/8Pg9B97k8pq6r+ylP6KxPs+/4xf9q2hNC5kY1WnaD9zx1MWjSR7ncdcLd4mbKHK4U9JyVjrzJHI9YSU4NxxQsIW5t3LtT0G4lV5t4Wtu5T3uykVcZKXFWVT797EfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780097; c=relaxed/simple;
	bh=VXRLOhu9zClujAJ9i21PJuIzz2UYgEuOD7XEJ8lyYrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDXx5IVNMdyaeA2U3mra1+SzilSejRpUQEkTTeZv5oESYQb4LrOcLMxmuAfv9dmFVXVxkLLTRDu2iJQVwIwqQmX630yPgMkOfsY7KI9/oQ5AfVyucMZ6JMmLoiv0qwJNdXeI9Y4WthXzM32ncUhjHfd/qBnVAwH4ZlNdzKWW118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViiUKsXy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViiUKsXy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1efc457bso2780845f8f.2
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780093; x=1746384893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyteuPNXSyEFONOFGfEqomWUKg/ummwo7+RjcdIV/zA=;
        b=ViiUKsXySfLgWyf6wp0g2OiVCGNgF3OLMUU4XZBrbllWIfDi7wNb+QPSXglRFF8ab1
         jBBls8WZhYWW2JmHDBciC9X/eUsMxeN+ClzWbyGHq24LekPRXWhZacJ2G7meLBJD8aiy
         HwVjieqJ4YQONtx5xCfGZQjQ5G4qD0JLa5koummvtlqAY4GoRJYAQfhMh0/rCahRVYr7
         hg17W2SoSQz144mIeyDPRljIbiojlYMK/+ubnBreme7aeAz0WyqRT/PSIoT/Dv1r3EW6
         jEN7Fa1m2oc6E9OYDpXru4C3EDYpqGUtZmZPTq+zp0VyhkgHHDO6xgCSD8QMUp0p9MIw
         ZDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780093; x=1746384893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyteuPNXSyEFONOFGfEqomWUKg/ummwo7+RjcdIV/zA=;
        b=Tu6a80pgDixNPtx6l7A52e4OoUDMA2btFRrx189wRlpoxbPr5rGrXe2coNHnQaa6dw
         sfFtmPzqUE5HpTCU+eKRV2gyZES3+ZCa8lByg7Hrbd/u1OmWsGJdV7O2o62/NgVGNRP9
         uAjLtJprwUkNW8RW0Knfdt7hZrV1ntBbnaWTaM3zWmB1RNo0wss7DLTwGSTyX/EPWUy+
         cCNb9Bpv3+B8JAh11K3T020navxGeJUOKmKRQrfedrvx9vaMf0oGiqRFcvYqwBigq0ek
         uzzFsFzf1KubF0fTB1wDWVqSGIRm4pPBSrDmm5wnKHRRKVk9mi0sQuCsEeSmMpG2JU78
         eLTg==
X-Gm-Message-State: AOJu0YxO4qWoMxfG9o8zJTxpSBBizikaKoGmSvxEL0ihqWWUP6T5L6rK
	hbcBnJ1C+RHXxo6cwo7gBkudGYjYE0eZgqKn1heGGb+8dHdQgHK4Z1kvJE4T584eBA==
X-Gm-Gg: ASbGncsIqiL3vGqm0GrAwspJjkbzIBu71XdEmMWXtcQjhaAzYBnevLBK3eBm/hKev+2
	S5tTRlA4gaCT1CIgKGeEv64igjz0uV+bGdwZXTgiJtojmfRabxUnlxakUiX/NSiIn7a/sHQ5Cg8
	boQeIfDURJQiRpdx0dt+rp7Rp5gX5GOPgsO2JzgiAAr8S5LB+ODuM6xay9WHliJT0OsUNB+UVli
	yoqUM9EZsN3VmaHPvrIWnFkNdnJexA5ISr0m8b+5XZPDLv5l+DCuiScDh62AViygdRaFvGNfO9Q
	Muqw+PieTlEX/da94luwcyYX2YDtkqRZqXjOUyfLcPELWtc=
X-Google-Smtp-Source: AGHT+IGG8gKgVNvaXvaRO8KzSprrVhpUmurYT1jxuT7eWqBnGM0rcnkhvRvwHghuJwFh7LZIlU9BZw==
X-Received: by 2002:a5d:4689:0:b0:39e:cbc7:ad2c with SMTP id ffacd0b85a97d-3a07aa75591mr3888069f8f.25.1745780093161;
        Sun, 27 Apr 2025 11:54:53 -0700 (PDT)
Received: from localhost.localdomain ([105.113.116.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm9150175f8f.11.2025.04.27.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 11:54:52 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 5/9] t/unit-tests: convert reftable pq test to use clar
Date: Sun, 27 Apr 2025 19:53:47 +0100
Message-ID: <20250427185351.82520-6-kuforiji98@gmail.com>
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

Adapt reftable priority queue test file to use clar by using clar
assertions where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                     |   2 +-
 t/meson.build                |   2 +-
 t/unit-tests/t-reftable-pq.c | 161 -----------------------------------
 t/unit-tests/u-reftable-pq.c | 152 +++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 163 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-pq.c
 create mode 100644 t/unit-tests/u-reftable-pq.c

diff --git a/Makefile b/Makefile
index a7a519ac81..060d89df7f 100644
--- a/Makefile
+++ b/Makefile
@@ -1365,6 +1365,7 @@ CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
+CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1378,7 +1379,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
diff --git a/t/meson.build b/t/meson.build
index a4210dc561..1e12bd1b96 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -11,6 +11,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-basics.c',
   'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-merged.c',
+  'unit-tests/u-reftable-pq.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -58,7 +59,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-pq.c',
   'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
deleted file mode 100644
index c128fe8616..0000000000
--- a/t/unit-tests/t-reftable-pq.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/constants.h"
-#include "reftable/pq.h"
-#include "strbuf.h"
-
-static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
-{
-	for (size_t i = 1; i < pq->len; i++) {
-		size_t parent = (i - 1) / 2;
-		check(pq_less(&pq->heap[parent], &pq->heap[i]));
-	}
-}
-
-static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
-{
-	int cmp;
-	check(!reftable_record_cmp(a->rec, b->rec, &cmp));
-	return !cmp && (a->index == b->index);
-}
-
-static void t_pq_record(void)
-{
-	struct merged_iter_pqueue pq = { 0 };
-	struct reftable_record recs[54];
-	size_t N = ARRAY_SIZE(recs) - 1, i;
-	char *last = NULL;
-
-	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
-		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
-	}
-
-	i = 1;
-	do {
-		struct pq_entry e = {
-			.rec = &recs[i],
-		};
-
-		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(&pq);
-		i = (i * 7) % N;
-	} while (i != 1);
-
-	while (!merged_iter_pqueue_is_empty(pq)) {
-		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e;
-
-		check(!merged_iter_pqueue_remove(&pq, &e));
-		merged_iter_pqueue_check(&pq);
-
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
-		if (last)
-			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
-		last = e.rec->u.ref.refname;
-	}
-
-	for (i = 0; i < N; i++)
-		reftable_record_release(&recs[i]);
-	merged_iter_pqueue_release(&pq);
-}
-
-static void t_pq_index(void)
-{
-	struct merged_iter_pqueue pq = { 0 };
-	struct reftable_record recs[13];
-	char *last = NULL;
-	size_t N = ARRAY_SIZE(recs), i;
-
-	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
-		recs[i].u.ref.refname = (char *) "refs/heads/master";
-	}
-
-	i = 1;
-	do {
-		struct pq_entry e = {
-			.rec = &recs[i],
-			.index = i,
-		};
-
-		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(&pq);
-		i = (i * 7) % N;
-	} while (i != 1);
-
-	for (i = N - 1; i > 0; i--) {
-		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e;
-
-		check(!merged_iter_pqueue_remove(&pq, &e));
-		merged_iter_pqueue_check(&pq);
-
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
-		check_int(e.index, ==, i);
-		if (last)
-			check_str(last, e.rec->u.ref.refname);
-		last = e.rec->u.ref.refname;
-	}
-
-	merged_iter_pqueue_release(&pq);
-}
-
-static void t_merged_iter_pqueue_top(void)
-{
-	struct merged_iter_pqueue pq = { 0 };
-	struct reftable_record recs[13];
-	size_t N = ARRAY_SIZE(recs), i;
-
-	for (i = 0; i < N; i++) {
-		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
-		recs[i].u.ref.refname = (char *) "refs/heads/master";
-	}
-
-	i = 1;
-	do {
-		struct pq_entry e = {
-			.rec = &recs[i],
-			.index = i,
-		};
-
-		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(&pq);
-		i = (i * 7) % N;
-	} while (i != 1);
-
-	for (i = N - 1; i > 0; i--) {
-		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e;
-
-		check(!merged_iter_pqueue_remove(&pq, &e));
-
-		merged_iter_pqueue_check(&pq);
-		check(pq_entry_equal(&top, &e));
-		check(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1));
-		for (size_t j = 0; i < pq.len; j++) {
-			check(pq_less(&top, &pq.heap[j]));
-			check_int(top.index, >, j);
-		}
-	}
-
-	merged_iter_pqueue_release(&pq);
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_pq_record(), "pq works with record-based comparison");
-	TEST(t_pq_index(), "pq works with index-based comparison");
-	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-pq.c b/t/unit-tests/u-reftable-pq.c
new file mode 100644
index 0000000000..ecbf08586c
--- /dev/null
+++ b/t/unit-tests/u-reftable-pq.c
@@ -0,0 +1,152 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/constants.h"
+#include "reftable/pq.h"
+#include "strbuf.h"
+
+static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
+{
+	for (size_t i = 1; i < pq->len; i++) {
+		size_t parent = (i - 1) / 2;
+		cl_assert(pq_less(&pq->heap[parent], &pq->heap[i]) != 0);
+	}
+}
+
+static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
+{
+	int cmp;
+	cl_assert(reftable_record_cmp(a->rec, b->rec, &cmp) == 0);
+	return !cmp && (a->index == b->index);
+}
+
+void test_reftable_pq__record(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[54];
+	size_t N = ARRAY_SIZE(recs) - 1, i;
+	char *last = NULL;
+
+	for (i = 0; i < N; i++) {
+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
+		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e;
+
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
+		merged_iter_pqueue_check(&pq);
+
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		if (last)
+			cl_assert(strcmp(last, e.rec->u.ref.refname) < 0);
+		last = e.rec->u.ref.refname;
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+	merged_iter_pqueue_release(&pq);
+}
+
+void test_reftable_pq__index(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	char *last = NULL;
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
+		recs[i].u.ref.refname = (char *) "refs/heads/master";
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e;
+
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
+		merged_iter_pqueue_check(&pq);
+
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		cl_assert_equal_i(e.index, i);
+		if (last)
+			cl_assert_equal_s(last, e.rec->u.ref.refname);
+		last = e.rec->u.ref.refname;
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
+
+void test_reftable_pq__merged_iter_pqueue_top(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
+		recs[i].u.ref.refname = (char *) "refs/heads/master";
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e;
+
+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
+
+		merged_iter_pqueue_check(&pq);
+		cl_assert(pq_entry_equal(&top, &e) != 0);
+		cl_assert(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1) != 0);
+		for (size_t j = 0; i < pq.len; j++) {
+			cl_assert(pq_less(&top, &pq.heap[j]) != 0);
+			cl_assert(top.index > j);
+		}
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
-- 
2.43.0

