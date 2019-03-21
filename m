Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E02020248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfCUNRG (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:17:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40934 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfCUNRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:17:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so4273261pfc.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8H6qWmk56NM2gLM6s3H6pjZs+ZTeloNinh26qu2GpGw=;
        b=evdmrJRkaKYIrQg/ssR9456aq0n/QHDtOHbz4Tj8QThJBJyTLTkjTR/MxFlkNVCRzS
         FKkR67yJRsj5mn0XVB8H+sZlG2luloB1+Zvo0hf7T/rMadHrTCkTr3NETX5J+0ye/LkP
         59ZDA70E7KE9O6DtZkqQoGVemgeljDY3K3Yyb1aQs1jzTcVk6Z7lO0iGlUES4OCOrIU+
         M1nwU9gPxEskNIJqxmOGq0suCGUABQHQxKzdY3M1zwyDezPvIfem59fiIGGo9kBUlCgt
         cRgs6Xukcd+8WaUmII85EuT2lR1gRaJo9Cs1skxNjBMoeTboGpT9xeRbZMknibnfBsSh
         0J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8H6qWmk56NM2gLM6s3H6pjZs+ZTeloNinh26qu2GpGw=;
        b=VmHjgmMQb+xsK5gmkAfsn/hStMX8gT3ooV+KrRHNAVE/yKd0E1azsI7Y0BkIrP1GC/
         E0gUpzkaNy8mfhAhAYVz4Qdjv49HOGPbMpw8x9iKVoJwhZK/FfrGJ3ZMrKYH+IE8BTdM
         /yndp47KnIDhhieiTEnSeqMrxamwyiZmxWA3GBhIT6LlhNWu2N/nbEZgjLVveCLXClEf
         WLY21UEoC53p3EnRY7B3kxPSA47BLLbky+CU8Jm3BcOVah45pMRtWZoMhOTLRDO+phl/
         ulcZp/INqFdjKGuOtuVe6pHcmxzIpAvHn609/vgCPfmee03hExEHkeV8Yutv+4q3Qctu
         e96w==
X-Gm-Message-State: APjAAAUxQHad9fuII/dXqULjBkbACgJ7EOF/bne6yaLUxSnAY6tknZzN
        +Yu9PidUAWV8IVAfdgaODuk=
X-Google-Smtp-Source: APXvYqyZUMEUW4436b05yzvptTBoFtrslyaQVX90H+bfcR5oHhlRw8nj5032TgsxL+U0uN6qTwDR5w==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr3627502plt.100.1553174225469;
        Thu, 21 Mar 2019 06:17:05 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id g13sm7118304pfm.159.2019.03.21.06.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:16:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 00/26] Add new command 'switch'
Date:   Thu, 21 Mar 2019 20:16:29 +0700
Message-Id: <20190321131655.15249-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new command 'git-switch' as the half-replacement for
'git-checkout'. Jump to 12/26 as the starting point. The other half is
git-restore, which is dealt with separately.

The diff delta is shrinking nicely. The two main changes are

- '--orphan <new-branch> <initial-tree>' is no longer accepted
- --force implies --ignore-in-progress

The rest is the usual typo and bug fixes.

The two "todo" items from v4 will be handled separately and will not
be mentioned again in v6 (if there is one):

 - The 'checkout -m' losing staged changes problem has already been
discussed elsewhere and I'm still trying to see if I can improve it.

 - I have some work in progress for improving tracking branch error
message, but it's unlikely to conflict badly with this series.

Nguyễn Thái Ngọc Duy (26):
  git-checkout.txt: spell out --no-option
  git-checkout.txt: fix one syntax line
  doc: document --overwrite-ignore
  git-checkout.txt: fix monospace typeset
  t: rename t2014-switch.sh to t2014-checkout-switch.sh
  checkout: advice how to get out of detached HEAD mode
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
 Documentation/git-switch.txt (new)            | 276 ++++++++
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
 builtin.h                                     |   1 +
 builtin/checkout.c                            | 605 ++++++++++--------
 command-list.txt                              |   1 +
 contrib/completion/git-completion.bash        |  37 +-
 git.c                                         |   1 +
 parse-options-cb.c                            |  17 +
 parse-options.h                               |   1 +
 sha1-name.c                                   |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  14 -
 ...014-switch.sh => t2014-checkout-switch.sh} |   0
 t/t2020-checkout-detach.sh                    |  28 +-
 t/t2060-switch.sh (new +x)                    |  98 +++
 39 files changed, 1051 insertions(+), 493 deletions(-)
 create mode 100644 Documentation/git-switch.txt
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)
 create mode 100755 t/t2060-switch.sh

