Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0551F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbeHMS6Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:25 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:35399 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbeHMS6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:23 -0400
Received: by mail-lj1-f170.google.com with SMTP id p10-v6so13059107ljg.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+mv8qq5AK8S2xqHNjQxmmnxJVxjv6EoMcP6j9hrSMg=;
        b=dTp1vJHbwgVcyu19P9HGXSuKHURiZhbR4i3wDJFCsxaQvaWa49agEtw+up6qDwrlnn
         Kz5FEFpPWVSrpqIqoBkn9KcSb99uvdNNzUl4Wab8duSI2xmenf/YYilImTswbM6IWMYs
         2XUltXjh8EJ6FCPDtLwZWD4YzbDslUHI9jAZ6Jco/WdsEP6MDCtBPWD+KuVhjKf1f+gN
         4LcV+ltwkasy3Bw1gDWyyd05x8R/ofqIzGLCRXlcya2jJQDwURJ6g3Qb0mwjL/PXm+Zz
         FF0gvxEtfMD6o6URjzmIbMgW5Voopi9LOqkR6wGX+BES4e2DXYz8E1SafOyrJMfIn/8X
         dKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+mv8qq5AK8S2xqHNjQxmmnxJVxjv6EoMcP6j9hrSMg=;
        b=IBi11wt9JRCMhw/URkv8vS2+31S1LAUppYy0zK6mFAVuatiy2x805JbuXT8jHAhRUe
         Yw4p1gCdmEL2k2ihGw1Ewkbp80E6zq3ijDJVBTwGJcbWkvfazWa05N8QgBwPj7ut58SE
         8b3IekqcfysUNpXgBAuKXnb4VItbjmaHH7XzwyUgTqURCaKy+wwa1HFrRjaDPuzhhhIt
         YmYmVjlweT/nfjr3kXDzyoIFU/dfgcEdSK33EFF7kGPXWNL/8OavU35xpVFZpbSCwuzt
         ENY80FQyOF3rMimuqQUuY7RJSS607x5sU5UP7htPXV/DghOh0IHTlsliESIxpKRwL79g
         oBAw==
X-Gm-Message-State: AOUpUlHTncqzYoRLaC2FjCxF70vh+QN9gCgPHEY57TqWYExRmO2UyJNF
        3emxbpKKXh3PjyKD+T2l2+sMQAW/
X-Google-Smtp-Source: AA+uWPwXm4iGH2Yg4QlYbxhMZ0MlemtcppBAKDrCEL5GznQPWv/iCliWww85k36gzQ8+6lDoCpZwIg==
X-Received: by 2002:a2e:5f89:: with SMTP id x9-v6mr12323027lje.16.1534176928119;
        Mon, 13 Aug 2018 09:15:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/24] unpack-trees: remove 'extern' on function declaration
Date:   Mon, 13 Aug 2018 18:14:25 +0200
Message-Id: <20180813161441.16824-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
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
2.18.0.1004.g6639190530

