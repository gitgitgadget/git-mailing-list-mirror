Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B2320248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfBXKLh (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40582 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBXKLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so5207272eds.7
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=390tjtd6hStgDVrFDvt5FO6xfDfRGxtkOPFAyOHbBWM=;
        b=EwZdBekf65XS2t07wENbogeJQteAjlJg2PPnuCoGp+xO8Kw/BJHPS8pCq2sbm49YzV
         HfvcDKVuV0zFDQOPe5k8YJLAgl0GSehqUyCX/kl8kDJZ7RaTHs+vmLL2Hm6p0KrLNi6Y
         wRtzTrP9j+gUFA2N76gHAIlwz56Tq1ZNz93/65Y/jvqkmgqMBlFqldNlZwVCPtMc6/2l
         UY4Zi2sLoncKrTO9uEtEWrZG68zvc9EKyXeFpe2d+VB97DtXrTww4yTT4ZHOm8MkTtOk
         a/gsq6T3aVDCjLkh52TX8KAYSPie57PfkOIKQ4ut2iQ1BxUFAxjXmu51GKI7qsOfNLWt
         Tffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=390tjtd6hStgDVrFDvt5FO6xfDfRGxtkOPFAyOHbBWM=;
        b=fQR5Zai9yTdnjb8jYdjYTnej1bfzWVB1WVqXGXuMz16URf8KyOEKdjt60vUrzKACjP
         0eh9f3cZrjyG8Fn3NckyKIz3CR5VvN97PnOaTxshaII4n/HukoZUOUiXrxkwcCsrC2fm
         EBSZDXJaftXgbM3/p5fA2Iff+5oucc++IdcbV/VkSUAGpRUYBBz0QPM5axND+dahRz1b
         T97vS7AVmxf+2qo36ZNvc1Mcx89zg/kWCXNQ79B9DWb/tgAHcfd2Ow1fohjcnDoS097O
         dqISLeMtlD+Veqk25IpOaJaRYub/jyuGgUZgaXNs6tPOx/iis+GAY+rfuxbTJ08ChS7o
         +k9w==
X-Gm-Message-State: AHQUAuaRkYgFph0ZfSwpVELHPcYi8WiCbXnW/f5p1RytmhlXil7yB1Bg
        zQXu/x2uH9pErRrDm8GkZciDyrDO
X-Google-Smtp-Source: AHgI3IYe/IvwUiwofrdQYc5rEx7PF/5HZ3ahHei2gdPHoQaUS0WvqRD5m0fVOs4TGoVcleorSpbcSA==
X-Received: by 2002:a50:e10f:: with SMTP id h15mr9777565edl.99.1551003093461;
        Sun, 24 Feb 2019 02:11:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm1789766edj.61.2019.02.24.02.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:33 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:33 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:11 GMT
Message-Id: <438c26ae62b48a55326dba6bc3643aeb120cc13a.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 23/26] bisect--helper: retire `--bisect-auto-next` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-auto-next` subcommand is no longer used in the shell
script and the function `bisect_auto_next()` is called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 848401094d..4b4401005d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,6 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -1018,7 +1017,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1037,8 +1035,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1093,12 +1089,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_AUTO_NEXT:
-		if (argc)
-			return error(_("--bisect-auto-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_auto_next(&terms, prefix);
-		break;
 	case BISECT_STATE:
 		if (argc == 0)
 			return error(_("--bisect-state requires at least one revision"));
-- 
gitgitgadget

