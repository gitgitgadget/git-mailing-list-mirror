Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2671F404
	for <e@80x24.org>; Sun, 12 Aug 2018 05:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeHLHtE (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:49:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53233 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeHLHtD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:49:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so5587640wmh.2
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 22:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9hQvqs2CeadidUSlU6NmQsr7NFAdiwyh5NOsnmhlyo=;
        b=YEtbh3DRg+/NpmCbxEKfd2UxCt2WROp63FHJjEAjhaUCCj0YSc8RcSkJzo2+RAGmIk
         r5+zurdHvibdPHgU4SMIppEUnQ7CDxZvkrBPJABzo8nZ5VTVPAfMCsAa++kshagMWdi4
         lZE2HfFqv8evdutkn+R7/nR6Pmaa/Hh8UJ5FNKbIZlgIp67pVyDf2dRxcHv/EKmRbnW8
         PQKrLeYqWrmtyo+cEjbdP3CjR8P0upsImzmja14H9MdNx9v330sPh6buMvKTgZFzXQJZ
         b1TSQ0qDcG3c/oTpzU4cmE94IL6QNV/QQ0Wvpuw1q5RMLzU1EAl1s360GrAsocjcYJwe
         JN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9hQvqs2CeadidUSlU6NmQsr7NFAdiwyh5NOsnmhlyo=;
        b=Y4bcq4Xw1hDh00j7KkcHrHTpIrm+Vvk8U2i30U4D7mphFuJGMIn78MECylvZI7kB65
         UKUv3JF/tYlHUl8hmHtWQ333x2JBHSxlKm/a5oZEMa6QSvu1dESozQB+z0AVh0qdMxCq
         MQ9iyFvFeUWfOb7jmYU/90x4CNLwcY6K9R0BjnWgwM8Z0zu2FcNgA6wvwSQ9yK7+zL/y
         NTGmJR3OssDm0kjkYkAaDtfrUQYvmRmj6zYWTxO5GwmB5UmYbHP4tEtqiVDgaeajFXVk
         mkOMNkiBtbBKltgAtpobUWHPPLO/QQE3EWDAFxysfpdbCZ7uOcPK0AvR1gNp2YIO8/Zf
         zRcw==
X-Gm-Message-State: AOUpUlHjEOwop9EW42/jDucC7sDDw4RrvcK47Y346AtSPOTgyNj4eQMi
        IDHjV2gVbNBWivkHvhRaiep1Mc98
X-Google-Smtp-Source: AA+uWPz4srMCXdqhrjXA273bGxbYgOk/Gb/6pFfr1oiQwkfTab99ylHqnNXK2s2vaMy3GrOutdT34w==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr5151961wmh.112.1534050740484;
        Sat, 11 Aug 2018 22:12:20 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13281205wrv.90.2018.08.11.22.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 22:12:19 -0700 (PDT)
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
Subject: [PATCH v4 7/7] pack-objects: move 'layer' into 'struct packing_data'
Date:   Sun, 12 Aug 2018 07:11:51 +0200
Message-Id: <20180812051151.6425-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.554.gdb07901040.dirty
In-Reply-To: <20180812051151.6425-1-chriscool@tuxfamily.org>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduces the size of 'struct object_entry' from 88 bytes
to 80 and therefore makes packing objects more efficient.

For example on a Linux repo with 12M objects,
`git pack-objects --all` needs extra 96MB memory even if the
layer feature is not used.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c |  4 ++--
 delta-islands.c        |  4 ++--
 pack-objects.c         |  6 ++++++
 pack-objects.h         | 20 ++++++++++++++++++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fd3e514b31..d5d91eeed5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -611,7 +611,7 @@ static inline void add_to_write_order(struct object_entry **wo,
 			       unsigned int *endp,
 			       struct object_entry *e)
 {
-	if (e->filled || e->layer != write_layer)
+	if (e->filled || oe_layer(&to_pack, e) != write_layer)
 		return;
 	wo[(*endp)++] = e;
 	e->filled = 1;
@@ -714,7 +714,7 @@ static void compute_layer_order(struct object_entry **wo, unsigned int *wo_end)
 	 * Finally all the rest in really tight order
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (!objects[i].filled && objects[i].layer == write_layer)
+		if (!objects[i].filled && oe_layer(&to_pack, &objects[i]) == write_layer)
 			add_family_to_write_order(wo, wo_end, &objects[i]);
 	}
 }
diff --git a/delta-islands.c b/delta-islands.c
index 14d34e16cb..2ced34d99c 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -488,13 +488,13 @@ int compute_pack_layers(struct packing_data *to_pack)
 		struct object_entry *entry = &to_pack->objects[i];
 		khiter_t pos = kh_get_sha1(island_marks, entry->idx.oid.hash);
 
-		entry->layer = 1;
+		oe_set_layer(to_pack, entry, 1);
 
 		if (pos < kh_end(island_marks)) {
 			struct island_bitmap *bitmap = kh_value(island_marks, pos);
 
 			if (island_bitmap_get(bitmap, island_counter_core))
-				entry->layer = 0;
+				oe_set_layer(to_pack, entry, 0);
 		}
 	}
 
diff --git a/pack-objects.c b/pack-objects.c
index 30314572e6..98389460c2 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -163,6 +163,9 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (pdata->tree_depth)
 			REALLOC_ARRAY(pdata->tree_depth, pdata->nr_alloc);
+
+		if (pdata->layer)
+			REALLOC_ARRAY(pdata->layer, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -181,5 +184,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	if (pdata->tree_depth)
 		pdata->tree_depth[pdata->nr_objects - 1] = 0;
 
+	if (pdata->layer)
+		pdata->layer[pdata->nr_objects - 1] = 0;
+
 	return new_entry;
 }
diff --git a/pack-objects.h b/pack-objects.h
index 3cb5527eeb..ad3c208764 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -101,8 +101,6 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 
-	unsigned char layer;
-
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
@@ -147,6 +145,7 @@ struct packing_data {
 
 	/* delta islands */
 	unsigned int *tree_depth;
+	unsigned char *layer;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
@@ -369,4 +368,21 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
+static inline unsigned char oe_layer(struct packing_data *pack,
+				     struct object_entry *e)
+{
+	if (!pack->layer)
+		return 0;
+	return pack->layer[e - pack->objects];
+}
+
+static inline void oe_set_layer(struct packing_data *pack,
+				struct object_entry *e,
+				unsigned char layer)
+{
+	if (!pack->layer)
+		ALLOC_ARRAY(pack->layer, pack->nr_objects);
+	pack->layer[e - pack->objects] = layer;
+}
+
 #endif
-- 
2.18.0.554.gdb07901040.dirty

