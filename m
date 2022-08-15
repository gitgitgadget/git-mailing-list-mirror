Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB14C25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiHOPLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiHOPLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:11:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4992019B
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay12so3979042wmb.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=yDcfO/3KwB+tt7IYfPSzNWG2EwOg9CJOS9nc2eiK7Dw=;
        b=S1oSsyRjB4xXaQIeRrlipYVoro75zMY+cPTUgYrqwPdJpIfObupjXgwu7nAUdPs4QB
         Os9Z7eNJtalprXkQg6eoGz65PbnOQvkQc/uJf+QoOx5l242xbxRoKPwuFgWHd/onbOiw
         AUVmMTzwUeg3llLYdurP3JoQyGBh8yFmBxmv+2mIQ4Ox91/gjrD5VS6zYFZgDV8ZZy7c
         aMqm5mMHG2Gme9mgqdGWoSZbfzfoTbgpw2LI01/nthWYvDOVZDBY2wwnkejpNHts1QkU
         aRpnoQcImMbem7JECKUY7W2J4C1s9EwKwpvKVT8qIuArvAnmF061G2idFH/1fBwoEygm
         7C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=yDcfO/3KwB+tt7IYfPSzNWG2EwOg9CJOS9nc2eiK7Dw=;
        b=UwLkAt05Iiy9uHnQ+jm4vTY87fXV9S9ahqcL4dvzFNk6aK71mwTx1Sxgo+huHXvN47
         iGSjWpdaRp+3gy3JtE65IcRBLow+9S9X4qX1oWhyWtiAz7ii5L68TYwNG4RTlZBwWcYn
         F+BrX5keEL4fWpuMgtb6LSmoiKlYPiIaYqK/hWdUrskVjodJDKf/z2UhKH3MXBr6X0F/
         hA5eIiuTSw2l94cJ1ozV6NVWUVGDrDGiLKbNP3PuyCSWHfCebNERwT7Ccr08viA2asyp
         IPYrGl9EztsEbCBWoExPFF2CHpyePrRn/Il7AVsmIjn9Tt2M0PJE6TPyRDjR393nv5//
         OF6Q==
X-Gm-Message-State: ACgBeo0CsN5in1S+rZ1eDRzSZS0ogMQ28d6B7xAa9avtqsSOrf2Cx3Va
        ioSb872kk90jU5WlKHh80+/4W55bVjQ=
X-Google-Smtp-Source: AA6agR6W4WJjtPH6CxWihsN9YCRtFpCx4VprB9tvhbaozPsRQPHT0S6I9Kgjx5SPjUX7a9KMrXgHPg==
X-Received: by 2002:a1c:7512:0:b0:3a4:f09d:1cf7 with SMTP id o18-20020a1c7512000000b003a4f09d1cf7mr16568168wmc.67.1660576289198;
        Mon, 15 Aug 2022 08:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128-20020a1ca486000000b003a540fef440sm9842117wme.1.2022.08.15.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:11:28 -0700 (PDT)
Message-Id: <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:11:22 +0000
Subject: [PATCH 4/5] rebase --keep-base: imply --reapply-cherry-picks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 Documentation/git-rebase.txt     |  2 +-
 builtin/rebase.c                 | 15 ++++++++++++++-
 t/t3416-rebase-onto-threedots.sh | 21 +++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 080658c8710..dc0c6c54e27 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	merge base of `<upstream>` and `<branch>`. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
+	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 86ea731ca3a..b6b3e00e3b1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1181,6 +1181,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
+	options.reapply_cherry_picks = -1;
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
@@ -1240,6 +1241,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.root)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
 	}
+	/*
+	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
+	 * commits disappear when using this option.
+	 */
+	if (options.reapply_cherry_picks < 0)
+		options.reapply_cherry_picks = keep_base;
 
 	if (options.root && options.fork_point > 0)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
@@ -1416,7 +1423,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1680,6 +1691,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 	if (keep_base) {
 		oidcpy(&merge_base, &options.onto->object.oid);
+		if (options.reapply_cherry_picks)
+			options.upstream = options.onto;
 	} else {
 		fill_merge_base(&options, &merge_base);
 	}
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index e1fc2dbd48e..e0410bfc2a8 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -197,6 +197,27 @@ test_expect_success 'rebase -i --keep-base main from side' '
 	test_must_fail git rebase -i --keep-base main
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

