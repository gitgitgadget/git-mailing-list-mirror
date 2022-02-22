Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E612C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiBVQbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE39167F98
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso2277237wmj.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ww5wUb8C1NNFa9kIf3WduYzn2764k0AZ5kVmtw0osZw=;
        b=J6a1socL865zKS+59+Vd8b9HjMcMvWG9MIPaAd6U+OC+b1h/VBVJfsm0KwZhq1PdSl
         ALfzk3yr8b+aqxfu2d/eK73I19sxd2LjkM5tWYd3X9Ta0DMPZZDeTFVTOphqpmNAVejM
         8P1PbSq7ItbI1HQUUvX8coLtvBfli+xhw2apzPBTvkpvGv5Dz4ipPS7mZdTpod5j3K0J
         Qie7ZJvD/jVoINVAe9LGi/y/zRG49otBTW208LKKwl94Phk5tX5py0NCY/5w6NSyCsY9
         PRJ3lcnjTPRFkC/RgWoDT5eAAL3SkRX3dKmdm7fK74z8SVPZc+J1s4zQUGnLCcgYKEXV
         x37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ww5wUb8C1NNFa9kIf3WduYzn2764k0AZ5kVmtw0osZw=;
        b=bRNxl1vmDtnkznYOI3GQKqlnXTH7NzQAGFuJjY2ZrbK+MDf2EbTl3deHYuHb11lBSj
         qxD9HR4goLiIdOWZeV6UbyDw/TqS7I+VBBOmigN6KpuZ3I10TbdK9utbaxMibQucEFN2
         IFg4yRP/rbYO39Ep1oBAfwfhIW9KyE0dtUw+6g2Mts83ZwjRtVpsuawHdpN0nouBdBDM
         rY35AtnFF1r/N2B3yffs8C2jNDcchCoWqzdAXFHyaoJ+wG5jgGo6J2zRNu0chAY7zEvT
         kM6aiVJf0SjbHbP6S3OdlpHA1BGECMirT/sHmHAVRl2DEYjfDeMBIi+jW7PjC13Xgo10
         EpDw==
X-Gm-Message-State: AOAM53111cDl7Hq1DdZXQU/uCvCgndhbQbxfb9J+ed4bamNsRzicFLGW
        AxOEueKMMX6DnkwXugcu27w84z55TAQ=
X-Google-Smtp-Source: ABdhPJxzClQFwOBaX9BuWIX/5qZrfaPEZhdfENCm7g6JjhXLtq+IvcZZ1yGxIGvehfsmKJKnQoFvHQ==
X-Received: by 2002:a05:600c:19d2:b0:37b:b8cc:5ca5 with SMTP id u18-20020a05600c19d200b0037bb8cc5ca5mr4116487wmq.22.1645547434912;
        Tue, 22 Feb 2022 08:30:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm42968039wrt.65.2022.02.22.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:34 -0800 (PST)
Message-Id: <7db4b03b66834ff78507303532af516206a22486.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:21 +0000
Subject: [PATCH v2 12/14] Turn `git bisect` into a full built-in
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

Now that the shell script hands off to the `bisect--helper` to do
_anything_ (except to show the help), it is but a tiny step to let the
helper implement the actual `git bisect` command instead.

This retires `git-bisect.sh`, concluding a multi-year journey that many
hands helped with, in particular Pranit Bauna, Tanushree Tumane and
Miriam Rubio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                               |  3 +--
 builtin.h                              |  2 +-
 builtin/{bisect--helper.c => bisect.c} |  8 +++---
 git-bisect.sh                          | 37 --------------------------
 git.c                                  |  2 +-
 5 files changed, 7 insertions(+), 45 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)
 delete mode 100755 git-bisect.sh

diff --git a/Makefile b/Makefile
index 5580859afdb..ce2eabeca58 100644
--- a/Makefile
+++ b/Makefile
@@ -595,7 +595,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1064,7 +1063,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 8a58743ed63..b5567ea3a9d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -116,7 +116,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
 int cmd_archive(int argc, const char **argv, const char *prefix);
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
+int cmd_bisect(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bisect--helper.c b/builtin/bisect.c
similarity index 99%
rename from builtin/bisect--helper.c
rename to builtin/bisect.c
index ef0b06d594b..1493d7d1d96 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -20,7 +20,7 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
-static const char * const git_bisect_usage[] = {
+static const char * const builtin_bisect_usage[] = {
 	N_("git bisect help\n"
 	   "\tprint this long help message."),
 	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
@@ -1182,7 +1182,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	}
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	int res = 0;
 	struct option options[] = {
@@ -1192,7 +1192,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	const char *command = argc > 1 ? argv[1] : "help";
 
 	if (!strcmp("-h", command) || !strcmp("help", command))
-		usage_with_options(git_bisect_usage, options);
+		usage_with_options(builtin_bisect_usage, options);
 
 	argc -= 2;
 	argv += 2;
@@ -1239,7 +1239,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		if (check_and_set_terms(&terms, command)) {
 			char *msg = xstrfmt(_("unknown command: '%s'"), command);
-			usage_msg_opt(msg, git_bisect_usage, options);
+			usage_msg_opt(msg, builtin_bisect_usage, options);
 		}
 		/* shift the `command` back in */
 		argc++;
diff --git a/git-bisect.sh b/git-bisect.sh
deleted file mode 100755
index 028d39cd9ce..00000000000
--- a/git-bisect.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-
-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
-LONG_USAGE='git bisect help
-	print this long help message.
-git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
-	reset bisect state and start bisection.
-git bisect (bad|new) [<rev>]
-	mark <rev> a known-bad revision/
-		a revision after change in a given property.
-git bisect (good|old) [<rev>...]
-	mark <rev>... known-good revisions/
-		revisions before change in a given property.
-git bisect terms [--term-good | --term-bad]
-	show the terms used for old and new commits (default: bad, good)
-git bisect skip [(<rev>|<range>)...]
-	mark <rev>... untestable revisions.
-git bisect next
-	find next bisection to test and check it out.
-git bisect reset [<commit>]
-	finish bisection search and go back to commit.
-git bisect (visualize|view)
-	show bisect status in gitk.
-git bisect replay <logfile>
-	replay bisection log.
-git bisect log
-	show bisect log.
-git bisect run <cmd>...
-	use <cmd>... to automatically bisect.
-
-Please use "git help bisect" to get the full man page.'
-
-OPTIONS_SPEC=
-. git-sh-setup
-
-exec git bisect--helper "$@"
diff --git a/git.c b/git.c
index edda922ce6d..a8500132a28 100644
--- a/git.c
+++ b/git.c
@@ -490,7 +490,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-- 
gitgitgadget

