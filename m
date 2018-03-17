Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A83631FAE5
	for <e@80x24.org>; Sat, 17 Mar 2018 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeCQOKv (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:10:51 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36536 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbeCQOKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:48 -0400
Received: by mail-lf0-f66.google.com with SMTP id z143-v6so13074608lff.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSTC6o7CgKit92Bm6X+gRjmmpcSORJ0AbpTv4pg66bc=;
        b=PmSQP2iXQLHZ2KvvSnGrIR6wlDTDWECNQRAc2sr41hQnYzOeNHgDAZRDOip4h/NT7s
         BSRd0m/MfBUn6LYfiScjeJqqZe2BR4C2ILRF1YVMYNsy4ijfMmxTlsG8TCbBg3f6SATb
         bT29YvgNRWtonvTZjDgLTZrrZwKSsjYD8+YozUaqs+/sZXPxw58c/yywD2N+1ic2LUBW
         MSvjFC5xNFbo4u4UHbAwDDvHAXsD/3E1aGWGoijoK6Ef94evJKOX/rQbZkBBlRP149cl
         hsblvt5oR2YXdO8/uZIxBOmCBU/2sBauOK8szTduTlvkN5npOaKdHIKNuP/y2Wd+e9sn
         /ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSTC6o7CgKit92Bm6X+gRjmmpcSORJ0AbpTv4pg66bc=;
        b=p6UqKq4/d5wyYa4/wxBlq8rE8KM3IrQrd4u7tGdjHwSgd8n2Q+0OQ59dfNFsp1uQBo
         x4TWRtPImGJzvKvVp41cnAjD2lq1PYDAXLsFgJhgTG4gkFvJIJqIAfrct0K7AlYQTxZy
         Del0XVe2hmCH2tWsvevd3p1boEiAyEIK3bG3v9LoPwG3SWIvrVnIQw5OGBhFdwJIg/CC
         hcuU4q2jn5FE4dAZnhcImUpeCbTQ48LiNxmuu3OLaQoI8yBmRgWhZ2bJAtI/O/fmvV85
         KVf4kwBTdIrk8JlJu6S30H3O0jC6thIPt6YwBHx0TEVFHBmfwimn4Y03l/9i24j1kQ84
         l6Rg==
X-Gm-Message-State: AElRT7ERxjAw+s0SI/dPQYO0aHSRL+yldsGENmf50yonzYP5R3WVdLOJ
        hfqm4oZgfPw2xOPj3aTDDHc=
X-Google-Smtp-Source: AG47ELsiwfz78p3gxrmJXAYpCOKzyZt+Wyuku8bxoVU1SC4l6ctDyccE8FX0EFsz5s3FreWNrmcqsQ==
X-Received: by 10.46.69.85 with SMTP id s82mr3747522lja.19.1521295846905;
        Sat, 17 Mar 2018 07:10:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 01/11] pack-objects: a bit of document about struct object_entry
Date:   Sat, 17 Mar 2018 15:10:23 +0100
Message-Id: <20180317141033.21545-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
 <20180317141033.21545-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The role of this comment block becomes more important after we shuffle
fields around to shrink this struct. It will be much harder to see what
field is related to what.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..de91edd264 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,51 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+/*
+ * basic object info
+ * -----------------
+ * idx.oid is filled up before delta searching starts. idx.crc32 is
+ * only valid after the object is written out and will be used for
+ * generating the index. idx.offset will be both gradually set and
+ * used in writing phase (base objects get offset first, then deltas
+ * refer to them)
+ *
+ * "size" is the uncompressed object size. Compressed size of the raw
+ * data for an object in a pack is not stored anywhere but is computed
+ * and made available when reverse .idx is made.
+ *
+ * "hash" contains a path name hash which is used for sorting the
+ * delta list and also during delta searching. Once prepare_pack()
+ * returns it's no longer needed.
+ *
+ * source pack info
+ * ----------------
+ * The (in_pack, in_pack_offset) tuple contains the location of the
+ * object in the source pack. in_pack_header_size allows quickly
+ * skipping the header and going straight to the zlib stream.
+ *
+ * "type" and "in_pack_type" both describe object type. in_pack_type
+ * may contain a delta type, while type is always the canonical type.
+ *
+ * deltas
+ * ------
+ * Delta links (delta, delta_child and delta_sibling) are created to
+ * reflect that delta graph from the source pack then updated or added
+ * during delta searching phase when we find better deltas.
+ *
+ * delta_child and delta_sibling are last needed in
+ * compute_write_order(). "delta" and "delta_size" must remain valid
+ * at object writing phase in case the delta is not cached.
+ *
+ * If a delta is cached in memory and is compressed, delta_data points
+ * to the data and z_delta_size contains the compressed size. If it's
+ * uncompressed [1], z_delta_size must be zero. delta_size is always
+ * the uncompressed size and must be valid even if the delta is not
+ * cached.
+ *
+ * [1] during try_delta phase we don't bother with compressing because
+ * the delta could be quickly replaced with a better one.
+ */
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-- 
2.17.0.rc0.347.gf9cf61673a

