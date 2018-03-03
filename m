Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41DA1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965214AbeCCCsD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:48:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34764 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965205AbeCCCsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:48:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id j20so4782070pfi.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZnKooFho5CYZSIqllcRKZ4Vqk8esl7170GME652mCc=;
        b=dkSBEHa2ksi2eX4af5X7DZaccX547OoOUYk+okL2Hz0dDqAVVdNp22EpaYJoSaDL/3
         8ImkMf7Ha36kcZboN4A8PObXjHiO2+EyTRAB7aYSdRqXzipKIHzAOmxDmvnRue8tGRe6
         8GDBYc0n0iAP3IsulIEvpWPUaBqyMbAX/tteWkEEXAN7Jsc1VVY/BC9uMm4jMmSzvlTb
         mAflUtzP/kYdbx9PmG+Hca0QYEpQZY89ypbzFapkBGOGbbpS3d9p6O0/p6jZFEJK2Se9
         l8SunRWkk7I3AkMZm9OQT2LAGh12IUEu1w93P5PzUIxn5ygMN1z45Zkb/5Tnb/I2vbQc
         sQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZnKooFho5CYZSIqllcRKZ4Vqk8esl7170GME652mCc=;
        b=WCl4Wg7Vti153ZsfnttATuhLvoE6gOKjKKOMfVQkl+8GiOKRGbei60mvQsSbYvQbz5
         7CuOeVN22QRxL9Lmw37lXgnZX+OAOABigdgDAkIElN/TJvLhU99miZwYRIxMR+cWAAVk
         bIduoJKX0gpr5Imtyi1QKcjJ+9NpGmfCJI8sV1Gk7WZA9fsz5LYUBPVnSUf5JdwApIGK
         KOLoLeoB4vlTbO8YMSFKKjys0IAtHYpFL074r8icgjTJ6LwfaaJYRdWEqqMAiY310p5I
         s29t7Jv9mPfmdFefyeQYfcOubwg7ViDyWj7Vekz38+6kPOdK/dD7f9Dz2ACN2WJyoDXI
         eAqQ==
X-Gm-Message-State: APf1xPDRFukSaJ8vTObwKCbYHdxp5eX4ueOfz28Zz6px4MaXa1mnmy8j
        eYpGuxEBXDXnqF/NLO9Z/n1MYw==
X-Google-Smtp-Source: AG47ELtCtQM0E9bYlaJF6xavYI421rCaNvLWm2DTp8Ly8giNGRvYqRVLpT4ugUrEybAJpqkquBVbcw==
X-Received: by 10.99.114.65 with SMTP id c1mr6351822pgn.314.1520045281340;
        Fri, 02 Mar 2018 18:48:01 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s6sm8709672pgn.59.2018.03.02.18.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:48:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 9/9] pack-objects: reorder 'hash' to pack struct object_entry
Date:   Sat,  3 Mar 2018 09:47:06 +0700
Message-Id: <20180303024706.31465-10-pclouds@gmail.com>
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
 pack-objects.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index db50e56223..a57aca5f03 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -38,12 +38,10 @@ struct object_entry {
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	/* XXX 4 bytes hole, try to pack */
-
+	uint32_t hash;			/* name hint hash */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	uint32_t hash;			/* name hint hash */
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
@@ -62,7 +60,7 @@ struct object_entry {
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 104, padding: 4, bit_padding: 18 bits */
+	/* size: 96, bit_padding: 18 bits */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

