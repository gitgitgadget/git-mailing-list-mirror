Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA8B1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfBHJEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:04:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1303844pgq.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaVTKtlAO/IC3mpqNvOGGj8zznocueMLsDTZKDCMIV0=;
        b=m+d4Lhv404ejgNjnJrNQw+iuNkNGcM/CIRVEQHLk/HScbxgRswpWrc/Co4R5gF0uHf
         3iFXnD5L2OCdNlwZsnLjtHM+MaBiKB1n/czl+h1JxD58Cg5b7+3GpYRBNNW8urYJzYCP
         9hh00oIMfZaVECDmdVdZHJ5QfsxKP0tP6Kw1+gbvpJBozEw8JwQyl8QaqAzguVppEGBN
         xhQ3SzeR9K3sxMp0hOBYU8yiKyirRs0ZOg5pin0kpMHS9FoaLdjtxkm9p5T2nTNM+IR5
         b+Y6v2y5QIMWfTHD37wLDpUxNlKqdDY+gxzyt4Z6vWFfL+gQhg30byLg9l6lF4oCPYib
         p2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaVTKtlAO/IC3mpqNvOGGj8zznocueMLsDTZKDCMIV0=;
        b=SqbyIWAqfZPEwVg2y5l797yUjt+F5Zi0QxJMg0ebRnxADnY0lczJ1ncfdVYDJhsju+
         GoZtnLaCApyfM60PBkMS0na1W32GJ73PFOMgMTb+qWIbwkXRQ7gcztnBOOtfIuRK1u8f
         1cLoIVYnLnYJiGlv1FtyRoKH4SWtdV2cXafwMeA0au9JFIWI+oFttyMYVubdec8WtvR1
         qHJsp7t6JwRygiQM4SJNP9bD7LYA/Z2YJkH98MFeibLsCVK08hwXSrxPfFyEIsm4UNI9
         KysgxIYUbqi7epK9NyzbqwcNnbridwinouX+SOV/IVUOaB7uWJguXjMIC3F/hbqvJyqY
         LvXA==
X-Gm-Message-State: AHQUAuZQXPctxjqRe4NTqb0i3Hp08j1KXpeFn8p8oZUu2XS3BsUuoy9v
        3FbLADdswYqHyTPoi0ep6F0=
X-Google-Smtp-Source: AHgI3IY1xEZ/5XFSS/IqFvHNQEHpFgQ6heC/2C2fO819QVxhKKuOhizMg54z0wlC1RcPSCQ+j3a1cw==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr18828687pgk.21.1549616664116;
        Fri, 08 Feb 2019 01:04:24 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p24sm4785050pfj.72.2019.02.08.01.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:04:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/19] Add new command "switch"
Date:   Fri,  8 Feb 2019 16:03:42 +0700
Message-Id: <20190208090401.14793-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a new command "switch" for switching branches, an
alternative for "git checkout".

v2 fixes the comments I got from v1. I think the range-diff below
summarizes it better than I do. No major changes though.

