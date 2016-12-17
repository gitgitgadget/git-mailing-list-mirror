Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB021FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757099AbcLQO4G (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:06 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35354 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757052AbcLQO4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:05 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so18052861wjc.2
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PweXGt89uSpgHabsgsNr62pf1erHWT0Gsv3bpXBU3SE=;
        b=Eig4fLxnKwfa/yof+n9cUhJwd+KZ5sbJ72DKNcUt1MHm/1RBwhHSZgAk9f41ozSUhx
         oZ/mUXyc/VgpQq46MosSlFGoFDys4oocONKezkmhJHQOkfq6Cm5EHOr63D3EfmlUrjHy
         IkMJEZ25hijfp0qd/GydtJWwwzqI5Rd6ZsMH5pJpzvF6sTHqGRy/g3WEhDdGQOAozswP
         dQ23FxFEtPynxley1abGoIXCR9oCyZqgw7i+QW20Ice0MLVY9jDQ7pKlBUjsuL99G/BE
         1oP2LAhoQH0/YSbiJBXAu7ChSfHQ3hR5eWP+uMxH89tIhnI6pWHkc1PuPxwb6WrOd9DO
         tSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PweXGt89uSpgHabsgsNr62pf1erHWT0Gsv3bpXBU3SE=;
        b=Vo5IgkaNN5x+GQi1vNKB+dibC/MH0p6er5+6sf4plRXdURFhm2WUfJ20oNm7sSejaJ
         JZbsxgUilGWJRk4gWHUJyKZyiS5m5DX+07fI+Ch9fAx007ZCRpP4Rrd0OnYrzgdCeaxN
         HdoviHh2QreV6rAzkzKuMy+QVONMc8JRt93uMCEuOa4SKOLZGgufwFdyEiDnq1LBhSDq
         WuhgsUh1c/dcOzr5LM56NTv7FYmCYbhWTcqfXTzcU9F4vlMwwYnKOdfXm14w/RiLU7ZG
         hjNfBrswAvtLhEe5JqpGzlxb6Oo73jc1XMhUJ7PfufpKoYuWwhslkgSa7ZRyPpEZt0Vc
         RlwA==
X-Gm-Message-State: AIkVDXKlYAsY/WmhNkOpTtP++gAaJWd2JqCHGDnQeLkGsDbrisjQp1QRIIINqjdtuhfFIA==
X-Received: by 10.194.71.17 with SMTP id q17mr8183112wju.180.1481986563843;
        Sat, 17 Dec 2016 06:56:03 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:02 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/21] config: mark an error message up for translation
Date:   Sat, 17 Dec 2016 15:55:27 +0100
Message-Id: <20161217145547.11748-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 83fdecb1bc..2eaf8ad77a 100644
--- a/config.c
+++ b/config.c
@@ -1701,8 +1701,8 @@ int git_config_get_untracked_cache(void)
 		if (!strcasecmp(v, "keep"))
 			return -1;
 
-		error("unknown core.untrackedCache value '%s'; "
-		      "using 'keep' default value", v);
+		error(_("unknown core.untrackedCache value '%s'; "
+			"using 'keep' default value"), v);
 		return -1;
 	}
 
-- 
2.11.0.49.g2414764.dirty

