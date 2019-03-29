Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270B620248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfC2Kjl (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:39:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46862 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfC2Kjl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:39:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so1010328pgv.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ER3ur74Yd8F1s50xsHi3+GUnDJC4Rnm6wtZ6G6nbaAc=;
        b=RNoGXDDH2C5lwYY9EAVCImsqMKCVJnRnOs1cpQtazd2z1Zwh160XAMOwJc7nUY10vD
         CFOG1Q2x5i8SVhf64ROuauAwkBPNlO2OxZZ0WJp+/0BPM8febmaau7sqxo3lNZvsmHaI
         tYf5S0HTUkfvaW5xy4jcKg0gKmjJjg9ZEuBbsjsiR/8ds3ORapjnUfzlLkUZ0k2cRHzP
         YQqSjqoyoew8GqOMYA5KEscO98hvY6uWUX2sK0DQkigtYOIwvuyzKybpInnckWIDYdeM
         7fk+yALeyNyVPxA/EfDBQARlX5Di5L9nNmmpvzaRe9rs3IGBiWwKKW6GNNPkya7qGmih
         z7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ER3ur74Yd8F1s50xsHi3+GUnDJC4Rnm6wtZ6G6nbaAc=;
        b=PCgGG2ugtL2BOMD4Gx0AvP+nKKtT+cYTzNjI62FJ8nkld03zCyROyjtBgwX5led8If
         X5nYfrgIngDTdqe5xltVCP5ZxsCf43/GVJzTjhVsw0D/tVwLBhtU1p4VbU8+YYGWi/uZ
         r/UYNouWwKt8N7xDwHBDKIW0/MxgWjX8XignG69kcX5fOhyk8kCaSqta6fAvhLDHbyGN
         38Zqqb5REMkRrZP8X8P0oTMvQY1uiCsXlQNieH0hgbVk/yAvVKiuNtygFlPyumxrFMT7
         rkh5aTtOcp/AOsnOlCez86o6CLvvJpvVLKZoLENQQG6kwjy9sQm+5TzSR5n1JENrpSsy
         mIoA==
X-Gm-Message-State: APjAAAWQ5Vc2cvGL4d10P/PK+OQcL/igO6Qv03bMmDPWzMSt0DWz4WuT
        mrXhhhR7hRHRAnBbHQ2pb3U=
X-Google-Smtp-Source: APXvYqy2g66gyVSV/vYuor0vizgPWZDcxrMpEIvEikTpk8xtWqpGu7y9pUbJeLpSQeIajyhDMQfMtg==
X-Received: by 2002:aa7:9286:: with SMTP id j6mr45405020pfa.47.1553855979975;
        Fri, 29 Mar 2019 03:39:39 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id w18sm3952108pfg.75.2019.03.29.03.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:39:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:39:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 00/27] Add new command 'switch'
Date:   Fri, 29 Mar 2019 17:38:52 +0700
Message-Id: <20190329103919.15642-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new command 'git-switch' as the half-replacement for
'git-checkout'. Jump to 13/27 as the starting point. The other half is
git-restore, which is dealt with separately.

The sixth time must be the charm, because the seventh time may be the
curse!

The last big change since v5 is from the discussion about
remove_branch_state() and its relation with --ignore-in-progress. By
popular demand, --ignore-in-progress is gone. The discussion is linked
in 23/27, which is also improved to suggest a way out.

That discussion also leads to a new patch, 07/27, which improves 'git
checkout' and tells the user when merge/revert/cherry-pick is canceled.

The rest is just minor updates here and there. And I made sure the
sign-off is back this time :D

