Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A46020248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCKQpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:45:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34826 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQpt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:45:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id t18so5899541wrx.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oc24ke8A1A890AoEC9bBBkGF7f6SawIAXQjk88btQ+Q=;
        b=JS1/X8zrJsyTX9yBmCYRQd8O0Un7fmuoprcU1qDWp9+4aKYF8rb9mu2WN5i5neSyRm
         jtcOgtk+kG5i0GG+N1zWtzCMAjyCTsdiWhOUTxJJB1dIHS+OwshyQjsbeHJz1smjdqGY
         /dZLCtMWFZd7AhmlzVVlulFOHG3waKziGN0BFs0L2v4hxRwtq1bFHj3OWW9ydY91Db5Z
         peksr6ak3nmysu6y+axkTHedT/gENdgM1JnJi1wDuVKbpis6GSL3HpnBVWG6mZRGLrqk
         w6ZlMV8qzvpI8GyvvZwrIcFUTaS0JHooLqlPi6PsNAg94QipE6sh1OYw6RXdXR5e7fKK
         5ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Oc24ke8A1A890AoEC9bBBkGF7f6SawIAXQjk88btQ+Q=;
        b=Z1U14EqajmHocGGEnxptxxFsziM7xaHrIpTngGS/COogwSB6+xDhzIa9L+6o6Q5O6U
         I4uVUn5RiYIMmbQvK/WMAL3f8AfEDCDDCIPVCahX6MFjjy+m7yIvWxIVR8V3MfWhDKew
         VB8oczCwQYJFnO/hYlXZDGRTFXH68l7lSbH5fRSXki0OytqhcwFsCyQbdq5k51EvBcyk
         NdueoxKvCc2rV0NBHPWo69vwNND2l9pHS6IsxJ0WUmXhGwT34tWUFPrPNRzRlgNFzL7H
         4mqBf7n1mgDkbaQm9ig/UbAWw/GyzXosff+DBj88OQf/YBsESq4gSae/X1+gya/VZUEo
         qCIg==
X-Gm-Message-State: APjAAAU3cbOmEYdNOz6Cf8SMWDEadJ9w/Jhbo3Qt3+8ZWNGeZ+HKcBOB
        fOQfLQ9DD1xpMfhEB6gktw8=
X-Google-Smtp-Source: APXvYqypK3G1jx9w6e4JrVEVnXQDNgwkxobhzHBM2q/mmWxPiHWjpBl9rDdRFhYz33EzlRBBCwHNcA==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr7858667wrr.160.1552322747291;
        Mon, 11 Mar 2019 09:45:47 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id y5sm17496864wmg.31.2019.03.11.09.45.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:45:46 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/8] sequencer.c: remove duplicate code
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
 <6d5ce3ffffe5ef6c23b12538650b2cdf86e4cac9.1552275703.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3b863432-e9b8-051a-a52e-efe4938f62d0@gmail.com>
Date:   Mon, 11 Mar 2019 16:45:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6d5ce3ffffe5ef6c23b12538650b2cdf86e4cac9.1552275703.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

One small comment below, this basically looks fine to me

On 11/03/2019 03:42, Denton Liu wrote:
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
> not be set. We change the behaviour so that default_msg_cleanup will now
> take on the value as if "default" were provided as the cleanup_arg.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/commit.c |  2 +-
>   sequencer.c      | 20 +++++++-------------
>   sequencer.h      |  2 +-
>   3 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0df15e4851..81e3bd21ca 100644
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
> index 224c823b43..612621f221 100644
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
> @@ -526,7 +516,11 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>   	else if (!strcmp(cleanup_arg, "scissors"))
>   		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
>   				    COMMIT_MSG_CLEANUP_SPACE;
> -	else
> +	else if (!die_on_error) {
> +		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);

git generally starts error messages with a lower-case letter so I would 
change the message in the previous patch to match that pattern rather 
than changing this one.


Best Wishes

Phillip


> +		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> +				    COMMIT_MSG_CLEANUP_SPACE;
> +	} else
>   		die(_("Invalid cleanup mode %s"), cleanup_arg);
>   }
>   
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
