Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6354D8BE
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116650; cv=none; b=DPi1xLLz83+g8zqm2z7CuhJfE29JjvrNLcx+Kpo5XCEINg0VEcpE4SL1zb2aFFfwQ9NjSANo+4LKrS0nIhRsyBbn/mfcVXKMMWq4QHR4le94JHFIJ1mur6dF5D3K131qQvpWFTstNATvXkBs/PoP0P3i6xNR2P4Qx9z053zHzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116650; c=relaxed/simple;
	bh=qsBlSaCY33QWpIg5WWaz2nmRtHahCuykMe3MM9LSCHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpEv+QqbLfeMThpsPSocuvhdx/VToxj3Eso+im/dUq8u+RJlDGWkTuGNGvA5l4OscXs/bSVMp51EcEUjlFHAboFQD+YyLViRYQLfiLmLWlTPliSEEKlcxtsxOTCwvTUDNzQ7+fcGZhb11z8UYRRXnlfzkbdgvao+Ig3QugsqBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYJ48+pR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYJ48+pR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb0d88fd25so36071435ad.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116647; x=1721721447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GJ/jIA1MCLPbMW3wFJ6DCyKziFeRopCx8gUqoXhAxg=;
        b=gYJ48+pRNbo+2sgh2tIckZRogJhSzH2lwd7UdreWvDcJM5z9aFrJEHn2BwxZ09+oXh
         PoIQQ5uVO3Eu078YEtUHvCsbTfKF7gNqihGRFt5OOY6sKlA96J8peRILmajlnXl7TIZa
         fYCPDcTO6/85gobQUfjQfV6CliZNNunRle24Z8RgxuvJAldlWW3/dzczDGN0YjzuEPWC
         gg2NQLc0huejI64KpFuUZteTnUDOsX9d190TwF3IwsNa/k611Pug9DsUTZ4tp+Y0KTrz
         FLVdXnsr1wn7db/nM/83UjUDbije6k12UNfMmYZYPrkM5Q7edoJO2288gt2nKZ6XkbVd
         chTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116647; x=1721721447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GJ/jIA1MCLPbMW3wFJ6DCyKziFeRopCx8gUqoXhAxg=;
        b=JjsNlkTabH2UP/Wzz0w9fArl/tNYRMnlvwuxLuHxZJtqenhYY8TPlL1Ok0hQxolkcJ
         Wqjtm7FPu4XOHiZaEbLxN3ZqcIXo25cNIAkswm5SLM8mwiiAWIYXrq4gOCoAJ5xkJcKR
         P9unTTiPFBqb5Neh3KA6I8ArcCQmbmWqn5tyK6QRzMGBEvSpfaUvcXeaG3ExkWtzIl54
         r3q1LTcyiRngekW13nGcOI/KtyfW6TcYPJqux9RZ+tfQGysD3bio7+eGHUB907HzsY1m
         Ci+TjosjlBYOEa1OHJJSavEVUPlWjH8vaLEbn52QrE38NiTl1Shfiw7y2MgE2kLOJt/W
         cBjA==
X-Gm-Message-State: AOJu0Yy6W5wkeTPOk7g06dALErkGm6swy66og7y3ZbFiqCqSoLeuR217
	/PK77dtdJLkiWFrAYrdPbrXn6LdJ+USGKpH586lNlVYSGXsrCbj0ndxPUxpv
X-Google-Smtp-Source: AGHT+IFxDXFlcQ8CUr7/J11yWMfKgK16yw307j9a4HIt/Hx/km7Vl7kjPVpNtJo83wIQ7SQEZ36IkA==
X-Received: by 2002:a17:902:8c8e:b0:1fa:2b11:657d with SMTP id d9443c01a7336-1fc3e677edamr12769985ad.10.1721116647353;
        Tue, 16 Jul 2024 00:57:27 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc3a599sm53691435ad.232.2024.07.16.00.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:57:26 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
Date: Tue, 16 Jul 2024 13:18:14 +0530
Message-ID: <20240716075641.4264-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
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

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                       |  2 +-
 reftable/reftable-tests.h      |  1 -
 reftable/tree_test.c           | 60 ----------------------------------
 t/helper/test-reftable.c       |  1 -
 t/unit-tests/t-reftable-tree.c | 56 +++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 63 deletions(-)
 delete mode 100644 reftable/tree_test.c
 create mode 100644 t/unit-tests/t-reftable-tree.c

diff --git a/Makefile b/Makefile
index 3eab701b10..79e86ddf53 100644
--- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
+UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
@@ -2685,7 +2686,6 @@ REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 114cc3d053..d0abcc51e2 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -16,7 +16,6 @@ int pq_test_main(int argc, const char **argv);
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
index 9160bc5da6..245b674a3c 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -7,7 +7,6 @@ int cmd__reftable(int argc, const char **argv)
 	/* test from simple to complex. */
 	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	merged_test_main(argc, argv);
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
new file mode 100644
index 0000000000..5df814d983
--- /dev/null
+++ b/t/unit-tests/t-reftable-tree.c
@@ -0,0 +1,56 @@
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
+	do {
+		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
+		check_pointer_eq(values + i, nodes[i]->key);
+		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
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

