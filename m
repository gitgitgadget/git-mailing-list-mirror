Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC61E898
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577271; cv=none; b=OXJzeS82bmTR9KDNSIXrpBX3G5zB9lLjFp8vc82ghymAOBjEn9yr2UTOzbZdugarPlCPPOLYKlStdapR5VjmB9LW78QHwMO1EXLz1AixzrdrTvfr7wvuakCbZVf1Og9uJWs+i4lVyT9qF726CFoanBFVrmDJTnMzWr5t0UAzWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577271; c=relaxed/simple;
	bh=FRciMlkDdqqALPoFo4ik8JTGdqeIRr5e6H0Euotr/Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHY9CmMt9SnrTwnCnbPqjh/LEV/NR6z+NaFkMCL4llbbAA01nrz2gHQVKhvznKCDrnWzRoSZ8AQ0LQKDFiB92u/CRAW1O9WIsjO+YXTAc3ct62b9STq+lw4oKSbyGcBKwr/ujofCTMp9Xyyv6v/tuixJ6l+vuSuxOzNHrI8xEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/CbWfMo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/CbWfMo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6a837e9a3so2674705ad.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719577269; x=1720182069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4sHgboFsXYJiOIAtdnp9QKp6C4h72QWB0//VtH7y6w=;
        b=m/CbWfMobnPxOCwtTwNpoR/xrA0lNZRfISw6urZHXd8WUikZeHOcbz4If8Re5DfsQK
         if/kLBGaqX+nLdHcqyqg7wHWFI8bFYSgguzMMTnUjdP0ch8kB3WfqgB7sUQ1RamgBo7Y
         n2r9xkN1ZTpSlIbwwuYbGzQfuTDG5OVzHEqIUBC8vusBy8CecPuaD0e4xaYFQj8zbopx
         dVqiQV1pbwf01FuSQlwYuaveqKF61zECNxAIBDNYVSDEhBrnB5XEik5896MgXIILk3ri
         herwR8Kwate27XSdCARo2mzAJoDpSZVP5BNjQ0FRxyvjsOkVc2ykTJPpUOoiUA+U4OYh
         QVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719577269; x=1720182069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4sHgboFsXYJiOIAtdnp9QKp6C4h72QWB0//VtH7y6w=;
        b=Dksv48GQLAgAZiBOLwH2B28UvroYV7eWzjTi6DHfuuK6irtlDRFaG65x3n/8K+dZOr
         Yoieq8+IcBq30MAOJTabDXZckNMaEPsgvfWbow0Rnip7Qi5MDUKtoCFEhrcVQx9RZQRc
         S7pdGjK+XZ/+LJgoVAGjsCFFTJvNhdFycWUlaM5i2vVPwsPkwL0LFb5MxcYKJhjV0llQ
         DCz9qdBaPze7+E2Jx68dc+KdVKbhP3mxeaQCGKiU9Rz/iNGOUQUnQRmVWFyGNb6fxszL
         HKmddxt+7R0qKSGRL3cCHA4OTRnFFAHSNxQdngnKZh/gczHS6E0TbZy0hBgGyPsYn3bG
         kpBg==
X-Gm-Message-State: AOJu0Ywe8ZPW6eRyaMrK53If5wVyxDsK+ISJp6q1d7rz+BrlRZCFUx/d
	YzrbJ1dO+O3ZGGUS1fc5GjKKsgLSGhUpwcD5df/TXu+CQE2+zu+S4/WTcsG+2b8=
X-Google-Smtp-Source: AGHT+IH9Bd6YX6H2SejhXeipo9Kn9CurPNF2SwKJqlNKVflefFGm5iEmygLT1UNJDPyTpFJX31Tb3w==
X-Received: by 2002:a17:902:e74d:b0:1f7:124:b820 with SMTP id d9443c01a7336-1fa24082256mr155320345ad.50.1719577268622;
        Fri, 28 Jun 2024 05:21:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1a82sm14052375ad.59.2024.06.28.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:21:08 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c
Date: Fri, 28 Jun 2024 17:50:21 +0530
Message-ID: <20240628122030.41554-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619175036.64291-1-shyamthakkar001@gmail.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
library which is built on top of hashmap.h.

