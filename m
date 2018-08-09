Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B1A1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeHISVl (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38513 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbeHISVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so5582430wro.5
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44fQWrAjE5F1G8T82xTAWsp/pQ3iQ2boJKzTPQdmOVc=;
        b=uSh3TZ5DebLKryCitfMmFBViMY75O+95FZdQg9Bmtk9EU1QSqYecHjtoeO9Dy7bb8a
         /BM6WBRY0vxwJNt9migkLj6fBZzAn9oVuJkJCgDJp5TRQEUniT/i2/EyYKBbuu+E3F+o
         q5TmMpqOtMGrmjRjlcB69MSyfOsyMTPOXnfqHX2u1FUktoadLzd6T6WBX9WwxTMWrJMf
         CWld1WVeH6QpUsqJvDtnIiRCAvxojjiw2LBLLeNB1hps5ZjJDqmB7qvaRVrcYv7kYvcw
         am/fXVv6w7U0pc/vMOJWQmn0c72DumJ8yS3zElFoRGuhHFrn3WCmUvj16T8yIObNXWRR
         93PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44fQWrAjE5F1G8T82xTAWsp/pQ3iQ2boJKzTPQdmOVc=;
        b=LhAj9UHxUEjLStRew4Y9ks3CCAKJbFkuqNRVO8xAMvXbB4Lf4PqCDpOeEwRFncv69W
         tgzLyLLDshOvzZ5Xe3PsMR72dqfur4UiOVkgufwnxqwFcTFEf2MstzN9T+83ooRyXTjh
         QwBIFPWJIk0YWz7RgNsM1oBmJzTXLCsGtJywp2hbxF5W5ElzggQOdYVHCPXd1tvfztIX
         zfOJyxVFhT9E6NJuzRXXpTTlsiC8yrRod00bTVxScM27uQi3W5Q6GhMQ7P+B/O1kBZR1
         +9dN9kqmxly0wNHbE8Glb/xpidyw9sYodXrvRVpby8tCP84gwUlEO+0ifm7Rv6R4WZt8
         HI7g==
X-Gm-Message-State: AOUpUlEzfN4jnt6AogDRuXK4uk5IRFHfxgulYc2zTmNOMD7Jlw1C3vsM
        y5cwffuWVUlNR8moRj0Vx1SD0ive
X-Google-Smtp-Source: AA+uWPxrIweNt2qdPGqSXrHGBoK1M7vDMw6a1kVyZ6B4oUvnB7WoKTlunWu8Ywx0WTY5Ey7+dVoUoQ==
X-Received: by 2002:adf:9a0b:: with SMTP id z11-v6mr1778604wrb.47.1533830166618;
        Thu, 09 Aug 2018 08:56:06 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:56:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 7/8] pack-objects: move tree_depth into 'struct packing_data'
Date:   Thu,  9 Aug 2018 17:55:31 +0200
Message-Id: <20180809155532.26151-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
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
index 448ddcbbe4..3c8fe60801 100644
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
2.18.0.555.g17f9c4abba