Range-diff dựa trên v4:
 1:  535dc1f310 !  1:  7bcb4b0ff8 doc: document --overwrite-ignore
    @@ -22,20 +22,7 @@
     +
      --recurse-submodules::
      --no-recurse-submodules::
    --	Using --recurse-submodules will update the content of all initialized
    -+	Using `--recurse-submodules` will update the content of all initialized
    - 	submodules according to the commit recorded in the superproject. If
    - 	local modifications in a submodule would be overwritten the checkout
    --	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
    -+	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
    - 	is used, the work trees of submodules will not be updated.
    --	Just like linkgit:git-submodule[1], this will detach the
    --	submodules HEAD.
    -+	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
    -+	submodule.
    - 
    - --no-guess::
    - 	Do not attempt to create a branch if a remote tracking branch
    + 	Using --recurse-submodules will update the content of all initialized
     
      diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
      --- a/Documentation/git-merge.txt
 2:  b6305d2871 !  2:  f2d77152eb git-checkout.txt: fix monospace typeset
    @@ -4,8 +4,7 @@
     
         Add backticks where we have none, replace single quotes with backticks
         and replace double-quotes. Drop double-quotes from nested constructions
    -    such as `"@{-1}"`. Add a missing possessive apostrophe after the word
    -    "submodules" while at it.
    +    such as `"@{-1}"`.
     
         Helped-by: Martin Ågren <martin.agren@gmail.com>
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
    @@ -207,6 +206,24 @@
      This means that you can use `git checkout -p` to selectively discard
      edits from your current working tree. See the ``Interactive Mode''
     @@
    + 
    + --recurse-submodules::
    + --no-recurse-submodules::
    +-	Using --recurse-submodules will update the content of all initialized
    ++	Using `--recurse-submodules` will update the content of all initialized
    + 	submodules according to the commit recorded in the superproject. If
    + 	local modifications in a submodule would be overwritten the checkout
    +-	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
    ++	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
    + 	is used, the work trees of submodules will not be updated.
    +-	Just like linkgit:git-submodule[1], this will detach the
    +-	submodules HEAD.
    ++	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
    ++	submodule.
    + 
    + --no-guess::
    + 	Do not attempt to create a branch if a remote tracking branch
    +@@
      	In the default overlay mode, `git checkout` never
      	removes files from the index or the working tree.  When
      	specifying `--no-overlay`, files that appear in the index and
 3:  bb56e45457 =  3:  cbe630fb4a t: rename t2014-switch.sh to t2014-checkout-switch.sh
 4:  123392757a =  4:  6bc8a1052f checkout: advice how to get out of detached HEAD mode
 5:  d1ec6b4ce0 =  5:  0bb2aefb85 checkout: keep most #include sorted
 6:  4b1742672b =  6:  ace82aa26f checkout: factor out some code in parse_branchname_arg()
 7:  e0bcc3a4dd =  7:  6e13efcba8 checkout: make "opts" in cmd_checkout() a pointer
 8:  ca5b4d7db0 =  8:  f61a042eb8 checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 9:  13c03997f0 =  9:  972cebc568 checkout: split options[] array in three pieces
