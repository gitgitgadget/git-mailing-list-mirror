Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DED1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBHLbG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:31:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36133 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHLbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:31:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so3019577wmc.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 03:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jX2XnNzOqfysj6U7nRptReo30fKYk58wyjVpba2Mx98=;
        b=XAxzbwFE7K/qC3Yv7S/VDaztOH81X9nCtHZ0RgTp9Z8imEaePc7WQahFjymSU5Fygf
         rm+tYwKVKtE9j0fA4t1jqTGyyJk5vC8WaNDXIYAR8C5xAWwPTA7wngXGJ0DjTt5x4rAI
         HhoQoLUd2fg1QAfUSt9C3AaNc21/H7bOMyQEFCJjhgdOFvB/AvqdWYbU1M8mbxrFk1dz
         ak/xI7tpuxdY0T86lIbiMs0b3tuya/YFaRig7GZ7C4+XkjovgNAG07WeOaPrXCud2Oy6
         a+Ic0uPMWC9cpJxY6wQ/T+ir7krO6rJTTL9QOJAb6diZMO6tyKfOwZMCe0IuXjxCuZsi
         WR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jX2XnNzOqfysj6U7nRptReo30fKYk58wyjVpba2Mx98=;
        b=A8W5d2yKiB38fNDoDT3BL8zmN+Y7DE1wUywR7YMGnuGq48EPvaImCD564Iins5r/LZ
         CS/4HkPC1yMM/XEEgthH2QQK0erV79+Y9Y3bUiYMAia4SUE6zmX/Q6QWZW9fRF8BGkA+
         AYBtN/4DASHNNZyR8Cdgt3h5aookv00wsyYxLuVcBKpoVI1A5tY4lAB2Zp6ABRFm5mLD
         FP6gmcOUlfhKIFrS/h/jY3DMjXToTkTYj60KM1yfEIrIupvxP8f/m86qc/jrew7fD3o7
         znuBeDZWlv59iZKEDVueaSPY0e7dXBY5RZDQClXhbrwGE2fFc0cyNNB+KyYaMIL4qtRQ
         p/9Q==
X-Gm-Message-State: AHQUAuYwpPkC8/v0UEpwo9Jds0TCvQoaJ5LmiuFO+myBg1u02WvEdQoU
        VNgyagconLCna6EOuD4u9gM=
X-Google-Smtp-Source: AHgI3IacyKf/k4aWPQuXaA/YkAjW92i1aEQzdb2JY0E8yAQZEsr+D8Q9tnlIYYrAluQn4P+DVyvwnw==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr11330014wme.104.1549625462378;
        Fri, 08 Feb 2019 03:31:02 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id d16sm1149475wru.52.2019.02.08.03.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 03:31:01 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:30:59 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190208113059.GV10587@szeder.dev>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 09:44:34PM +0200, Paul-Sebastian Ungureanu wrote:
> Add stash push to the helper.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

This patch causes rare failures in 't3903-stash.sh', I've seen it
break for the first time today in a Travis CI build:

  +echo bar3
  +echo bar4
  +git add file2
  +git stash -k
  Saved working directory and index state WIP on stashbranch: d3a23d9 alternate second
  +cat file
  +cat file2
  +test bar,bar4 = bar,bar2
  error: last command exited with $?=1
  not ok 20 - stash -k

Steps to reproduce:

  $ git checkout -f fa38428f76
  HEAD is now at fa38428f76 stash: convert push to builtin
  
  # fb7d1e3ac8 (test-lib: add the '--stress' option to run a test
  # repeatedly under load, 2019-01-05)
  $ git merge --no-commit fb7d1e3ac8
  Automatic merge went well; stopped before committing as requested
  $ make && cd t
  <snip>
  $ ./t3903-stash.sh --stress -r 1,13,14,20
  # wait, it tends to fail in <30 repetitions

I run stress testing on its parent for over 800 repetitions, no sign
of failure yet.

> ---
>  builtin/stash--helper.c | 245 +++++++++++++++++++++++++++++++++++++++-
>  git-stash.sh            |   6 +-
>  2 files changed, 245 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 080c2f7aa6..c77f62c895 100644
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
> @@ -1092,7 +1102,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  
>  static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  			   int include_untracked, int patch_mode,
> -			   struct stash_info *info)
> +			   struct stash_info *info, struct strbuf *patch)
>  {
>  	int ret = 0;
>  	int flags = 0;
> @@ -1105,7 +1115,6 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  	struct strbuf msg = STRBUF_INIT;
>  	struct strbuf commit_tree_label = STRBUF_INIT;
>  	struct strbuf untracked_files = STRBUF_INIT;
> -	struct strbuf patch = STRBUF_INIT;
>  
>  	prepare_fallback_ident("git stash", "git@stash");
>  
> @@ -1154,7 +1163,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  		untracked_commit_option = 1;
>  	}
>  	if (patch_mode) {
> -		ret = stash_patch(info, ps, &patch);
> +		ret = stash_patch(info, ps, patch);
>  		if (ret < 0) {
>  			fprintf_ln(stderr, _("Cannot save the current "
>  					     "worktree state"));
> @@ -1225,7 +1234,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  
>  	memset(&ps, 0, sizeof(ps));
>  	strbuf_addstr(&stash_msg_buf, stash_msg);
> -	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info);
> +	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
> +			      NULL);
>  
>  	if (!ret)
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
> @@ -1239,6 +1249,231 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  	return ret < 0;
>  }
>  
> +static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
> +			 int keep_index, int patch_mode, int include_untracked)
> +{
> +	int ret = 0;
> +	struct stash_info info;
> +	struct strbuf patch = STRBUF_INIT;
> +	struct strbuf stash_msg_buf = STRBUF_INIT;
> +
> +	if (patch_mode && keep_index == -1)
> +		keep_index = 1;
> +
> +	if (patch_mode && include_untracked) {
> +		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
> +				     " or --all at the same time"));
> +		ret = -1;
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
> +			ret = -1;
> +			free(ps_matched);
> +			goto done;
> +		}
> +		free(ps_matched);
> +	}
> +
> +	if (refresh_cache(REFRESH_QUIET)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (!check_changes(ps, include_untracked)) {
> +		if (!quiet)
> +			printf_ln(_("No local changes to save"));
> +		goto done;
> +	}
> +
> +	if (!reflog_exists(ref_stash) && do_clear_stash()) {
> +		ret = -1;
> +		fprintf_ln(stderr, _("Cannot initialize stash"));
> +		goto done;
> +	}
> +
> +	if (stash_msg)
> +		strbuf_addstr(&stash_msg_buf, stash_msg);
> +	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
> +			    &info, &patch)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
> +		ret = -1;
> +		fprintf_ln(stderr, _("Cannot save the current status"));
> +		goto done;
> +	}
> +
> +	printf_ln(_("Saved working directory and index state %s"),
> +		  stash_msg_buf.buf);
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
> +	strbuf_release(&stash_msg_buf);
> +	return ret;
> +}
> +
> +static int push_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int keep_index = -1;
> +	int patch_mode = 0;
> +	int include_untracked = 0;
> +	int quiet = 0;
> +	const char *stash_msg = NULL;
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
> @@ -1277,6 +1512,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!store_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "create"))
>  		return !!create_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "push"))
> +		return !!push_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index a9b3064ff0..51d7a06601 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -429,7 +429,8 @@ save)
>  	;;
>  push)
>  	shift
> -	push_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper push "$@"
>  	;;
>  apply)
>  	shift
> @@ -465,7 +466,8 @@ branch)
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
> 2.20.1.441.g764a526393
> 
