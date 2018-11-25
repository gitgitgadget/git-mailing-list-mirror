Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057141F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 22:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeKZJMf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 04:12:35 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35459 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 04:12:35 -0500
Received: by mail-wm1-f52.google.com with SMTP id c126so16398208wmh.0
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3cj4zci+0KNUucH6RPi8W2aAHE/MpQsn0wQ5dRXT7s=;
        b=rSUPG5u7qTzoDvOhsSTVNE55cewbijz9ATEwfwYeoOjAIQRIxSbw2gxEv2pqyb6uBS
         6cHMfYeHezXHFOleOrvR0eV/0MQmDpR8s1gnirvSijHA9Vf3PbzuysB+Ai995kVfEyfP
         hqly/li1inaU5LPj3wr8ytaQsMo8xoPDM/3mUGu459+9MhE8TqPcgTeilokY7y0ZTRtO
         9mp15VAk8BeyCO7rM9LYpyphVPQ6K0NmEWqclqdLjOeJfPPDDuPw2GERv2ncoDFwi/7K
         EwE67WWIAlCW7UNyWe2YNYb9U+i4dfMRWZf8GQZqA4wTfmw/BO0NIjAOOgXtADPyyQ3e
         BWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3cj4zci+0KNUucH6RPi8W2aAHE/MpQsn0wQ5dRXT7s=;
        b=Dm5GaNrGprUntffy9RO8wt04fsaDRr39pQY1C39VQ7Yf38iPESGoRJeEENUybhMyFS
         8NJaKsNwoL3o8oeZcQzH8JJ8qPSnYGCARKbAdrRjMlzlMTZmuY3f7+Lp+nzxk4M+EFez
         /DNALAIo/jdk8K6IxPF6YOsCC+PHnmWmXvqdD2Izn8SGoEzOYtwMM6LYjCQv8Wsblcbq
         gPkZZZwjn3Dh43C1V6IShMRLDRkEmZpAwLBdNUweUl+GnPTjxiNbNeKZHfwWRzovf/P9
         C+yUMVDnhdD/ExLKeEbAxqkofCfiYi/ACbcXUr0S74FLbQVvJVPgrLSoEFRWxHqcngV6
         sA2A==
X-Gm-Message-State: AA+aEWa86UxfcYHB2FQiu4K3rMDj6uEYg0l23CayQR2/g7RO2Shhap4A
        EuH/vvZSIZO0vOO1xpciTsE=
X-Google-Smtp-Source: AFSGD/W6ZRh0tPBhWIOe8Fn/5djHr4GQa14i5/CW09kDn41ecrxrSOz7AoIGGHZc0G6psBPR7YHv0Q==
X-Received: by 2002:a1c:47:: with SMTP id 68mr5212360wma.89.1543184423276;
        Sun, 25 Nov 2018 14:20:23 -0800 (PST)
Received: from localhost ([31.127.45.106])
        by smtp.gmail.com with ESMTPSA id 125sm19978081wml.35.2018.11.25.14.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 14:20:22 -0800 (PST)
Date:   Sun, 25 Nov 2018 22:20:21 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
Message-ID: <20181125222021.GL4883@hank.intra.tgummerer.com>
References: <20181110133525.17538-1-pclouds@gmail.com>
 <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
 <8736rx1ah9.fsf@evledraar.gmail.com>
 <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
 <20181120174554.GA29910@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120174554.GA29910@duynguyen.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Duy Nguyen wrote:
