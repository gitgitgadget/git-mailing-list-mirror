Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284051F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162525AbeBNTBR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:17 -0500
Received: from mail-ua0-f201.google.com ([209.85.217.201]:46533 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162506AbeBNTBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:12 -0500
Received: by mail-ua0-f201.google.com with SMTP id k4so15481902uad.13
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PeB2J24wPDzeQjlfU5SBQceXOJj/z6L/xvwQc4+IbAU=;
        b=X0lkcYyB1mqQRpNy6yXa8JYiiO9wNtQOYjRb+wMDnQzxyJdFhUAwrRZ1Pbnt+EDLxo
         QSmCxbvLE1OgOt4cjtY/2MnCnf1ah8tqsiKXQFycR8upC03ub5lF7tTlRsCMgeLIZCWT
         fke+6LUkAKkUFntKJ3GQBSBMxUF/4/9R4wF/X234fbYxTfsXkVpWcjIjSOQN7rK204us
         e/JGJ8MCDBVxfmEa/VRFhWN1Uq+k8h8Ni9Z+jgNhzhe5MDIFi3BXPOcX6iBz1zAVoNNA
         UksD4xBAbSFNtnjvfbiL5mAB3EOHV34hYQgHTIQpeeiPfKTFUNP1+8mDA/oFw/NM3BOZ
         2Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PeB2J24wPDzeQjlfU5SBQceXOJj/z6L/xvwQc4+IbAU=;
        b=LJ+vfMHz6ZXuF0TjY4ieY0AHc4buhLSMBiEpBWaB9ZD7YnOBAXN4iX2M4/YcOt8UX3
         k6MTwWbFy8ZzfwAd1VauT9gkcM39/MtIKvpRvgwXLP6O6J3FWfmGp+/XxApODZQwrYRy
         PKQhhiy547hXUhU6dlRGcKwhgYmq0LeGTCAR4g0ODFWOhMKFYkjiOIYy3KujnFyXAvr1
         R6H4OjmiFw43T1mgJkrd3U+rnr3Rsr9TzH1FmMf3knywnpQvr+hN1cwaV4MpoufHYJPW
         wMsikhhusRVqzCCF4iigDHcM9pyfpXkWn4Y6P624PVkHQCsy+yho/Q0/5f4YviWDNUs2
         hcrw==
X-Gm-Message-State: APf1xPDlYxlUyVDuVXs7/PGzLcB1qXvriZQPozIMtUIcSH9x+yXTbdOx
        WJzUDq5W/yxyDrfWH94HB+11f4i0T+jVvKvC536ai5m5S4QXxQ6j6ntPcoHMiPeqcxWQp7ZJrVj
        CzlVIaP8gfIHg9AiKnFDBfilNYnsMe6G9pDAR3KDstP8JnPIvCPT7gWLgMg==
X-Google-Smtp-Source: AH8x226ylyB6KyJOMOlBASY5FaXOidb1HFIlfxazgPryvYf7vrOsTALE3nzau6b4nfgg2DzFNcQHJBAZErY=
MIME-Version: 1.0
X-Received: by 10.176.0.162 with SMTP id 31mr2773868uaj.84.1518634871967; Wed,
 14 Feb 2018 11:01:11 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:33 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-12-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 11/37] pack-redundant: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/pack-redundant.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index aaa813632..991e1bb76 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -48,17 +48,17 @@ static inline void llist_item_put(struct llist_item *item)
 
 static inline struct llist_item *llist_item_get(void)
 {
-	struct llist_item *new;
+	struct llist_item *new_item;
 	if ( free_nodes ) {
-		new = free_nodes;
+		new_item = free_nodes;
 		free_nodes = free_nodes->next;
 	} else {
 		int i = 1;
-		ALLOC_ARRAY(new, BLKSIZE);
+		ALLOC_ARRAY(new_item, BLKSIZE);
 		for (; i < BLKSIZE; i++)
-			llist_item_put(&new[i]);
+			llist_item_put(&new_item[i]);
 	}
-	return new;
+	return new_item;
 }
 
 static void llist_free(struct llist *list)
@@ -80,26 +80,26 @@ static inline void llist_init(struct llist **list)
 static struct llist * llist_copy(struct llist *list)
 {
 	struct llist *ret;
-	struct llist_item *new, *old, *prev;
+	struct llist_item *new_item, *old_item, *prev;
 
 	llist_init(&ret);
 
 	if ((ret->size = list->size) == 0)
 		return ret;
 
-	new = ret->front = llist_item_get();
-	new->sha1 = list->front->sha1;
+	new_item = ret->front = llist_item_get();
+	new_item->sha1 = list->front->sha1;
 
-	old = list->front->next;
-	while (old) {
-		prev = new;
-		new = llist_item_get();
-		prev->next = new;
-		new->sha1 = old->sha1;
-		old = old->next;
+	old_item = list->front->next;
+	while (old_item) {
+		prev = new_item;
+		new_item = llist_item_get();
+		prev->next = new_item;
+		new_item->sha1 = old_item->sha1;
+		old_item = old_item->next;
 	}
-	new->next = NULL;
-	ret->back = new;
+	new_item->next = NULL;
+	ret->back = new_item;
 
 	return ret;
 }
@@ -108,24 +108,24 @@ static inline struct llist_item *llist_insert(struct llist *list,
 					      struct llist_item *after,
 					       const unsigned char *sha1)
 {
-	struct llist_item *new = llist_item_get();
-	new->sha1 = sha1;
-	new->next = NULL;
+	struct llist_item *new_item = llist_item_get();
+	new_item->sha1 = sha1;
+	new_item->next = NULL;
 
 	if (after != NULL) {
-		new->next = after->next;
-		after->next = new;
+		new_item->next = after->next;
+		after->next = new_item;
 		if (after == list->back)
-			list->back = new;
+			list->back = new_item;
 	} else {/* insert in front */
 		if (list->size == 0)
-			list->back = new;
+			list->back = new_item;
 		else
-			new->next = list->front;
-		list->front = new;
+			new_item->next = list->front;
+		list->front = new_item;
 	}
 	list->size++;
-	return new;
+	return new_item;
 }
 
 static inline struct llist_item *llist_insert_back(struct llist *list,
-- 
2.16.1.291.g4437f3f132-goog

