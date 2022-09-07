Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A0EC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIGOiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIGOiI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:38:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7707B1C4
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:38:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b5so20724361wrr.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=nU05la8118E5qqcSfvjH2ePUu/UsC7r6OQ3Uqsd6xQg=;
        b=TtHqdHPPT0nl/13bmAkMPu2NtX57PuuB2VSvwbmGCQpKsqQS02v6hodY/DTahQJNpQ
         FWhwY6UcIERoI5RKYihhJBwXQzf4YOknzXG5zmb8yhX4con+fPsV2QS9m0bGY7MVRKCP
         m29UY40a+a12u46Qm/pZAw2epDPSvkiFREEdFnp/wPrPzbTfaimHZ23K4jQBh0Wa9wV9
         r82OygJtx6uJwSPUWgcswvP1K4xwEvSA3j7zlbusNiavjChf0FV6LsZDJG+96dB65XuT
         VyTVFu7v1CLREw8HS4KCeajtaZuAceoitmGtnCGodE1SgdpKwlIKq/meGPr1rZMhvCqN
         MPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nU05la8118E5qqcSfvjH2ePUu/UsC7r6OQ3Uqsd6xQg=;
        b=3VmqIxKmLYfQvxqCh3NfQet64Ar3N4mykNMjkgohqh5J12Qz3Pqy9rx2FJZ9Q63saM
         hGUIFQ+dKLP0lG1Ilf+Sd8iwnMm+Qwmdj/eZwGoqrlpfs/9avkrPhTxzrM5oTzEOfmf7
         hCR0543RY92GvHwIJ6b23Or/kNDYwYXlqj6yD38Z2BMkUKzaZ8JGp8pyhbANpBQwL2de
         QeGBx4EZ4IPyD2gXHZpEqmNay8erfJ3f2uPgzD2VqsnbEuEzHQh4GybwN0d/WdjR6MpV
         arFNILwMThEqXnyi5TYCswzXlvjZT1YmywpXT3ttoQTBLRD5yNbONhumLT29u8P2gHK5
         MwCw==
X-Gm-Message-State: ACgBeo0a9Q58/AQ6HXYlMNjGHHAwAu92nJ240Z4ChxzxVZZxKhRlh/Cl
        ALMwwvnwHxOrqLBJEbYx5cFsOLOq3b8=
X-Google-Smtp-Source: AA6agR4Ys5q1Sk1cUODithQRON0+IyIde1eLOHha+H+yPDw/lGeKMNBpDy8RBS0OpLDAMYJx1xhNIQ==
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id ay25-20020a5d6f19000000b00228d8e83ac8mr2229895wrb.101.1662561480231;
        Wed, 07 Sep 2022 07:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003a30fbde91dsm24671210wmp.20.2022.09.07.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:59 -0700 (PDT)
Message-Id: <faad7eaf0d62f084ec6c8dc6a057bb861a0e64eb.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:49 +0000
Subject: [PATCH v2 6/7] rebase --keep-base: imply --reapply-cherry-picks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As --keep-base does not rebase the branch it is confusing if it
removes commits that have been cherry-picked to the upstream branch.
As --reapply-cherry-picks is not supported by the "apply" backend this
commit ensures that cherry-picks are reapplied by forcing the upstream
commit to match the onto commit unless --no-reapply-cherry-picks is
given.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt     | 26 ++++++++++++++++----------
 builtin/rebase.c                 | 16 +++++++++++++++-
 t/t3416-rebase-onto-threedots.sh | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 080658c8710..ee6cdd56949 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,12 +218,14 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	merge base of `<upstream>` and `<branch>`. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
+	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
 upstream branch may advance and it may not be the best idea to keep
-rebasing on top of the upstream but to keep the base commit as-is.
+rebasing on top of the upstream but to keep the base commit as-is. As
+the base commit is unchanged this option implies `--reapply-cherry-picks`
+to avoid losing commits.
 +
 Although both this option and `--fork-point` find the merge base between
 `<upstream>` and `<branch>`, this option uses the merge base as the _starting
@@ -278,7 +280,8 @@ See also INCOMPATIBLE OPTIONS below.
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
 by `git log --cherry-mark ...`) are detected and dropped as a
-preliminary step (unless `--reapply-cherry-picks` is passed).
+preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
+passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -311,13 +314,16 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream changes, the behavior towards them is controlled by
 	the `--empty` flag.)
 +
-By default (or if `--no-reapply-cherry-picks` is given), these commits
-will be automatically dropped.  Because this necessitates reading all
-upstream commits, this can be expensive in repos with a large number
-of upstream commits that need to be read.  When using the 'merge'
-backend, warnings will be issued for each dropped commit (unless
-`--quiet` is given). Advice will also be issued unless
-`advice.skippedCherryPicks` is set to false (see linkgit:git-config[1]).
+
+In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
+given), these commits will be automatically dropped.  Because this
+necessitates reading all upstream commits, this can be expensive in
+repositories with a large number of upstream commits that need to be
+read. When using the 'merge' backend, warnings will be issued for each
+dropped commit (unless `--quiet` is given). Advice will also be issued
+unless `advice.skippedCherryPicks` is set to false (see
+linkgit:git-config[1]).
+
 +
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b5c78ce1fb0..204155bb25b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1180,6 +1180,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
+	options.reapply_cherry_picks = -1;
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
@@ -1239,6 +1240,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.root)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
 	}
+	/*
+	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
+	 * commits when using this option.
+	 */
+	if (options.reapply_cherry_picks < 0)
+		options.reapply_cherry_picks = keep_base;
 
 	if (options.root && options.fork_point > 0)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
@@ -1415,7 +1422,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	if (options.reapply_cherry_picks)
+	/*
+	 * --keep-base implements --reapply-cherry-picks by altering upstream so
+	 * it works with both backends.
+	 */
+	if (options.reapply_cherry_picks && !keep_base)
 		imply_merge(&options, "--reapply-cherry-picks");
 
 	if (gpg_sign)
@@ -1678,6 +1689,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				options.onto_name);
 		fill_branch_base(&options, &branch_base);
 	}
+	if (keep_base && options.reapply_cherry_picks)
+		options.upstream = options.onto;
+
 	if (options.fork_point > 0)
 		options.restrict_revision =
 			get_fork_point(options.upstream_name, options.orig_head);
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 01eb9513d6c..ea501f2b42b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -199,6 +199,27 @@ test_expect_success 'rebase --keep-base requires a single merge base' '
 	grep "need exactly one merge base with branch" err
 '
 
+test_expect_success 'rebase --keep-base keeps cherry picks' '
+	git checkout -f -B main E &&
+	git cherry-pick F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base HEAD G
+	) &&
+	test_cmp_rev HEAD G
+'
+
+test_expect_success 'rebase --keep-base --no-reapply-cherry-picks' '
+	git checkout -f -B main E &&
+	git cherry-pick F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --keep-base \
+					--no-reapply-cherry-picks HEAD G
+	) &&
+	test_cmp_rev HEAD^ C
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

