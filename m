Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803BE1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbeKFEm1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38220 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so7023195lfg.5
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoAfIjfV6rZiew1hUmarcExoqd/S8h47l+w/BWFL8D4=;
        b=TstDATQpYSVCxm7eYggyiy3Jm4LwgXXoBNv2LYhrH5UheAqRs4oxCbUWQPjpqVEB8m
         rVd9hte3Gr95omHOXC/uz0WsQpyDPvbkHIh/WZ+zcucztS6mnST5z9oKyB1a+Lm9Y+L8
         g/CwagzoV+vdeFabnuRqsh1Nf0ShrIHaKLdtnngzRWVkZ6Xp1N6Kowe6iabvzy/9qppW
         2yR6Pg/Lw4rnM2ZYLZEVoyKRSthNkWV7xjtjvY6DOUzC6TKupNHX+C74cRvA2eUSSgWx
         3iv3tSskr8GKECWEFTVcp/h6i5SiFG5YqXlODvbY2jvGebBplWynAWaNNRdQYMWuFjYq
         oNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoAfIjfV6rZiew1hUmarcExoqd/S8h47l+w/BWFL8D4=;
        b=GgB/Nt+JWZHmFwDlaaTOaKRC8TmDt4RyxxVM6Mfe9GBonS29odEiINWp6BWEaBDmfM
         5Vjqx52AnCp5Cck+rfObBns5BIXQQjtJ3qSiW+Gjo0QpBeYYZJNG11ttxHuRi6Bdyspl
         xKSYILm7WDpUZ0KOjpf9oC1YBwzkJ9R7Y6XkNfrPVrNWGyGqmHWRsXrz7L91dd8FEQM7
         rfYTBmvdlD8GWcJM1lWbkwuaJVqbzlW6Mu6zNsdt8j6CgFFSIol7PKNC+M8fG7KRNevR
         6UKnwe2Ean2SkqZqaJcCqGVNQmEOXOw3rH6WTe6aWP4zCTqcNSdTwhqBSc/YYcl2IHsw
         E23A==
X-Gm-Message-State: AGRZ1gIj4nK8W8fERC+L/uj6tuOUBnW9TBwN4hf+7VWITUBEJLc1xZJQ
        XB6104voBVmzqA3nmgb8GvBepwcQ
X-Google-Smtp-Source: AJdET5dsFijBjQpIhnjhvHDbkmr4FBWagU/wKDkD7fYZHjdEf/2PHYQcZtRf+fzOEAfk1cgDEaCfhA==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr14005043lff.123.1541445676113;
        Mon, 05 Nov 2018 11:21:16 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:15 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/16] read-cache.c: add missing colon separators
Date:   Mon,  5 Nov 2018 20:20:50 +0100
Message-Id: <20181105192059.20303-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

typechange_fmt and added_fmt should have a colon before "needs
update". Align the statements to make it easier to read and see. Also
drop the unnecessary ().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 858befe738..8d99ae376c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1492,11 +1492,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 						  istate->cache_nr);
 
 	trace_performance_enter();
-	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
-	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
-	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
-	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
-	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
+	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
+	deleted_fmt    = in_porcelain ? "D\t%s\n" : "%s: needs update\n";
+	typechange_fmt = in_porcelain ? "T\t%s\n" : "%s: needs update\n";
+	added_fmt      = in_porcelain ? "A\t%s\n" : "%s: needs update\n";
+	unmerged_fmt   = in_porcelain ? "U\t%s\n" : "%s: needs merge\n";
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
-- 
2.19.1.1005.gac84295441

