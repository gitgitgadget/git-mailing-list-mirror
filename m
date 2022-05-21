Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4489C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355321AbiEUOt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355342AbiEUOta (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94B6CF51
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so14953189wra.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJwNNNqAeh0XsOJhXXlCEFiY+grfskTHoM+y0Zqn21s=;
        b=hmKRoNFDe8ngvI9cRUn4hd5h8fKC2ffCeit3PLZYOdx8ayiFQyLGr/+d65L8WZRA4i
         soHqEpW3ORgbVpSw99vCvIeetPr5yJHr/UE59pamEWzqfhOL+Qe5+mOZSurDGaRFy5n1
         +AaTGjs9P34mtkynHUD3pYbQIjcAa+blA3L1X3vxf8dtot3IOGvNUQNrYXSDBzyTPXLy
         Z5hVP1IDwNTDivhTdlJ/hd+BBlCrwURngbRtFfkGBkW5LRxkwsggTKWB3R+Nhk0W3bn8
         PqTut84PYtePynvB6UDJZIRvlUOA0Y45exFgXu/qoMEq4DEc6i+mKDNp9h3ecUbN146c
         BaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJwNNNqAeh0XsOJhXXlCEFiY+grfskTHoM+y0Zqn21s=;
        b=SbdFx391eezEpINvbCS284Gpdg5p9w4LW5NfsB7GrYBhhHO7xvXQC3v5sQvpb+NEiF
         TBrpXmHVTNKxud4/i8FC5SQqCh5siUD3ehkumJ7OLZCKAxgyg3k+kAc6+YVwS4DVYZhI
         3oenYCmt+6q03wWfOL5Cgt99x6kd6oDj8KYvgG+sK4lA1YttdeLlO5D7/IVbnrbJET5B
         lA7wlPoJSSewSR/XEoRoo2H/9/TBQFQ/q7pAXQzQ7ZS5D+YOdSrt+KfjeJR49WcDPuKq
         0PHKHMgEl1Z+tVfur6G2iae9UVscFzTZtF8buKV966Dn8a/sJjxhBOm6/Ji344TizqWG
         70tw==
X-Gm-Message-State: AOAM5335E7ufmlzYsprIGvZ9+CcBM9Wf2AsFIDpszd1LqIzih7LhSfiY
        SUi6KnPYF/sUD9881GbdIz2l9uKHXyk=
X-Google-Smtp-Source: ABdhPJxMOTyUM5UuHezsIYQG09Yo5IIMEolRLOpUuj3zE7iF6c7k1AcmizKWn7CQSv7eNqI6Td1W8Q==
X-Received: by 2002:a5d:6484:0:b0:20f:cc0b:e3f1 with SMTP id o4-20020a5d6484000000b0020fcc0be3f1mr1849091wri.237.1653144563326;
        Sat, 21 May 2022 07:49:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b00394975e14f4sm4573378wmr.8.2022.05.21.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:22 -0700 (PDT)
Message-Id: <85f5c256ae3e1014d42b3f76e16224a375f64360.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:04 +0000
Subject: [PATCH v3 13/15] Turn `git bisect` into a full built-in
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
 builtin/{bisect--helper.c => bisect.c} |  2 +-
 git-bisect.sh                          | 37 --------------------------
 git.c                                  |  2 +-
 5 files changed, 4 insertions(+), 42 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)
 delete mode 100755 git-bisect.sh

diff --git a/Makefile b/Makefile
index 61aadf3ce88..824b8a43576 100644
--- a/Makefile
+++ b/Makefile
@@ -611,7 +611,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1107,7 +1106,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc8485..b9470f8ab4f 100644
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
index a68f2c5a919..d33de133c8c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1299,7 +1299,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	return res;
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	int res = 0;
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
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
index 5ff4f3e25b7..40ed082e621 100644
--- a/git.c
+++ b/git.c
@@ -492,7 +492,7 @@ static struct cmd_struct commands[] = {
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

