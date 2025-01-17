Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CF1FE472
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116994; cv=none; b=rN+h6kez/JsjxbUKX98FEst7HGQ970Af87m0z34wkBsBPyjFuT0QMMKl2y2ozoWxngHYNbQSbCnXcatrdAO9SWsvnUD3co2uPQIpdawpyYuGt7/rvGhJeP5q91IWdryfGXFZlXL8V/FW9JO2AbezADE8cfI+6eCOQd8om4UaVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116994; c=relaxed/simple;
	bh=0PfZZchRGvwEj9MKjZkX2TKoeQjjs9/nibor6yetpWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFReWFqRXIYXj//0X4PySpWON2/pKvNTPtPrB9QzURMvxxQMIYxxE4LI16CJXrTyy5N6Zptq681B/rHerSRtL+zxM9aA3VfJwO2gf3CdIBtwA0S7yoZwMXZ6I2CMY+YZp2rKzeVEJEW8HV5JXVJC0xyvFgpn2duXcn+K2v6wHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGi+7ng7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGi+7ng7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so322085366b.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 04:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737116991; x=1737721791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2D1ZQgyigSiR29ims/9YVQ82J01XGMI+3TgqZULvx0=;
        b=NGi+7ng7iXSkEaG7H/aK5olsRfhfQTQOqniQ0QnShAIo41tPM/cELZWA36ZnUpcru/
         DkJmjOJjcc23XIw4vz5Nq0BOoPn2Fp7iz4vtC9xkLgntLz8IUvqZ/iIxrE7smpduKNK+
         LEQA7pbii3X3E+JV/xklZihpPz+VAH9QCQC9qpYP1rVqEzGce04dZI1KdZi0cnr4VQF5
         jLgeFKbjufwjrMozo5HdI0LtVPyT+uEulij0NALANHeC2pzJAVLFWUmX8ixADPJnArYz
         AfZCB28K/ruckLG8rry7AJhIf0wlEdUsXpEkV3S0Bo0jklsSS8mNqHst9wvSgvcUmcbc
         kthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116991; x=1737721791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2D1ZQgyigSiR29ims/9YVQ82J01XGMI+3TgqZULvx0=;
        b=DpqOa43mqh6OFe9a/VkAu5rs6A7ANb0VOdfVyprvrtO7+kkqLdXRxSZC/yXYEOgIMF
         Wg+HAPoYGJo63eIgNdf4/xWWltTyieu+WZLbjJ8xSFLTOffa1u3E5scTznPYba/Td+sK
         DCEMpmiwM9MDiysOqvXaMwqC5tHuP3Ii5hbpTC7mkc4QKQd8PE1DREdct+7pW74YnN4w
         k+zneKVjQ9Qe+ldO5z/ktlB5wjQUgDPvHpzTxSNvx5aa3WCGqys+sRMn7CCWdKfNmQM0
         MfoTgdijFDeQbv53GypcsjFPViBcgawykl6a67i20prmIPBATga0p9CVshfsWvcAKEAi
         mNdQ==
X-Gm-Message-State: AOJu0YwxixgsjSCunPnSg5vC+1aNetHe1Mo3buqHwY3gobLmX8Ju3mvI
	zxyw32oOF3vI+a+sovqaBXKSEKWC/+exXOowDYu8rdjGtXZJr2S504KMM8e41JxxnQ==
X-Gm-Gg: ASbGncscPXzj0V5nmgsdWH4m0JQkssQGAAgOh47TlKhzg91XTUnnr95sIFC4XN+hpz+
	QGVlIxVMuZL4XX6Z0ecs2yd3gDP0FjfzyMMIJjrb3fYxSvpHFyyhHeJ782V0F6nZV4kAct/SfNc
	VDaC4877+quWiB3ZUlvKGaK6PAbDYpsbR53ePorlP/C7ePJGtkVRu0Pf2ix1oArX7iWBav2ZjKz
	rAjhad7/AJrdZRyWxys+XzsnE2dmgkN6Fnssuptc95Adav/GB3tUez+dtsLzhuqYRAJ4g==
