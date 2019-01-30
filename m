Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94FA1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfA3LtE (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:49:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA3LtE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:49:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so11309725pfi.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVjEGVwFu6ah1dkko/ndN0GVwnq8FgZYpPbkMl74yas=;
        b=JJDGGjN7CfcQewSg5zsT/bazbG6m6WZ0HEWnrEvy98p7QyGZDl3xnfvWX7+kF+j0ts
         QGyQoSfNuvyK+2nXz6mQBDYz5Wb6ubvEY4fBVprgpgOZUXZGNr9nWSOzM0PpdJCdGNO6
         cqIOumQQVCOQ32ELYcFUc2O4GI/N1i2jvt0vU1LVEJB4QyBW90IPGvmg2Uy13zVlC64E
         qJQnZrfJVKKNCiy1qrVONHrRzQYZT8P5wgvSPP3LtRgnNIzan9OW/v8nKN8qGCnHdEH5
         D8JJGWNrd5IZJy5ncO/CBUk52yHITaWEkW5NHNcXtT4cDBrBYXKKT3JTB3pzlTvTMjuJ
         RIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVjEGVwFu6ah1dkko/ndN0GVwnq8FgZYpPbkMl74yas=;
        b=n8FbmM/VcasanxwfKS347DcY/xNusZJKDES8ztoLIj7QY+7g9fzq6KYwu7/RRCgvds
         DnVEwyNPboxLT2VjJQXxmOkzBZuoYxvwgxRLfKLVougnRbT+TouAZWFcoTxybGzw4bX9
         WEmCZikw7rfwsH+lWsBwCQUSxTnRYQsHqCkJCmqtQbKHjhwYo9Mgkb7a37vteEwftHCW
         cLfLojTKLMmkUFOEP0egm/Ct/K94A50uJFzqwZXW6EeTlIS0DiZN25uTW4fifzgFJKH6
         X9Mwk6UL2wUzmf3P43ywnKyRWJaogiCsU2q3ePz+wOWrzQvre31ufow5rYBW1/dlVMth
         ZLKg==
X-Gm-Message-State: AJcUukcccx9CERLkZ2kwDg3u/vub++ugcT0tCvBjGVCixeKlu5WC1kbM
        bUROCQpZua8AHak0rmS+/+k=
X-Google-Smtp-Source: ALg8bN6ucL/81j4nD12V8NA3ciuO9qbfbwhYV6+J4PYop+wE3A44CqPgcOGUlMC1tM7fk1AODVeySQ==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr29855026pfa.186.1548848943254;
        Wed, 30 Jan 2019 03:49:03 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:49:02 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 5/6] pack-redundant: rename pack_list.all_objects
Date:   Wed, 30 Jan 2019 19:47:35 +0800
Message-Id: <20190130114736.30357-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

New algorithm uses `pack_list.all_objects` to track remaining objects,
so rename it to `pack_list.remaining_objects`.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index b83d55031a..c145852b8b 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -32,7 +32,7 @@ static struct pack_list {
 	struct pack_list *next;
 	struct packed_git *pack;
 	struct llist *unique_objects;
-	struct llist *all_objects;
+	struct llist *remaining_objects;
 } *local_packs = NULL, *altodb_packs = NULL;
 
 static struct llist_item *free_nodes;
@@ -241,9 +241,9 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 	const unsigned int hashsz = the_hash_algo->rawsz;
 
 	if (!p1->unique_objects)
-		p1->unique_objects = llist_copy(p1->all_objects);
+		p1->unique_objects = llist_copy(p1->remaining_objects);
 	if (!p2->unique_objects)
-		p2->unique_objects = llist_copy(p2->all_objects);
+		p2->unique_objects = llist_copy(p2->remaining_objects);
 
 	p1_base = p1->pack->index_data;
 	p2_base = p2->pack->index_data;
@@ -344,8 +344,8 @@ static int cmp_pack_list_reverse(const void *a, const void *b)
 {
 	struct pack_list *pl_a = *((struct pack_list **)a);
 	struct pack_list *pl_b = *((struct pack_list **)b);
-	size_t sz_a = pl_a->all_objects->size;
-	size_t sz_b = pl_b->all_objects->size;
+	size_t sz_a = pl_a->remaining_objects->size;
+	size_t sz_b = pl_b->remaining_objects->size;
 
 	if (sz_a == sz_b)
 		return 0;
@@ -355,7 +355,7 @@ static int cmp_pack_list_reverse(const void *a, const void *b)
 		return -1;
 }
 