Migrate them to the unit testing framework for better performance,
concise code and better debugging. Along with the migration also plug
memory leaks and make the test logic independent for all the tests.
The migration removes 'put' tests from t0016, because it is used as
setup to all the other tests, so testing it separately does not yield
any benefit.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
This version addresses Phillip's review about detecting duplicates in
oidmap when iterating over it and removing put_and_check_null() to move
the relevant code to setup() instead. And contains some grammer fixes
in the comment.

Range-diff against v1:
1:  45fa96550f ! 1:  aabec4cd4d t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c
    @@ Commit message
         t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c
     
         helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
    -    library which is built on top of hashmap.h to store arbitrary
    -    datastructure (which must contain oidmap_entry, which is a wrapper
    -    around object_id). These entries can be accessed by querying their
    -    associated object_id.
    +    library which is built on top of hashmap.h.
     
         Migrate them to the unit testing framework for better performance,
         concise code and better debugging. Along with the migration also plug
    @@ Commit message
         setup to all the other tests, so testing it separately does not yield
         any benefit.
     
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
         Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
    @@ t/unit-tests/t-oidmap.c (new)
     +#include "hex.h"
     +
     +/*
    -+ * elements we will put in oidmap structs are made of a key: the entry.oid
    ++ * Elements we will put in oidmap structs are made of a key: the entry.oid
     + * field, which is of type struct object_id, and a value: the name field (could
    -+ * be a refname for example)
    ++ * be a refname for example).
     + */
     +struct test_entry {
     +	struct oidmap_entry entry;
    @@ t/unit-tests/t-oidmap.c (new)
     +				    { "22", "two" },
     +				    { "33", "three" } };
     +
    -+static int put_and_check_null(struct oidmap *map, const char *hex,
    -+			      const char *entry_name)
    -+{
    -+	struct test_entry *entry;
    -+
    -+	FLEX_ALLOC_STR(entry, name, entry_name);
    -+	if (get_oid_arbitrary_hex(hex, &entry->entry.oid))
    -+		return -1;
    -+	if (!check(oidmap_put(map, entry) == NULL))
    -+		return -1;
    -+	return 0;
    -+}
    -+
     +static void setup(void (*f)(struct oidmap *map))
     +{
     +	struct oidmap map = OIDMAP_INIT;
     +	int ret = 0;
     +
    -+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++)
    -+		if ((ret = put_and_check_null(&map, key_val[i][0],
    -+					      key_val[i][1])))
    ++	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++){
    ++		struct test_entry *entry;
    ++
    ++		FLEX_ALLOC_STR(entry, name, key_val[i][1]);
    ++		if ((ret = get_oid_arbitrary_hex(key_val[i][0], &entry->entry.oid))) {
    ++			free(entry);
     +			break;
    ++		}
    ++		entry = oidmap_put(&map, entry);
    ++		if (!check(entry == NULL))
    ++			free(entry);
    ++	}
     +
     +	if (!ret)
     +		f(&map);
    @@ t/unit-tests/t-oidmap.c (new)
     +
     +static int key_val_contains(struct test_entry *entry)
     +{
    -+	/* the test is small enough to be able to bear O(n) */
     +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
    -+		if (!strcmp(key_val[i][1], entry->name)) {
    -+			struct object_id oid;
    -+			if (get_oid_arbitrary_hex(key_val[i][0], &oid))
    -+				return -1;
    -+			if (oideq(&entry->entry.oid, &oid))
    -+				return 0;
    ++		struct object_id oid;
    ++
    ++		if (get_oid_arbitrary_hex(key_val[i][0], &oid))
    ++			return -1;
    ++
    ++		if (oideq(&entry->entry.oid, &oid)) {
    ++			if (!strcmp(key_val[i][1], "USED"))
    ++				return 2;
    ++			key_val[i][1] = "USED";
    ++			return 0;
     +		}
     +	}
     +	return 1;
    @@ t/unit-tests/t-oidmap.c (new)
     +{
     +	struct oidmap_iter iter;
     +	struct test_entry *entry;
    -+	int ret;
     +
     +	oidmap_iter_init(map, &iter);
     +	while ((entry = oidmap_iter_next(&iter))) {
    ++		int ret;
     +		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
    -+			if (ret == -1)
    -+				return;
    -+			test_msg("obtained entry was not given in the input\n"
    -+	    			 "  name: %s\n   oid: %s\n",
    -+				 entry->name, oid_to_hex(&entry->entry.oid));
    ++			switch (ret) {
    ++			case -1:
    ++				break; /* error message handled by get_oid_arbitrary_hex() */
    ++			case 1:
    ++				test_msg("obtained entry was not given in the input\n"
    ++					 "  name: %s\n   oid: %s\n",
    ++					 entry->name, oid_to_hex(&entry->entry.oid));
    ++				break;
    ++			case 2:
    ++				test_msg("duplicate entry detected\n"
    ++					 "  name: %s\n   oid: %s\n",
    ++					 entry->name, oid_to_hex(&entry->entry.oid));
    ++				break;
    ++			default:
    ++				test_msg("BUG: invalid return value (%d) from key_val_contains()",
    ++					 ret);
    ++				break;
    ++			}
     +		}
     +	}
     +	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));

 Makefile                |   2 +-
 t/helper/test-oidmap.c  | 123 ----------------------------
 t/helper/test-tool.c    |   1 -
 t/helper/test-tool.h    |   1 -
 t/t0016-oidmap.sh       | 112 -------------------------
 t/unit-tests/t-oidmap.c | 176 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 177 insertions(+), 238 deletions(-)
 delete mode 100644 t/helper/test-oidmap.c
 delete mode 100755 t/t0016-oidmap.sh
 create mode 100644 t/unit-tests/t-oidmap.c

