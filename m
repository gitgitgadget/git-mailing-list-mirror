Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1567C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiF0ShB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44818B15
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w17so14261751wrg.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kZA8sVf6KwZqKRPx5rlUz8DQlOu5VHM8cteZKnFwQ0Y=;
        b=YksWLtQrKzj4EDoVFJeb/TxkaeQLEHVz9q3fAuNU9PrvZ/VNPl0rJHtAd37QcQtOb2
         IJina7rwrc/IEaXBqV/L8RBFUpUGgkfpMS0OB337eyg49EHY3LMwM9O0kK83rc2RSzgK
         BOB5KoBFmwIwtJzohGyVOVuw+sMkEe97mmdNbcnsjL3PMRfA+5vBEsDFMr5Ry8wHspu7
         yqXcwGmuuTMXsyxQbzuzGiWJbWoLzqEkLhZZiACi9cGkEEoi1TiHj7qVN9icfEynyQOD
         +bBYG74oZai6sZSVdGv06AOKQpVqWqlwi+LLpC+CQR5wYA4oIqP05ss6npyCCWh+FuKC
         tDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kZA8sVf6KwZqKRPx5rlUz8DQlOu5VHM8cteZKnFwQ0Y=;
        b=JIk+Y3L655pNj6WcOAyEnmfysc53vzrZXKhFAqKTOfIv0QqfFbdBsIw8NyrlIKnBg+
         VbjSlyhSys+BAyVzAnnSM3MR+DivCv4ofZXgJ9KsEIPlCaFNhcXP1cNIsmo7gwKW01iY
         9343ZxNsNrQZ3XHETVuPokn9P7OfmtTPqcfY3+0JGzqPGpy5MAxo1oyPmBvOU71fvdJb
         jqX9ayx796eWg1gK7h1M8cniR8dgYRW6NRt61funu0bAP0zEF02qXqSXoegYp9KUM4F7
         Bthq+8hV6QedDgXTwcZuoZ9d4D4UVXAlSSimP5dkAuZCoeHrXihdqlvkInPgQayqLy7w
         ynjw==
X-Gm-Message-State: AJIora9clxX4QanVBRZFmEAlh9oCtD3eMPkf7R4TMxOA7DtQYSUQ/I8a
        p3WQLm5iVN2pUzx1QvlE71zRqEDKHDufHA==
X-Google-Smtp-Source: AGRyM1uk+Pa+ThJ31VZOC7Hub3eVK+Q+sVhFj+Dh/soJ6EuXfIC1olxzVxUzqA1epf8oOGYXJy/zow==
X-Received: by 2002:a5d:598e:0:b0:218:531a:eb5 with SMTP id n14-20020a5d598e000000b00218531a0eb5mr14022340wri.334.1656354688550;
        Mon, 27 Jun 2022 11:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b0021b932de5d6sm11307567wrv.39.2022.06.27.11.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:28 -0700 (PDT)
Message-Id: <375a46dca9f82c91c8dcb873a5ca95b5fc11f79e.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:09 +0000
Subject: [PATCH v4 08/16] bisect--helper: align the sub-command order with
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 45983a0a1fc..2d6eafa2abd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1279,37 +1279,37 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
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
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_END()
@@ -1324,19 +1324,24 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1344,15 +1349,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1360,14 +1364,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

