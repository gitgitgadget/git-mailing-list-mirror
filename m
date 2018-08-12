Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3AF1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 05:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeHLHtC (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:49:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35534 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeHLHtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:49:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so5622347wmc.0
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 22:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eubhzx8TzN3Yd21MOthL8IM1RZK5wYyK9ZrY9JEOxCk=;
        b=krrOoanqVKw57ZBEdVVComy6+O0JoXKPhwKPmq3wnd2/NZ+PL5K/owAJ5bIVgwVZa5
         ol6LIwwhh8er/svhzlKBK1I+bLM5olJv28Ig87HPe/ydS8Nyav0f+F5/9qKBgaHQ0Exe
         AAIDSE/qZAvCaIUkOfrKPkk+x1KLRz7fw/hOMswJAWvcPje2Ldqk+ED9cktZDSMvtPVp
         hZskYZTZoU9kELRtgR+wxIJEsPi57o0xtX2N08ILMDIgeFic1/YKdL7sdKtXEAiP54zc
         vABTNfC8bEHRulF2SeTfo8qamcFTQImiLSpJR7UIgIYAqn0cem90FURqBOLUkt+S4/8X
         h4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eubhzx8TzN3Yd21MOthL8IM1RZK5wYyK9ZrY9JEOxCk=;
        b=Im5ZTMKyxXuDk5D1kSfDqqkBIjbAjC1zeuU3nJUJbsHZ+6Jehp7ZAn0R2AHRAADhjx
         AgA1rq5QEFHCTMcBu7XNKWmFENGSXkN5Mzy60TuLpHpxF3cGOkLNna8KxC7V1djroW5d
         tb+RWciWf6qKB4R4XpZKwtCgIGaoAA+i1fZNHsEftpoNtLjm3KQH4ryxTqivDbflQt2w
         Olb8R7LR0lm+QPDpWATctGy6XIMKMa4zzeRV/hqspDBqxTB8jDlI4XtSNqYd1SrPbyjn
         bYeRU7DN/Fopc3mDXziRBcKDwHKcK2R9Isp9sdyPy+J+WNYloFgptdqzjLrm2wBXPbYT
         i8Dg==
X-Gm-Message-State: AOUpUlF8rZkCW6T5Ywdnd0R8Yh9HRvSSGA4kC8qUzb0VvG6vPoI8GbxN
        D2woaPC0DHrLZ6PfLSzBT329OsYb
X-Google-Smtp-Source: AA+uWPx9u3xQr9+sK+QufG0TjPoYNR2/NwFXwIFSIetGuEvWnJ8zJ6FvqSgaE2+io2grVMXE1OmUiQ==
X-Received: by 2002:a1c:5bc7:: with SMTP id p190-v6mr5057005wmb.101.1534050739088;
        Sat, 11 Aug 2018 22:12:19 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13281205wrv.90.2018.08.11.22.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 22:12:18 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: [PATCH v4 6/7] pack-objects: move tree_depth into 'struct packing_data'
Date:   Sun, 12 Aug 2018 07:11:50 +0200
Message-Id: <20180812051151.6425-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.554.gdb07901040.dirty
In-Reply-To: <20180812051151.6425-1-chriscool@tuxfamily.org>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduces the size of 'struct object_entry' and therefore
makes packing objects more efficient.

This also renames cmp_tree_depth() into tree_depth_compare(),
as it is more modern to have the name of the compare functions
end with "compare".

Helped-by: Jeff King <peff@peff.net>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c |  4 ++--
 delta-islands.c        | 27 ++++++++++++++++++---------
 pack-objects.c         |  6 ++++++
 pack-objects.h         | 21 ++++++++++++++++++++-
 4 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 30ef48dc43..fd3e514b31 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2716,8 +2716,8 @@ static void show_object(struct object *obj, const char *name, void *data)
 			depth++;
 
 		ent = packlist_find(&to_pack, obj->oid.hash, NULL);
-		if (ent && depth > ent->tree_depth)
-			ent->tree_depth = depth;
+		if (ent && depth > oe_tree_depth(&to_pack, ent))
+			oe_set_tree_depth(&to_pack, ent, depth);
 	}
 }
 
