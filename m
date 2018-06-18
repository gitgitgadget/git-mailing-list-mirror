Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAB21F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbeFRPeb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:34:31 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:10760 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933182AbeFRPeb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:34:31 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UwAmfSgEHVlGZUwAmfS7Em; Mon, 18 Jun 2018 16:34:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529336069;
        bh=f0r5ro3xU+JMChJ9tbEUIIqNXYq36R6eOGD4erJPQfs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cinb3bB/c6rmBp8jzHUK/GRDPkJgBy0OgVnRG060gZiw4RSxdkjx89JoE93hMPp3W
         XvBkoR4KQfeJ07M5FcDj4XFgm2NCMl74HIj/n+fDGFOGMB6pky1YQGsApKM63m+rxo
         RrUWZ0FQBO+CEtp3MUZoPgy5sEy+G/FW/Xal+U6I=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=nKOLGV2pmlVTrH4s72oA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 2/3] rebase -i: rewrite setup_reflog_action() in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-3-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6583e68e-3aeb-3afa-8e13-9391b77e4fe7@talktalk.net>
Date:   Mon, 18 Jun 2018 16:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618131844.13408-3-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLDoApURFFKUK6hf5Dw02O77TSuBI+u9rQtyyl3wForf0z8RTBnIR8GXyHtuBVsRCwp5bNrQGz1JNdj9z6PGOqcZOscPSjUhiQ5osL8G5MSLy5xhvKvJ
 tV1Qn2gElxECEi0TPo1WhdKO6ZbJWKkBAqUZkOT/wPwAj1yKNhnGI3tBHokO7sPP1x4xCox/ajUQLC9hTy5cXjFZXmQc3sZtFB58cE0i8Z4HRZkgbWC5r7ip
 H50mV/f9cKkTspkjMWj64TYIfgfJnmkKHS+cLuL2TyM4i3t+Ww9kQa75ebGbAp9Todw6vR+/S7xaeaGH4EGnf4StcsGiSSUE7oTx9ZWnl6XVdQLs2LySGY2d
 BNzBsmI1usCK46z9KmGSg3xxHrHjmM24Okq9VIubv+mpMHWMnMKtH0m1mkCCyBnK/HR5O13z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/06/18 14:18, Alban Gruin wrote:
> This rewrites setup_reflog_action() from shell to C.
> 
> A new command is added to rebase--helper.c, “setup-reflog”, as such as a
> new flag, “verbose”, to silence the output of the checkout operation
> called by setup_reflog_action().

I'm having difficulty understanding what that means, surely the verbose 
flag is to stop the output from being silenced.

I'm not that keen on the naming in this patch, if it's only a staging 
post and will be removed it probably doesn't matter too much. I can see 
why you've based the function and flag names on the shell version, but 
the C version is not setting up the reflog it is checking out the branch 
we're rebasing. --checkout-base or something like that would be clearer.

Also the name of the function that does the checkout is tied to checking 
out the base revision, but then reused in the next patch to checkout the 
'onto' commit. As such I think it would be clearer if it was called 
run_git_checkout() or something like that.

One further thought - how easy would it be to refactor the code in 
do_reset() to handle the checkouts in this patch series, rather than 
having to fork 'git checkout'

Best wishes

Phillip

