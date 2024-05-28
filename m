Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5416F90F
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901155; cv=none; b=I8Zbr9t2LR5NoW2fBnN3VxJTK8IW6gwnBstpLCdImu/QofYCop9RPJHqHUx0t0TflLMCUGglPyKSqzMF8nwzACbMZcF+6agdfrJ39hELvO6I8X8ceEF10fE3j59M6SLbgj7s/NzifiI85zPOHXWlgLzGJqrOUlm/U3L4RGOVp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901155; c=relaxed/simple;
	bh=Xt1/78dRqN2Lea1lo5jRa/wdbMdvN3E8rDdJcCNLT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoy3TGfkzWNDBHKwd8Sj5EMTtiXIYYNvxJtMbBQzemDx1ckzt9wb+Z5/aNIZSomB8kElzKbG0o0kloHrXGZbE57cWWqvtoWPKQd0AX2M+cUkTXB4RzkHAACUFs8c/zWU/+PYWD4HV5Iv6m/7xC1vS5CAm/xDzFOkpqwdiDrTb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBvZBh7x; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBvZBh7x"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3737b281d89so3254955ab.0
        for <git@vger.kernel.org>; Tue, 28 May 2024 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716901153; x=1717505953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEXvqvSGAz1/Ofc859fPQwbBH49De1bLQww7551Fc64=;
        b=hBvZBh7xU5LQrv3eexyfQ0ktPwrOK2SEqS13V0q/kRdGqm2TptUtUNNOyGzc2PwnAS
         8Xy8BlTyjVwKkDGHlRzkQ+D0Pus8ImZKH0YgsK1LoHV9IgrPnrLNNXi7MRDtxO7HA+QG
         b0cpNFA336k5ROvodjHXztE55M7v4jOiDdN9gRQnaNwt9csSsjZUPfoF1rVrl22w6EwF
         bS/FyY8UQnAtL8EXSa63xOJIv412RHQZXvUbUfYcCmqIvMm7LPZLZz8J7FMckSUEPy9Q
         skrBorWrhjXsnfj6Rz9NfqD3reQHbspwHxA40+eUYXT9r8BobC70kOrPCUz9EMXXzEQh
         GdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901153; x=1717505953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEXvqvSGAz1/Ofc859fPQwbBH49De1bLQww7551Fc64=;
        b=YWQrt51MQi9913+UIeRplOm2rlogedPmbHCslzPp7LiKDfRJAdKfkbJGMfpF5xj3wM
         1k676BxdBGqAa0ar3dICjPDTQrQJNqXM/QXZckQQ8FryHO+94GRr7sR0NoQ9ZEWj/plS
         XyxnD0TPwSL5cwgn0eE6oxE+GsmYExOVVDys4tMSSkhSh817Nm02CVSLy/7/o4QJRADn
         pbleBlV0B7ZFKqWPuH8DG3N3XqHqr/QMcSCc+ET2FRs4DspJQTUklE8AdQzJg+ry1E5k
         DsibtRTPrIkSHfYyIBQSbJbeve+3kJtpmzMTJBjn7n5bof4XJ1qm0lT13b2ydDxBVmXA
         4cBw==
X-Gm-Message-State: AOJu0YwbayIEc4cKSvmw7N3njkBIsE48TY0/nztZDV8xbfXvgnfTfisO
	pa7hyUt40dzKtSm0Rte+nIKdpTZceduD+D3+uvbB1O4Fcom46smFbjR0Hll5
X-Google-Smtp-Source: AGHT+IHCrXtKvVeI/2pXBMY+fKjVBnYskpo5DSjnpe8WWknwZy+IwG2uAFzmCDpbIzEc5mqc3zx3Cg==
X-Received: by 2002:a05:6e02:1c07:b0:371:252c:d8f6 with SMTP id e9e14a558f8ab-3737b3032f7mr133661275ab.11.1716901152739;
        Tue, 28 May 2024 05:59:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-68221892e55sm7103388a12.31.2024.05.28.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:59:12 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the unit testing framework
