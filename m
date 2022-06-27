Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199DC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbiF0ShL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbiF0Sga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3DE13E03
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 189so5493964wmz.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/lcBQOqeRg76SKYk+xD2etkKLEfQ0I5qEgFQ6WV8kMQ=;
        b=E0ABHq/37zTbkCJ9P5sIm4WaP1IgHAlPmypLm0Ih5aba6d0LeS3Wz95RHKle+1Xyt4
         64KSbfnhcJbNuPFLXArZkne/zJ+hIW6wU4Dnt1b3Ua4G3QKHc7HUN915SNT3+8qss9ud
         eL0jJAr/D41T9Qx89SVD9ozXS/0Xaxc1MD0Mgy+RL0SE47d+bcJwxisl+fE7HdlBcI/I
         5amjHR/e/P2nLYa8WqBUeHCEpE6lH2tgVe7mWc3d3C2B2lr49VjU9EBIrSxhSkOZ8BXu
         GHosTAQa/ljt0600IYRT3ZTTRhthV/2Zakw+MM/dI6uDChmcBDJTezcgYHqH38BJLpnU
         M60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/lcBQOqeRg76SKYk+xD2etkKLEfQ0I5qEgFQ6WV8kMQ=;
        b=m+G7sctE3X9kCVU6wQ4ySBy4IvccIOJ5VYHVl6kx7CwPMaBc1UTpd0xoYeV8P24JLQ
         Cc3+gj/cJfXVdkG9Mz+AyyV8uZrbD/MA7Xct9R/2VXn1FE96EM96Oc6uvzOpLKi7fIzY
         VWZSLUJTLkM1nw9YdvT0zIvkowfZmWiuhhbdzzBHgy4/XmG1+UJ54yycoARzZk0Gzh2Y
         E9YcHfjyq376kaijA80kIGj+UGaA9luDow1uMtfkuLhwIzCoIy8gpRfLtZBbF2ZWFPPt
         +OsDCNDp1JWL15PfNHUo+pbCfrPPvI2qPBcQ+2m3CNjZ1aVfm4vvdX6iUc+2mZFRWfbe
         nEfQ==
X-Gm-Message-State: AJIora+PB2T7n49VpBbDfFmVXk4oxRvpRR7YO8/TY3Dox+ZurZaCFU0P
        jaDtl23MYrpgQxgBpHj2yW+Kxuk28fHA9Q==
X-Google-Smtp-Source: AGRyM1uClBdPHurLPXAVVDNWW9nnTub80avxcXsFVewIch7byvEMF6+A4VQt+SCTouZWzTTxUYs+Xw==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr16944551wmh.154.1656354696339;
        Mon, 27 Jun 2022 11:31:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d4acc000000b0021b9416fa13sm12715154wrs.90.2022.06.27.11.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:35 -0700 (PDT)
Message-Id: <378d6d227372405326112fee03c377f1aff386fc.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:15 +0000
Subject: [PATCH v4 14/16] Turn `git bisect` into a full built-in
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
index 04d0fd1fe60..3462bad4f15 100644
--- a/Makefile
+++ b/Makefile
@@ -619,7 +619,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1119,7 +1118,7 @@ BUILTIN_OBJS += builtin/am.o
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
index 7232d650905..380fef852f3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1301,7 +1301,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
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
index d7a7a82008b..1ad501058a8 100644
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

