Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B07B1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeGRQvp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44255 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbeGRQvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id g6-v6so3851460lfb.11
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Haw8whwjgk/gV3yNZjD/4QyMhaN01iu7jfpZUaFm8r4=;
        b=hS4nG1nCRoF2VCc8gRC0HR4CYbV1sbC1BDjG7Nfg5dkQhnUQqBqIO0x2pBkd9sYsBi
         xH+daDZbeRTs2qU5+BlZw0/z0QXY0kDHMIQqgw9cZRwFQw1euKsvdz1J1YgmFcGJmRLH
         H3BuhJZKA1ukHjg7pUjDv0tD6PuB6oB9QlIn7YOAphad47q2gAmSPHT387odatREdk0X
         +z8EuD6d9IkPe3k67hbOrNaKqzhrRrAhO9x7zPTzYJ6W2ZUw8M3cjr4TuTC4bw+xCTLe
         6NXNrcxxOkOvy0v15l+sHHlLqQpu/Jfp51i2WWCsjVdgFZSv2pV/VfJzduCv04nLIL+F
         iAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Haw8whwjgk/gV3yNZjD/4QyMhaN01iu7jfpZUaFm8r4=;
        b=UZss5DJ712+bsM282lCW9PkydOivjmKUyXKjdhDNrPcq5llLwtOiUe/PDzt85o8u5u
         Bdj4IsDrEg5rN3tyLIcYswcvFqHva9/UuL4Mqb3o/xh1M33XSmIMuJ0X9PZkaMvvUcFS
         ePrDJILM6TDlHtxdwZm3mYjWSbqJwZ/3evSFXYg9dH4uJpmH4tzCDHUn11Iiq4SENgua
         CeoMGJiAmtjnTb48RKD4zI+09QEm3uzw2rvu9Gtn0qzjatnQKeKOCo8gxu5c+KjDtmZC
         QwzYFw+o2yUjvNZpmNr23rYjpGwrIt1X5uquSKAA9I8ZFAzTVVaETGy7EV+NVHHRTk1C
         kJBQ==
X-Gm-Message-State: AOUpUlExHucO483CzCelmUtYrw1ctaLimRxu3gnmY9uHBSkgY3GJcp3E
        eXNIJn7OTPI3TBFIx/k1IOo9EQ==
X-Google-Smtp-Source: AAOMgpfazEHQ4MHRZorf8vXA2hwcWA4Vd9wcuFuhNRfxgXWZORTdX4jETbPkaSTpXrOy7HJfh0UvOQ==
X-Received: by 2002:a19:5f11:: with SMTP id t17-v6mr4571641lfb.64.1531930386665;
        Wed, 18 Jul 2018 09:13:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 18/23] refspec.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:56 +0200
Message-Id: <20180718161101.19765-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index c66351743b..f529092fd6 100644
--- a/refspec.c
+++ b/refspec.c
@@ -134,7 +134,7 @@ void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch)
 {
 	if (!refspec_item_init(item, refspec, fetch))
-		die("invalid refspec '%s'", refspec);
+		die(_("invalid refspec '%s'"), refspec);
 }
 
 void refspec_item_clear(struct refspec_item *item)
-- 
2.18.0.rc2.476.g39500d3211

