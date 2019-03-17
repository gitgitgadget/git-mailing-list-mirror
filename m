Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F08520248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCQMtj (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:49:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34742 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMtj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:49:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id v64so9412857pfb.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJ/ChsHjomSWZU8/tJncoX8DLKi5qrinZZutWYd93tY=;
        b=Q6CW0WzCdnOkdfAD30sQNWTCOkoPAt9KCtW7ETmPrbjzihZZsllovglkhOFhvDsHwH
         qRir/aHmX6M2bJyvxrwih0SapzOt7ggnL1qPf5YywZBm2ywx4jlAhlrcqlrC/xQW2xWt
         0n0hbEaFm8dEONR68NkyENbBAJGCtJsylrvAh/w6DqpuFfRSB8Z106qTyV8NXFPIsa6d
         LYdUf20M9lg+i6I81Pb7htZYJJZjNWGZXi3fUvDNmofCmY+oC1WQTLIN+lX0HspKdQFk
         g7wI/3NlbRlIUt6+1p+7xh5//+6f6/0t9nIDJ9L7QioY94g6uLTHFVObYRQy931v3OLX
         4VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJ/ChsHjomSWZU8/tJncoX8DLKi5qrinZZutWYd93tY=;
        b=RpQLCEBA3U8qC3wdhd6xOsbZS1mVyGt+gXdcdU17aT4uTwiNmxepe1s0vS3bHXETh/
         75VlzuRMTCmdqRpM0L/cGFDgX/OAggoLUV9BBt6N1Hr1/q06CVPrIro3pbAED8dfFa++
         QEZlZDJEBtb4XQFyj9FbFDXobS1npktfknyO/v+RbGQv+SC+CmoSg8KoZbcn5bc6EgWH
         BrT9wEnqb4CDWVeXXI1N8am1TLeWyrSfKG5S4OnV2RmWS0S7LQRh3MzSLpNnGi3qOLSe
         4VkzaFNoJfnXo5qt3+Hk5pO5lNQQ+aAbwF6aKXzgihA4kfCY1Zo3F0I5QS2FA3rW8zic
         ocEw==
X-Gm-Message-State: APjAAAU56b/lD4nmGkiavVSdfbsQbvymf8b6T3Jw3HHClGhjzlt0/djq
        r72F0BzwLndZc1TFKr0nEHE=
X-Google-Smtp-Source: APXvYqxWjC27xVGvLerSiJwQatScaA99bQuDAoQJiJuQWmnN7y39QTkIPAhqvSqipwbxcVvTfJL+tw==
X-Received: by 2002:a63:4247:: with SMTP id p68mr12996918pga.30.1552826977443;
        Sun, 17 Mar 2019 05:49:37 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id g10sm7262573pfo.139.2019.03.17.05.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:49:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:49:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 00/26] Add new command 'switch'
Date:   Sun, 17 Mar 2019 19:49:00 +0700
Message-Id: <20190317124926.17137-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the comments from v3 (and before), I didn't expect
feedback from so many people. v4 fixes most of them, but still leaves
a couple for v5.

- -C remains because people seem to need it

- --recreate vs --force-create: there was no strong preference for
  either, so I stick with --force-create

- --guess (dwim mode) is now made default

- --orphan by default switches to an empty tree instead of current HEAD
  (this is Elijah's alternative approach). This allows you to start
  fresh, but you can still keep "HEAD" content or even switch to another
  tree.

- advice.detachedHead text is updated to suggest a way out (currently it
  only suggests a way forward with 'checkout -b')

- --force has a new alias --discard-changes

- the error message when we expect a branch is improved to help point
  out why the given argument is not a branch

- more docs update and reorganization, and other silly bugs I made in
  v3

The two things I'm aware of but have not done:

- the bug in 'git checkout -m' and 'git switch -m' that could lead to
  loss of staged changes.

- better suggestion when dwim fails (e.g. when there are multiple dwim
  candidates, we could show them all).

There have been lots of discussions back and forth. If I miss anything
else, please let me know.

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
  switch: --orphan defaults to empty tree as HEAD
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
 Documentation/git-switch.txt (new)            | 277 ++++++++
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
 builtin/checkout.c                            | 597 ++++++++++--------
 command-list.txt                              |   1 +
 contrib/completion/git-completion.bash        |  37 +-
 git.c                                         |   1 +
 parse-options-cb.c                            |  17 +
 parse-options.h                               |   1 +
 sha1-name.c                                   |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  14 -
 ...014-switch.sh => t2014-checkout-switch.sh} |   0
 t/t2020-checkout-detach.sh                    |  28 +-
 t/t2060-switch.sh (new +x)                    |  97 +++
 39 files changed, 1043 insertions(+), 493 deletions(-)
 create mode 100644 Documentation/git-switch.txt
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)
 create mode 100755 t/t2060-switch.sh

