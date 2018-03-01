Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01ADE1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966792AbeCAJLz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:55 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36795 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966711AbeCAJLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:35 -0500
Received: by mail-pl0-f68.google.com with SMTP id 61-v6so3299190plf.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x61+dwBchPoEYI6RkfVF28so1oUcPKm1qPoqptcTAsw=;
        b=vJ/245cUOb840/9T+Eq8P3TXpTtXYV2iJYS4favW852aE2s9uOwAT7uUmi5j78Qtfh
         WeBD8w110lclmbVCZ5qz9MXNsd2xqJCgdZzAeoPq0gvwK0xz25gZ+qQ5ZtfiIYdwfgDD
         KQ6P/3gZEUKjXKoAhsp7IyGEbjrmLSaiVk3LTdRwXW7pMmDJJTQ53p9xmAx4Q9Qv0DP9
         RZp6VdDzdpTapTpxhVhIpr9NURv4t3hHIrWkc8iF2V0nhbPbmiNmvsL55fgHxWRK1/cW
         AEXKBnda7NhDLVHeOHiZ3pLSbONBzlejXthkn8FaRhIM4IY8ObE+TvEcxzwl5eSHunZg
         4i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x61+dwBchPoEYI6RkfVF28so1oUcPKm1qPoqptcTAsw=;
        b=bz1yBWRII9lddn9HupHP6+OUvKcxX6ryiA0eTqRamXKB3/fmTv9fUcr5LElyOZ6vVc
         KD1/o7yHu0R5RJIdDLasIF1ObsWWU5hgKBTgEMuUfV3Pv3T42dvS3ES1tYdAKSkA8WgR
         65y9eulP6DwyyxvwlvdHLwOZ5KD2C3w27Bt8eMyyHhtjkKNfAIFfGxIdGuwUvI8zGZ5k
         fbvoFsSrvdptS8xSqJjZYP7R/betZHZxgGjw3aixMzGfL/V3X7q20vLYH8vj5jal6y29
         D4yWhT2+QojIKY+eyz2HuSlMNA0JzGFeKYbMTIwZgAuBUydl70V7L7QRt9QQbDzpsnum
         mhYw==
X-Gm-Message-State: APf1xPD0LEnSF3Lx8+6Zv1plHm8M5Ow6CjM0sibr/5DuVRKemyhJYxIN
        Lxv/Fy2yQmGOAs8Y9TMQ5tGvwQ==
X-Google-Smtp-Source: AG47ELsGfKMjE8IiB9FBb4kpWTq7EuMCHBrudSiA1RhrCzDEAws1zFaSp3whnvjIWBO5teayX8XRfA==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr1260597pls.68.1519895494626;
        Thu, 01 Mar 2018 01:11:34 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 191sm7334317pfv.167.2018.03.01.01.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/11] pack-objects: note about in_pack_header_size
Date:   Thu,  1 Mar 2018 16:10:46 +0700
Message-Id: <20180301091052.32267-6-pclouds@gmail.com>
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

Object header in a pack is packed really tight (see
pack-format.txt). Even with 8 bytes length, we need 9-10 bytes most,
plus a hash (20 bytes). Which means this field only needs to store a
number as big as 32 (5 bits).

This is trickier to pack tight though since a new hash algorithm is
coming, the number of bits needed may quickly increase. So leave it
for now.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-objects.h b/pack-objects.h
index 3941e6c9a6..017cc3425f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -32,7 +32,7 @@ struct object_entry {
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
-	unsigned char in_pack_header_size;
+	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
-- 
2.16.1.435.g8f24da2e1a

