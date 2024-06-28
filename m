Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269715572B
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578549; cv=none; b=i1qt/Ja1ZV+A95wRX37FogQCFTpQHjPTjreudGNXjt+C8A/0w/LZLCwRTvDUFWwIEFOfrX72cyhbvkpS+ZTO7EL/DYL8zrUeVe3Rev5IWexILaTBClJ/18tqhCJ3kxoBiwVAInh4aMBJ5gBFlgpK6vB1DRe5UVOkxLxiV7XgmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578549; c=relaxed/simple;
	bh=yylvPHscusQO2OyAiLLlFoU6chSlxeuu+/xUfGbM8dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qa8OAMelQqDUcsQ4bSq9GQ3bs23luR3znGIiBLCPofilZSPMD67HYZxevAK0RCLPKx7Q5E2RXmggpDvS/7y2pn0bhri92FHFYK7mgm3BYJOGzboeqj9Mul3TJVy338hSN5RekYq1JoU6/YcIMQZ4Sr7lyJo+Qy7sZqd4hX4Q31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNHrTFAj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNHrTFAj"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70670fb3860so390210b3a.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578544; x=1720183344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRjf3+FZAd7bXXoD7gwowTK8+7VvvsUobFn3eFw9wbw=;
        b=HNHrTFAj+24Dbo8xk+HWxNJe0k9G7oLu9yrQ2u+jfExTmMsTebGt4CqObXomVUYKWO
         huu4rCqGWxWJOHtHp9FLQMVP5ABZFjmP4WwX/C9WghkGQukE/ztgpVH9ct57Pdc+D3bT
         LZgUA33yaXOqn02NCJUQHYUPZt7+P4VePm3qYkbCN8jJO2xw/eYg8ggBJNgTnvlH7m37
         B9Ok3bAlC6MFZRHM2to7PcBAtwsbe8pns1wpvDQ1A8uX6/2RXawxAnNoEsf+r2nHd5sL
         vl6MgVm8Bu28HtPebYkJNmj/7cXqtOjYZOXaVXxmJkG6HNez+9cgoBtPArkLj/a9H8W9
         KUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578544; x=1720183344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRjf3+FZAd7bXXoD7gwowTK8+7VvvsUobFn3eFw9wbw=;
        b=ZxuhaKFesExmxghR5KM80RS0zHKtXovtmuOclaugJoaLuLu09phKDugMiECFoDKALn
         4ojicjQWCZXI4k0aHT7BHphPwgPDjHYBAapGDTMC/BP3aWqEEf+xKrziaL4flYjObKfu
         Rcm/KkT/DIJWoHBxSzTfWBnjutcL38t2voOz1Q+8/VF4Rh527mDdynpMSm/8b6aMlP88
         xI+ev4KOFWskMETzHNktDau24u+P1FsuLOJiaLzw9e3yfzbUTq+xdk0RzoAV/qQDX+gm
         a3hVsySaqR1qSQpHCev3KoBRzyWxqQTb4b7rSWxTCasGXJxQDd7fBdyaWuSZlFTbxxqa
         fcSA==
X-Gm-Message-State: AOJu0Yy8Zy5Qi/Fiy/SJyVqdKx+TMnnzyTi+8qcuhMEuqsUK6TeJbIdt
	RsnMzSl8tKiGT07p+KbcYoZtlOPRD6IvRGw6jmDUbJzHxGXWBIVxCZ6QnLlJyQA=
X-Google-Smtp-Source: AGHT+IG+i9zCzAQ3wRsUC+y/bRDkjWFeIXa/klua1vvjmaJtO2oCtQXdn8tEbp1UQUQwfCmNX55APw==
X-Received: by 2002:a05:6a00:26e8:b0:706:6255:e4fc with SMTP id d2e1a72fcca58-7066e54388dmr15178772b3a.15.1719578543713;
        Fri, 28 Jun 2024 05:42:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498a3besm1474185b3a.196.2024.06.28.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:42:22 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH] t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
Date: Fri, 28 Jun 2024 18:11:40 +0530
Message-ID: <20240628124149.43688-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
library. Migrate them to the unit testing framework for better
debugging, runtime performance and consice code.