Range-diff dựa trên v3:
 1:  b0cb2372db !  1:  535dc1f310 doc: document --overwrite-ignore
    @@ -22,7 +22,20 @@
     +
      --recurse-submodules::
      --no-recurse-submodules::
    - 	Using --recurse-submodules will update the content of all initialized
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
     
      diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
      --- a/Documentation/git-merge.txt
 2:  5b165524d1 <  -:  ---------- git-checkout.txt: fix monospace typeset
 -:  ---------- >  2:  b6305d2871 git-checkout.txt: fix monospace typeset
 3:  a4240a888e =  3:  bb56e45457 t: rename t2014-switch.sh to t2014-checkout-switch.sh
 -:  ---------- >  4:  123392757a checkout: advice how to get out of detached HEAD mode
 -:  ---------- >  5:  d1ec6b4ce0 checkout: keep most #include sorted
 4:  dc4a8e8933 =  6:  4b1742672b checkout: factor out some code in parse_branchname_arg()
 5:  f0d933c2ac =  7:  e0bcc3a4dd checkout: make "opts" in cmd_checkout() a pointer
 6:  0aa541689c =  8:  ca5b4d7db0 checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 7:  84ca42bb26 =  9:  13c03997f0 checkout: split options[] array in three pieces
 8:  e983c8bb2c ! 10:  24d532b276 checkout: split part of it to new command 'switch'
    @@ -4,9 +4,9 @@
     
         "git checkout" doing too many things is a source of confusion for many
         users (and it even bites old timers sometimes). To remedy that, the
    -    command will be split into two new ones: switch and
    -    something-to-checkout-paths. The good old "git checkout" command is
    -    still here and will be until all (or most of users) are sick of it.
    +    command will be split into two new ones: switch and restore. The good
    +    old "git checkout" command is still here and will be until all (or most
    +    of users) are sick of it.
     
         See the new man page for the final design of switch. The actual
         implementation though is still pretty much the same as "git checkout"
    @@ -157,12 +157,13 @@
     +updated to match the branch. All new commits will be added to the tip
     +of this branch.
     +
    -+Optionally a new branch could be created with either `-c` or `-C`, or
    ++Optionally a new branch could be created with either `-c`, `-C`,
    ++automatically from a remote branch of same name (see `--guess`), or
     +detach the working tree from any branch with `--detach`, along with
     +switching.
     +
     +Switching branches does not require a clean index and working tree
    -+(i.e. no differences compared to 'HEAD'). The operation is aborted
    ++(i.e. no differences compared to `HEAD`). The operation is aborted
     +however if the switch leads to loss of local changes, unless told
     +otherwise.
     +
    @@ -175,14 +176,19 @@
     +	Name for the new branch.
     +
     +<start-point>::
    -+	The name of a commit at which to switch to before creating a
    -+	new branch or detach from.
    ++	The starting point for the new branch. Specifying a
    ++	`<start-point>` allows you to create a branch based on some
    ++	other point in history than where HEAD currently points. (Or,
    ++	in the case of `--detach`, allows you to inspect and detach
    ++	from some other point.)
     ++
    -+You can use the `"@{-N}"` syntax to refer to the N-th last
    ++You can use the `@{-N}` syntax to refer to the N-th last
     +branch/commit switched to "git switch" or "git checkout"
    -+operation. You may also specify `-` which is synonymous to `"@{-1}"`.
    ++operation. You may also specify `-` which is synonymous to `@{-1}`.
    ++This is often used to switch quickly between two branches, or to undo
    ++a branch switch by mistake.
     ++
    -+As a special case, you may use `"A...B"` as a shortcut for the merge
    ++As a special case, you may use `A...B` as a shortcut for the merge
     +base of `A` and `B` if there is exactly one merge base. You can leave
     +out at most one of `A` and `B`, in which case it defaults to `HEAD`.
     +
    @@ -214,8 +220,8 @@
     +	experiments. See the "DETACHED HEAD" section in
     +	linkgit:git-checkout[1] for details.
     +
    -+-g::
     +--guess::
    ++--no-guess::
     +	If `<branch>` is not found but there does exist a tracking
     +	branch in exactly one remote (call it `<remote>`) with a
     +	matching name, treat as equivalent to
    @@ -231,18 +237,45 @@
     +to always checkout remote branches from there if `<branch>` is
     +ambiguous but exists on the 'origin' remote. See also
     +`checkout.defaultRemote` in linkgit:git-config[1].
    -+
    -+-q::
    -+--quiet::
    -+	Quiet, suppress feedback messages.
    +++
    ++`--guess` is the default behavior. Use `--no-guess` to disable it.
     +
     +-f::
     +--force::
    ++	An alias for `--discard-changes`.
    ++
    ++--discard-changes::
     +	Proceed even if the index or the working tree differs from
    -+	HEAD. Both the index and working tree are restored to match
    ++	`HEAD`. Both the index and working tree are restored to match
     +	the switching target. This is used to throw away local
     +	changes.
     +
    ++-m::
    ++--merge::
    ++	If you have local modifications to one or more files that are
    ++	different between the current branch and the branch to which
    ++	you are switching, the command refuses to switch branches in
    ++	order to preserve your modifications in context.  However,
    ++	with this option, a three-way merge between the current
    ++	branch, your working tree contents, and the new branch is
    ++	done, and you will be on the new branch.
    +++
    ++When a merge conflict happens, the index entries for conflicting
    ++paths are left unmerged, and you need to resolve the conflicts
    ++and mark the resolved paths with `git add` (or `git rm` if the merge
    ++should result in deletion of the path).
    ++
    ++--conflict=<style>::
    ++	The same as `--merge` option above, but changes the way the
    ++	conflicting hunks are presented, overriding the
    ++	`merge.conflictStyle` configuration variable.  Possible values are
    ++	"merge" (default) and "diff3" (in addition to what is shown by
    ++	"merge" style, shows the original contents).
    ++
    ++-q::
    ++--quiet::
    ++	Quiet, suppress feedback messages.
    ++
     +--progress::
     +--no-progress::
     +	Progress status is reported on the standard error stream
    @@ -253,49 +286,28 @@
     +-t::
     +--track::
     +	When creating a new branch, set up "upstream" configuration.
    -+	`-c` is implied. See "--track" in linkgit:git-branch[1] for
    ++	`-c` is implied. See `--track` in linkgit:git-branch[1] for
     +	details.
     ++
     +If no `-c` option is given, the name of the new branch will be derived
     +from the remote-tracking branch, by looking at the local part of the
     +refspec configured for the corresponding remote, and then stripping
    -+the initial part up to the "*".  This would tell us to use "hack" as
    -+the local branch when branching off of "origin/hack" (or
    -+"remotes/origin/hack", or even "refs/remotes/origin/hack").  If the
    ++the initial part up to the "*".  This would tell us to use `hack` as
    ++the local branch when branching off of `origin/hack` (or
    ++`remotes/origin/hack`, or even `refs/remotes/origin/hack`).  If the
     +given name has no slash, or the above guessing results in an empty
     +name, the guessing is aborted.  You can explicitly give a name with
     +`-c` in such a case.
     +
     +--no-track::
     +	Do not set up "upstream" configuration, even if the
    -+	branch.autoSetupMerge configuration variable is true.
    -+
    -+-m::
    -+--merge::
    -+	If you have local modifications to one or more files that are
    -+	different between the current branch and the branch to which
    -+	you are switching, the command refuses to switch branches in
    -+	order to preserve your modifications in context.  However,
    -+	with this option, a three-way merge between the current
    -+	branch, your working tree contents, and the new branch is
    -+	done, and you will be on the new branch.
    -++
    -+When a merge conflict happens, the index entries for conflicting
    -+paths are left unmerged, and you need to resolve the conflicts
    -+and mark the resolved paths with `git add` (or `git rm` if the merge
    -+should result in deletion of the path).
    -+
    -+--conflict=<style>::
    -+	The same as --merge option above, but changes the way the
    -+	conflicting hunks are presented, overriding the
    -+	merge.conflictStyle configuration variable.  Possible values are
    -+	"merge" (default) and "diff3" (in addition to what is shown by
    -+	"merge" style, shows the original contents).
    ++	`branch.autoSetupMerge` configuration variable is true.
     +
     +--orphan <new-branch>::
    -+	Create a new 'orphan' branch, named `<new-branch>`, started from
    -+	`<start-point>` and switch to it. See explanation of the same
    -+	option in linkgit:git-checkout[1] for details.
    ++	Create a new 'orphan' branch, named `<new-branch>`. If
    ++	`<start-point>` is specified, the index and working tree are
    ++	adjusted to match it. Otherwise both are adjusted to contain no
    ++	tracked files.
     +
     +--ignore-other-worktrees::
     +	`git switch` refuses when the wanted ref is already
    @@ -303,15 +315,20 @@
     +	the ref out anyway. In other words, the ref can be held by
     +	more than one worktree.
     +
    ++--ignore-in-progress::
    ++	`git switch` by default refuses when some operation is in
    ++	progress (e.g. "git rebase", "git am" ...). This option
    ++	overrides this safety check and allows switching.
    ++
     +--recurse-submodules::
     +--no-recurse-submodules::
    -+	Using --recurse-submodules will update the content of all initialized
    ++	Using `--recurse-submodules` will update the content of all initialized
     +	submodules according to the commit recorded in the superproject. If
     +	local modifications in a submodule would be overwritten the checkout
    -+	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
    ++	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
     +	is used, the work trees of submodules will not be updated.
    -+	Just like linkgit:git-submodule[1], this will detach the
    -+	submodules HEAD.
    ++	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
    ++	submodule.
     +
     +EXAMPLES
     +--------
    @@ -366,7 +383,7 @@
     +------------
     +
     +If you want to start a new branch from a remote branch of the same
    -+name, use `-g`:
    ++name:
     +
     +------------
     +$ git switch -g new-topic
    @@ -374,7 +391,7 @@
     +Switched to a new branch 'new-topic'
     +------------
     +
    -+To check out commit "HEAD~3" for temporary inspection or experiment
    ++To check out commit `HEAD~3` for temporary inspection or experiment
     +without creating a new branch:
     +
     +------------
    @@ -391,7 +408,8 @@
     +
     +SEE ALSO
     +--------
    -+linkgit:git-checkout[1]
    ++linkgit:git-checkout[1],
    ++linkgit:git-branch[1]
     +
     +GIT
     +---
 9:  5491932cc8 = 11:  c966bacfcc switch: better names for -b and -B
 -:  ---------- > 12:  bdb88bf9a9 switch: add --discard-changes
