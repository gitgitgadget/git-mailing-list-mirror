Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD8E20323
	for <e@80x24.org>; Wed, 15 Mar 2017 06:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdCOGyP (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 02:54:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35228 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdCOGyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 02:54:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id x63so1081201pfx.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lr2OdKtF8zry9rD/A8ul2iw4D4k79M+Ou5t7XeD6Ls=;
        b=OEU/7/8+/YsRzioobiRUWQxvaOXktywU1cw93KOoxGM0OEpmCSvbfZeI4rXuFdwOsC
         RbBB0Jg9jo0Md4MUnBNR9uBrmZaJCW7QJI89yfgAV4J0bXmtSrngyYJ7RQu4yyjXVH8X
         5McssVAyQr2ldn7hYjrFKjpQD76WYvZ3m6SfiXiP23RJm73yeb2fgtBlkzmthN8vKFxm
         AU5aT5kgpJ1DXwrFL/Bwr2EyiNrSHbdSkjgrKfl2RPgua0J7dPCovFozx26ukSBf2mrA
         bdO/kLBZ/hQcoYcdcche7Nrr04V4ltgWCKibjF+N2fmBXvlC4WOcYujRLrGI6uSABzP2
         BOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6lr2OdKtF8zry9rD/A8ul2iw4D4k79M+Ou5t7XeD6Ls=;
        b=sT0JF4w1sbBA2pByu9kYN2euhfD4v6MuBZqagbRkSTKcYtQBW6Z1z5ZCy4sIp/dOhU
         O/vQInpmXIhZOjVyz8wyNflcNuVAHEaMdxfUmwuBWr7BAHVdmZjuPOHz1/mmR4/gVOeJ
         S8eIAvk5X3RxsHVDPRWWCv5TCUPWRhTgBLN6mIvSfIxJBDwVaRLcJ+t30MzcE2098cmn
         NDmyu054dPrb22aygBvLMt9ume7D4vCNj8YRRg3oEsHSeGDceOVwKFdGUIPkHpzMkR35
         myBcsqXgZ1j5CxKnt7YkTH7RrHAXqnCmN8ux82kkAZF4EyBvDmrRdchcMWhY+zXEI3am
         3H8g==
X-Gm-Message-State: AFeK/H1KL5sMBzVA9iNMkYY79sLwlxutZ1fRY5JA+5YLmRd4sgjOaSXduURV75IIeLDdOg==
X-Received: by 10.98.93.150 with SMTP id n22mr1977087pfj.103.1489560853150;
        Tue, 14 Mar 2017 23:54:13 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id v9sm1851026pfg.133.2017.03.14.23.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 23:54:11 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: [PATCH 2/3] t7800: cleanup cruft left behind by tests
Date:   Tue, 14 Mar 2017 23:54:05 -0700
Message-Id: <20170315065406.6739-2-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.309.gffef9e61c2
In-Reply-To: <20170315065406.6739-1-davvid@gmail.com>
References: <20170315065406.6739-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
More cleanup, this is needed because the final patch adds a test
to t7800 that was sensitive to the cruft left behind.

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
2.12.0.309.gffef9e61c2

