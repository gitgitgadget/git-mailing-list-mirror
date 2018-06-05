Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371D31F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeFEPoB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:44:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33430 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeFEPnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id y20-v6so4361923lfy.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=pEmlr7CSPsgpbsxkk3X6V200futqZ3y0x9aVBNldVdY97HT1kWl2BcglfvF3TioCfH
         Idl+f8Fb2nRQ5Uz2pC38q72eshuamPDy02SlABO7nqYYHBVWH4F4N64SAC7Djw/E6mTC
         Ep0wgqJ/YXPCif84dvcI6uKtl6qrj8X/pGocamwFo9rBdh4fC6IIx1InGYTJLqYSQgtd
         MhpAoJDVz0xO9Czic1zYBL/RIpBrc7z/PFxWUYGbJbCtwuFsuCwAmIAxrjDWd6nt4TQP
         DyHrbcHTi9/psMGJtx80Vik7E/wzOoFR3tgQ9WwPb4y2D/SFAFs3lFw3fH9sgNisGmP1
         j1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=II+1tHQSrqzwMjUWul/lsxKcGX9uDUnHDD6oG6nEJUMrbnCtGNufh20e/dXSIr+iAQ
         Z+J54Q1UmkQWUEBqylTScXQFVTNZ+7TrJGcUuxpijHaPL+DPIFBH5i5ccIl2fschUSNq
         SSg0KLwfdBUv5WmXqckhc486A3WAsPUBsdtZibsB60YWnGOwtVRH/2DPAOB12Yw9MIcW
         QWjnURb71w4ogi9/uB8sL28jsbpjZ/fJZgQRHMK66jC0yR5+C01U0MqKOHtGV5nLL01R
         aUzkTaHM4DEw4LaFXgSnMimTgdd/g5gj7wWVecc7LZXsa70pS7M/Pv2HSlV5OrfXBTH0
         tyVg==
X-Gm-Message-State: APt69E1SzNdnpGz3wN0gv+rf2W+MQ2yqABHlRoRE77qcBna89KskUvYo
        N/L3Xea/lyzF2V3W93My7MWb+Q==
X-Google-Smtp-Source: ADUXVKJxgZYXrdSObAlnM42tjWF+yQPP01QvTiKKI2YUbHnRyd12vmpXLWTRvwdlPrxspDfc+tuGfA==
X-Received: by 2002:a19:5943:: with SMTP id n64-v6mr1932841lfb.107.1528213422179;
        Tue, 05 Jun 2018 08:43:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/6] unpack-trees: add a note about path invalidation
Date:   Tue,  5 Jun 2018 17:43:30 +0200
Message-Id: <20180605154334.22613-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..5d06aa9c98 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1545,6 +1545,17 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
 
+/*
+ * TODO: We should actually invalidate o->result, not src_index [1].
+ * But since cache tree and untracked cache both are not copied to
+ * o->result until unpacking is complete, we invalidate them on
+ * src_index instead with the assumption that they will be copied to
+ * dst_index at the end.
+ *
+ * [1] src_index->cache_tree is also used in unpack_callback() so if
+ * we invalidate o->result, we need to update it to use
+ * o->result.cache_tree as well.
+ */
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-- 
2.18.0.rc0.333.g22e6ee6cdf

