Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF08020248
	for <e@80x24.org>; Thu,  7 Mar 2019 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGSgo (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 13:36:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56292 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSgn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 13:36:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so10352919wme.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwxLsX7b1R+E9L/ZxCEROzTT0tO806iByMx+i+JcXnI=;
        b=H/S+o3mQejCWR4eekO0xSbdey0/i8XGRtWEjat1hPXPqg4Cor2EKRZT93yqGTHHvQn
         beS2J3nAQRIQjzFeW3DX/P3fKRgzy9gz1H/WNt8wlegEnmouJHfgZmVJLMh8GoJ6LSvU
         X1lB6Gv57wSxk2p+A+EA1HuUw2mk8lcEdK9rEj2YuUeHcwp7saUz25E0CYqcPDmifYgn
         sBSD5nEuF/S2mhlG8tnTRljgTthw4gLOTxjqjEStPbKD0UDis3bGVlWnZ7mE0lPJILlk
         WydbwKpofPGW7ogMTsh6GBWjlCe9jtsaSYsR8GPbzst205opYwclbrfV4YjA144x5faJ
         yVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwxLsX7b1R+E9L/ZxCEROzTT0tO806iByMx+i+JcXnI=;
        b=udwIGovenHn7hWCuKg+8wYaP4WASV7XYoMhJs5Vqn5edQnV2yJOKBVNG8hXLVBM+lB
         lTrprWpl//d+oj9MvuP/n3VMSFPpaeSB6Y6QhJSf8IzDR4B+b61gZE3m9bsBehwByN4r
         YtJOH71+bB/VTZjBJsFQisKYwnr4fZab9U6W5ueznoenDQBoi5XtkfCfBQa/X1Z6TvgL
         yxxE5Jr0MzhlBZj1GGUroOjaGZdrExznedFTd8MUhTOv4zv1BiZ9jhTanTf0hx/MuF0b
         fTvI9fydZ+WOcOjnj0REIjFln4hJ3N0r1l7NgKVXD4vX0EoAcKhfMJh3A0wRtVz4n+TV
         115A==
X-Gm-Message-State: APjAAAUokhXzjyXuFd7kKCMb4ggBzH2AoNHQ/joY7qoMzOH8m3hF/Bnd
        IDJ0VOhqyApKyl/pJ9cAJ+0=
X-Google-Smtp-Source: APXvYqy9MPCjBoJgDQAW7gFMBxuJj0VawiwXTUja1pW9IlySjlhQs/qfttbECSVMlWsLyGJo7hV59A==
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr6587462wmg.27.1551983800933;
        Thu, 07 Mar 2019 10:36:40 -0800 (PST)
Received: from [192.168.2.201] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.googlemail.com with ESMTPSA id v20sm10038627wmj.2.2019.03.07.10.36.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:36:40 -0800 (PST)
Subject: Re: [PATCH v3 3/4] cherry-pick/revert: add scissors line on merge
 conflict
To:     Denton Liu <liu.denton@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
 <cover.1551951770.git.liu.denton@gmail.com>
 <14672ce10c90c46b15b62c48d2eea6fe8d85ed86.1551951770.git.liu.denton@gmail.com>
 <b568185b-2411-7c43-b1bb-c22594904fa0@gmail.com>
 <20190307175628.GA14130@dev-l>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8404ea52-6556-1232-176e-f74f8d9583f8@gmail.com>
Date:   Thu, 7 Mar 2019 18:36:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307175628.GA14130@dev-l>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/03/2019 17:56, Denton Liu wrote:
> Hi Phillip,
> 
> On Thu, Mar 07, 2019 at 03:24:16PM +0000, Phillip Wood wrote:
>> Hi Denton
>>
>> On 07/03/2019 09:58, Denton Liu wrote:
>>> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
>>> index f7c2a5fdc8..5f1bc9d383 100644
>>> --- a/builtin/rebase--helper.c
>>> +++ b/builtin/rebase--helper.c
>>> @@ -48,10 +48,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>>>  		OPT_END()
>>>  	};
>>> +	opts.action = REPLAY_INTERACTIVE_REBASE;
>>>  	sequencer_init_config(&opts);
>>>  	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
>>> -	opts.action = REPLAY_INTERACTIVE_REBASE;
>>>  	opts.allow_ff = 1;
>>>  	opts.allow_empty = 1;
>>
>>
>> What are you basing this series on? builtin/rebase--helper.c was removed
>> last September in 34b47315d9 ("rebase -i: move rebase--helper modes to
>> rebase--interactive", 2018-09-27)
> 
> I was basing this patch on the tip of dl/merge-cleanup-scissors-fix. I
> can rebase or merge my work to something else but I'll wait for
> additional directions since I don't know what would be best.

See what Junio says, I think it might be simple enough for him to fix
that up when he merges it into pu.


I've just realized that if you're cherry-picking a range of commits and
it stops for a conflict resolution then the new option is not saved.
You'll need to update populate_opts_cb() and save_opts() in sequencer.c
to do that.

Best Wishes

Phillip


>>> diff --git a/builtin/revert.c b/builtin/revert.c
>>> index 9a66720cfc..fe18036be7 100644
>>> --- a/builtin/revert.c
>>> +++ b/builtin/revert.c
>>> @@ -95,11 +95,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>>>  {
>>>  	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
>>>  	const char *me = action_name(opts);
>>> +	const char *cleanup_arg = NULL;
>>>  	int cmd = 0;
>>>  	struct option base_options[] = {
>>>  		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
>>>  		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
>>>  		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
>>> +		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
>>>  		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
>>>  		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
>>>  		OPT_NOOP_NOARG('r', NULL),
>>> @@ -136,6 +138,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>>>  	if (opts->keep_redundant_commits)
>>>  		opts->allow_empty = 1;
>>> +	if (cleanup_arg)
>>> +		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
>>> +
>>>  	/* Check for incompatible command line arguments */
>>>  	if (cmd) {
>>>  		char *this_operation;
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 707e72fb39..5c04bae7ac 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -153,6 +153,11 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
>>>  static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
>>>  static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
>>> +static inline int is_rebase_i(const struct replay_opts *opts)
>>> +{
>>> +	return opts->action == REPLAY_INTERACTIVE_REBASE;
>>> +}
>>> +
>>
>> This is already in sequencer.c in a different place in recent versions
> 
> I was just moving this function from below here so that the compiler
> would pick it up.
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>>  static int git_sequencer_config(const char *k, const char *v, void *cb)
>>>  {
>>>  	struct replay_opts *opts = cb;
>>> @@ -165,17 +170,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>>>  		if (status)
>>>  			return status;
>>> -		if (!strcmp(s, "verbatim"))
>>> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
>>> -		else if (!strcmp(s, "whitespace"))
>>> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
>>> -		else if (!strcmp(s, "strip"))
>>> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
>>> -		else if (!strcmp(s, "scissors"))
>>> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
>>> -		else
>>> -			warning(_("invalid commit message cleanup mode '%s'"),
>>> -				  s);
>>> +		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts));
>>>  		free((char *)s);
>>>  		return status;
>>> @@ -199,11 +194,6 @@ void sequencer_init_config(struct replay_opts *opts)
>>>  	git_config(git_sequencer_config, opts);
>>>  }
>>> -static inline int is_rebase_i(const struct replay_opts *opts)
>>> -{
>>> -	return opts->action == REPLAY_INTERACTIVE_REBASE;
>>> -}
>>> -
>>>  static const char *get_dir(const struct replay_opts *opts)
>>>  {
>>>  	if (is_rebase_i(opts))
>>> @@ -516,10 +506,16 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>>>  		die(_("Invalid cleanup mode %s"), cleanup_arg);
>>>  }
>>> -void append_conflicts_hint(struct strbuf *msgbuf)
>>> +void append_conflicts_hint(struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
>>>  {
>>>  	int i;
>>> +	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
>>> +		strbuf_addch(msgbuf, '\n');
>>> +		wt_status_append_cut_line(msgbuf);
>>> +		strbuf_addch(msgbuf, comment_line_char);
>>> +	}
>>> +
>>>  	strbuf_addch(msgbuf, '\n');
>>>  	strbuf_commented_addf(msgbuf, "Conflicts:\n");
>>>  	for (i = 0; i < active_nr;) {
>>> @@ -586,7 +582,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>>>  			_(action_name(opts)));
>>>  	if (!clean)
>>> -		append_conflicts_hint(msgbuf);
>>> +		append_conflicts_hint(msgbuf, opts->default_msg_cleanup);
>>>  	return !clean;
>>>  }
>>> diff --git a/sequencer.h b/sequencer.h
>>> index 5690e0c27e..aa99503dd7 100644
>>> --- a/sequencer.h
>>> +++ b/sequencer.h
>>> @@ -91,7 +91,8 @@ int rearrange_squash(void);
>>>  extern const char sign_off_header[];
>>>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
>>> -void append_conflicts_hint(struct strbuf *msgbuf);
>>> +void append_conflicts_hint(struct strbuf *msgbuf,
>>> +		enum commit_msg_cleanup_mode cleanup_mode);
>>>  enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>>>  	int use_editor);
>>> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
>>> index 74ff925526..c3894ca9d6 100755
>>> --- a/t/t3507-cherry-pick-conflict.sh
>>> +++ b/t/t3507-cherry-pick-conflict.sh
>>> @@ -189,6 +189,46 @@ test_expect_success 'failed cherry-pick registers participants in index' '
>>>  	test_cmp expected actual
>>>  '
>>> +test_expect_success \
>>> +	'cherry-pick conflict, ensure commit.cleanup = scissors places scissors line properly' '
>>> +	pristine_detach initial &&
>>> +	git config commit.cleanup scissors &&
>>> +	cat <<-EOF >expected &&
>>> +		picked
>>> +
>>> +		# ------------------------ >8 ------------------------
>>> +		# Do not modify or remove the line above.
>>> +		# Everything below it will be ignored.
>>> +		#
>>> +		# Conflicts:
>>> +		#	foo
>>> +		EOF
>>> +
>>> +	test_must_fail git cherry-pick picked &&
>>> +
>>> +	test_i18ncmp expected .git/MERGE_MSG
>>> +'
>>> +
>>> +test_expect_success \
>>> +	'cherry-pick conflict, ensure cleanup=scissors places scissors line properly' '
>>> +	pristine_detach initial &&
>>> +	git config --unset commit.cleanup &&
>>> +	cat <<-EOF >expected &&
>>> +		picked
>>> +
>>> +		# ------------------------ >8 ------------------------
>>> +		# Do not modify or remove the line above.
>>> +		# Everything below it will be ignored.
>>> +		#
>>> +		# Conflicts:
>>> +		#	foo
>>> +		EOF
>>> +
>>> +	test_must_fail git cherry-pick --cleanup=scissors picked &&
>>> +
>>> +	test_i18ncmp expected .git/MERGE_MSG
>>> +'
>>> +
>>>  test_expect_success 'failed cherry-pick describes conflict in work tree' '
>>>  	pristine_detach initial &&
>>>  	cat <<-EOF >expected &&
>>> @@ -335,6 +375,52 @@ test_expect_success 'revert conflict, diff3 -m style' '
>>>  	test_cmp expected actual
>>>  '
>>> +test_expect_success \
>>> +	'revert conflict, ensure commit.cleanup = scissors places scissors line properly' '
>>> +	pristine_detach initial &&
>>> +	git config commit.cleanup scissors &&
>>> +	cat >expected <<-EOF &&
>>> +		Revert "picked"
>>> +
>>> +		This reverts commit OBJID.
>>> +
>>> +		# ------------------------ >8 ------------------------
>>> +		# Do not modify or remove the line above.
>>> +		# Everything below it will be ignored.
>>> +		#
>>> +		# Conflicts:
>>> +		#	foo
>>> +		EOF
>>> +
>>> +	test_must_fail git revert picked &&
>>> +
>>> +	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
>>> +	test_i18ncmp expected actual
>>> +'
>>> +
>>> +test_expect_success \
>>> +	'revert conflict, ensure cleanup=scissors places scissors line properly' '
>>> +	pristine_detach initial &&
>>> +	git config --unset commit.cleanup &&
>>> +	cat >expected <<-EOF &&
>>> +		Revert "picked"
>>> +
>>> +		This reverts commit OBJID.
>>> +
>>> +		# ------------------------ >8 ------------------------
>>> +		# Do not modify or remove the line above.
>>> +		# Everything below it will be ignored.
>>> +		#
>>> +		# Conflicts:
>>> +		#	foo
>>> +		EOF
>>> +
>>> +	test_must_fail git revert --cleanup=scissors picked &&
>>> +
>>> +	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
>>> +	test_i18ncmp expected actual
>>> +'
>>> +
>>>  test_expect_success 'failed cherry-pick does not forget -s' '
>>>  	pristine_detach initial &&
>>>  	test_must_fail git cherry-pick -s picked &&
>>>
> 
> Thanks,
> 
> Denton
> 

