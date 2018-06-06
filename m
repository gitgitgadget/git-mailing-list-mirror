Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7201F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933548AbeFFQuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:50:37 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:43291 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933524AbeFFQue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:50:34 -0400
Received: by mail-lf0-f54.google.com with SMTP id n15-v6so10152967lfn.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=WR/74qGQbAlTZuBVsTcn2oNcnN6aNKWq9KRX4s7yMPgm0T7DaqGNZHlWwWxgWMZbAW
         EI/MyWKGBgij9h2Q58Zv1cGP+n8km4XcVCvDJuzKdBP/PgAJc3FjLcscgEB28A5ISNCc
         TK2euYMqh3YBYMxpt7pdBL9fhEJUxQMKTe+V3ThLdQ2IeqcQOJpTvmFC79IS5O89362s
         6G9QXmHEUqqFxnT3P0ZCrkwGq2nlr+u89w5D/aie/MWaFgVRafAFY8eLWgLUcP7oghOc
         YMfwQK42BxZ9Z3UlGslYEPvd4bo8mzONvabvGVII93C4aBzhuRRI7ghF1xy4ckSuOgfb
         TH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=GQjrsBkJxWa/xSTD5wF3bRQgvsfmV/m6u3USnSYfg/EqXEiCNHlCHBZB8vaG3jvs8X
         tokOZ068hCNZFNdrSot1xZpZxUyvPHNgbEM/XhoaQPM2Lcx9kSDGg/iKQUa6W4+RBpmL
         VhKlL3xigCWu9VNLSw2BYgJkFtr4IcyXZDJK4VV6/+FL6TSdR/SF6u6WpjBm46pUwI1W
         kgtJRfR7XnQIvagZ3BuivwRVXA7ImPPNBZ8QisilnqnWmxjM10IeI+cMGTD6jEg3vOv/
         POOXHKyRdR6cQTxW9gPO0olv5X2lFI+C9vCUSDehrcxWHJDk4qlmdqCHsSUX6VXm2d59
         2i0w==
X-Gm-Message-State: APt69E1iUwR31ILHlWPfoEeoiORZ2Xmk8rTSGR4XiNq78j6p3fJygfDF
        eBTt0VHw3IJ/8+AvJeMRAFw=
X-Google-Smtp-Source: ADUXVKKhfJtEGI+rsqZTnroNg3Sr5OhS6fKx5CBYahH1+Jo0hNLn2gUCK6PVV746G2u48Y/y2WnZvA==
X-Received: by 2002:a19:1003:: with SMTP id f3-v6mr2480636lfi.114.1528303833632;
        Wed, 06 Jun 2018 09:50:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y6-v6sm909489ljc.67.2018.06.06.09.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:50:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 01/23] unpack-trees: remove 'extern' on function declaration
Date:   Wed,  6 Jun 2018 18:49:54 +0200
Message-Id: <20180606165016.3285-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com>
 <20180606165016.3285-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..534358fcc5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -82,8 +82,8 @@ struct unpack_trees_options {
 	struct exclude_list *el; /* for internal use */
 };
 
-extern int unpack_trees(unsigned n, struct tree_desc *t,
-		struct unpack_trees_options *options);
+int unpack_trees(unsigned n, struct tree_desc *t,
+		 struct unpack_trees_options *options);
 
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
-- 
2.18.0.rc0.333.g22e6ee6cdf