10:  e0f1247b09 = 13:  d5fe7f4bd0 switch: remove -l
11:  f7ff1a7df6 ! 14:  3bce4c521e switch: stop accepting pathspec
    @@ -11,9 +11,9 @@
      --- a/builtin/checkout.c
      +++ b/builtin/checkout.c
     @@
    - 	int count_checkout_paths;
      	int overlay_mode;
      	int no_dwim_new_local_branch;
    + 	int discard_changes;
     +	int accept_pathspec;
      
      	/*
12:  0750d63d38 ! 15:  dad0063fc4 switch: reject "do nothing" case
    @@ -17,8 +17,8 @@
      --- a/builtin/checkout.c
      +++ b/builtin/checkout.c
     @@
    - 	int overlay_mode;
      	int no_dwim_new_local_branch;
    + 	int discard_changes;
      	int accept_pathspec;
     +	int switch_branch_doing_nothing_is_ok;
      
13:  bcd843146d ! 16:  41ca042917 switch: only allow explicit detached HEAD
    @@ -24,6 +24,36 @@
      	int writeout_stage;
      	int overwrite_ignore;
      	int ignore_skipworktree;
    +@@
    + 	return status;
    + }
    + 
    ++static void die_expecting_a_branch(const struct branch_info *branch_info)
    ++{
    ++	struct object_id oid;
    ++	char *to_free;
    ++
    ++	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free) == 1) {
    ++		const char *ref = to_free;
    ++
    ++		if (skip_prefix(ref, "refs/tags/", &ref))
    ++			die(_("a branch is expected, got tag '%s'"), ref);
    ++		if (skip_prefix(ref, "refs/remotes/", &ref))
    ++			die(_("a branch is expected, got remote branch '%s'"), ref);
    ++		die(_("a branch is expected, got '%s'"), ref);
    ++	}
    ++	if (branch_info->commit)
    ++		die(_("a branch is expected, got commit '%s'"), branch_info->name);
    ++	/*
    ++	 * This case should never happen because we already die() on
    ++	 * non-commit, but just in case.
    ++	 */
    ++	die(_("a branch is expected, got '%s'"), branch_info->name);
    ++}
    ++
    + static int checkout_branch(struct checkout_opts *opts,
    + 			   struct branch_info *new_branch_info)
    + {
     @@
      	    !opts->force_detach)
      		die(_("missing branch or commit argument"));
    @@ -34,7 +64,7 @@
     +	    !opts->new_branch_force &&
     +	    new_branch_info->name &&
     +	    !new_branch_info->path)
    -+		die(_("a branch is expected, got %s"), new_branch_info->name);
    ++		die_expecting_a_branch(new_branch_info);
     +
      	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
      	    !opts->ignore_other_worktrees) {
14:  d5cc55525d = 17:  a0b9f1b285 switch: add short option for --detach
15:  4a27400a58 ! 18:  3d254df104 switch: no implicit dwim, use --guess to dwim
    @@ -1,15 +1,15 @@
     Author: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
     
    -    switch: no implicit dwim, use --guess to dwim
    +    switch: implicit dwim, use --no-guess to disable it
     
    -    Similar to automatic detach, this behavior could be confusing because
    -    it can sometimes create a new branch without a user asking it to,
    -    especially when the user is still not aware about this feature.
    +    This is already the default in git-checkout. The real change in here is
    +    just minor cleanup. The main excuse is to explain why dwim is kept default.
     
    -    In the future, perhaps we could have a config key to disable these
    -    safety nets and let 'switch' do automatic detach or dwim
    -    again. But that will be opt-in after the user knows what is what. For
    -    now give a short option if you want to use it often.
    +    Contrary to detach mode that is easy to get into and confusing to get
    +    back out. Automatically creating a tracking branch often does not kick
    +    in as often (you would need a branch of the same name on a remote). And
    +    since the branch creation is reported clearly, the user should be able
    +    to undo/delete it if it's unwanted.
     
      diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
      --- a/Documentation/git-checkout.txt
    @@ -41,7 +41,7 @@
      rather expensive side-effects to show only the tracking information,
     @@
      	Do not set up "upstream" configuration, even if the
    - 	branch.autoSetupMerge configuration variable is true.
    + 	`branch.autoSetupMerge` configuration variable is true.
      
     +--guess::
     +--no-guess::
    @@ -68,8 +68,8 @@
      	Create the new branch's reflog; see linkgit:git-branch[1] for
      	details.
     @@
    - 	Just like linkgit:git-submodule[1], this will detach the
    - 	submodules HEAD.
    + 	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
    + 	submodule.
      
     ---no-guess::
     -	Do not attempt to create a branch if a remote tracking branch
    @@ -88,9 +88,9 @@
      	int overlay_mode;
     -	int no_dwim_new_local_branch;
     +	int dwim_new_local_branch;
    + 	int discard_changes;
      	int accept_pathspec;
      	int switch_branch_doing_nothing_is_ok;
    - 
     @@
      		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
      			   N_("update ignored files (default)"),
    @@ -145,15 +145,17 @@
      			   N_("create and switch to a new branch")),
      		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
      			   N_("create/reset and switch to a branch")),
    -+		OPT_BOOL('g', "guess", &opts.dwim_new_local_branch,
    ++		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
     +			 N_("second guess 'git switch <no-such-branch>'")),
    + 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
    + 			 N_("throw away local modifications")),
      		OPT_END()
    - 	};
    +@@
      	int ret;
      
      	memset(&opts, 0, sizeof(opts));
     -	opts.no_dwim_new_local_branch = 0;
    -+	opts.dwim_new_local_branch = 0;
    ++	opts.dwim_new_local_branch = 1;
      	opts.accept_pathspec = 0;
      	opts.switch_branch_doing_nothing_is_ok = 0;
      	opts.implicit_detach = 0;
