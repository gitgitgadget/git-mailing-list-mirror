Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08222C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiBVQbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A9167F8B
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so2386828wml.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PQkUAfKeX5SLmX/s3QRqfcVmlnFv15MPwnW0ew/LNlA=;
        b=ONOnaXKNkc2NaX1PCQgAQzLlKnI1pGOZRMHt4EjeAnZaOXe6mUpnEdfsGoOER8hW0D
         1WWIZV+LczLiuJo4z/T9YRYBPn0YJngQVshJ3XUrIweWXWDtkRjrTSyNFXGcq3eWIxPB
         XNnshRjFdUZ67aLxzxW/kqdRoF2tbjBra80GKya/jzxAl005K07fycSVIYkg9PQFjk+k
         dwXyVkbWCyN6za5ZbgoVEuYd6IwUGVXNxunXAfezurWrBojQRlSrTFuNg5mcPTYQVx+1
         AJ46ZQn3E3g+d+Ye40WJboOHUWNh4LIbo29rcNK5L4TrK8hCvYmaFM9CiV9cfy69WM4p
         yFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PQkUAfKeX5SLmX/s3QRqfcVmlnFv15MPwnW0ew/LNlA=;
        b=YwmykJIPTqyP7c/9ZwVlTw2W7MiA8YMQYeij0KVFXBkkxtwvjSB28xs0380fVUV5qY
         x3N2XxAE+hBxKfSCmORVQ5HFLgDUQuA0Y2PBVbEPY1xCwC32ixB4DCyxfLDAzsg3s/zU
         wVStEfUPOsqm6SOVR1PGy0NC1OuI8+keigyz05y6j2QAOIq4FMYXXp7OaGK35fJGd9FG
         Clg3QY5PxWIkViUSs5LHMLd8Sx+je8AkXkDv/W6NOLL1eP0jAidYkWN8mcEF5Cv3xAlF
         mhROruGvOJm+EgYkBZl71EM7BRqaLLvFqVtR1rQejOIUBr0mwyqt1jnOic7HiD39yekV
         Bing==
X-Gm-Message-State: AOAM5301GCMgNIIrXXGbeNV9CppXVXj5l8vcFH5rRr4ZyZglq0Y+u31h
        lrBoi2qbFUJ0GcErVHK51161nHMB0+g=
X-Google-Smtp-Source: ABdhPJyDESZEql0/V/pQQKapQIxo04IMAU881lwxErSLUdUOed+6Vc4FmGN646c5CxCndfqzoPk4mA==
X-Received: by 2002:a1c:2742:0:b0:37b:b481:321f with SMTP id n63-20020a1c2742000000b0037bb481321fmr4053075wmn.56.1645547432926;
        Tue, 22 Feb 2022 08:30:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm41675937wrt.70.2022.02.22.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:32 -0800 (PST)
Message-Id: <208f8fa48512377e6d8f88c5c89f63692a792ccc.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:19 +0000
Subject: [PATCH v2 10/14] bisect--helper: return only correct exit codes in
 `cmd_*()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Exit codes cannot be negative, but `error()` returns -1.

Let's just go with the common pattern and call `die()` in
`cmd_bisect__helper()` when incorrect arguments were detected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ba047ee0fc8..5228964937d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1217,7 +1217,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_TERMS:
 		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
+			die(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 		break;
 	case BISECT_SKIP:
@@ -1227,13 +1227,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_NEXT:
 		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
+			die(_("--bisect-next requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
 	case BISECT_RESET:
 		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
+			die(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case BISECT_VISUALIZE:
@@ -1242,18 +1242,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_REPLAY:
 		if (argc != 1)
-			return error(_("no logfile given"));
+			die(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
 	case BISECT_LOG:
 		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
+			die(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
 	case BISECT_RUN:
 		if (!argc)
-			return error(_("bisect run failed: no command provided."));
+			die(_("bisect run failed: no command provided."));
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 		break;
-- 
gitgitgadget

