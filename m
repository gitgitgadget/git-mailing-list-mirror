Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD92C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiF0ShH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiF0Sga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0150718B20
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so5268784wmr.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=42iKZzegnZlyfRqzAvQLpJaOWagryEx/SDmBBXR5+zw=;
        b=ppzA7ieLioj5qxpWx5ZGSPApM9bMgXcwZ6JjpIDVeJWu3iFOKuk/UBVrOxreZGlha+
         ifthmBTrv1i3GspOWeyGRnKJPVmjQkxpPVVximAIzAEAJtB6JmrkkNRxJ5NZs/lthFa9
         kfO4MGZ+4qgagg64kQbhfYxEn6+FuC8LhXeh6weS1DOQ2Kmo7YX2ddkEu8OWW11SHUUd
         mlHPRkJkiZuxVxR3sPQlmGm3ueCKCxRsTckEVfAB4z7qbWxa/VlA7W0grvsZKsO7KOw7
         01w1TuNIb5/ULV8qUs98TuHH99934GyFmCRwcIpRqooOl32eePaXKatCBkg1Ay/bSbwE
         SpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=42iKZzegnZlyfRqzAvQLpJaOWagryEx/SDmBBXR5+zw=;
        b=WeRGr3OaGGWgvSibN3iO3O5g0tfuKpvnr+YVKcBx+q2ei3Xa2MXlypKx3sSX1YejoO
         18dkeb6FnPH3mx0bnWefdC2QAbVcHliHE92DmjyKSr8LUhK5lQyxFFNCCsVYeDWfhPOS
         BJCs5NRBhyEOlb9/nQtEWwJq3zyQ+WlohDNLgbXylc1lvoBLAB5w2XQ1QpmvDzxqvZbJ
         pGRA7VGspIkutNUgLlhXFMCBGKKwf+467kjoTTmgrFk3G7iSVYu4KEMTQaafI0UosUmp
         aOI1Gt9kQ7fW1lcoUAdI8TElkK5HDbZU3vAqP/QcyWSg+OB5d3xDG925Odg7293IaZiU
         za2g==
X-Gm-Message-State: AJIora9yPjWiyBYJAqNELb0yjF6R9kvaq6/AThySpIssxbx6RLbe1bQh
        o4QKKUHNFW1dDeFBgvIV2Y2+t5HqkzyNIA==
X-Google-Smtp-Source: AGRyM1uULTy+QYCyfYk3PYM7Zke0sF0blRKZ16n6jWUh1S9trih6eyYgolS2vZIY9bBOjzoDIRB5qw==
X-Received: by 2002:a1c:19c4:0:b0:3a0:2d2d:93e0 with SMTP id 187-20020a1c19c4000000b003a02d2d93e0mr22042495wmz.117.1656354694219;
        Mon, 27 Jun 2022 11:31:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d680d000000b0021b93a483dbsm11215969wru.32.2022.06.27.11.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:33 -0700 (PDT)
Message-Id: <5dbe233e4ec2f404bb236a8ee71d24e8cb6a4387.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:13 +0000
Subject: [PATCH v4 12/16] bisect: teach the `bisect--helper` command to show
 the correct usage strings
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

In preparation for `bisect--helper` graduating to become the actual
`bisect` command, we hereby teach it to print the very same usage
strings as the scripted `git-bisect.sh` does.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 65 +++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 86195058cd5..1914aa7c69f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "cache.h"
-#include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
@@ -20,18 +19,46 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
-static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --bisect-reset [<commit>]"),
-	"git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]",
-	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
-					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
-	"git bisect--helper --bisect-next",
-	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
-	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
-	N_("git bisect--helper --bisect-replay <filename>"),
-	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
-	"git bisect--helper --bisect-visualize",
-	N_("git bisect--helper --bisect-run <cmd>..."),
+static const char *bisect_usage =
+	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
+	   "visualize|view|replay|log|run]");
+
+static const char * const bisect_long_usage[] = {
+	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
+	   "visualize|view|replay|log|run]\n"
+	   "\n"
+	   "git bisect help\n"
+	   "\tprint this long help message.\n"
+	   "git bisect start [--term-{new,bad}=<term> "
+		"--term-{old,good}=<term>]\n"
+	   "\t	 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] "
+		"[<pathspec>...]\n"
+	   "\treset bisect state and start bisection.\n"
+	   "git bisect (bad|new) [<rev>]\n"
+	   "\tmark <rev> a known-bad revision/\n"
+	   "\t	a revision after change in a given property.\n"
+	   "git bisect (good|old) [<rev>...]\n"
+	   "\tmark <rev>... known-good revisions/\n"
+	   "\t	revisions before change in a given property.\n"
+	   "git bisect terms [--term-good | --term-bad]\n"
+	   "\tshow the terms used for old and new commits "
+		"(default: bad, good)\n"
+	   "git bisect skip [(<rev>|<range>)...]\n"
+	   "\tmark <rev>... untestable revisions.\n"
+	   "git bisect next\n"
+	   "\tfind next bisection to test and check it out.\n"
+	   "git bisect reset [<commit>]\n"
+	   "\tfinish bisection search and go back to commit.\n"
+	   "git bisect (visualize|view)\n"
+	   "\tshow bisect status in gitk.\n"
+	   "git bisect replay <logfile>\n"
+	   "\treplay bisection log.\n"
+	   "git bisect log\n"
+	   "\tshow bisect log.\n"
+	   "git bisect run <cmd>...\n"
+	   "\tuse <cmd>... to automatically bisect.\n"
+	   "\n"
+	   "Please use \"git help bisect\" to get the full man page."),
 	NULL
 };
 
@@ -1317,7 +1344,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
+			     bisect_long_usage,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
 
 	switch (cmdmode ? cmdmode : BISECT_STATE) {
@@ -1368,13 +1395,15 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_run(&terms, argv, argc);
 		break;
 	case BISECT_STATE:
+		if (argc &&
+		    !file_is_not_empty(git_path_bisect_start()) &&
+		    !one_of(argv[0], "bad", "good", "new", "old", NULL))
+			usage(bisect_usage);
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
 		if (!cmdmode &&
-		    (!argc || check_and_set_terms(&terms, argv[0]))) {
-			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
-			usage_msg_opt(msg, git_bisect_helper_usage, options);
-		}
+		    (!argc || check_and_set_terms(&terms, argv[0])))
+			usage(bisect_usage);
 		res = bisect_state(&terms, argv, argc);
 		break;
 	default:
-- 
gitgitgadget