Nguyễn Thái Ngọc Duy (27):
  git-checkout.txt: spell out --no-option
  git-checkout.txt: fix one syntax line
  doc: document --overwrite-ignore
  git-checkout.txt: fix monospace typeset
  t: rename t2014-switch.sh to t2014-checkout-switch.sh
  checkout: advice how to get out of detached HEAD mode
  checkout: inform the user when removing branch state
  checkout: keep most #include sorted
  checkout: factor out some code in parse_branchname_arg()
  checkout: make "opts" in cmd_checkout() a pointer
  checkout: move 'confict_style' and 'dwim_..' to checkout_opts
  checkout: split options[] array in three pieces
  checkout: split part of it to new command 'switch'
  switch: better names for -b and -B
  switch: add --discard-changes
  switch: remove -l
  switch: stop accepting pathspec
  switch: reject "do nothing" case
  switch: only allow explicit detached HEAD
  switch: add short option for --detach
  switch: implicit dwim, use --no-guess to disable it
  switch: no worktree status unless real branch switch happens
  switch: reject if some operation is in progress
  switch: make --orphan switch to an empty tree
  t: add tests for switch
  completion: support switch
  doc: promote "git switch"

 .gitignore                                    |   1 +
 Documentation/config/advice.txt               |  13 +-
 Documentation/config/branch.txt               |   4 +-
 Documentation/config/checkout.txt             |  17 +-
 Documentation/config/diff.txt                 |   3 +-
 Documentation/git-branch.txt                  |  12 +-
 Documentation/git-check-ref-format.txt        |   3 +-
 Documentation/git-checkout.txt                | 221 ++++---
 Documentation/git-format-patch.txt            |   2 +-
 Documentation/git-merge-base.txt              |   2 +-
 Documentation/git-merge.txt                   |   5 +
 Documentation/git-rebase.txt                  |   2 +-
 Documentation/git-remote.txt                  |   2 +-
 Documentation/git-rerere.txt                  |  10 +-
 Documentation/git-reset.txt                   |  20 +-
 Documentation/git-stash.txt                   |   9 +-
 Documentation/git-switch.txt (new)            | 271 ++++++++
 Documentation/gitattributes.txt               |   3 +-
 Documentation/gitcore-tutorial.txt            |  19 +-
 Documentation/giteveryday.txt                 |  24 +-
 Documentation/githooks.txt                    |   8 +-
 Documentation/gittutorial.txt                 |   4 +-
 Documentation/gitworkflows.txt                |   3 +-
 Documentation/revisions.txt                   |   2 +-
 Documentation/user-manual.txt                 |  56 +-
 Makefile                                      |   1 +
 advice.c                                      |  17 +-
 branch.c                                      |  11 +-
 branch.h                                      |   2 +-
 builtin.h                                     |   1 +
 builtin/am.c                                  |   2 +-
 builtin/checkout.c                            | 619 ++++++++++--------
 builtin/rebase.c                              |   4 +-
 builtin/reset.c                               |   2 +-
 builtin/revert.c                              |   2 +-
 command-list.txt                              |   1 +
 contrib/completion/git-completion.bash        |  37 +-
 git.c                                         |   1 +
 parse-options-cb.c                            |  17 +
 parse-options.h                               |   1 +
 sha1-name.c                                   |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  14 -
 ...014-switch.sh => t2014-checkout-switch.sh} |   0
 t/t2020-checkout-detach.sh                    |  28 +-
 t/t2060-switch.sh (new +x)                    |  96 +++
 unpack-trees.c                                |   2 +-
 46 files changed, 1071 insertions(+), 505 deletions(-)
 create mode 100644 Documentation/git-switch.txt
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)
 create mode 100755 t/t2060-switch.sh