10:  24d532b276 ! 10:  970c727b24 checkout: split part of it to new command 'switch'
    @@ -147,9 +147,10 @@
     +SYNOPSIS
     +--------
     +[verse]
    -+'git switch' [<options>] [--guess] <branch>
    ++'git switch' [<options>] [--no-guess] <branch>
     +'git switch' [<options>] --detach [<start-point>]
    -+'git switch' [<options>] (-c|-C|--orphan) <new-branch> [<start-point>]
    ++'git switch' [<options>] (-c|-C) <new-branch> [<start-point>]
    ++'git switch' [<options>] --orphan <new-branch>
     +
     +DESCRIPTION
     +-----------
    @@ -164,8 +165,8 @@
     +
     +Switching branches does not require a clean index and working tree
     +(i.e. no differences compared to `HEAD`). The operation is aborted
    -+however if the switch leads to loss of local changes, unless told
    -+otherwise.
    ++however if the operation leads to loss of local changes, unless told
    ++otherwise with `--discard-changes` or `--merge`.
     +
     +OPTIONS
     +-------
    @@ -183,7 +184,7 @@
     +	from some other point.)
     ++
     +You can use the `@{-N}` syntax to refer to the N-th last
    -+branch/commit switched to "git switch" or "git checkout"
    ++branch/commit switched to using "git switch" or "git checkout"
     +operation. You may also specify `-` which is synonymous to `@{-1}`.
     +This is often used to switch quickly between two branches, or to undo
     +a branch switch by mistake.
    @@ -242,7 +243,7 @@
     +
     +-f::
     +--force::
    -+	An alias for `--discard-changes`.
    ++	An alias for `--discard-changes` and `--ignore-in-progress`.
     +
     +--discard-changes::
     +	Proceed even if the index or the working tree differs from
    @@ -250,6 +251,11 @@
     +	the switching target. This is used to throw away local
     +	changes.
     +
    ++--ignore-in-progress::
    ++	`git switch` by default refuses when some operation is in
    ++	progress (e.g. "git rebase", "git am" ...). This option
    ++	overrides this safety check and allows switching.
    ++
     +-m::
     +--merge::
     +	If you have local modifications to one or more files that are
    @@ -304,10 +310,8 @@
     +	`branch.autoSetupMerge` configuration variable is true.
     +
     +--orphan <new-branch>::
    -+	Create a new 'orphan' branch, named `<new-branch>`. If
    -+	`<start-point>` is specified, the index and working tree are
    -+	adjusted to match it. Otherwise both are adjusted to contain no
    -+	tracked files.
    ++	Create a new 'orphan' branch, named `<new-branch>`. All
    ++	tracked files are removed.
     +
     +--ignore-other-worktrees::
     +	`git switch` refuses when the wanted ref is already
    @@ -315,11 +319,6 @@
     +	the ref out anyway. In other words, the ref can be held by
     +	more than one worktree.
     +
    -+--ignore-in-progress::
    -+	`git switch` by default refuses when some operation is in
    -+	progress (e.g. "git rebase", "git am" ...). This option
    -+	overrides this safety check and allows switching.
    -+
     +--recurse-submodules::
     +--no-recurse-submodules::
     +	Using `--recurse-submodules` will update the content of all initialized
11:  c966bacfcc = 11:  676f5df0fd switch: better names for -b and -B
12:  bdb88bf9a9 ! 12:  4e37c0659e switch: add --discard-changes
    @@ -4,8 +4,8 @@
     
         --discard-changes is a better name than --force for this option since
         it's what really happens. --force is turned to an alias for
    -    --discard-changes. But it's meant to an alias for potentially more force
    -    options in the future.
    +    --discard-changes. But it's meant to be an alias for potentially more
    +    force options in the future.
     
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
13:  d5fe7f4bd0 = 13:  a57208d137 switch: remove -l
14:  3bce4c521e = 14:  3de6f95bf2 switch: stop accepting pathspec
15:  dad0063fc4 = 15:  ad225517cd switch: reject "do nothing" case
16:  41ca042917 = 16:  583cfd5cc4 switch: only allow explicit detached HEAD
17:  a0b9f1b285 = 17:  1c5aee658d switch: add short option for --detach
18:  3d254df104 = 18:  d942ac52e2 switch: implicit dwim, use --no-guess to disable it
19:  c6ea203f36 = 19:  37eb152c0d switch: no worktree status unless real branch switch happens
20:  5c4effc7fd ! 20:  50d6768afd switch: reject if some operation is in progress
    @@ -12,6 +12,9 @@
         that separate thing you want to work on and leave this worktree
         alone (unless of course creating or preparing worktrees are not cheap).
     
    +    --force is updated to also imply --ignore-in-progress because it is
    +    supposed to be the "just do your things and don't bother me" option.
    +
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
      +++ b/builtin/checkout.c
    @@ -45,7 +48,7 @@
     +			die(_("cannot switch branch while merging"));
     +		if (state.am_in_progress)
     +			die(_("cannot switch branch in the middle of an am session"));
    -+		if (state.rebase_in_progress || state.rebase_in_progress)
    ++		if (state.rebase_interactive_in_progress || state.rebase_in_progress)
     +			die(_("cannot switch branch while rebasing"));
     +		if (state.cherry_pick_in_progress)
     +			die(_("cannot switch branch while cherry-picking"));
    @@ -58,6 +61,18 @@
      	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
      	    !opts->ignore_other_worktrees) {
      		int flag;
    +@@
    + 		opts->merge = 1; /* implied */
    + 		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
    + 	}
    +-	if (opts->force)
    ++	if (opts->force) {
    + 		opts->discard_changes = 1;
    ++		opts->can_switch_when_in_progress = 1;
    ++	}
    + 
    + 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
    + 		die(_("-b, -B and --orphan are mutually exclusive"));
     @@
      	opts.only_merge_on_switching_branches = 0;
      	opts.accept_pathspec = 1;
