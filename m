Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02514C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351353AbiFOPfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349522AbiFOPft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 11:35:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1F24BC0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 08:35:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z9so6520431wmf.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5FaNZklIFcAMZ/HwAdKs9YyfDx2DzTr34tzL4sH+82k=;
        b=FFzkOxScaik2fyC13QKoFx1oj9Fc38HYlL9j210R133O5XLweSrpyAa9zI4uCsGLLp
         OJtohlAK8OOPiMbADZNd7C21xnBrXJoIsxE4DzxII/IVPMBUgqzRSOHJ4ITB/hWyu5pU
         uWOlzZxC5OqXf194GcC4YKlqiFuWzsxqbc5GKP76atQlORR/AbaC2qlT3kbQpANlpBWR
         ByFSWD+UHum93SfMInHE27ka4WNEclSVVoul7v+F8QiKwspSo7lpZ2fVC66+UtWJZhrA
         AAaBL06xzWmSbH+fHb4Bu1UdwJ9qSTaAbKaSjQIQdiguIAYQLlp4+hPThAq7xi9+GTlb
         1cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5FaNZklIFcAMZ/HwAdKs9YyfDx2DzTr34tzL4sH+82k=;
        b=8KWeAAqafOc5Mg9G9zpZ+yIGhhJVODwv/g1HjQVTzhiSLJLuvLtvfrvgvCjIPOKTX/
         DVunYY1ZBilPwxeNe1d40juH4GMBwgUpdEeUxZAbLqQbrxB3Sr+aKAksL8Ju3xv9Z9hi
         E9rPeufTZo/f5SprFGpRpPsKbMZVyZIP/wLKKHVRFacMWfGc6qImLFacXiQycvEr1QHX
         Rv3TCrpvbMjoqdOXwyDGKXgXDHBQAL9U2IvvDGakqpTJDNQmxXDwh7zJWYsGomvZP0t6
         NGK3IUAZmpE5eLRkTlHuO7kvg3qrDUn629lJwN5zNWIu3l2YFeR6X9pZsBVC1E+EcBi2
         goHA==
X-Gm-Message-State: AOAM531FwFtRBsmh5gB3WYkNqKYVZUeBRbkwymCh0rGqNTyZ2rIheyuT
        Gp5eJH/LQSJXE5n5JPqzqBtRBCO23NihlQ==
X-Google-Smtp-Source: ABdhPJwojvJAI+iA1tl15Y76/yvaAVcGstUb/RxCB9jnzDBnR3Tc2rFvfc6IyAh25v/ag/Hn7NYGOQ==
X-Received: by 2002:a05:600c:350f:b0:397:7204:ce8e with SMTP id h15-20020a05600c350f00b003977204ce8emr10800643wmq.0.1655307346764;
        Wed, 15 Jun 2022 08:35:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b0039c8d181ac6sm2996774wmq.26.2022.06.15.08.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:35:45 -0700 (PDT)
Message-Id: <pull.1276.git.git.1655307345132.gitgitgadget@gmail.com>
From:   "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 15:35:44 +0000
Subject: [PATCH] push: fix capitalisation of the option name autoSetupMerge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>, Fangyi Zhou <me@fangyi.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fangyi Zhou <me@fangyi.io>

This was found during l10n process by Jiang Xin.

Reported-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
    push: Fix capitalisation of the option name autoSetupMerge
    
    This was found during l10n process by Jiang Xin.
    
    Signed-off-by: Fangyi Zhou me@fangyi.io

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1276%2Ffangyi-zhou%2Fautosetupmerge-capitalisation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1276/fangyi-zhou/autosetupmerge-capitalisation-v1
Pull-Request: https://github.com/git/git/pull/1276

 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 86b44f8aa71..df0d68e5998 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -171,7 +171,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 				 "To avoid automatically configuring "
 				 "upstream branches when their name\n"
 				 "doesn't match the local branch, see option "
-				 "'simple' of branch.autosetupmerge\n"
+				 "'simple' of branch.autoSetupMerge\n"
 				 "in 'git help config'.\n");
 	die(_("The upstream branch of your current branch does not match\n"
 	      "the name of your current branch.  To push to the upstream branch\n"

base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
-- 
gitgitgadget
