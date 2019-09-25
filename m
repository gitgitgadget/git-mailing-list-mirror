Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460521F463
	for <e@80x24.org>; Wed, 25 Sep 2019 02:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633764AbfIYCEs (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 22:04:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45289 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbfIYCEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 22:04:48 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so9465401iot.12
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/BUQK4TBWTerPsbwVxt4e3h1Zpptorjgr+lA2TqEFc=;
        b=oByAD5LrnpOHbmg61Mwo28DkdfwXU+FtDHzhtdY9uqLuPitjX67LeUnppnvRF3NQkh
         065Ma7+hJAMJAWr0LS4Yokup5pqDhcBPfjEX951l6mq7vM46JN3tuFysRqztKe4EFtou
         ltS3xOuVaLJvBW+/f1PZ+33GHKDvnWyKL5kCzO9kzsIG2pkSUvDyJqBc56Deq+JYLm4Z
         iqZtVtxvCURBw3TTKvViEG+YK1LmqWv8ExoTnL3bOwwpzGM0OknKHYI6MLgk+3/O05ZD
         L2S3ucpS2ghpT44ilDd3C7iECXMkyCS0K3ZfpLWgfK8EZKNpXDgp10d8rwgH4hGAEjSS
         T1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/BUQK4TBWTerPsbwVxt4e3h1Zpptorjgr+lA2TqEFc=;
        b=CJJqxeTBxCV9np0e4lDgq/s+yRGJpVBKFZzkMU6s2vS3nC4rtULX+7YIFUHyZOLsHa
         RHc8tXaR7LIYJs9qkxh0BpEIIz+WTQryBGygS/HC3MnpA+ZZunwfWgSUFqnia+F9nwLl
         uHK29xNquYzYnOX0XwBsF49DEM/XlPJhM3s/W7VcS65yBTeP1+Jt42pMcfW06rUZx5iJ
         FXiO+j0M8YlWn8txAMj/e1VkWz+K67RXHjVwo65i81Jc+nT0iAVKyh21lcn64xlFJueG
         D6dphU9hyWOS4iVEAARtIVoKcivBX+QRMEv7L2REnFLTPSjyHwrR1T8hiC8qY393Sqjv
         sL5Q==
X-Gm-Message-State: APjAAAV9+hmQMXPDwY7Pll757/BpO5a3VDmiYYfrPqQ6Y8yRyzrveLoT
        FXSfCMwCRhqbsBxIgwEjFVmmkg8nSJk=
X-Google-Smtp-Source: APXvYqxGWYtEwtK/BdRU+iYTbFcXD96iCdkRp6DMxeWjoJhz7yeA6BsgGE6LSYeSNkJODVG3qEWHmQ==
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr2611065jai.13.1569377086678;
        Tue, 24 Sep 2019 19:04:46 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id u11sm5341777iof.22.2019.09.24.19.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 19:04:45 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        davvid@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 1/3] commit-graph: remove a duplicate assignment
Date:   Tue, 24 Sep 2019 20:01:56 -0600
Message-Id: <20190925020158.751492-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925020158.751492-1-alexhenrie24@gmail.com>
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 commit-graph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b02d2c426..659f4bb4f4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1534,7 +1534,6 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		size_mult = ctx->split_opts->size_multiple;
 	}
 
-	g = ctx->r->objects->commit_graph;
 	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
 	while (g && (g->num_commits <= size_mult * num_commits ||
-- 
2.23.0

