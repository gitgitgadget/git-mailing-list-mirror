Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47C1E3CA8
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600874; cv=none; b=jcukWji3RRhPC/q3qIMdBCqchfRDRitR1+QdHUlt9fRoYE72s4o/9GUheRF2uV6WOnUJlKSfMf6MumWVxQ9/E7jHHtESAfkxOTcQig896ydEQw2g7gXn4x3YuBKhe8hdrhP9dJP7NbeLWS+u1HJLSfwz0is+So6zPbGBYDH6+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600874; c=relaxed/simple;
	bh=+22dSkfQbPJueRh80Q76V7X8FxQ8t5F5fTl3aG9z94k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD4Ao3+vWe2QQFPEmdaxAyE7z40h6RLXFKeHP6GWuUFhF4oeDNOC6nxA7M+dc6+aPImd9pqOkGcJriJ6FP9gEXU/rfvNRaOaqgmEVzwrayJo/zXpWOurGTOH1nbCZS7F0zvZ9ZKWWtWcNmxyZuITagp+KNpUk598cEMj5NBoiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7KxI1po; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7KxI1po"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so814029b3a.2
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722600871; x=1723205671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZA9nZQwqpO3hA3ae2hNED+3x7rama5TJT1JVO8u6Oc=;
        b=L7KxI1poGankDlhikcwfrQqOM6SXrJh4G6AWgvkxF2YBaxGlsF29bEfECrKydjn3Rn
         6TdvztJdpxnZHjtV2aiC3OinlTp0Khy7EBqTw+YRloTfmPLOnTv6XYvOPctlPImyCs25
         CNjXK/YjaKPWnZlwhs52WPbCeJe0/dcGeS+l4WhtAUBYrELcGSv17fi83hc6ADKLXnTS
         gt9V2hLxzeddsxs5VqjTBPJIQjwg9b4fngMMefrbdV5rGe/w49B+4I1Y2zwgn3KKqpK9
         6577/k4Q1l/Bm6V0l9KOcy5T+GDCl5qARzgihqOrmSXJOKFPwc0wpjm/LyaIeaTAf8XI
         RGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722600871; x=1723205671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZA9nZQwqpO3hA3ae2hNED+3x7rama5TJT1JVO8u6Oc=;
        b=asVM47FBULBFEZC22PAI6RubUjDfvwcEIpVl/RYuvvf721LonsLE/iEbyY5NI+RCQ0
         gHaSoSDZMkCZFBwtl23mS0oBqcXxxCd9MFwIn+umr96/R902NlmpGwzn0d4jr+arMcfV
         2bgDh29QIbeygw1DKehXtwTKzXY9ZY4NIiPjHCgvyegSKC20116e1bTrx02FDDnoOsYm
         PTnfVkgXMuafFmePwskpa2SiP/jYrg5pLpNRHJqVVKxxxDyXGvCp7MT5f8/KdLA8n3Au
         uID0q0esQx4dVpfLnV+7CVAqUNhadNJHU0FfNBVERO1rzp/mZ+beAcspltONfzGeCcM4
         CznQ==
X-Gm-Message-State: AOJu0YyQQ+DDCQY59RT9G7PquuIgIlivWvSNdxAe9M32TL58jGhg2V/W
	8yh/tihazBZIlzP/UHGDXWC/fhQvq8N+ony2KjC/79gbbpUWAiKp/XfKLw==
X-Google-Smtp-Source: AGHT+IEfliex0IBfPUQ56M1jNey+jHBzkaBxsYe9F2mvoYGXKUfAUZ1UJ9FezzcaMno5/ikJYxVaMQ==
X-Received: by 2002:a05:6a20:7346:b0:1c4:6be0:912f with SMTP id adf61e73a8af0-1c69953c712mr5037567637.10.1722600871138;
        Fri, 02 Aug 2024 05:14:31 -0700 (PDT)
