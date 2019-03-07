Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F55D20248
	for <e@80x24.org>; Thu,  7 Mar 2019 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCGPVF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 10:21:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfCGPVE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 10:21:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id y6so2737635wrn.7
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U6wlKjAeQ3Wv9qsGcUdD7pTZYytcUXNy8jmD0Om+E30=;
        b=DdxS6+rb2Xb77anqWGY84rZQhs7IEYik/aNacM04MAaSwxI5WFWIvoWPV5HcPLw0Ws
         7SSlsf8GlxP9rb1VxOPplcWLq5OIFHdBPukH9TIQ1ei4s0NcnjZFKA5yBtoz9LsjXVcl
         p+BJXeNmt7P2CDEfujCT1sbyleeIx93BZhDVZWfR0EEk4FjcIi0XzHEdZ2YvFvtkin/q
         Iq98VY9vSP5CM6b8QIDvnnJmWErA0/JZg3+R1bMfmPvvgwfmd5ejQzmj2wbh5iQE0Vsg
         Pvjkf8jh0uRCxQ/puWU9WCXZJPmajn6PL1F7kuDXZ0a++xQefKD1eg/lr7afvRsbrwAx
         rs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U6wlKjAeQ3Wv9qsGcUdD7pTZYytcUXNy8jmD0Om+E30=;
        b=oeGHLKEPdwNeu++kl6e/M6Pp8P+bzDDZYVpmn4VkG3+IveIKIkdhEVpvODzR3pzxdI
         DSDB8HQyKU+pBEI/qzwN/PtEpXyeD4LNmcUbQodJXollQgd6QyUzgOn/8KAxGPBkNr+e
         647dPWzGiTRpG6j6W1zXP4j1/0k+syHzBck3NO1Rme+Mc21J7c2pvFaxPYyQHAnJcpmn
         kA5T/kbatWTf3LW3JXOt9G/q5j4xPo0MqKXk+i0MZHsbxGEQCj3EwGecmEiAbhEZSIM+
         twfYVSwknFnqUNeGTK1PE1paHAf/zLaczvBN4IOPM14sEocIIOewBVz4inmr5MNeb6IN
         Y8UQ==
X-Gm-Message-State: APjAAAWTIvJCS5+tPPpnH3HIcYtPL/v8NqhyuPbpsIEZW9mWsz67/E+N
        HxB38e1i9SP94P76vh+Hn54=
X-Google-Smtp-Source: APXvYqyoQOFIFigfP9zHbQmXbcrjnMtf3YzNpSZWp7sXcdEruek8MMYj7xgL+yyM2vhlbJ7EL2djjQ==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr7286389wre.68.1551972062334;
        Thu, 07 Mar 2019 07:21:02 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.gmail.com with ESMTPSA id v10sm7916682wrn.26.2019.03.07.07.21.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:21:01 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] sequencer.c: don't die on invalid cleanup_arg
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
 <cover.1551951770.git.liu.denton@gmail.com>
 <68ec2b7cd7457e9bcd3f6f211774457c73ef8646.1551951770.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <556113c0-b952-522b-d7b4-233c313d158f@gmail.com>
Date:   Thu, 7 Mar 2019 15:21:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <68ec2b7cd7457e9bcd3f6f211774457c73ef8646.1551951770.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

Thanks for doing this, I think it looks ok but it would be better to 
make these changes earlier in the series so they come before what is now 
patch 3

Best Wishes

Phillip

On 07/03/2019 09:58, Denton Liu wrote:
> When get_cleanup_mode was provided with an invalid cleanup_arg, it used
> to die. Warn user and fallback to default behaviour if an invalid
> cleanup_arg is given.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/commit.c |  2 +-
>   builtin/merge.c  |  4 ++--
>   builtin/revert.c |  2 +-
>   sequencer.c      | 10 +++++++---
>   sequencer.h      |  2 +-
>   5 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 43291d79bd..0072a5817a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1167,7 +1167,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
>   	if (argc == 0 && (also || (only && !amend && !allow_empty)))
>   		die(_("No paths with --include/--only does not make sense."));
> -	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
> +	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor, 1);
>   
>   	handle_untracked_files_arg(s);
>   
> diff --git a/builtin/merge.c b/builtin/merge.c
> index d4217ebcf5..3b597ec540 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -916,7 +916,7 @@ static int suggest_conflicts(void)
>   	 * Thus, we will get the cleanup mode which is returned when we _are_ using
>   	 * an editor.
>   	 */
> -	append_conflicts_hint(&msgbuf, get_cleanup_mode(cleanup_arg, 1));
> +	append_conflicts_hint(&msgbuf, get_cleanup_mode(cleanup_arg, 1, 1));
>   	fputs(msgbuf.buf, fp);
>   	strbuf_release(&msgbuf);
>   	fclose(fp);
> @@ -1424,7 +1424,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   	if (option_edit < 0)
>   		option_edit = default_edit_option();
>   
> -	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit);
> +	cleanup_mode = get_cleanup_mode(cleanup_arg, 0 < option_edit, 1);
>   
>   	if (!use_strategies) {
>   		if (!remoteheads)
> diff --git a/builtin/revert.c b/builtin/revert.c
> index fe18036be7..a96f2ecd8a 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -139,7 +139,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   		opts->allow_empty = 1;
>   
>   	if (cleanup_arg)
> -		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
> +		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1, 1);
>   
>   	/* Check for incompatible command line arguments */
>   	if (cmd) {
> diff --git a/sequencer.c b/sequencer.c
> index 5c04bae7ac..7d18c55223 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -170,7 +170,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   		if (status)
>   			return status;
>   
> -		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts));
> +		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts), 0);
>   
>   		free((char *)s);
>   		return status;
> @@ -488,7 +488,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
>   }
>   
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> -	int use_editor)
> +	int use_editor, int die_on_error)
>   {
>   	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
>   		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> @@ -502,7 +502,11 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>   	else if (!strcmp(cleanup_arg, "scissors"))
>   		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
>   				    COMMIT_MSG_CLEANUP_SPACE;
> -	else
> +	else if (!die_on_error) {
> +		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
> +		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> +				    COMMIT_MSG_CLEANUP_SPACE;
> +	} else
>   		die(_("Invalid cleanup mode %s"), cleanup_arg);
>   }
>   
> diff --git a/sequencer.h b/sequencer.h
> index aa99503dd7..c4c80051ea 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -94,7 +94,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
>   void append_conflicts_hint(struct strbuf *msgbuf,
>   		enum commit_msg_cleanup_mode cleanup_mode);
>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
> -	int use_editor);
> +	int use_editor, int die_on_error);
>   
>   void cleanup_message(struct strbuf *msgbuf,
>   	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
> 
