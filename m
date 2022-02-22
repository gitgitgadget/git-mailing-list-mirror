Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D3C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiBVQbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6DD166E35
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x15so30943wrg.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mt/SR32s9SQd3S85z51Uk46xXwNP4IEbnlgYuVXE+gI=;
        b=UmhJ6SGFlr7RhevjxqYCYUgucn6dQCcLBNeRrOKuN8C3BMS/qA73QpnSoz0KLYO/vN
         RRr5Txmg++2aONgQhTfBfPq3fKrfP6p5VjmF4ElUuBmnsqxjFSwpel+m6n48PD0rEp1x
         bF0wOk6J/W29VeymUyXm7/eUHovnDu2Sl4Va66tiFwx1b+C8a7ljBDYu5Qvlf3ngnkJ9
         A7ICLMfpchi371gzoUODO5qh8+hJgNeeOXjJBKtZvdzFxPdDJCp+HZgbFPQ5H3KQ6fas
         fFbHyUPZMbR4X/33wP6YDR/mLxMrjYQhIAVuA8pbeArid9t4yD2cvSKHr37CIT8EGfTA
         fkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mt/SR32s9SQd3S85z51Uk46xXwNP4IEbnlgYuVXE+gI=;
        b=S0RygZwInQa9z1o/0lrNilaf/r1SoPn6G3slZjC5wt3j7GkKpRbcbF82cuy/ZSHBlF
         57slxr4T9s6zHGQ3jmn4EgDcsTIZMxeGSpStvRfmSkMvDYzc74KbWKL2ONSg1ZUWC07r
         FdZhZN6DT5LyfLQMrHnsB7Ao4pLZJFWfdeZ2JkCptJRECXbucWw2JJFGUpNR8xoHaA7I
         4kRBJhRtx4hYncq8QZ+0F9POsaEY+RgUZ/RpbEJ/zTrdRXq3EUEXxA7c55inhVJzufkP
         MMylR8tvBGE0VTy3DNwsJFG0YGfNjWIjDM3Q0Phlh4kRI4AKbq99g5xFAQt7C4GC1aX1
         XjFw==
X-Gm-Message-State: AOAM53281lMEMK+PJ5QFuPFfVTgMZKDfh6bBja6eoCUqqshmHpJnRM41
        gpx8X65O/SNBPnj4vWzh8oYxpb9cavY=
X-Google-Smtp-Source: ABdhPJy/jNhhz+hUgUAFCiaG/y28buRdMZkM1v+MBeE1VJLGJnD2oiZZVU+sN+g84eF1W/G7oESgjw==
X-Received: by 2002:a5d:5185:0:b0:1e5:78a3:7747 with SMTP id k5-20020a5d5185000000b001e578a37747mr20402198wrv.470.1645547430508;
        Tue, 22 Feb 2022 08:30:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm2962256wms.2.2022.02.22.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:30 -0800 (PST)
Message-Id: <0487701220b5b1e6c8212ed422ce4ebecca5fbe2.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:16 +0000
Subject: [PATCH v2 07/14] bisect--helper: align the sub-command order with
 git-bisect.sh
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

We are about to retire the shell implementation of `git bisect`, or
maybe better put: the remainder of the shell implementation (a shell of
a script, if you want).

In preparation for that, align the order of the sub-commands with the
way the outgoing implementation presents them to the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 76 ++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index fcddd7444a4..31243a88a02 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1169,37 +1169,37 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		BISECT_RESET = 1,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_NEXT,
+		BISECT_START = 1,
 		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
+		BISECT_TERMS,
 		BISECT_SKIP,
+		BISECT_NEXT,
+		BISECT_RESET,
 		BISECT_VISUALIZE,
+		BISECT_REPLAY,
+		BISECT_LOG,
 		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
 			 N_("skip some commits for checkout"), BISECT_SKIP),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_END()
@@ -1214,19 +1214,24 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case BISECT_RESET:
-		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
+	case BISECT_START:
+		set_terms(&terms, "bad", "good");
+		res = bisect_start(&terms, argv, argc);
+		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
 		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 		break;
-	case BISECT_START:
+	case BISECT_SKIP:
 		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
+		get_terms(&terms);
+		res = bisect_skip(&terms, argv, argc);
 		break;
 	case BISECT_NEXT:
 		if (argc)
@@ -1234,15 +1239,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
+	case BISECT_RESET:
+		if (argc > 1)
+			return error(_("--bisect-reset requires either no argument or a commit"));
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_LOG:
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log();
+	case BISECT_VISUALIZE:
+		get_terms(&terms);
+		res = bisect_visualize(&terms, argv, argc);
 		break;
 	case BISECT_REPLAY:
 		if (argc != 1)
@@ -1250,14 +1254,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
-	case BISECT_SKIP:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_VISUALIZE:
-		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
+	case BISECT_LOG:
+		if (argc)
+			return error(_("--bisect-log requires 0 arguments"));
+		res = bisect_log();
 		break;
 	case BISECT_RUN:
 		if (!argc)
-- 
gitgitgadget

