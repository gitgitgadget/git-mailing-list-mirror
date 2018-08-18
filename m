Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E491A1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeHRSoO (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 14:44:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52676 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSoN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 14:44:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so10142565wmh.2
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CKT9PK97kLe6pjtMlT1X5VjwuEwolFvQkqssdSAAiqU=;
        b=Wh+NUSEjbqbdAI/13IddRe+5wRzgSHCWOfLwIkA7WFJyayNsqLWK2ARWz7D09r6N+/
         IIhYbNY8TVdXtGPpgCHf/YF/vE7kTqHCOmwyiSX0aSfhd9ydRQ8R/hnfWtilZbR07DSV
         4Q+tAigI2F6gRnX0irRJXT0h+zTx6NGYDySXUVavIh2gehmegbvuqi37BbBF77+t3FDw
         LVdb5MSlkuXMjoc/Y8TTaVboqFqkDWpfnaNkeRWRxeoipm2GzLo80vUiLOjjBUub/pwO
         t9ECemdX8N+JiSRf9Z4/XCqTAZm2+Z4IwByMr6MqT3NaoRUKxgjhhcwCeAXuf/vQoOEh
         aM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CKT9PK97kLe6pjtMlT1X5VjwuEwolFvQkqssdSAAiqU=;
        b=KMKPHlVTwbBOOQsF0OrmIWvfvlsgFpNzRg2eZTaU8SIWzt7BZ+qobg+eRQEOptD0Nd
         59pFwNrsToYKD4Oq/Q4WyfnI8zGuhZUzg3DA8A7izYcGfEp/AY1vVAmvPHFKraDlf4qE
         DHA8cJk8amUqjHx80fDvzKqNgObT6wanEOzzct3P3P6oLiKVXm2O0m3jaAIRYntHaYLn
         GT6C9qun8gonTlSlS8Q0nyhPBoVC9ggV9sV9nKWaLh4sE+ne20Vm5aqCkAMdR8l1aHbc
         4RgS8+8Ko3iF0TYBnemynZX6ug4YXimp1fq2tSbwHlG0F//Xmtos20Gwg5LxKGzxvTvF
         dPeQ==
X-Gm-Message-State: AOUpUlGS3WhnqM//V53XOqdQS2x0EXzJMpKpMz6FR873BQaEw1ejEVvc
        A+L8+BKLD+OurRJVZQ08YHg=
X-Google-Smtp-Source: AA+uWPxp4aMkl5ZPrlNUrFxx2/CwE1T7sCXmxunR13rMSj1YGDb0pNIWWvP0m+wLjE0ODg9JPMxB9w==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr21841256wmb.29.1534606566264;
        Sat, 18 Aug 2018 08:36:06 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id j133-v6sm12488124wmd.12.2018.08.18.08.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 08:36:05 -0700 (PDT)
Date:   Sat, 18 Aug 2018 16:36:04 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 18/26] stash: convert push to builtin
Message-ID: <20180818153604.GB11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <b41bff3b5188ac014f9cb5024e535d6804ef1834.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41bff3b5188ac014f9cb5024e535d6804ef1834.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add stash push to the helper.
> ---

This (and the previous two and I think most subsequent patches) are
missing your sign-off.

