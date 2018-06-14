Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC00A1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 14:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbeFNOqe (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 10:46:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46841 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965133AbeFNOH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so3296934pff.13
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZmnAgsoEw4oFQRHo5Vot37a9Xre6DdesOQ4LnNZA1Ig=;
        b=a9FkJeu6pmFbUZj9EuZcnPzF9K6O69DBuNlSx9QpclmIaXEmfbUaRTD8/bFPqV3HJA
         7aeYc1mK35FwmKlIuAFKha1wPRDn1a0G7REta31zlWlkWqukJfM12LSnMvtOBZDJLgx5
         60G4+gGfhyfkAR1iek3aTRHj8juSPwWiUlu9jYyoFkw3R2PnlnT9nFJRYCz2lbB1t5e3
         LKKSPYtPGuL8hCBnRbi0HJ8STBQeykp7cEI+7dB9A+iLOXk69q27FvJBnqk4Yka4HFZ4
         PM7va+VaOr3wIkZVSy2yyBrgg2LUPVvVt3CRm6oSVTuk2gc+g1eKnyN6rHaq32drUt3P
         V4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZmnAgsoEw4oFQRHo5Vot37a9Xre6DdesOQ4LnNZA1Ig=;
        b=uf2XB7172EYxS8Z093/Ka9S8KRf55fM3qiyoB0b90cA+gBbfP6dxQ9E1m9f1NrQuoC
         /fno9DWKYzX+/99rESJre7S23nT7TinX8TGWyWO126NoKNRNAd+a8M7HPXoKDavYRpqk
         gVz2ykEo2AzGPR1gGL9+uPIQnOVl1FwbB8sdIoWFo2D4VLzYGEUMcI2HyCzsUrwyEM1r
         tn8l7WPnhMay/bmOsFxpBOXfKKWTgnno3PMVpsl3vO4BccU39RowAhbFOShxvet+JlhP
         YaTYvWMsN0CfGOcGf8NqCceuXtHIVDkOVbbs1QKDsu7KhPKqHAhDOilJDqrxtZG3qceO
         Hhuw==
X-Gm-Message-State: APt69E00YcInudvvUFtfJU0QtnDnw/TyAs2lqQwkHo5fp9yR48b/X5uv
        2vF22Cz3fj3x13BXZZJFXLwqvOyg
X-Google-Smtp-Source: ADUXVKIvoc8alDcTWjH+jdanjBuZmp+rAC6BG+5ofyAyoxUReXYdMKD+YdEflYX6sN8L54JOdP8vUQ==
X-Received: by 2002:a62:ff1d:: with SMTP id b29-v6mr9713422pfn.181.1528985275844;
        Thu, 14 Jun 2018 07:07:55 -0700 (PDT)
Received: from localhost.localdomain ([117.219.197.98])
        by smtp.gmail.com with ESMTPSA id p22-v6sm12498522pfj.166.2018.06.14.07.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 07:07:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: [PATCH] t3200: clarify description of --set-upstream test
Date:   Thu, 14 Jun 2018 19:36:41 +0530
Message-Id: <20180614140641.13752-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69
In-Reply-To: <20180605112446.17016-1-szeder.dev@gmail.com>
References: <20180605112446.17016-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for the --set-upstream option was removed in 52668846ea
(builtin/branch: stop supporting the "--set-upstream" option,
2017-08-17). The change did not completely remove the command
due to an issue noted in the commit's log message.

So, a test was added to ensure that a command which uses the
'--set-upstream' option fails and doesn't silently act as an alias
for the '--set-upstream-to' option due to option parsing features.

To avoid confusion, clarify that the option is an unsupported one
in the corresponding test description.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6c0b7ea4a..d14de82ba 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -884,7 +884,7 @@ test_expect_success 'test --unset-upstream on a particular branch' '
 	test_must_fail git config branch.my14.merge
 '
 
-test_expect_success '--set-upstream fails' '
+test_expect_success 'unsupported option --set-upstream fails' '
     test_must_fail git branch --set-upstream origin/master
 '
 
-- 
2.18.0.rc1.242.g61856ae69

