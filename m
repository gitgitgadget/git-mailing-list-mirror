Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F801FECA1
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116989; cv=none; b=EwXX86/mydf3Njx8lY6pNphokCBJI2xzcHMi9nXlEKCJ/bRzk3BqBgLMn6VAUUr/X3HQUsurwJ4ZcCIVcVz8cHwOtX/u+gWuQPRItk8Ua6M9Kt/rizVx3/eA2J0OIExij25AY6K16wfmFYM2ti+mlQsnpLfvMONZtN4GJkqWJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116989; c=relaxed/simple;
	bh=6K/e8WYJqsLYizO+fJi/1H/TJJqTyblk3zV47tvHNKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqzE+mXbkekHb6HgFhbcNBtcF+Jeb3fszb0ix62LcjE5AYp4ziD+I1pyljquKXK3Mrwy/tbmGhbeCLI8jWxvwaI92jKvovf27m9idnSVh/uQ1awwXMtSnuiHx9NjZI9JN8XKSTrQ2eWidE9bMhynqaSy1p5BpdShIlU7jJTLiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSnkv+Yo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSnkv+Yo"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso342213866b.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 04:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737116985; x=1737721785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdMNfYg/Nq9UYuGTGNO4U1NkxgEnTvWULcXRtGl+3jY=;
        b=cSnkv+Yo8y61r/Z/bJTChGTV1fo76BElKigUMrz/PnG1si96DZyC5Ihitjhiu5iVeU
         dEzfhnpWHqmX6uLTamoM7cWL5CMVX5mkm4i2UjWACtdolzPOXvCuyu87hxEYusS9En9j
         UsesaKWDtPZ2A9c6ohzOzEXuVenhiSisdkKtsinQO10SVFxyaOqmVTLchOuitKhjJq3g
         9xzmQ+rlNBZOmj+G94QfEBVW883wR+a3SvSMh1fItPI0JJ7vbEuTtkq+6qzGaMdl3qX7
         9wQ2tT31GWu/bbiWPnFtBFUY7q/GCxAFTp4ZrIS4yJGPKG3ldoTDNSsz1CEI/+RApYhl
         W/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116985; x=1737721785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdMNfYg/Nq9UYuGTGNO4U1NkxgEnTvWULcXRtGl+3jY=;
        b=UELfjr2PXzZ2lL9636Jqy9KVeaR/30Dy1NPL9GrPJ8yerCnYvF0FF3d+gvigwb04Mt
         qMXaUtFRk5xuzB5sJxNLRh40JMlCVTEqYUT1IxPjZSgfVLdgbrzY3iH7YKn5q3uVPiX+
         M0QZpr/Sr9wmCFbi+ihWrEW3o15x6/yYd+5dqygMz/UvVs3U2zq4EGccGIwDX54PVddX
         /+J4NmuTeth5ilEjX19g9TtqH2WjgH4LwnshPyHYLae+2wcx5/zgeIkbgKLl3ME/6NNi
         nX+JZJmH2NRnlCWNmK1iNWebFEgjIchL0A/0GtV3Bzr40VGPaqzVH2CCTe/23d+WbArH
         ImEA==
X-Gm-Message-State: AOJu0Yx+jr9GtdxZkBvOXzwd5fYfgm6chjHj/9RMtoxcHSbe2eLTUAC8
	X+N+suCDxcZEHVXblxTL1CDgabPj3HPbZ44fiLKMjnFIwNAip9+ndn5TT8DvbYeRtg==
X-Gm-Gg: ASbGnct03PxTUwVT1ZU54Nm9eakGzGSlh6dRFoaa+PKOH6eSHqU8IAuP/iORPNDueCh
	M4oAzNsL0mtrvRONXf+83NNESsFGoVbvqNEQz4pqSGnc26nk1N2b6M57tKub9Z8gTbdFh+Q2gRh
	Majzjeb3Rg+eCkysqIvvaBqnZ2DgU07doWznZucK8Vrs08S5HAA6+oA42ORYkPzaTCVW6rizAUe
	9YG+ObiCPoEyNLSthvrHp4O0L3BEPiGeDtsPXhqQCQULsFmWPQQ4Ft6MMxN4RQy6ebvzQ==