>  builtin/stash--helper.c | 209 ++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            |   6 +-
>  2 files changed, 213 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index f905d3908..c26cad3d5 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -23,6 +23,9 @@ static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper clear"),
>  	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
>  	N_("git stash--helper create [<message>]"),
> +	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
> +	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
> +	   "          [--] [<pathspec>...]]"),
>  	NULL
>  };
>  
> @@ -71,6 +74,13 @@ static const char * const git_stash_helper_create_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_push_usage[] = {
> +	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
> +	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
> +	   "          [--] [<pathspec>...]]"),
> +	NULL
> +};
> +
>  static const char *ref_stash = "refs/stash";
>  static int quiet;
>  static struct strbuf stash_index_path = STRBUF_INIT;
> @@ -1210,6 +1220,203 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  	return ret < 0;
>  }
>  
> +static int do_push_stash(int argc, const char **argv, const char *prefix,
> +			 int keep_index, int patch_mode, int include_untracked,
> +			 int quiet, const char *stash_msg)
> +{
> +	int ret = 0;
> +	struct pathspec ps;
> +	struct stash_info info;
> +	if (patch_mode && keep_index == -1)
> +		keep_index = 1;
> +
> +	if (patch_mode && include_untracked) {
> +		fprintf_ln(stderr, "Can't use --patch and --include-untracked or --all at the same time");

This should be marked for translation.  Similar for the messages
below.  I noticed this in a previous patch as well, so it may be worth
reviewing all the output, and checking that it's going to the right
stream and is marked for translation.

> +		return -1;
> +	}
> +
> +	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	if (!include_untracked && ps.nr) {
> +		int i;
> +		char *ps_matched = xcalloc(ps.nr, 1);
> +
> +		for (i = 0; i < active_nr; ++i) {
> +			const struct cache_entry *ce = active_cache[i];
> +			if (!ce_path_match(ce, &ps, ps_matched))
> +				continue;
> +		}
> +
> +		if (report_path_error(ps_matched, &ps, prefix)) {
> +			fprintf_ln(stderr, "Did you forget to 'git add'?");
> +			return -1;
> +		}
> +	}
> +
> +	read_cache_preload(NULL);

Instead of doing a 'read_cache' before and 'read_cache_preload(NULL)'
here, we could just use 'read_cache_preload(NULL)' above.
'read_cache' does return early if the index has already been read, so
there's no big harm in doing this twice, but just having one call is
still neater I think.

It would make the command slightly slower in the error case above, but
I doubt that's worth worrying about.

> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	if (!check_changes(argv, include_untracked, prefix)) {
> +		fprintf_ln(stdout, "No local changes to save");
> +		return 0;
> +	}
> +
> +	if (!reflog_exists(ref_stash) && do_clear_stash()) {
> +		fprintf_ln(stderr, "Cannot initialize stash");
> +		return -1;
> +	}
> +
> +	if ((ret = do_create_stash(argc, argv, prefix, &stash_msg,
> +				   include_untracked, patch_mode, &info)))
> +		return ret;

Should this be 'return ret < 0'?  'ret == 1' means there are no
changes, for which we currently get a 0 exit code.  Though on second
thought that can't happen, because we already have 'check_changes'
above.  Why do we want the 'ret' variable here?

Something I notice here is that we are passing 'argc' and 'argv'
around a lot.  We passed that through parse-options already, and it
seems to me that we're mostly left with pathspecs here, rather than
'argv'.  It looks to me like we could just parse the pathspecs in the
callers (which we do in some places, but maybe not in all of them) and
then pass 'struct pathspec' around instead of the leftover argv, which
is easier to understand, and gives all these functions a neater/easier
to understand interface.

Also looking at 'do_create_stash', the 'argc' argument seems to be
unused?  I failed to notice that earlier obviously, but we should get
rid of that unused argument.

> +
> +	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
> +		fprintf(stderr, "Cannot save the current status");
> +		return -1;
> +	}
> +
> +	fprintf(stdout, "Saved working directory and index state %s", stash_msg);
> +
> +	if (!patch_mode) {
> +		if (include_untracked && ps.nr == 0) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "clean", "--force",
> +					 "--quiet", "-d", NULL);
> +			if (include_untracked == 2)
> +				argv_array_push(&cp.args, "-x");
> +			if (run_command(&cp))
> +				return -1;
> +		}
> +		if (argc != 0) {

We use 'ps.nr' in the check above, and 'argc' here.  I think we should
consistently use 'ps.nr'.

> +			int i;
> +			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			struct child_process cp2 = CHILD_PROCESS_INIT;
> +			struct child_process cp3 = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			cp1.git_cmd = 1;
> +			argv_array_push(&cp1.args, "add");
> +			if (!include_untracked)
> +				argv_array_push(&cp1.args, "-u");
> +			if (include_untracked == 2)
> +				argv_array_push(&cp1.args, "--force");
> +			argv_array_push(&cp1.args, "--");
> +			for (i = 0; i < ps.nr; ++i)
> +				argv_array_push(&cp1.args, ps.items[i].match);

Since we're doing this 'argv_array_push' with pathspec elements a few
times already (and may do it even more often if the code is being
refactored to pass 'struct pathspec' around), would it be worth
factoring this out as a tiny helper function?

> +			if (run_command(&cp1))
> +				return -1;
> +
> +			cp2.git_cmd = 1;
> +			argv_array_pushl(&cp2.args, "diff-index", "-p",
> +					 "--cached", "--binary", "HEAD", "--",
> +					 NULL);
> +			for (i = 0; i < ps.nr; ++i)
> +				argv_array_push(&cp2.args, ps.items[i].match);
> +			if (pipe_command(&cp2, NULL, 0, &out, 0, NULL, 0))
> +				return -1;
> +
> +			cp3.git_cmd = 1;
> +			argv_array_pushl(&cp3.args, "apply", "--index", "-R",
> +					 NULL);
> +			if (pipe_command(&cp3, out.buf, out.len, NULL, 0, NULL,
> +					 0))
> +				return -1;
> +		} else {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
> +					 NULL);
> +			if (run_command(&cp))
> +				return -1;
> +		}
> +
> +		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
> +			int i;
> +			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			struct child_process cp2 = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			if (reset_tree(&info.i_tree, 0, 1))
> +				return -1;
> +
> +			cp1.git_cmd = 1;
> +			argv_array_pushl(&cp1.args, "ls-files", "-z",
> +					 "--modified", "--", NULL);
> +			for (i = 0; i < ps.nr; ++i)
> +				argv_array_push(&cp1.args, ps.items[i].match);
> +			if (pipe_command(&cp1, NULL, 0, &out, 0, NULL, 0))
> +				return -1;
> +
> +			cp2.git_cmd = 1;
> +			argv_array_pushl(&cp2.args, "checkout-index", "-z",
> +					 "--force", "--stdin", NULL);
> +			if (pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL,
> +					 0))
> +				return -1;
> +		}
> +	} else {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		cp.git_cmd = 1;
> +		argv_array_pushl(&cp.args, "apply", "-R", NULL);
> +
> +		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
> +			fprintf_ln(stderr, "Cannot remove worktree changes");
> +			return -1;
> +		}
> +
> +		if (keep_index < 1) {
> +			int i;
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
> +			for (i = 0; i < ps.nr; ++i)
> +				argv_array_push(&cp.args, ps.items[i].match);
> +			if (run_command(&cp))
> +				return -1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int push_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int keep_index = -1;
> +	int patch_mode = 0;
> +	int include_untracked = 0;
> +	int quiet = 0;
> +	const char *stash_msg = NULL;
> +	struct option options[] = {
> +		OPT_SET_INT('k', "keep-index", &keep_index,
> +			N_("keep index"), 1),
> +		OPT_BOOL('p', "patch", &patch_mode,
> +			N_("stash in patch mode")),
> +		OPT_BOOL('q', "quiet", &quiet,
> +			N_("quiet mode")),

We should be able to use OPT__QUIET here.

> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_SET_INT('a', "all", &include_untracked,
> +			    N_("include ignore files"), 2),
> +		OPT_STRING('m', "message", &stash_msg, N_("message"),
> +			 N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_push_usage,
> +			     0);
> +
> +	return do_push_stash(argc, argv, prefix, keep_index, patch_mode,
> +			     include_untracked, quiet, stash_msg);
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -1248,6 +1455,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!store_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "create"))
>  		return !!create_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "push"))
> +		return !!push_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index ab06e4ffb..c3146f62a 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -412,7 +412,8 @@ save)
>  	;;
>  push)
>  	shift
> -	push_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper push "$@"
>  	;;
>  apply)
>  	shift
> @@ -448,7 +449,8 @@ branch)
>  *)
>  	case $# in
>  	0)
> -		push_stash &&
> +		cd "$START_DIR"
> +		git stash--helper push &&
>  		say "$(gettext "(To restore them type \"git stash apply\")")"
>  		;;
>  	*)
> -- 
> 2.18.0.573.g56500d98f
> 
