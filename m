Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5507B202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 10:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbdI0KSv (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 06:18:51 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38786 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdI0KSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 06:18:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id q8so1134773qkl.5
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PgoY+og/7n+5jCEfM1F5uZ/n0waF00mrjt74zftihqk=;
        b=Z8Z/C7y8CL4WvkDayvQjyJz6Zrz0muGLVnTUzF/x5/TwA+28FYB3W2OsmEGSgrTI8f
         nmZoVhAWroQN5xVGtY6mznZAYNgDsuZvgRnlLqpPVhqjWNb6lyH9SnvFcNyQS5bqa63+
         ayfTXL5tID0H2G6kzE6wI+9/TTDJcRhre93zcKYpgjuFSRXL0sBRX6FYOiJFpeeyMsC8
         5f/NdrNNAyKYtnddsiGvMcWTdTF7KjQgR81m9vDNdOq3rLFpponVogrjVJeB1NjUTfT+
         AYcQ84OkB3S+F/YZHdWHHR4/qRJvOh+g31MDOWOByZ695eiIqfKe0HGWp2YY7urVZiqr
         huyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PgoY+og/7n+5jCEfM1F5uZ/n0waF00mrjt74zftihqk=;
        b=al6XARV5/wx/hAHfuKeP/cxeuE+Njy2hfCDpkBM1CtO0JhYdDKka7a5d0tO6Ub91nf
         BcipZxvDqwh4j/AQqwFQ3LHOw4DM4KAq8+ndyQuqh8dLPDDDJZxqDhKGokLSU+rnYlTb
         yz1V94gzRedtrMvin30zeNqMtMxVchA6sCyalQIyqugJYzLWuW+YRBpdwfjEyjpFDXU8
         AoY9dBFHrTUBPh3CsyDtqZ9Lftu72SC7kL3h76bzDN85ZyZ9d1iBn/y5/jUmZTm3tLlS
         nT1AKO9fr2yf8M0ppIoQHqzPH/+pyaA2GnWtCgQTmNwhJOWwpaM4MMJ1cCUFUsU8q6v/
         uE4A==
X-Gm-Message-State: AHPjjUiqyIZcJi0U99dmTugoqUlMq9XYamG/Gp6Tyrk48RD8mgjxu85w
        m+7LySiL19L1y1RDbQKcdWNwA/5dmV5TeBUqtA0EZQ==
X-Google-Smtp-Source: AOwi7QDeTEqMTl/rSwHz8jO+SRjI/1CzlaedGqfR+kAShRsi7NDGRoEpza00UWxpgoT4/WQDIGj1lIPqhxRffpm28YA=
X-Received: by 10.55.169.81 with SMTP id s78mr1643128qke.34.1506507528755;
 Wed, 27 Sep 2017 03:18:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.35.233 with HTTP; Wed, 27 Sep 2017 03:18:48 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 27 Sep 2017 13:18:48 +0300
Message-ID: <CAL21BmnvJSaN+Tnw7Hdc5P5biAnM5dfWR7gX5FrAG1r_D8th=A@mail.gmail.com>
Subject: [PATCH] [Outreachy] cleanup: use list.h in mru.h and mru.c
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove implementation of double-linked list in mru.c and mru.h and use
implementation from list.h.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>, Jeff King
<peff@peff.net>
---
 builtin/pack-objects.c |  5 +++--
 mru.c                  | 51 +++++++++++++++-----------------------------------
 mru.h                  | 31 +++++++++++++-----------------
 packfile.c             |  6 ++++--
 4 files changed, 35 insertions(+), 58 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f721137ea..fb4c9be89 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -995,8 +995,8 @@ static int want_object_in_pack(const unsigned char *sha1,
         struct packed_git **found_pack,
         off_t *found_offset)
 {
- struct mru_entry *entry;
  int want;
+        struct list_head *pos;

  if (!exclude && local && has_loose_object_nonlocal(sha1))
  return 0;
@@ -1012,7 +1012,8 @@ static int want_object_in_pack(const unsigned char *sha1,
  return want;
  }

- for (entry = packed_git_mru.head; entry; entry = entry->next) {
+ list_for_each(pos, &packed_git_mru.list) {
+ struct mru *entry = list_entry(pos, struct mru, list);
  struct packed_git *p = entry->item;
  off_t offset;

diff --git a/mru.c b/mru.c
index 9dedae028..8b6ba3d9b 100644
--- a/mru.c
+++ b/mru.c
@@ -1,50 +1,29 @@
 #include "cache.h"
 #include "mru.h"

-void mru_append(struct mru *mru, void *item)
+void mru_append(struct mru *head, void *item)
 {
- struct mru_entry *cur = xmalloc(sizeof(*cur));
+ struct mru *cur = xmalloc(sizeof(*cur));
  cur->item = item;
- cur->prev = mru->tail;
- cur->next = NULL;
-
- if (mru->tail)
- mru->tail->next = cur;
- else
- mru->head = cur;
- mru->tail = cur;
+ list_add_tail(&cur->list, &head->list);
 }

-void mru_mark(struct mru *mru, struct mru_entry *entry)
+void mru_mark(struct mru *head, struct mru *entry)
 {
- /* If we're already at the front of the list, nothing to do */
- if (mru->head == entry)
- return;
-
- /* Otherwise, remove us from our current slot... */
- if (entry->prev)
- entry->prev->next = entry->next;
- if (entry->next)
- entry->next->prev = entry->prev;
- else
- mru->tail = entry->prev;
-
- /* And insert us at the beginning. */
- entry->prev = NULL;
- entry->next = mru->head;
- if (mru->head)
- mru->head->prev = entry;
- mru->head = entry;
+ /* To mark means to put at the front of the list. */
+ list_del(&entry->list);
+ list_add(&entry->list, &head->list);
 }

-void mru_clear(struct mru *mru)
+void mru_clear(struct mru *head)
 {
- struct mru_entry *p = mru->head;
-
- while (p) {
- struct mru_entry *to_free = p;
- p = p->next;
+ struct list_head *p1;
+ struct list_head *p2;
+ struct mru *to_free;
+
+ list_for_each_safe(p1, p2, &head->list) {
+ to_free = list_entry(p1, struct mru, list);
  free(to_free);
  }
- mru->head = mru->tail = NULL;
+ INIT_LIST_HEAD(&head->list);
 }
diff --git a/mru.h b/mru.h
index 42e4aeaa1..36a332af0 100644
--- a/mru.h
+++ b/mru.h
@@ -1,6 +1,8 @@
 #ifndef MRU_H
 #define MRU_H

+#include "list.h"
+
 /**
  * A simple most-recently-used cache, backed by a doubly-linked list.
  *
@@ -8,18 +10,15 @@
  *
  *   // Create a list.  Zero-initialization is required.
  *   static struct mru cache;
- *   mru_append(&cache, item);
- *   ...
+ *   INIT_LIST_HEAD(&cache.list);
  *
- *   // Iterate in MRU order.
- *   struct mru_entry *p;
- *   for (p = cache.head; p; p = p->next) {
- * if (matches(p->item))
- * break;
- *   }
+ *   // Add new item to the end of the list.
+ *   void *item;
+ *   ...
+ *   mru_append(&cache, item);
  *
  *   // Mark an item as used, moving it to the front of the list.
- *   mru_mark(&cache, p);
+ *   mru_mark(&cache, item);
  *
  *   // Reset the list to empty, cleaning up all resources.
  *   mru_clear(&cache);
@@ -29,17 +28,13 @@
  * you will begin traversing the whole list again.
  */

-struct mru_entry {
- void *item;
- struct mru_entry *prev, *next;
-};
-
 struct mru {
- struct mru_entry *head, *tail;
+ struct list_head list;
+        void *item;
 };

-void mru_append(struct mru *mru, void *item);
-void mru_mark(struct mru *mru, struct mru_entry *entry);
-void mru_clear(struct mru *mru);
+void mru_append(struct mru *head, void *item);
+void mru_mark(struct mru *head, struct mru *entry);
+void mru_clear(struct mru *head);

 #endif /* MRU_H */
diff --git a/packfile.c b/packfile.c
index f69a5c8d6..ae3b0b2e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -876,6 +876,7 @@ void prepare_packed_git(void)
  for (alt = alt_odb_list; alt; alt = alt->next)
  prepare_packed_git_one(alt->path, 0);
  rearrange_packed_git();
+ INIT_LIST_HEAD(&packed_git_mru.list);
  prepare_packed_git_mru();
  prepare_packed_git_run_once = 1;
 }
@@ -1824,13 +1825,14 @@ static int fill_pack_entry(const unsigned char *sha1,
  */
 int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
- struct mru_entry *p;
+ struct list_head *pos;

  prepare_packed_git();
  if (!packed_git)
  return 0;

- for (p = packed_git_mru.head; p; p = p->next) {
+ list_for_each(pos, &packed_git_mru.list) {
+ struct mru *p = list_entry(pos, struct mru, list);
  if (fill_pack_entry(sha1, e, p->item)) {
  mru_mark(&packed_git_mru, p);
  return 1;
-- 
2.14.1.727.g9ddaf86b0
