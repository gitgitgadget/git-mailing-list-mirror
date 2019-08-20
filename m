Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECE21F461
	for <e@80x24.org>; Tue, 20 Aug 2019 13:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfHTNpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 09:45:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33235 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfHTNpm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 09:45:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so12480765wrr.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xO5CIw3HJ652yK6nfKAUfhZ5gOiY1TsCt5vKB/vnxIk=;
        b=JSQl4gd/SguSGwGs+vM9o9ZjFR+kanlvXPNXT8mIMaocE7gT/A5RwwsMUPJebYtp9R
         rl8Imvn5a6Poiuel/JTZtH5tJspko1cxRGcImqmShL0IuimTaVutPmhqUgBq7k6ghclp
         3H9cg3IIovssBuQW1P4KUquR0xqq3n4ARVd5nGH29GIoEUNmrBSH70n9olGST/XKgt5V
         0p1BhXt77YDDFCvKWSJLk/IXG58bUGQ58bbiNKzddvLrD6i6PA+wLap9lQLoAJRNRcbz
         PKdMaCi+alAe1ssnI/LmGF8w6BQ8KJOi+z8KUklBkqS/lIEvEdte9MF7C5tJRDY0DmPr
         ycYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xO5CIw3HJ652yK6nfKAUfhZ5gOiY1TsCt5vKB/vnxIk=;
        b=oizDBu8AjZpvIiqMfS3KF+8LHyA8hzaN/4+Akt30ZVwnPW9uR2DJTeRlzdlppbljaO
         6OnJF6/INFyV3hO3YqTR7/uCuS+/7KkTCMK7bcB2zzfEnEPk8B82DS//YNQL3qItVCPN
         F7hhUYQlx8FxB0Tt5UII0FYq3PGY2omPxk4TKCIubVxz4rciuyvI6E39G7DimjSqW4vX
         SAmIxp8m40Dcl456cNQL9isAIh0fKg9bPNsuO6iNXi9Nc4uwcj0M29aWKNg/ASY9Xojr
         4Sa3yYN1NwizB754XSsTkqVNLx0U2CBZAcgBeQ71lldK/b6IhpVjgaHmC1ym3rLtYkgi
         m5eA==
X-Gm-Message-State: APjAAAWvKWVHSacSQcYM3HSH++JE5l6BfCB76YAAZrNkkVyrOH3xyAUc
        J0WT8e/oNZbA1mVb1kVnEKOZjAicV+o=
