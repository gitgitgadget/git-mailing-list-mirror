Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9ED13FFF
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502310; cv=none; b=tOcFNqgl3ZuSX/KJfv2TymxL5RU9l8D4WixG7Ii6T/9opz2phSGzkb9zerFGyVh+PP9L4rvKBtGLdtM9NuIJ+nN3+iv3SWr+47VHm81wtsfZNbKlS5QTNrhyP1KmZncpwsa+4DosfeEQTEs953KG+xqWKeRoH6KsnlB6OnbeVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502310; c=relaxed/simple;
	bh=/ELMUzgsQPxaxO/yVx1AuZ661iS4/wZJKvUf4eNqqEc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=kS0J1z8EJByEmSIlN7AlGkdBVkM6XQRmAbTk9W3g+h9iLNjtUoxcv5uhdzvBjmnMGp0gtX3Kb0E9t2WLZhRRo9MxA/ekagvjAWdgK57fU6KTHvXuA6u2heS16BxKOhCV0yODyDv+A9vqyZZbALYb+Iov5gf7SzviJe+4TFQNGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLF+TKbM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLF+TKbM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e86a9fbd9so14363275e9.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705502306; x=1706107106; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZpQQh0McTESzU5hcqzsyGYnyPvCBsxAJziOPrEmtGQ=;
        b=BLF+TKbMdALxKX5SuRTCH5El1hXqEYKYTF8t0oG7drd0UzSQPgofCcJAiEmeMWXV7A
         nW16W3d6Q2ywjwd6FYGxe1j9IA2ERUuq4hbuqLBnXf88EHOT4G+fFuP0Ra1QZUi1wNZo
         ryGzsJg5Y/gPG6fDkiERzf8YNY+MukP52VwwuBBew+X3zNa67cwTpqxP6j+1hgGDc+LP
         KZZmTrdKlJgbKAF5M+uRb4F4L2KD6dvnb8ay97IKuQZbSnqKILiUs2knJg6u4oBEWc7n
         C8o9raNy+g5WfIWq7soMPNdMi5WueU0hFk+8kQxZPo+X0RXETNA+YxtOLcByqmaGYTe7
         jXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705502306; x=1706107106;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZpQQh0McTESzU5hcqzsyGYnyPvCBsxAJziOPrEmtGQ=;
        b=hchXBuS9nCqL/KOFiul2cBKh6WfeGA5pyT5jqTn87XQBu1H3u+4cPN69McrMlH7Vsk
         ed3WJ6ReCKiHHUEqALTL6bxlVKbpQzCadHHqOAe9xRM2NV8yroU99po4sfeBpUEjlgvK
         xFn8vZQ9BNkD9N6n9x7qI9NG9VzlYHSyg7SfWyhaE/UqH4sEkqy2xfB9yTyA6d1KEl+o
         zqbpvlWPhLuxFnQYjLqPXT+dnK5FdOtF8ddCwvTRymlQh2OZh4em6R8da1RSfAbYbUZU
         3Jv8AusCUgYPMYyJxJfshHWhitlihzC6eO3gLXNxawzoBm0XtP99m89cDNUG/hgxjb/3
         butg==
X-Gm-Message-State: AOJu0YyExfOCw58ZYq8wkMnCithhoXYcXiBlU4B6n9SNhd1DoZn8atUw
	JJrR2vtyaeCNx/fd0nfNvdIktYvp2po=
X-Google-Smtp-Source: AGHT+IEaWhf5PkS7MsT8acFkiMcGDFsETa1IFKuC7/GoYnNIgyXIypmT0wEofGM6HyEJ/dbbVwCeyg==
X-Received: by 2002:a05:600c:22da:b0:40d:85b9:6f76 with SMTP id 26-20020a05600c22da00b0040d85b96f76mr4531016wmg.155.1705502305803;
        Wed, 17 Jan 2024 06:38:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b0040e88fbe051sm2494752wmo.48.2024.01.17.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 06:38:25 -0800 (PST)
Message-ID: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
In-Reply-To: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
References: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 14:38:23 +0000
Subject: [PATCH v3] tests: move t0009-prio-queue.sh to the new unit testing
 framework
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
    Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c unit
tests Git's implementation of a priority queue. Migrate the
test over to the new unit testing framework to simplify debugging
and reduce test run-time. Refactor the required logic and add
a new test case in addition to porting over the original ones in
shell.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    tests: move t0009-prio-queue.sh to the new unit testing framework

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1642%2FChand-ra%2Fprio-queue-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1642/Chand-ra/prio-queue-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1642

