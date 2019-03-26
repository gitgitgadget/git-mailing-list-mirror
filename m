Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD3920248
	for <e@80x24.org>; Tue, 26 Mar 2019 10:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfCZKoa (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 06:44:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46784 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZKoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 06:44:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id o1so13678451wrs.13
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LosfnCgAVjLdEqUpNcDFygv4OUydHRuuCTeZOwn/rsk=;
        b=FA8o8X8zfKT0kz0Zr1Z5ETK8joWSsoMBJJgZHjwzFNNDm7MwMSPHtUFy9AjzUDQiIU
         cnweO0Pgs31jAgW3iPOZCFr5G63GDI4UZb4QeyTSeueFSG4WW25W7ubkFXsJqh5KM3D+
         N4zoPZkGL8mG0QnhJlaCFkPD67n+1RyDXH+cRddt0EA8quOnxtaMMTt1JaP2RS75vo1i
         RnYf2KzVG5OrHhjlW5hvvTuzseqILzv7kCq1uc00cPp17T53jF20Tv+PtiyZB40SBmIQ
         iLYWa/ZZPPZs50LE52Z2vrSMOzVurD+fTxBLRuWkHrXp4KvJZqFjlBwEEtkzhDfo6b6c
         9OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LosfnCgAVjLdEqUpNcDFygv4OUydHRuuCTeZOwn/rsk=;
        b=LnMuxkaCyhBvHBLm26/PpYTUx9SzN82yQinwW8iUbkoAzSnY/MbRgm2BKBr1n081Yy
         0yVsY59SQEONWG+z32V4DimXADFQMrfmJhpCC5AOzZ/wgM82Qf681/cNYHB2l6VRTADi
         2Z7Xh+aE3Mii+zYcWjob8Fs2PAExVLo+ZykM8bm3naia2/skkLWSdLWJuAWXci1tlCO8
         R/OUInOQ78gNkj0Iy8ywygqVCzGfNxMYtXdaIzGOHl3jmL3/Qy1a6jhyMyMA0eMkyAHu
         mZadYUgdpLTLrvEWPNQuUUt8PKTv11b8kfR5dEyflRfB85OFtLkg4+YIvi3rdAtKE+wU
         bsuQ==
X-Gm-Message-State: APjAAAU76+c7Ck78BBGlRJ9VEqamKmohTq77KXQxG79MYT5l/8i37NiP
        6J7SMnEnTpnafl7CpdZe3oA=
X-Google-Smtp-Source: APXvYqwnUAcgB9nCWJENlDjodxfXkbwD3vom1n/QAXLioLNV462J1vKLFGVm8CzMS2rN9F/+wKG0Og==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr18316361wrp.268.1553597067431;
        Tue, 26 Mar 2019 03:44:27 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id t24sm4958427wmi.10.2019.03.26.03.44.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:44:26 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 07/11] sequencer.c: remove duplicate code
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
 <492ba73797ac66cc48da2b44cdae2152b41aa481.1553150827.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <69e3e5b7-58ec-4507-bc5c-c162393368c4@gmail.com>
Date:   Tue, 26 Mar 2019 10:44:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <492ba73797ac66cc48da2b44cdae2152b41aa481.1553150827.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/03/2019 06:53, Denton Liu wrote:
> Since we implemented get_cleanup_mode, we had some duplicate code in
> git_sequencer_config which essentially performed the same operations.
> Refactor git_sequencer_config to take advantage of the logic already in
> get_cleanup_mode.
> 
> Note that we had to introduce a separate argument to get_cleanup_mode
> indicating whether to die or not on an invalid value. This is because if
> we are parsing a config, we do not want to die but instead, we only want
> to warn the user, whereas if we are parsing a command-line option, we
> would like to actually die.
> 
> Finally, this is almost a no-op refactor but not quite. Previously, in
> the case that an invalid value is presented, default_msg_cleanup would
> not be set. 

Looking more closely at the code that's not correct, we set a default 
value before in sequencer_init_config() which unfortunately means my 
previous concerns about needing different values for rebase were not 
correct.

