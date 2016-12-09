Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5331FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 11:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933254AbcLILfx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 06:35:53 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34026 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbcLILfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 06:35:51 -0500
Received: by mail-pf0-f196.google.com with SMTP id y68so1105692pfb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 03:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiqFSkmbT2iVPBAxq2yCnDphWojqEHEO/HDiQXeWMoQ=;
        b=qk5P9Z3FNXpO+6l33v4L78NjG72el108cVrX53mZAh0VQz6ijx19buOXT600hwTJDT
         QVAyDKwjYsfphGFA3/I8povLTe2efFS14C+Lvmk/EszPc9HaSh4z6sGWmjeU38xjm61B
         l61dc6sW4H1MKemuEq65zh9URcf4dYp0tHC4LRVZYpR1eLgOqOULhjkkj+vtu69OUN82
         2eJr/5k4PX3Ve7LbshXYoW0K6IrFl/nZSE8lnuHaSA9ATnzkwRpGrapb6bBtS67mfhFR
         xHEqWDHyd75dWG7c/Flx6ekSNAZ4ti7wQ4COUAn8ewARMdgIg7RMkC5YCwbIyIjBO8kp
         48yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiqFSkmbT2iVPBAxq2yCnDphWojqEHEO/HDiQXeWMoQ=;
        b=X1IKYWJq88w4p9RtXckCVNcBw8H1XI9/2ZKH7BblI1i7I9sMgQsiPROViFwSmBY94E
         Y841TNK6bqFTzjFxPvfQgaTOW2U1gxbxidxUhb/YWXWbSJvIHgx38BcP+E4O41VE5pz8
         xGB7xaC3nJmNmoh6iHYGOVKzxtF9oKeie2kdZPHq47htBYEJzLwvg1QFWg9vwHSpVhWA
         Bw+f5NlYdHsEQ3BGyHXI9UfsHuw6aD2XNKax1AKmyiAZ7tCpsZ5BBLzXnqW/WK5ZoPvs
         sSIp6pBnB3RkuoQPzvsQfc1jpYeNcfxvT2bddcXTBVwFZh/YBEVti8f5kR4MskMAGWCS
         7Zfg==
X-Gm-Message-State: AKaTC02/0aS1qU4rXawrfXqhxGYr5RMeQYEtudfcnZyGB6r2HggCB8dHKGebn6R6US+Q4g==
X-Received: by 10.99.38.3 with SMTP id m3mr141910870pgm.113.1481283350959;
        Fri, 09 Dec 2016 03:35:50 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id t193sm57414136pgb.4.2016.12.09.03.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 03:35:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Dec 2016 18:35:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, s-beyer@gmx.net,
        christian.couder@gmail.com, szeder@ira.uka.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] revert, cherry-pick: rename --quit to be consistent with rebase
Date:   Fri,  9 Dec 2016 18:34:27 +0700
Message-Id: <20161209113427.6039-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161209113427.6039-1-pclouds@gmail.com>
References: <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
 <20161209113427.6039-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old --quit remains supported, just hidden away.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-cherry-pick.txt      |  2 +-
 Documentation/git-revert.txt           |  2 +-
 Documentation/sequencer.txt            |  2 +-
 builtin/revert.c                       |  7 +++++--
 contrib/completion/git-completion.bash |  4 ++--
 sequencer.c                            |  2 +-
 t/t3510-cherry-pick-sequence.sh        | 14 +++++++-------
 t/t3511-cherry-pick-x.sh               |  2 +-
 8 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 6154e57..de878ff 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
 'git cherry-pick' --continue
-'git cherry-pick' --quit
+'git cherry-pick' --forget
 'git cherry-pick' --abort
 
 DESCRIPTION
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 573616a..c21a43b 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
 'git revert' --continue
-'git revert' --quit
+'git revert' --forget
 'git revert' --abort
 
 DESCRIPTION
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 5747f44..ddfaad6 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -3,7 +3,7 @@
 	'.git/sequencer'.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
 
---quit::
+--forget::
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
 	revert.
diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..663eaf7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -77,7 +77,10 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char *me = action_name(opts);
 	int cmd = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
+		OPT_CMDMODE(0, "forget", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
+		{ OPTION_CMDMODE, 0, "quit", &cmd, NULL,
+		  N_("end revert or cherry-pick sequence"),
+		  PARSE_OPT_NOARG|PARSE_OPT_NONEG|PARSE_OPT_HIDDEN, NULL, 'q' },
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
@@ -134,7 +137,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->subcommand != REPLAY_NONE) {
 		char *this_operation;
 		if (opts->subcommand == REPLAY_REMOVE_STATE)
-			this_operation = "--quit";
+			this_operation = "--forget";
 		else if (opts->subcommand == REPLAY_CONTINUE)
 			this_operation = "--continue";
 		else {
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8159f28..d5c74e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1047,7 +1047,7 @@ _git_cherry_pick ()
 {
 	local dir="$(__gitdir)"
 	if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
+		__gitcomp "--continue --forget --abort"
 		return
 	fi
 	case "$cur" in
@@ -2303,7 +2303,7 @@ _git_revert ()
 {
 	local dir="$(__gitdir)"
 	if [ -f "$dir"/REVERT_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
+		__gitcomp "--continue --forget --abort"
 		return
 	fi
 	case "$cur" in
diff --git a/sequencer.c b/sequencer.c
index e66f2fe..12d10d0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -812,7 +812,7 @@ static int create_seq_dir(void)
 {
 	if (file_exists(git_path_seq_dir())) {
 		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
+		advise(_("try \"git cherry-pick (--continue | --forget | --abort)\""));
 		return -1;
 	}
 	else if (mkdir(git_path_seq_dir(), 0777) < 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..d84fafa 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -18,7 +18,7 @@ test_description='Test cherry-pick continuation features
 _r10='\1\1\1\1\1\1\1\1\1\1'
 
 pristine_detach () {
-	git cherry-pick --quit &&
+	git cherry-pick --forget &&
 	git checkout -f "$1^0" &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x
@@ -89,9 +89,9 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success '--quit does not complain when no cherry-pick is in progress' '
+test_expect_success '--forget does not complain when no cherry-pick is in progress' '
 	pristine_detach initial &&
-	git cherry-pick --quit
+	git cherry-pick --forget
 '
 
 test_expect_success '--abort requires cherry-pick in progress' '
@@ -99,14 +99,14 @@ test_expect_success '--abort requires cherry-pick in progress' '
 	test_must_fail git cherry-pick --abort
 '
 
-test_expect_success '--quit cleans up sequencer state' '
+test_expect_success '--forget cleans up sequencer state' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..picked &&
-	git cherry-pick --quit &&
+	git cherry-pick --forget &&
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success '--quit keeps HEAD and conflicted index intact' '
+test_expect_success '--forget keeps HEAD and conflicted index intact' '
 	pristine_detach initial &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -116,7 +116,7 @@ test_expect_success '--quit keeps HEAD and conflicted index intact' '
 	:000000 100644 OBJID OBJID A	unrelated
 	EOF
 	test_expect_code 1 git cherry-pick base..picked &&
-	git cherry-pick --quit &&
+	git cherry-pick --forget &&
 	test_path_is_missing .git/sequencer &&
 	test_must_fail git update-index --refresh &&
 	{
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9cce5ae..a56d48e 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -5,7 +5,7 @@ test_description='Test cherry-pick -x and -s'
 . ./test-lib.sh
 
 pristine_detach () {
-	git cherry-pick --quit &&
+	git cherry-pick --forget &&
 	git checkout -f "$1^0" &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x
-- 
2.8.2.524.g6ff3d78

