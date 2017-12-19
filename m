Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FDD1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbdLSW0x (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:26:53 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36881 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdLSW0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:26:49 -0500
Received: by mail-it0-f66.google.com with SMTP id d137so4615231itc.2
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=Ug4KC6w0lCX6QYf8OdmJUFMCiJeOKp3+YaJ0NBRcz0p1dgj8hq07rRkLLxiMQnsoRK
         2zYPUYRVxjsguIBJQuNNXUzpY2FGqK1e32d8gnYkeF+OIOa4XQfL745nHX2lTm6z/HgZ
         Tbe/Q4fanoj3abcjEJxwEGu8IGNGM1/ebOIWoK9TWm22pFTfm5Tce02WDb/pHRfTaObI
         firkip4RVmPsI4oikM5qI/b/NAgUefuLSuoNEU0dmxgg090F2ifJNVnaBLLcOKS9ECC0
         Bn5ypLbJfNfZp+L6rI54xuy6MJE6EVFXBHcS5WheseLZjtrcsngMpsjrSFgllZdmaVqe
         AWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=aysIU8+SCFblI/U4GQgMmPvyTGppsyKCZ9QBMpGnEhwZ5zInzOPR5nadzx9E5DDqqu
         MRllKwzlO3zEEMUsg8ri/fclnHIKIVPLgg5M5HWtmE6fjcphfkFmNkm5zGhm5uMFYipn
         fJTIbAep+1hjeGIumSrmis1umAaIn4grun+1tTsZXZ2JibLPDUtN2sDyoGRoFQp6vgck
         HgN0+3ytSyvSlSEnS7nOO6W1QM5pcuQXVkwk5jBbbR5o5zUu5HAbOY1wWJ3QmolC3Q0O
         nRUkTMb+tAs5qqe0vGjkxbksUFB7xpTd9ndB+okWor/lUGdDBCtgnuGtb1SGsCsEJTgK
         4HeQ==
X-Gm-Message-State: AKGB3mLn9Hb+fQvRsmfYq8/A1QEylSFmizTmpKQ/UVXL269Qe4tql0xU
        UKwNrwfbwEe5RDxQ5bi2OI1+HHFxAaI=
X-Google-Smtp-Source: ACJfBovOx5qqcEmmVUDe3+tdzM5shbj5cw8WMEjte9KZyZ+VyuWlldG6oSX20Omm3yKYX3obnf8BVg==
X-Received: by 10.36.172.73 with SMTP id m9mr5084983iti.120.1513722409003;
        Tue, 19 Dec 2017 14:26:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r67sm2685211iod.58.2017.12.19.14.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:26:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] t/lib-submodule-update.sh: clarify test
Date:   Tue, 19 Dec 2017 14:26:32 -0800
Message-Id: <20171219222636.216001-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171219222636.216001-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the local branch name as the upstream branch name to avoid confusion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 38dadd2c29..d7699046f6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -664,8 +664,8 @@ test_submodule_recursing_with_args_common() {
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
 			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t check-keep origin/modify_sub1 &&
-			$command check-keep &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-- 
2.15.1.620.gb9897f4670-goog

