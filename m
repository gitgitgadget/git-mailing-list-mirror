Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2BCF1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeDNPfa (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37173 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeDNPf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:29 -0400
Received: by mail-lf0-f67.google.com with SMTP id m200-v6so16389245lfm.4
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGcun7TFC7Nlb4MjZfN59NnCLgnd0QYhtI0Tk0YvSh0=;
        b=goNiIVAfXbIOyFm9BiFVi5MrKxGhb1CQPiF2n3zPLk3TQKSIeVe56dmYP2Xga9NZC8
         yWtea+WYWNLj0gTKq3TZ/U3cAKsYlwNV3BqGJjw4xO7ggAgG/34r+KfdvZMIAgZ03jwN
         HGUmkwPLN2oZoeJ8uPXZKwuHKUr6lqT9fIUxGgCTz6fnCPnK+L6vSMIXs71iBBQmjI4b
         nTS5a/rJFuADI8696NJIL9dxIz4jG/g4z+d41RIWpb8weH8LW++btBNvqAhvrcvdkqC2
         zC9dy8o9k0xoLM4TgzJkglCtQ7qLd68Gp8tjFYF8KUTT+K1qV8jZjA3I6z01jDQ3LF18
         Fa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGcun7TFC7Nlb4MjZfN59NnCLgnd0QYhtI0Tk0YvSh0=;
        b=hrdW07HNSbbOPJkDK94TPBmHvKs04+SmyiljnxpZKCXtGz8F+U0hnrajlfBNFVcD8w
         iu5TKEDEJvip6Si3e2YBZysnAunmZi7jYe5ZiC2UU+BVkaw6YPFMkmZVYHjhVeVDMu4n
         D1+dS8Z15XPRWi0EL9spj55ih8nAqkxJouvhwIa8oQzK2W2AcRNF5UpNjXyF8lgqC5iU
         qir5glvCyLMfECCXDI+bhtRsEeUjwyo2qIvmSnoMyzYSlc5/wldBJDOtJ8g+9Yb9Gx6J
         xQ7M1pvYFnuqMnEONEhi24WfBWSObsujpBOKkqeFBm7cSSkd8NYJs38+VVEmEbdfSD0c
         1n2w==
X-Gm-Message-State: ALQs6tDovrUu9Lh5zISYD47sb5dFX/xC3EQNmgyyCwzqc/lazfLMak18
        IFOwGD2YmWIdfTBSIXAMR/Pf8Q==
X-Google-Smtp-Source: AIpwx4/WrcKaFVhjSyK8Q3JmhgDK2NWqj8IbwMGauPqb5+wCSm9VjhsRNRPNH94dQZY+WBMFYDP/6Q==
X-Received: by 2002:a19:2181:: with SMTP id h123-v6mr2375856lfh.81.1523720127419;
        Sat, 14 Apr 2018 08:35:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/15] pack-objects: a bit of document about struct object_entry
Date:   Sat, 14 Apr 2018 17:35:00 +0200
Message-Id: <20180414153513.9902-3-pclouds@gmail.com>
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
2.17.0.367.g5dd2e386c3

