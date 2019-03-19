Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417F420248
	for <e@80x24.org>; Tue, 19 Mar 2019 20:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCSUYd (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 16:24:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44386 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCSUYc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 16:24:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id x10so23135edh.11
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TBNQmZfo26N9BavfYkHxXroT3k88Zz9U299ci9cYSEY=;
        b=pP9t/9eO+1Bes4oAKImmnvLKfcfWG3JVLQsNjmw9us9su5X2YK8148IWDb5zwnGkYj
         RSW4mUmRCN3KZdRMOiKTzQNQ2km/5D8eFUh0qDSulNa9/AVr01xmkxCzYMZ8ax0MBJQT
         SJPqMNpK+sPJKMSNddMyccGrpa+jrItU9CWjspabDayilb9FpLLCvtsAxuxdPAQxSZV7
         jxh0QFzdGFGP1NG2MfrgNtAogoRSAK7/Tss1ID7L304PnZoTxle8paJwZk0r8eManKgM
         n2yUUtf3K78R5siHzySPRiusA7ppzxGADidSp2AsgDFFCEsIIiYHrVSjINbWuf/HmHEC
         tLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TBNQmZfo26N9BavfYkHxXroT3k88Zz9U299ci9cYSEY=;
        b=WbrxcPKid1lp/OhheCiysZO0qs3bPQhkUhHoNpIhMRy62AJhURBcSy+rhTz3MEVJFa
         J2Tyn/XObxk5VR0/sItzTM0m8orpe8MEk8Khc97av2fmMOYlJPbX7xS9kk297MPI6Q9w
         Xid4yPho6+TqsgV+y3dK8x6nrfBJvgz05DBt/7BzQdhrw80LswbsYzbiNgCe32W5OcT9
         h7xSAkSY5ir6DNNjAUAfHl6cRszAQY/HMtgf+/wZAo/1PG/KtXhsjDF6M6RCe4Zyocmi
         d65uGlO97Qh/sXeUGPp3ZyVA0rLNPu5G+UHWcjRHrFKK47+SYw0X6D9xr2Obh4Zx7FhU
         kPfQ==
X-Gm-Message-State: APjAAAVZRZJpF2vBUofgWfv7EUTZth7pdEIVSH4w5iIMcNIawiXrrjXX
        rfKQqp4qw4Qp0Akk7h+4Y/s=
X-Google-Smtp-Source: APXvYqy4AERm6/lWI/+c8ETCo7z6MsrDdTcJWxxas368EC66Yu3Y9N3VfAoL4auXlN35XjI7yMoazQ==
X-Received: by 2002:aa7:d812:: with SMTP id v18mr17216733edq.71.1553027069939;
        Tue, 19 Mar 2019 13:24:29 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y21sm636edb.54.2019.03.19.13.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 13:24:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 10/11] rebase: use a common action enum
References: <20190319190317.6632-1-phillip.wood123@gmail.com> <20190319190317.6632-11-phillip.wood123@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190319190317.6632-11-phillip.wood123@gmail.com>
Date:   Tue, 19 Mar 2019 21:24:28 +0100
Message-ID: <875zseehoj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> cmd_rebase() and cmd_rebase__interactive() used different enums to hold
> the current action. Change to using a common enum so the values are the
> same when we change `rebase -i` to avoid forking `rebase--interactive`.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     I'm not sure what to do with action_names, I moved it to keep it near
>     the definition of the enum. The extra commands in the enum are not
>     traced so they don't need to be in action_names but it looks odd to
>     leave them out. Also I don't understand why action_names in NULL
>     terminated or the names are marked for translation as it is used in
>     	trace2_cmd_mode(action_names[action]);
>     so we don't use the NULL termination or translate the names (I'd be
>     surprised if we did for tracing)

Making them for translation is a bug in the recent b3a5d5a80c
("trace2:data: add subverb for rebase", 2019-02-22) and just looks like
copy/paste cargo-culting from somewhere else, and likewise with the
trailing NULL which doesn't make sense in this case.