> On Mon, Nov 19, 2018 at 04:19:53PM +0100, Duy Nguyen wrote:
> > I promise to come back with something better (at least it still
> > sounds better in my mind). If that idea does not work out, we can
> > come back and see if we can improve this.
> 
> So this is it. The patch isn't pretty, mostly as a proof of
> concept. Just look at the three functions at the bottom of checkout.c,
> which is the main thing.
> 
> This patch tries to split "git checkout" command in two new ones:
> 
> - git switch-branch is all about switching branches
> - git restore-paths (maybe restore-file is better) for checking out
>   paths
> 
> The main idea is these two commands will co-exist with the good old
> 'git checkout', which will NOT be deprecated. Old timers will still
> use "git checkout". But new people should be introduced to the new two
> instead. And the new ones are just as capable as "git checkout".
> 
> Since the three commands will co-exist (with duplicate functionality),
> maintenance cost must be kept to minimum. The way I did this is simply
> split the command line options into three pieces: common,
> switch-branch and checkout-paths. "git checkout" has all three, the
> other two have common and another piece.
>
> With this, a new option added to git checkout will be automatically
> available in either switch-branch or checkout-paths. Bug fixes apply
> to all relevant commands.
> 
> Later on, we could start to add a bit more stuff in, e.g. some form of
> disambiguation is no longer needed when running as switch-branch, or
> restore-paths.
> 
> So, what do you think?

I like the idea of splitting those commands up, in fact it is
something I've been considering working on myself.  I do think we
should consider if we want to change the behaviour of those new
commands in any way compared to 'git checkout', since we're starting
with a clean slate.