X-Google-Smtp-Source: APXvYqz4vjqyr3LxYxU/B615hrF3a/432f00wEIB1o0nJvXXrwIbcfMq4A5CMrAmRUW2SYx7FBM1Yw==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr33313343wrn.316.1566308739954;
        Tue, 20 Aug 2019 06:45:39 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id j10sm22441758wrd.26.2019.08.20.06.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 06:45:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] rebase -i: support --ignore-date
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-6-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ca047519-7226-a94b-9ec6-d5e23b6cf31d@gmail.com>
Date:   Tue, 20 Aug 2019 14:45:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820034536.13071-6-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 20/08/2019 04:45, Rohit Ashiwal wrote:
> rebase am already has this flag to "lie" about the author date
> by changing it to the committer (current) date. Let's add the same
> for interactive machinery.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   Documentation/git-rebase.txt            |  6 +--
>   builtin/rebase.c                        | 16 ++++---
>   sequencer.c                             | 58 ++++++++++++++++++++++++-
>   sequencer.h                             |  1 +
>   t/t3433-rebase-options-compatibility.sh | 16 +++++++
>   5 files changed, 87 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7c0eac18c..e7ac9fae0b 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -391,8 +391,8 @@ See also INCOMPATIBLE OPTIONS below.
>   	as the committer date. This implies --force-rebase.
>   
>   --ignore-date::
> -	This flag is passed to 'git am' to change the author date
> -	of each rebased commit (see linkgit:git-am[1]).
> +	Instead of using the given author date, reset it to the value
> +	same as the current time. This implies --force-rebase.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
> @@ -529,7 +529,6 @@ INCOMPATIBLE OPTIONS
>   
>   The following options:
>   
> - * --ignore-date
>    * --whitespace
>    * -C
>   
> @@ -555,6 +554,7 @@ In addition, the following pairs of options are incompatible:
>    * --preserve-merges and --rebase-merges
>    * --preserve-merges and --ignore-whitespace
>    * --preserve-merges and --committer-date-is-author-date
> + * --preserve-merges and --ignore-date
>    * --rebase-merges and --ignore-whitespace
>    * --rebase-merges and --strategy
>    * --rebase-merges and --strategy-option
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 656bc7d7e9..a63531ee90 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -83,6 +83,7 @@ struct rebase_options {
>   	char *gpg_sign_opt;
>   	int autostash;
>   	int committer_date_is_author_date;
> +	int ignore_date;
>   	char *cmd;
>   	int allow_empty_message;
>   	int rebase_merges, rebase_cousins;
> @@ -117,6 +118,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>   	replay.committer_date_is_author_date =
>   					opts->committer_date_is_author_date;
> +	replay.ignore_date = opts->ignore_date;
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>   	replay.strategy = opts->strategy;
>   
> @@ -981,6 +983,8 @@ static int run_am(struct rebase_options *opts)
>   		argv_array_push(&am.args, "--ignore-whitespace");
>   	if (opts->committer_date_is_author_date)
>   		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
> +	if (opts->ignore_date)
> +		argv_array_push(&opts->git_am_opts, "--ignore-date");
>   	if (opts->action && !strcmp("continue", opts->action)) {
>   		argv_array_push(&am.args, "--resolved");
>   		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1427,8 +1431,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		OPT_BOOL(0, "committer-date-is-author-date",
>   			 &options.committer_date_is_author_date,
>   			 N_("make committer date match author date")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> +		OPT_BOOL(0, "ignore-date", &options.ignore_date,
> +			 "ignore author date and use current date"),
>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>   				  N_("passed to 'git apply'"), 0),
>   		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> @@ -1697,13 +1701,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		    state_dir_base, cmd_live_rebase, buf.buf);
>   	}
>   
> -	if (options.committer_date_is_author_date)
> +	if (options.ignore_date)
> +		options.committer_date_is_author_date = 0;
> +	if (options.committer_date_is_author_date ||
> +	    options.ignore_date)
>   		options.flags |= REBASE_FORCE;
>   
>   	for (i = 0; i < options.git_am_opts.argc; i++) {
>   		const char *option = options.git_am_opts.argv[i], *p;
> -		if (!strcmp(option, "--ignore-date") ||
> -		    !strcmp(option, "--whitespace=fix") ||
> +		if (!strcmp(option, "--whitespace=fix") ||
>   		    !strcmp(option, "--whitespace=strip"))
>   			options.flags |= REBASE_FORCE;
>   		else if (skip_prefix(option, "-C", &p)) {
> diff --git a/sequencer.c b/sequencer.c
> index 8f7b984333..f5a9590844 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -148,6 +148,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>    */
>   static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>   static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
> +static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
>   static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>   static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>   static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -919,6 +920,32 @@ static const char *read_author_ident(struct strbuf *buf)
>   	return buf->buf;
>   }
>   
> +/* Construct a free()able author string with current time as the author date */
> +static char *ignore_author_date(const char *author)
> +{
> +	int len = strlen(author);
> +	struct ident_split ident;
> +	struct strbuf new_author = STRBUF_INIT;
> +
> +	split_ident_line(&ident, author, len);

You need to check the return value whenever you call split_ident_line(). 
In this case doing so would avoid using NULL pointers below if the 
author is corrupted.

> +	len = ident.mail_end - ident.name_begin + 1;
> +
> +	strbuf_addf(&new_author, "%.*s ", len, author);
> +	datestamp(&new_author);
> +	return strbuf_detach(&new_author, NULL);
> +}

I think this is clearer now it returns the new author

> +
> +static void push_dates(struct child_process *child)
> +{
> +	time_t now = time(NULL);
> +	struct strbuf date = STRBUF_INIT;
> +
> +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
> +	argv_array_pushf(&child->args, "--date=%s", date.buf);
> +	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);

Looking at the code in builtin/am.c it is quite clear how it handles the 
combination of --ignore-date and --committer-date-is-author date is it 
sets GIT_COMMITTER_DATE in a single place. Here we've got two separate 
pieces of code one from patch 3 the other added here. This 
implementation differs from the one in builtin/am.c if --ignore-date is 
given when GIT_COMMITTER_DATE is set in the environment and 
--committer-date-is-author-date is not given.

> +	strbuf_release(&date);
> +}
> +
>   static const char staged_changes_advice[] =
>   N_("you have staged changes in your working tree\n"
>   "If these changes are meant to be squashed into the previous commit, run:\n"
> @@ -1020,10 +1047,20 @@ static int run_git_commit(struct repository *r,
>   
>   		if (res <= 0)
>   			res = error_errno(_("could not read '%s'"), defmsg);
> -		else
> +		else {
> +			if (opts->ignore_date) {
> +				char *new_author = ignore_author_date(author);
> +				if (!author)
> +					BUG("ignore-date can only be used with "
> +					    "rebase, which must set the author "
> +					    "before committing the tree");
> +				free((void *)author);
> +				author = new_author;
> +			}
>   			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
>   					  NULL, &root_commit, author,
>   					  opts->gpg_sign);
> +		}
>   
>   		strbuf_release(&msg);
>   		strbuf_release(&script);
> @@ -1053,6 +1090,8 @@ static int run_git_commit(struct repository *r,
>   		argv_array_push(&cmd.args, "--amend");
>   	if (opts->gpg_sign)
>   		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +	if (opts->ignore_date)
> +		push_dates(&cmd);
>   	if (defmsg)
>   		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>   	else if (!(flags & EDIT_MSG))
> @@ -1515,6 +1554,11 @@ static int try_to_commit(struct repository *r,
>   
>   	reset_ident_date();
>   
> +	if (opts->ignore_date) {
> +		author = ignore_author_date(author);
> +		free(author_to_free);
> +		author_to_free = (char *)author;
> +	}

The memory handling is much clearer now

>   	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
>   				 oid, author, opts->gpg_sign, extra)) {
>   		res = error(_("failed to write commit object"));
> @@ -2592,6 +2636,11 @@ static int read_populate_opts(struct replay_opts *opts)
>   			opts->committer_date_is_author_date = 1;
>   		}
>   
> +		if (file_exists(rebase_path_ignore_date())) {
> +			opts->allow_ff = 0;
> +			opts->ignore_date = 1;
> +		}
> +
>   		if (file_exists(rebase_path_reschedule_failed_exec()))
>   			opts->reschedule_failed_exec = 1;
>   
> @@ -2676,6 +2725,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>   		write_file(rebase_path_signoff(), "--signoff\n");
>   	if (opts->committer_date_is_author_date)
>   		write_file(rebase_path_cdate_is_adate(), "%s", "");
> +	if (opts->ignore_date)
> +		write_file(rebase_path_ignore_date(), "%s", "");
>   	if (opts->reschedule_failed_exec)
>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>   
> @@ -3601,6 +3652,8 @@ static int do_merge(struct repository *r,
>   		argv_array_push(&cmd.args, git_path_merge_msg(r));
>   		if (opts->gpg_sign)
>   			argv_array_push(&cmd.args, opts->gpg_sign);
> +		if (opts->ignore_date)
> +			push_dates(&cmd);
>   
>   		/* Add the tips to be merged */
>   		for (j = to_merge; j; j = j->next)
> @@ -3874,7 +3927,8 @@ static int pick_commits(struct repository *r,
>   	if (opts->allow_ff)
>   		assert(!(opts->signoff || opts->no_commit ||
>   				opts->record_origin || opts->edit ||
> -				opts->committer_date_is_author_date));
> +				opts->committer_date_is_author_date ||
> +				opts->ignore_date));
>   	if (read_and_refresh_cache(r, opts))
>   		return -1;
>   
> diff --git a/sequencer.h b/sequencer.h
> index e3881e9275..bf5a79afdb 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -44,6 +44,7 @@ struct replay_opts {
>   	int quiet;
>   	int reschedule_failed_exec;
>   	int committer_date_is_author_date;
> +	int ignore_date;
>   
>   	int mainline;
>   
> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> index b2419a2b75..c060fcd10b 100755
> --- a/t/t3433-rebase-options-compatibility.sh
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -81,4 +81,20 @@ test_expect_success '--committer-date-is-author-date works with interactive back
>   	test_cmp authortime committertime
>   '
>   
> +# Checking for +0000 in author time is enough since default
> +# timezone is UTC, but the timezone used while committing
> +# sets to +0530.

I'm still worried that this will hide some breakage in the future. Can 
we add a test for rebase -r as well to check that code please.

Best Wishes

Phillip

> +test_expect_success '--ignore-date works with am backend' '
> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
> +	git rebase --ignore-date HEAD^ &&
> +	git show HEAD --pretty="format:%ai" >authortime &&
> +	grep "+0000" authortime
> +'
> +
> +test_expect_success '--ignore-date works with interactive backend' '
> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
> +	git rebase --ignore-date -i HEAD^ &&
> +	git show HEAD --pretty="format:%ai" >authortime &&
> +	grep "+0000" authortime
> +'
>   test_done
> 
