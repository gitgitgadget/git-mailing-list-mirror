Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36AAB1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeDNPgC (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:36:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43524 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeDNPfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so16386786lfa.10
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8AMJ+fH/zW8/4NXH7o5Wv9ZpBBhPvylVUR69xS6IU4=;
        b=NiiXsISEYOXBoIU/Uw9kHrOk4w78WVMcJkZhHZOqrM5jklQDTEnHgIveo014wy9CTg
         4CwVyzhUoU7GEhMn1Gat0Gb+leZxBTPHg2WE/MDunIXDOJngE1Ha+RG/ZcPfW+GBySsL
         MUsieRfjwL4C0yydloQNHapNj6Z3wW+vPI5e5fec3MtzcEKDR/MW6KtDi+X7ivrCqG7g
         HzlGRGZBwc+IWC5KU/dyN/8DeqGI422TlZw39cCOet8XPxKjP9Wk90BZ8Tn2+BtmAp1C
         MGOtCAdX0GmOuIaasrFvwkLiED74UlBpk/qI6P6GS7b6QlucFodYLw6YtUmNPxr0g42W
         3yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8AMJ+fH/zW8/4NXH7o5Wv9ZpBBhPvylVUR69xS6IU4=;
        b=AYRBfJ44H41BulFCVhEUmXTgQP1socrTd6ZoYtXSWh/AQiCdnz8qzwWFmXqX2ilbVg
         PpcgdoPaDD1wtWVmFvY7Texf0TtFTnYjQ3D1wkX9NwcQ9l49F8kjWKN6j0GwaJO2Si74
         yqa+A9J/6sdDevtjtuBtnc/c2EprMb0Ol2Bn1Y2MpiHES/fQN6hdOEMbPGsUv8GD/ceP
         4c5sIo8T8lGgB2Pnz1ZuM+VnCbvAjssreLrGuyfJBgjUQpTZgqlC522OVVPfhTii3VuW
         UT6a2ZaTUV0hwOZ/zZt+fSeD4jESOQPxVtdOvGTBDfeU5FmhSCdXIUphb/FKQc4kGcue
         DINw==
X-Gm-Message-State: ALQs6tASiv22X8WyMijFWAV3i4C6gAHX6/iqQyW0nKzvDJycUSaemaEB
        MnGhOZHG2xOe9nyOzYyKf/DMgQ==
X-Google-Smtp-Source: AIpwx4/b1ZtxgRLn6FhtvHUj11JNjM3Pvx9iE5QHBsnHMSF6bx8hkbdyZtZlMj0VDynMlP/BuOcMyA==
X-Received: by 10.46.54.20 with SMTP id d20mr3341810lja.114.1523720138334;
        Sat, 14 Apr 2018 08:35:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/15] pack-objects: clarify the use of object_entry::size
Date:   Sat, 14 Apr 2018 17:35:09 +0200
Message-Id: <20180414153513.9902-12-pclouds@gmail.com>
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

While this field most of the time contains the canonical object size,
there is one case it does not: when we have found that the base object
of the delta in question is also to be packed, we will very happily
reuse the delta by copying it over instead of regenerating the new
delta.

"size" in this case will record the delta size, not canonical object
size. Later on in write_reuse_object(), we reconstruct the delta
header and "size" is used for this purpose. When this happens, the
"type" field contains a delta type instead of a canonical type.
Highlight this in the code since it could be tricky to see.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 11 ++++++++---
 pack-objects.h         |  4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e75693176e..779f14a45e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1418,6 +1418,7 @@ static void check_object(struct object_entry *entry)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
+		unsigned long in_pack_size;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1427,7 +1428,7 @@ static void check_object(struct object_entry *entry)
 		 */
 		used = unpack_object_header_buffer(buf, avail,
 						   &type,
-						   &entry->size);
+						   &in_pack_size);
 		if (used == 0)
 			goto give_up;
 
@@ -1444,6 +1445,7 @@ static void check_object(struct object_entry *entry)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
+			entry->size = in_pack_size;
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -1500,6 +1502,7 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
+			entry->size = in_pack_size; /* delta size */
 			SET_DELTA(entry, base_entry);
 			entry->delta_size = entry->size;
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
@@ -1509,13 +1512,15 @@ static void check_object(struct object_entry *entry)
 		}
 
 		if (oe_type(entry)) {
+			off_t delta_pos;
+
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
 			 * object size from the delta header.
 			 */
-			entry->size = get_size_from_delta(p, &w_curs,
-					entry->in_pack_offset + entry->in_pack_header_size);
+			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
+			entry->size = get_size_from_delta(p, &w_curs, delta_pos);
 			if (entry->size == 0)
 				goto give_up;
 			unuse_pack(&w_curs);
diff --git a/pack-objects.h b/pack-objects.h
index 9d0391c173..e4ea6a350c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -32,7 +32,9 @@ enum dfs_state {
  *
  * "size" is the uncompressed object size. Compressed size of the raw
  * data for an object in a pack is not stored anywhere but is computed
- * and made available when reverse .idx is made.
+ * and made available when reverse .idx is made. Note that when a
+ * delta is reused, "size" is the uncompressed _delta_ size, not the
+ * canonical one after the delta has been applied.
  *
  * "hash" contains a path name hash which is used for sorting the
  * delta list and also during delta searching. Once prepare_pack()
-- 
2.17.0.367.g5dd2e386c3

