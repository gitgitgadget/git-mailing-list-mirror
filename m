Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55C253F21
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949239; cv=none; b=OCCGgHIZ7l9/3NKDAROasuFVdVqKVqC5FEP0beWWb1QVnT9USe93QIZpED2jh9PkgGR6I6ubuQD7xrlAj4cMqUXqnYYDm63UqSWoqAWeeMDJwJn24Q3CwOF1RRqZnUqljEMS9ia4EVavyofMBWNrMWbNjCchenPqPZ0fyq+F8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949239; c=relaxed/simple;
	bh=XMmqKt2F9cK446ihknqIw7ThFEh2/Mf+Fp46HxrAihc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma/7c3Pijy5L5yTPp/hfUDPa1MBcnk0ggXLPjYxtPGqe6fNVIJ7Y7uoaEb0Q5se3NmKrszQgobAh8o5Hb2cuXmqRUM86Tzm+2vfZ/aOy7reT8x5hYWNP5ckd33VtwnoAQ+z9emzfyWtAYxmLT0QGTnkkjldcy73vU/bIsoK6FbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/mV9/BU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/mV9/BU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso40620415e9.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949235; x=1746554035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPRgWBpSFFNUCr54GefMQlumQ3GQzXpDEesBKo816Ko=;
        b=N/mV9/BU0EjYuKsc2fN1HEmURvkerhCfH8YITyq0ve84dcWmJ9T1Y5hgKnDS0Gt8IN
         Io/lOEy/j1MHUNlgyL7HZK3gsepd3TC0XyPSe/3XtxzUhiRAINdoOiFz4EJqt60NFDxy
         P4IdYk2aoWgn7rVjItIWWbxXCP2P4lttG1rhWc4ECoc6sekqc6EM5xJsw0Nzck7flIKT
         QER75Qf2v0pG2I8dgNghO5UvOh2dfQc7C5aKWkI9VZK9DGqOyl2FmSBzcl1xCb/vLkGZ
         rWDvcbVO59GcTTcGTQoENRz97QuWyS81sxDSeopAcUugSP+ZAkHaitySNI/xZTeT5bJ5
         ccIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949235; x=1746554035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPRgWBpSFFNUCr54GefMQlumQ3GQzXpDEesBKo816Ko=;
        b=CKe52DoO3JEXxNktOJx9a4uagQIaLjWe4QYf78rHQ4Lpihq1Qr8aCBV1AqAn6fgUIC
         5nZI8goAFvzngAgMZnjBWLJD9bhJc6ZxpegWFvLtWsOs2o/PePf9SxDBhw+SZgZ137HA
         15M1pOrPncvaFrwY9uF+N7J1/jMrX4fv+rmWebuq6UX/Twlj1aDBrUBkPcUURTxdTcJK
         8pGFTR3RsVmCejaI5eCum1boolXFZEeJEY71up1NXuCuKgsxMExjeR/JvytrXGDlPV7S
         zvVUY8XaBM5i+7EqRtTuCjzS3w8k5V1RhCgmkKMyQvF2Qchz2m+u7lpbjzy92qefd2KA
         PT1w==
X-Gm-Message-State: AOJu0Yw1XCrInDRYjq8QrU02SH9n67fkMIdecUdXS3B2HBRpF8wihDaN
	OhRnN5Yk+NJuN0wTJJoE5Ow2h5HQmdkyMvap2kl8jT9C2pP1+evHz1RfRFqDamku4w==
X-Gm-Gg: ASbGncsDKHSsYrJ/MNCLrDs+qgFf+0HAnLwQ/yzrwWEdB2BKueFepr2V9VZHvpjEvjF
	3Ek3tm7+cxmqs5UGCtgOaQ0vuIlZuOQtFycTiuTIBBzWMdAKUPNJyErgXyYhdWg1yWQGZXXKZsO
	0naD9+MREPJsy1ovGQQXYvpNDXjp/8rzBb5Zt9lQstnzk8M+8fPVPkC2sw8jfcZZBZOujQfORj2
	vY6XBZjrAkDGJOhieplc0r2pE4Tqpx6QAnLg96IkO7QkFDAg+aOsFUNNXAHBiZuGA2U328P246I
	1lxSICXJdlohN7wdzBI4Zf0KMt4s32Gs+b0=
X-Google-Smtp-Source: AGHT+IFXm9VZij1/sMwJgrugd0dWKplCSOXu+KOT4xs4U5lAYY2sIK/kuDU4LJw7IsVFdga2SXfxEw==
X-Received: by 2002:a05:600c:4e55:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-441b1f61925mr1647175e9.27.1745949235107;
        Tue, 29 Apr 2025 10:53:55 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:54 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 06/10] t/unit-tests: convert reftable reader test to use clar
