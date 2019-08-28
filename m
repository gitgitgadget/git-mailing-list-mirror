Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB471F461
	for <e@80x24.org>; Wed, 28 Aug 2019 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfH1QfU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 12:35:20 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35082 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1QfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 12:35:20 -0400
Received: by mail-wm1-f46.google.com with SMTP id l2so760582wmg.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDhAJ7LT2eeQAqOevB6r1aD4+OUrM7yU/NZ1M0/fyaQ=;
        b=dWimD4LWSeo6pu+Rh4VUMK0s8LCfJUCFNNl3FZyoNvCLWt2tFKV8q+r1iSff5W8YAu
         wlpvcOwJWcHfF/etrIkRTH3xPU97ns3XA2LEGg3aii/1ifnmmB1ETe7fmS/tyT5EY3H6
         f7HnT4OMnIxWkSskozkIzplylOqQ97/+SEcfZ6iSuTVUBPD22aLCCiOA+P5D8G95FzrC
         qEFUzlFYItwpeZ2h9uSTdgzHMhUcDgzvoucRzeh02L1tTcwCNHBUvuQMT0mDHZJCAEc+
         IxFT5XPC+sArm4t7TMEEdteqos09dTwAXxFdH+ePYlD8iif2OdZGsalJdcV2nSP7tCX2
         i18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDhAJ7LT2eeQAqOevB6r1aD4+OUrM7yU/NZ1M0/fyaQ=;
        b=rg+mPycUiyaSF8lg/yKIbl/B+WiroSQqfPg+7PJx1izzH7NtZhyVgU31jPHPaJSllD
         jHt91yM+Nn7ajhmeNcOiyCF1WXUIjsyYsVoOYmtkDzzlqLnlkTBB4K18SNC6inJXqfdn
         zxV+lvOEoogot902TUx2Wq/md2ZBFnC2RkI3AxlYJNHGZO8/aORr/nMdTkIDZF+uPCR0
         MzX4wrsCdgfBYIgHMRuwsflFePeNX4MsZMOwgqIvLPkrKoIBV9rjrRl1zsqB4Faa+vNI
         uPDV0BS9KsuU0Hd1CoVQvHmHaHo6Zwk7MQupMkHk++1qfDMuW9a1cuV2JylBwxg6glQ7
         FZCg==
X-Gm-Message-State: APjAAAU2jAweFBXkLlZ+ASiPwrZyUKUIVeRtFp87CczFFTduSh8oZLMA
        7nmzYH9dUYsvMrgGcak6t78HNlOc
X-Google-Smtp-Source: APXvYqwYBi+xkds0eof8/MGJwTORtNaeTdIwyIDG9w8PbXNCE7Ox54EfETR8XQdELSsozXZ+r6YMNw==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr6087118wmj.177.1567010116564;
        Wed, 28 Aug 2019 09:35:16 -0700 (PDT)
Received: from localhost.localdomain (x4db66bea.dyn.telefonica.de. [77.182.107.234])
        by smtp.gmail.com with ESMTPSA id u7sm2052106wrp.96.2019.08.28.09.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 09:35:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] [PoC] A simpler find_unique_prefixes() implementation
Date:   Wed, 28 Aug 2019 18:34:19 +0200
Message-Id: <20190828163419.30620-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190828163045.GF8571@szeder.dev>
References: <20190828163045.GF8571@szeder.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement find_unique_prefixes() by sorting the prefix items
lexicographically and then looking for unique prefixes in adjacent
pairs.  It's definitely shorter than the current hashmap-based
implementation (101 vs 149 lines), subjectively easier to follow, and
hopefully less buggy (some of the new elements in the test trigger
failure with the hashmap).

TODO: deal multi-byte caracter sequences, make the test tool more
      developer-friendly
---
 Makefile                   |   2 +-
 add-interactive.c          |   2 +-
 prefix-map.c               | 109 -------------------------------------
 prefix-map.h               |  40 --------------
 t/helper/test-prefix-map.c |  31 +++++++----
 unique-prefix.c            |  73 +++++++++++++++++++++++++
 unique-prefix.h            |  28 ++++++++++
 7 files changed, 124 insertions(+), 161 deletions(-)
 delete mode 100644 prefix-map.c
 delete mode 100644 prefix-map.h
 create mode 100644 unique-prefix.c
 create mode 100644 unique-prefix.h

