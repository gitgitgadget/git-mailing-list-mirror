Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FCAB211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbeL0Q0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46799 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbeL0QZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so16652026ljh.13
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDenxXQFnfGA6L2wSwxdY5Z9THLD15uqhY3iNilOOXc=;
        b=tGQTTg6kFMYj9Ttb7q4uJQsmRx7Vq3uGon+HEkP4Jq3HxHS3M+9f8tCVGIdL4daw9h
         nTFDOUgVJhbV155xzEoiJm9Xtlk4hR2j8eYxLpSbrDYHgcWe6+XgNHGbJRWeJCa3wdnJ
         t7h3qlE05jtTInSHepG1XTi0XDEC74IDV+m+4ZiDrKVPYV/x+AMwJR4r/pm5GhYTtIbp
         +BaGTbxQEO2FwWM4ZYphqGybz6tqKLLrjm5XBj2FBZTwPC8dm+su94xHsN3/17yyrZxK
         Sa1Riq1Dm43YN/KgEHW01k0kVP1RF9cD++8QJErNA0Vv2mOzKfTL32YPecVUAB8wy67w
         NeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDenxXQFnfGA6L2wSwxdY5Z9THLD15uqhY3iNilOOXc=;
        b=iCZ6gUDQT0qUevtVXIzPqwBopLz3yfX4Cf32eTcv6fJChCQP2SpIBMrTXiweJ2AAe2
         qmDSBHadvLnPU9+/KYh0eaOr21tP2BvIPDGDBFH0Xkn8zsAgRPkCWRlANjyZgbU7KOsQ
         RfK3vyIM7kyUdDvSPu0iKSCxfntmf5yxH0NKGb0C9IfmcuZJorVptD5o8MmLKil7LQsu
         xPhGAGpFRtcg/JZthPIijnCOA2eJHCsRHD2nHP7NQdhRKp3E3V9dipYI6gmstoPd0+WU
         g6tDa4+iknnb1HQduNoe/fmY8QXS5VHU9uZ5IpXgFG9o2YNR4kwDBGHjorR8n04ImQC8
         LN5w==
X-Gm-Message-State: AJcUukck2sQyz6E4XamjQsd1u6zPESiAcNuxApUhpoJw51X+DjlOmZ+x
        7syCgYSD8Y69ZjypBn/M4jmcUtXZ
X-Google-Smtp-Source: ALg8bN4eEjeAntvqh7hQvLEHpqDgkej1YNUtmuWqnwhLYdxPbzZOq/XZfis/34nNPMcibZWfgx64Hg==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr14104840lje.28.1545927955765;
        Thu, 27 Dec 2018 08:25:55 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:54 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/75] diff.h: keep forward struct declarations sorted
Date:   Thu, 27 Dec 2018 17:25:30 +0100
Message-Id: <20181227162536.15895-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.h b/diff.h
index 9e8061ca29..4b65ff739f 100644
--- a/diff.h
+++ b/diff.h
@@ -9,16 +9,16 @@
 #include "object.h"
 #include "oidset.h"
 
-struct rev_info;
+struct combine_diff_path;
+struct commit;
+struct diff_filespec;
 struct diff_options;
 struct diff_queue_struct;
-struct strbuf;
-struct diff_filespec;
-struct userdiff_driver;
 struct oid_array;
-struct commit;
-struct combine_diff_path;
 struct repository;
+struct rev_info;
+struct strbuf;
+struct userdiff_driver;
 
 typedef int (*pathchange_fn_t)(struct diff_options *options,
 		 struct combine_diff_path *path);
-- 
2.20.0.482.g66447595a7

