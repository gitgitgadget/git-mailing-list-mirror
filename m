Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BC61F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 18:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdKKSG4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 13:06:56 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:57015 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdKKSGz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 13:06:55 -0500
Received: by mail-yw0-f196.google.com with SMTP id r186so2069765ywe.13
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zd/U6Ljem4QOjrLbzy+i8VW+LoZ6PXu/iwHYpKrk3B4=;
        b=Aa92+u2/Fv9wKuyaI1xhT2QavgvDwoFuhuv0KDLglJ7KG4BceGcerEaVbGbFF+3L4H
         1XOakUwx0vwtHkBjdbg2cTF+HO8nMqLgQ9c+VLNVjiwir5jrLxRTg6HuTLyUr47eYMx5
         r5iLw0/UNbZzcPrZ8d4q1vRzLgEn2Da6nJWAF00Dxd4ypru5D/NmGlpMr+0o+78SS9Mj
         Ay7wrwqdgFqe/F6NhOFCdnwqziWSvIzf1V6pDh/jWqCwdgFuujWS1nlUrpJUbJgNANmA
         ywkQp7B0BLHFgKWxt3oe1Ft7P7K8spZ/5xOkTmcDEXt56lCpGrDOvWuHAxzCMeMLFOla
         XalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zd/U6Ljem4QOjrLbzy+i8VW+LoZ6PXu/iwHYpKrk3B4=;
        b=UOwzNQmePEbr4y5rn0XwXlgDvJPAFv+zR6+UUy0kIi5TWW4TtXJ2ZKxK+WQAp82F/C
         n49NEJ1V7K+s9qgBus0bJstuEZrcsDqcTTfHbHLitc4sOTFO3YOvEw61P5M6ZHuJHE54
         rpFHdnGg3TSzUSTd/nLuQS1avgzmdW3Rpw9MuOsJg/7UeYW6Q2GPx4dU9vLpFVUo+PUt
         LA9kfbs/1lTbi2490CK5SUuY/yUEjXaK2ygS9WX8fUtEmSKDIsd7EjClamdIjZu8csmv
         Dd1zXopWiBb+BuJwHaax1j0vW/ZEJpi28myUJN7MbQOtnZ410rETcxNS40AoWuGbiJ3y
         ph5A==
X-Gm-Message-State: AJaThX42dEsKYysm7YeRqEOhvfdkicQ5ssR6VrtBd8BECWH0r6QibtEy
        z96Z9m7uIovJ0r4vWHbsKFBSDA==
X-Google-Smtp-Source: AGs4zMaq8X/T1LwAVs9NgaQlAMTAkAbEb2mvnzmg3lb9w4AjjhqpYLM1o+daNFKHS50HihOi7/A7qQ==
X-Received: by 10.129.56.197 with SMTP id f188mr2820116ywa.144.1510423613907;
        Sat, 11 Nov 2017 10:06:53 -0800 (PST)
Received: from gargi.wfi.bloomberg.com ([62.189.9.199])
        by smtp.gmail.com with ESMTPSA id y123sm1300541ywg.68.2017.11.11.10.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Nov 2017 10:06:53 -0800 (PST)
From:   Gargi Sharma <gs051095@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, olyatelezhnaya@gmail.com,
        Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH] mru: Replace mru.[ch] with list.h implementation
Date:   Sat, 11 Nov 2017 13:06:46 -0500
Message-Id: <1510423606-9616-1-git-send-email-gs051095@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace custom allocation in mru.[ch] with generic calls
to list.h API.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
 builtin/pack-objects.c | 14 ++++++++------
 cache.h                |  9 +++++----
 mru.c                  | 27 ---------------------------
 mru.h                  | 40 ----------------------------------------
 packfile.c             | 28 +++++++++++++++++++---------
 5 files changed, 32 insertions(+), 86 deletions(-)
 delete mode 100644 mru.c
 delete mode 100644 mru.h

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba81234..26717c5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -24,7 +24,7 @@
 #include "reachable.h"
 #include "sha1-array.h"
 #include "argv-array.h"