Range-diff vs v2:

 1:  60ac9b3c259 ! 1:  6b10028177a tests: move t0009-prio-queue.sh to the new unit testing framework
     @@ t/unit-tests/t-prio-queue.c (new)
      +	return *a - *b;
      +}
      +
     ++
     ++#define MISSING  -1
     ++#define DUMP	 -2
     ++#define STACK	 -3
     ++#define GET	 -4
     ++#define REVERSE  -5
     ++
      +static int show(int *v)
      +{
     -+	int ret = -1;
     -+	if (v)
     -+		ret = *v;
     -+	free(v);
     -+	return ret;
     ++	return v ? *v : MISSING;
      +}
      +
     -+static int test_prio_queue(const char **input, int *result)
     ++static int test_prio_queue(int *input, int *result)
      +{
      +	struct prio_queue pq = { intcmp };
      +	int i = 0;
      +
      +	while (*input) {
     -+		if (!strcmp(*input, "get")) {
     -+			void *peek = prio_queue_peek(&pq);
     -+			void *get = prio_queue_get(&pq);
     -+			if (peek != get)
     -+				BUG("peek and get results do not match");
     -+			result[i++] = show(get);
     -+		} else if (!strcmp(*input, "dump")) {
     -+			void *peek;
     -+			void *get;
     -+			while ((peek = prio_queue_peek(&pq))) {
     ++		int *val = input++;
     ++		void *peek, *get;
     ++		switch(*val) {
     ++			case GET:
     ++				peek = prio_queue_peek(&pq);
      +				get = prio_queue_get(&pq);
      +				if (peek != get)
     -+					BUG("peek and get results do not match");
     ++					BUG("peek and get results don't match");
      +				result[i++] = show(get);
     -+			}
     -+		} else if (!strcmp(*input, "stack")) {
     -+			pq.compare = NULL;
     -+		} else if (!strcmp(*input, "reverse")) {
     -+			prio_queue_reverse(&pq);
     -+		} else {
     -+			int *v = xmalloc(sizeof(*v));
     -+			*v = atoi(*input);
     -+			prio_queue_put(&pq, v);
     ++				break;
     ++			case DUMP:
     ++				while ((peek = prio_queue_peek(&pq))) {
     ++					get = prio_queue_get(&pq);
     ++					if (peek != get)
     ++						BUG("peek and get results don't match");
     ++					result[i++] = show(get);
     ++				}
     ++				break;
     ++			case STACK:
     ++				pq.compare = NULL;
     ++				break;
     ++			case REVERSE:
     ++				prio_queue_reverse(&pq);
     ++				break;
     ++			default:
     ++				prio_queue_put(&pq, val);
     ++				break;
      +		}
     -+		input++;
      +	}
     -+
      +	clear_prio_queue(&pq);
     -+
      +	return 0;
      +}
      +
     -+#define INPUT_SIZE 6
     -+
     -+#define BASIC_INPUT "1", "2", "3", "4", "5", "5", "dump"
     ++#define BASIC_INPUT 1, 2, 3, 4, 5, 5, DUMP
      +#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
      +
     -+#define MIXED_PUT_GET_INPUT "6", "2", "4", "get", "5", "3", "get", "get", "1", "dump"
     ++#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
      +#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
      +
     -+#define EMPTY_QUEUE_INPUT "1", "2", "get", "get", "get", "1", "2", "get", "get", "get"
     -+#define EMPTY_QUEUE_EXPECTED 1, 2, -1, 1, 2, -1
     ++#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
     ++#define EMPTY_QUEUE_EXPECTED 1, 2, MISSING, 1, 2, MISSING
      +
     -+#define STACK_INPUT "stack", "1", "5", "4", "6", "2", "3", "dump"
     ++#define STACK_INPUT STACK, 1, 5, 4, 6, 2, 3, DUMP
      +#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
      +
     -+#define REVERSE_STACK_INPUT "stack", "1", "2", "3", "4", "5", "6", "reverse", "dump"
     ++#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
      +#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
      +
      +#define TEST_INPUT(INPUT, EXPECTED, name)			\
     -+  static void test_##name(void)					\
     ++  static void test_##name(void)				\
      +{								\
     -+	const char *input[] = {INPUT};				\
     ++	int input[] = {INPUT};					\
      +	int expected[] = {EXPECTED};				\
     -+	int result[INPUT_SIZE];					\
     ++	int result[ARRAY_SIZE(expected)];			\
      +	test_prio_queue(input, result);				\
      +	check(!memcmp(expected, result, sizeof(expected)));	\
      +}


 Makefile                    |   2 +-
 t/helper/test-prio-queue.c  |  51 ------------------
 t/helper/test-tool.c        |   1 -
 t/helper/test-tool.h        |   1 -
 t/t0009-prio-queue.sh       |  66 -----------------------
 t/unit-tests/t-prio-queue.c | 101 ++++++++++++++++++++++++++++++++++++
 6 files changed, 102 insertions(+), 120 deletions(-)
 delete mode 100644 t/helper/test-prio-queue.c
 delete mode 100755 t/t0009-prio-queue.sh
 create mode 100644 t/unit-tests/t-prio-queue.c

diff --git a/Makefile b/Makefile
index 312d95084c1..d5e48e656b3 100644
--- a/Makefile
+++ b/Makefile
@@ -828,7 +828,6 @@ TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
-TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
@@ -1340,6 +1339,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
deleted file mode 100644
index f0bf255f5f0..00000000000
--- a/t/helper/test-prio-queue.c
+++ /dev/null
@@ -1,51 +0,0 @@
-#include "test-tool.h"
-#include "prio-queue.h"
-
-static int intcmp(const void *va, const void *vb, void *data UNUSED)
-{
-	const int *a = va, *b = vb;
-	return *a - *b;
-}
-
-static void show(int *v)
-{
-	if (!v)
-		printf("NULL\n");
-	else
-		printf("%d\n", *v);
-	free(v);
-}
-
-int cmd__prio_queue(int argc UNUSED, const char **argv)
-{
-	struct prio_queue pq = { intcmp };
-
-	while (*++argv) {
-		if (!strcmp(*argv, "get")) {
-			void *peek = prio_queue_peek(&pq);
-			void *get = prio_queue_get(&pq);
-			if (peek != get)
-				BUG("peek and get results do not match");
-			show(get);
-		} else if (!strcmp(*argv, "dump")) {
-			void *peek;
-			void *get;
-			while ((peek = prio_queue_peek(&pq))) {
-				get = prio_queue_get(&pq);
-				if (peek != get)
-					BUG("peek and get results do not match");
-				show(get);
-			}
-		} else if (!strcmp(*argv, "stack")) {
-			pq.compare = NULL;
-		} else {
-			int *v = xmalloc(sizeof(*v));
-			*v = atoi(*argv);
-			prio_queue_put(&pq, v);
-		}
-	}
-
-	clear_prio_queue(&pq);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 876cd2dc313..5f591b9718f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -57,7 +57,6 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
-	{ "prio-queue", cmd__prio_queue },
 	{ "proc-receive", cmd__proc_receive },
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 70dd4eba119..b921138d8ec 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -50,7 +50,6 @@ int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
-int cmd__prio_queue(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
deleted file mode 100755
index eea99107a48..00000000000
--- a/t/t0009-prio-queue.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-test_description='basic tests for priority queue implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-cat >expect <<'EOF'
-1
-2
-3
-4
-5
-5
-6
-7
-8
-9
-10
-EOF
-test_expect_success 'basic ordering' '
-	test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<'EOF'
-2
-3
-4
-1
-5
-6
-EOF
-test_expect_success 'mixed put and get' '
-	test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<'EOF'
-1
-2
-NULL
-1
-2
-NULL
-EOF
-test_expect_success 'notice empty queue' '
-	test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
-	test_cmp expect actual
-'
-
-cat >expect <<'EOF'
-3
-2
-6
-4
-5
-1
-8
-EOF
-test_expect_success 'stack order' '
-	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
new file mode 100644
index 00000000000..0b826b463e9
--- /dev/null
+++ b/t/unit-tests/t-prio-queue.c
@@ -0,0 +1,101 @@
+#include "test-lib.h"
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
+static int test_prio_queue(int *input, int *result)
+{
+	struct prio_queue pq = { intcmp };
+	int i = 0;
+
+	while (*input) {
+		int *val = input++;
+		void *peek, *get;
+		switch(*val) {
+			case GET:
+				peek = prio_queue_peek(&pq);
+				get = prio_queue_get(&pq);
+				if (peek != get)
+					BUG("peek and get results don't match");
+				result[i++] = show(get);
+				break;
+			case DUMP:
+				while ((peek = prio_queue_peek(&pq))) {
+					get = prio_queue_get(&pq);
+					if (peek != get)
+						BUG("peek and get results don't match");
+					result[i++] = show(get);
+				}
+				break;
+			case STACK:
+				pq.compare = NULL;
+				break;
+			case REVERSE:
+				prio_queue_reverse(&pq);
+				break;
+			default:
+				prio_queue_put(&pq, val);
+				break;
+		}
+	}
+	clear_prio_queue(&pq);
+	return 0;
+}
+
+#define BASIC_INPUT 1, 2, 3, 4, 5, 5, DUMP
+#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
+
+#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
+#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
+
+#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
+#define EMPTY_QUEUE_EXPECTED 1, 2, MISSING, 1, 2, MISSING
+
+#define STACK_INPUT STACK, 1, 5, 4, 6, 2, 3, DUMP
+#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
+
+#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
+#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
+
+#define TEST_INPUT(INPUT, EXPECTED, name)			\
+  static void test_##name(void)				\
+{								\
+	int input[] = {INPUT};					\
+	int expected[] = {EXPECTED};				\
+	int result[ARRAY_SIZE(expected)];			\
+	test_prio_queue(input, result);				\
+	check(!memcmp(expected, result, sizeof(expected)));	\
+}
+
+TEST_INPUT(BASIC_INPUT, BASIC_EXPECTED, basic)
+TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_EXPECTED, mixed)
+TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_EXPECTED, empty)
+TEST_INPUT(STACK_INPUT, STACK_EXPECTED, stack)
+TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_EXPECTED, reverse)
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(test_basic(), "prio-queue works for basic input");
+	TEST(test_mixed(), "prio-queue works for mixed put & get commands");
+	TEST(test_empty(), "prio-queue works when queue is empty");
+	TEST(test_stack(), "prio-queue works when used as a LIFO stack");
+	TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
+
+	return test_done();
+}

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
