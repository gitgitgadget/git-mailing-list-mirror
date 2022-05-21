Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183A9C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355397AbiEUOtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355333AbiEUOt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED36CF70
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h5so13818882wrb.11
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AZfg7ldQb3mykbJM/3Wnop0ik5mI6PV69CBzGVDQxR4=;
        b=aNY5fhXZDKfAhNvmbLtVIHipw72i5Vn3KRru1n9fwcQ2N3cuukR+tCRvEdC0qVa+ve
         DRvyYTJq2xHTJM6XEJ5xTPiGl0gDjl8Pdt5M8ZoBTAYbKS7YAZGR7w8kEW7uaziO3qwO
         ZJ9LbczZtNoAJ902WZ/o93trjdEclCgY87SsM9pmYnWZU/9tz8G3LoGKHvF7CgFQCo0E
         R64Vxraa7KIHPu4qhVZwWYFzMjX1NXNS3A3+tcFMkTSROoojlXvly52D/31spKhJccin
         /GbHPfbacKTKQfS0hvHbOuHk4e6xqfb/oUAjN66wc2eV7rI7eLsRrQL5XpOkGAIhumvc
         ODew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AZfg7ldQb3mykbJM/3Wnop0ik5mI6PV69CBzGVDQxR4=;
        b=E9e7b53GgfPE6WDUQuYLUb1wYO4s8tUQQlcYtnEokeBttj04wElqb/z8wRBiSt7JtA
         C5DWvCwKeE1KoGVkX/tnlmQg9XJnzothLYiHGuiiSu80cH2yPJn0ngKxDz6CshSEdsL8
         y4NTSPtB6tyosBX8arRf1exNd/vdJPAX3y1v3B/Js9Ny5gXcDB0MEYtlGMl57/DETBLY
         RdcwmMMUBMbSxleSI2NCfNdLpSuroGhey+b6H0kSDUqx/ep++h62lrn9Wjj00WVzB8/2
         y21jKUBvBmLamK+FaO6qavvUC8tTUj8w3Ape1vo8i4KRGnc67p2tYKOuoKNrvIli+T7I
         x6Yw==
X-Gm-Message-State: AOAM531hvaVrDNTlQqqlIr/fvDAICqWwvlVnUUcCFFP1CzanHTmoPkEN
        SVkoo6dRLQ6dJ4F8a9jYP4VKOSEl++I=
X-Google-Smtp-Source: ABdhPJyCZKkJW9r1VUuPMKhbGephGMLFZkG8ogq1l9U7lf3Fv95oCZJqE/aoeSYGgi8Clv885Mullg==
X-Received: by 2002:a5d:4e50:0:b0:20f:ca28:358f with SMTP id r16-20020a5d4e50000000b0020fca28358fmr2321595wrt.449.1653144561142;
        Sat, 21 May 2022 07:49:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11-20020adfc74b000000b0020e68218048sm5610177wrh.93.2022.05.21.07.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:20 -0700 (PDT)
Message-Id: <4ae78d37d04789b2cadb059088e59af80a850c15.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:02 +0000
Subject: [PATCH v3 11/15] bisect: move even the command-line parsing to
 `bisect--helper`
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

On our journey to a fully built-in `git bisect`, this is the
one of the last steps.

Side note: The `parse-options` API is not at all set up to parse
subcommands such as `git bisect start`, `git bisect reset`, etc.
Instead of fighting an up-hill battle trying to "fix" that, we simply
roll the same type of manual subcommand parsing as we already do e.g.
in `builtin/bundle.c`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 91 ++++++++++++----------------------------
 git-bisect.sh            | 49 +---------------------
 2 files changed, 27 insertions(+), 113 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 824f84ae76f..89ff688a4a2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1276,108 +1276,69 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_START = 1,
-		BISECT_STATE,
-		BISECT_TERMS,
-		BISECT_SKIP,
-		BISECT_NEXT,
-		BISECT_RESET,
-		BISECT_VISUALIZE,
-		BISECT_REPLAY,
-		BISECT_LOG,
-		BISECT_RUN,
-	} cmdmode = 0;
 	int res = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+	const char *command = argc > 1 ? argv[1] : "help";
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
+	if (!strcmp("-h", command) || !strcmp("help", command))
+		usage_with_options(git_bisect_helper_usage, options);
 
-	switch (cmdmode ? cmdmode : BISECT_STATE) {
-	case BISECT_START:
+	argc -= 2;
+	argv += 2;
+
+	if (!strcmp("start", command)) {
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
-		break;
-	case BISECT_TERMS:
+	} else if (!strcmp("terms", command)) {
 		if (argc > 1)
-			die(_("--bisect-terms requires 0 or 1 argument"));
+			die(_("'terms' requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
-		break;
-	case BISECT_SKIP:
+	} else if (!strcmp("skip", command)) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
 		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_NEXT:
+	} else if (!strcmp("next", command)) {
 		if (argc)
-			die(_("--bisect-next requires 0 arguments"));
+			die(_("'next' requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
-		break;
-	case BISECT_RESET:
+	} else if (!strcmp("reset", command)) {
 		if (argc > 1)
-			die(_("--bisect-reset requires either no argument or a commit"));
+			die(_("'reset' requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
-		break;
-	case BISECT_VISUALIZE:
+	} else if (one_of(command, "visualize", "view", NULL)) {
 		get_terms(&terms);
 		res = bisect_visualize(&terms, argv, argc);
-		break;
-	case BISECT_REPLAY:
+	} else if (!strcmp("replay", command)) {
 		if (argc != 1)
 			die(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
-		break;
-	case BISECT_LOG:
+	} else if (!strcmp("log", command)) {
 		if (argc)
-			die(_("--bisect-log requires 0 arguments"));
+			die(_("'log' requires 0 arguments"));
 		res = bisect_log();
-		break;
-	case BISECT_RUN:
+	} else if (!strcmp("run", command)) {
 		if (!argc)
 			die(_("bisect run failed: no command provided."));
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
-		break;
-	case BISECT_STATE:
+	} else {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		if (!cmdmode &&
-		    (!argc || check_and_set_terms(&terms, argv[0]))) {
-			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
+		if (check_and_set_terms(&terms, command)) {
+			char *msg = xstrfmt(_("unknown command: '%s'"), command);
 			usage_msg_opt(msg, git_bisect_helper_usage, options);
 		}
+		/* shift the `command` back in */
+		argc++;
+		argv--;
 		res = bisect_state(&terms, argv, argc);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
 	}
+
 	free_terms(&terms);
 
 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index fbf56649d7d..028d39cd9ce 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,51 +34,4 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-TERM_BAD=bad
-TERM_GOOD=good
-
-get_terms () {
-	if test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		{
-		read TERM_BAD
-		read TERM_GOOD
-		} <"$GIT_DIR/BISECT_TERMS"
-	fi
-}
-
-case "$#" in
-0)
-	usage ;;
-*)
-	cmd="$1"
-	get_terms
-	shift
-	case "$cmd" in
-	help)
-		git bisect -h ;;
-	start)
-		git bisect--helper --bisect-start "$@" ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper "$cmd" "$@" ;;
-	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
-	next)
-		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
-	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
-	reset)
-		git bisect--helper --bisect-reset "$@" ;;
-	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
-	log)
-		git bisect--helper --bisect-log || exit ;;
-	run)
-		git bisect--helper --bisect-run "$@" || exit;;
-	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
-	*)
-		usage ;;
-	esac
-esac
+exec git bisect--helper "$@"
-- 
gitgitgadget

