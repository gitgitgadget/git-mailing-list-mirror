Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93991F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeA2WkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:40:25 -0500
Received: from mail-vk0-f73.google.com ([209.85.213.73]:51122 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeA2WiH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:07 -0500
Received: by mail-vk0-f73.google.com with SMTP id z207so5820599vkd.17
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3ckAHx9r3U2374gAG7LgH74f6F1HeUbsZqh8DLZElKw=;
        b=q36VN5dsKWD/ytaURv1Si6kATv1QacfZ+SH1o4Mr7pNUiS1eloNVgk2ddFG+wmN3Nz
         GqG4il3p1/o8an0IzMxb1hXbmus8aVFKrLx0Uo8EbuajsP5iKALE6a9B50m5vUJ5BHSp
         iSWFqXzL1Jn1EHsHg9mPhFVFpW64hGpdKdBv2ymzlojnEyUKVuQuKcVSQnimMXh9NRJK
         un+QUgaeer3lCS7QEyEIXji/np9RDIg3EhY0DubnZoQiTN415Q5cgCRP8/or+a4RVHcp
         VfCpfy6KpEqkXf6vd0w1GaSBSaE++uq6qZ+opCFnrEbBZDsvOyUnX2J9TtZlBXetLsDM
         WmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3ckAHx9r3U2374gAG7LgH74f6F1HeUbsZqh8DLZElKw=;
        b=uoDLtbvSDguwO8ntG+nIzzfBLgZWO/LwdSWY6iMSd6fbbR+esX2HSGV79tN8aSCjtu
         +TZZ8k7+Fc0aejRJOkOG0h+W9/+r5pk4eWUzYo+Ik1tuLxDmbAylWzq2YTXtrg/ilbdE
         o+Lm1h7ck+cJvZ6jfGmFFWdFcHWo+JBH/BaFGpkrwhKgP9GyIkrZAwTTgDvojkBxZCXh
         ws5oV/N+QXt6o3QQpgq4XA1vi4rW/ktsih79ZPOgGUKmvbKB16iTWJsdIi6iG46X0R8+
         qu6IKU1WTa+6k6li0hkqv5+ZV4eKL+8CQ9UrHRZpbD2177aGZBm6m0QjzyfQaY0d5l1L
         n5Jw==
X-Gm-Message-State: AKwxytfeSyuFNgVebJGjbpGDusew55ghNT1YY6rNa5mFxltUuP/Be6DD
        eeVu/8kAVSQS4XzUbYJggN76hpsvKY4WApa52xD/xllFyMXUl9a+nfZTSNbDdXsgrwNors0GzJ8
        XsMRF2edf05Ef+pupMIQHRQvL8PSxb1ZT33w7iJ3gJ5n+5rsAZPxAANUEIg==
X-Google-Smtp-Source: AH8x227LxKU4N0wnKANowl8gDTnZtGWkG2/+zFyqBvIEAb6mmwGlNwPexWoyv82vL2ECY/LNEe4nb0YMWek=
MIME-Version: 1.0
X-Received: by 10.31.252.9 with SMTP id a9mr12229695vki.101.1517265487061;
 Mon, 29 Jan 2018 14:38:07 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:02 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-12-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 11/37] pack-redundant: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/pack-redundant.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index aaa813632..e18b53df8 100644
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
+	struct llist_item *new_item, *old, *prev;
 
 	llist_init(&ret);
 
 	if ((ret->size = list->size) == 0)
 		return ret;
 
-	new = ret->front = llist_item_get();
-	new->sha1 = list->front->sha1;
+	new_item = ret->front = llist_item_get();
+	new_item->sha1 = list->front->sha1;
 
 	old = list->front->next;
 	while (old) {
-		prev = new;
-		new = llist_item_get();
-		prev->next = new;
-		new->sha1 = old->sha1;
+		prev = new_item;
+		new_item = llist_item_get();
+		prev->next = new_item;
+		new_item->sha1 = old->sha1;
 		old = old->next;
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
2.16.0.rc1.238.g530d649a79-goog

