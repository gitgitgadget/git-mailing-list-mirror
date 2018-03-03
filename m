Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23441F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935854AbeCCCrc (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:32 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34357 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935847AbeCCCrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:31 -0500
Received: by mail-pg0-f68.google.com with SMTP id m19so4526404pgn.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5YFrr8Dp/yh391bdrqMC8uPCY2uewtaa/u9D4Azgfc=;
        b=PbPcLwX3krhznYYHl/UMC/ORC11dziVeg9i4qnwvAHdJY1NuueSCV9zx0dHANd9sgM
         wJuFqZC0QU6Wf7sT2/zLLBgv7rUhplktEUh49T7WgTxuayAENKMOm0clGI3cwPi8401/
         NomYgD5s5gN36/JlGs8aH83Wur6zAR7966NWVA53yxvuE/qTDZyBABfEvhyzqoBBcUB+
         AbyAtsjTCwSknDiS2uwJTbOlWQOPrGZHdnwbwgP7l64w0l88kOwvH8UZPEQ/GkcuVZiG
         UuWMkxR8Yu7eq3T8P2yUGoUSFEvr9vW9G7HNjgPcNHsaRk84IPHmXX7yATEDqvwGsh/d
         q+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5YFrr8Dp/yh391bdrqMC8uPCY2uewtaa/u9D4Azgfc=;
        b=LqCmRLoyrLFPqmh/dud9ImzaVRa/cJb5T1BahefpiuyzU5sRnWt05c+5IDdo5O3fyg
         TcCkdZLYK6W3LRvDfODzc9K9HhlFfgUl0PtWWHkMxPLNbozealBMerHFQc3MEvRux33a
         OSZIhx2Stf4sn6dezZmQevZTMtpTvO9CTu1nbSWolDkVIF9Wy1ju19Twzc3Vs7qzYMw4
         yLeIqbnpt9nnHa2envmLXtsyimeAc5shjfDxt0pkYMIhzlfoJyeRaQ/FKnBTN31Ky0RS
         rwaH2YNvN7E82gydRi/ld3oTByvF/OnVQV7zOF/eNy12LSU0cLc+enoS/3fRjRKL/hT/
         /Tzg==
X-Gm-Message-State: APf1xPAR4VH0bswPQveMMQeSHAiBi4v/IMdmvzAKYAGdH/ZOU41cRCjA
        cKDVb8E5UKzMgD/CZJ+uzfRkzQ==
X-Google-Smtp-Source: AG47ELtSZ3ia9L/gNj4LaLE5JqBl5BpRL3PIO8/GVDnWXzXQRvaYiBvNLOkXeZyDhP4u2azfMfjiSQ==
X-Received: by 10.99.110.137 with SMTP id j131mr6166925pgc.85.1520045250423;
        Fri, 02 Mar 2018 18:47:30 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w10sm11320159pgr.57.2018.03.02.18.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 3/9] pack-objects: use bitfield for object_entry::dfs_state
Date:   Sat,  3 Mar 2018 09:47:00 +0700
Message-Id: <20180303024706.31465-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
References: <20180301091052.32267-1-pclouds@gmail.com>
 <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 +++
 pack-objects.h         | 33 ++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fd217cb51f..a4dbb40824 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3049,6 +3049,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
+		die("BUG: too many dfs states, increase OE_DFS_STATE_BITS");
+
 	check_replace_refs = 0;
 
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/pack-objects.h b/pack-objects.h
index f8b06e2521..6a85cc60c9 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,21 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#define OE_DFS_STATE_BITS 2
+
+/*
+ * State flags for depth-first search used for analyzing delta cycles.
+ *
+ * The depth is measured in delta-links to the base (so if A is a delta
+ * against B, then A has a depth of 1, and B a depth of 0).
+ */
+enum dfs_state {
+	DFS_NONE = 0,
+	DFS_ACTIVE,
+	DFS_DONE,
+	DFS_NUM_STATES
+};
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
@@ -27,21 +42,13 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned dfs_state:OE_DFS_STATE_BITS;
+
+	/* XXX 20 bits hole, try to pack */
 
-	/* XXX 22 bits hole, try to pack */
-	/*
-	 * State flags for depth-first search used for analyzing delta cycles.
-	 *
-	 * The depth is measured in delta-links to the base (so if A is a delta
-	 * against B, then A has a depth of 1, and B a depth of 0).
-	 */
-	enum {
-		DFS_NONE = 0,
-		DFS_ACTIVE,
-		DFS_DONE
-	} dfs_state;
 	int depth;
-	/* size: 128, padding: 4 */
+
+	/* size: 120 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