16:  f7dd33abe6 ! 19:  c6ea203f36 switch: no worktree status unless real branch switch happens
    @@ -36,8 +36,8 @@
      --- a/builtin/checkout.c
      +++ b/builtin/checkout.c
     @@
    - #include "submodule.h"
    - #include "advice.h"
    + #include "unpack-trees.h"
    + #include "xdiff-interface.h"
      
     -static int checkout_optimize_new_branch;
     -
    @@ -45,7 +45,7 @@
      	N_("git checkout [<options>] <branch>"),
      	N_("git checkout [<options>] [<branch>] -- <file>..."),
     @@
    - 	int dwim_new_local_branch;
    + 	int discard_changes;
      	int accept_pathspec;
      	int switch_branch_doing_nothing_is_ok;
     -
    @@ -220,7 +220,7 @@
      	opts.implicit_detach = 1;
      
     @@
    - 	opts.dwim_new_local_branch = 0;
    + 	opts.dwim_new_local_branch = 1;
      	opts.accept_pathspec = 0;
      	opts.switch_branch_doing_nothing_is_ok = 0;
     +	opts.only_merge_on_switching_branches = 1;
 -:  ---------- > 20:  5c4effc7fd switch: reject if some operation is in progress
 -:  ---------- > 21:  a4afe6a999 switch: --orphan defaults to empty tree as HEAD
