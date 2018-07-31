Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACA71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeGaTmU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52027 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeGaTmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so4090259wma.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ocIk5NBzDJJKozRHCSoC/sBzEhFlXWXLJgYzWvNz7hs=;
        b=eIE6fsRWXhsU96+inlMTA1UVbSrbIgTaqKpjLIwEc75yD5z5yftTUDFvGHLD6hlf6h
         A2oOtmcAO+cCvFcpVdWLPJL01RT3yuQ+PBL2nR+qrn1S/DlzLE9gV+nbkPOMhm9GgK0j
         5PzPRova6UjeYZw7VDo9ns2Ayi48mQ3TNZZfHijNkiAJabJJwLiteMq1zifRDfvfhTVS
         RZK21UsLYQidkt94voZJ08fRyCcYVv0EAYhNXOVyTliiVR2bp5T2jlhAwLkp4lSlZsPi
         +o5DmwON1XXUQxaBMQj469Z3oe/E33AxSFCAbFjISsfbXBLxEG9OWibCs3DIU+NzOdN2
         GE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ocIk5NBzDJJKozRHCSoC/sBzEhFlXWXLJgYzWvNz7hs=;
        b=H9+RSXMYArlYQXJ/zzYtWd5uK5kmbw9NI2jzBga0uaSnEyii/aps3WcNd0umFp4J26
         YSVa3DGiUNMUls8fvuFhitM/g/aSx6qmZ1yoWtSKtwmf1V9mfTtH9jTcbjkDXu22rapV
         KgYM7/Z1IUvn3fqgg8+0fH2dimrKqSmeyswnsz77cM2/ggGP8l030dzDr8gxkKW7nOj8
         gIHVf+D7HEbrttVQCWR0+8excEDyl9sQE2otafq1CJjri4qRRMVGrVtWe+7wN82l8+uo
         c+lEvnJCprpQVgEcXITUbQFqlCr28Lk/4eY+gULZuyWmdJRh+VIUgkORqINJjilU6Oaa
         Cpjg==
X-Gm-Message-State: AOUpUlGwVxKoMcmYfDVOZz5evv71RN/7BVxZKsJzZkBjNxoAcBrlSTZJ
        LLOYO1vcjmfSVgO0FRJH155Sz6Aa
X-Google-Smtp-Source: AAOMgpcM20AbPZ9tGr3wGXs5V30dIjfh1PWDHOQykrug7vGvcWhQio+/6p8UBpoCwVg9gufTlsjB6g==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr477864wmy.11.1533060050444;
        Tue, 31 Jul 2018 11:00:50 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:49 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 19/20] rebase -i: remove git-rebase--interactive.sh
Date:   Tue, 31 Jul 2018 20:00:02 +0200
Message-Id: <20180731180003.5421-20-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes git-rebase--interactive.sh, as its functionnality has been
replaced by git-rebase--interactive2.

git-rebase--interactive2.c is then renamed to git-rebase--interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v4.

 .gitignore                                    |  1 -
 Makefile                                      |  4 +-
 ...--interactive2.c => rebase--interactive.c} |  0
 git-rebase--interactive.sh                    | 84 -------------------
 git-rebase.sh                                 |  2 +-
 git.c                                         |  2 +-
 6 files changed, 3 insertions(+), 90 deletions(-)
 rename builtin/{rebase--interactive2.c => rebase--interactive.c} (100%)
 delete mode 100644 git-rebase--interactive.sh

diff --git a/.gitignore b/.gitignore
index 404c9a8472..3284a1e9b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,7 +118,6 @@
 /git-rebase--am
 /git-rebase--helper
 /git-rebase--interactive
-/git-rebase--interactive2
 /git-rebase--merge
 /git-rebase--preserve-merges
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 71f8f45fe5..584834726d 100644
--- a/Makefile
+++ b/Makefile
@@ -619,7 +619,6 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
-SCRIPT_LIB += git-rebase--interactive
 SCRIPT_LIB += git-rebase--preserve-merges
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
@@ -1060,8 +1059,8 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/rebase--interactive2.o
 BUILTIN_OBJS += builtin/rebase--helper.o