diff --git a/delta-islands.c b/delta-islands.c
index c0b0da6837..14d34e16cb 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -224,17 +224,23 @@ static void mark_remote_island_1(struct remote_island *rl, int is_core_island)
 	island_counter++;
 }
 
-static int cmp_tree_depth(const void *va, const void *vb)
+struct tree_islands_todo {
+	struct object_entry *entry;
+	unsigned int depth;
+};
+
+static int tree_depth_compare(const void *a, const void *b)
 {
-	struct object_entry *a = *(struct object_entry **)va;
-	struct object_entry *b = *(struct object_entry **)vb;
-	return a->tree_depth - b->tree_depth;
+	const struct tree_islands_todo *todo_a = a;
+	const struct tree_islands_todo *todo_b = b;
+
+	return todo_a->depth - todo_b->depth;
 }
 
 void resolve_tree_islands(int progress, struct packing_data *to_pack)
 {
 	struct progress *progress_state = NULL;
-	struct object_entry **todo;
+	struct tree_islands_todo *todo;
 	int nr = 0;
 	int i;
 
@@ -250,16 +256,19 @@ void resolve_tree_islands(int progress, struct packing_data *to_pack)
 	 */
 	ALLOC_ARRAY(todo, to_pack->nr_objects);
 	for (i = 0; i < to_pack->nr_objects; i++) {
-		if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
-			todo[nr++] = &to_pack->objects[i];
+		if (oe_type(&to_pack->objects[i]) == OBJ_TREE) {
+			todo[nr].entry = &to_pack->objects[i];
+			todo[nr].depth = oe_tree_depth(to_pack, &to_pack->objects[i]);
+			nr++;
+		}
 	}
-	QSORT(todo, nr, cmp_tree_depth);
+	QSORT(todo, nr, tree_depth_compare);
 
 	if (progress)
 		progress_state = start_progress(_("Propagating island marks"), nr);
 
 	for (i = 0; i < nr; i++) {
-		struct object_entry *ent = todo[i];
+		struct object_entry *ent = todo[i].entry;
 		struct island_bitmap *root_marks;
 		struct tree *tree;
 		struct tree_desc desc;
diff --git a/pack-objects.c b/pack-objects.c
index 92708522e7..30314572e6 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -160,6 +160,9 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (!pdata->in_pack_by_idx)
 			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
+
+		if (pdata->tree_depth)
+			REALLOC_ARRAY(pdata->tree_depth, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -175,5 +178,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	if (pdata->in_pack)
 		pdata->in_pack[pdata->nr_objects - 1] = NULL;
 
+	if (pdata->tree_depth)
+		pdata->tree_depth[pdata->nr_objects - 1] = 0;
+
 	return new_entry;
 }
diff --git a/pack-objects.h b/pack-objects.h
index 8eecd67991..3cb5527eeb 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -101,7 +101,6 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 
-	unsigned int tree_depth; /* should be repositioned for packing? */
 	unsigned char layer;
 
 	unsigned preferred_base:1; /*
@@ -145,6 +144,9 @@ struct packing_data {
 	struct packed_git **in_pack;
 
 	uintmax_t oe_size_limit;
+
+	/* delta islands */
+	unsigned int *tree_depth;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
@@ -350,4 +352,21 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 		    "where delta size is the same as entry size");
 }
 
+static inline unsigned int oe_tree_depth(struct packing_data *pack,
+					 struct object_entry *e)
+{
+	if (!pack->tree_depth)
+		return 0;
+	return pack->tree_depth[e - pack->objects];
+}
+
+static inline void oe_set_tree_depth(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned int tree_depth)
+{
+	if (!pack->tree_depth)
+		ALLOC_ARRAY(pack->tree_depth, pack->nr_objects);
+	pack->tree_depth[e - pack->objects] = tree_depth;
+}
+
 #endif
-- 
2.18.0.554.gdb07901040.dirty

