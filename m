Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04C71F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeCaKD0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41366 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbeCaKDY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id o102-v6so15110342lfg.8
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8I7dO5ynV/1Oo3CYh8EB8ltaEfjmpgnWyZsA/paPEE=;
        b=oHjEIm2fNXWE2V9LMnE/3LlCYdhjAJE1fbtuLmBiZT0aywfIadu9Gd94bXYs5ZhRVK
         HgLFS4QYRWmfZFjt0hBH1v5ctNx9oz9jR/JI3b4UlryBee5QkJJgjkKWNr7ZCoxdKlZk
         MRgdZRPJOVAC1QfWiNQ/T6sU9VCYlhoXhLXT6q6A/snZlD4Lnhc8z1XpbfTNgFbQzqMB
         KM5HhGykW+uYxL5iDhubB1GXSTPZV8vBw88RPePqQbpfWmF1thiK93tPWQIqJMM+8xX/
         yx7z7pCefRD2m99mbTxR3aTYcmEsUHN1NatLuAhrPKfv7ntwcrb9hatp8J1nX/uC8bCo
         HNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8I7dO5ynV/1Oo3CYh8EB8ltaEfjmpgnWyZsA/paPEE=;
        b=KTqIb5JwRe3UHUTQITmgwslPcFrTj2vqdIgFmjlIjXB+vHel+BF80xrhOImxtxzo7c
         SU7HTjubx2ymlzWjJalLzLYuRVR0Y00dK8PZfzod1lLEuaCVVjMZrrXKAokABHFg32KM
         Xe7ibZrQ4mP+YimzZFixf953RhsWAloQtpL+JqT1GJ/c7VawVoo+w1KdwGp9tJfQn/ko
         dxBBjagl0044qvz/gr4APk/Zd65bJ8UTRTPD0w7TUKBZdKT/wSaNFiblRCbkzaqXcoFh
         RFkZcfRpENTZ+/mvyBKuZxi7fzoXjUHdHUND7ulv/yxOsaQCnb4dgGQoeg7AMeYV/OVG
         pmWA==
X-Gm-Message-State: AElRT7EGMIiKHSgJMHSZiBJj60n4jCIjruRqwXvt/nhdv4nfkbxWxKFQ
        tyKsgsTW4IpCxQshcqNh+Bs=
X-Google-Smtp-Source: AIpwx4/Are4UOoMuVPItr3H62SL8BUToDirXC/QgnGDGGGkKzxHe3CuRreCxCrs8MVic5wbAPa34Xg==
X-Received: by 10.46.133.217 with SMTP id h25mr1382507ljj.109.1522490603053;
        Sat, 31 Mar 2018 03:03:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 02/15] pack-objects: a bit of document about struct object_entry
Date:   Sat, 31 Mar 2018 12:02:58 +0200
Message-Id: <20180331100311.32373-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
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
2.17.0.rc2.515.g4feb9b7923