+BUILTIN_OBJS += builtin/rebase--interactive.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
@@ -2400,7 +2399,6 @@ XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
-LOCALIZED_SH += git-rebase--interactive.sh
 LOCALIZED_SH += git-rebase--preserve-merges.sh
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive.c
similarity index 100%
rename from builtin/rebase--interactive2.c
rename to builtin/rebase--interactive.c
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
deleted file mode 100644
index e87d708a4d..0000000000
--- a/git-rebase--interactive.sh
+++ /dev/null
@@ -1,84 +0,0 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its interactive mode.  "git rebase --interactive" makes it easy
-# to fix up commits in the middle of a series and rearrange commits.
-#
-# Copyright (c) 2006 Johannes E. Schindelin
-#
-# The original idea comes from Eric W. Biederman, in
-# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
-#
-# The file containing rebase commands, comments, and empty lines.
-# This file is created by "git rebase -i" then edited by the user.  As
-# the lines are processed, they are removed from the front of this
-# file and written to the tail of $done.
-todo="$state_dir"/git-rebase-todo
-
-GIT_CHERRY_PICK_HELP="$resolvemsg"
-export GIT_CHERRY_PICK_HELP
-
-# Initiate an action. If the cannot be any
-# further action it  may exec a command
-# or exit and not return.
-#
-# TODO: Consider a cleaner return model so it
-# never exits and always return 0 if process
-# is complete.
-#
-# Parameter 1 is the action to initiate.
-#
-# Returns 0 if the action was able to complete
-# and if 1 if further processing is required.
-initiate_action () {
-	case "$1" in
-	continue)
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-		     --continue
-		;;
-	skip)
-		git rerere clear
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-		     --continue
-		;;
-	edit-todo)
-		exec git rebase--helper --edit-todo
-		;;
-	show-current-patch)
-		exec git show REBASE_HEAD --
-		;;
-	*)
-		return 1 # continue
-		;;
-	esac
-}
-
-git_rebase__interactive () {
-	initiate_action "$action"
-	ret=$?
-	if test $ret = 0; then
-		return 0
-	fi
-
-	test -n "$keep_empty" && keep_empty="--keep-empty"
-	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
-	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
-	test -n "$autosquash" && autosquash="--autosquash"
-	test -n "$verbose" && verbose="--verbose"
-	test -n "$force_rebase" && force_rebase="--no-ff"
-	test -n "$restrict_revisions" && restrict_revisions="--restrict-revisions=^$restrict_revisions"
-	test -n "$upstream" && upstream="--upstream=$upstream"
-	test -n "$onto" && onto="--onto=$onto"
-	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
-	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
-	test -n "$head_name" && head_name="--head-name=$head_name"
-	test -n "$strategy" && strategy="--strategy=$strategy"
-	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
-	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
-	test -n "$cmd" && cmd="--cmd=$cmd"
-
-	exec git rebase--interactive2 "$keep_empty" "$rebase_merges" "$rebase_cousins" \
-		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
-		"$allow_empty_message" "$autosquash" "$verbose" \
-		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
-		"$strategy_opts" "$cmd" "$switch_to" \
-		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
-}
diff --git a/git-rebase.sh b/git-rebase.sh
index d5950a3012..a707d59412 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -223,7 +223,7 @@ run_interactive () {
 	test -n "$cmd" && cmd="--cmd=$cmd"
 	test -n "$action" && action="--$action"
 
-	exec git rebase--interactive2 "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
+	exec git rebase--interactive "$action" "$keep_empty" "$rebase_merges" "$rebase_cousins" \
 		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
 		"$allow_empty_message" "$autosquash" "$verbose" \
 		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
diff --git a/git.c b/git.c
index 8309fb24a6..19d0b6e3b8 100644
--- a/git.c
+++ b/git.c
@@ -518,7 +518,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-	{ "rebase--interactive2", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
+	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
2.18.0