X-Google-Smtp-Source: AGHT+IHHbiCpflYQY8EBo97ieGRDc5o1jMcotgcD4CZMYdkKaqZq60KrTua7lKRVZt2Aj4y6+XzhkA==
X-Received: by 2002:a17:906:4794:b0:aa5:1a1c:d0a2 with SMTP id a640c23a62f3a-ab38b1c52b4mr219031766b.34.1737116990407;
        Fri, 17 Jan 2025 04:29:50 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f23007sm164362166b.96.2025.01.17.04.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:29:50 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 3/4] t/unit-tests: adapt priority queue test to use clar test framework
Date: Fri, 17 Jan 2025 13:29:25 +0100
Message-ID: <20250117122926.101749-4-kuforiji98@gmail.com>
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

Convert the prio-queue test script to clar framework by using clar
assertions where necessary. Test functions are created as a standalone
to test different cases.

update the type of the variable `j` from int to `size_t`, this ensures
compatibility with the type used for result_size, which is also size_t,
preventing a potential warning or error caused by comparisons between
signed and unsigned integers.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                    |  2 +-
 t/meson.build               |  2 +-
 t/unit-tests/t-prio-queue.c | 91 -----------------------------------
 t/unit-tests/u-prio-queue.c | 94 +++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 93 deletions(-)
 delete mode 100644 t/unit-tests/t-prio-queue.c
 create mode 100644 t/unit-tests/u-prio-queue.c

diff --git a/Makefile b/Makefile
index 49ada4169d..049f857512 100644
--- a/Makefile
+++ b/Makefile
@@ -1339,6 +1339,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
 CLAR_TEST_SUITES += u-mem-pool
+CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1351,7 +1352,6 @@ UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
-UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
diff --git a/t/meson.build b/t/meson.build
index ffe951f9be..09232967cd 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,6 +1,7 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
   'unit-tests/u-mem-pool.c',
+  'unit-tests/u-prio-queue.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -47,7 +48,6 @@ unit_test_programs = [
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
-  'unit-tests/t-prio-queue.c',
   'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
