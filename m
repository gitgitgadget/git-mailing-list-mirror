Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7FF1F576
	for <e@80x24.org>; Sun, 11 Feb 2018 09:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeBKJn5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 04:43:57 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38857 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 04:43:56 -0500
Received: by mail-pf0-f195.google.com with SMTP id q79so2989302pfl.5
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O87TqQqm2P0l5iyWc0BtU3JDVgjqjUprMinNHIkmKg4=;
        b=MuoSsUBzF6+1b2N7KQmI3H2zpDEkjxQvA2ELkn11fQkoFIVdAXMF1iLqKKzNFXm3uq
         gZ4c89iNy3Vp8rukU+t4dJgIj7YehFy9rCRwIdH3Qm3LFMIztcvymWe0t5wyHmF+SRy5
         8ahFP2LfBDSeJMXfaqkqcZ4uO7trUGpFkjHqxQ2xTdcafnpK5g0ut+IR3s0WW2mJfA7K
         ufuDd/G8w/tF/Wmn5ShiLkIa0S6TMV5IPAnHN2z9ApnwZw/TaNpv7iKKHNgTZPjIgbGW
         Lomma9CdwgHZsFSiMFJPk669O2Wf4N3O1eC+YirwmSnONY8AcmTxOF778Sg5nB9pZZfg
         dzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O87TqQqm2P0l5iyWc0BtU3JDVgjqjUprMinNHIkmKg4=;
        b=OznooHYPuN8/ex1RAXou/QfwFG75U6rhz+B/9jQjOnZjzgrG3qCmR4p8yuBVoc7Y9R
         +ub4WSj4SIn3aIq3ZnKjKT5n9U+XWzNFK/wSZsT1PYU4k4wYkbBuWp7HYnRxDhenx0VS
         R3htAJYqMLYqDoIqoihILBHdzOjEywe6ga5shr/EZccjBf9pZO67t0XpYyUFjiwop0TL
         IO6X/luPXbUCn9dx2aALmIC1hwT7dK+7r5QHOCfr4rUDvxbnS7G/2/RsUGxrmPetqaHe
         lF34Tq/70s1GpHpYqmWvg7kqUov3fXzu+R9YFF2oEB2m+pXZryZpk0cHp96Ql4EkJk8+
         /BbA==
X-Gm-Message-State: APf1xPBL3rcS+sI5CrfBne7XnmPWguE0JWKqkPz3hSDStPGJPpHRlaSY
        RY4Mbu0A6PQuwVv1zCeiZ3C87w==
X-Google-Smtp-Source: AH8x225Mff/J1fdACosD9TTRO+O1WXVeSz1tsIsiCJWrn2E6ti2FVdfd4kOgpf2Al3vB+aMD85ZOdw==
X-Received: by 10.101.92.193 with SMTP id b1mr6685484pgt.319.1518342235885;
        Sun, 11 Feb 2018 01:43:55 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id q10sm22502405pfl.106.2018.02.11.01.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2018 01:43:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 11 Feb 2018 16:43:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/3] rebase: add --show-current-patch
Date:   Sun, 11 Feb 2018 16:43:27 +0700
Message-Id: <20180211094328.6157-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180211094328.6157-1-pclouds@gmail.com>
References: <20180131093051.15525-1-pclouds@gmail.com>
 <20180211094328.6157-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful to see the full patch while resolving conflicts in a
rebase. The only way to do it now is

    less .git/rebase-*/patch

which could turn out to be a lot longer to type if you are in a
linked worktree, or not at top-dir. On top of that, an ordinary user
should not need to peek into .git directory. The new option is
provided to examine the patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-rebase.txt           |  6 ++++-
 builtin/am.c                           | 11 +++++++++
 contrib/completion/git-completion.bash |  4 ++--
 git-rebase--am.sh                      |  3 +++
 git-rebase--interactive.sh             |  3 +++
 git-rebase--merge.sh                   |  3 +++
 git-rebase.sh                          |  7 +++++-
 t/t3400-rebase.sh                      | 33 ++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh          |  5 ++++
 9 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a861c1e0d..7ef9577472 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --quit | --edit-todo
+'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
 
 DESCRIPTION
 -----------
@@ -250,6 +250,10 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --edit-todo::
 	Edit the todo list during an interactive rebase.
 