-#include "mru.h"
+#include "list.h"
 #include "packfile.h"
 
 static const char *pack_usage[] = {
@@ -1012,9 +1012,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
-	list_for_each(pos, &packed_git_mru.list) {
-		struct mru *entry = list_entry(pos, struct mru, list);
-		struct packed_git *p = entry->item;
+	list_for_each(pos, &packed_git_mru) {
+		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+		struct list_head *entry = &(p->mru);
 		off_t offset;
 
 		if (p == *found_pack)
@@ -1030,8 +1030,10 @@ static int want_object_in_pack(const unsigned char *sha1,
 				*found_pack = p;
 			}
 			want = want_found_object(exclude, p);
-			if (!exclude && want > 0)
-				mru_mark(&packed_git_mru, entry);
+			if (!exclude && want > 0) {
+				list_del(entry);
+				list_add(entry, &packed_git_mru);
+			}
 			if (want != -1)
 				return want;
 		}
diff --git a/cache.h b/cache.h
index 49b083e..1a275ae 100644
--- a/cache.h
+++ b/cache.h
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hashmap.h"
-#include "mru.h"
+#include "list.h"
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
@@ -1566,6 +1566,7 @@ struct pack_window {
 
 extern struct packed_git {
 	struct packed_git *next;
+	struct list_head mru;
 	struct pack_window *windows;
 	off_t pack_size;
 	const void *index_data;
@@ -1587,10 +1588,10 @@ extern struct packed_git {
 } *packed_git;
 
 /*
- * A most-recently-used ordered version of the packed_git list, which can
- * be iterated instead of packed_git (and marked via mru_mark).
+ * A most-recently-used ordered version of the packed_git list.
  */
-extern struct mru packed_git_mru;
+extern struct list_head packed_git_mru;
+
 
 struct pack_entry {
 	off_t offset;
diff --git a/mru.c b/mru.c
deleted file mode 100644
index 8f3f34c..0000000
--- a/mru.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include "cache.h"
-#include "mru.h"
-
-void mru_append(struct mru *head, void *item)
-{
-	struct mru *cur = xmalloc(sizeof(*cur));
-	cur->item = item;
-	list_add_tail(&cur->list, &head->list);
-}
-
-void mru_mark(struct mru *head, struct mru *entry)
-{
-	/* To mark means to put at the front of the list. */
-	list_del(&entry->list);
-	list_add(&entry->list, &head->list);
-}
-
-void mru_clear(struct mru *head)
-{
-	struct list_head *pos;
-	struct list_head *tmp;
-
-	list_for_each_safe(pos, tmp, &head->list) {
-		free(list_entry(pos, struct mru, list));
-	}
-	INIT_LIST_HEAD(&head->list);
-}
diff --git a/mru.h b/mru.h
deleted file mode 100644
index 80a589e..0000000
--- a/mru.h
+++ /dev/null
@@ -1,40 +0,0 @@
-#ifndef MRU_H
-#define MRU_H
-
-#include "list.h"
-
-/**
- * A simple most-recently-used cache, backed by a doubly-linked list.
- *
- * Usage is roughly:
- *
- *   // Create a list.  Zero-initialization is required.
- *   static struct mru cache;
- *   INIT_LIST_HEAD(&cache.list);
- *
- *   // Add new item to the end of the list.
- *   void *item;
- *   ...
- *   mru_append(&cache, item);
- *
- *   // Mark an item as used, moving it to the front of the list.
- *   mru_mark(&cache, item);
- *
- *   // Reset the list to empty, cleaning up all resources.
- *   mru_clear(&cache);
- *
- * Note that you SHOULD NOT call mru_mark() and then continue traversing the
- * list; it reorders the marked item to the front of the list, and therefore
- * you will begin traversing the whole list again.
- */
-
-struct mru {
-	struct list_head list;
-	void *item;
-};
-
-void mru_append(struct mru *head, void *item);
-void mru_mark(struct mru *head, struct mru *entry);
-void mru_clear(struct mru *head);
-
-#endif /* MRU_H */
diff --git a/packfile.c b/packfile.c
index 502d915..3882d0b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "mru.h"
+#include "list.h"
 #include "pack.h"
 #include "dir.h"
 #include "mergesort.h"
@@ -40,7 +40,7 @@ static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
 struct packed_git *packed_git;
-struct mru packed_git_mru = {{&packed_git_mru.list, &packed_git_mru.list}};
+LIST_HEAD(packed_git_mru);
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -859,9 +859,18 @@ static void prepare_packed_git_mru(void)
 {
 	struct packed_git *p;
 
-	mru_clear(&packed_git_mru);
-	for (p = packed_git; p; p = p->next)
-		mru_append(&packed_git_mru, p);
+	struct list_head *pos;
+	struct list_head *tmp;
+	list_for_each_safe(pos, tmp, &packed_git_mru)
+		list_del_init(pos);
+
+	INIT_LIST_HEAD(&packed_git_mru);
+
+	for (p = packed_git; p; p = p->next) {
+		struct packed_git *cur = xmalloc(sizeof(*packed_git));
+		cur = p;
+		list_add_tail(&cur->mru, &packed_git_mru);
+	}
 }
 
 static int prepare_packed_git_run_once = 0;
@@ -1830,10 +1839,11 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
 
-	list_for_each(pos, &packed_git_mru.list) {
-		struct mru *p = list_entry(pos, struct mru, list);
-		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(&packed_git_mru, p);
+	list_for_each(pos, &packed_git_mru) {
+		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+		if (fill_pack_entry(sha1, e, p)) {
+			list_del(&p->mru);
+			list_add(&p->mru, &packed_git_mru);
 			return 1;
 		}
 	}
-- 
2.7.4