X-Google-Smtp-Source: AGHT+IGwgi2iYKE35Noitd1NjBs9dOGW/qnqL0vEqsTP4V74Hknv7qJIMmOvEaFE4/M3aeEp8QS5XQ==
X-Received: by 2002:a17:907:969f:b0:aa6:93c4:c68c with SMTP id a640c23a62f3a-ab38b382cacmr294739766b.41.1737116985196;
        Fri, 17 Jan 2025 04:29:45 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f23007sm164362166b.96.2025.01.17.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:29:44 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 2/4] t/unit-tests: convert mem-pool test to use clar test framework
Date: Fri, 17 Jan 2025 13:29:24 +0100
Message-ID: <20250117122926.101749-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250117122926.101749-1-kuforiji98@gmail.com>
References: <20250116161559.91038-1-kuforiji98@gmail.com>
 <20250117122926.101749-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt the mem-pool test script to use clar framework by using clar
assertions where necessary.Test functions are created as a standalone to
test different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                  |  2 +-
 t/meson.build             |  2 +-
 t/unit-tests/t-mem-pool.c | 31 -------------------------------
 t/unit-tests/u-mem-pool.c | 25 +++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 33 deletions(-)
 delete mode 100644 t/unit-tests/t-mem-pool.c
 create mode 100644 t/unit-tests/u-mem-pool.c

diff --git a/Makefile b/Makefile
index 97e8385b66..49ada4169d 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1347,7 +1348,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-hashmap
-UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
diff --git a/t/meson.build b/t/meson.build
index 602ebfe6a2..ffe951f9be 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,5 +1,6 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
+  'unit-tests/u-mem-pool.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -43,7 +44,6 @@ unit_test_programs = [
   'unit-tests/t-example-decorate.c',
   'unit-tests/t-hash.c',
   'unit-tests/t-hashmap.c',
-  'unit-tests/t-mem-pool.c',
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
deleted file mode 100644
index fe500c704b..0000000000
--- a/t/unit-tests/t-mem-pool.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include "test-lib.h"
-#include "mem-pool.h"
-
-static void setup_static(void (*f)(struct mem_pool *), size_t block_alloc)
-{
-	struct mem_pool pool = { .block_alloc = block_alloc };
-	f(&pool);
-	mem_pool_discard(&pool, 0);
-}
-
-static void t_calloc_100(struct mem_pool *pool)
-{
-	size_t size = 100;
-	char *buffer = mem_pool_calloc(pool, 1, size);
-	for (size_t i = 0; i < size; i++)
-		check_int(buffer[i], ==, 0);
-	if (!check(pool->mp_block != NULL))
-		return;
-	check(pool->mp_block->next_free != NULL);
-	check(pool->mp_block->end != NULL);
-}
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST(setup_static(t_calloc_100, 1024 * 1024),
-	     "mem_pool_calloc returns 100 zeroed bytes with big block");
-	TEST(setup_static(t_calloc_100, 1),
-	     "mem_pool_calloc returns 100 zeroed bytes with tiny block");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-mem-pool.c b/t/unit-tests/u-mem-pool.c
new file mode 100644
index 0000000000..2bc2493b7e
--- /dev/null
+++ b/t/unit-tests/u-mem-pool.c
@@ -0,0 +1,25 @@
+#include "unit-test.h"
+#include "mem-pool.h"
+
+static void test_many_pool_allocations(size_t block_alloc)
+{
+	struct mem_pool pool = { .block_alloc = block_alloc };
+	size_t size = 100;
+	char *buffer = mem_pool_calloc(&pool, 1, size);
+	for (size_t i = 0; i < size; i++)
+		cl_assert_equal_i(0, buffer[i]);
+	cl_assert(pool.mp_block != NULL);
+	cl_assert(pool.mp_block->next_free != NULL);
+	cl_assert(pool.mp_block->end != NULL);
+	mem_pool_discard(&pool, 0);
+}
+
+void test_mem_pool__big_block(void)
+{
+	test_many_pool_allocations(1024 * 1024);
+}
+
+void test_mem_pool__tiny_block(void)
+{
+	test_many_pool_allocations(1);
+}
-- 
2.34.1