diff --git a/Makefile b/Makefile
index 545a0e8743..6773041f0d 100644
--- a/Makefile
+++ b/Makefile
@@ -944,7 +944,6 @@ LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
 LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
-LIB_OBJS += prefix-map.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
@@ -1013,6 +1012,7 @@ LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
+LIB_OBJS += unique-prefix.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
diff --git a/add-interactive.c b/add-interactive.c
index c431c72e3f..cf22749b81 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -5,7 +5,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
-#include "prefix-map.h"
+#include "unique-prefix.h"
 
 struct add_i_state {
 	struct repository *r;
diff --git a/prefix-map.c b/prefix-map.c
deleted file mode 100644
index 747ddb4ebc..0000000000
--- a/prefix-map.c
+++ /dev/null
@@ -1,109 +0,0 @@
-#include "cache.h"
-#include "prefix-map.h"
-
-static int map_cmp(const void *unused_cmp_data,
-		   const void *entry,
-		   const void *entry_or_key,
-		   const void *unused_keydata)
-{
-	const struct prefix_map_entry *a = entry;
-	const struct prefix_map_entry *b = entry_or_key;
-
-	return a->prefix_length != b->prefix_length ||
-		strncmp(a->name, b->name, a->prefix_length);
-}
-
-static void add_prefix_entry(struct hashmap *map, const char *name,
-			     size_t prefix_length, struct prefix_item *item)
-{
-	struct prefix_map_entry *result = xmalloc(sizeof(*result));
-	result->name = name;
-	result->prefix_length = prefix_length;
-	result->item = item;
-	hashmap_entry_init(result, memhash(name, prefix_length));
-	hashmap_add(map, result);
-}
-
-static void init_prefix_map(struct prefix_map *prefix_map,
-			    int min_prefix_length, int max_prefix_length)
-{
-	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
-	prefix_map->min_length = min_prefix_length;
-	prefix_map->max_length = max_prefix_length;
-}
-
-static void add_prefix_item(struct prefix_map *prefix_map,
-			    struct prefix_item *item)
-{
-	struct prefix_map_entry e = { { NULL } }, *e2;
-	int j;
-
-	e.item = item;
-	e.name = item->name;
-
-	for (j = prefix_map->min_length;
-	     j <= prefix_map->max_length && e.name[j]; j++) {
-		/* Avoid breaking UTF-8 multi-byte sequences */
-		if (!isascii(e.name[j]))
-			break;
-
-		e.prefix_length = j;
-		hashmap_entry_init(&e, memhash(e.name, j));
-		e2 = hashmap_get(&prefix_map->map, &e, NULL);
-		if (!e2) {
-			/* prefix is unique at this stage */
-			item->prefix_length = j;
-			add_prefix_entry(&prefix_map->map, e.name, j, item);
-			break;
-		}
-
-		if (!e2->item)
-			continue; /* non-unique prefix */
-
-		if (j != e2->item->prefix_length || memcmp(e.name, e2->name, j))
-			BUG("unexpected prefix length: %d != %d (%s != %s)",
-			    j, (int)e2->item->prefix_length, e.name, e2->name);
-
-		/* skip common prefix */
-		for (; j < prefix_map->max_length && e.name[j]; j++) {
-			if (e.item->name[j] != e2->item->name[j])
-				break;
-			add_prefix_entry(&prefix_map->map, e.name, j + 1,
-					 NULL);
-		}
-
-		/* e2 no longer refers to a unique prefix */
-		if (j < prefix_map->max_length && e2->name[j]) {
-			/* found a new unique prefix for e2's item */
-			e2->item->prefix_length = j + 1;
-			add_prefix_entry(&prefix_map->map, e2->name, j + 1,
-					 e2->item);
-		}
-		else
-			e2->item->prefix_length = 0;
-		e2->item = NULL;
-
-		if (j < prefix_map->max_length && e.name[j]) {
-			/* found a unique prefix for the item */
-			e.item->prefix_length = j + 1;
-			add_prefix_entry(&prefix_map->map, e.name, j + 1,
-					 e.item);
-		} else
-			/* item has no (short enough) unique prefix */
-			e.item->prefix_length = 0;
-
-		break;
-	}
-}
-
-void find_unique_prefixes(struct prefix_item **list, size_t nr,
-			  int min_length, int max_length)
-{
-	int i;
-	struct prefix_map prefix_map;
-
-	init_prefix_map(&prefix_map, min_length, max_length);
-	for (i = 0; i < nr; i++)
-		add_prefix_item(&prefix_map, list[i]);
-	hashmap_free(&prefix_map.map, 1);
-}
diff --git a/prefix-map.h b/prefix-map.h
deleted file mode 100644
index ce3b8a4a32..0000000000
--- a/prefix-map.h
+++ /dev/null
@@ -1,40 +0,0 @@
-#ifndef PREFIX_MAP_H
-#define PREFIX_MAP_H
-
-#include "hashmap.h"
-
-struct prefix_item {
-	const char *name;
-	size_t prefix_length;
-};
-
-struct prefix_map_entry {
-	struct hashmap_entry e;
-	const char *name;
-	size_t prefix_length;
-	/* if item is NULL, the prefix is not unique */
-	struct prefix_item *item;
-};
-
-struct prefix_map {
-	struct hashmap map;
-	int min_length, max_length;
-};
-
-/*
- * Find unique prefixes in a given list of strings.
- *
- * Typically, the `struct prefix_item` information will be but a field in the
- * actual item struct; For this reason, the `list` parameter is specified as a
- * list of pointers to the items.
- *
- * The `min_length`/`max_length` parameters define what length the unique
- * prefixes should have.
- *
- * If no unique prefix could be found for a given item, its `prefix_length`
- * will be set to 0.
- */
-void find_unique_prefixes(struct prefix_item **list, size_t nr,
-			  int min_length, int max_length);
-
-#endif
diff --git a/t/helper/test-prefix-map.c b/t/helper/test-prefix-map.c
index 3f1c90eaf0..d472ff5dc6 100644
--- a/t/helper/test-prefix-map.c
+++ b/t/helper/test-prefix-map.c
@@ -1,6 +1,5 @@
 #include "test-tool.h"
-#include "cache.h"
-#include "prefix-map.h"
+#include "unique-prefix.h"
 
 static size_t test_count, failed_count;
 
@@ -24,25 +23,32 @@ static void check(int succeeded, const char *file, size_t line_no,
 
 #define EXPECT_SIZE_T_EQUALS(expect, actual, hint) \
 	check(expect == actual, __FILE__, __LINE__, \
-	      "size_t's do not match: %" \
-	      PRIdMAX " != %" PRIdMAX " (%s) (%s)", \
+	      "size_t's do not match: expected: %" \
+	      PRIdMAX " got: %" PRIdMAX " (%s) (%s)", \
 	      (intmax_t)expect, (intmax_t)actual, #actual, hint)
 
 int cmd__prefix_map(int argc, const char **argv)
 {
-#define NR 5
-	struct prefix_item items[NR] = {
+	size_t i;
+	struct prefix_item items[] = {
 		{ "unique" },
 		{ "hell" },
 		{ "hello" },
 		{ "wok" },
 		{ "world" },
+		{ "a" },
+		{ "" },
+		{ "pq" },
+		{ "pq" },
+		{ "pqr" },
 	};
-	struct prefix_item *list[NR] = {
-		items, items + 1, items + 2, items + 3, items + 4
-	};
+	struct prefix_item *list[ARRAY_SIZE(items)];
+	for (i = 0; i < ARRAY_SIZE(items); i++) {
+		list[i] = &items[i];
+		list[i]->prefix_length = 12345; /* dummy */
+	}
 
-	find_unique_prefixes(list, NR, 1, 3);
+	find_unique_prefixes(list, ARRAY_SIZE(list), 1, 3);
 
 #define EXPECT_PREFIX_LENGTH_EQUALS(expect, index) \
 	EXPECT_SIZE_T_EQUALS(expect, list[index]->prefix_length, \
@@ -53,6 +59,11 @@ int cmd__prefix_map(int argc, const char **argv)
 	EXPECT_PREFIX_LENGTH_EQUALS(0, 2);
 	EXPECT_PREFIX_LENGTH_EQUALS(3, 3);
 	EXPECT_PREFIX_LENGTH_EQUALS(3, 4);
+	EXPECT_PREFIX_LENGTH_EQUALS(1, 5);
+	EXPECT_PREFIX_LENGTH_EQUALS(0, 6);
+	EXPECT_PREFIX_LENGTH_EQUALS(0, 7);
+	EXPECT_PREFIX_LENGTH_EQUALS(0, 8);
+	EXPECT_PREFIX_LENGTH_EQUALS(3, 9);
 
 	return !!failed_count;
 }
diff --git a/unique-prefix.c b/unique-prefix.c
new file mode 100644
index 0000000000..327e8fa32c
--- /dev/null
+++ b/unique-prefix.c
@@ -0,0 +1,73 @@
+#include "git-compat-util.h"
+#include "unique-prefix.h"
+
+static int prefix_item_ptr_cmp(const void *item1, const void *item2)
+{
+	const struct prefix_item *pi1 = *((struct prefix_item**) item1);
+	const struct prefix_item *pi2 = *((struct prefix_item**) item2);
+	return strcmp(pi1->name, pi2->name);
+}
+
+static int str_is_shorter_than(const char *s, size_t len)
+{
+	for (; *s && len; s++, len--);
+	return !!len;
+}
+
+static size_t str_common_prefix_len(const char *s1, const char *s2, size_t limit)
+{
+	size_t i;
+	for (i = 0; i < limit; i++)
+		if (s1[i] != s2[i] || s1[i] == '\0')
+			return i;
+	return limit + 1;
+}
+
+void find_unique_prefixes(struct prefix_item **items, size_t nr,
+			  int min_length, int max_length)
+{
+	size_t i;
+	struct prefix_item **sorted_items;
+
+	ALLOC_ARRAY(sorted_items, nr);
+	COPY_ARRAY(sorted_items, items, nr);
+	QSORT(sorted_items, nr, prefix_item_ptr_cmp);
+
+	if (str_is_shorter_than(sorted_items[0]->name, min_length))
+		sorted_items[0]->prefix_length = 0;
+	else
+		sorted_items[0]->prefix_length = min_length;
+	for (i = 1; i < nr; i++) {
+		size_t common_len = str_common_prefix_len(
+			sorted_items[i - 1]->name, sorted_items[i]->name,
+			max_length);
+
+		if (!sorted_items[i - 1]->prefix_length)
+			/*
+			 * The previous iteration already determined that
+			 * it doesn't have a unique prefix.
+			 */
+			;
+		else if (max_length < common_len)
+			sorted_items[i - 1]->prefix_length = 0;
+		else if (sorted_items[i - 1]->name[common_len] == '\0')
+			/* Either prefix of or equal to the next string. */
+			sorted_items[i - 1]->prefix_length = 0;
+		else if (sorted_items[i - 1]->prefix_length <= common_len)
+			sorted_items[i - 1]->prefix_length = common_len + 1;
+
+		if (max_length < common_len)
+			sorted_items[i]->prefix_length = 0;
+		else if (sorted_items[i]->name[common_len] == '\0')
+			/* the two strings are the same */
+			sorted_items[i]->prefix_length = 0;
+		else if (min_length <= common_len)
+			sorted_items[i]->prefix_length = common_len + 1;
+		else if (str_is_shorter_than(sorted_items[i]->name, min_length))
+			sorted_items[i]->prefix_length = 0;
+		else
+			sorted_items[i]->prefix_length = min_length;
+	}
+
+	free(sorted_items);
+}
diff --git a/unique-prefix.h b/unique-prefix.h
new file mode 100644
index 0000000000..cbddc29a9a
--- /dev/null
+++ b/unique-prefix.h
@@ -0,0 +1,28 @@
+#ifndef UNIQUE_PREFIX_H
+#define UNIQUE_PREFIX_H
+
+struct prefix_item {
+	const char *name;
+	size_t prefix_length;
+};
+
+/*
+ * Find unique prefixes in a given array of strings.
+ * Given a list of names, find unique prefixes (i.e. the first <n> characters
+ * that uniquely identify the names) and store the lengths of the unique
+ * prefixes in the 'prefix_length' field of the elements of the given array.
+ *
+ * Typically, the `struct prefix_item` information will be a field in the
+ * actual item struct; For this reason, the `items` parameter is specified
+ * as an array of pointers to the items.
+ *
+ * The `min_length`/`max_length` parameters define what length the unique
+ * prefixes should have.
+ *
+ * If no unique prefix could be found for a given item, its `prefix_length`
+ * will be set to 0.
+ */
+void find_unique_prefixes(struct prefix_item **items, size_t nr,
+			  int min_length, int max_length);
+
+#endif
-- 
2.23.0.331.g4e51dcdf11

