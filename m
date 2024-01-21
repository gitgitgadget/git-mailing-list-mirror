Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F0374EB
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865331; cv=none; b=jTi+5Jl+hmjF0hOLf1T0j51W/OvY2kazQ8v6S0HTDWaiYprMMougEdhpmNnIDiKLE1m24c6UU2jDNchiCxn1mYehSQHmf4UUd/4ofmEyhais4SnluasooDjvZHw48v4+Nm09O97cWK3GJb2hkSQ/mSyubWB6M/O6oeeuGdloDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865331; c=relaxed/simple;
	bh=OevNwVNRWYM+4W09e/INIqf4BzOgq3GcVpHxuPdiHWY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CIfporMOpt1BQ3t1hNAvcB5CjEQDT98C0GeI4DhyT+UTN2tHKDcxf3nfn3BW8LFsIy+ud5EFxBc7ya+l00dKbk2WkhmEUPQYv9idGu22IBBXpcWcD7HR8kMg+aBcouzbxL927j5LFDa0DBm530u4bnpi/qWxh3N6o9R3D9/r21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL8rLVPh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL8rLVPh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so28528795e9.3
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705865327; x=1706470127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKseWQj6naWYl7UuPsqGUJaMhflKPbfQBw6cS9H3nCQ=;
        b=BL8rLVPhNQnLChSFUznJ1KQi7SMHH9csdgtJWCar69ynCHPBzakXY3jlutJwG6WHGE
         iaPOgd4GE8hxlfqhbX8mKx2MuJI5KRNJ1ADRN+k4GtrCijoC/61OwmKOILKfGFp1c2W0
         dyOQfxmtkPyXNhGs/8KvFNomNqOLS0Pq6YFdwUpqk4gtlf0G8Vwx9GMrDHfSsQsevMIu
         EQEEzGMhPx0gtftUd+UBiMKMH5hTe0aWczGh5OlHp05BRWpBJUqT+vwqMwjur+LG/FGw
         PuOA1/saU+4xYprtXYWiEp57LmM1DTKqjmpg/GUfDZgSM2wD7qjUZPu0C3ZzaunVHTZ3
         hiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865327; x=1706470127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKseWQj6naWYl7UuPsqGUJaMhflKPbfQBw6cS9H3nCQ=;
        b=RU6GXiBQQYu7vB08COU6WlklksjJowAshWCc4Kn9BQXiEsxZuaqRoCc5jgvW/PXrre
         Mnz1IkG09eY8qOwK60x/zdQbCXHSdT4TRY2NZSo4cME6lBdiqW1Tgpiy0SqvkcxdWGHE
         tci2ECUTc99h4eZPrShfBKk78wZ8cGR4jkLtcFKHOBx2GZrOPfq9R3OEJU/bK6ez8x9m
         u9THiMJDQvNtsWIzXwy+R2U2JzeQW3iFK4ZJw5e/K4x8ogjH/T693piSbC4hc9ZrOnYx
         tk1gx+PbJrp6dj9HpOnSO/I/GTy4ikBrEDxKrbsdg4oTa2zJNPsg7GxzbSlDLPKDDLTw
         qB4g==
X-Gm-Message-State: AOJu0Yz7N6KNmZG/AkMTWr7K1M0lmufhN5yKRtxyCJYeeVEDL+xGQT6A
	jsMXUGLWJhWpX9ei1MysZH0M1qRTzvxZSpqpz8TBjpluEL00hlh6HhwykMhS
X-Google-Smtp-Source: AGHT+IFKoJNQnLd6JmKdtEwdw4LSKgnqiM8LCLqefPR3eowxCtTg+xZD0ns3X8e81X/aoWu4XubBIg==
X-Received: by 2002:a05:600c:181c:b0:40e:8df4:ef96 with SMTP id n28-20020a05600c181c00b0040e8df4ef96mr1637171wmp.153.1705865327426;
        Sun, 21 Jan 2024 11:28:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b0040e3ac9f4c8sm40301862wmo.28.2024.01.21.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:28:47 -0800 (PST)