17:  5b182abea8 ! 22:  6cca78f835 t: add tests for switch
    @@ -31,12 +31,9 @@
     +	test_path_is_missing second.t
     +'
     +
    -+test_expect_success 'switch to a commit' '
    -+	test_must_fail git switch master^{commit}
    -+'
    -+
     +test_expect_success 'switch and detach' '
     +	test_when_finished git switch master &&
    ++	test_must_fail git switch master^{commit} &&
     +	git switch --detach master^{commit} &&
     +	test_must_fail git symbolic-ref HEAD
     +'
    @@ -60,6 +57,7 @@
     +test_expect_success 'force create branch from HEAD' '
     +	test_when_finished git switch master &&
     +	git switch --detach master &&
    ++	test_must_fail git switch -c temp &&
     +	git switch -C temp &&
     +	test_cmp_rev master refs/heads/temp &&
     +	echo refs/heads/temp >expected-branch &&
    @@ -67,12 +65,15 @@
     +	test_cmp expected-branch actual-branch
     +'
     +
    -+test_expect_success 'new orphan branch' '
    ++test_expect_success 'new orphan branch from empty' '
     +	test_when_finished git switch master &&
    -+	git switch --orphan new-orphan master^ &&
    ++	git switch --orphan new-orphan &&
     +	test_commit orphan &&
     +	git cat-file commit refs/heads/new-orphan >commit &&
    -+	! grep ^parent commit
    ++	! grep ^parent commit &&
    ++	git ls-files >tracked-files &&
    ++	echo orphan.t >expected &&
    ++	test_cmp expected tracked-files
     +'
     +
     +test_expect_success 'switching ignores file of same branch name' '
    @@ -81,16 +82,25 @@
     +	git switch first-branch &&
     +	echo refs/heads/first-branch >expected &&
     +	git symbolic-ref HEAD >actual &&
    -+	test_commit expected actual
    ++	test_cmp expected actual
     +'
     +
     +test_expect_success 'guess and create branch ' '
     +	test_when_finished git switch master &&
    -+	test_must_fail git switch foo &&
    -+	git switch --guess foo &&
    ++	test_must_fail git switch --no-guess foo &&
    ++	git switch foo &&
     +	echo refs/heads/foo >expected &&
     +	git symbolic-ref HEAD >actual &&
     +	test_cmp expected actual
     +'
     +
    ++test_expect_success 'switching when something is in progress' '
    ++	test_when_finished rm -f .git/MERGE_HEAD &&
    ++	# fake a merge-in-progress
    ++	cp .git/HEAD .git/MERGE_HEAD &&
    ++	test_must_fail git switch -d @^ &&
    ++	git switch --ignore-in-progress -d @^ &&
    ++	git switch -
    ++'
    ++
     +test_done
