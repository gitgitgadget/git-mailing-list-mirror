Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8301F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbeGRQvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33450 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbeGRQvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so4608406ljj.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMFMMnYAPiGbfykAK4PzIWKnFDy5wUX3EKsRABCJZBg=;
        b=ki97FkjAFqSOkx+0xjJ+Es+i6G6aCbkmO3BgULnT4s7eeOsvOGoXfb4v0XJTK1oaBy
         GdH3X749vzE4XE+m0MdiWHBgzVVBFUTu8tCoQabCWv1oXNVj2TzEp9JmVfaoDtC7R7/V
         fAjUlqJDgBVtHHfPwEHMmcpJSiPhg74jK1GJMj4aQMwI2DMcMKSyHNDYr8CjPYKDrqF+
         CverZmBiCSYz8A8ormqRjLePCcvaS1B+8vyGLqGmqfWfvufY1s8u1wqr56vLP8lwmhX6
         VOAQi5scU/i0KnGFs0mmphFBmws6wN4eJ2EVFBGmylnhhG4PZV9bCpkdbONpmN+JO7xa
         uMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMFMMnYAPiGbfykAK4PzIWKnFDy5wUX3EKsRABCJZBg=;
        b=T+PY/rWg4y6rHk1mQEPoyniDKPChWqY3XhQO6fnQr7okh+755Q9ysWIIX/yZ+lc1Xn
         delgotxUExXnCr4dnrFXzNuY1UrU3XCvnZfW0tg5x1blHby9WjDCb1bxHem3M34Y+aJl
         YYMriQrJL6KpteSBMMj5akKWkFz2+oiFmC4BFHj0HzLninD5ASiv0sqU5cII4FoZI66C
         6OCunvi1Bogmu8dr+GMnFA7v8PflAPrJ7XcfBsb56P0ARmtxpqDEX/oE90IjeVFdG/CV
         N2ppw/Xw8KPf6p4J9+DS90dWF4F91HweY7W7B+/yROIu3k+H68jwonsE8AHQIJM+oe0v
         VB5w==
X-Gm-Message-State: AOUpUlFR5LC0UbG8rWlgWaueMpZSandLQFaVLv7HzAKwavs+KsGMRV2K
        Z4HKpRBTI36a8FA1qD9VXxv+vQ==
X-Google-Smtp-Source: AAOMgpcjTliR//HJ2kzpXoHJbuyiEUqZ6O27jLaDkMdeaUOC3SV0MHeyk200jAGvkBWZ7/NqzQitmg==
X-Received: by 2002:a2e:5d88:: with SMTP id v8-v6mr4921222lje.137.1531930365010;
        Wed, 18 Jul 2018 09:12:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/23] builtin/grep.c: mark strings for translation
Date:   Wed, 18 Jul 2018 18:10:43 +0200
Message-Id: <20180718161101.19765-6-pclouds@gmail.com>
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
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9774920999..58f941e951 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -489,7 +489,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 	}
 
 	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
-- 
2.18.0.rc2.476.g39500d3211

