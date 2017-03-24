Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68181FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965508AbdCXP2B (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:28:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36138 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965762AbdCXP1p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id n37so833031qtb.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QVn76uCR1cJmcFeJoEkZQsZOXPUPU2CE+edxyFftSFo=;
        b=ABtGAZTj3+01gHPlQjU5oRy+sT77tK+vphcVF+CyvLLKYKx2Y/DWOJdB5USOWuleew
         VgVDCr8pJyqz0gwjHiS3dvYd3mmJYWZd+uCXoJN9LoR1WSrhrkUy9oZFHkPThJ+t/cL1
         pmF9Bfa66FBRr+X/zQx5JJGG1kM3bnu01GUjChgTleDy/YmXXAiUG6we6Rf07DfwUP8Z
         Rc66tcrAZxTWzYkmY+CU9XNka4J7Qk1NvFQEVfjNIF7CVa+5xO2THgxv1cSeCIX8n9X6
         RemZCC8tzBGATsY+MOK1/XyZinOVU1+21AZ4sGqcvQSMHlcvHnCqo9Vk36oX2tUWnOeP
         wHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QVn76uCR1cJmcFeJoEkZQsZOXPUPU2CE+edxyFftSFo=;
        b=CfpD4oaPE//tOI/1I+Uv8sU3vC6/Z++BvskDGvK9zrSQ/MeTpD+s1+DjevaakJKv7I
         fRaZaYLGsrkMFGvsK7dUOaLp7mG/KY3TIAz+K/ckIirYTkaA4M7E+NAhh3bf7uNmaadB
         /sTMLx9Az+5piZieSFpmrPvX1oTtRBA0NfWW0AgInMJHPGERVyh97K1wueCi+UEVX6w9
         1EYtgt7H9qn1U2jdwRJ/MKk9uJprWMvprzIzjrC7pp7RgWoedS9jCdE56KRsTWKfz9qM
         C893325kdGDv7rgbql76enlDElTe0MjfyCzZ3+BuV6NxuadMJ0J9Si38CX5hUKOZ8zFS
         aytg==
X-Gm-Message-State: AFeK/H2/Z9WS7StAOYmMnfCne1/TvaKl8nvD5ZE5nOaHkl8MznsCRHd88qNF06o9YKq72A==
X-Received: by 10.200.3.74 with SMTP id w10mr9180299qtg.73.1490369263628;
        Fri, 24 Mar 2017 08:27:43 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:42 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] t7800: cleanup cruft left behind by tests
Date:   Fri, 24 Mar 2017 11:27:24 -0400
Message-Id: <20170324152726.14632-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
In-Reply-To: <20170324152726.14632-1-benpeart@microsoft.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Aguilar <davvid@gmail.com>

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7800-difftool.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index e1ec292718..e0e65df8de 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -591,6 +591,7 @@ test_expect_success 'difftool --no-symlinks detects conflict ' '
 '
 
 test_expect_success 'difftool properly honors gitlink and core.worktree' '
+	test_when_finished rm -rf submod/ule &&
 	git submodule add ./. submod/ule &&
 	test_config -C submod/ule diff.tool checktrees &&
 	test_config -C submod/ule difftool.checktrees.cmd '\''
@@ -600,11 +601,13 @@ test_expect_success 'difftool properly honors gitlink and core.worktree' '
 		cd submod/ule &&
 		echo good >expect &&
 		git difftool --tool=checktrees --dir-diff HEAD~ >actual &&
-		test_cmp expect actual
+		test_cmp expect actual &&
+		rm -f expect actual
 	)
 '
 
 test_expect_success SYMLINKS 'difftool --dir-diff symlinked directories' '
+	test_when_finished git reset --hard &&
 	git init dirlinks &&
 	(
 		cd dirlinks &&
-- 
2.12.0.gvfs.1.43.g876ba2a