deleted file mode 100644
index a053635000..0000000000
--- a/t/unit-tests/t-prio-queue.c
+++ /dev/null
@@ -1,91 +0,0 @@
-#include "test-lib.h"
-#include "prio-queue.h"
-
-static int intcmp(const void *va, const void *vb, void *data UNUSED)
-{
-	const int *a = va, *b = vb;
-	return *a - *b;
-}
-
-
-#define MISSING  -1
-#define DUMP	 -2
-#define STACK	 -3
-#define GET	 -4
-#define REVERSE  -5
-
-static int show(int *v)
-{
-	return v ? *v : MISSING;
-}
-
-static void test_prio_queue(int *input, size_t input_size,
-			    int *result, size_t result_size)
-{
-	struct prio_queue pq = { intcmp };
-	int j = 0;
-
-	for (size_t i = 0; i < input_size; i++) {
-		void *peek, *get;
-		switch(input[i]) {
-		case GET:
-			peek = prio_queue_peek(&pq);
-			get = prio_queue_get(&pq);
-			if (!check(peek == get))
-				return;
-			if (!check_uint(j, <, result_size))
-				break;
-			if (!check_int(result[j], ==, show(get)))
-				test_msg("      j: %d", j);
-			j++;
-			break;
-		case DUMP:
-			while ((peek = prio_queue_peek(&pq))) {
-				get = prio_queue_get(&pq);
-				if (!check(peek == get))
-					return;
-				if (!check_uint(j, <, result_size))
-					break;
-				if (!check_int(result[j], ==, show(get)))
-					test_msg("      j: %d", j);
-				j++;
-			}
-			break;
-		case STACK:
-			pq.compare = NULL;
-			break;
-		case REVERSE:
-			prio_queue_reverse(&pq);
-			break;
-		default:
-			prio_queue_put(&pq, &input[i]);
-			break;
-		}
-	}
-	check_uint(j, ==, result_size);
-	clear_prio_queue(&pq);
-}
-
-#define TEST_INPUT(input, result) \
-	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST(TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
-			((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 })),
-	     "prio-queue works for basic input");
-	TEST(TEST_INPUT(((int []){ 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP }),
-			((int []){ 2, 3, 4, 1, 5, 6 })),
-	     "prio-queue works for mixed put & get commands");
-	TEST(TEST_INPUT(((int []){ 1, 2, GET, GET, GET, 1, 2, GET, GET, GET }),
-			((int []){ 1, 2, MISSING, 1, 2, MISSING })),
-	     "prio-queue works when queue is empty");
-	TEST(TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
-			((int []){ 3, 2, 6, 4, 5, 1, 8 })),
-	     "prio-queue works when used as a LIFO stack");
-	TEST(TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
-			((int []){ 1, 2, 3, 4, 5, 6 })),
-	     "prio-queue works when LIFO stack is reversed");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-prio-queue.c b/t/unit-tests/u-prio-queue.c
new file mode 100644
index 0000000000..145e689c9c
--- /dev/null
+++ b/t/unit-tests/u-prio-queue.c
@@ -0,0 +1,94 @@
+#include "unit-test.h"
+#include "prio-queue.h"
+
+static int intcmp(const void *va, const void *vb, void *data UNUSED)
+{
+	const int *a = va, *b = vb;
+	return *a - *b;
+}
+
+
+#define MISSING  -1
+#define DUMP	 -2
+#define STACK	 -3
+#define GET	 -4
+#define REVERSE  -5
+
+static int show(int *v)
+{
+	return v ? *v : MISSING;
+}
+
+static void test_prio_queue(int *input, size_t input_size,
+			    int *result, size_t result_size)
+{
+	struct prio_queue pq = { intcmp };
+	size_t j = 0;
+
+	for (size_t i = 0; i < input_size; i++) {
+		void *peek, *get;
+		switch(input[i]) {
+		case GET:
+			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
+			cl_assert(peek == get);
+			cl_assert(j < result_size);
+			cl_assert_equal_i(result[j], show(get));
+			j++;
+			break;
+		case DUMP:
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				cl_assert(peek == get);
+				cl_assert(j < result_size);
+				cl_assert_equal_i(result[j], show(get));
+				j++;
+			}
+			break;
+		case STACK:
+			pq.compare = NULL;
+			break;
+		case REVERSE:
+			prio_queue_reverse(&pq);
+			break;
+		default:
+			prio_queue_put(&pq, &input[i]);
+			break;
+		}
+	}
+	cl_assert_equal_i(j, result_size);
+	clear_prio_queue(&pq);
+}
+
+#define TEST_INPUT(input, result) \
+	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))
+
+void test_prio_queue__basic(void)
+{
+	TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
+		   ((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 }));
+}
+
+void test_prio_queue__mixed(void)
+{
+	TEST_INPUT(((int []){ 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP }),
+		   ((int []){ 2, 3, 4, 1, 5, 6 }));
+}
+
+void test_prio_queue__empty(void)
+{
+	TEST_INPUT(((int []){ 1, 2, GET, GET, GET, 1, 2, GET, GET, GET }),
+		   ((int []){ 1, 2, MISSING, 1, 2, MISSING }));
+}
+
+void test_prio_queue__stack(void)
+{
+	TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
+		   ((int []){ 3, 2, 6, 4, 5, 1, 8 }));
+}
+
+void test_prio_queue__reverse_stack(void)
+{
+	TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
+		   ((int []){ 1, 2, 3, 4, 5, 6 }));
+}
-- 
2.34.1