> The shell version is then stripped in favour of a call to the helper. As
> $GIT_REFLOG_ACTION is not longer set at the first call of
> checkout_onto(), a call to comment_for_reflog() is added at the
> beginning of this function.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--helper.c   |  9 +++++++--
>   git-rebase--interactive.sh | 16 ++--------------
>   sequencer.c                | 31 +++++++++++++++++++++++++++++++
>   sequencer.h                |  3 +++
>   4 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index d2990b210..d677fb663 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>   int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   {
>   	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
>   	int abbreviate_commands = 0, rebase_cousins = -1;
>   	enum {
>   		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>   		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> -		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
> +		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG
>   	} command = 0;
>   	struct option options[] = {
>   		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
>   		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>   			 N_("keep original branch points of cousins")),
> +		OPT_BOOL(0, "verbose", &verbose, N_("verbose")),
>   		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>   				CONTINUE),
>   		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
> @@ -50,6 +51,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   		OPT_CMDMODE(0, "edit-todo", &command,
>   			    N_("edit the todo list during an interactive rebase"),
>   			    EDIT_TODO),
> +		OPT_CMDMODE(0, "setup-reflog", &command,
> +			    N_("setup the reflog action"), SETUP_REFLOG),
>   		OPT_END()
>   	};
>   
> @@ -93,5 +96,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   		return !!append_todo_help(0, keep_empty);
>   	if (command == EDIT_TODO && argc == 1)
>   		return !!edit_todo_list(flags);
> +	if (command == SETUP_REFLOG && argc == 2)
> +		return !!setup_reflog_action(&opts, argv[1], verbose);
>   	usage_with_options(builtin_rebase_helper_usage, options);
>   }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2defe607f..048bbf041 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -72,6 +72,7 @@ collapse_todo_ids() {
>   
>   # Switch to the branch in $into and notify it in the reflog
>   checkout_onto () {
> +	comment_for_reflog start
>   	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
>   	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
>   	git update-ref ORIG_HEAD $orig_head
> @@ -119,19 +120,6 @@ initiate_action () {
>   	esac
>   }
>   
> -setup_reflog_action () {
> -	comment_for_reflog start
> -
> -	if test ! -z "$switch_to"
> -	then
> -		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
> -		output git checkout "$switch_to" -- ||
> -			die "$(eval_gettext "Could not checkout \$switch_to")"
> -
> -		comment_for_reflog start
> -	fi
> -}
> -
>   init_basic_state () {
>   	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
>   	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
> @@ -211,7 +199,7 @@ git_rebase__interactive () {
>   		return 0
>   	fi
>   
> -	setup_reflog_action
> +	git rebase--helper --setup-reflog "$switch_to" ${verbose:+--verbose}
>   	init_basic_state
>   
>   	init_revisions_and_shortrevisions
> diff --git a/sequencer.c b/sequencer.c
> index 3437673d2..4bfe29c7b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3131,6 +3131,37 @@ static const char *reflog_message(struct replay_opts *opts,
>   	return buf.buf;
>   }
>   
> +static int checkout_base_commit(struct replay_opts *opts, const char *commit,
> +				int verbose, const char *action)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +	cmd.git_cmd = 1;
> +
> +	argv_array_push(&cmd.args, "checkout");
> +	argv_array_push(&cmd.args, commit);
> +	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> +
> +	if (verbose)
> +		return run_command(&cmd);
> +	else
> +		return run_command_silent_on_success(&cmd);
> +}
> +
> +int setup_reflog_action(struct replay_opts *opts, const char *commit,
> +			int verbose)
> +{
> +	const char *action;
> +
> +	if (commit && *commit) {
> +		action = reflog_message(opts, "start", "checkout %s", commit);
> +		if (checkout_base_commit(opts, commit, verbose, action))
> +			die(_("Could not checkout %s"), commit);
> +	}
> +
> +	return 0;
> +}
> +
>   static const char rescheduled_advice[] =
>   N_("Could not execute the todo command\n"
>   "\n"
> diff --git a/sequencer.h b/sequencer.h
> index 35730b13e..55e4057d8 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -100,6 +100,9 @@ int update_head_with_reflog(const struct commit *old_head,
>   void commit_post_rewrite(const struct commit *current_head,
>   			 const struct object_id *new_head);
>   
> +int setup_reflog_action(struct replay_opts *opts, const char *commit,
> +			int verbose);
> +
>   #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>   #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>   void print_commit_summary(const char *prefix, const struct object_id *oid,
> 

