Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324C1D6B6
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716812; cv=none; b=l5a1ksVFYkZJXzY/aCQCyC4ir+ZyYRHWfJdON7zQv/eWDAho3JtQHe/ywb9g7hH9euBAKx4bXrPbPN6shU70+oTeG+SZMJ3DEpL08od6EuNPEHB9F1YaN2Qexenh0V4oEO6NpOUKV9xp89bR5KtZMZZDvI4QjzliJzWMs7etXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716812; c=relaxed/simple;
	bh=4+jaOwmv9XFpo0LhfgDh5kkBAWR3AexavPutGtLOvDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6p9K1N05GSPSipSvBPhgzUamQftu5+obLC3JWxJK64psx2u2Ya3C5irw/FkrVhDSSTYV+ioxCgtHefRyP60Kx0hLhLZiu5N9kmwuQdrOp5WIV6QZctcvdvk9/91LTcNQw6TqH6fInGgpzHlyzwZtBV7AmCmIMcQNJJXtq6SdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi5DIRcq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi5DIRcq"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e46db0cf82so937478b3a.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708716809; x=1709321609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXDf1A4DGXJgDzvOGXLHdlTEzt06A8OHIYoQiSdTneo=;
        b=gi5DIRcqaHAhI+gCgX+MJDB76i3sF7KT3geK7yShGJbdBU0hW/YM/L8XKpqzxb9gZC
         5yxMpPm4vzUqdkyWzkdgXltkkunHiVptUDmVssilrshBslejfC6THnUMulsdG/rSz60v
         cS0IKgsY6Pj7+Ch3slzoLDuajZFPN99B2Qqt9R/SNcs36LU1h1fob1Xdt6QMkaAdT7Fx
         DMXrARuSZXbQ0JGC3OiMbDItWaLLErvpfZSpocre3vU8j9CrIKXJbu9eJLbC7DqLsa7o
         GUbBZDCEir+AmjHu/+1xdbin7BcEPyi0ADDcjGMZcftIrO1NG+I3yl0AjYbr/qObUcbV
         EKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708716809; x=1709321609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXDf1A4DGXJgDzvOGXLHdlTEzt06A8OHIYoQiSdTneo=;
        b=a6n5Sy1nZrIr1oLUF50PT9tqeDn7mbJ0lwG49na9L5qv0Ku3dnG02UeXC/xWSpVkvb
         2bTz9LDkl9pVpa7iQ2xPThUyPL90llEH1DH3mbPcmy1aL65u9mLwraGHlmBkPZkw3MAS
         kMaF3TeTzn7ITcZcsbn5nLlF6aMAKhIxsZLb1HQ3C7D6jWBQQRbBivYUGacFYCvkhsjf
         RW9J/rbERrc9h8bPlkqXjjAXYSr/8/JJxmWIl0G1XpgC6n6lsZa//RbZpBL6oM7vL2cW
         lWEcpSZKBHGuB36Dyva9wJIzShcBYsN53jHL25K6eoa1g1Ta3yLBClHTmpa7QEIognMI
         hIvw==
X-Gm-Message-State: AOJu0YwmWtXTMEFsK+5Pe9BQznW5nHBudbQhVF4C2mGRWIZ6UrohI9U9
	FYLGh75THE3jwsG0MQ0O/bvdwaqRij8kViFYjKxbVP46+XgwMGIa1/JlpG+l
X-Google-Smtp-Source: AGHT+IHXC5zcuGOjhhPdptUs4bqNsgzut/JIQQtqf9t54FTT2svK9PwMLheLS+YDQyKQqv0NrErFWQ==
X-Received: by 2002:aa7:85ce:0:b0:6e4:9ba7:a622 with SMTP id z14-20020aa785ce000000b006e49ba7a622mr737414pfn.19.1708716808510;
        Fri, 23 Feb 2024 11:33:28 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78ec2000000b006e4d2cbcac8sm3179450pfr.94.2024.02.23.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 11:33:28 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH] unit-tests: convert t/helper/test-oid-array.c to unit-tests
Date: Sat, 24 Feb 2024 01:02:48 +0530
Message-ID: <20240223193257.9222-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate t/helper/test-oid-array.c and t/t0064-oid-array.sh to the
recently added unit testing framework. This would improve runtime
performance and provide better debugging via displaying array content,
index at which the test failed etc. directly to stdout.