Range-diff dựa trên v5:
 -:  ---------- >  1:  ddcc6f7684 checkout: inform the user when removing branch state
 1:  0bb2aefb85 =  2:  1d91c3ed35 checkout: keep most #include sorted
 2:  ace82aa26f =  3:  1705d50f4e checkout: factor out some code in parse_branchname_arg()
 3:  6e13efcba8 =  4:  dc07f2fd92 checkout: make "opts" in cmd_checkout() a pointer
 4:  f61a042eb8 =  5:  a8292a7173 checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 5:  972cebc568 =  6:  89b7d4baea checkout: split options[] array in three pieces
 6:  970c727b24 !  7:  0862b680c3 checkout: split part of it to new command 'switch'
    @@ -243,18 +243,14 @@
     +
     +-f::
     +--force::
    -+	An alias for `--discard-changes` and `--ignore-in-progress`.
    ++	An alias for `--discard-changes`.
     +
     +--discard-changes::
     +	Proceed even if the index or the working tree differs from
     +	`HEAD`. Both the index and working tree are restored to match
    -+	the switching target. This is used to throw away local
    -+	changes.
    -+
    -+--ignore-in-progress::
    -+	`git switch` by default refuses when some operation is in
    -+	progress (e.g. "git rebase", "git am" ...). This option
    -+	overrides this safety check and allows switching.
    ++	the switching target. If `--recurse-submodules` is specified,
    ++	submodule content is also restored to match the switching
    ++	target. This is used to throw away local changes.
     +
     +-m::
     +--merge::
    @@ -321,13 +317,12 @@
     +
     +--recurse-submodules::
     +--no-recurse-submodules::
    -+	Using `--recurse-submodules` will update the content of all initialized
    -+	submodules according to the commit recorded in the superproject. If
    -+	local modifications in a submodule would be overwritten the checkout
    -+	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
    -+	is used, the work trees of submodules will not be updated.
    -+	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
    -+	submodule.
    ++	Using `--recurse-submodules` will update the content of all
    ++	initialized submodules according to the commit recorded in the
    ++	superproject. If nothing (or `--no-recurse-submodules`) is
    ++	used, the work trees of submodules will not be updated. Just
    ++	like linkgit:git-submodule[1], this will detach `HEAD` of the
    ++	submodules.
     +
     +EXAMPLES
     +--------
    @@ -385,7 +380,7 @@
     +name:
     +
     +------------
    -+$ git switch -g new-topic
    ++$ git switch new-topic
     +Branch 'new-topic' set up to track remote branch 'new-topic' from 'origin'
     +Switched to a new branch 'new-topic'
     +------------
 7:  676f5df0fd =  8:  52da28d384 switch: better names for -b and -B
 8:  4e37c0659e !  9:  471b0c47ac switch: add --discard-changes
    @@ -7,6 +7,10 @@
         --discard-changes. But it's meant to be an alias for potentially more
         force options in the future.
     
    +    Side note. It's not obvious from the patch but --discard-changes also
    +    affects submodules if --recurse-submodules is used. The knob to force
    +    updating submodules is hidden behind unpack-trees.c
    +
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
      +++ b/builtin/checkout.c
 9:  a57208d137 = 10:  bf6d12272c switch: remove -l
