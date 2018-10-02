Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFAA1F454
	for <e@80x24.org>; Tue,  2 Oct 2018 20:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJCDWo (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:22:44 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35074 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeJCDWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:22:44 -0400
Received: by mail-wm1-f46.google.com with SMTP id o18-v6so3488753wmc.0
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9oUuq4iNCxw5FaTCU+Tf2aRPFvABG9pM6JHPJsG/Pk=;
        b=kEYisOjmX8CycM/CSd4GnEOiquu9X14kHoUbWnbhOgU4NwxlvZJ5VY+dH/R8C3o/PN
         /erUshTZPF5UiUyhUTBlfICw3K8LiunqcvrYCSYXcSii2g72N/HG5XTsr2ezcGNTm+Mo
         kt/nOpWoftAQPSLCilKBOIk+JshJPY6/1r83vy9pglZwpaGD7s6BTez8+ceq2e3Qr7fR
         O+xsyZJso7mMjmzms23zoqta1bBggkGPsScV7DLeFexT1o3x59Xs5mb3IIN622RNvV94
         naFy3okBVeybLEFnqcdx9M6uZszk1oNpz+loqopUAR11ndV8d7AUol9dJTZi2H4iGZI6
         sF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9oUuq4iNCxw5FaTCU+Tf2aRPFvABG9pM6JHPJsG/Pk=;
        b=uMUeX6NDrOswGx2sRXAnZCM6vc4oFQQmAeQWBiq/13eC6eaGPAePSbH17+pDYS4oWs
         Sj8odzFWPnn4rYxah9FiwC9tjgnYnu07RQ1HVAJ64SjYsVPn0BK6RrRd1xfpF1UURzSf
         nfTSXYzxP0HpPPdX2IkRVLFb41/c2/owXsAkRu22vFC1CkzF8oH+wCgLZbhmOIGGob3O
         rg16DpteNux5AjiEhpXY3LdSD2B8FL89c7Ggglf5aNQenUThd9q+TrXI1gKjFX7+4jHU
         xFSLU8/ke1FhMd9KqFVeYBIzkxREIPLDyN1x0w0XzivRYD1Y8EBC3FVqq+9T1TamscTc
         5Y0A==
X-Gm-Message-State: ABuFfohVE6fuSjNZlmNLQ3wtQvuWCUGm/8yhuksX6NzhSX6RXB5aJ9je
        DMH+NCybzZxbzrBlroyhuBzxla4F
X-Google-Smtp-Source: ACcGV60o88KXz19DMVa/4qnn6LvCJn4kXuab9333zXQ097v+DJYR48haoyr4jyFGuKSEWN8O5HdV8w==
X-Received: by 2002:a1c:8a94:: with SMTP id m142-v6mr2925137wmd.80.1538512652360;
        Tue, 02 Oct 2018 13:37:32 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id t24-v6sm6446816wra.5.2018.10.02.13.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 13:37:31 -0700 (PDT)
Date:   Tue, 2 Oct 2018 21:37:30 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 16/21] stash: convert push to builtin
Message-ID: <20181002203730.GI2253@hank.intra.tgummerer.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
 <6636ecc6b2a4da8dcde00d580455ea2911dbb218.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6636ecc6b2a4da8dcde00d580455ea2911dbb218.1537913094.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Paul-Sebastian Ungureanu wrote:
> Add stash push to the helper.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 244 +++++++++++++++++++++++++++++++++++++++-
>  git-stash.sh            |   6 +-
>  2 files changed, 244 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 49b05f2458..d79233d7ec 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -23,6 +23,9 @@ static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
>  	N_("git stash--helper clear"),
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
>  static struct strbuf stash_index_path = STRBUF_INIT;
>  
> @@ -1088,7 +1098,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  
>  static int do_create_stash(struct pathspec ps, char **stash_msg,
>  			   int include_untracked, int patch_mode,
> -			   struct stash_info *info)
> +			   struct stash_info *info, struct strbuf *patch)
>  {
>  	int ret = 0;
>  	int flags = 0;
> @@ -1102,7 +1112,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  	struct strbuf commit_tree_label = STRBUF_INIT;
>  	struct strbuf untracked_files = STRBUF_INIT;
>  	struct strbuf stash_msg_buf = STRBUF_INIT;
> -	struct strbuf patch = STRBUF_INIT;
>  
>  	read_cache_preload(NULL);
>  	refresh_cache(REFRESH_QUIET);
> @@ -1152,7 +1161,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
>  		untracked_commit_option = 1;
>  	}
>  	if (patch_mode) {
> -		ret = stash_patch(info, ps, &patch);
> +		ret = stash_patch(info, ps, patch);
>  		*stash_msg = NULL;
>  		if (ret < 0) {
>  			fprintf_ln(stderr, _("Cannot save the current worktree state"));
> @@ -1221,7 +1230,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  			     0);
>  
>  	memset(&ps, 0, sizeof(ps));
> -	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info);
> +	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
> +			      NULL);
>  
>  	if (!ret)
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
> @@ -1234,6 +1244,230 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  	return ret < 0;
>  }
>  
> +static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
> +			 int keep_index, int patch_mode, int include_untracked)
> +{
> +	int ret = 0;
> +	struct stash_info info;
> +	struct strbuf patch = STRBUF_INIT;
> +
> +	if (patch_mode && keep_index == -1)
> +		keep_index = 1;
> +
> +	if (patch_mode && include_untracked) {
> +		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
> +				     " or --all at the same time"));
> +		ret = -1;

We should set "stash_msg" to NULL here, otherwise we'll get an invalid
free if these options are used together and a message is given.

