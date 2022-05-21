Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F34C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355323AbiEUOtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355335AbiEUOt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B06CF7B
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r23so14980491wrr.2
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xOuCTQ8othQu7M3wU3lEArKTkeDfPToh5569gOStC3g=;
        b=JF/QizqiRMX1/BReeVZPdrOtE6mlaRHt+uW/w9SS+PgE+rC0eg1+Bq0Yk851Ze1UIV
         gRQdlHyTEbph3uVhsq6xs66xRjK35QYrUCrUiO3IGQOsB57RWmdA1ob9a4+AzRyMdA34
         Il4yMW613OMlY9BxGe+KXSXy5YuTulVBI5iEoeO6S7PojJqoJn8yJHPCMJAN7Zhjs9b7
         fdCWcSPGRG9wtbPf4FZI4Ol0laQQm601bEzm+RMl4LqmFbklZ9ga5lQkLooZ6tq9YeHb
         djQeul8D63lZbk6jmOW4MNSeFw/IKtDe+TORtgKPHlDIrREsZOvVqDNMtChX4jt0s3Lq
         NKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xOuCTQ8othQu7M3wU3lEArKTkeDfPToh5569gOStC3g=;
        b=OkZ/duiwBCalyc53BkDxv8bABac9xF+b/uSkQ+eC2OVBs9VeXK+9Ulco/sOp969TZE
         GL/4WTkZUf4kLw4DHpLsKoSFBgKNjtiKdAEVtzU+qwp3z7OLVwXwH082227k0bW4o+S+
         4bsRS9LT05FCtwNVDgVXkR4fAZrq83EyAEqFZlKD0AGQUhKhUSLEHpAdKb0Z8tWIoYEp
         VXTOylqDgJ2VbVK5/ZniEsnrnBvZ444LeO5ivdpFtaUktJOLD4eYhAdLtyr41Ivmn3Gg
         BU7SCSyplJzmiHIVnAnVuNcrsweshWk8xrtC4+0F6K9MxnyTI1Zj75LrwTDAG3y4+p0D
         GnZg==
X-Gm-Message-State: AOAM532nkL/tN05VgyPpkQjs1De7MA8EKYZE9nRvwVbVgVhcY0kUdy+i
        WveeUyoQA/eEOn2GLo53Ciwro6TmpZs=
X-Google-Smtp-Source: ABdhPJy+AlvLhjrQvtfM+uWYhYr8raKQ1z6mGfxLGvA09sdNRYL/TBeh3dzxgWJZfIf7Mdtjpe6t/g==
X-Received: by 2002:a05:6000:1a85:b0:20c:7ba1:737b with SMTP id f5-20020a0560001a8500b0020c7ba1737bmr12239595wry.209.1653144562236;
        Sat, 21 May 2022 07:49:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c211100b003942a244f4fsm4387954wml.40.2022.05.21.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:21 -0700 (PDT)
Message-Id: <ac472aefb6af0670cc9fa498e57145aec9ae6c47.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:03 +0000
Subject: [PATCH v3 12/15] bisect: teach the `bisect--helper` command to show
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for `bisect--helper` graduating to become the actual
`bisect` command, we hereby teach it to print the very same usage
strings as the scripted `git-bisect.sh` does.

With this patch, the `bisect--helper` command is able to do everything
that the `git-bisect.sh` script could, leaving as last step only to
retire that script at long last, which we will do in the next commit.

Note: Since we cannot use the `parse-options` API to handle the
subcommands of `git bisect` anyway, we no longer use it even just to
show the usage string anymore, either.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 69 ++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 89ff688a4a2..a68f2c5a919 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "cache.h"
-#include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
@@ -20,20 +19,46 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
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
-	NULL
-};
+static const char *bisect_usage =
+	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
+	   "visualize|view|replay|log|run]");
+
+static const char *bisect_long_usage =
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
+	   "Please use \"git help bisect\" to get the full man page.");
 
 struct add_bisect_ref_data {
 	struct rev_info *revs;
@@ -1277,14 +1302,11 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int res = 0;
-	struct option options[] = {
-		OPT_END()
-	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 	const char *command = argc > 1 ? argv[1] : "help";
 
 	if (!strcmp("-h", command) || !strcmp("help", command))
-		usage_with_options(git_bisect_helper_usage, options);
+		usage(bisect_long_usage);
 
 	argc -= 2;
 	argv += 2;
@@ -1327,12 +1349,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 	} else {
+		if (!file_is_not_empty(git_path_bisect_start()) &&
+		    !one_of(command, "bad", "good", "new", "old", NULL))
+			usage(bisect_usage);
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		if (check_and_set_terms(&terms, command)) {
-			char *msg = xstrfmt(_("unknown command: '%s'"), command);
-			usage_msg_opt(msg, git_bisect_helper_usage, options);
-		}
+		if (check_and_set_terms(&terms, command))
+			usage(bisect_usage);
 		/* shift the `command` back in */
 		argc++;
 		argv--;
-- 
gitgitgadget