Message-ID: <pull.1642.v4.git.1705865326185.gitgitgadget@gmail.com>
In-Reply-To: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
References: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 19:28:45 +0000
Subject: [PATCH v4] tests: move t0009-prio-queue.sh to the new unit testing
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
    Jeff King <peff@peff.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
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
    
    Thanks to Jeff, Philip and Junio for your valuable feedbacks! I have
    updated the patch so that the resulting tests are more verbose when they
    fail and lesser prone to memory related errors.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1642%2FChand-ra%2Fprio-queue-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1642/Chand-ra/prio-queue-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1642

Range-diff vs v3:

 1:  6b10028177a ! 1:  e9a0dba6f47 tests: move t0009-prio-queue.sh to the new unit testing framework
     @@ t/unit-tests/t-prio-queue.c (new)
      +	return v ? *v : MISSING;
      +}
      +
     -+static int test_prio_queue(int *input, int *result)
     ++static void test_prio_queue(int *input, int *result, size_t input_size)
      +{
      +	struct prio_queue pq = { intcmp };
     -+	int i = 0;
      +
     -+	while (*input) {
     -+		int *val = input++;
     ++	for (int i = 0, j = 0; i < input_size; i++) {
      +		void *peek, *get;
     -+		switch(*val) {
     -+			case GET:
     -+				peek = prio_queue_peek(&pq);
     ++		switch(input[i]) {
     ++		case GET:
     ++			peek = prio_queue_peek(&pq);
     ++			get = prio_queue_get(&pq);
     ++			if (!check(peek == get))
     ++				return;
     ++			if(!check_int(result[j++], ==, show(get)))
     ++				test_msg("failed at result[] index %d", j-1);
     ++			break;
     ++		case DUMP:
     ++			while ((peek = prio_queue_peek(&pq))) {
      +				get = prio_queue_get(&pq);
     -+				if (peek != get)
     -+					BUG("peek and get results don't match");
     -+				result[i++] = show(get);
     -+				break;
     -+			case DUMP:
     -+				while ((peek = prio_queue_peek(&pq))) {
     -+					get = prio_queue_get(&pq);
     -+					if (peek != get)
     -+						BUG("peek and get results don't match");
     -+					result[i++] = show(get);
     -+				}
     -+				break;
     -+			case STACK:
     -+				pq.compare = NULL;
     -+				break;
     -+			case REVERSE:
     -+				prio_queue_reverse(&pq);
     -+				break;
     -+			default:
     -+				prio_queue_put(&pq, val);
     -+				break;
     ++				if (!check(peek == get))
     ++					return;
     ++				if(!check_int(result[j++], ==, show(get)))
     ++					test_msg("failed at result[] index %d", j-1);
     ++			}
     ++			break;
     ++		case STACK:
     ++			pq.compare = NULL;
     ++			break;
     ++		case REVERSE:
     ++			prio_queue_reverse(&pq);
     ++			break;
     ++		default:
     ++			prio_queue_put(&pq, &input[i]);
     ++			break;
      +		}
      +	}
      +	clear_prio_queue(&pq);
     -+	return 0;
      +}
      +
     -+#define BASIC_INPUT 1, 2, 3, 4, 5, 5, DUMP
     -+#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
     ++#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
     ++#define BASIC_RESULT 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
      +
      +#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
     -+#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
     ++#define MIXED_PUT_GET_RESULT 2, 3, 4, 1, 5, 6
      +
      +#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
     -+#define EMPTY_QUEUE_EXPECTED 1, 2, MISSING, 1, 2, MISSING
     ++#define EMPTY_QUEUE_RESULT 1, 2, MISSING, 1, 2, MISSING
      +
     -+#define STACK_INPUT STACK, 1, 5, 4, 6, 2, 3, DUMP
     -+#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
     ++#define STACK_INPUT STACK, 8, 1, 5, 4, 6, 2, 3, DUMP
     ++#define STACK_RESULT 3, 2, 6, 4, 5, 1, 8
      +
      +#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
     -+#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
     ++#define REVERSE_STACK_RESULT 1, 2, 3, 4, 5, 6
      +
     -+#define TEST_INPUT(INPUT, EXPECTED, name)			\
     ++#define TEST_INPUT(INPUT, RESULT, name)			\
      +  static void test_##name(void)				\
      +{								\
      +	int input[] = {INPUT};					\
     -+	int expected[] = {EXPECTED};				\
     -+	int result[ARRAY_SIZE(expected)];			\
     -+	test_prio_queue(input, result);				\
     -+	check(!memcmp(expected, result, sizeof(expected)));	\
     ++	int result[] = {RESULT};				\
     ++	test_prio_queue(input, result, ARRAY_SIZE(input));	\
      +}
      +
     -+TEST_INPUT(BASIC_INPUT, BASIC_EXPECTED, basic)
     -+TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_EXPECTED, mixed)
     -+TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_EXPECTED, empty)
     -+TEST_INPUT(STACK_INPUT, STACK_EXPECTED, stack)
     -+TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_EXPECTED, reverse)
     ++TEST_INPUT(BASIC_INPUT, BASIC_RESULT, basic)
     ++TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_RESULT, mixed)
     ++TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_RESULT, empty)
     ++TEST_INPUT(STACK_INPUT, STACK_RESULT, stack)
     ++TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_RESULT, reverse)
      +
      +int cmd_main(int argc, const char **argv)
      +{


 Makefile                    |  2 +-
 t/helper/test-prio-queue.c  | 51 -------------------
 t/helper/test-tool.c        |  1 -
 t/helper/test-tool.h        |  1 -
 t/t0009-prio-queue.sh       | 66 -------------------------
 t/unit-tests/t-prio-queue.c | 98 +++++++++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+), 120 deletions(-)
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
index 00000000000..d78b002f9ea
--- /dev/null
+++ b/t/unit-tests/t-prio-queue.c
@@ -0,0 +1,98 @@
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
+static void test_prio_queue(int *input, int *result, size_t input_size)
+{
+	struct prio_queue pq = { intcmp };
+
+	for (int i = 0, j = 0; i < input_size; i++) {
+		void *peek, *get;
+		switch(input[i]) {
+		case GET:
+			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
+			if (!check(peek == get))
+				return;
+			if(!check_int(result[j++], ==, show(get)))
+				test_msg("failed at result[] index %d", j-1);
+			break;
+		case DUMP:
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				if (!check(peek == get))
+					return;
+				if(!check_int(result[j++], ==, show(get)))
+					test_msg("failed at result[] index %d", j-1);
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
+	clear_prio_queue(&pq);
+}
+
+#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
+#define BASIC_RESULT 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
+
+#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
+#define MIXED_PUT_GET_RESULT 2, 3, 4, 1, 5, 6
+
+#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
+#define EMPTY_QUEUE_RESULT 1, 2, MISSING, 1, 2, MISSING
+
+#define STACK_INPUT STACK, 8, 1, 5, 4, 6, 2, 3, DUMP
+#define STACK_RESULT 3, 2, 6, 4, 5, 1, 8
+
+#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
+#define REVERSE_STACK_RESULT 1, 2, 3, 4, 5, 6
+
+#define TEST_INPUT(INPUT, RESULT, name)			\
+  static void test_##name(void)				\
+{								\
+	int input[] = {INPUT};					\
+	int result[] = {RESULT};				\
+	test_prio_queue(input, result, ARRAY_SIZE(input));	\
+}
+
+TEST_INPUT(BASIC_INPUT, BASIC_RESULT, basic)
+TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_RESULT, mixed)
+TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_RESULT, empty)
+TEST_INPUT(STACK_INPUT, STACK_RESULT, stack)
+TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_RESULT, reverse)
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