Date: Tue, 28 May 2024 18:28:25 +0530
Message-ID: <20240528125837.31090-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-example-decorate.c along with t9004-example.sh provide
an example of how to use the functions in decorate.h (which provides
a data structure that associates Git objects to void pointers) and
also test their output.

Migrate them to the new unit testing framework for better debugging
and runtime performance.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 Makefile                          |  2 +-
 decorate.h                        |  2 +-
 t/helper/test-example-decorate.c  | 78 ------------------------------
 t/helper/test-tool.c              |  1 -
 t/helper/test-tool.h              |  1 -
 t/t9004-example.sh                | 12 -----
 t/unit-tests/t-example-decorate.c | 80 +++++++++++++++++++++++++++++++
 7 files changed, 82 insertions(+), 94 deletions(-)
 delete mode 100644 t/helper/test-example-decorate.c
 delete mode 100755 t/t9004-example.sh
 create mode 100644 t/unit-tests/t-example-decorate.c

diff --git a/Makefile b/Makefile
index 8f4432ae57..43663fe528 100644
--- a/Makefile
+++ b/Makefile
@@ -793,7 +793,6 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-env-helper.o
-TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-example-tap.o
 TEST_BUILTINS_OBJS += test-find-pack.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
@@ -1335,6 +1334,7 @@ THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-ctype
+UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-strbuf
diff --git a/decorate.h b/decorate.h
index cdeb17c9df..08af658d34 100644
--- a/decorate.h
+++ b/decorate.h
@@ -3,7 +3,7 @@
 
 /*
  * A data structure that associates Git objects to void pointers. See
- * t/helper/test-example-decorate.c for a demonstration of how to use these
+ * t/unit-tests/t-example-decorate.c for a demonstration of how to use these
  * functions.
  */
 
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
deleted file mode 100644
index 8f59f6be4c..0000000000
--- a/t/helper/test-example-decorate.c
+++ /dev/null
@@ -1,78 +0,0 @@
-#include "test-tool.h"
-#include "git-compat-util.h"
-#include "object.h"
-#include "decorate.h"
-#include "repository.h"
-
-int cmd__example_decorate(int argc UNUSED, const char **argv UNUSED)
-{
-	struct decoration n;
-	struct object_id one_oid = { {1} };
-	struct object_id two_oid = { {2} };
-	struct object_id three_oid = { {3} };
-	struct object *one, *two, *three;
-
-	int decoration_a, decoration_b;
-
-	void *ret;
-
-	int i, objects_noticed = 0;
-
-	/*
-	 * The struct must be zero-initialized.
-	 */
-	memset(&n, 0, sizeof(n));
-
-	/*
-	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
-	 * decoration.
-	 */
-	one = lookup_unknown_object(the_repository, &one_oid);
-	two = lookup_unknown_object(the_repository, &two_oid);
-	ret = add_decoration(&n, one, &decoration_a);
-	if (ret)
-		BUG("when adding a brand-new object, NULL should be returned");
-	ret = add_decoration(&n, two, NULL);
-	if (ret)
-		BUG("when adding a brand-new object, NULL should be returned");
-
-	/*
-	 * When re-adding an already existing object, the old decoration is
-	 * returned.
-	 */
-	ret = add_decoration(&n, one, NULL);
-	if (ret != &decoration_a)
-		BUG("when readding an already existing object, existing decoration should be returned");
-	ret = add_decoration(&n, two, &decoration_b);
-	if (ret)
-		BUG("when readding an already existing object, existing decoration should be returned");
-
-	/*
-	 * Lookup returns the added declarations, or NULL if the object was
-	 * never added.
-	 */
-	ret = lookup_decoration(&n, one);
-	if (ret)
-		BUG("lookup should return added declaration");
-	ret = lookup_decoration(&n, two);
-	if (ret != &decoration_b)
-		BUG("lookup should return added declaration");
-	three = lookup_unknown_object(the_repository, &three_oid);
-	ret = lookup_decoration(&n, three);
-	if (ret)
-		BUG("lookup for unknown object should return NULL");
-
-	/*
-	 * The user can also loop through all entries.
-	 */
-	for (i = 0; i < n.size; i++) {
-		if (n.entries[i].base)
-			objects_noticed++;
-	}
-	if (objects_noticed != 2)
-		BUG("should have 2 objects");
-
-	clear_decoration(&n, NULL);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f6fd0fe491..2d82515f56 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -29,7 +29,6 @@ static struct test_cmd cmds[] = {
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "env-helper", cmd__env_helper },
-	{ "example-decorate", cmd__example_decorate },
 	{ "example-tap", cmd__example_tap },
 	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 868f33453c..bc334183c3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,7 +23,6 @@ int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__env_helper(int argc, const char **argv);
-int cmd__example_decorate(int argc, const char **argv);
 int cmd__example_tap(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
diff --git a/t/t9004-example.sh b/t/t9004-example.sh
deleted file mode 100755
index 590aab0304..0000000000
--- a/t/t9004-example.sh
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/sh
-
-test_description='check that example code compiles and runs'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'decorate' '
-	test-tool example-decorate
-'
-
-test_done
diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-decorate.c
new file mode 100644
index 0000000000..3c856a8cf2
--- /dev/null
+++ b/t/unit-tests/t-example-decorate.c
@@ -0,0 +1,80 @@
+#include "test-lib.h"
+#include "object.h"
+#include "decorate.h"
+#include "repository.h"
+
+struct test_vars {
+	struct object *one, *two, *three;
+	struct decoration n;
+	int decoration_a, decoration_b;
+};
+
+static void t_add(struct test_vars *vars)
+{
+	void *ret = add_decoration(&vars->n, vars->one, &vars->decoration_a);
+
+	if (!check(ret == NULL))
+		test_msg("when adding a brand-new object, NULL should be returned");
+	ret = add_decoration(&vars->n, vars->two, NULL);
+	if (!check(ret == NULL))
+		test_msg("when adding a brand-new object, NULL should be returned");
+}
+
+static void t_readd(struct test_vars *vars)
+{
+	void *ret = add_decoration(&vars->n, vars->one, NULL);
+
+	if (!check(ret == &vars->decoration_a))
+		test_msg("when readding an already existing object, existing decoration should be returned");
+	ret = add_decoration(&vars->n, vars->two, &vars->decoration_b);
+	if (!check(ret == NULL))
+		test_msg("when readding an already existing object, existing decoration should be returned");
+}
+
+static void t_lookup(struct test_vars *vars)
+{
+	void *ret = lookup_decoration(&vars->n, vars->one);
+
+	if (!check(ret == NULL))
+		test_msg("lookup should return added declaration");
+	ret = lookup_decoration(&vars->n, vars->two);
+	if (!check(ret == &vars->decoration_b))
+		test_msg("lookup should return added declaration");
+	ret = lookup_decoration(&vars->n, vars->three);
+	if (!check(ret == NULL))
+		test_msg("lookup for unknown object should return NULL");
+}
+
+static void t_loop(struct test_vars *vars)
+{
+	int i, objects_noticed = 0;
+
+	for (i = 0; i < vars->n.size; i++) {
+		if (vars->n.entries[i].base)
+			objects_noticed++;
+	}
+	if (!check_int(objects_noticed, ==, 2))
+		test_msg("should have 2 objects");
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
+	struct test_vars vars = { 0 };
+
+	vars.one = lookup_unknown_object(the_repository, &one_oid);
+	vars.two = lookup_unknown_object(the_repository, &two_oid);
+	vars.three = lookup_unknown_object(the_repository, &three_oid);
+
+	TEST(t_add(&vars),
+	     "Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.");
+	TEST(t_readd(&vars),
+	     "When re-adding an already existing object, the old decoration is returned.");
+	TEST(t_lookup(&vars),
+	     "Lookup returns the added declarations, or NULL if the object was never added.");
+	TEST(t_loop(&vars), "The user can also loop through all entries.");
+
+	clear_decoration(&vars.n, NULL);
+
+	return test_done();
+}
-- 
2.45.1