18:  1575064fe6 ! 23:  e5e6f9d6f1 completion: support switch
    @@ -10,6 +10,16 @@
      diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
      --- a/contrib/completion/git-completion.bash
      +++ b/contrib/completion/git-completion.bash
    +@@
    + #   GIT_COMPLETION_CHECKOUT_NO_GUESS
    + #
    + #     When set to "1", do not include "DWIM" suggestions in git-checkout
    +-#     completion (e.g., completing "foo" when "origin/foo" exists).
    ++#     and git-switch completion (e.g., completing "foo" when "origin/foo"
    ++#     exists).
    + 
    + case "$COMP_WORDBREAKS" in
    + *:*) : great ;;
     @@
      	__git_complete_index_file "$complete_opt"
      }
    @@ -24,15 +34,22 @@
     +		__gitcomp_builtin switch
     +		;;
     +	*)
    -+		# check if ---guess was specified to enable DWIM mode
    -+		local track_opt= only_local_ref=n
    -+		if [ -n "$(__git_find_on_cmdline "-g --guess")" ]; then
    ++		# check if --track, --no-track, or --no-guess was specified
    ++		# if so, disable DWIM mode
    ++		local track_opt="--track" only_local_ref=n
    ++		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
    ++		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
    ++			track_opt=''
    ++		fi
    ++		# explicit --guess enables DWIM mode regardless of
    ++		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
    ++		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
     +			track_opt='--track'
     +		fi
     +		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
     +			only_local_ref=y
     +		fi
    -+		if [ $only_local_ref = y -a -n "$track_opt"]; then
    ++		if [ $only_local_ref = y -a -z "$track_opt" ]; then
     +			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
     +		else
     +			__git_complete_refs $track_opt
