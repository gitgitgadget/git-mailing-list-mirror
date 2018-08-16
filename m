Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18DD1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbeHPJJw (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:09:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbeHPJJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:09:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so3041538wrr.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehXrhBp7BUbEjZj1HXe+R9s0Xa6SCJxiNpkWkYcQ8/M=;
        b=N2euqxM2XQ4XX+NXSrvBr8/WWIPKB15coCiZ/CpAWvHacLeVSJXwBFDTb/8Yw2Nm1T
         M3hmYYYLHadHop6zJnllzrS5E5dPJIers3zGuL9vhqoxu3I4D0K/Li4YbtDe2FEN94ef
         eQks4a4Jg2SK3mjCbBCZWgcWD//4wozRj/ICQeT2Z7riKLlIWmHYsXKY+msLvkOhlM9c
         m5NM9Dyav5QyF3lao+y3SoIsOqxErFhubgB54CW6aouF1jBaNcld+KT/Kvd+ycKK9Nr1
         nL2TUWHrZLdrMy3Xga0CM+Vn1FVQVntw8wKtmrbOccs0IPBEndp0woEqUfzLpcJ4IgCT
         IFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehXrhBp7BUbEjZj1HXe+R9s0Xa6SCJxiNpkWkYcQ8/M=;
        b=SZofaTu/Jq/6brZpcjXWtq9eKk/4vEo3i3FaAMtncjhjZJb/JR31NufM+ayJCjFbF8
         VFO7q7sj2feIuQ8G3kNj20YSkHrdQaYrJt8rSSYkfKOlML5fLRs1I8tA9vHFlIZOeVWg
         06mioxkMcQIkENB5CahTgtv1d4/YEPtzqkF9b3v0p5/TtQ4PA4UideQIb0HUrukjTDwg
         5Spt395/hKZp2GKq54BEM/GDiWSF+FSpvx/KcnpeQbaI/Z+aqmyhKUew6q1bSp3WtWXa
         wJfggkxv1J6ZiQMeEFg2Wz51CE6+HFEwRq/WzqdA1ALW5dyN3J5XYl9oJOZdwcHdUUJl
         4+uw==
X-Gm-Message-State: AOUpUlEYbwf5FcvD98E6Coj34DXGzU/nHypfl/2xve5TH4Nxd6l73yJf
        Qfoa4Suk9dvuwVpo9gyNsL4xYyw7
X-Google-Smtp-Source: AA+uWPyCpLJQ8E3imoUVRIuwG22bT76a9m/X7aja4GMuhbn0+Ik4O1Hxbt6ETmRuERuFEnYR7jpNfA==
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr19202754wro.259.1534400020492;
        Wed, 15 Aug 2018 23:13:40 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id d8-v6sm22325182wrv.68.2018.08.15.23.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:13:39 -0700 (PDT)
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
Subject: [PATCH v5 7/7] pack-objects: move 'layer' into 'struct packing_data'
Date:   Thu, 16 Aug 2018 08:13:13 +0200
Message-Id: <20180816061313.19298-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.673.gcd86e60100
In-Reply-To: <20180816061313.19298-1-chriscool@tuxfamily.org>
References: <20180816061313.19298-1-chriscool@tuxfamily.org>
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
index c86d2a9ad1..cc31d27793 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -616,7 +616,7 @@ static inline void add_to_write_order(struct object_entry **wo,
 			       unsigned int *endp,
 			       struct object_entry *e)
 {
-	if (e->filled || e->layer != write_layer)
+	if (e->filled || oe_layer(&to_pack, e) != write_layer)
 		return;
 	wo[(*endp)++] = e;
 	e->filled = 1;
@@ -719,7 +719,7 @@ static void compute_layer_order(struct object_entry **wo, unsigned int *wo_end)
 	 * Finally all the rest in really tight order
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (!objects[i].filled && objects[i].layer == write_layer)
+		if (!objects[i].filled && oe_layer(&to_pack, &objects[i]) == write_layer)
 			add_family_to_write_order(wo, wo_end, &objects[i]);
 	}
 }
diff --git a/delta-islands.c b/delta-islands.c
index b0b9157c85..8e5018e406 100644
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
2.18.0.673.gcd86e60100