In general I find this API and the do_create_stash API a bit
cumbersome to use.  Maybe it would help if we'd 'xstrdup' the string
before passing it in, so we can free it unconditionally, without
setting it to NULL everywhere.  As it's only a single strdup for each
command that's run that isn't very costly compared to what else we're
doing here, and I think the readability we're gaining would be worth
it.

> +		goto done;
> +	}
> +
> +	read_cache_preload(NULL);
> +	if (!include_untracked && ps.nr) {
> +		int i;
> +		char *ps_matched = xcalloc(ps.nr, 1);
> +
> +		for (i = 0; i < active_nr; i++)
> +			ce_path_match(&the_index, active_cache[i], &ps,
> +				      ps_matched);
> +
> +		if (report_path_error(ps_matched, &ps, NULL)) {
> +			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
> +			stash_msg = NULL;
> +			ret = -1;

'ps_matched' is not being free'd in this error case.

> +			goto done;
> +		}
> +		free(ps_matched);
> +	}
> +
> +	if (refresh_cache(REFRESH_QUIET)) {
> +		stash_msg = NULL;
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (!check_changes(ps, include_untracked)) {
> +		stash_msg = NULL;
> +		if (!quiet)
> +			printf_ln(_("No local changes to save"));
> +		goto done;
> +	}
> +
> +	if (!reflog_exists(ref_stash) && do_clear_stash()) {
> +		stash_msg = NULL;
> +		ret = -1;
> +		fprintf_ln(stderr, _("Cannot initialize stash"));
> +		goto done;
> +	}
> +
> +	if (do_create_stash(ps, &stash_msg, include_untracked, patch_mode,
> +			    &info, &patch)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (do_store_stash(&info.w_commit, stash_msg, 1)) {
> +		ret = -1;
> +		fprintf_ln(stderr, _("Cannot save the current status"));
> +		goto done;
> +	}
> +
> +	printf_ln(_("Saved working directory and index state %s"), stash_msg);
> +
> +	if (!patch_mode) {
> +		if (include_untracked && !ps.nr) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "clean", "--force",
> +					 "--quiet", "-d", NULL);
> +			if (include_untracked == INCLUDE_ALL_FILES)
> +				argv_array_push(&cp.args, "-x");
> +			if (run_command(&cp)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +		if (ps.nr) {
> +			struct child_process cp_add = CHILD_PROCESS_INIT;
> +			struct child_process cp_diff = CHILD_PROCESS_INIT;
> +			struct child_process cp_apply = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			cp_add.git_cmd = 1;
> +			argv_array_push(&cp_add.args, "add");
> +			if (!include_untracked)
> +				argv_array_push(&cp_add.args, "-u");
> +			if (include_untracked == INCLUDE_ALL_FILES)
> +				argv_array_push(&cp_add.args, "--force");
> +			argv_array_push(&cp_add.args, "--");
> +			add_pathspecs(&cp_add.args, ps);
> +			if (run_command(&cp_add)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp_diff.git_cmd = 1;
> +			argv_array_pushl(&cp_diff.args, "diff-index", "-p",
> +					 "--cached", "--binary", "HEAD", "--",
> +					 NULL);
> +			add_pathspecs(&cp_diff.args, ps);
> +			if (pipe_command(&cp_diff, NULL, 0, &out, 0, NULL, 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp_apply.git_cmd = 1;
> +			argv_array_pushl(&cp_apply.args, "apply", "--index",
> +					 "-R", NULL);
> +			if (pipe_command(&cp_apply, out.buf, out.len, NULL, 0,
> +					 NULL, 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		} else {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
> +					 NULL);
> +			if (run_command(&cp)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +
> +		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
> +			struct child_process cp_ls = CHILD_PROCESS_INIT;
> +			struct child_process cp_checkout = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			if (reset_tree(&info.i_tree, 0, 1)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp_ls.git_cmd = 1;
> +			argv_array_pushl(&cp_ls.args, "ls-files", "-z",
> +					 "--modified", "--", NULL);
> +
> +			add_pathspecs(&cp_ls.args, ps);
> +			if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp_checkout.git_cmd = 1;
> +			argv_array_pushl(&cp_checkout.args, "checkout-index",
> +					 "-z", "--force", "--stdin", NULL);
> +			if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
> +					 0, NULL, 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +		goto done;
> +	} else {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		cp.git_cmd = 1;
> +		argv_array_pushl(&cp.args, "apply", "-R", NULL);
> +
> +		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
> +			fprintf_ln(stderr, _("Cannot remove worktree changes"));
> +			ret = -1;
> +			goto done;
> +		}
> +
> +		if (keep_index < 1) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
> +			add_pathspecs(&cp.args, ps);
> +			if (run_command(&cp)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +		goto done;
> +	}
> +
> +done:
> +	free(stash_msg);
> +	return ret;
> +}
> +
> +static int push_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int keep_index = -1;
> +	int patch_mode = 0;
> +	int include_untracked = 0;
> +	int quiet = 0;
> +	char *stash_msg = NULL;
> +	struct pathspec ps;
> +	struct option options[] = {
> +		OPT_BOOL('k', "keep-index", &keep_index,
> +			 N_("keep index")),
> +		OPT_BOOL('p', "patch", &patch_mode,
> +			 N_("stash in patch mode")),
> +		OPT__QUIET(&quiet, N_("quiet mode")),
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_SET_INT('a', "all", &include_untracked,
> +			    N_("include ignore files"), 2),
> +		OPT_STRING('m', "message", &stash_msg, N_("message"),
> +			   N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_push_usage,
> +			     0);
> +
> +	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
> +	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
> +			     include_untracked);
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -1272,6 +1506,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!store_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "create"))
>  		return !!create_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "push"))
> +		return !!push_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index ab06e4ffb8..c3146f62ab 100755
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
> 2.19.0.rc0.23.g1fb9f40d88
> 
