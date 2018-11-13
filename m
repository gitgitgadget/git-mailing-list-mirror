Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F3C1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 17:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbeKNDvm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 22:51:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34726 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbeKNDvm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 22:51:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so9494986lfc.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5QUi2GzwHVI9XlIZPBFQ+0Cn0AF3SerfOG9ykLCMtk=;
        b=YfY4oJAHfculq4Jymnp0Z/W6NshFjL17EigP8pCMOWzmODbm2Azv7KOwgG9D0crOtG
         K/REHSdjDZ19Grqs9GPXoirn2hN6gMewk6uDZ2uazoW8tyzowStu+OOYmSM5qJ6P0Btm
         Xe6DiqlvI+UPiX4Zp+UoHzWm8O9ukS3rpx6unQrAlX+7kHo+HhHSp30Mf3mMtBwioZM7
         mJLZeq4PuSYpkb3/+uZc5zIa9SzmVHUylnPmroOYqxpWhtr4iYUnN8JXBNTTckchlZx/
         pHa4kvH4ER1zi1qp59g4wjW1qFWyeFzMe60SHATPybpCDalhvUPqMLhom4/+1pnKshw5
         L0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5QUi2GzwHVI9XlIZPBFQ+0Cn0AF3SerfOG9ykLCMtk=;
        b=QVjyK1+jwta5Rl/vuVn0Le5eAEhUO1EW30+6tPHTV/JV1US/YrO8MXMwzz6sUlvmLn
         cMt/c2WC1qM+uaR2SrcOKonNc14ZterEa+Z0J1yvmQd3LUnkOngD00KWfsYEOkdIwm6k
         wcmYz7Ysp9cV+1+snF/d7j2Dv79gRV2TxKlUPmAUb2d+KS/yJNU7yvJM+k8LuMSJt7Sm
         a+JOk+adAP0kLYD7NfxkPeRcrd7I9h4Ix8Kv6u0i5ouHWn5yoh2ktK97M/QilD7dtFbs
         MYB/B2I+YskKyFfiRFr0GmJBIxjDvXfQ4F6+aPj3G0S9a/wUKiEWVPsIjCLkECwdmk7A
         AXuw==
X-Gm-Message-State: AGRZ1gItDAgkhVaHbm4g8OUnV4lll+Inds8xH4tHHKGqOhDrWcNinYxV
        o2hmKlIFZrp3Jv84HU8ofDY=
X-Google-Smtp-Source: AJdET5eiXuW0qisH8BbCtVFzdSgBiYNEj1lLSZ3piiXtGiLSPv5LaTi+d1ClL9KhJ4lIDSgc/0SZ/g==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr3373072lfb.121.1542131551511;
        Tue, 13 Nov 2018 09:52:31 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j12-v6sm3468887lja.8.2018.11.13.09.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:52:30 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/1] disambiguate dwim tracking branches and local files
Date:   Tue, 13 Nov 2018 18:52:25 +0100
Message-Id: <20181113175226.25635-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1318.g5295c6727d
In-Reply-To: <20181110120707.25846-1-pclouds@gmail.com>
References: <20181110120707.25846-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 leaves "pathspec with wildcard" case alone. The behavior in this
case remains as before.

--no-guess is now made visible in "git checkout -h" and the man page.


PS. Based on git-checkout.txt I don't think any user can work out that
"git checkout branch --" can be used to disambiguate. And updating the
doc to show that makes it a lot uglier.

Perhaps it's time we add two new semi-aliases, switch-branch and
restore-path. They will have the same syntax as checkout in their
respective use case, without ambiguation. Semi-aliases because like
builtin commands, they cannot be overriden by user aliases.

