Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63401F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeDNPfn (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43520 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDNPfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so16386715lfa.10
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2mQIJNeeJ+52dgtitGAqYd9vHnrOUR0gepsRzGG158=;
        b=hGP7U7ogcJw+yxTwynLUJ9TGP5codsGl9jCEJ7MqCcCGYgtO542FbrjZQR+WX2vqd8
         38PY9lsRQdIEM89TEd+iXZ8nbkMIgWwZfSS/xbPWAGoLAlICqQpRhkElBiR/Rj/+T9ZT
         Uz/bek68llxNpZES03qPZCRZyTsp5Wx+bqcBdRr6klmg/aNnCdu7y0fXhLBIcJb1CVXo
         UNWeZcimSeJzZ3V6ScMZtGtRXW09NMS0VKs60KW/q1cEiKwsnAGoravjrdz9H78TfnBa
         fwAQj739DjlurdYywzxeraGqHFC/utBP2GxO6Snj7Dd4uAK6tKbRiHFC/4847+bjrBK4
         iUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2mQIJNeeJ+52dgtitGAqYd9vHnrOUR0gepsRzGG158=;
        b=KPNNLGfQFeMgyRsxYP2f+S6aaMhJjwI4s26DEeyPqxHPbl/vUdRAiyt7Ue8jF+tmQO
         Shgq/OhvCTR8Ll6MBCeGz1Njh7h16om5Nc0/o6h75YjJAz8ALPg4rCee9eBp7MWZw/Y2
         TrHiq9VgXQ8AOGV7khMRYwp21g0Lh47dzh4FXMZ21xWqQhzDGWyzOxl/J6BAzqH+o89k
         ndekY2H3lPvQ7jMVIm9SnYWkJEBS43PuXiONLU/y1ZdRGTLZhPaytjXCGAXY4B3c/JD1
         quXzYD3S7RdiH0dqcB889ITUNpKawPWvCigfXBIT+FnMb/lEAu1qI3mOZ4LJnYEuskgf
         dv3Q==
X-Gm-Message-State: ALQs6tCtHzqn6EhKSRsf2cRM6Qa3EWH3F6kmfldeOmArcAMkCTn4tSwl
        5tlY1hAc/hSeuM2Q9hudY/Iasw==
X-Google-Smtp-Source: AIpwx4+0ZYR9834f6dt0QUIjRRWwF8t5gcYFXVNNInHdOP99cHsunziMhaJm8FVL5dYtoOzarvr3qw==
X-Received: by 10.46.144.204 with SMTP id o12mr4528406ljg.32.1523720135939;
        Sat, 14 Apr 2018 08:35:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/15] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Sat, 14 Apr 2018 17:35:07 +0200
Message-Id: <20180414153513.9902-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only cache deltas when it's smaller than a certain limit. This limit
defaults to 1000 but save its compressed length in a 64-bit field.
Shrink that field down to 20 bits, so you can only cache 1MB deltas.
Larger deltas must be recomputed at when the pack is written down.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  3 ++-
 builtin/pack-objects.c   | 24 ++++++++++++++++++------
 pack-objects.h           |  3 ++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d97f10722c..a62134264e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2459,7 +2459,8 @@ pack.deltaCacheLimit::
 	The maximum size of a delta, that is cached in
 	linkgit:git-pack-objects[1]. This cache is used to speed up the
 	writing object phase by not having to recompute the final delta
-	result once the best match for all objects is found. Defaults to 1000.
+	result once the best match for all objects is found.
+	Defaults to 1000. Maximum value is 65535.
 
 pack.threads::
 	Specifies the number of threads to spawn when searching for best
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec02641d2e..211bb1ad0e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2099,12 +2099,19 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * between writes at that moment.
 		 */
 		if (entry->delta_data && !pack_to_stdout) {
-			entry->z_delta_size = do_compress(&entry->delta_data,
-							  entry->delta_size);
-			cache_lock();
-			delta_cache_size -= entry->delta_size;
-			delta_cache_size += entry->z_delta_size;
-			cache_unlock();
+			unsigned long size;
+
+			size = do_compress(&entry->delta_data, entry->delta_size);
+			if (size < (1U << OE_Z_DELTA_BITS)) {
+				entry->z_delta_size = size;
+				cache_lock();
+				delta_cache_size -= entry->delta_size;
+				delta_cache_size += entry->z_delta_size;
+				cache_unlock();
+			} else {
+				FREE_AND_NULL(entry->delta_data);
+				entry->z_delta_size = 0;
+			}
 		}
 
 		/* if we made n a delta, and if n is already at max
@@ -3087,6 +3094,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			depth, (1 << OE_DEPTH_BITS) - 1);
 		depth = (1 << OE_DEPTH_BITS) - 1;
 	}
+	if (cache_max_small_delta_size >= (1U << OE_Z_DELTA_BITS)) {
+		warning(_("pack.deltaCacheLimit is too high, forcing %d"),
+			(1U << OE_Z_DELTA_BITS) - 1);
+		cache_max_small_delta_size = (1U << OE_Z_DELTA_BITS) - 1;
+	}
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index e962dce3c0..9d0391c173 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -6,6 +6,7 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		10
+#define OE_Z_DELTA_BITS		20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -77,7 +78,7 @@ struct object_entry {
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
+	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned type_valid:1;
-- 
2.17.0.367.g5dd2e386c3

