Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F7E1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 12:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfAJMFS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 07:05:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38746 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJMFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 07:05:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so5219670pfi.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 04:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omq9iNaSuFesm3pOkIb34gc3XwOPHx6YaCh9mavardw=;
        b=hFJSaCb6INpsXWATbJW/NOFbRG6LmMIIr4Lgjbp8vVxBUlTrXDhVWbna3a1l+ryo3Y
         56Zf0G0CgCV9cy0mKxxSSaUXtMtJstCpCY7TnfWBZ/kyK13/KMtP71Q7oDLgaRlxuZUC
         MM4s52Iw7hYQeXnuguzTNUSH70ATvWPvXVCWJiMN8Dn/C2BiLC/vvgpLrNY+a4tdNs/W
         YQEoE3wPBK2xeOE5J63Fyyk3HD1nefcIf0YfXGnroSIw3I9FawUPNcGOgwXQxYgxUYVi
         09uUygXxRfY3GIHpNEyko9LuOaUGCGK4GWTO7abRO7oZmWNYxq6ZWRy+NQb61i5uqJGn
         XCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omq9iNaSuFesm3pOkIb34gc3XwOPHx6YaCh9mavardw=;
        b=l05S6fU8RkEGVPd8NEe0UNRekNyqhBv6UhBYw37syQ6NHrUx4t8oEWO24Uhas/pLWR
         X0X7ACHTLDndAa5UQKUtcR5aiNP+1+u4RkOySo6GsnSGh7QaeC2XB+nXVkonH/TYby3O
         svmFfDRkfarXeIhh9JVPEmcuaqiOmZbzYBKnZtz54OuIqru7NJZgjSPA0XiSmDWZv4PF
         GEzg28xbhpfIVD8IRoUvSPhv3Iv+tiFaAKUcNfUSQJN1TvbR3oVS9d3XxbMXBaKLwk+g
         hRtpgNRWxzf2rIqagiEw5ZEW1Oxa7EZ5XwTWj5Ki5tNZlXGc6Ed1qiAGoc2etmufSNok
         9R7w==
X-Gm-Message-State: AJcUukegOVeSSVpg7+WjqVRfWEp4pPFvPrJvh3I917Y52K7m8HaOCn/H
        G7CWORSHGKvgZzNV7ZpH12c=
X-Google-Smtp-Source: ALg8bN4ZiDQVJf46i9bC5V3vjBTDJ9Biqo860tuJP+35ceQeS/2cVtNkhEzPQHFYHgVrxwNmnEwWKA==
X-Received: by 2002:a63:cd11:: with SMTP id i17mr9226761pgg.345.1547121916531;
        Thu, 10 Jan 2019 04:05:16 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.204])
        by smtp.gmail.com with ESMTPSA id b2sm137189403pfm.3.2019.01.10.04.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:05:16 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v5 3/5] pack-redundant: rename pack_list.all_objects
Date:   Thu, 10 Jan 2019 20:01:40 +0800
Message-Id: <20190110120142.22271-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.101.gc01fadde4e
In-Reply-To: <20190109164731.GJ4673@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
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
 builtin/pack-redundant.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3655cc7dc6..56591d283f 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -32,7 +32,7 @@ static struct pack_list {
 	struct pack_list *next;
 	struct packed_git *pack;
 	struct llist *unique_objects;
-	struct llist *all_objects;
+	struct llist *remaining_objects;
 } *local_packs = NULL, *altodb_packs = NULL;
 
 struct pll {
@@ -346,7 +346,7 @@ static int is_superset(struct pack_list *pl, struct llist *list)
 	diff = llist_copy(list);
 
 	while (pl) {
-		llist_sorted_difference_inplace(diff, pl->all_objects);
+		llist_sorted_difference_inplace(diff, pl->remaining_objects);
 		if (diff->size == 0) { /* we're done */
 			llist_free(diff);
 			return 1;
@@ -425,8 +425,8 @@ static int cmp_pack_list_reverse(const void *a, const void *b)
 {
 	struct pack_list *pl_a = *((struct pack_list **)a);
 	struct pack_list *pl_b = *((struct pack_list **)b);
-	size_t sz_a = pl_a->all_objects->size;
-	size_t sz_b = pl_b->all_objects->size;
+	size_t sz_a = pl_a->remaining_objects->size;
+	size_t sz_b = pl_b->remaining_objects->size;
 
 	if (sz_a == sz_b)
 		return 0;
@@ -436,7 +436,7 @@ static int cmp_pack_list_reverse(const void *a, const void *b)
 		return -1;
 }
 
-/* Sort pack_list, greater size of all_objects first */
+/* Sort pack_list, greater size of remaining_objects first */
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
@@ -480,7 +480,7 @@ static void minimize(struct pack_list **min)
 	missing = llist_copy(all_objects);
 	pl = unique;
 	while (pl) {
-		llist_sorted_difference_inplace(missing, pl->all_objects);
+		llist_sorted_difference_inplace(missing, pl->remaining_objects);
 		pl = pl->next;
 	}
 
@@ -498,20 +498,20 @@ static void minimize(struct pack_list **min)
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
@@ -526,7 +526,7 @@ static void load_all_objects(void)
 
 	while (pl) {
 		hint = NULL;
-		l = pl->all_objects->front;
+		l = pl->remaining_objects->front;
 		while (l) {
 			hint = llist_insert_sorted_unique(all_objects,
 							  l->oid, hint);
@@ -537,7 +537,7 @@ static void load_all_objects(void)
 	/* remove objects present in remote packs */
 	pl = altodb_packs;
 	while (pl) {
-		llist_sorted_difference_inplace(all_objects, pl->all_objects);
+		llist_sorted_difference_inplace(all_objects, pl->remaining_objects);
 		pl = pl->next;
 	}
 }
@@ -563,10 +563,10 @@ static void scan_alt_odb_packs(void)
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
@@ -581,7 +581,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return NULL;
 
 	l.pack = p;
-	llist_init(&l.all_objects);
+	llist_init(&l.remaining_objects);
 
 	if (open_pack_index(p))
 		return NULL;
@@ -590,11 +590,11 @@ static struct pack_list * add_pack(struct packed_git *p)
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
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	pl = local_packs;
 	while (pl) {
 		llist_sorted_difference_inplace(pl->unique_objects, ignore);
-		llist_sorted_difference_inplace(pl->all_objects, ignore);
+		llist_sorted_difference_inplace(pl->remaining_objects, ignore);
 		pl = pl->next;
 	}
 
-- 
2.20.1.101.gc01fadde4e