Nguyễn Thái Ngọc Duy (1):
  checkout: disambiguate dwim tracking branches and local files

 Documentation/git-checkout.txt |  4 ++++
 builtin/checkout.c             | 18 +++++++++++++-----
 t/t2024-checkout-dwim.sh       | 31 +++++++++++++++++++++++++++++++
 t/t9902-completion.sh          |  3 ++-
 4 files changed, 50 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  530f5d8f03 ! 1:  0408fdde4d checkout: disambiguate dwim tracking branches and local files
    @@ -21,12 +21,36 @@
     
         We normally try to do the right thing, but when there are multiple
         "right things" to do, it's best to leave it to the user to decide.
    -    Check this case, ask the user to use "--" to disambiguate.
    +    Check this case, ask the user to to disambiguate:
    +
    +    - "git checkout -- foo" will check out path "foo"
    +    - "git checkout foo --" will dwim and create branch "foo" [4]
    +
    +    For users who do not want dwim, use --no-guess. It's useless in this
    +    particular case because "git checkout --no-guess foo --" will just
    +    fail. But it could be used by scripts.
     
         [1] 70c9ac2f19 (DWIM "git checkout frotz" to "git checkout -b frotz
             origin/frotz" - 2009-10-18)
         [2] https://public-inbox.org/git/CACsJy8B2TVr1g+k+eSQ=pBEO3WN4_LtgLo9gpur8X7Z9GOFL_A@mail.gmail.com/
         [3] https://news.ycombinator.com/item?id=18230655
    +    [4] a047fafc78 (checkout: allow dwim for branch creation for "git
    +        checkout $branch --" - 2013-10-18)
    +
    + diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
    + --- a/Documentation/git-checkout.txt
    + +++ b/Documentation/git-checkout.txt
    +@@
    + 	Just like linkgit:git-submodule[1], this will detach the
    + 	submodules HEAD.
    + 
    ++--no-guess::
    ++	Do not attempt to create a branch if a remote tracking branch
    ++	of the same name exists.
    ++
    + <branch>::
    + 	Branch to checkout; if it refers to a branch (i.e., a name that,
    + 	when prepended with "refs/heads/", is a valid ref), then that
     
      diff --git a/builtin/checkout.c b/builtin/checkout.c
      --- a/builtin/checkout.c
    @@ -37,9 +61,11 @@
      
     -		if (!has_dash_dash &&
     -		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
    --			recover_with_dwim = 0;
     +		int could_be_checkout_paths = !has_dash_dash &&
    -+			(check_filename(opts->prefix, arg) || !no_wildcard(arg));
    ++			check_filename(opts->prefix, arg);
    ++
    ++		if (!has_dash_dash && !no_wildcard(arg))
    + 			recover_with_dwim = 0;
     +
      		/*
      		 * Accept "git checkout foo" and "git checkout foo --"
    @@ -50,10 +76,39 @@
      			if (remote) {
     +				if (could_be_checkout_paths)
     +					die(_("'%s' could be both a local file and a tracking branch.\n"
    -+					      "Please use -- to disambiguate"), arg);
    ++					      "Please use -- (and optionally --no-guess) to disambiguate"),
    ++					    arg);
      				*new_branch = arg;
      				arg = remote;
      				/* DWIMmed to create local branch, case (3).(b) */
    +@@
    + 	struct checkout_opts opts;
    + 	struct branch_info new_branch_info;
    + 	char *conflict_style = NULL;
    +-	int dwim_new_local_branch = 1;
    ++	int dwim_new_local_branch, no_dwim_new_local_branch = 0;
    + 	int dwim_remotes_matched = 0;
    + 	struct option options[] = {
    + 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
    +@@
    + 		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
    + 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
    + 			 N_("do not limit pathspecs to sparse entries only")),
    +-		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
    +-				N_("second guess 'git checkout <no-such-branch>'")),
    ++		OPT_BOOL(0, "no-guess", &no_dwim_new_local_branch,
    ++			 N_("do not second guess 'git checkout <no-such-branch>'")),
    + 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
    + 			 N_("do not check if another worktree is holding the given ref")),
    + 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
    +@@
    + 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
    + 			     PARSE_OPT_KEEP_DASHDASH);
    + 
    ++	dwim_new_local_branch = !no_dwim_new_local_branch;
    + 	if (opts.show_progress < 0) {
    + 		if (opts.quiet)
    + 			opts.show_progress = 0;
     
      diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
      --- a/t/t2024-checkout-dwim.sh
    @@ -94,3 +149,17 @@
     +'
     +
      test_done
    +
    + diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
    + --- a/t/t9902-completion.sh
    + +++ b/t/t9902-completion.sh
    +@@
    + 	--ignore-other-worktrees Z
    + 	--recurse-submodules Z
    + 	--progress Z
    +-	--no-quiet Z
    ++	--guess Z
    ++	--no-guess Z
    + 	--no-... Z
    + 	EOF
    + '
-- 
2.19.1.1318.g5295c6727d

