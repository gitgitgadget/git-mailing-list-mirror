Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB32522B4
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949248; cv=none; b=AO/mhXAkigB8SgnNcozenMfQJ0TWSk3CXMnwkjlAv0FLZgR+Gw+eKBm0/16ip15SAoFekBVtFVufAJvUvIsS7iB7LLIqyND6pcTlRR9MNUI8BunmP+Yt0f1q8DwHtAsM62f+vSEg1sLPUQ8hYWGB088jKs3AP9ba+oJa3aMx65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949248; c=relaxed/simple;
	bh=IOqtRo9JTQzjH4nSCtvNSh20DleY8RZ1dbRySpvmyN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blLcM4LaABaJCKPVuPrCnm01TKM1T7HpTjKh/zwKFh/byS9/4e1F5efJwHz/N5XpmF99ZYq3cKVFU8LwVqs05cOC8AHHaJqInpEmnMr4DTRBT0de8SwmrqNN/b2SAwkYEwS4+alsJKVPKdgPrq8iHWHh7uAotuvzApyerBMUH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d88YHJF/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d88YHJF/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39149bccb69so5309083f8f.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949244; x=1746554044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e977cQL+9yK9Ng4jRZGkFSvyM9Kl+Q8zpzoNeiqlWtQ=;
        b=d88YHJF/Tvy7854+vNdGPdYLpysXL+dd3rBAdSqUiEOZ3MillVvkHuTkeUe0QzYvJr
         fOrvhdzTOP9eeuEqFXvvg3plfzbP8JDlr+0teD9u/ygOtoFYhU4BZ9h+9S1RHTNnBzVm
         5syUSXqqt06Fudt6EbpqvhNdrdJieoriyD135t8e+2ZojDavOfd1r7INBWnjDxvKo7Wb
         9+rz9CiSbvYkXBViBPZrEpCrC5PbTq9m+nLkv3M7fyZh7o9DTqSuo1gMnwnKohK3003K
         nUsqeoIUFvKsXQ5ysqt8tJkEKAPGcbT4x1o5FqtTmIP92VAH/OSRxVdsUtT+sT4TwjbR
         PnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949244; x=1746554044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e977cQL+9yK9Ng4jRZGkFSvyM9Kl+Q8zpzoNeiqlWtQ=;
        b=Evo0cVNXnnlgoQAOTdsLJt2FQ/fcQXU9KFBJv6UMnPQwF5kZodOwSHRJziAyRmVzbF
         uYGNpB7u6jfYu7xdzokPqM3wbvuB9m3z+Uw62fRj5yFKo1LZQK8ka94NLldo7sChuEOh
         fc2pOOOi05FcUMb8lrcAsLNC0C7aLMw3Q4ogqoL2lAEqpi64noTCjJI5slYyTMr6nshM
         Dvo3Gc8Yf8+GlsJr+KW59VG9m8/nf+ftycbi4IEO3mB7wlOdynNdJrde+v+zpWVcYU3J
         6OIcosW36HbYtcO5nMArzMvdI37Juc5gB995lUSp2v+w2pZQ+gGIdbtubbu6NrL8uUo5
         3AEA==
X-Gm-Message-State: AOJu0YwxY2cMNmMfabD7oKvYn44EACTTL5B80mZEj2BkBkIJTnqjUcUr
	GdDptwuKeJCRQm6v7Xx6ofijcTF1sJZBYUJRrrrUB1p1KhaxlyCaXWfpgscImG43OQ==
X-Gm-Gg: ASbGnct5lz5hmfYelI4uc46RuufBRIuEee7z42uR385X9jzlRUSVfbtkjxrP0+9TXTw
	ztcfmSt6HOIE/vPu51E3PQlJRxuHiFu0dF7OHPl2JA6cVeU+/1kv3nJEy16SoiQ1l/JH3cvaxQY
	vPDKZA253QRabdWM2uGqD6dWqqfbkTLTvsVDlJzKq3RbXk3pgs4Pw8p7QfarObyDTlk5+ANN85i
	4lfxEMsBQyLSrG2SHduUrrNoUopvY3ye8G/Im1KieOjtFZdCJXxHw7Q6NfzoX3iiAn7b3+aAb7i
	Is1utRD9h4XtXIgBWUBWOPJ5ASGCOBsZo7k=
X-Google-Smtp-Source: AGHT+IGHI8hhEe7zpOj4MYYdiOMPtGTwhtPVMRoSsMdUvnZ/APnOzeT0VHvSpyADfzk8rBXHQpNKsw==
X-Received: by 2002:a5d:6484:0:b0:39f:4591:32bd with SMTP id ffacd0b85a97d-3a08f771e65mr212708f8f.34.1745949243399;
        Tue, 29 Apr 2025 10:54:03 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:54:02 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 08/10] t/unit-tests: convert reftable record test to use clar