> We change the behaviour so that default_msg_cleanup will now
> take on the value as if "default" were provided as the cleanup_arg.

That is not the default value we want, if the user provides an invalid 
value in the config we're better off using --verbatim which is what the 
current code does.

While looking at all this I noticed that in run_git_commit() we set up 
the cleanup option for to use with

	if ((flags & CLEANUP_MSG))
		argv_array_push(&cmd.args, "--cleanup=strip");
	if ((flags & EDIT_MSG))
		argv_array_push(&cmd.args, "-e");
	else if (!(flags & CLEANUP_MSG) &&
		 !opts->signoff && !opts->record_origin &&
		 git_config_get_value("commit.cleanup", &value))
		argv_array_push(&cmd.args, "--cleanup=verbatim");

So we use --strip when editing (we always set CLEANUP_MSG when EDIT_MSG 
is set) otherwise if opts->signoff or opts->record_origin is set we use 
commit's default cleanup which is --whitespace as we're not editing 
unless the user has set something else. In all other cases we use 
--verbatim unless the user has something set in their config.

With your changes we need to change 
git_config_get_value("commit.cleanup", &value) to something that checks 
to see if --cleanup was given on the command line as well. I think the 
best way is to add an opts->explict_cleanup flag which will also help 
with a bug I introduced when I wrote try_to_commit().

In try_to_commit() we do

	cleanup = (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
					  opts->default_msg_cleanup;

Which does not special case the opts->signoff or opts->record_origin 
cases (opts->default_msg_cleanup will be --verbatim unless the user has 
set something else) I'm planning to send in a patch for that soonish, it 
will involve adding opts->explicit_cleanup which will interact badly 
with this series as it is, I'll try and do some fixups to address that.

I have a general question about this series. If I run 'merge 
--cleanup=scissors' or 'cherry-pick --cleanup=scissors' and there are 
conflicts what happens when if I run 'commit --no-edit' to commit the 
conflict resolution - does it know which cleanup mode to use?

Best Wishes

Phillip


> Also, we lowercase some user-facing strings.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/commit.c |  2 +-
>   sequencer.c      | 22 ++++++++--------------
>   sequencer.h      |  2 +-
>   3 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8277da8474..ba1e6027ba 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1172,7 +1172,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
>   	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>   		die(_("No paths with --include/--only does not make sense."));
> -	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
> +	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor, 1);
>   
>   	handle_untracked_files_arg(s);
>   
> diff --git a/sequencer.c b/sequencer.c
> index 224c823b43..2cbfb848dd 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -172,17 +172,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   		if (status)
>   			return status;
>   
> -		if (!strcmp(s, "verbatim"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
> -		else if (!strcmp(s, "whitespace"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
> -		else if (!strcmp(s, "strip"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
> -		else if (!strcmp(s, "scissors"))
> -			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
> -		else
> -			warning(_("invalid commit message cleanup mode '%s'"),
> -				  s);
> +		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
>   
>   		free((char *)s);
>   		return status;
> @@ -512,7 +502,7 @@ static int fast_forward_to(struct repository *r,
>   }
>   
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> -	int use_editor)
> +	int use_editor, int die_on_error)
>   {
>   	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
>   		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> @@ -526,8 +516,12 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>   	else if (!strcmp(cleanup_arg, "scissors"))
>   		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
>   				    COMMIT_MSG_CLEANUP_SPACE;
> -	else
> -		die(_("Invalid cleanup mode %s"), cleanup_arg);
> +	else if (!die_on_error) {
> +		warning(_("invalid cleanup mode %s, falling back to default"), cleanup_arg);
> +		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> +				    COMMIT_MSG_CLEANUP_SPACE;
> +	} else
> +		die(_("invalid cleanup mode %s"), cleanup_arg);
>   }
>   
>   void append_conflicts_hint(struct index_state *istate,
> diff --git a/sequencer.h b/sequencer.h
> index eb9bd97ef3..e7908f558e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -117,7 +117,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
>   
>   void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> -	int use_editor);
> +	int use_editor, int die_on_error);
>   
>   void cleanup_message(struct strbuf *msgbuf,
>   	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
> 