diff --git a/Makefile b/Makefile
index 3eab701b10..2a5c70d218 100644
--- a/Makefile
+++ b/Makefile
@@ -809,7 +809,6 @@ TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oid-array.o
-TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
@@ -1337,6 +1336,7 @@ UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-mem-pool
+UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
deleted file mode 100644
index bd30244a54..0000000000
--- a/t/helper/test-oidmap.c
+++ /dev/null
@@ -1,123 +0,0 @@
-#include "test-tool.h"
-#include "hex.h"
-#include "object-name.h"
-#include "oidmap.h"
-#include "repository.h"
-#include "setup.h"
-#include "strbuf.h"
-#include "string-list.h"
-
-/* key is an oid and value is a name (could be a refname for example) */
-struct test_entry {
-	struct oidmap_entry entry;
-	char name[FLEX_ARRAY];
-};
-
-#define DELIM " \t\r\n"
-
-/*
- * Read stdin line by line and print result of commands to stdout:
- *
- * hash oidkey -> sha1hash(oidkey)
- * put oidkey namevalue -> NULL / old namevalue
- * get oidkey -> NULL / namevalue
- * remove oidkey -> NULL / old namevalue
- * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
- *
- */
-int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
-{
-	struct string_list parts = STRING_LIST_INIT_NODUP;
-	struct strbuf line = STRBUF_INIT;
-	struct oidmap map = OIDMAP_INIT;
-
-	setup_git_directory();
-
-	/* init oidmap */
-	oidmap_init(&map, 0);
-
-	/* process commands from stdin */
-	while (strbuf_getline(&line, stdin) != EOF) {
-		char *cmd, *p1, *p2;
-		struct test_entry *entry;
-		struct object_id oid;
-
-		/* break line into command and up to two parameters */
-		string_list_setlen(&parts, 0);
-		string_list_split_in_place(&parts, line.buf, DELIM, 2);
-		string_list_remove_empty_items(&parts, 0);
-
-		/* ignore empty lines */
-		if (!parts.nr)
-			continue;
-		if (!*parts.items[0].string || *parts.items[0].string == '#')
-			continue;
-
-		cmd = parts.items[0].string;
-		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
-		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
-
-		if (!strcmp("put", cmd) && p1 && p2) {
-
-			if (repo_get_oid(the_repository, p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* create entry with oid_key = p1, name_value = p2 */
-			FLEX_ALLOC_STR(entry, name, p2);
-			oidcpy(&entry->entry.oid, &oid);
-
-			/* add / replace entry */
-			entry = oidmap_put(&map, entry);
-
-			/* print and free replaced entry, if any */
-			puts(entry ? entry->name : "NULL");
-			free(entry);
-
-		} else if (!strcmp("get", cmd) && p1) {
-
-			if (repo_get_oid(the_repository, p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* lookup entry in oidmap */
-			entry = oidmap_get(&map, &oid);
-
-			/* print result */
-			puts(entry ? entry->name : "NULL");
-
-		} else if (!strcmp("remove", cmd) && p1) {
-
-			if (repo_get_oid(the_repository, p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* remove entry from oidmap */
-			entry = oidmap_remove(&map, &oid);
-
-			/* print result and free entry*/
-			puts(entry ? entry->name : "NULL");
-			free(entry);
-
-		} else if (!strcmp("iterate", cmd)) {
-
-			struct oidmap_iter iter;
-			oidmap_iter_init(&map, &iter);
-			while ((entry = oidmap_iter_next(&iter)))
-				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
-
-		} else {
-
-			printf("Unknown command %s\n", cmd);
-
-		}
-	}
-
-	string_list_clear(&parts, 0);
-	strbuf_release(&line);
-	oidmap_free(&map, 1);
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 93436a82ae..da3e69128a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -44,7 +44,6 @@ static struct test_cmd cmds[] = {
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "oid-array", cmd__oid_array },
-	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d9033d14e1..642a34578c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -37,7 +37,6 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
-int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
deleted file mode 100755
index 0faef1f4f1..0000000000
--- a/t/t0016-oidmap.sh
+++ /dev/null
@@ -1,112 +0,0 @@
-#!/bin/sh
-
-test_description='test oidmap'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-# This purposefully is very similar to t0011-hashmap.sh
-
-test_oidmap () {
-	echo "$1" | test-tool oidmap $3 >actual &&
-	echo "$2" >expect &&
-	test_cmp expect actual
-}
-
-
-test_expect_success 'setup' '
-
-	test_commit one &&
-	test_commit two &&
-	test_commit three &&
-	test_commit four
-
-'
-
-test_expect_success 'put' '
-
-test_oidmap "put one 1
-put two 2
-put invalidOid 4
-put three 3" "NULL
-NULL
-Unknown oid: invalidOid
-NULL"
-
-'
-
-test_expect_success 'replace' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-put invalidOid 4
-put two deux
-put one un" "NULL
-NULL
-NULL
-Unknown oid: invalidOid
-2
-1"
-
-'
-
-test_expect_success 'get' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-get two
-get four
-get invalidOid
-get one" "NULL
-NULL
-NULL
-2
-NULL
-Unknown oid: invalidOid
-1"
-
-'
-
-test_expect_success 'remove' '
-
-test_oidmap "put one 1
-put two 2
-put three 3
-remove one
-remove two
-remove invalidOid
-remove four" "NULL
-NULL
-NULL
-1
-2
-Unknown oid: invalidOid
-NULL"
-
-'
-
-test_expect_success 'iterate' '
-	test-tool oidmap >actual.raw <<-\EOF &&
-	put one 1
-	put two 2
-	put three 3
-	iterate
-	EOF
-
-	# sort "expect" too so we do not rely on the order of particular oids
-	sort >expect <<-EOF &&
-	NULL
-	NULL
-	NULL
-	$(git rev-parse one) 1
-	$(git rev-parse two) 2
-	$(git rev-parse three) 3
-	EOF
-
-	sort <actual.raw >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
new file mode 100644
index 0000000000..13532aa98b
--- /dev/null
+++ b/t/unit-tests/t-oidmap.c
@@ -0,0 +1,176 @@
+#include "test-lib.h"
+#include "lib-oid.h"
+#include "oidmap.h"
+#include "hash.h"
+#include "hex.h"
+
+/*
+ * Elements we will put in oidmap structs are made of a key: the entry.oid
+ * field, which is of type struct object_id, and a value: the name field (could
+ * be a refname for example).
+ */
+struct test_entry {
+	struct oidmap_entry entry;
+	char name[FLEX_ARRAY];
+};
+
+static const char *key_val[][2] = { { "11", "one" },
+				    { "22", "two" },
+				    { "33", "three" } };
+
+static void setup(void (*f)(struct oidmap *map))
+{
+	struct oidmap map = OIDMAP_INIT;
+	int ret = 0;
+
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++){
+		struct test_entry *entry;
+
+		FLEX_ALLOC_STR(entry, name, key_val[i][1]);
+		if ((ret = get_oid_arbitrary_hex(key_val[i][0], &entry->entry.oid))) {
+			free(entry);
+			break;
+		}
+		entry = oidmap_put(&map, entry);
+		if (!check(entry == NULL))
+			free(entry);
+	}
+
+	if (!ret)
+		f(&map);
+	oidmap_free(&map, 1);
+}
+
+static void t_replace(struct oidmap *map)
+{
+	struct test_entry *entry, *prev;
+
+	FLEX_ALLOC_STR(entry, name, "un");
+	if (get_oid_arbitrary_hex("11", &entry->entry.oid))
+		return;
+	prev = oidmap_put(map, entry);
+	if (!check(prev != NULL))
+		return;
+	check_str(prev->name, "one");
+	free(prev);
+
+	FLEX_ALLOC_STR(entry, name, "deux");
+	if (get_oid_arbitrary_hex("22", &entry->entry.oid))
+		return;
+	prev = oidmap_put(map, entry);
+	if (!check(prev != NULL))
+		return;
+	check_str(prev->name, "two");
+	free(prev);
+}
+
+static void t_get(struct oidmap *map)
+{
+	struct test_entry *entry;
+	struct object_id oid;
+
+	if (get_oid_arbitrary_hex("22", &oid))
+		return;
+	entry = oidmap_get(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "two");
+
+	if (get_oid_arbitrary_hex("44", &oid))
+		return;
+	check(oidmap_get(map, &oid) == NULL);
+
+	if (get_oid_arbitrary_hex("11", &oid))
+		return;
+	entry = oidmap_get(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "one");
+}
+
+static void t_remove(struct oidmap *map)
+{
+	struct test_entry *entry;
+	struct object_id oid;
+
+	if (get_oid_arbitrary_hex("11", &oid))
+		return;
+	entry = oidmap_remove(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "one");
+	check(oidmap_get(map, &oid) == NULL);
+	free(entry);
+
+	if (get_oid_arbitrary_hex("22", &oid))
+		return;
+	entry = oidmap_remove(map, &oid);
+	if (!check(entry != NULL))
+		return;
+	check_str(entry->name, "two");
+	check(oidmap_get(map, &oid) == NULL);
+	free(entry);
+
+	if (get_oid_arbitrary_hex("44", &oid))
+		return;
+	check(oidmap_remove(map, &oid) == NULL);
+}
+
+static int key_val_contains(struct test_entry *entry)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
+		struct object_id oid;
+
+		if (get_oid_arbitrary_hex(key_val[i][0], &oid))
+			return -1;
+
+		if (oideq(&entry->entry.oid, &oid)) {
+			if (!strcmp(key_val[i][1], "USED"))
+				return 2;
+			key_val[i][1] = "USED";
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void t_iterate(struct oidmap *map)
+{
+	struct oidmap_iter iter;
+	struct test_entry *entry;
+
+	oidmap_iter_init(map, &iter);
+	while ((entry = oidmap_iter_next(&iter))) {
+		int ret;
+		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
+			switch (ret) {
+			case -1:
+				break; /* error message handled by get_oid_arbitrary_hex() */
+			case 1:
+				test_msg("obtained entry was not given in the input\n"
+					 "  name: %s\n   oid: %s\n",
+					 entry->name, oid_to_hex(&entry->entry.oid));
+				break;
+			case 2:
+				test_msg("duplicate entry detected\n"
+					 "  name: %s\n   oid: %s\n",
+					 entry->name, oid_to_hex(&entry->entry.oid));
+				break;
+			default:
+				test_msg("BUG: invalid return value (%d) from key_val_contains()",
+					 ret);
+				break;
+			}
+		}
+	}
+	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(setup(t_replace), "replace works");
+	TEST(setup(t_get), "get works");
+	TEST(setup(t_remove), "remove works");
+	TEST(setup(t_iterate), "iterate works");
+	return test_done();
+}
-- 
2.45.2