10:  3de6f95bf2 = 11:  bec2fb8884 switch: stop accepting pathspec
11:  ad225517cd = 12:  ed0dfccf89 switch: reject "do nothing" case
12:  583cfd5cc4 = 13:  d17eabfb01 switch: only allow explicit detached HEAD
13:  1c5aee658d = 14:  59623757ee switch: add short option for --detach
14:  d942ac52e2 = 15:  04dca884f8 switch: implicit dwim, use --no-guess to disable it
15:  37eb152c0d = 16:  c8ff76def6 switch: no worktree status unless real branch switch happens
16:  50d6768afd ! 17:  34727e7d46 switch: reject if some operation is in progress
    @@ -7,13 +7,20 @@
         forget that you're in the middle of something. By the time you realize,
         you may have done a ton of work and it gets harder to go back.
     
    -    The new option --ignore-in-progress is added to override this check.
    -    However it's probably just safer to create a separate worktree for
    -    that separate thing you want to work on and leave this worktree
    -    alone (unless of course creating or preparing worktrees are not cheap).
    +    A new option --ignore-in-progress was considered but dropped because it
    +    was not exactly clear what should happen. Sometimes you can switch away
    +    and get back safely and resume the operation. Sometimes not. And the
    +    git-checkout behavior is automatically clear merge/revert/cherry-pick,
    +    which makes it a bit even more confusing [1].
     
    -    --force is updated to also imply --ignore-in-progress because it is
    -    supposed to be the "just do your things and don't bother me" option.
    +    We may revisit and add this option in the future. But for now play it
    +    safe and not allow it (you can't even skip this check with --force). The
    +    user is suggested to cancel the operation by themselves (and hopefully
    +    they do consider the consequences, not blindly type the command), or to
    +    create a separate worktree instead of switching. The third option is
    +    the good old "git checkout", but it's not mentioned.
    +
    +    [1] CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com
     
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
    @@ -35,44 +42,55 @@
      	const char *new_branch;
      	const char *new_branch_force;
     @@
    - 	    !new_branch_info->path)
    - 		die_expecting_a_branch(new_branch_info);
    + 	die(_("a branch is expected, got '%s'"), branch_info->name);
    + }
      
    -+	if (!opts->can_switch_when_in_progress) {
    -+		struct wt_status_state state;
    ++static void die_if_some_operation_in_progress(void)
    ++{
    ++	struct wt_status_state state;
     +
    -+		memset(&state, 0, sizeof(state));
    -+		wt_status_get_state(the_repository, &state, 0);
    ++	memset(&state, 0, sizeof(state));
    ++	wt_status_get_state(the_repository, &state, 0);
     +
    -+		if (state.merge_in_progress)
    -+			die(_("cannot switch branch while merging"));
    -+		if (state.am_in_progress)
    -+			die(_("cannot switch branch in the middle of an am session"));
    -+		if (state.rebase_interactive_in_progress || state.rebase_in_progress)
    -+			die(_("cannot switch branch while rebasing"));
    -+		if (state.cherry_pick_in_progress)
    -+			die(_("cannot switch branch while cherry-picking"));
    -+		if (state.revert_in_progress)
    -+			die(_("cannot switch branch while reverting"));
    -+		if (state.bisect_in_progress)
    -+			die(_("cannot switch branch while bisecting"));
    -+	}
    ++	if (state.merge_in_progress)
    ++		die(_("cannot switch branch while merging\n"
    ++		      "Consider \"git merge --quit\" "
    ++		      "or \"git worktree add\"."));
    ++	if (state.am_in_progress)
    ++		die(_("cannot switch branch in the middle of an am session\n"
    ++		      "Consider \"git am --quit\" "
    ++		      "or \"git worktree add\"."));
    ++	if (state.rebase_interactive_in_progress || state.rebase_in_progress)
    ++		die(_("cannot switch branch while rebasing\n"
    ++		      "Consider \"git rebase --quit\" "
    ++		      "or \"git worktree add\"."));
    ++	if (state.cherry_pick_in_progress)
    ++		die(_("cannot switch branch while cherry-picking\n"
    ++		      "Consider \"git cherry-pick --quit\" "
    ++		      "or \"git worktree add\"."));
    ++	if (state.revert_in_progress)
    ++		die(_("cannot switch branch while reverting\n"
    ++		      "Consider \"git revert --quit\" "
    ++		      "or \"git worktree add\"."));
    ++	if (state.bisect_in_progress)
    ++		die(_("cannot switch branch while bisecting\n"
    ++		      "Consider \"git bisect reset HEAD\" "
    ++		      "or \"git worktree add\"."));
    ++}
    ++
    + static int checkout_branch(struct checkout_opts *opts,
    + 			   struct branch_info *new_branch_info)
    + {
    +@@
    + 	    !new_branch_info->path)
    + 		die_expecting_a_branch(new_branch_info);
    + 
    ++	if (!opts->can_switch_when_in_progress)
    ++		die_if_some_operation_in_progress();
     +
      	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
      	    !opts->ignore_other_worktrees) {
      		int flag;
    -@@
    - 		opts->merge = 1; /* implied */
    - 		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
    - 	}
    --	if (opts->force)
    -+	if (opts->force) {
    - 		opts->discard_changes = 1;
    -+		opts->can_switch_when_in_progress = 1;
    -+	}
    - 
    - 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
    - 		die(_("-b, -B and --orphan are mutually exclusive"));
     @@
      	opts.only_merge_on_switching_branches = 0;
      	opts.accept_pathspec = 1;
    @@ -81,15 +99,6 @@
      
      	options = parse_options_dup(checkout_options);
      	options = add_common_options(&opts, options);
    -@@
    - 			 N_("second guess 'git switch <no-such-branch>'")),
    - 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
    - 			 N_("throw away local modifications")),
    -+		OPT_BOOL(0, "ignore-in-progress", &opts.can_switch_when_in_progress,
    -+			 N_("allow to switch branch when some operation is still in progress")),
    - 		OPT_END()
    - 	};
    - 	int ret;
     @@
      	opts.switch_branch_doing_nothing_is_ok = 0;
      	opts.only_merge_on_switching_branches = 1;
