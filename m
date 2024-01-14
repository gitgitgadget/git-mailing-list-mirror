Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CDE1860
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUN9faEv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e62e6e3b0so27205685e9.2
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 00:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705219831; x=1705824631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ELij8VhuonTnzk70CnO7oG3bML9Wbjx1dZ7S6FluVv4=;
        b=UUN9faEv7rOBGSHzDWAeCTtIY62Fo2gKr7x4ctAE2R2wa0LNnRSAGlhnJycp/pce3Y
         h7Pn3dPTY4UcjgsJCQrupWwc6Mc+PZKS07xQVdswsVu7fzQGv99EgJfj7AUnFXCI4Tzm
         Mhr7wp1VA3Hxc7AJp7cHM0BxFjhC98dUlW6blm11JhnLdCWwAW9cK4PsRSwM8KDzGAO6
         ER0iGql2NdhFgcq3/T28FLMBSJrXU+hhirv2787bBSXEAS3E0v/GzgU7cUjccoa/Dv+J
         CUfs0iNOBC53hy0mbjNLXUHcWq1a/8H5vv4/g+50o3kUBkwJllIs2DBCPAItR4aP7Q1Z
         e4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705219831; x=1705824631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELij8VhuonTnzk70CnO7oG3bML9Wbjx1dZ7S6FluVv4=;
        b=kez+nEs7Ii3TXg1/1ha3bV+ipRfQVMx/rP+h7debZHDrcVwQAX08MpkSI2U/PsMfg3
         7jlaQco9wh2jzmO8niY9gNMx7qvBHoFp+QjIJq1n4o65H6cDH5dub/qU100AFeGC9CW2
         2nm0HpKxlTnjYyPpXCxwYU0j1mLybMmeSaj2HxDR43ykHjpA83UuJZVZ00IHLrTWhyqD
         Jcxmjx0eytQwxz4+z8TgozMVRisW4dKW+jPnpPFChmBpDjwVrOAQ8pDD/srRP1NEYjtL
         7GujVvBGydhN7d07TJZgnwSnu/bATvRf1MgRZsrndqaDpYYOB5b+0vt0vqrZH1kWaxTR
         2ELA==
X-Gm-Message-State: AOJu0YxJ5WEOSNzwfKSa4PBA3t3kJWjttQn4qwYS4ydnGDA6/KLYgc9u
	7nt/4wRp43nsBKlWivTPtsVI2EwqCtA=
X-Google-Smtp-Source: AGHT+IFxcCOCV7uw5Wh2EsUPQuHzHXRFhOjeY4DPk9L7IeILGAvM0vzokSgk8aTdLqKLDCJ6wVMn1g==
X-Received: by 2002:a7b:c7c6:0:b0:40e:6271:a2b2 with SMTP id z6-20020a7bc7c6000000b0040e6271a2b2mr1362985wmk.240.1705219831087;
        Sun, 14 Jan 2024 00:10:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1-20020adfa181000000b003368d2e729bsm8581041wru.43.2024.01.14.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 00:10:30 -0800 (PST)
Message-ID: <pull.1642.git.1705219829965.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jan 2024 08:10:29 +0000
Subject: [PATCH] tests: move t0009-prio-queue.sh to the new unit testing
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1642%2FChand-ra%2Fprio-queue-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1642/Chand-ra/prio-queue-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1642

 Makefile                    |  2 +-
 t/helper/test-prio-queue.c  | 51 -------------------
 t/helper/test-tool.c        |  1 -
 t/helper/test-tool.h        |  1 -
 t/t0009-prio-queue.sh       | 66 -------------------------
 t/unit-tests/t-prio-queue.c | 99 +++++++++++++++++++++++++++++++++++++
 6 files changed, 100 insertions(+), 120 deletions(-)
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
index 00000000000..98a69790f7e
--- /dev/null
+++ b/t/unit-tests/t-prio-queue.c
@@ -0,0 +1,99 @@
+#include "test-lib.h"
+#include "prio-queue.h"
+
+static int intcmp(const void *va, const void *vb, void *data UNUSED)
+{
+	const int *a = va, *b = vb;
+	return *a - *b;
+}
+
+static int show(int *v)
+{
+	int ret = -1;
+	if (v)
+		ret = *v;
+	free(v);
+	return ret;
+}
+
+static int test_prio_queue(const char **input, int *result)
+{
+	struct prio_queue pq = { intcmp };
+	int i = 0;
+
+	while (*input) {
+		if (!strcmp(*input, "get")) {
+			void *peek = prio_queue_peek(&pq);
+			void *get = prio_queue_get(&pq);
+			if (peek != get)
+				BUG("peek and get results do not match");
+			result[i++] = show(get);
+		} else if (!strcmp(*input, "dump")) {
+			void *peek;
+			void *get;
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				if (peek != get)
+					BUG("peek and get results do not match");
+				result[i++] = show(get);
+			}
+		} else if (!strcmp(*input, "stack")) {
+			pq.compare = NULL;
+		} else if (!strcmp(*input, "reverse")) {
+			prio_queue_reverse(&pq);
+		} else {
+			int *v = xmalloc(sizeof(*v));
+			*v = atoi(*input);
+			prio_queue_put(&pq, v);
+		}
+		input++;
+	}
+
+	clear_prio_queue(&pq);
+
+	return 0;
+}
+
+#define INPUT_SIZE 6
+
+#define BASIC_INPUT "1", "2", "3", "4", "5", "5", "dump"
+#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
+
+#define MIXED_PUT_GET_INPUT "6", "2", "4", "get", "5", "3", "get", "get", "1", "dump"
+#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
+
+#define EMPTY_QUEUE_INPUT "1", "2", "get", "get", "get", "1", "2", "get", "get", "get"
+#define EMPTY_QUEUE_EXPECTED 1, 2, -1, 1, 2, -1
+
+#define STACK_INPUT "stack", "1", "5", "4", "6", "2", "3", "dump"
+#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
+
+#define REVERSE_STACK_INPUT "stack", "1", "2", "3", "4", "5", "6", "reverse", "dump"
+#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
+
+#define TEST_INPUT(INPUT, EXPECTED, name)		\
+  static void test_##name(void)					\
+{											\
+	const char *input[] = {INPUT};						\
+	int expected[] = {EXPECTED};					\
+	int result[INPUT_SIZE];								\
+	test_prio_queue(input, result);						\
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