One thing in particular that I have in mind is something I'm currently
working on, namely adding a --index flag to 'git checkout', which
would make 'git checkout' work in non-overlay mode (for more
discussion on that see also [*1*].  I got something working, that
needs to be polished a bit and am hoping to send that to the list
sometime soon.

I wonder if such the --index behaviour could be the default in
restore-paths command?

Most of the underlying machinery for 'checkout' could and should of
course still be shared between the commands.

*1*: <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>

> -- 8< --
> diff --git a/builtin.h b/builtin.h
> index 6538932e99..6e321ec8a4 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
>  extern int cmd_repack(int argc, const char **argv, const char *prefix);
>  extern int cmd_rerere(int argc, const char **argv, const char *prefix);
>  extern int cmd_reset(int argc, const char **argv, const char *prefix);
> +extern int cmd_restore_paths(int argc, const char **argv, const char *prefix);
>  extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
>  extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
>  extern int cmd_revert(int argc, const char **argv, const char *prefix);
> @@ -227,6 +228,7 @@ extern int cmd_show_index(int argc, const char **argv, const char *prefix);
>  extern int cmd_status(int argc, const char **argv, const char *prefix);
>  extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
>  extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
> +extern int cmd_switch_branch(int argc, const char **argv, const char *prefix);
>  extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_tag(int argc, const char **argv, const char *prefix);
>  extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index acdafc6e4c..868ca3c223 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -33,6 +33,16 @@ static const char * const checkout_usage[] = {
>  	NULL,
>  };
>  
> +static const char * const switch_branch_usage[] = {
> +	N_("git switch-branch [<options>] <branch>"),
> +	NULL,
> +};
> +
> +static const char * const restore_paths_usage[] = {
> +	N_("git restore-paths [<options>] [<branch>] -- <file>..."),
> +	NULL,
> +};
> +
>  struct checkout_opts {
>  	int patch_mode;
>  	int quiet;
> @@ -44,6 +54,7 @@ struct checkout_opts {
>  	int ignore_skipworktree;
>  	int ignore_other_worktrees;
>  	int show_progress;
> +	int dwim_new_local_branch;
>  	/*
>  	 * If new checkout options are added, skip_merge_working_tree
>  	 * should be updated accordingly.
> @@ -55,6 +66,7 @@ struct checkout_opts {
>  	int new_branch_log;
>  	enum branch_track track;
>  	struct diff_options diff_options;
> +	char *conflict_style;
>  
>  	int branch_exists;
>  	const char *prefix;
> @@ -1223,78 +1235,105 @@ static int checkout_branch(struct checkout_opts *opts,
>  	return switch_branches(opts, new_branch_info);
>  }
>  
> -int cmd_checkout(int argc, const char **argv, const char *prefix)
> +static struct option *add_common_options(struct checkout_opts *opts,
> +					 struct option *prevopts)
>  {
> -	struct checkout_opts opts;
> -	struct branch_info new_branch_info;
> -	char *conflict_style = NULL;
> -	int dwim_new_local_branch = 1;
> -	int dwim_remotes_matched = 0;
>  	struct option options[] = {
> -		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
> -		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
> +		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
> +		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
> +			 N_("do not limit pathspecs to sparse entries only")),
> +		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
> +			    "checkout", "control recursive updating of submodules",
> +			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
> +		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
> +		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
> +			   PARSE_OPT_NOCOMPLETE),
> +		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
> +			   N_("conflict style (merge or diff3)")),
> +		OPT_END()
> +	};
> +	struct option *newopts = parse_options_concat(prevopts, options);
> +	free(prevopts);
> +	return newopts;
> +}
> +
> +static struct option *add_switch_branch_options(struct checkout_opts *opts,
> +						struct option *prevopts)
> +{
> +	struct option options[] = {
> +		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
>  			   N_("create and checkout a new branch")),
> -		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
> +		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
>  			   N_("create/reset and checkout a branch")),
> -		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
> -		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach HEAD at named commit")),
> -		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
> +		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
> +		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
> +		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
>  			BRANCH_TRACK_EXPLICIT),
> -		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
> -		OPT_SET_INT_F('2', "ours", &opts.writeout_stage,
> +		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
> +		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
> +		OPT_HIDDEN_BOOL(0, "guess", &opts->dwim_new_local_branch,
> +				N_("second guess 'git checkout <no-such-branch>'")),
> +		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
> +			 N_("do not check if another worktree is holding the given ref")),
> +		OPT_END()
> +	};
> +	struct option *newopts = parse_options_concat(prevopts, options);
> +	free(prevopts);
> +	return newopts;
> +}
> +
> +static struct option *add_checkout_path_options(struct checkout_opts *opts,
> +						struct option *prevopts)
> +{
> +	struct option options[] = {
> +		OPT_SET_INT_F('2', "ours", &opts->writeout_stage,
>  			      N_("checkout our version for unmerged files"),
>  			      2, PARSE_OPT_NONEG),
> -		OPT_SET_INT_F('3', "theirs", &opts.writeout_stage,
> +		OPT_SET_INT_F('3', "theirs", &opts->writeout_stage,
>  			      N_("checkout their version for unmerged files"),
>  			      3, PARSE_OPT_NONEG),
> -		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
> -			   PARSE_OPT_NOCOMPLETE),
> -		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
> -		OPT_BOOL_F(0, "overwrite-ignore", &opts.overwrite_ignore,
> -			   N_("update ignored files (default)"),
> -			   PARSE_OPT_NOCOMPLETE),
> -		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
> -			   N_("conflict style (merge or diff3)")),
> -		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
> -		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
> -			 N_("do not limit pathspecs to sparse entries only")),
> -		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
> -				N_("second guess 'git checkout <no-such-branch>'")),
> -		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
> -			 N_("do not check if another worktree is holding the given ref")),
> -		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
> -			    "checkout", "control recursive updating of submodules",
> -			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
> -		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
> -		OPT_END(),
> +		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
> +		OPT_END()
>  	};
> +	struct option *newopts = parse_options_concat(prevopts, options);
> +	free(prevopts);
> +	return newopts;
> +}
>  
> -	memset(&opts, 0, sizeof(opts));
> +static int checkout_main(int argc, const char **argv, const char *prefix,
> +			 struct checkout_opts *opts, struct option *options,
> +			 const char * const usagestr[])
> +{
> +	struct branch_info new_branch_info;
> +	int dwim_remotes_matched = 0;
> +
> +	memset(opts, 0, sizeof(*opts));
> +	opts->dwim_new_local_branch = 1;
>  	memset(&new_branch_info, 0, sizeof(new_branch_info));
> -	opts.overwrite_ignore = 1;
> -	opts.prefix = prefix;
> -	opts.show_progress = -1;
> +	opts->overwrite_ignore = 1;
> +	opts->prefix = prefix;
> +	opts->show_progress = -1;
>  
> -	git_config(git_checkout_config, &opts);
> +	git_config(git_checkout_config, opts);
>  
> -	opts.track = BRANCH_TRACK_UNSPECIFIED;
> +	opts->track = BRANCH_TRACK_UNSPECIFIED;
>  
> -	argc = parse_options(argc, argv, prefix, options, checkout_usage,
> +	argc = parse_options(argc, argv, prefix, options, usagestr,
>  			     PARSE_OPT_KEEP_DASHDASH);
>  
> -	if (opts.show_progress < 0) {
> -		if (opts.quiet)
> -			opts.show_progress = 0;
> +	if (opts->show_progress < 0) {
> +		if (opts->quiet)
> +			opts->show_progress = 0;
>  		else
> -			opts.show_progress = isatty(2);
> +			opts->show_progress = isatty(2);
>  	}
>  
> -	if (conflict_style) {
> -		opts.merge = 1; /* implied */
> -		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> +	if (opts->conflict_style) {
> +		opts->merge = 1; /* implied */
> +		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
>  	}
>  
> -	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
> +	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
>  		die(_("-b, -B and --orphan are mutually exclusive"));
>  
>  	/*
> @@ -1302,14 +1341,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	 * and new_branch_force and new_orphan_branch will tell us which one of
>  	 * -b/-B/--orphan is being used.
>  	 */
> -	if (opts.new_branch_force)
> -		opts.new_branch = opts.new_branch_force;
> +	if (opts->new_branch_force)
> +		opts->new_branch = opts->new_branch_force;
>  
> -	if (opts.new_orphan_branch)
> -		opts.new_branch = opts.new_orphan_branch;
> +	if (opts->new_orphan_branch)
> +		opts->new_branch = opts->new_orphan_branch;
>  
>  	/* --track without -b/-B/--orphan should DWIM */
> -	if (opts.track != BRANCH_TRACK_UNSPECIFIED && !opts.new_branch) {
> +	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
>  		const char *argv0 = argv[0];
>  		if (!argc || !strcmp(argv0, "--"))
>  			die(_("--track needs a branch name"));
> @@ -1318,7 +1357,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		argv0 = strchr(argv0, '/');
>  		if (!argv0 || !argv0[1])
>  			die(_("missing branch name; try -b"));
> -		opts.new_branch = argv0 + 1;
> +		opts->new_branch = argv0 + 1;
>  	}
>  
>  	/*
> @@ -1337,56 +1376,56 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	if (argc) {
>  		struct object_id rev;
>  		int dwim_ok =
> -			!opts.patch_mode &&
> -			dwim_new_local_branch &&
> -			opts.track == BRANCH_TRACK_UNSPECIFIED &&
> -			!opts.new_branch;
> +			!opts->patch_mode &&
> +			opts->dwim_new_local_branch &&
> +			opts->track == BRANCH_TRACK_UNSPECIFIED &&
> +			!opts->new_branch;
>  		int n = parse_branchname_arg(argc, argv, dwim_ok,
> -					     &new_branch_info, &opts, &rev,
> +					     &new_branch_info, opts, &rev,
>  					     &dwim_remotes_matched);
>  		argv += n;
>  		argc -= n;
>  	}
>  
>  	if (argc) {
> -		parse_pathspec(&opts.pathspec, 0,
> -			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
> +		parse_pathspec(&opts->pathspec, 0,
> +			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
>  			       prefix, argv);
>  
> -		if (!opts.pathspec.nr)
> +		if (!opts->pathspec.nr)
>  			die(_("invalid path specification"));
>  
>  		/*
>  		 * Try to give more helpful suggestion.
>  		 * new_branch && argc > 1 will be caught later.
>  		 */
> -		if (opts.new_branch && argc == 1)
> +		if (opts->new_branch && argc == 1)
>  			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
> -				argv[0], opts.new_branch);
> +				argv[0], opts->new_branch);
>  
> -		if (opts.force_detach)
> +		if (opts->force_detach)
>  			die(_("git checkout: --detach does not take a path argument '%s'"),
>  			    argv[0]);
>  
> -		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
> +		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
>  			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
>  			      "checking out of the index."));
>  	}
>  
> -	if (opts.new_branch) {
> +	if (opts->new_branch) {
>  		struct strbuf buf = STRBUF_INIT;
>  
> -		if (opts.new_branch_force)
> -			opts.branch_exists = validate_branchname(opts.new_branch, &buf);
> +		if (opts->new_branch_force)
> +			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
>  		else
> -			opts.branch_exists =
> -				validate_new_branchname(opts.new_branch, &buf, 0);
> +			opts->branch_exists =
> +				validate_new_branchname(opts->new_branch, &buf, 0);
>  		strbuf_release(&buf);
>  	}
>  
>  	UNLEAK(opts);
> -	if (opts.patch_mode || opts.pathspec.nr) {
> -		int ret = checkout_paths(&opts, new_branch_info.name);
> +	if (opts->patch_mode || opts->pathspec.nr) {
> +		int ret = checkout_paths(opts, new_branch_info.name);
>  		if (ret && dwim_remotes_matched > 1 &&
>  		    advice_checkout_ambiguous_remote_branch_name)
>  			advise(_("'%s' matched more than one remote tracking branch.\n"
> @@ -1405,6 +1444,49 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  			       dwim_remotes_matched);
>  		return ret;
>  	} else {
> -		return checkout_branch(&opts, &new_branch_info);
> +		return checkout_branch(opts, &new_branch_info);
>  	}
>  }
> +
> +int cmd_checkout(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options = NULL;
> +	int ret;
> +
> +	options = add_common_options(&opts, options);
> +	options = add_switch_branch_options(&opts, options);
> +	options = add_checkout_path_options(&opts, options);
> +	ret = checkout_main(argc, argv, prefix, &opts,
> +			    options, checkout_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> +
> +int cmd_switch_branch(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options = NULL;
> +	int ret;
> +
> +	options = add_common_options(&opts, options);
> +	options = add_switch_branch_options(&opts, options);
> +	ret = checkout_main(argc, argv, prefix, &opts,
> +			    options, switch_branch_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> +
> +int cmd_restore_paths(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout_opts opts;
> +	struct option *options = NULL;
> +	int ret;
> +
> +	options = add_common_options(&opts, options);
> +	options = add_checkout_path_options(&opts, options);
> +	ret = checkout_main(argc, argv, prefix, &opts,
> +			    options, restore_paths_usage);
> +	FREE_AND_NULL(options);
> +	return ret;
> +}
> diff --git a/git.c b/git.c
> index 2f604a41ea..e8a76a99da 100644
> --- a/git.c
> +++ b/git.c
> @@ -542,6 +542,7 @@ static struct cmd_struct commands[] = {
>  	{ "replace", cmd_replace, RUN_SETUP },
>  	{ "rerere", cmd_rerere, RUN_SETUP },
>  	{ "reset", cmd_reset, RUN_SETUP },
> +	{ "restore-paths", cmd_restore_paths, RUN_SETUP | NEED_WORK_TREE },
>  	{ "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
>  	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
>  	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
> @@ -557,6 +558,7 @@ static struct cmd_struct commands[] = {
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
> +	{ "switch-branch", cmd_switch_branch, RUN_SETUP | NEED_WORK_TREE },
>  	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
>  	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
>  	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 8c9edce52f..c609d52926 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -126,7 +126,7 @@ struct option *parse_options_concat(struct option *a, struct option *b)
>  	struct option *ret;
>  	size_t i, a_len = 0, b_len = 0;
>  
> -	for (i = 0; a[i].type != OPTION_END; i++)
> +	for (i = 0; a && a[i].type != OPTION_END; i++)
>  		a_len++;
>  	for (i = 0; b[i].type != OPTION_END; i++)
>  		b_len++;
> -- 8< --