21:  a4afe6a999 ! 21:  af8bb710c8 switch: --orphan defaults to empty tree as HEAD
    @@ -1,15 +1,16 @@
     Author: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
     
    -    switch: --orphan defaults to empty tree as HEAD
    +    switch: make --orphan switch to an empty tree
     
         Switching and creating branches always involves knowing the
         <start-point> to begin the new branch from. Sometimes, people want to
         create a new branch that does not have any commits yet; --orphan is a
         flag to allow that.
     
    -    If <start-point> is not specified, instead of leaving index/worktree
    -    unchanged, default to "empty tree" starting point, allowing a clean
    -    start.
    +    --orphan overrides the default of HEAD for <start-point> instead causing
    +    us to start from an empty history with all tracked files removed from
    +    the index and working tree. The use of --orphan is incompatible with
    +    specifying a <start-point>.
     
         A note on the implementation. An alternative is just create a dummy
         commit in-core with empty tree and switch to it. But there's a chance
    @@ -23,7 +24,7 @@
      	int switch_branch_doing_nothing_is_ok;
      	int only_merge_on_switching_branches;
      	int can_switch_when_in_progress;
    -+	int orphan_default_empty_tree;
    ++	int orphan_from_empty_tree;
      
      	const char *new_branch;
      	const char *new_branch_force;
    @@ -38,9 +39,11 @@
      		return error(_("index file corrupt"));
      
      	resolve_undo_clear();
    -+	if (opts->orphan_default_empty_tree && !new_branch_info->commit)
    ++	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
    ++		if (new_branch_info->commit)
    ++			BUG("'switch --orphan' should never accept a commit as starting point");
     +		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
    -+	else
    ++	} else
     +		new_tree = get_commit_tree(new_branch_info->commit);
      	if (opts->discard_changes) {
     -		ret = reset_tree(get_commit_tree(new_branch_info->commit),
    @@ -106,23 +109,34 @@
      	if (prepare_revision_walk(&revs))
      		die(_("internal error in revision walk"));
     @@
    + 	if (old_branch_info.path)
    + 		skip_prefix(old_branch_info.path, "refs/heads/", &old_branch_info.name);
      
    - 		if (opts->only_merge_on_switching_branches)
    - 			do_merge = 0;
    ++	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
    ++		if (new_branch_info->name)
    ++			BUG("'switch --orphan' should never accept a commit as starting point");
    ++		new_branch_info->commit = NULL;
    ++		new_branch_info->name = "(empty)";
    ++		do_merge = 1;
    ++	}
     +
    -+		if (opts->new_orphan_branch && opts->orphan_default_empty_tree) {
    -+			new_branch_info->commit = NULL;
    -+			new_branch_info->name = "(empty)";
    -+			do_merge = 1;
    -+		}
    - 	}
    - 
    - 	if (do_merge) {
    + 	if (!new_branch_info->name) {
    + 		new_branch_info->name = "HEAD";
    + 		new_branch_info->commit = old_branch_info.commit;
    +@@
    + 	if (opts->new_orphan_branch) {
    + 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
    + 			die(_("'%s' cannot be used with '%s'"), "--orphan", "-t");
    ++		if (opts->orphan_from_empty_tree && new_branch_info->name)
    ++			die(_("'%s' cannot take <start-point>"), "--orphan");
    + 	} else if (opts->force_detach) {
    + 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
    + 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
     @@
      	opts.accept_pathspec = 1;
      	opts.implicit_detach = 1;
      	opts.can_switch_when_in_progress = 1;
    -+	opts.orphan_default_empty_tree = 0;
    ++	opts.orphan_from_empty_tree = 0;
      
      	options = parse_options_dup(checkout_options);
      	options = add_common_options(&opts, options);
    @@ -130,7 +144,7 @@
      	opts.only_merge_on_switching_branches = 1;
      	opts.implicit_detach = 0;
      	opts.can_switch_when_in_progress = 0;
    -+	opts.orphan_default_empty_tree = 1;
    ++	opts.orphan_from_empty_tree = 1;
      
      	options = parse_options_dup(switch_options);
      	options = add_common_options(&opts, options);
22:  6cca78f835 ! 22:  4a293a3d53 t: add tests for switch
    @@ -67,6 +67,7 @@
     +
     +test_expect_success 'new orphan branch from empty' '
     +	test_when_finished git switch master &&
    ++	test_must_fail git switch --orphan new-orphan HEAD &&
     +	git switch --orphan new-orphan &&
     +	test_commit orphan &&
     +	git cat-file commit refs/heads/new-orphan >commit &&
23:  e5e6f9d6f1 = 23:  b10290b378 completion: support switch
24:  807e8bc50b = 24:  67c5175e5f doc: promote "git switch"
-- 
2.21.0.548.gd3c7d92dc2

