Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95721F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965147AbeCCCrm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:42 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37956 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965062AbeCCCrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:41 -0500
Received: by mail-pf0-f195.google.com with SMTP id d26so4780927pfn.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYWJD91DWKJEft6YA1Qv7g27FZBZAQie66BHxu8eboQ=;
        b=ZNGEo8CG8EOdgtzAs0mN/7u09ZvLx+tjn+7FAlVtsC7Hpu1TaPTG3uxh+2TsmKct1n
         SkNwpj3MUXZ/o8tjUVeYpOcPnZJiRICd4hwimLYeCQUcgFE/gEeP5rxwNpBw1y0z3lld
         m/+cZHj8CEwA1696ubkFEM7sKgRIl74aozEblvSaki5AHfmg0sKxmDt3dikg3tNpcNMq
         ZXyNvLiU6MWqByHEU90JekBGCxa88cDcYu6a/rzV452iI9kuC0ct5/AK4AMwLx+7Bqy/
         0KHy+cC92BNFUBNCeKbxPvUK8Ai0Q5v/z0x60bl9q+B4o4guchJayLHB7UipogqlcK5R
         5wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYWJD91DWKJEft6YA1Qv7g27FZBZAQie66BHxu8eboQ=;
        b=noTXVEZ8yXCZpQihRxUH+M1icXseFckbrM1awRENm0Er7ALwnWHktm5Qc8dsi6QC7H
         9BXn09gcB7o5NvFO5nh54CBFPKVmNMsi4XMYCXrgx5ZDTifekCOPKziEO3FietkuEXFH
         O+9CU7+Qkl9e1+zbcMwEuORIeIVF0bOule5GUopvdxXR4kVxDidNPLHNwqns39tav86M
         VqKPflqRzR87tjDKr8w3WVhJfmhLkDF65PcBduVOOP3XA1x7fDpDWv1vGxXaT/H4Hyrn
         iXS3/PcVeqEKzqx0CaBTkT4ItFoG6PwOFV5J8Q4oNHL1HpSTvTolR6Fo4AGR4Jy7OcQr
         bOZQ==
X-Gm-Message-State: APf1xPAj1lqiZMqTq8IccRx57YxXjzAlRESCk9Of+RgXFyMGevm+24L0
        t/msZXLYWOJJNug3OuEuDIuuww==
X-Google-Smtp-Source: AG47ELtY+7m1DmTliWjjSGhss6yvslFextQ1R17Y+bbd8oma8N0Yhw4DDUCVcRs0MGNaFKaDWFjoIw==
X-Received: by 10.98.242.6 with SMTP id m6mr7580228pfh.230.1520045260705;
        Fri, 02 Mar 2018 18:47:40 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t63sm16385863pfj.44.2018.03.02.18.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 5/9] pack-objects: note about in_pack_header_size
Date:   Sat,  3 Mar 2018 09:47:02 +0700
Message-Id: <20180303024706.31465-6-pclouds@gmail.com>
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
index 2050a05a0b..fb2a3c8f48 100644
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