There is only one change in the new testing approach. In the previous
testing method, a new repo gets initialized for the test according to
GIT_TEST_DEFAULT_HASH algorithm. In unit testing however, we do not
need to initialize the repo. We can set the length of the hexadecimal
strbuf according to the algorithm used directly.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
[RFC]: I recently saw a series by Eric W. Biederman [1] which enables
the use of oid's with different hash algorithms into the same
oid_array safely. However, there were no tests added for this. So, I
am wondering if we should have a input format which allows us to
specify hash algo for each oid with its hex value. i.e. "sha1:55" or
"sha256:55", instead of just "55" and relying on GIT_TEST_DEFAULT_HASH
for algo. So far, I tried to imitate the existing tests but I suppose
this may be useful in the future if that series gets merged.

 Makefile                   |   2 +-
 t/helper/test-oid-array.c  |  45 --------
 t/helper/test-tool.c       |   1 -
 t/helper/test-tool.h       |   1 -
 t/t0064-oid-array.sh       | 104 -----------------
 t/unit-tests/t-oid-array.c | 222 +++++++++++++++++++++++++++++++++++++
 6 files changed, 223 insertions(+), 152 deletions(-)
 delete mode 100644 t/helper/test-oid-array.c
 delete mode 100755 t/t0064-oid-array.sh
 create mode 100644 t/unit-tests/t-oid-array.c

