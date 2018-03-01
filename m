Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0167A1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966803AbeCAJMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:12:19 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33703 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965026AbeCAJMF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:12:05 -0500
Received: by mail-pl0-f66.google.com with SMTP id c11-v6so3309749plo.0
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3Izaw38k5ngZxqrMuytAWl1viVeoiBKrPP7U8mxnD4=;
        b=RDrGYHM2XfEPouGUUpQEgvxYZ99ki5thU4OoUlRYOetT5hwfX9VjZQep8BFJxVdiuQ
         CXzENuZ5mez2EFgaiPfwkVFoVCBwSt+F5c2g290kHdx585ZQRXHnRg0QSmOmDnW5vsWO
         f/m0XJABnkMvA+t0eZu0iyUUJOQi4rQ6wqGfp+e4vUAe+GjVZNvuGTGe3qM3hsfE+hRY
         yFyAjy1gstj2V0ORR3efWUnr9OwGRs1R07OibIm7IPfh0EugDnm31Vn8Oncr6MzrUcEx
         YEFM9jah566Nwe22roTm5BQuvVE4uYEgRl9SctaLaN7nq95lYDHTWvcc8/OT+T9IT4e3
         5uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3Izaw38k5ngZxqrMuytAWl1viVeoiBKrPP7U8mxnD4=;
        b=osTkBpkWZf5vxkMyCkeE8q2INV2jjp/iAmNArb1DrWR7rgtXgMxdyBgdiR/CNmpDNO
         HL+cK7gHjNwU+q5N/BDtsQHT46vKpFX8NmEdscgmPYNmiD7zPBYH1wLEi/H9MyXQOciv
         uirUDLEOYy7Truzh8nelZkJhDWbn2wa6AmFm7WRQVTVPyf+vvOWwDPIK5Um6y+uVkSTM
         h5OL1qsN+CJhyqMrnjMlAe/dKbWzTU77PLF5vxCh12QtdW6PEWeGzjUQX1VFKRWMimU4
         atgltMhJBXzcZ5XkkBjhlAuTYCkZ/AaXc2IhBPplcVsqwziozohi2aZpUvKZdZojufhy
         kHnA==
X-Gm-Message-State: APf1xPAVRXHsj7sIy9TqpMUIUUjz1tJ1D0EINtE4hn12fP64ZXxWs8tq
        WqqdOzK/vjwQqlQBX6MZw1z7Og==
X-Google-Smtp-Source: AG47ELu25nU5Mm4z3FoMspeKaxn5n3b3vpA9Z3nFXfZWJh803ZlXyfjSg3TUCNm5gEiBaOT84gXN8A==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr1289763pll.396.1519895523785;
        Thu, 01 Mar 2018 01:12:03 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id g77sm8176000pfk.135.2018.03.01.01.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:12:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/11] pack-objects: increase pack file limit to 4096
Date:   Thu,  1 Mar 2018 16:10:52 +0700
Message-Id: <20180301091052.32267-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When OE_IN_PACK_BITS was added, we didn't have many bits left to spare
so the max number of packs that pack-objects could handle was limited
to 256. Now we have more spare bits, let's increase it to 4096 to be
on the safe side. If you have more than this many packs, you may need
to reconsider if you're still sane.

Increasing this also increases memory a bit because in_pack[] array in
packing_data is bigger, roughly 32kb, which is insignificant in
pack-objects context.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index 52087b32e5..ec4eba4ee4 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,7 +3,7 @@
 
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
-#define OE_IN_PACK_BITS 8
+#define OE_IN_PACK_BITS 12
 
 #define IN_PACK_POS(to_pack, obj) \
 	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
@@ -24,6 +24,11 @@ enum dfs_state {
 	DFS_NUM_STATES
 };
 
+/*
+ * The size of struct nearly determines pack-objects's memory
+ * consumption. This struct is packed tight for that reason. When you
+ * add or reorder something in this struct, think a bit about this.
+ */
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
@@ -51,7 +56,7 @@ struct object_entry {
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 
-	/* XXX 12 bits hole, try to pack */
+	/* XXX 8 bits hole, try to pack */
 
 	unsigned depth:OE_DEPTH_BITS;
 
-- 
2.16.1.435.g8f24da2e1a

