Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF8B1FAE5
	for <e@80x24.org>; Sun, 18 Mar 2018 14:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeCROZm (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:25:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43908 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754241AbeCROZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so1990099lfa.10
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKKP7Ef6Rg5tQmP3IpuEDNB4AZOgwmLxzj6vt0oWZhU=;
        b=l8a7cxwZClPJoKwv7L+zlUKsLwv1Gz5oaPjERy2ux95fGbwuBFju3eHLXQIPf8mCY6
         nP2+DkRy/QhZZZLmNJ5pxTLzV7mvJb8pxivQZD9v12GD/XMB+tuS7ptJJ8DsYNaGs8Re
         s1I856AsDis1He/RnKKl9uRFrjdQmmm0Hqy3FA4V2EHf73F6B/KBlkxejEYpDISV6ZoR
         TZbuofZyoCnosGlxrlbIYu1VJVlU1Jy+bofTwdK0d4VqR4nAv001pNbIbxGExaXA/rT6
         cY8o4/Isq4s4XEpZCV2rhcOdVKnFdzLc7Tl26Vc08tty0UpwfSyeza3bQM2CZQ1xIgbh
         3odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKKP7Ef6Rg5tQmP3IpuEDNB4AZOgwmLxzj6vt0oWZhU=;
        b=PsUX1qFjZh+2SaD23WLrzO1ZG5kYRrAM5xwzuunPOrgBfKBbx3hm9AUb1oVsDAqa3D
         dNFAIbLhG+G+O+u/9fHqlSF5GISWpMOBGlwukwFLg2NXqL4DrIxmFILGoXICdHzckmJS
         aNHKQIJyWfypRZH7GJHXh07XPKM6/VabgY+rLHnf2V4V6FuLfVWT0pzr1SlEmzs1OKmx
         EE/hebv/CtLhsJ8XP+DdCcNSzBtcDjphILxQQPMJbTMd383ymGejg4pN26sf8x2l2Z7n
         ym+CgHZ/Eo1MaHA0XKXONuI8aqC/hpO86wjhtA2IbIlLb4bKKXbl/UpRl/6xWuoatmYN
         RoIA==
X-Gm-Message-State: AElRT7GdkfIFiiptvJ8UFo09rL4vuVR44ceYPfqgRAzYxt30lQfoc6EV
        HOXecgdKbVuji5wKV/xK4sg=
X-Google-Smtp-Source: AG47ELsJesd38qgKxEvgauqjz3681WejTnUrFLw8qVdyai0tcnKmE44QNUIh9p6+gJd0RbMSRP7r4g==
X-Received: by 2002:a19:e112:: with SMTP id y18-v6mr5582701lfg.102.1521383139501;
        Sun, 18 Mar 2018 07:25:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 01/11] pack-objects: a bit of document about struct object_entry
Date:   Sun, 18 Mar 2018 15:25:16 +0100
Message-Id: <20180318142526.9378-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
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
index 03f1191659..c0a1f61aac 100644
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