Range-diff dựa trên v1:
 1:  6d550b443c !  1:  2283204090 checkout: split part of it to new command switch
    @@ -148,24 +148,33 @@
     +--------
     +[verse]
     +'git switch' [<options>] [--guess] <branch>
    -+'git switch' [<options>] --detach [<start_point>>]
    -+'git switch' [<options>] [[-c|-C|--orphan] <new_branch>] [<start_point>]
    ++'git switch' [<options>] --detach [<start-point>]
    ++'git switch' [<options>] (-c|-C|--orphan) <new-branch> [<start-point>]
     +
     +DESCRIPTION
     +-----------
    -+Switch to a specified branch and update files in the working tree to
    -+match it. Optionally a new branch could be created with either `-c` or
    -+`-C`, or detach from any branch with `--detach`, along with switching.
    ++Switch to a specified branch. The working tree and the index are
    ++updated to match the branch. All new commits will be added to the tip
    ++of this branch.
    ++
    ++Optionally a new branch could be created with either `-c` or `-C`, or
    ++detach the working tree from any branch with `--detach`, along with
    ++switching.
    ++
    ++Switching branches does not require a clean index and working tree
    ++(i.e. no differences compared to 'HEAD'). The operation is aborted
    ++however if the switch leads to loss of local changes, unless told
    ++otherwise.
     +
     +OPTIONS
     +-------
     +<branch>::
     +	Branch to switch to.
     +
    -+<new_branch>::
    ++<new-branch>::
     +	Name for the new branch.
     +
    -+<start_point>::
    ++<start-point>::
     +	The name of a commit at which to switch to before creating a
     +	new branch or detach from.
     ++
    @@ -177,17 +186,27 @@
     +base of `A` and `B` if there is exactly one merge base. You can leave
     +out at most one of `A` and `B`, in which case it defaults to `HEAD`.
     +
    -+-c <new_branch>::
    -+--create <new_branch>::
    -+	Create a new branch named <new_branch> and start it at
    -+	<start_point>; see linkgit:git-branch[1] for details.
    ++-c <new-branch>::
    ++--create <new-branch>::
    ++	Create a new branch named <new-branch> starting at
    ++	<start-point> before switching to the branch. This is a
    ++	convenient shortcut for:
    +++
    ++------------
    ++$ git branch <new-branch>
    ++$ git switch <new-branch>
    ++------------
     +
    -+-C <new_branch>::
    -+--force-create <new_branch>::
    -+	Creates the branch <new_branch> and start it at <start_point>;
    -+	if it already exists, then reset it to <start_point>. This is
    -+	equivalent to running "git branch" with "-f"; see
    -+	linkgit:git-branch[1] for details.
    ++-C <new-branch>::
    ++--force-create <new-branch>::
    ++	Similar to `--create` except that if <new-branch> already
    ++	exists, it will be reset to <start-point>. This is a
    ++	convenient shortcut for:
    +++
    ++------------
    ++$ git branch -f <new-branch>
    ++$ git switch <new-branch>
    ++------------
     +
     +-d::
     +--detach::
    @@ -220,7 +239,9 @@
     +-f::
     +--force::
     +	Proceed even if the index or the working tree differs from
    -+	HEAD.  This is used to throw away local changes.
    ++	HEAD. Both the index and working tree are restored to match
    ++	the switching target. This is used to throw away local
    ++	changes.
     +
     +--[no-]progress::
     +	Progress status is reported on the standard error stream
    @@ -270,9 +291,9 @@
     +	"merge" (default) and "diff3" (in addition to what is shown by
     +	"merge" style, shows the original contents).
     +
    -+--orphan <new_branch>::
    -+	Create a new 'orphan' branch, named <new_branch>, started from
    -+	<start_point> and switch to it. See explanation of the same
    ++--orphan <new-branch>::
    ++	Create a new 'orphan' branch, named <new-branch>, started from
    ++	<start-point> and switch to it. See explanation of the same
     +	option in linkgit:git-checkout[1] for details.
     +
     +--ignore-other-worktrees::
 2:  e2f94df471 !  2:  deceb221dc switch: better names for -b and -B
    @@ -61,7 +61,7 @@
     +		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
     +			   N_("create and switch to a new branch")),
     +		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
    -+			   N_("create/reset and switch to a new branch")),
    ++			   N_("create/reset and switch to a branch")),
     +		OPT_END()
     +	};
      	int ret;
 3:  b3d431a97f =  3:  08f28e9726 switch: remove -l
 4:  26738818fa =  4:  9ee4852c8b switch: stop accepting pathspec
 5:  79ebe7a68c !  5:  0a7ea4b33b switch: reject "do nothing" case
    @@ -32,7 +32,7 @@
     +	    !new_branch_info->name &&
     +	    !opts->new_branch &&
     +	    !opts->force_detach)
    -+		die(_("nothing to do"));
    ++		die(_("missing branch or commit argument"));
     +
      	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
      	    !opts->ignore_other_worktrees) {
 6:  bc36ac8510 !  6:  eedf82c72b switch: only allow explicit detached HEAD
    @@ -26,7 +26,7 @@
      	int ignore_skipworktree;
     @@
      	    !opts->force_detach)
    - 		die(_("nothing to do"));
    + 		die(_("missing branch or commit argument"));
      
     +	if (!opts->implicit_detach &&
     +	    !opts->force_detach &&
 7:  1a761ce8e5 =  7:  9314ff16c9 switch: add short option for --detach
 8:  738c560eb9 !  8:  9d8e461df2 switch: no implicit dwim, use --guess to dwim
    @@ -143,7 +143,7 @@
     @@
      			   N_("create and switch to a new branch")),
      		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
    - 			   N_("create/reset and switch to a new branch")),
    + 			   N_("create/reset and switch to a branch")),
     +		OPT_BOOL('g', "guess", &opts.dwim_new_local_branch,
     +			 N_("second guess 'git switch <no-such-branch>'")),
      		OPT_END()
 9:  456e9340f1 =  9:  749665c457 switch: no worktree status unless real branch switch happens