Received: from Ubuntu.. ([106.213.168.25])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec16034sm1294534b3a.15.2024.08.02.05.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:14:30 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 2/5] t: move reftable/tree_test.c to the unit testing framework
Date: Fri,  2 Aug 2024 17:38:05 +0530
Message-ID: <20240802121318.4583-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240802121318.4583-1-chandrapratap3519@gmail.com>
References: <20240722061836.4176-1-chandrapratap3519@gmail.com>
 <20240802121318.4583-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/tree_test.c exercises the functions defined in
reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
testing framework. Migration involves refactoring the tests to use
the unit testing framework instead of reftable's test framework and
renaming the tests to align with unit-tests' standards.

Also add a comment to help understand the test routine.

Note that this commit mostly moves the test from reftable/ to
t/unit-tests/ and most of the refactoring is performed by the
trailing commits.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                       |  2 +-
 reftable/reftable-tests.h      |  1 -
 reftable/tree_test.c           | 60 ----------------------------------
 t/helper/test-reftable.c       |  1 -
 t/unit-tests/t-reftable-tree.c | 59 +++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 63 deletions(-)
 delete mode 100644 reftable/tree_test.c
 create mode 100644 t/unit-tests/t-reftable-tree.c

diff --git a/Makefile b/Makefile
index 3863e60b66..5499f7bcbd 100644
--- a/Makefile
+++ b/Makefile
@@ -1342,6 +1342,7 @@ UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-record
+UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2685,7 +2686,6 @@ REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index d5e03dcc1b..8516b1f923 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -15,7 +15,6 @@ int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
-int tree_test_main(int argc, const char **argv);
 int reftable_dump_main(int argc, char *const *argv);
 
 #endif
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
deleted file mode 100644
index 6961a657ad..0000000000
--- a/reftable/tree_test.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-#include "tree.h"
-
-#include "test_framework.h"
-#include "reftable-tests.h"
-
-static int test_compare(const void *a, const void *b)
-{
-	return (char *)a - (char *)b;
-}
-
-struct curry {
-	void *last;
-};
-
-static void check_increasing(void *arg, void *key)
-{
-	struct curry *c = arg;
-	if (c->last) {
-		EXPECT(test_compare(c->last, key) < 0);
-	}
-	c->last = key;
-}
-
-static void test_tree(void)
-{
-	struct tree_node *root = NULL;
-
-	void *values[11] = { NULL };
-	struct tree_node *nodes[11] = { NULL };
-	int i = 1;
-	struct curry c = { NULL };
-	do {
-		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
-		i = (i * 7) % 11;
-	} while (i != 1);
-
-	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
-		EXPECT(values + i == nodes[i]->key);
-		EXPECT(nodes[i] ==
-		       tree_search(values + i, &root, &test_compare, 0));
-	}
-
-	infix_walk(root, check_increasing, &c);
-	tree_free(root);
-}
-
-int tree_test_main(int argc, const char *argv[])
-{
-	RUN_TEST(test_tree);
-	return 0;
-}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 9d378427da..0acaf85494 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,7 +6,6 @@ int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
 	block_test_main(argc, argv);
-	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	stack_test_main(argc, argv);
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
new file mode 100644
index 0000000000..08f1873ad3
--- /dev/null
+++ b/t/unit-tests/t-reftable-tree.c
@@ -0,0 +1,59 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "test-lib.h"
+#include "reftable/tree.h"
+
+static int t_compare(const void *a, const void *b)
+{
+	return (char *)a - (char *)b;
+}
+
+struct curry {
+	void *last;
+};
+
+static void check_increasing(void *arg, void *key)
+{
+	struct curry *c = arg;
+	if (c->last)
+		check_int(t_compare(c->last, key), <, 0);
+	c->last = key;
+}
+
+static void t_tree(void)
+{
+	struct tree_node *root = NULL;
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	size_t i = 1;
+	struct curry c = { 0 };
+
+	/* pseudo-randomly insert the pointers for elements between
+	 * values[1] and values[10] (included) in the tree.
+	 */
+	do {
+		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
+		check_pointer_eq(&values[i], nodes[i]->key);
+		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
+	}
+
+	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+int cmd_main(int argc, const char *argv[])
+{
+	TEST(t_tree(), "tree_search and infix_walk work");
+
+	return test_done();
+}
-- 
2.45.GIT