Date: Tue, 29 Apr 2025 18:53:00 +0100
Message-ID: <20250429175302.23724-9-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429175302.23724-1-kuforiji98@gmail.com>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable record test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |   2 +-
 t/meson.build                    |   2 +-
 t/unit-tests/t-reftable-record.c | 585 -------------------------------
 t/unit-tests/u-reftable-record.c | 565 +++++++++++++++++++++++++++++
 4 files changed, 567 insertions(+), 587 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-record.c
 create mode 100644 t/unit-tests/u-reftable-record.c

diff --git a/Makefile b/Makefile
index 88b6851b37..cd9db9adf1 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,6 +1368,7 @@ CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-reader
 CLAR_TEST_SUITES += u-reftable-readwrite
+CLAR_TEST_SUITES += u-reftable-record
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1380,7 +1381,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/meson.build b/t/meson.build
index 7722d177e2..756cb2a2dd 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -14,6 +14,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-pq.c',
   'unit-tests/u-reftable-reader.c',
   'unit-tests/u-reftable-readwrite.c',
+  'unit-tests/u-reftable-record.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -60,7 +61,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
 ]
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
deleted file mode 100644
index 5954966373..0000000000
--- a/t/unit-tests/t-reftable-record.c
+++ /dev/null
@@ -1,585 +0,0 @@
-/*
-  Copyright 2020 Google LLC
-
-  Use of this source code is governed by a BSD-style
-  license that can be found in the LICENSE file or at
-  https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "test-lib.h"
-#include "reftable/basics.h"
-#include "reftable/constants.h"
-#include "reftable/record.h"
-
-static void t_copy(struct reftable_record *rec)
-{
-	struct reftable_record copy;
-	uint8_t typ;
-
-	typ = reftable_record_type(rec);
-	check(!reftable_record_init(&copy, typ));
-	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
-	/* do it twice to catch memory leaks */
-	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
-	check(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1));
-
-	reftable_record_release(&copy);
-}
-
-static void t_varint_roundtrip(void)
-{
-	uint64_t inputs[] = { 0,
-			      1,
-			      27,
-			      127,
-			      128,
-			      257,
-			      4096,
-			      ((uint64_t)1 << 63),
-			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
-
-	for (size_t i = 0; i < ARRAY_SIZE(inputs); i++) {
-		uint8_t dest[10];
-
-		struct string_view out = {
-			.buf = dest,
-			.len = sizeof(dest),
-		};
-		uint64_t in = inputs[i];
-		int n = put_var_int(&out, in);
-		uint64_t got = 0;
-
-		check_int(n, >, 0);
-		out.len = n;
-		n = get_var_int(&got, &out);
-		check_int(n, >, 0);
-
-		check_int(got, ==, in);
-	}
-}
-
-static void t_varint_overflow(void)
-{
-	unsigned char buf[] = {
-		0xFF, 0xFF, 0xFF, 0xFF,
-		0xFF, 0xFF, 0xFF, 0xFF,
-		0xFF, 0x00,
-	};
-	struct string_view view = {
-		.buf = buf,
-		.len = sizeof(buf),
-	};
-	uint64_t value;
-	int err = get_var_int(&value, &view);
-	check_int(err, ==, -1);
-}
-
-static void set_hash(uint8_t *h, int j)
-{
-	for (size_t i = 0; i < hash_size(REFTABLE_HASH_SHA1); i++)
-		h[i] = (j >> i) & 0xff;
-}
-
-static void t_reftable_ref_record_comparison(void)
-{
-	struct reftable_record in[3] = {
-		{
-			.type = BLOCK_TYPE_REF,
-			.u.ref.refname = (char *) "refs/heads/master",
-			.u.ref.value_type = REFTABLE_REF_VAL1,
-		},
-		{
-			.type = BLOCK_TYPE_REF,
-			.u.ref.refname = (char *) "refs/heads/master",
-			.u.ref.value_type = REFTABLE_REF_DELETION,
-		},
-		{
-			.type = BLOCK_TYPE_REF,
-			.u.ref.refname = (char *) "HEAD",
-			.u.ref.value_type = REFTABLE_REF_SYMREF,
-			.u.ref.value.symref = (char *) "refs/heads/master",
-		},
-	};
-	int cmp;
-
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
-
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
-
-	in[1].u.ref.value_type = in[0].u.ref.value_type;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
-}
-
-static void t_reftable_ref_record_compare_name(void)
-{
-	struct reftable_ref_record recs[3] = {
-		{
-			.refname = (char *) "refs/heads/a"
-		},
-		{
-			.refname = (char *) "refs/heads/b"
-		},
-		{
-			.refname = (char *) "refs/heads/a"
-		},
-	};
-
-	check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), <, 0);
-	check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), >, 0);
-	check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
-}
-
-static void t_reftable_ref_record_roundtrip(void)
-{
-	struct reftable_buf scratch = REFTABLE_BUF_INIT;
-
-	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
-		struct reftable_record in = {
-			.type = BLOCK_TYPE_REF,
-			.u.ref.value_type = i,
-		};
-		struct reftable_record out = { .type = BLOCK_TYPE_REF };
-		struct reftable_buf key = REFTABLE_BUF_INIT;
-		uint8_t buffer[1024] = { 0 };
-		struct string_view dest = {
-			.buf = buffer,
-			.len = sizeof(buffer),
-		};
-		int n, m;
-
-		in.u.ref.value_type = i;
-		switch (i) {
-		case REFTABLE_REF_DELETION:
-			break;
-		case REFTABLE_REF_VAL1:
-			set_hash(in.u.ref.value.val1, 1);
-			break;
-		case REFTABLE_REF_VAL2:
-			set_hash(in.u.ref.value.val2.value, 1);
-			set_hash(in.u.ref.value.val2.target_value, 2);
-			break;
-		case REFTABLE_REF_SYMREF:
-			in.u.ref.value.symref = xstrdup("target");
-			break;
-		}
-		in.u.ref.refname = xstrdup("refs/heads/master");
-
-		t_copy(&in);
-
-		check_int(reftable_record_val_type(&in), ==, i);
-		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
-
-		reftable_record_key(&in, &key);
-		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-		check_int(n, >, 0);
-
-		/* decode into a non-zero reftable_record to test for leaks. */
-		m = reftable_record_decode(&out, key, i, dest, REFTABLE_HASH_SIZE_SHA1, &scratch);
-		check_int(n, ==, m);
-
-		check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
-						 REFTABLE_HASH_SIZE_SHA1));
-		reftable_record_release(&in);
-
-		reftable_buf_release(&key);
-		reftable_record_release(&out);
-	}
-
-	reftable_buf_release(&scratch);
-}
-
-static void t_reftable_log_record_comparison(void)
-{
-	struct reftable_record in[3] = {
-		{
-			.type = BLOCK_TYPE_LOG,
-			.u.log.refname = (char *) "refs/heads/master",
-			.u.log.update_index = 42,
-		},
-		{
-			.type = BLOCK_TYPE_LOG,
-			.u.log.refname = (char *) "refs/heads/master",
-			.u.log.update_index = 22,
-		},
-		{
-			.type = BLOCK_TYPE_LOG,
-			.u.log.refname = (char *) "refs/heads/main",
-			.u.log.update_index = 22,
-		},
-	};
-	int cmp;
-
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
-	/* comparison should be reversed for equal keys, because
-	 * comparison is now performed on the basis of update indices */
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check_int(cmp, <, 0);
-
-	in[1].u.log.update_index = in[0].u.log.update_index;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-}
-
-static void t_reftable_log_record_compare_key(void)
-{
-	struct reftable_log_record logs[3] = {
-		{
-			.refname = (char *) "refs/heads/a",
-			.update_index = 1,
-		},
-		{
-			.refname = (char *) "refs/heads/b",
-			.update_index = 2,
-		},
-		{
-			.refname = (char *) "refs/heads/a",
-			.update_index = 3,
-		},
-	};
-
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
-	check_int(reftable_log_record_compare_key(&logs[1], &logs[0]), >, 0);
-
-	logs[1].update_index = logs[0].update_index;
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
-
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), >, 0);
-	check_int(reftable_log_record_compare_key(&logs[2], &logs[0]), <, 0);
-	logs[2].update_index = logs[0].update_index;
-	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), ==, 0);
-}
-
-static void t_reftable_log_record_roundtrip(void)
-{
-	struct reftable_log_record in[] = {
-		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 42,
-			.value_type = REFTABLE_LOG_UPDATE,
-			.value = {
-				.update = {
-					.name = xstrdup("han-wen"),
-					.email = xstrdup("hanwen@google.com"),
-					.message = xstrdup("test"),
-					.time = 1577123507,
-					.tz_offset = 100,
-				},
-			}
-		},
-		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 22,
-			.value_type = REFTABLE_LOG_DELETION,
-		},
-		{
-			.refname = xstrdup("branch"),
-			.update_index = 33,
-			.value_type = REFTABLE_LOG_UPDATE,
-		}
-	};
-	struct reftable_buf scratch = REFTABLE_BUF_INIT;
-	set_hash(in[0].value.update.new_hash, 1);
-	set_hash(in[0].value.update.old_hash, 2);
-	set_hash(in[2].value.update.new_hash, 3);
-	set_hash(in[2].value.update.old_hash, 4);
-
-	check(!reftable_log_record_is_deletion(&in[0]));
-	check(reftable_log_record_is_deletion(&in[1]));
-	check(!reftable_log_record_is_deletion(&in[2]));
-
-	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
-		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
-		struct reftable_buf key = REFTABLE_BUF_INIT;
-		uint8_t buffer[1024] = { 0 };
-		struct string_view dest = {
-			.buf = buffer,
-			.len = sizeof(buffer),
-		};
-		/* populate out, to check for leaks. */
-		struct reftable_record out = {
-			.type = BLOCK_TYPE_LOG,
-			.u.log = {
-				.refname = xstrdup("old name"),
-				.value_type = REFTABLE_LOG_UPDATE,
-				.value = {
-					.update = {
-						.name = xstrdup("old name"),
-						.email = xstrdup("old@email"),
-						.message = xstrdup("old message"),
-					},
-				},
-			},
-		};
-		int n, m, valtype;
-
-		rec.u.log = in[i];
-
-		t_copy(&rec);
-
-		reftable_record_key(&rec, &key);
-
-		n = reftable_record_encode(&rec, dest, REFTABLE_HASH_SIZE_SHA1);
-		check_int(n, >=, 0);
-		valtype = reftable_record_val_type(&rec);
-		m = reftable_record_decode(&out, key, valtype, dest,
-					   REFTABLE_HASH_SIZE_SHA1, &scratch);
-		check_int(n, ==, m);
-
-		check(reftable_log_record_equal(&in[i], &out.u.log,
-						 REFTABLE_HASH_SIZE_SHA1));
-		reftable_log_record_release(&in[i]);
-		reftable_buf_release(&key);
-		reftable_record_release(&out);
-	}
-
-	reftable_buf_release(&scratch);
-}
-
-static void t_key_roundtrip(void)
-{
-	uint8_t buffer[1024] = { 0 };
-	struct string_view dest = {
-		.buf = buffer,
-		.len = sizeof(buffer),
-	};
-	struct reftable_buf last_key = REFTABLE_BUF_INIT;
-	struct reftable_buf key = REFTABLE_BUF_INIT;
-	struct reftable_buf roundtrip = REFTABLE_BUF_INIT;
-	int restart;
-	uint8_t extra;
-	int n, m;
-	uint8_t rt_extra;
-
-	check(!reftable_buf_addstr(&last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&key, "refs/tags/bla"));
-	extra = 6;
-	n = reftable_encode_key(&restart, dest, last_key, key, extra);
-	check(!restart);
-	check_int(n, >, 0);
-
-	check(!reftable_buf_addstr(&roundtrip, "refs/heads/master"));
-	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
-	check_int(n, ==, m);
-	check(!reftable_buf_cmp(&key, &roundtrip));
-	check_int(rt_extra, ==, extra);
-
-	reftable_buf_release(&last_key);
-	reftable_buf_release(&key);
-	reftable_buf_release(&roundtrip);
-}
-
-static void t_reftable_obj_record_comparison(void)
-{
-
-	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
-	uint64_t offsets[] = { 0, 16, 32, 48, 64, 80, 96, 112};
-	struct reftable_record in[3] = {
-		{
-			.type = BLOCK_TYPE_OBJ,
-			.u.obj.hash_prefix = id_bytes,
-			.u.obj.hash_prefix_len = 7,
-			.u.obj.offsets = offsets,
-			.u.obj.offset_len = 8,
-		},
-		{
-			.type = BLOCK_TYPE_OBJ,
-			.u.obj.hash_prefix = id_bytes,
-			.u.obj.hash_prefix_len = 7,
-			.u.obj.offsets = offsets,
-			.u.obj.offset_len = 5,
-		},
-		{
-			.type = BLOCK_TYPE_OBJ,
-			.u.obj.hash_prefix = id_bytes,
-			.u.obj.hash_prefix_len = 5,
-		},
-	};
-	int cmp;
-
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
-
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
-
-	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
-}
-
-static void t_reftable_obj_record_roundtrip(void)
-{
-	uint8_t testHash1[REFTABLE_HASH_SIZE_SHA1] = { 1, 2, 3, 4, 0 };
-	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
-	struct reftable_obj_record recs[3] = {
-		{
-			.hash_prefix = testHash1,
-			.hash_prefix_len = 5,
-			.offsets = till9,
-			.offset_len = 3,
-		},
-		{
-			.hash_prefix = testHash1,
-			.hash_prefix_len = 5,
-			.offsets = till9,
-			.offset_len = 9,
-		},
-		{
-			.hash_prefix = testHash1,
-			.hash_prefix_len = 5,
-		},
-	};
-	struct reftable_buf scratch = REFTABLE_BUF_INIT;
-
-	for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
-		uint8_t buffer[1024] = { 0 };
-		struct string_view dest = {
-			.buf = buffer,
-			.len = sizeof(buffer),
-		};
-		struct reftable_record in = {
-			.type = BLOCK_TYPE_OBJ,
-			.u = {
-				.obj = recs[i],
-			},
-		};
-		struct reftable_buf key = REFTABLE_BUF_INIT;
-		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
-		int n, m;
-		uint8_t extra;
-
-		check(!reftable_record_is_deletion(&in));
-		t_copy(&in);
-		reftable_record_key(&in, &key);
-		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-		check_int(n, >, 0);
-		extra = reftable_record_val_type(&in);
-		m = reftable_record_decode(&out, key, extra, dest,
-					   REFTABLE_HASH_SIZE_SHA1, &scratch);
-		check_int(n, ==, m);
-
-		check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
-		reftable_buf_release(&key);
-		reftable_record_release(&out);
-	}
-
-	reftable_buf_release(&scratch);
-}
-
-static void t_reftable_index_record_comparison(void)
-{
-	struct reftable_record in[3] = {
-		{
-			.type = BLOCK_TYPE_INDEX,
-			.u.idx.offset = 22,
-			.u.idx.last_key = REFTABLE_BUF_INIT,
-		},
-		{
-			.type = BLOCK_TYPE_INDEX,
-			.u.idx.offset = 32,
-			.u.idx.last_key = REFTABLE_BUF_INIT,
-		},
-		{
-			.type = BLOCK_TYPE_INDEX,
-			.u.idx.offset = 32,
-			.u.idx.last_key = REFTABLE_BUF_INIT,
-		},
-	};
-	int cmp;
-
-	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
-	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
-
-	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
-
-	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
-	check_int(cmp, >, 0);
-
-	in[1].u.idx.offset = in[0].u.idx.offset;
-	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
-	check(!cmp);
-
-	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
-		reftable_record_release(&in[i]);
-}
-
-static void t_reftable_index_record_roundtrip(void)
-{
-	struct reftable_record in = {
-		.type = BLOCK_TYPE_INDEX,
-		.u.idx = {
-			.offset = 42,
-			.last_key = REFTABLE_BUF_INIT,
-		},
-	};
-	uint8_t buffer[1024] = { 0 };
-	struct string_view dest = {
-		.buf = buffer,
-		.len = sizeof(buffer),
-	};
-	struct reftable_buf scratch = REFTABLE_BUF_INIT;
-	struct reftable_buf key = REFTABLE_BUF_INIT;
-	struct reftable_record out = {
-		.type = BLOCK_TYPE_INDEX,
-		.u.idx = { .last_key = REFTABLE_BUF_INIT },
-	};
-	int n, m;
-	uint8_t extra;
-
-	check(!reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master"));
-	reftable_record_key(&in, &key);
-	t_copy(&in);
-
-	check(!reftable_record_is_deletion(&in));
-	check(!reftable_buf_cmp(&key, &in.u.idx.last_key));
-	n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-	check_int(n, >, 0);
-
-	extra = reftable_record_val_type(&in);
-	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
-				   &scratch);
-	check_int(m, ==, n);
-
-	check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
-
-	reftable_record_release(&out);
-	reftable_buf_release(&key);
-	reftable_buf_release(&scratch);
-	reftable_buf_release(&in.u.idx.last_key);
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
-	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
-	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
-	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
-	TEST(t_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
-	TEST(t_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
-	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
-	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
-	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-	TEST(t_varint_overflow(), "get_var_int notices an integer overflow");
-	TEST(t_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
-	TEST(t_reftable_obj_record_roundtrip(), "record operations work on obj record");
-	TEST(t_reftable_index_record_roundtrip(), "record operations work on index record");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
new file mode 100644
index 0000000000..ac2e33584c
--- /dev/null
+++ b/t/unit-tests/u-reftable-record.c
@@ -0,0 +1,565 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "unit-test.h"
+#include "reftable/basics.h"
+#include "reftable/constants.h"
+#include "reftable/record.h"
+
+static void t_copy(struct reftable_record *rec)
+{
+	struct reftable_record copy;
+	uint8_t typ;
+
+	typ = reftable_record_type(rec);
+	cl_assert(reftable_record_init(&copy, typ) == 0);
+	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
+	/* do it twice to catch memory leaks */
+	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
+	cl_assert(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1) != 0);
+
+	reftable_record_release(&copy);
+}
+
+void test_reftable_record__varint_roundtrip(void)
+{
+	uint64_t inputs[] = { 0,
+			      1,
+			      27,
+			      127,
+			      128,
+			      257,
+			      4096,
+			      ((uint64_t)1 << 63),
+			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
+
+	for (size_t i = 0; i < ARRAY_SIZE(inputs); i++) {
+		uint8_t dest[10];
+
+		struct string_view out = {
+			.buf = dest,
+			.len = sizeof(dest),
+		};
+		uint64_t in = inputs[i];
+		int n = put_var_int(&out, in);
+		uint64_t got = 0;
+
+		cl_assert(n > 0);
+		out.len = n;
+		n = get_var_int(&got, &out);
+		cl_assert(n > 0);
+
+		cl_assert_equal_i(got, in);
+	}
+}
+
+void test_reftable_record__varint_overflow(void)
+{
+	unsigned char buf[] = {
+		0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0x00,
+	};
+	struct string_view view = {
+		.buf = buf,
+		.len = sizeof(buf),
+	};
+	uint64_t value;
+	cl_assert_equal_i(get_var_int(&value, &view), -1);
+}
+
+static void set_hash(uint8_t *h, int j)
+{
+	for (size_t i = 0; i < hash_size(REFTABLE_HASH_SHA1); i++)
+		h[i] = (j >> i) & 0xff;
+}
+
+void test_reftable_record__ref_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = (char *) "refs/heads/master",
+			.u.ref.value_type = REFTABLE_REF_VAL1,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = (char *) "refs/heads/master",
+			.u.ref.value_type = REFTABLE_REF_DELETION,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = (char *) "HEAD",
+			.u.ref.value_type = REFTABLE_REF_SYMREF,
+			.u.ref.value.symref = (char *) "refs/heads/master",
+		},
+	};
+	int cmp;
+
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
+
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
+
+	in[1].u.ref.value_type = in[0].u.ref.value_type;
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
+}
+
+void test_reftable_record__ref_record_compare_name(void)
+{
+	struct reftable_ref_record recs[3] = {
+		{
+			.refname = (char *) "refs/heads/a"
+		},
+		{
+			.refname = (char *) "refs/heads/b"
+		},
+		{
+			.refname = (char *) "refs/heads/a"
+		},
+	};
+
+	cl_assert(reftable_ref_record_compare_name(&recs[0], &recs[1]) < 0);
+	cl_assert(reftable_ref_record_compare_name(&recs[1], &recs[0]) > 0);
+	cl_assert_equal_i(reftable_ref_record_compare_name(&recs[0], &recs[2]), 0);
+}
+
+void test_reftable_record__ref_record_roundtrip(void)
+{
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+
+	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
+		struct reftable_record in = {
+			.type = BLOCK_TYPE_REF,
+			.u.ref.value_type = i,
+		};
+		struct reftable_record out = { .type = BLOCK_TYPE_REF };
+		struct reftable_buf key = REFTABLE_BUF_INIT;
+		uint8_t buffer[1024] = { 0 };
+		struct string_view dest = {
+			.buf = buffer,
+			.len = sizeof(buffer),
+		};
+		int n, m;
+
+		in.u.ref.value_type = i;
+		switch (i) {
+		case REFTABLE_REF_DELETION:
+			break;
+		case REFTABLE_REF_VAL1:
+			set_hash(in.u.ref.value.val1, 1);
+			break;
+		case REFTABLE_REF_VAL2:
+			set_hash(in.u.ref.value.val2.value, 1);
+			set_hash(in.u.ref.value.val2.target_value, 2);
+			break;
+		case REFTABLE_REF_SYMREF:
+			in.u.ref.value.symref = xstrdup("target");
+			break;
+		}
+		in.u.ref.refname = xstrdup("refs/heads/master");
+
+		t_copy(&in);
+
+		cl_assert_equal_i(reftable_record_val_type(&in), i);
+		cl_assert_equal_i(reftable_record_is_deletion(&in),  i == REFTABLE_REF_DELETION);
+
+		reftable_record_key(&in, &key);
+		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
+		cl_assert(n > 0);
+
+		/* decode into a non-zero reftable_record to test for leaks. */
+		m = reftable_record_decode(&out, key, i, dest, REFTABLE_HASH_SIZE_SHA1, &scratch);
+		cl_assert_equal_i(n, m);
+
+		cl_assert(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
+											REFTABLE_HASH_SIZE_SHA1) != 0);
+		reftable_record_release(&in);
+
+		reftable_buf_release(&key);
+		reftable_record_release(&out);
+	}
+
+	reftable_buf_release(&scratch);
+}
+
+void test_reftable_record__log_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/master",
+			.u.log.update_index = 42,
+		},
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/master",
+			.u.log.update_index = 22,
+		},
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/main",
+			.u.log.update_index = 22,
+		},
+	};
+	int cmp;
+
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
+	/* comparison should be reversed for equal keys, because
+	 * comparison is now performed on the basis of update indices */
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp < 0);
+
+	in[1].u.log.update_index = in[0].u.log.update_index;
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+}
+
+void test_reftable_record__log_record_compare_key(void)
+{
+	struct reftable_log_record logs[3] = {
+		{
+			.refname = (char *) "refs/heads/a",
+			.update_index = 1,
+		},
+		{
+			.refname = (char *) "refs/heads/b",
+			.update_index = 2,
+		},
+		{
+			.refname = (char *) "refs/heads/a",
+			.update_index = 3,
+		},
+	};
+
+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[1]) < 0);
+	cl_assert(reftable_log_record_compare_key(&logs[1], &logs[0]) > 0);
+
+	logs[1].update_index = logs[0].update_index;
+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[1]) < 0);
+
+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[2]) > 0);
+	cl_assert(reftable_log_record_compare_key(&logs[2], &logs[0]) < 0);
+	logs[2].update_index = logs[0].update_index;
+	cl_assert_equal_i(reftable_log_record_compare_key(&logs[0], &logs[2]), 0);
+}
+
+void test_reftable_record__log_record_roundtrip(void)
+{
+	struct reftable_log_record in[] = {
+		{
+			.refname = xstrdup("refs/heads/master"),
+			.update_index = 42,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = {
+				.update = {
+					.name = xstrdup("han-wen"),
+					.email = xstrdup("hanwen@google.com"),
+					.message = xstrdup("test"),
+					.time = 1577123507,
+					.tz_offset = 100,
+				},
+			}
+		},
+		{
+			.refname = xstrdup("refs/heads/master"),
+			.update_index = 22,
+			.value_type = REFTABLE_LOG_DELETION,
+		},
+		{
+			.refname = xstrdup("branch"),
+			.update_index = 33,
+			.value_type = REFTABLE_LOG_UPDATE,
+		}
+	};
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+	set_hash(in[0].value.update.new_hash, 1);
+	set_hash(in[0].value.update.old_hash, 2);
+	set_hash(in[2].value.update.new_hash, 3);
+	set_hash(in[2].value.update.old_hash, 4);
+
+	cl_assert(reftable_log_record_is_deletion(&in[0]) == 0);
+	cl_assert(reftable_log_record_is_deletion(&in[1]) != 0);
+	cl_assert(reftable_log_record_is_deletion(&in[2]) == 0);
+
+	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
+		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
+		struct reftable_buf key = REFTABLE_BUF_INIT;
+		uint8_t buffer[1024] = { 0 };
+		struct string_view dest = {
+			.buf = buffer,
+			.len = sizeof(buffer),
+		};
+		/* populate out, to check for leaks. */
+		struct reftable_record out = {
+			.type = BLOCK_TYPE_LOG,
+			.u.log = {
+				.refname = xstrdup("old name"),
+				.value_type = REFTABLE_LOG_UPDATE,
+				.value = {
+					.update = {
+						.name = xstrdup("old name"),
+						.email = xstrdup("old@email"),
+						.message = xstrdup("old message"),
+					},
+				},
+			},
+		};
+		int n, m, valtype;
+
+		rec.u.log = in[i];
+
+		t_copy(&rec);
+
+		reftable_record_key(&rec, &key);
+
+		n = reftable_record_encode(&rec, dest, REFTABLE_HASH_SIZE_SHA1);
+		cl_assert(n >= 0);
+		valtype = reftable_record_val_type(&rec);
+		m = reftable_record_decode(&out, key, valtype, dest,
+					   REFTABLE_HASH_SIZE_SHA1, &scratch);
+		cl_assert_equal_i(n, m);
+
+		cl_assert(reftable_log_record_equal(&in[i], &out.u.log,
+											REFTABLE_HASH_SIZE_SHA1) != 0);
+		reftable_log_record_release(&in[i]);
+		reftable_buf_release(&key);
+		reftable_record_release(&out);
+	}
+
+	reftable_buf_release(&scratch);
+}
+
+void test_reftable_record__key_roundtrip(void)
+{
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+	struct reftable_buf last_key = REFTABLE_BUF_INIT;
+	struct reftable_buf key = REFTABLE_BUF_INIT;
+	struct reftable_buf roundtrip = REFTABLE_BUF_INIT;
+	int restart;
+	uint8_t extra;
+	int n, m;
+	uint8_t rt_extra;
+
+	cl_assert(reftable_buf_addstr(&last_key, "refs/heads/master") == 0);
+	cl_assert(reftable_buf_addstr(&key, "refs/tags/bla") == 0);
+	extra = 6;
+	n = reftable_encode_key(&restart, dest, last_key, key, extra);
+	cl_assert(restart == 0);
+	cl_assert(n > 0);
+
+	cl_assert(reftable_buf_addstr(&roundtrip, "refs/heads/master") == 0);
+	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
+	cl_assert_equal_i(n, m);
+	cl_assert(reftable_buf_cmp(&key, &roundtrip) == 0);
+	cl_assert_equal_i(rt_extra, extra);
+
+	reftable_buf_release(&last_key);
+	reftable_buf_release(&key);
+	reftable_buf_release(&roundtrip);
+}
+
+void test_reftable_record__obj_record_comparison(void)
+{
+
+	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
+	uint64_t offsets[] = { 0, 16, 32, 48, 64, 80, 96, 112};
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 8,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 5,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 5,
+		},
+	};
+	int cmp;
+
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
+
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
+
+	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
+}
+
+void test_reftable_record__obj_record_roundtrip(void)
+{
+	uint8_t testHash1[REFTABLE_HASH_SIZE_SHA1] = { 1, 2, 3, 4, 0 };
+	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
+	struct reftable_obj_record recs[3] = {
+		{
+			.hash_prefix = testHash1,
+			.hash_prefix_len = 5,
+			.offsets = till9,
+			.offset_len = 3,
+		},
+		{
+			.hash_prefix = testHash1,
+			.hash_prefix_len = 5,
+			.offsets = till9,
+			.offset_len = 9,
+		},
+		{
+			.hash_prefix = testHash1,
+			.hash_prefix_len = 5,
+		},
+	};
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+
+	for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
+		uint8_t buffer[1024] = { 0 };
+		struct string_view dest = {
+			.buf = buffer,
+			.len = sizeof(buffer),
+		};
+		struct reftable_record in = {
+			.type = BLOCK_TYPE_OBJ,
+			.u = {
+				.obj = recs[i],
+			},
+		};
+		struct reftable_buf key = REFTABLE_BUF_INIT;
+		struct reftable_record out = { .type = BLOCK_TYPE_OBJ };
+		int n, m;
+		uint8_t extra;
+
+		cl_assert(reftable_record_is_deletion(&in) == 0);
+		t_copy(&in);
+		reftable_record_key(&in, &key);
+		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
+		cl_assert(n > 0);
+		extra = reftable_record_val_type(&in);
+		m = reftable_record_decode(&out, key, extra, dest,
+					   REFTABLE_HASH_SIZE_SHA1, &scratch);
+		cl_assert_equal_i(n, m);
+
+		cl_assert(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1) != 0);
+		reftable_buf_release(&key);
+		reftable_record_release(&out);
+	}
+
+	reftable_buf_release(&scratch);
+}
+
+void test_reftable_record__index_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_INDEX,
+			.u.idx.offset = 22,
+			.u.idx.last_key = REFTABLE_BUF_INIT,
+		},
+		{
+			.type = BLOCK_TYPE_INDEX,
+			.u.idx.offset = 32,
+			.u.idx.last_key = REFTABLE_BUF_INIT,
+		},
+		{
+			.type = BLOCK_TYPE_INDEX,
+			.u.idx.offset = 32,
+			.u.idx.last_key = REFTABLE_BUF_INIT,
+		},
+	};
+	int cmp;
+
+	cl_assert(reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master") == 0);
+	cl_assert(reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master") == 0);
+	cl_assert(reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch") == 0);
+
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
+
+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
+	cl_assert(cmp > 0);
+
+	in[1].u.idx.offset = in[0].u.idx.offset;
+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
+	cl_assert(cmp == 0);
+
+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
+		reftable_record_release(&in[i]);
+}
+
+void test_reftable_record__index_record_roundtrip(void)
+{
+	struct reftable_record in = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = {
+			.offset = 42,
+			.last_key = REFTABLE_BUF_INIT,
+		},
+	};
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+	struct reftable_buf key = REFTABLE_BUF_INIT;
+	struct reftable_record out = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx = { .last_key = REFTABLE_BUF_INIT },
+	};
+	int n, m;
+	uint8_t extra;
+
+	cl_assert(reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master") == 0);
+	reftable_record_key(&in, &key);
+	t_copy(&in);
+
+	cl_assert(reftable_record_is_deletion(&in) == 0);
+	cl_assert(reftable_buf_cmp(&key, &in.u.idx.last_key) == 0);
+	n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
+	cl_assert(n > 0);
+
+	extra = reftable_record_val_type(&in);
+	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
+				   &scratch);
+	cl_assert_equal_i(m, n);
+
+	cl_assert(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1) != 0);
+
+	reftable_record_release(&out);
+	reftable_buf_release(&key);
+	reftable_buf_release(&scratch);
+	reftable_buf_release(&in.u.idx.last_key);
+}
-- 
2.43.0

