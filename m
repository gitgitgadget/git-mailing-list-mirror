Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868C81F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbeHPJJn (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:09:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50869 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbeHPJJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:09:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so3308981wmc.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MlpLkS7aDsPoRCmSr1pjQWa9ZfWaOIvtz1AmOxP6TI=;
        b=oxdVI6qdbCufdBaLTLJKrRfscQbZi3S+jh9gd47W0ol7lyh0nYzLqdtZlib9Iotb+z
         dSCg+q41Nxk/wWHxhWmjBWf5H6cJynk5wXLpxSX8ChwyPFsoPxlR1AiTyX0EbVrVU2DG
         30e8sQibrn1Ny+YQGTdLbzOyFk5Y9RzIaknqUV0mQdUzAWBJDO4XhcNkuMr1xb88fYfa
         moibCEjCKymXQphrjrnCineitJXz2YUqwrn/DcRdbDk1vaIfbZgimcPHTsSYRHcP20xn
         AZR5EFZXUXewVSSCZnggRRCOxkaoDy+y5NvEFu+KqANSWT3wHRahykeq0iFB55LGkT3q
         CMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MlpLkS7aDsPoRCmSr1pjQWa9ZfWaOIvtz1AmOxP6TI=;
        b=nN4Agsav215poGUR+ViXSmOR/zgszkl8MHC202x2LzZGJE8AV6l1kLNVYtzg2QSZDa
         /u46PyDPw/OqnDCgVAqIzUCAs+wwZgKBbfzGW2CgIGWtmGl9WL04nJkkGLrKNoiLDwug
         w4ASM8RY2Onwr07MizRhUqR1DnbRvlYT1r3Sb+yAfefkK1YrqNlHThvJVXzEdDxfgEi3
         C/1T+6p+wZLm6wQxgKzHPIH3RQN1YCRVS/03GLc4gI+CHjQd7wkzgAyyMQ0Z46SWAghT
         zOPOhHIk7CqK3I4kJJWzYGyyV7Q23/dJyyHaZL30Ivb082F/OtbFtQF7cbhC4NV6lOuC
         gMvA==
X-Gm-Message-State: AOUpUlEzD/o2SxUvjnkRxob6FO9zmAKPH6yU2kySCKzd7hfQIrg7sv1g
        xOI3tdbGHY9p2hEHC+YpKSAWHztl
X-Google-Smtp-Source: AA+uWPx7s0o5XWc13+FhZ2dd0kHQHrYQk5qoYR+svwXOVeW94C00f9FYFoGPfksW5xT90M6wR+/TxA==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr14632321wma.85.1534400013009;
        Wed, 15 Aug 2018 23:13:33 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id d8-v6sm22325182wrv.68.2018.08.15.23.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:13:32 -0700 (PDT)
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
Subject: [PATCH v5 2/7] pack-objects: refactor code into compute_layer_order()
Date:   Thu, 16 Aug 2018 08:13:08 +0200
Message-Id: <20180816061313.19298-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.673.gcd86e60100
In-Reply-To: <20180816061313.19298-1-chriscool@tuxfamily.org>
References: <20180816061313.19298-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following commit, as we will use delta islands, we will
have to compute the write order for different layers, not just
for one.

Let's prepare for that by refactoring the code that will be
used to compute the write order for a given layer into a new
compute_layer_order() function.

This will make it easier to see and understand what the
following changes are doing.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 90 +++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80c880e9ad..efe62f8ebd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -672,48 +672,15 @@ static void add_family_to_write_order(struct object_entry **wo,
 	add_descendants_to_write_order(wo, endp, root);
 }
 
-static struct object_entry **compute_write_order(void)
+static void compute_layer_order(struct object_entry **wo, unsigned int *wo_end)
 {
-	unsigned int i, wo_end, last_untagged;
-
-	struct object_entry **wo;
+	unsigned int i, last_untagged;
 	struct object_entry *objects = to_pack.objects;
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
-		objects[i].tagged = 0;
-		objects[i].filled = 0;
-		SET_DELTA_CHILD(&objects[i], NULL);
-		SET_DELTA_SIBLING(&objects[i], NULL);
-	}
-
-	/*
-	 * Fully connect delta_child/delta_sibling network.
-	 * Make sure delta_sibling is sorted in the original
-	 * recency order.
-	 */
-	for (i = to_pack.nr_objects; i > 0;) {
-		struct object_entry *e = &objects[--i];
-		if (!DELTA(e))
-			continue;
-		/* Mark me as the first child */
-		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
-		SET_DELTA_CHILD(DELTA(e), e);
-	}
-
-	/*
-	 * Mark objects that are at the tip of tags.
-	 */
-	for_each_tag_ref(mark_tagged, NULL);
-
-	/*
-	 * Give the objects in the original recency order until
-	 * we see a tagged tip.
-	 */
-	ALLOC_ARRAY(wo, to_pack.nr_objects);
-	for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
 			break;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 	last_untagged = i;
 
@@ -722,7 +689,7 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
-			add_to_write_order(wo, &wo_end, &objects[i]);
+			add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -732,7 +699,7 @@ static struct object_entry **compute_write_order(void)
 		if (oe_type(&objects[i]) != OBJ_COMMIT &&
 		    oe_type(&objects[i]) != OBJ_TAG)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -741,7 +708,7 @@ static struct object_entry **compute_write_order(void)
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -749,8 +716,51 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (!objects[i].filled)
-			add_family_to_write_order(wo, &wo_end, &objects[i]);
+			add_family_to_write_order(wo, wo_end, &objects[i]);
 	}
+}
+
+static struct object_entry **compute_write_order(void)
+{
+	unsigned int i, wo_end;
+
+	struct object_entry **wo;
+	struct object_entry *objects = to_pack.objects;
+
+	for (i = 0; i < to_pack.nr_objects; i++) {
+		objects[i].tagged = 0;
+		objects[i].filled = 0;
+		SET_DELTA_CHILD(&objects[i], NULL);
+		SET_DELTA_SIBLING(&objects[i], NULL);
+	}
+
+	/*
+	 * Fully connect delta_child/delta_sibling network.
+	 * Make sure delta_sibling is sorted in the original
+	 * recency order.
+	 */
+	for (i = to_pack.nr_objects; i > 0;) {
+		struct object_entry *e = &objects[--i];
+		if (!DELTA(e))
+			continue;
+		/* Mark me as the first child */
+		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
+		SET_DELTA_CHILD(DELTA(e), e);
+	}
+
+	/*
+	 * Mark objects that are at the tip of tags.
+	 */
+	for_each_tag_ref(mark_tagged, NULL);
+
+	/*
+	 * Give the objects in the original recency order until
+	 * we see a tagged tip.
+	 */
+	ALLOC_ARRAY(wo, to_pack.nr_objects);
+	wo_end = 0;
+
+	compute_layer_order(wo, &wo_end);
 
 	if (wo_end != to_pack.nr_objects)
 		die(_("ordered %u objects, expected %"PRIu32),
-- 
2.18.0.673.gcd86e60100