17:  af8bb710c8 = 18:  6e1986f0d4 switch: make --orphan switch to an empty tree
18:  4a293a3d53 ! 19:  414a1783fb t: add tests for switch
    @@ -95,13 +95,11 @@
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'switching when something is in progress' '
    ++test_expect_success 'not switching when something is in progress' '
     +	test_when_finished rm -f .git/MERGE_HEAD &&
     +	# fake a merge-in-progress
     +	cp .git/HEAD .git/MERGE_HEAD &&
    -+	test_must_fail git switch -d @^ &&
    -+	git switch --ignore-in-progress -d @^ &&
    -+	git switch -
    ++	test_must_fail git switch -d @^
     +'
     +
     +test_done
19:  b10290b378 = 20:  ac6f5fa9f9 completion: support switch
20:  67c5175e5f ! 21:  5a921aa0a1 doc: promote "git switch"
    @@ -9,6 +9,9 @@
         For these reasons, promote it everywhere possible. This includes
         documentation, suggestions/advice from other commands...
     
    +    The "Checking out files" progress line in unpack-trees.c is also updated
    +    to "Updating files" to be neutral to both git-checkout and git-switch.
    +
      diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
      --- a/Documentation/git-branch.txt
      +++ b/Documentation/git-branch.txt
    @@ -662,7 +665,8 @@
     -	"  git checkout -b <new-branch-name>\n"
     +	"  git switch -c <new-branch-name>\n"
      	"\n"
    - 	"Or undo this checkout with:\n"
    +-	"Or undo this checkout with:\n"
    ++	"Or undo this operation with:\n"
      	"\n"
     -	"  git checkout -\n"
     +	"  git switch -\n"
    @@ -705,7 +709,8 @@
     -	  git checkout -b <new-branch-name>
     +	  git switch -c <new-branch-name>
      
    - 	Or undo this checkout with:
    +-	Or undo this checkout with:
    ++	Or undo this operation with:
      
     -	  git checkout -
     +	  git switch -
    @@ -731,10 +736,24 @@
     -	  git checkout -b <new-branch-name>
     +	  git switch -c <new-branch-name>
      
    - 	Or undo this checkout with:
    +-	Or undo this checkout with:
    ++	Or undo this operation with:
      
     -	  git checkout -
     +	  git switch -
      
      	Turn off this advice by setting config variable advice.detachedHead to false
      
    +
    + diff --git a/unpack-trees.c b/unpack-trees.c
    + --- a/unpack-trees.c
    + +++ b/unpack-trees.c
    +@@
    + 			total++;
    + 	}
    + 
    +-	return start_delayed_progress(_("Checking out files"), total);
    ++	return start_delayed_progress(_("Updating files"), total);
    + }
    + 
    + static void setup_collided_checkout_detection(struct checkout *state,
-- 
2.21.0.479.g47ac719cd3