>  builtin/rebase.c | 93 +++++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 44 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 21ccb6495e..26d25a5242 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -119,6 +119,30 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  	return replay;
>  }
>
> +enum action {
> +	ACTION_NONE = 0,
> +	ACTION_CONTINUE,
> +	ACTION_SKIP,
> +	ACTION_ABORT,
> +	ACTION_QUIT,
> +	ACTION_EDIT_TODO,
> +	ACTION_SHOW_CURRENT_PATCH,
> +	ACTION_SHORTEN_OIDS,
> +	ACTION_EXPAND_OIDS,
> +	ACTION_CHECK_TODO_LIST,
> +	ACTION_REARRANGE_SQUASH,
> +	ACTION_ADD_EXEC
> +};
> +
> +static const char *action_names[] = { N_("undefined"),
> +				      N_("continue"),
> +				      N_("skip"),
> +				      N_("abort"),
> +				      N_("quit"),
> +				      N_("edit_todo"),
> +				      N_("show_current_patch"),
> +				      NULL };
> +
>  static int add_exec_commands(struct string_list *commands)
>  {
>  	const char *todo_file = rebase_path_todo();
> @@ -347,10 +371,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  	unsigned flags = 0;
>  	int abbreviate_commands = 0, ret = 0;
>  	struct object_id squash_onto = null_oid;
> -	enum {
> -		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
> -		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
> -	} command = 0;
> +	enum action command = ACTION_NONE;
>  	struct option options[] = {
>  		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
>  			   REBASE_FORCE),
> @@ -367,22 +388,22 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  			N_("display a diffstat of what changed upstream"),
>  			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
> -			    CONTINUE),
> -		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
> +			    ACTION_CONTINUE),
> +		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), ACTION_SKIP),
>  		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
> -			    EDIT_TODO),
> +			    ACTION_EDIT_TODO),
>  		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
> -			    SHOW_CURRENT_PATCH),
> +			    ACTION_SHOW_CURRENT_PATCH),
>  		OPT_CMDMODE(0, "shorten-ids", &command,
> -			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
> +			N_("shorten commit ids in the todo list"), ACTION_SHORTEN_OIDS),
>  		OPT_CMDMODE(0, "expand-ids", &command,
> -			N_("expand commit ids in the todo list"), EXPAND_OIDS),
> +			N_("expand commit ids in the todo list"), ACTION_EXPAND_OIDS),
>  		OPT_CMDMODE(0, "check-todo-list", &command,
> -			N_("check the todo list"), CHECK_TODO_LIST),
> +			N_("check the todo list"), ACTION_CHECK_TODO_LIST),
>  		OPT_CMDMODE(0, "rearrange-squash", &command,
> -			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
> +			N_("rearrange fixup/squash lines"), ACTION_REARRANGE_SQUASH),
>  		OPT_CMDMODE(0, "add-exec-commands", &command,
> -			N_("insert exec commands in todo list"), ADD_EXEC),
> +			N_("insert exec commands in todo list"), ACTION_ADD_EXEC),
>  		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"), N_("onto"),
>  		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
>  		{ OPTION_CALLBACK, 0, "restrict-revision", &opts.restrict_revision,
> @@ -428,36 +449,36 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
>  	flags |= opts.rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
>  	flags |= opts.rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
> -	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
> +	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
>
>  	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
>  		warning(_("--[no-]rebase-cousins has no effect without "
>  			  "--rebase-merges"));
>
>  	switch (command) {
> -	case NONE: {
> +	case ACTION_NONE: {
>  		if (!opts.onto && !opts.upstream)
>  			die(_("a base commit must be provided with --upstream or --onto"));
>
>  		ret = do_interactive_rebase(&opts, flags);
>  		break;
>  	}
> -	case SKIP: {
> +	case ACTION_SKIP: {
>  		struct string_list merge_rr = STRING_LIST_INIT_DUP;
>
>  		rerere_clear(the_repository, &merge_rr);
>  	}
>  		/* fallthrough */
> -	case CONTINUE: {
> +	case ACTION_CONTINUE: {
>  		struct replay_opts replay_opts = get_replay_opts(&opts);
>
>  		ret = sequencer_continue(the_repository, &replay_opts);
>  		break;
>  	}
> -	case EDIT_TODO:
> +	case ACTION_EDIT_TODO:
>  		ret = edit_todo_file(flags);
>  		break;
> -	case SHOW_CURRENT_PATCH: {
> +	case ACTION_SHOW_CURRENT_PATCH: {
>  		struct child_process cmd = CHILD_PROCESS_INIT;
>
>  		cmd.git_cmd = 1;
> @@ -466,17 +487,17 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>
>  		break;
>  	}
> -	case SHORTEN_OIDS:
> -	case EXPAND_OIDS:
> +	case ACTION_SHORTEN_OIDS:
> +	case ACTION_EXPAND_OIDS:
>  		ret = transform_todo_file(flags);
>  		break;
> -	case CHECK_TODO_LIST:
> +	case ACTION_CHECK_TODO_LIST:
>  		ret = check_todo_list_from_file(the_repository);
>  		break;
> -	case REARRANGE_SQUASH:
> +	case ACTION_REARRANGE_SQUASH:
>  		ret = rearrange_squash_in_todo_file();
>  		break;
> -	case ADD_EXEC: {
> +	case ACTION_ADD_EXEC: {
>  		struct string_list commands = STRING_LIST_INIT_DUP;
>
>  		split_exec_commands(opts.cmd, &commands);
> @@ -1417,23 +1438,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	struct strbuf revisions = STRBUF_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct object_id merge_base;
> -	enum {
> -		NO_ACTION,
> -		ACTION_CONTINUE,
> -		ACTION_SKIP,
> -		ACTION_ABORT,
> -		ACTION_QUIT,
> -		ACTION_EDIT_TODO,
> -		ACTION_SHOW_CURRENT_PATCH,
> -	} action = NO_ACTION;
> -	static const char *action_names[] = { N_("undefined"),
> -					      N_("continue"),
> -					      N_("skip"),
> -					      N_("abort"),
> -					      N_("quit"),
> -					      N_("edit_todo"),
> -					      N_("show_current_patch"),
> -					      NULL };
> +	enum action action = ACTION_NONE;
>  	const char *gpg_sign = NULL;
>  	struct string_list exec = STRING_LIST_INIT_NODUP;
>  	const char *rebase_merges = NULL;
> @@ -1600,7 +1605,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			     builtin_rebase_options,
>  			     builtin_rebase_usage, 0);
>
> -	if (action != NO_ACTION && total_argc != 2) {
> +	if (action != ACTION_NONE && total_argc != 2) {
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
>  	}
> @@ -1609,7 +1614,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_rebase_usage,
>  				   builtin_rebase_options);
>
> -	if (action != NO_ACTION && !in_progress)
> +	if (action != ACTION_NONE && !in_progress)
>  		die(_("No rebase in progress?"));
>  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
>
> @@ -1709,7 +1714,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		options.action = "show-current-patch";
>  		options.dont_finish_rebase = 1;
>  		goto run_rebase;
> -	case NO_ACTION:
> +	case ACTION_NONE:
>  		break;
>  	default:
>  		BUG("action: %d", action);