Date: Tue, 29 Apr 2025 18:52:58 +0100
Message-ID: <20250429175302.23724-7-kuforiji98@gmail.com>
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

Adapt reftable reader test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |  2 +-
 t/meson.build                    |  2 +-
 t/unit-tests/t-reftable-reader.c | 96 --------------------------------
 t/unit-tests/u-reftable-reader.c | 78 ++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 98 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-reader.c
 create mode 100644 t/unit-tests/u-reftable-reader.c

diff --git a/Makefile b/Makefile
index 4142927d0a..d3e8677653 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,6 +1366,7 @@ CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
+CLAR_TEST_SUITES += u-reftable-reader
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1378,7 +1379,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
-UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
diff --git a/t/meson.build b/t/meson.build
index 9bded2d15c..6a22bd2790 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -12,6 +12,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-pq.c',
+  'unit-tests/u-reftable-reader.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -58,7 +59,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
deleted file mode 100644
index 546df6005e..0000000000
--- a/t/unit-tests/t-reftable-reader.c
+++ /dev/null
@@ -1,96 +0,0 @@
-#include "test-lib.h"
-#include "lib-reftable.h"
-#include "reftable/blocksource.h"
-#include "reftable/reader.h"
-
-static int t_reader_seek_once(void)
-{
-	struct reftable_ref_record records[] = {
-		{
-			.refname = (char *) "refs/heads/main",
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 42 },
-		},
-	};
-	struct reftable_block_source source = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int ret;
-
-	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_buf(&source, &buf);
-
-	ret = reftable_reader_new(&reader, &source, "name");
-	check(!ret);
-
-	reftable_reader_init_ref_iterator(reader, &it);
-	ret = reftable_iterator_seek_ref(&it, "");
-	check(!ret);
-	ret = reftable_iterator_next_ref(&it, &ref);
-	check(!ret);
-
-	ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
-	check_int(ret, ==, 1);
-
-	ret = reftable_iterator_next_ref(&it, &ref);
-	check_int(ret, ==, 1);
-
-	reftable_ref_record_release(&ref);
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-	return 0;
-}
-
-static int t_reader_reseek(void)
-{
-	struct reftable_ref_record records[] = {
-		{
-			.refname = (char *) "refs/heads/main",
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 42 },
-		},
-	};
-	struct reftable_block_source source = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int ret;
-
-	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_buf(&source, &buf);
-
-	ret = reftable_reader_new(&reader, &source, "name");
-	check(!ret);
-
-	reftable_reader_init_ref_iterator(reader, &it);
-
-	for (size_t i = 0; i < 5; i++) {
-		ret = reftable_iterator_seek_ref(&it, "");
-		check(!ret);
-		ret = reftable_iterator_next_ref(&it, &ref);
-		check(!ret);
-
-		ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
-		check_int(ret, ==, 1);
-
-		ret = reftable_iterator_next_ref(&it, &ref);
-		check_int(ret, ==, 1);
-	}
-
-	reftable_ref_record_release(&ref);
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-	return 0;
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_reader_seek_once(), "reader can seek once");
-	TEST(t_reader_reseek(), "reader can reseek multiple times");
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-reader.c b/t/unit-tests/u-reftable-reader.c
new file mode 100644
index 0000000000..6c35063105
--- /dev/null
+++ b/t/unit-tests/u-reftable-reader.c
@@ -0,0 +1,78 @@
+#include "unit-test.h"
+#include "lib-reftable.h"
+#include "reftable/blocksource.h"
+#include "reftable/reader.h"
+
+void test_reftable_reader__seek_once(void)
+{
+	struct reftable_ref_record records[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "name") == 0);
+
+
+	reftable_reader_init_ref_iterator(reader, &it);
+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
+
+	cl_assert_equal_i(reftable_ref_record_equal(&ref, &records[0],
+												REFTABLE_HASH_SIZE_SHA1), 1);
+
+	cl_assert_equal_i(reftable_iterator_next_ref(&it, &ref), 1);
+
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_reader__reseek(void)
+{
+	struct reftable_ref_record records[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "name") == 0);
+
+	reftable_reader_init_ref_iterator(reader, &it);
+
+	for (size_t i = 0; i < 5; i++) {
+		cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+		cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
+
+		cl_assert_equal_i(reftable_ref_record_equal(&ref, &records[0],
+													REFTABLE_HASH_SIZE_SHA1), 1);
+
+		cl_assert_equal_i(reftable_iterator_next_ref(&it, &ref), 1);
+	}
+
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+}
-- 
2.43.0