Along with the migration, make 'add' tests from the shellscript order
agnostic in unit tests, since they iterate over entries with the same
keys and we do not guarantee the order.

The helper/test-hashmap.c is still not removed because it contains a
performance test meant to be run by the user directly (not used in
t/perf). And it makes sense for such a utility to be a helper.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 Makefile                 |   1 +
 t/helper/test-hashmap.c  | 100 +-----------
 t/t0011-hashmap.sh       | 260 ------------------------------
 t/unit-tests/t-hashmap.c | 339 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+), 358 deletions(-)
 delete mode 100755 t/t0011-hashmap.sh
 create mode 100644 t/unit-tests/t-hashmap.c

diff --git a/Makefile b/Makefile
index 3eab701b10..74bb026610 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
+UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 2912899558..7b854a7030 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -12,11 +12,6 @@ struct test_entry
 	char key[FLEX_ARRAY];
 };
 
-static const char *get_value(const struct test_entry *e)
-{
-	return e->key + strlen(e->key) + 1;
-}
-
 static int test_entry_cmp(const void *cmp_data,
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
@@ -141,30 +136,16 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 /*
  * Read stdin line by line and print result of commands to stdout:
  *
- * hash key -> strhash(key) memhash(key) strihash(key) memihash(key)
- * put key value -> NULL / old value
- * get key -> NULL / value
- * remove key -> NULL / old value
- * iterate -> key1 value1\nkey2 value2\n...
- * size -> tablesize numentries
- *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
 int cmd__hashmap(int argc, const char **argv)
 {
 	struct string_list parts = STRING_LIST_INIT_NODUP;
 	struct strbuf line = STRBUF_INIT;
-	int icase;
-	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &icase);
-
-	/* init hash map */
-	icase = argc > 1 && !strcmp("ignorecase", argv[1]);
 
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1, *p2;
-		unsigned int hash = 0;
-		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
 		string_list_setlen(&parts, 0);
@@ -180,84 +161,8 @@ int cmd__hashmap(int argc, const char **argv)
 		cmd = parts.items[0].string;
 		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
 		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
-		if (p1)
-			hash = icase ? strihash(p1) : strhash(p1);
-
-		if (!strcmp("add", cmd) && p1 && p2) {
-
-			/* create entry with key = p1, value = p2 */
-			entry = alloc_test_entry(hash, p1, p2);
-
-			/* add to hashmap */
-			hashmap_add(&map, &entry->ent);
-
-		} else if (!strcmp("put", cmd) && p1 && p2) {
-
-			/* create entry with key = p1, value = p2 */
-			entry = alloc_test_entry(hash, p1, p2);
-
-			/* add / replace entry */
-			entry = hashmap_put_entry(&map, entry, ent);
-
-			/* print and free replaced entry, if any */
-			puts(entry ? get_value(entry) : "NULL");
-			free(entry);
-
-		} else if (!strcmp("get", cmd) && p1) {
-			/* lookup entry in hashmap */
-			entry = hashmap_get_entry_from_hash(&map, hash, p1,
-							struct test_entry, ent);
-
-			/* print result */
-			if (!entry)
-				puts("NULL");
-			hashmap_for_each_entry_from(&map, entry, ent)
-				puts(get_value(entry));
-
-		} else if (!strcmp("remove", cmd) && p1) {
-
-			/* setup static key */
-			struct hashmap_entry key;
-			struct hashmap_entry *rm;
-			hashmap_entry_init(&key, hash);
-
-			/* remove entry from hashmap */
-			rm = hashmap_remove(&map, &key, p1);
-			entry = rm ? container_of(rm, struct test_entry, ent)
-					: NULL;
-
-			/* print result and free entry*/
-			puts(entry ? get_value(entry) : "NULL");
-			free(entry);
-
-		} else if (!strcmp("iterate", cmd)) {
-			struct hashmap_iter iter;
-
-			hashmap_for_each_entry(&map, &iter, entry,
-						ent /* member name */)
-				printf("%s %s\n", entry->key, get_value(entry));
-
-		} else if (!strcmp("size", cmd)) {
-
-			/* print table sizes */
-			printf("%u %u\n", map.tablesize,
-			       hashmap_get_size(&map));
-
-		} else if (!strcmp("intern", cmd) && p1) {
-
-			/* test that strintern works */
-			const char *i1 = strintern(p1);
-			const char *i2 = strintern(p1);
-			if (strcmp(i1, p1))
-				printf("strintern(%s) returns %s\n", p1, i1);
-			else if (i1 == p1)
-				printf("strintern(%s) returns input pointer\n", p1);
-			else if (i1 != i2)
-				printf("strintern(%s) != strintern(%s)", i1, i2);
-			else
-				printf("%s\n", i1);
-
-		} else if (!strcmp("perfhashmap", cmd) && p1 && p2) {
+	
+		if (!strcmp("perfhashmap", cmd) && p1 && p2) {
 
 			perf_hashmap(atoi(p1), atoi(p2));
 
@@ -270,6 +175,5 @@ int cmd__hashmap(int argc, const char **argv)
 
 	string_list_clear(&parts, 0);
 	strbuf_release(&line);
-	hashmap_clear_and_free(&map, struct test_entry, ent);
 	return 0;
 }
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
deleted file mode 100755
index 46e74ad107..0000000000
--- a/t/t0011-hashmap.sh
+++ /dev/null
@@ -1,260 +0,0 @@
-#!/bin/sh
-
-test_description='test hashmap and string hash functions'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_hashmap() {
-	echo "$1" | test-tool hashmap $3 > actual &&
-	echo "$2" > expect &&
-	test_cmp expect actual
-}
-
-test_expect_success 'put' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-put foobarfrotz value4
-size" "NULL
-NULL
-NULL
-NULL
-64 4"
-
-'
-
-test_expect_success 'put (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-size" "NULL
-NULL
-NULL
-64 3" ignorecase
-
-'
-
-test_expect_success 'replace' '
-
-test_hashmap "put key1 value1
-put key1 value2
-put fooBarFrotz value3
-put fooBarFrotz value4
-size" "NULL
-value1
-NULL
-value3
-64 2"
-
-'
-
-test_expect_success 'replace (case insensitive)' '
-
-test_hashmap "put key1 value1
-put Key1 value2
-put fooBarFrotz value3
-put foobarfrotz value4
-size" "NULL
-value1
-NULL
-value3
-64 2" ignorecase
-
-'
-
-test_expect_success 'get' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-put foobarfrotz value4
-get key1
-get key2
-get fooBarFrotz
-get notInMap" "NULL
-NULL
-NULL
-NULL
-value1
-value2
-value3
-NULL"
-
-'
-
-test_expect_success 'get (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-get Key1
-get keY2
-get foobarfrotz
-get notInMap" "NULL
-NULL
-NULL
-value1
-value2
-value3
-NULL" ignorecase
-
-'
-
-test_expect_success 'add' '
-
-test_hashmap "add key1 value1
-add key1 value2
-add fooBarFrotz value3
-add fooBarFrotz value4
-get key1
-get fooBarFrotz
-get notInMap" "value2
-value1
-value4
-value3
-NULL"
-
-'
-
-test_expect_success 'add (case insensitive)' '
-
-test_hashmap "add key1 value1
-add Key1 value2
-add fooBarFrotz value3
-add foobarfrotz value4
-get key1
-get Foobarfrotz
-get notInMap" "value2
-value1
-value4
-value3
-NULL" ignorecase
-
-'
-
-test_expect_success 'remove' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-remove key1
-remove key2
-remove notInMap
-size" "NULL
-NULL
-NULL
-value1
-value2
-NULL
-64 1"
-
-'
-
-test_expect_success 'remove (case insensitive)' '
-
-test_hashmap "put key1 value1
-put key2 value2
-put fooBarFrotz value3
-remove Key1
-remove keY2
-remove notInMap
-size" "NULL
-NULL
-NULL
-value1
-value2
-NULL
-64 1" ignorecase
-
-'
-
-test_expect_success 'iterate' '
-	test-tool hashmap >actual.raw <<-\EOF &&
-	put key1 value1
-	put key2 value2
-	put fooBarFrotz value3
-	iterate
-	EOF
-
-	cat >expect <<-\EOF &&
-	NULL
-	NULL
-	NULL
-	fooBarFrotz value3
-	key1 value1
-	key2 value2
-	EOF
-
-	sort <actual.raw >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'iterate (case insensitive)' '
-	test-tool hashmap ignorecase >actual.raw <<-\EOF &&
-	put key1 value1
-	put key2 value2
-	put fooBarFrotz value3
-	iterate
-	EOF
-
-	cat >expect <<-\EOF &&
-	NULL
-	NULL
-	NULL
-	fooBarFrotz value3
-	key1 value1
-	key2 value2
-	EOF
-
-	sort <actual.raw >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'grow / shrink' '
-
-	rm -f in &&
-	rm -f expect &&
-	for n in $(test_seq 51)
-	do
-		echo put key$n value$n >> in &&
-		echo NULL >> expect || return 1
-	done &&
-	echo size >> in &&
-	echo 64 51 >> expect &&
-	echo put key52 value52 >> in &&
-	echo NULL >> expect &&
-	echo size >> in &&
-	echo 256 52 >> expect &&
-	for n in $(test_seq 12)
-	do
-		echo remove key$n >> in &&
-		echo value$n >> expect || return 1
-	done &&
-	echo size >> in &&
-	echo 256 40 >> expect &&
-	echo remove key40 >> in &&
-	echo value40 >> expect &&
-	echo size >> in &&
-	echo 64 39 >> expect &&
-	test-tool hashmap <in >out &&
-	test_cmp expect out
-
-'
-
-test_expect_success 'string interning' '
-
-test_hashmap "intern value1
-intern Value1
-intern value2
-intern value2
-" "value1
-Value1
-value2
-value2"
-
-'
-
-test_done
diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
new file mode 100644
index 0000000000..628aba5231
--- /dev/null
+++ b/t/unit-tests/t-hashmap.c
@@ -0,0 +1,339 @@
+#include "test-lib.h"
+#include "hashmap.h"
+#include "strbuf.h"
+
+struct test_entry {
+	int padding; /* hashmap entry no longer needs to be the first member */
+	struct hashmap_entry ent;
+	/* key and value as two \0-terminated strings */
+	char key[FLEX_ARRAY];
+};
+
+static int test_entry_cmp(const void *cmp_data,
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
+			  const void *keydata)
+{
+	const int ignore_case = cmp_data ? *((int *)cmp_data) : 0;
+	const struct test_entry *e1, *e2;
+	const char *key = keydata;
+
+	e1 = container_of(eptr, const struct test_entry, ent);
+	e2 = container_of(entry_or_key, const struct test_entry, ent);
+
+	if (ignore_case)
+		return strcasecmp(e1->key, key ? key : e2->key);
+	else
+		return strcmp(e1->key, key ? key : e2->key);
+}
+
+static const char *get_value(const struct test_entry *e)
+{
+	return e->key + strlen(e->key) + 1;
+}
+
+static struct test_entry *alloc_test_entry(unsigned int ignore_case,
+					   const char *key, const char *value)
+{
+	size_t klen = strlen(key);
+	size_t vlen = strlen(value);
+	unsigned int hash = ignore_case ? strihash(key) : strhash(key);
+	struct test_entry *entry = xmalloc(st_add4(sizeof(*entry), klen, vlen, 2));
+
+	hashmap_entry_init(&entry->ent, hash);
+	memcpy(entry->key, key, klen + 1);
+	memcpy(entry->key + klen + 1, value, vlen + 1);
+	return entry;
+}
+
+static struct test_entry *get_test_entry(struct hashmap *map,
+					 unsigned int ignore_case, const char *key)
+{
+	return hashmap_get_entry_from_hash(
+		map, ignore_case ? strihash(key) : strhash(key), key,
+		struct test_entry, ent);
+}
+
+static int key_val_contains(const char *key_val[][3], size_t n,
+			    struct test_entry *entry)
+{
+	for (size_t i = 0; i < n; i++) {
+		if (!strcmp(entry->key, key_val[i][0]) &&
+		    !strcmp(get_value(entry), key_val[i][1])) {
+			if (!strcmp(key_val[i][2], "USED"))
+				return 2;
+			key_val[i][2] = "USED";
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void setup(void (*f)(struct hashmap *map, int ignore_case),
+		  int ignore_case)
+{
+	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &ignore_case);
+	f(&map, ignore_case);
+	hashmap_clear_and_free(&map, struct test_entry, ent);
+}
+
+static void t_put(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	const char *key_val[][2] = { { "key1", "value1" },
+				   { "key2", "value2" },
+				   { "fooBarFrotz", "value3" } };
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check(hashmap_put_entry(map, entry, ent) == NULL);
+	}
+
+	entry = alloc_test_entry(ignore_case, "foobarfrotz", "value4");
+	entry = hashmap_put_entry(map, entry, ent);
+	check(ignore_case ? entry != NULL : entry == NULL);
+	free(entry);
+
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, ignore_case ? 3 : 4);
+}
+
+static void t_replace(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+
+	entry = alloc_test_entry(ignore_case, "key1", "value1");
+	check(hashmap_put_entry(map, entry, ent) == NULL);
+
+	entry = alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
+				 "value2");
+	entry = hashmap_put_entry(map, entry, ent);
+	if (check(entry != NULL))
+		check_str(get_value(entry), "value1");
+	free(entry);
+
+	entry = alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
+	check(hashmap_put_entry(map, entry, ent) == NULL);
+
+	entry = alloc_test_entry(ignore_case,
+				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
+				 "value4");
+	entry = hashmap_put_entry(map, entry, ent);
+	if (check(entry != NULL))
+		check_str(get_value(entry), "value3");
+	free(entry);
+}
+
+static void t_get(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	const char *key_val[][2] = { { "key1", "value1" },
+				   { "key2", "value2" },
+				   { "fooBarFrotz", "value3" },
+				   { ignore_case ? "key4" : "foobarfrotz", "value4" } };
+	const char *query[][2] = {
+		{ ignore_case ? "Key1" : "key1", "value1" },
+		{ ignore_case ? "keY2" : "key2", "value2" },
+		{ ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check(hashmap_put_entry(map, entry, ent) == NULL);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
+		entry = get_test_entry(map, ignore_case, query[i][0]);
+		if (check(entry != NULL))
+			check_str(get_value(entry), query[i][1]);
+	}
+
+	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
+}
+
+static void t_add(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	const char *key_val[][3] = {
+		{ "key1", "value2", "UNUSED" },
+		{ ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
+		{ "fooBarFrotz", "value3", "UNUSED" },
+		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		hashmap_add(map, &entry->ent);
+	}
+
+	hashmap_for_each_entry_from(map, entry, ent)
+	{
+		int ret;
+		if (!check_int((ret = key_val_contains(key_val, ARRAY_SIZE(key_val),
+						       entry)), ==, 0)) {
+			switch (ret) {
+				case 1:
+					test_msg("found entry was not given in the input\n"
+						 "    key: %s\n  value: %s",
+						 entry->key, get_value(entry));
+					break;
+				case 2:
+					test_msg("duplicate entry detected\n"
+						 "    key: %s\n  value: %s",
+						 entry->key, get_value(entry));
+					break;
+			}
+		}
+	}
+
+	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
+}
+
+static void t_remove(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry, *removed;
+	const char *key_val[][2] = { { "key1", "value1" },
+				   { "key2", "value2" },
+				   { "fooBarFrotz", "value3" } };
+	const char *remove[][2] = { { ignore_case ? "Key1" : "key1", "value1" },
+				    { ignore_case ? "keY2" : "key2", "value2" } };
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check(hashmap_put_entry(map, entry, ent) == NULL);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(remove); i++) {
+		entry = alloc_test_entry(ignore_case, remove[i][0], "");
+		removed = hashmap_remove_entry(map, entry, ent, remove[i][0]);
+		if (check(removed != NULL))
+			check_str(get_value(removed), remove[i][1]);
+		free(entry);
+		free(removed);
+	}
+
+	entry = alloc_test_entry(ignore_case, "notInMap", "");
+	check(hashmap_remove_entry(map, entry, ent, "notInMap") == NULL);
+	free(entry);
+}
+
+static void t_iterate(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry;
+	struct hashmap_iter iter;
+	const char *key_val[][3] = { { "key1", "value1", "UNUSED" },
+				     { "key2", "value2", "UNUSED" },
+				     { "fooBarFrotz", "value3", "UNUSED" } };
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
+		check(hashmap_put_entry(map, entry, ent) == NULL);
+	}
+
+	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
+	{
+		int ret;
+		if (!check_int((ret = key_val_contains(key_val, ARRAY_SIZE(key_val),
+					      entry)), ==, 0)) {
+			switch (ret) {
+				case 1:
+					test_msg("found entry was not given in the input\n"
+						 "    key: %s\n  value: %s",
+						 entry->key, get_value(entry));
+					break;
+				case 2:
+					test_msg("duplicate entry detected\n"
+						 "    key: %s\n  value: %s",
+						 entry->key, get_value(entry));
+					break;
+			}
+		}
+	}
+	check_int(hashmap_get_size(map), ==, 3);
+}
+
+static void t_alloc(struct hashmap *map, int ignore_case)
+{
+	struct test_entry *entry, *removed;
+
+	for (int i = 1; i <= 51; i++) {
+		char *key = xstrfmt("key%d", i);
+		char *value = xstrfmt("value%d", i);
+		entry = alloc_test_entry(ignore_case, key, value);
+		check(hashmap_put_entry(map, entry, ent) == NULL);
+		free(key);
+		free(value);
+	}
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, 51);
+
+	entry = alloc_test_entry(ignore_case, "key52", "value52");
+	check(hashmap_put_entry(map, entry, ent) == NULL);
+	check_int(map->tablesize, ==, 256);
+	check_int(hashmap_get_size(map), ==, 52);
+
+	for (int i = 1; i <= 12; i++) {
+		char *key = xstrfmt("key%d", i);
+		char *value = xstrfmt("value%d", i);
+
+		entry = alloc_test_entry(ignore_case, key, "");
+		removed = hashmap_remove_entry(map, entry, ent, key);
+		if (check(removed != NULL))
+			check_str(value, get_value(removed));
+		free(key);
+		free(value);
+		free(entry);
+		free(removed);
+	}
+	check_int(map->tablesize, ==, 256);
+	check_int(hashmap_get_size(map), ==, 40);
+
+	entry = alloc_test_entry(ignore_case, "key40", "");
+	removed = hashmap_remove_entry(map, entry, ent, "key40");
+	if (check(removed != NULL))
+		check_str("value40", get_value(removed));
+	check_int(map->tablesize, ==, 64);
+	check_int(hashmap_get_size(map), ==, 39);
+	free(entry);
+	free(removed);
+}
+
+static void t_intern(struct hashmap *map, int ignore_case)
+{
+	const char *values[] = { "value1", "Value1", "value2", "value2" };
+
+	for (size_t i = 0; i < ARRAY_SIZE(values); i++) {
+		const char *i1 = strintern(values[i]);
+		const char *i2 = strintern(values[i]);
+
+		if (!check(!strcmp(i1, values[i])))
+			test_msg("strintern(%s) returns %s\n", values[i], i1);
+		else if (!check(i1 != values[i]))
+			test_msg("strintern(%s) returns input pointer\n",
+				 values[i]);
+		else if (!check(i1 == i2))
+			test_msg("address('%s') != address('%s'), so strintern('%s') != strintern('%s')",
+				 i1, i2, values[i], values[i]);
+		else
+			check_str(i1, values[i]);
+	}
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(setup(t_put, 0), "put works");
+	TEST(setup(t_put, 1), "put (case insensitive) works");
+	TEST(setup(t_replace, 0), "replace works");
+	TEST(setup(t_replace, 1), "replace (case insensitive) works");
+	TEST(setup(t_get, 0), "get works");
+	TEST(setup(t_get, 1), "get (case insensitive) works");
+	TEST(setup(t_add, 0), "add works");
+	TEST(setup(t_add, 1), "add (case insensitive) works");
+	TEST(setup(t_remove, 0), "remove works");
+	TEST(setup(t_remove, 1), "remove (case insensitive) works");
+	TEST(setup(t_iterate, 0), "iterate works");
+	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
+	TEST(setup(t_alloc, 0), "grow / shrink works");
+	TEST(setup(t_intern, 0), "string interning works");
+	return test_done();
+}
-- 
2.45.2

