Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1300420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbeLKCNr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:13:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39646 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:13:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so12448910wra.6
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Auvu2TKh2hzosGche3Kd5XKuT0itJUEGVh/BfICR0hM=;
        b=pTNaVNPLf66wYgj4nvesOLAKVQlkw66qKpkkp+ED5vEUwiJB5SEwHlP9rDRFojz1KB
         atgp35H76p6AzKzygI/hi1lYp2q1ql/WQh+C86D2iOcPWyPTxodyI3iv7iP31RSyFTgm
         QiBIgCTtKamq6i8j2zvLestIWt8Fcl6m9YupcukRSh6aNwCgdijSNURRj+grNy/mkvIa
         SfRrAtzZS8r8OeZrBqkLia8Sn8Ad2cbw61r58gy1mNEo8+aedh7/UjGV1pWs/O+J++ks
         CsRPnXMcqiqHuhKpSJ0+rE07KWCdXPMvD52lzJ/3sCxIOXcpDgwV2Yx7riakOGrw2LkD
         usNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Auvu2TKh2hzosGche3Kd5XKuT0itJUEGVh/BfICR0hM=;
        b=GymfmbwRjk5li01uNvv42I96zGFBgmxD8FHEbC03PhngDdm5ZofIM9BJNAnLibZAbv
         ZDPaQInnomAW+5A/gSrpKz9TmgnwdTIHY4mfvb0i9TmBz1vmgiTIhaE+p7u8jaY0xBf/
         1IfMv24qfSBSBxVJj74+hvEnInBtHAzP/6nLCgdfYTsXtpIC/zV54p327X+yMwygez3M
         TlTNOfrWPPtcZBH4MvOO4RbqFallGo7B5HC5hDpt8AvrnPxMv5O0tepErcv/j04mtxeb
         Fxs3H7IQ3GY04x+FIj5JiliHNQ7jCc57exCsxggLWdsy6t493duf93uENhRLVQ4o9Axv
         lMzw==
X-Gm-Message-State: AA+aEWZjFlw83/+maajkunEF7DlGvZHRUHipJ3u9wPL71ZCACoXf7g+a
        Hr6Ay2dZwgpZBxFMxptuZ/6TLqriCg8=
X-Google-Smtp-Source: AFSGD/U7xyPCON/QcPvEA2YBn/GmZ8SUaSryJxWITMmke8ZZCKqaLFYlhghfToKdw+NcJdp6lMYo4A==
X-Received: by 2002:adf:9484:: with SMTP id 4mr10944079wrr.98.1544494424651;
        Mon, 10 Dec 2018 18:13:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d4sm456323wmb.25.2018.12.10.18.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 18:13:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] parse-options: fix SunCC compiler warning
References: <87va4cujtx.fsf@evledraar.gmail.com>
        <20181209102724.8707-1-pclouds@gmail.com>
        <xmqqy38xkhvd.fsf@gitster-ct.c.googlers.com>
        <20181210152642.GA16203@duynguyen.home>
Date:   Tue, 11 Dec 2018 11:13:43 +0900
In-Reply-To: <20181210152642.GA16203@duynguyen.home> (Duy Nguyen's message of
        "Mon, 10 Dec 2018 16:26:42 +0100")
Message-ID: <xmqqk1kgn73c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The reason it's in parse_options_step() is because -h is also handled
> in there. Although -h does not bury exit() deep in the call chain. So
> how about this as a replacement?

So just like -h returns PARSE_OPT_HELP and causes the calling
parse_options() to exit(129), the new _COMPLETE can be used to
trigger an early & successful return?

We'd also have to cover builtin/{blame,shortlog,update-index}.c
where they switch() on the return value from parse_options_step(),
but other than that, it probably is a better approach.  The users of
parse_options_step() that avoid parse_options() want to handle the
various "we stopped by hitting a non-option" cases in their own
ways, so treating this special action the same way as -h is treated
would be sensible.  We _might_ want to standardize some of the case
arms in these custom switch statements that appear in these three
built-in command implementations, but that can be done more easily
if this step is done like you showed below, I think.





> -- 8< --
> diff --git a/parse-options.c b/parse-options.c
> index 3b874a83a0..6932eaff61 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -516,7 +516,7 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
>  	show_negated_gitcomp(original_opts, -1);
>  	show_negated_gitcomp(original_opts, nr_noopts);
>  	fputc('\n', stdout);
> -	exit(0);
> +	return PARSE_OPT_COMPLETE;
>  }
>  
>  static int usage_with_options_internal(struct parse_opt_ctx_t *,
> @@ -638,6 +638,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  	case PARSE_OPT_HELP:
>  	case PARSE_OPT_ERROR:
>  		exit(129);
> +	case PARSE_OPT_COMPLETE:
> +		exit(0);
>  	case PARSE_OPT_NON_OPTION:
>  	case PARSE_OPT_DONE:
>  		break;
> diff --git a/parse-options.h b/parse-options.h
> index 6c4fe2016d..a650a7d220 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -208,6 +208,7 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
>  /*----- incremental advanced APIs -----*/
>  
>  enum {
> +	PARSE_OPT_COMPLETE = -2,
>  	PARSE_OPT_HELP = -1,
>  	PARSE_OPT_DONE,
>  	PARSE_OPT_NON_OPTION,
> -- 8< --
