Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F1A211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 09:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfALJUA (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 04:20:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38375 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfALJT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 04:19:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so7352497pgc.5
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nV5BI1l9Z2CtRPJdsyRclY8HUKLxXhtq2HTZnFINtk=;
        b=i/a449vhvSOgnjY97BNg27nTYfYbUxFHMILcg+E20xqDeANGShhEi4vBmp8PcrUDr+
         rj92qFZDsXI0eWS75z8lNaVPI6Oz52jDht0wggp4eLYu/x/V0sclYJzsP1am0BiZl5N2
         zIiZh1Xd+m/gLC38fMyP7du/xRCpmGmwhdwHaXxbvrn6Nur6V1zIyyvx6cRU5i4CmFRj
         Hyybk+qkTp/SsG1cWsgFvz5/PfaSZq64ePTUQedn+AA/8IPuEemjbUpw+hSMD7Bl/v6d
         0Erdez/0ftTsyw8hlgfGR8lCV/ZpRWp77OdJOywZy5uBG+xPzo5Ig4HR17mNCGBeBPTN
         b4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nV5BI1l9Z2CtRPJdsyRclY8HUKLxXhtq2HTZnFINtk=;
        b=O3pk+pcnrVSfZilNbNx3HcoPRyOsSnh124BP0Tv+NXkpzfS9rGKsqBrlYLF1V6fwNv
         L48viAhvzkEBY8ey8Hpta6CU+4t2IhlVe45aMzXPBYjOSrUl308PazbnseeHBzjZbzu9
         CK9/ztDA72QfY/w72xGf3Z0mhSuWbdNmYVkEqINYnQjTsnRPDnRQstoZ4gd3AaXhI7rF
         GtgHxPexD9Ob0WlSeGWirtImO8Aym9ZUlhqBYmkna/l6dsrRCAYFg87SXPyuWGE/pplH
         Yj6lwkYmmC+cCDBzYlfYw9Y4hBlQWBhVgZrcUlodwHeGPFBQVnYDodc2IdzUnGk2uDF5
         bnTw==
X-Gm-Message-State: AJcUukeDGBIc+tC7L0u3TZnOTNoc9CCgR+Pl4xWviexPRJciQ1b2CAQ+
        LBdNjRryMAwbyJzv4sTS0Mc=
X-Google-Smtp-Source: ALg8bN4/WHQQCGad5eAwIHl1chO9i0U38QjZaIplgA/jrc04sz8prMu8VP+QRScBdx0o5Cfd14J7Og==
X-Received: by 2002:a63:60cf:: with SMTP id u198mr16406829pgb.323.1547284798765;
        Sat, 12 Jan 2019 01:19:58 -0800 (PST)
Received: from localhost.localdomain ([221.222.155.87])
        by smtp.gmail.com with ESMTPSA id i5sm27685510pfg.34.2019.01.12.01.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:19:58 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 4/5] pack-redundant: rename pack_list.all_objects
Date:   Sat, 12 Jan 2019 17:17:53 +0800
Message-Id: <20190112091754.30985-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20190110120142.22271-1-worldhello.net@gmail.com>
References: <20190110120142.22271-1-worldhello.net@gmail.com>
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
---
 builtin/pack-redundant.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index eac23500ee..64eec3e297 100644
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
@@ -339,8 +339,8 @@ static int cmp_pack_list_reverse(const void *a, const void *b)
 {
 	struct pack_list *pl_a = *((struct pack_list **)a);
 	struct pack_list *pl_b = *((struct pack_list **)b);
-	size_t sz_a = pl_a->all_objects->size;
-	size_t sz_b = pl_b->all_objects->size;
+	size_t sz_a = pl_a->remaining_objects->size;
+	size_t sz_b = pl_b->remaining_objects->size;
 
 	if (sz_a == sz_b)
 		return 0;
@@ -350,7 +350,7 @@ static int cmp_pack_list_reverse(const void *a, const void *b)
 		return -1;
 }
 
-/* Sort pack_list, greater size of all_objects first */
+/* Sort pack_list, greater size of remaining_objects first */
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
@@ -394,7 +394,7 @@ static void minimize(struct pack_list **min)
 	missing = llist_copy(all_objects);
 	pl = unique;
 	while (pl) {
-		llist_sorted_difference_inplace(missing, pl->all_objects);
+		llist_sorted_difference_inplace(missing, pl->remaining_objects);
 		pl = pl->next;
 	}
 
@@ -412,20 +412,20 @@ static void minimize(struct pack_list **min)
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
@@ -440,7 +440,7 @@ static void load_all_objects(void)
 
 	while (pl) {
 		hint = NULL;
-		l = pl->all_objects->front;
+		l = pl->remaining_objects->front;
 		while (l) {
 			hint = llist_insert_sorted_unique(all_objects,
 							  l->oid, hint);
@@ -451,7 +451,7 @@ static void load_all_objects(void)
 	/* remove objects present in remote packs */
 	pl = altodb_packs;
 	while (pl) {
-		llist_sorted_difference_inplace(all_objects, pl->all_objects);
+		llist_sorted_difference_inplace(all_objects, pl->remaining_objects);
 		pl = pl->next;
 	}
 }
@@ -477,10 +477,10 @@ static void scan_alt_odb_packs(void)
 		local = local_packs;
 		while (local) {
 			llist_sorted_difference_inplace(local->unique_objects,
-							alt->all_objects);
+							alt->remaining_objects);
 			local = local->next;
 		}
-		llist_sorted_difference_inplace(all_objects, alt->all_objects);
+		llist_sorted_difference_inplace(all_objects, alt->remaining_objects);
 		alt = alt->next;
 	}
 }
@@ -495,7 +495,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return NULL;
 
 	l.pack = p;
-	llist_init(&l.all_objects);
+	llist_init(&l.remaining_objects);
 
 	if (open_pack_index(p))
 		return NULL;
@@ -504,11 +504,11 @@ static struct pack_list * add_pack(struct packed_git *p)
 	base += 256 * 4 + ((p->index_version < 2) ? 4 : 8);
 	step = the_hash_algo->rawsz + ((p->index_version < 2) ? 4 : 0);
 	while (off < p->num_objects * step) {
-		llist_insert_back(l.all_objects, (const struct object_id *)(base + off));
+		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
 	/* this list will be pruned in cmp_two_packs later */
-	l.unique_objects = llist_copy(l.all_objects);
+	l.unique_objects = llist_copy(l.remaining_objects);
 	if (p->pack_local)
 		return pack_list_insert(&local_packs, &l);
 	else
@@ -604,7 +604,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	pl = local_packs;
 	while (pl) {
 		llist_sorted_difference_inplace(pl->unique_objects, ignore);
-		llist_sorted_difference_inplace(pl->all_objects, ignore);
+		llist_sorted_difference_inplace(pl->remaining_objects, ignore);
 		pl = pl->next;
 	}
 
-- 
2.20.0.3.gc45e608566