+--show-current-patch::
+	Show the current patch in an interactive rebase or when rebase
+	is stopped because of conflicts.
+
 -m::
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
diff --git a/builtin/am.c b/builtin/am.c
index 07abfb8f83..37219fceb0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2126,6 +2126,17 @@ static int show_patch(struct am_state *state)
 	const char *patch_path;
 	int len;
 
+	if (!is_null_oid(&state->orig_commit)) {
+		const char *av[4] = { "show", NULL, "--", NULL };
+		char *new_oid_str;
+		int ret;
+
+		av[1] = new_oid_str = xstrdup(oid_to_hex(&state->orig_commit));
+		ret = run_command_v_opt(av, RUN_GIT_CMD);
+		free(new_oid_str);
+		return ret;
+	}
+
 	patch_path = am_path(state, msgnum(state));
 	len = strbuf_read_file(&sb, patch_path, 0);
 	if (len < 0)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 56ca445fa8..2bd30d68cf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1992,11 +1992,11 @@ _git_rebase ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
-		__gitcomp "--continue --skip --abort --quit --edit-todo"
+		__gitcomp "--continue --skip --abort --quit --edit-todo --show-current-patch"
 		return
 	elif [ -d "$__git_repo_path"/rebase-apply ] || \
 	     [ -d "$__git_repo_path"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort --quit"
+		__gitcomp "--continue --skip --abort --quit --show-current-patch"
 		return
 	fi
 	__git_complete_strategy && return
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 14c50782e0..c931891cbc 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -27,6 +27,9 @@ skip)
 	move_to_original_branch
 	return
 	;;
+show-current-patch)
+	exec git am --show-current-patch
+	;;
 esac
 
 if test -z "$rebase_root"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d47bd29593..0c0f8abbf9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -840,6 +840,9 @@ To continue rebase after editing, run:
 
 	exit
 	;;
+show-current-patch)
+	exec git show "$(cat "$state_dir/stopped-sha")" --
+	;;
 esac
 
 comment_for_reflog start
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 06a4723d4d..0a96dfae37 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -137,6 +137,9 @@ skip)
 	finish_rb_merge
 	return
 	;;
+show-current-patch)
+	exec git show "$(cat "$state_dir/current")" --
+	;;
 esac
 
 mkdir -p "$state_dir"
diff --git a/git-rebase.sh b/git-rebase.sh
index fd72a35c65..41c915d18c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -45,6 +45,7 @@ abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
 quit!              abort but keep HEAD where it is
+show-current-patch! show the patch file being applied or merged
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -245,7 +246,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort|--quit|--edit-todo)
+	--continue|--skip|--abort|--quit|--edit-todo|--show-current-patch)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -412,6 +413,10 @@ quit)
 edit-todo)
 	run_specific_rebase
 	;;
+show-current-patch)
+	run_specific_rebase
+	die "BUG: run_specific_rebase is not supposed to return here"
+	;;
 esac
 
 # Make sure no rebase is in progress
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 8ac58d5ea5..09943d6a9b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -277,4 +277,37 @@ EOF
 	test_cmp From_.msg out
 '
 
+test_expect_success 'rebase--am.sh and --show-current-patch' '
+	test_create_repo conflict-apply &&
+	(
+		cd conflict-apply &&
+		test_commit init &&
+		echo one >>init.t &&
+		git commit -a -m one &&
+		echo two >>init.t &&
+		git commit -a -m two &&
+		git tag two &&
+		test_must_fail git rebase --onto init HEAD^ &&
+		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
+		grep "show.*$(git rev-parse two)" stderr
+	)
+'
+
+test_expect_success 'rebase--merge.sh and --show-current-patch' '
+	test_create_repo conflict-merge &&
+	(
+		cd conflict-merge &&
+		test_commit init &&
+		echo one >>init.t &&
+		git commit -a -m one &&
+		echo two >>init.t &&
+		git commit -a -m two &&
+		git tag two &&
+		test_must_fail git rebase --merge --onto init HEAD^ &&
+		git rebase --show-current-patch >actual.patch &&
+		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
+		grep "show.*$(git rev-parse two)" stderr
+	)
+'
+
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 481a350090..3af6f149a9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -225,6 +225,11 @@ test_expect_success 'stop on conflicting pick' '
 	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
 '
 
+test_expect_success 'show conflicted patch' '
+	GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
+	grep "show.*$(cat "$state_dir/stopped-sha")" stderr
+'
+
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
-- 
2.16.1.399.g632f88eed1