diff --git a/Makefile b/Makefile
index 78e874099d..5060d7eff3 100644
--- a/Makefile
+++ b/Makefile
@@ -820,7 +820,6 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
-TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-oidtree.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
@@ -1346,6 +1345,7 @@ UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
deleted file mode 100644
index aafe398ef0..0000000000
--- a/t/helper/test-oid-array.c
+++ /dev/null
@@ -1,45 +0,0 @@
-#include "test-tool.h"
-#include "hex.h"
-#include "oid-array.h"
-#include "setup.h"
-#include "strbuf.h"
-
-static int print_oid(const struct object_id *oid, void *data UNUSED)
-{
-	puts(oid_to_hex(oid));
-	return 0;
-}
-
-int cmd__oid_array(int argc UNUSED, const char **argv UNUSED)
-{
-	struct oid_array array = OID_ARRAY_INIT;
-	struct strbuf line = STRBUF_INIT;
-	int nongit_ok;
-
-	setup_git_directory_gently(&nongit_ok);
-
-	while (strbuf_getline(&line, stdin) != EOF) {
-		const char *arg;
-		struct object_id oid;
-
-		if (skip_prefix(line.buf, "append ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
-			oid_array_append(&array, &oid);
-		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
-			printf("%d\n", oid_array_lookup(&array, &oid));
-		} else if (!strcmp(line.buf, "clear"))
-			oid_array_clear(&array);
-		else if (!strcmp(line.buf, "for_each_unique"))
-			oid_array_for_each_unique(&array, print_oid, NULL);
-		else
-			die("unknown command: %s", line.buf);
-	}
-
-	strbuf_release(&line);
-	oid_array_clear(&array);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 482a1e58a4..ad74bfffbe 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -42,7 +42,6 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
-	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
 	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b1be7cfcf5..4f961a38c0 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -65,7 +65,6 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_is_sha1dc(int argc, const char **argv);
-int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
deleted file mode 100755
index 88c89e8f48..0000000000
--- a/t/t0064-oid-array.sh
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/sh
-
-test_description='basic tests for the oid array implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-echoid () {
-	prefix="${1:+$1 }"
-	shift
-	while test $# -gt 0
-	do
-		echo "$prefix$ZERO_OID" | sed -e "s/00/$1/g"
-		shift
-	done
-}
-
-test_expect_success 'ordered enumeration' '
-	echoid "" 44 55 88 aa >expect &&
-	{
-		echoid append 88 44 aa 55 &&
-		echo for_each_unique
-	} | test-tool oid-array >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'ordered enumeration with duplicate suppression' '
-	echoid "" 44 55 88 aa >expect &&
-	{
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echo for_each_unique
-	} | test-tool oid-array >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'lookup' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -eq 1
-'
-
-test_expect_success 'lookup non-existing entry' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid lookup 33
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -lt 0
-'
-
-test_expect_success 'lookup with duplicates' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -ge 3 &&
-	test "$n" -le 5
-'
-
-test_expect_success 'lookup non-existing entry with duplicates' '
-	{
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid append 88 44 aa 55 &&
-		echoid lookup 66
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -lt 0
-'
-
-test_expect_success 'lookup with almost duplicate values' '
-	# n-1 5s
-	root=$(echoid "" 55) &&
-	root=${root%5} &&
-	{
-		id1="${root}5" &&
-		id2="${root}f" &&
-		echo "append $id1" &&
-		echo "append $id2" &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -eq 0
-'
-
-test_expect_success 'lookup with single duplicate value' '
-	{
-		echoid append 55 55 &&
-		echoid lookup 55
-	} | test-tool oid-array >actual &&
-	n=$(cat actual) &&
-	test "$n" -ge 0 &&
-	test "$n" -le 1
-'
-
-test_done
diff --git a/t/unit-tests/t-oid-array.c b/t/unit-tests/t-oid-array.c
new file mode 100644
index 0000000000..b4f43c025d
--- /dev/null
+++ b/t/unit-tests/t-oid-array.c
@@ -0,0 +1,222 @@
+#include "test-lib.h"
+#include "hex.h"
+#include "oid-array.h"
+#include "strbuf.h"
+
+#define INPUT "88", "44", "aa", "55"
+#define INPUT_DUP \
+	"88", "44", "aa", "55", "88", "44", "aa", "55", "88", "44", "aa", "55"
+#define INPUT_ONLY_DUP "55", "55"
+#define ENUMERATION_RESULT_SORTED "44", "55", "88", "aa"
+
+/*
+ * allocates the memory based on the hash algorithm used and sets the length to
+ * it.
+ */
+static void hex_strbuf_init(struct strbuf *hex)
+{
+	static int sz = -1;
+
+	if (sz == -1) {
+		char *algo_env = getenv("GIT_TEST_DEFAULT_HASH");
+		if (algo_env && !strcmp(algo_env, "sha256"))
+			sz = GIT_SHA256_HEXSZ;
+		else
+			sz = GIT_SHA1_HEXSZ;
+	}
+
+	strbuf_init(hex, sz);
+	strbuf_setlen(hex, sz);
+}
+
+/* callback function for for_each used for printing */
+static int print_cb(const struct object_id *oid, void *data)
+{
+	int *i = data;
+	test_msg("%d. %s", *i, oid_to_hex(oid));
+	*i += 1;
+	return 0;
+}
+
+/* prints the oid_array with a message title */
+static void print_oid_array(struct oid_array *array, char *msg)
+{
+	int i = 0;
+	test_msg("%s", msg);
+	oid_array_for_each(array, print_cb, &i);
+}
+
+/* fills the hex strbuf with alternating characters from 'c' */
+static void fill_hex_strbuf(struct strbuf *hex, char *c)
+{
+	size_t i;
+	for (i = 0; i < hex->len; i++)
+		hex->buf[i] = (i & 1) ? c[1] : c[0];
+}
+
+/* populates object_id with hexadecimal representation generated from 'c' */
+static int get_oid_hex_input(struct object_id *oid, char *c)
+{
+	int ret;
+	struct strbuf hex;
+
+	hex_strbuf_init(&hex);
+	fill_hex_strbuf(&hex, c);
+	ret = get_oid_hex_any(hex.buf, oid);
+	if (ret == GIT_HASH_UNKNOWN)
+		test_msg("not a valid hexadecimal oid: %s", hex.buf);
+	strbuf_release(&hex);
+	return ret;
+}
+
+/* populates the oid_array with input from entries array */
+static int populate_oid_array(struct oid_array *oidarray, char **entries,
+			      size_t len)
+{
+	size_t i;
+	struct object_id oid;
+
+	for (i = 0; i < len; i++) {
+		if (!check_int(get_oid_hex_input(&oid, entries[i]), !=,
+			       GIT_HASH_UNKNOWN))
+			return -1;
+		oid_array_append(oidarray, &oid);
+	}
+	return 0;
+}
+
+/* callback function for enumeration test */
+static int add_to_oid_array(const struct object_id *oid, void *data)
+{
+	struct oid_array *array = data;
+	oid_array_append(array, oid);
+	return 0;
+}
+
+static void test_enumeration(char *input_entries[], size_t input_size,
+			     char *expected_entries[], size_t expected_size)
+{
+	int i;
+	struct oid_array input = OID_ARRAY_INIT;
+	struct oid_array actual = OID_ARRAY_INIT;
+	struct oid_array expect = OID_ARRAY_INIT;
+
+	if (populate_oid_array(&input, input_entries, input_size) == -1)
+		goto cleanup;
+
+	if (populate_oid_array(&expect, expected_entries, expected_size) == -1)
+		goto cleanup;
+
+	oid_array_for_each_unique(&input, add_to_oid_array, &actual);
+	if (!check_int(expect.nr, ==, expected_size) ||
+	    !check_int(actual.nr, ==, expected_size))
+		goto cleanup;
+
+	for (i = 0; i < expected_size; i++) {
+		if (!check_int(oideq(&actual.oid[i], &expect.oid[i]), ==, 1)) {
+			test_msg("failed at index %d", i);
+			print_oid_array(&expect, "expected array content:");
+			print_oid_array(&actual, "actual array content:");
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	oid_array_clear(&input);
+	oid_array_clear(&actual);
+	oid_array_clear(&expect);
+}
+
+#define ENUMERATION_INPUT(INPUT, RESULT, NAME)                                \
+	static void t_ordered_enumeration_##NAME(void)                        \
+	{                                                                     \
+		char *input_entries[] = { INPUT };                            \
+		char *expected_entries[] = { RESULT };                        \
+		size_t input_size = ARRAY_SIZE(input_entries);                \
+		size_t expected_size = ARRAY_SIZE(expected_entries);          \
+		test_enumeration(input_entries, input_size, expected_entries, \
+				 expected_size);                              \
+	}
+
+ENUMERATION_INPUT(INPUT, ENUMERATION_RESULT_SORTED, non_duplicate)
+ENUMERATION_INPUT(INPUT_DUP, ENUMERATION_RESULT_SORTED, duplicate)
+
+static void lookup_setup(void (*f)(struct strbuf *buf, struct oid_array *array))
+{
+	struct oid_array array = OID_ARRAY_INIT;
+	struct strbuf buf;
+
+	hex_strbuf_init(&buf);
+	f(&buf, &array);
+	oid_array_clear(&array);
+	strbuf_release(&buf);
+}
+
+#define LOOKUP_INPUT(INPUT, QUERY, NAME, CONDITION)                           \
+	static void t_##NAME(struct strbuf *buf UNUSED,                       \
+			     struct oid_array *array)                         \
+	{                                                                     \
+		struct object_id oid_query;                                   \
+		char *input_entries[] = { INPUT };                            \
+		size_t input_size = ARRAY_SIZE(input_entries);                \
+		int ret;                                                      \
+		if (!check_int(get_oid_hex_input(&oid_query, QUERY), !=,      \
+			       GIT_HASH_UNKNOWN))                             \
+			return;                                               \
+		if (!check_int(populate_oid_array(array, input_entries,       \
+						  input_size),                \
+			       !=, -1))                                       \
+			return;                                               \
+		ret = oid_array_lookup(array, &oid_query);                    \
+		if (!check(CONDITION)) {                                      \
+			print_oid_array(array, "array content:");             \
+			test_msg("oid query for lookup: %s", oid_query.hash); \
+		}                                                             \
+	}
+
+/* ret is return value of oid_array_lookup() */
+LOOKUP_INPUT(INPUT, "55", lookup, ret == 1)
+LOOKUP_INPUT(INPUT, "33", lookup_nonexist, ret < 1)
+LOOKUP_INPUT(INPUT_DUP, "66", lookup_nonexist_dup, ret < 0)
+LOOKUP_INPUT(INPUT_DUP, "55", lookup_dup, ret >= 3 && ret <= 5)
+LOOKUP_INPUT(INPUT_ONLY_DUP, "55", lookup_only_dup, ret >= 0 && ret <= 1)
+
+static void t_lookup_almost_dup(struct strbuf *hex, struct oid_array *array)
+{
+	struct object_id oid;
+
+	fill_hex_strbuf(hex, "55");
+	if (!check_int(get_oid_hex_any(hex->buf, &oid), !=, GIT_HASH_UNKNOWN))
+		return;
+
+	oid_array_append(array, &oid);
+	/* last character different */
+	hex->buf[hex->len - 1] = 'f';
+	if (!check_int(get_oid_hex_any(hex->buf, &oid), !=, GIT_HASH_UNKNOWN))
+		return;
+
+	oid_array_append(array, &oid);
+	if (!check_int(oid_array_lookup(array, &oid), ==, 1)) {
+		print_oid_array(array, "array content:");
+		test_msg("oid query for lookup: %s", hex->buf);
+	}
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(t_ordered_enumeration_non_duplicate(),
+	     "ordered enumeration works");
+	TEST(t_ordered_enumeration_duplicate(),
+	     "ordered enumeration with duplicate suppresion works");
+	TEST(lookup_setup(t_lookup), "lookup works");
+	TEST(lookup_setup(t_lookup_nonexist), "lookup non-existant entry");
+	TEST(lookup_setup(t_lookup_dup), "lookup with duplicates works");
+	TEST(lookup_setup(t_lookup_nonexist_dup),
+	     "lookup non-existant entry with duplicates");
+	TEST(lookup_setup(t_lookup_almost_dup),
+	     "lookup with almost duplicate values works");
+	TEST(lookup_setup(t_lookup_only_dup),
+	     "lookup with single duplicate value works");
+
+	return test_done();
+}
-- 
2.43.2