19:  8ed01ad0c5 ! 24:  807e8bc50b doc: promote "git switch"
    @@ -647,23 +647,28 @@
      void detach_advice(const char *new_name)
      {
      	const char *fmt =
    --	_("Note: checking out '%s'.\n\n"
    +-	_("Note: checking out '%s'.\n"
     +	_("Note: switching to '%s'.\n"
    -+	"\n"
    + 	"\n"
      	"You are in 'detached HEAD' state. You can look around, make experimental\n"
      	"changes and commit them, and you can discard any commits you make in this\n"
    --	"state without impacting any branches by performing another checkout.\n\n"
    +-	"state without impacting any branches by performing another checkout.\n"
     +	"state without impacting any branches by switching back to a branch.\n"
    -+	"\n"
    + 	"\n"
      	"If you want to create a new branch to retain commits you create, you may\n"
    --	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
    --	"  git checkout -b <new-branch-name>\n\n");
    +-	"do so (now or later) by using -b with the checkout command again. Example:\n"
     +	"do so (now or later) by using -c with the switch command. Example:\n"
    -+	"\n"
    -+	"  git switch -c <new-branch-name>\n\n");
    + 	"\n"
    +-	"  git checkout -b <new-branch-name>\n"
    ++	"  git switch -c <new-branch-name>\n"
    + 	"\n"
    + 	"Or undo this checkout with:\n"
    + 	"\n"
    +-	"  git checkout -\n"
    ++	"  git switch -\n"
    + 	"\n"
    + 	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
      
    - 	fprintf(stderr, fmt, new_name);
    - }
     
      diff --git a/sha1-name.c b/sha1-name.c
      --- a/sha1-name.c
    @@ -700,8 +705,13 @@
     -	  git checkout -b <new-branch-name>
     +	  git switch -c <new-branch-name>
      
    - 	HEAD is now at \$commit three
    - 	EOF
    + 	Or undo this checkout with:
    + 
    +-	  git checkout -
    ++	  git switch -
    + 
    + 	Turn off this advice by setting config variable advice.detachedHead to false
    + 
     @@
      
      	# The first detach operation is more chatty than the following ones.
    @@ -721,5 +731,10 @@
     -	  git checkout -b <new-branch-name>
     +	  git switch -c <new-branch-name>
      
    - 	HEAD is now at \$commit... three
    - 	EOF
    + 	Or undo this checkout with:
    + 
    +-	  git checkout -
    ++	  git switch -
    + 
    + 	Turn off this advice by setting config variable advice.detachedHead to false
    + 
-- 
2.21.0.548.gd3c7d92dc2