10:  cdd132a7e2 ! 10:  e4e0b397eb t: add tests for switch
    @@ -51,9 +51,7 @@
     +test_expect_success 'switch and create branch' '
     +	test_when_finished git switch master &&
     +	git switch -c temp master^ &&
    -+	git rev-parse master^ >expected &&
    -+	git rev-parse refs/heads/temp >actual &&
    -+	test_cmp expected actual &&
    ++	test_cmp_rev master^ refs/heads/temp &&
     +	echo refs/heads/temp >expected-branch &&
     +	git symbolic-ref HEAD >actual-branch &&
     +	test_cmp expected-branch actual-branch
    @@ -63,9 +61,7 @@
     +	test_when_finished git switch master &&
     +	git switch --detach master &&
     +	git switch -C temp &&
    -+	git rev-parse master >expected &&
    -+	git rev-parse refs/heads/temp >actual &&
    -+	test_cmp expected actual &&
    ++	test_cmp_rev master refs/heads/temp &&
     +	echo refs/heads/temp >expected-branch &&
     +	git symbolic-ref HEAD >actual-branch &&
     +	test_cmp expected-branch actual-branch
11:  96a97fcab4 = 11:  b9a7662271 completion: support switch
12:  8d984bc684 ! 12:  7449a0c4cc doc: promote "git switch"
    @@ -40,14 +40,18 @@
      +
      <1> This step and the next one could be combined into a single step with
     @@
    + NOTES
      -----
      
    - If you are creating a branch that you want to checkout immediately, it is
    +-If you are creating a branch that you want to checkout immediately, it is
     -easier to use the git checkout command with its `-b` option to create
    -+easier to use the "git switch" command with its `-c` option to create
    - a branch and check it out with a single command.
    +-a branch and check it out with a single command.
    ++If you are creating a branch that you want to switch to immediately,
    ++it is easier to use the "git switch" command with its `-c` option to
    ++do the same thing with a single command.
      
      The options `--contains`, `--no-contains`, `--merged` and `--no-merged`
    + serve four related but different purposes:
     
      diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
      --- a/Documentation/git-check-ref-format.txt
    @@ -473,9 +477,11 @@
      ------------------------------------------------------
      
     -The `git checkout` command normally expects a branch head, but will also
    +-accept an arbitrary commit; for example, you can check out the commit
    +-referenced by a tag:
     +The `git switch` command normally expects a branch head, but will also
    - accept an arbitrary commit; for example, you can check out the commit
    - referenced by a tag:
    ++accept an arbitrary commit when invoked with --detach; for example,
    ++you can check out the commit referenced by a tag:
      
      ------------------------------------------------
     -$ git checkout v2.6.17
    @@ -628,36 +634,23 @@
      {
      	const char *fmt =
     -	_("Note: checking out '%s'.\n\n"
    -+	_("Note: checking out '%s'.\n"
    ++	_("Note: switching to '%s'.\n"
     +	"\n"
      	"You are in 'detached HEAD' state. You can look around, make experimental\n"
      	"changes and commit them, and you can discard any commits you make in this\n"
     -	"state without impacting any branches by performing another checkout.\n\n"
    -+	"state without impacting any branches by performing another checkout.\n"
    ++	"state without impacting any branches by switching back to a branch.\n"
     +	"\n"
      	"If you want to create a new branch to retain commits you create, you may\n"
     -	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
     -	"  git checkout -b <new-branch-name>\n\n");
    -+	"do so (now or later) by using -b with the checkout command again. Example:\n"
    ++	"do so (now or later) by using -c with the switch command. Example:\n"
     +	"\n"
     +	"  git switch -c <new-branch-name>\n\n");
      
      	fprintf(stderr, fmt, new_name);
      }
     
    - diff --git a/builtin/clone.c b/builtin/clone.c
    - --- a/builtin/clone.c
    - +++ b/builtin/clone.c
    -@@
    - static const char junk_leave_repo_msg[] =
    - N_("Clone succeeded, but checkout failed.\n"
    -    "You can inspect what was checked out with 'git status'\n"
    --   "and retry the checkout with 'git checkout -f HEAD'\n");
    -+   "and retry the checkout with 'git switch -f HEAD'\n");
    - 
    - static void remove_junk(void)
    - {
    -
      diff --git a/sha1-name.c b/sha1-name.c
      --- a/sha1-name.c
      +++ b/sha1-name.c
    @@ -675,8 +668,20 @@
      --- a/t/t2020-checkout-detach.sh
      +++ b/t/t2020-checkout-detach.sh
     @@
    + 
    + 	# The first detach operation is more chatty than the following ones.
    + 	cat >1st_detach <<-EOF &&
    +-	Note: checking out 'HEAD^'.
    ++	Note: switching to 'HEAD^'.
    + 
    + 	You are in 'detached HEAD' state. You can look around, make experimental
    + 	changes and commit them, and you can discard any commits you make in this
    +-	state without impacting any branches by performing another checkout.
    ++	state without impacting any branches by switching back to a branch.
    + 
      	If you want to create a new branch to retain commits you create, you may
    - 	do so (now or later) by using -b with the checkout command again. Example:
    +-	do so (now or later) by using -b with the checkout command again. Example:
    ++	do so (now or later) by using -c with the switch command. Example:
      
     -	  git checkout -b <new-branch-name>
     +	  git switch -c <new-branch-name>
    @@ -684,8 +689,20 @@
      	HEAD is now at \$commit three
      	EOF
     @@
    + 
    + 	# The first detach operation is more chatty than the following ones.
    + 	cat >1st_detach <<-EOF &&
    +-	Note: checking out 'HEAD^'.
    ++	Note: switching to 'HEAD^'.
    + 
    + 	You are in 'detached HEAD' state. You can look around, make experimental
    + 	changes and commit them, and you can discard any commits you make in this
    +-	state without impacting any branches by performing another checkout.
    ++	state without impacting any branches by switching back to a branch.
    + 
      	If you want to create a new branch to retain commits you create, you may
    - 	do so (now or later) by using -b with the checkout command again. Example:
    +-	do so (now or later) by using -b with the checkout command again. Example:
    ++	do so (now or later) by using -c with the switch command. Example:
      
     -	  git checkout -b <new-branch-name>
     +	  git switch -c <new-branch-name>
13:  91e5442069 <  -:  ---------- checkout: split part of it to new command restore
14:  6bc8f87c0a <  -:  ---------- restore: take tree-ish from --from option instead
15:  095a1cd3e3 <  -:  ---------- restore: make pathspec mandatory
16:  6eb5612187 <  -:  ---------- restore: disable overlay mode by default
17:  cc79522047 <  -:  ---------- t: add tests for restore
18:  ed5d7097b6 <  -:  ---------- completion: support restore
19:  625a4fac68 <  -:  ---------- doc: promote "git restore"

Nguyễn Thái Ngọc Duy (19):
  git-checkout.txt: fix one syntax line
  doc: document --overwrite-ignore
  t: rename t2014-switch.sh to t2014-checkout-switch.sh
  checkout: factor out some code in parse_branchname_arg()
  checkout: make "opts" in cmd_checkout() a pointer
  checkout: move 'confict_style' and 'dwim_..' to checkout_opts
  checkout: split options[] array in three pieces
  checkout: split part of it to new command switch
  switch: better names for -b and -B
  switch: remove -l
  switch: stop accepting pathspec
  switch: reject "do nothing" case
  switch: only allow explicit detached HEAD
  switch: add short option for --detach
  switch: no implicit dwim, use --guess to dwim
  switch: no worktree status unless real branch switch happens
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
 Documentation/git-checkout.txt                |  48 +-
 Documentation/git-format-patch.txt            |   2 +-
 Documentation/git-merge-base.txt              |   2 +-
 Documentation/git-merge.txt                   |   4 +
 Documentation/git-rebase.txt                  |   2 +-
 Documentation/git-remote.txt                  |   2 +-
 Documentation/git-rerere.txt                  |  10 +-
 Documentation/git-reset.txt                   |  20 +-
 Documentation/git-stash.txt                   |   9 +-
 Documentation/git-switch.txt                  | 257 ++++++++++
 Documentation/gitattributes.txt               |   3 +-
 Documentation/gitcore-tutorial.txt            |  18 +-
 Documentation/giteveryday.txt                 |  24 +-
 Documentation/githooks.txt                    |   8 +-
 Documentation/gittutorial.txt                 |   4 +-
 Documentation/revisions.txt                   |   2 +-
 Documentation/user-manual.txt                 |  56 +--
 Makefile                                      |   1 +
 advice.c                                      |  11 +-
 builtin.h                                     |   1 +
 builtin/checkout.c                            | 464 +++++++++---------
 command-list.txt                              |   1 +
 contrib/completion/git-completion.bash        |  26 +
 git.c                                         |   1 +
 parse-options-cb.c                            |  17 +
 parse-options.h                               |   3 +-
 sha1-name.c                                   |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  14 -
 ...014-switch.sh => t2014-checkout-switch.sh} |   0
 t/t2020-checkout-detach.sh                    |  16 +-
 t/t2060-switch.sh                             |  87 ++++
 38 files changed, 796 insertions(+), 372 deletions(-)
 create mode 100644 Documentation/git-switch.txt
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)
 create mode 100755 t/t2060-switch.sh
-- 
2.20.1.682.gd5861c6d90

