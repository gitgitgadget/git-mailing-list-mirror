Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A0C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 11:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJFLp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJFLpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 07:45:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1BA95ACF
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 04:45:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so2283526wrp.10
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=uCQrv50mAuZZ9s3wHo2DOGPPJxWRIjDqcqblPolZMR0=;
        b=FBOXf7BtUbDiwU6HKEoxXh4jsHjvqdLKX0+6hhY439xuPjtrCXzJDt0zN0uKoQ5YlO
         yJGYlCqx9ypP7p6Isnc7AD8u5UUPUme7tg4Q/6CTKSB+vbwwV2ryOhXkRW95V8Suzxei
         OzDO44hpHAeZlELxunJpSeksFmbhBhgZ7m6YQzPsyxlUgN0xbR3AafkeiRycqdDOXdbJ
         5RvnuF4p2x3yeQVRPaPrEkLNWDG69+sIXtfD+Zyo6wh2Ax3LYcu+5uoXizV1IigdnaIs
         EYOxBgmiWaEcyCpjCnbW/Y3LWhMTjwhVSYxrFA0gC3RD9hqCrxowEihFLlAlPpEgo2MC
         S6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uCQrv50mAuZZ9s3wHo2DOGPPJxWRIjDqcqblPolZMR0=;
        b=ZBRG0xjGayxPkJXWkzhOLXyZA36QTtKc/haiWrqr2aVyTj1zaDvvpn/yTRZTWUOBoQ
         Qk0T0b2NJatVJFq67sJnaCaaMkzUl9GWLGIpGjKAH5czK7b5mNe0H3YIuIx/gd1Zayg7
         n24Jw1CGeyOTe0YwTlC8Ypz3y4hiy7VCR/wiVWBOAOjy04td2v08sGSGKOvMR+F0nMKS
         HHslzYJYzRr02KpdWW15OiUlcuhAFR37Lqfnw5bndk50JyOo/k2LrMheF2o2mDuFRjSC
         U7izFWXpQA8LSLAsMmRDJ9xrv1cKdzem84AmPo2o3C+Emp5CTptXXJgj22RiLkG/712o
         PSYw==
X-Gm-Message-State: ACrzQf1WLBl9DVI5Bx4j0E5GP8zhzY2hgogmHBqgU783jWUnLMxyDzVI
        Is+uSfjabDoAJA2Wg4AEU8j9f2fjX0M=
X-Google-Smtp-Source: AMsMyM4obb5DI7sbNEvPFjGiSYJCjkPS14K+0DDsX0CDXNLN6U5aMIrv98r0SvElVGfm8Q9BinPMyw==
X-Received: by 2002:a5d:404b:0:b0:22e:331e:1cba with SMTP id w11-20020a5d404b000000b0022e331e1cbamr2785198wrp.488.1665056750527;
        Thu, 06 Oct 2022 04:45:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b003c1b492daa4sm2068395wms.36.2022.10.06.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 04:45:49 -0700 (PDT)
Message-Id: <c107ad9f6ff2d5e00134eb1348f24737774edbac.1665056747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
From:   "dsal3389 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 11:45:47 +0000
Subject: [PATCH 2/2] removed else statement
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dsal3389 <dsal3389@gmail.com>, dsal3389 <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: dsal3389 <dsal3389@gmail.com>

there is no need for the else statement if we can do it more
elegantly with a signle if statement we no "else"

Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
---
 git.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index da411c53822..340ec8bcb31 100644
--- a/git.c
+++ b/git.c
@@ -894,12 +894,8 @@ int cmd_main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	if (argc > 0) {
-		if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
-			argv[0] = "version";
-		else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
-			argv[0] = "help";
-	} else {
+
+	if (argc <= 0) {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
 		printf(_("usage: %s\n\n"), git_usage_string);
@@ -907,6 +903,12 @@ int cmd_main(int argc, const char **argv)
 		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
 	}
+
+	if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
+		argv[0] = "version";
+	else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
+		argv[0] = "help";
+
 	cmd = argv[0];
 
 	/*
-- 
gitgitgadget