-/* Sort pack_list, greater size of all_objects first */
+/* Sort pack_list, greater size of remaining_objects first */
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
@@ -399,7 +399,7 @@ static void minimize(struct pack_list **min)
 	missing = llist_copy(all_objects);
 	pl = unique;
 	while (pl) {
-		llist_sorted_difference_inplace(missing, pl->all_objects);
+		llist_sorted_difference_inplace(missing, pl->remaining_objects);
 		pl = pl->next;
 	}
 
@@ -417,20 +417,20 @@ static void minimize(struct pack_list **min)
 	/* remove unique pack objects from the non_unique packs */
 	pl = non_unique;
 	while (pl) {
-		llist_sorted_difference_inplace(pl->all_objects, unique_pack_objects);
+		llist_sorted_difference_inplace(pl->remaining_objects, unique_pack_objects);
 		pl = pl->next;
 	}
 
 	while (non_unique) {
-		/* sort the non_unique packs, greater size of all_objects first */
+		/* sort the non_unique packs, greater size of remaining_objects first */
 		sort_pack_list(&non_unique);
-		if (non_unique->all_objects->size == 0)
+		if (non_unique->remaining_objects->size == 0)
 			break;
 
 		pack_list_insert(min, non_unique);
 
-		for (pl = non_unique->next; pl && pl->all_objects->size > 0;  pl = pl->next)
-			llist_sorted_difference_inplace(pl->all_objects, non_unique->all_objects);
+		for (pl = non_unique->next; pl && pl->remaining_objects->size > 0;  pl = pl->next)
+			llist_sorted_difference_inplace(pl->remaining_objects, non_unique->remaining_objects);
 
 		non_unique = non_unique->next;
 	}
@@ -445,7 +445,7 @@ static void load_all_objects(void)
 
 	while (pl) {
 		hint = NULL;
-		l = pl->all_objects->front;
+		l = pl->remaining_objects->front;
 		while (l) {
 			hint = llist_insert_sorted_unique(all_objects,
 							  l->oid, hint);
@@ -456,7 +456,7 @@ static void load_all_objects(void)
 	/* remove objects present in remote packs */
 	pl = altodb_packs;
 	while (pl) {
-		llist_sorted_difference_inplace(all_objects, pl->all_objects);
+		llist_sorted_difference_inplace(all_objects, pl->remaining_objects);
 		pl = pl->next;
 	}
 }
@@ -481,11 +481,11 @@ static void scan_alt_odb_packs(void)
 	while (alt) {
 		local = local_packs;
 		while (local) {
-			llist_sorted_difference_inplace(local->all_objects,
-							alt->all_objects);
+			llist_sorted_difference_inplace(local->remaining_objects,
+							alt->remaining_objects);
 			local = local->next;
 		}
-		llist_sorted_difference_inplace(all_objects, alt->all_objects);
+		llist_sorted_difference_inplace(all_objects, alt->remaining_objects);
 		alt = alt->next;
 	}
 }
@@ -500,7 +500,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return NULL;
 
 	l.pack = p;
-	llist_init(&l.all_objects);
+	llist_init(&l.remaining_objects);
 
 	if (open_pack_index(p))
 		return NULL;
@@ -509,7 +509,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
 	step = the_hash_algo->rawsz + ((p->index_version < 2) ? 4 : 0);
 	while (off < p->num_objects * step) {
-		llist_insert_back(l.all_objects, (const struct object_id *)(base + off));
+		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
 	l.unique_objects = NULL;
@@ -606,7 +606,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	llist_sorted_difference_inplace(all_objects, ignore);
 	pl = local_packs;
 	while (pl) {
-		llist_sorted_difference_inplace(pl->all_objects, ignore);
+		llist_sorted_difference_inplace(pl->remaining_objects, ignore);
 		pl = pl->next;
 	}
 
-- 
2.20.1.103.ged0fc2ca7b

