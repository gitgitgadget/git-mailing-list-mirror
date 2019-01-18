Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65CB1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfARSf0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:35:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54812 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfARSf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:35:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so5407440wmh.4
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5Prfi6Skq8S5Kgr8D1n+LNt5HVtrPzmmKo4YkYOk2mU=;
        b=CSRMSPItfZT5waYPdQ6dcajph8RNXH2jcwAuQxTyTjYEHoC0HcQUwLyoZXnzvjOzcN
         GWoIi7/853Eyf2bvrGMUIUwCbebHj1PGur7ued1vLsgFPXMUpButmPujs4J6rmz3lvq5
         McGSOoV+Fm8ajhTmt5fDSnhvfkaf/ut15MS55VcjQxfD1WjeYQ29y2OzKS0x0sylKpjr
         Q7e4WC1x1a4fehXEmAocQgRXQAsXS245zGAheVgSbizyP50D/XUO89lloEEHP8NRo0R3
         7FLpey7RKP484tQr5XC01oVjdSxWovAHdczWonl/J15hMTVchP9cL/II+c8/nO45qt/F
         1BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5Prfi6Skq8S5Kgr8D1n+LNt5HVtrPzmmKo4YkYOk2mU=;
        b=hEfrXQfmo2GW666pOyOiIV9COSC8JVYZv++ta+ez9GcFsKRc1g6jTOUYTPoZOWEIGt
         OXgcApXEBv8GeO9Wjki4Vwt/S1m+2ZmLrp7WBLdleyst/NiAA5UR3gotK6EoDX9AHhdq
         fcUNkgUxGZdR5PaTX689bNXzJ4ufQ7/2btqs9/gsexe/eVHYPduUKcuG1bOxIA9c0Lvy
         AvWKx8MbgOwj5n3+zu9t3VN17rF0b3TR6wWbpm7vqOvC857KCAlZ9/11n/b9wuHs7Wlv
         qg0eeNZHMOJpYalEpMsrAlnZpJlnd/1jHeLWdELQfYjAnBSUax6ohL7Rzux/ymNlV6ht
         +vaQ==
X-Gm-Message-State: AJcUukd5ZhX6csIqR29ohjRQC/WFC5HG/SpAjr1TwxBimEg61hjOQ2pQ
        DwiupYHsRbENCSiEsYWl0AA=
X-Google-Smtp-Source: ALg8bN7UKOiKeQmpKTqvj1Vb2IfWQ/YxqkgIeJN4GQP934RRKlYj0n7PrWwTjQXsWb+KcT7da8qqww==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr16621580wmc.35.1547836523642;
        Fri, 18 Jan 2019 10:35:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k23sm29067084wmj.32.2019.01.18.10.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 10:35:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/5] Remove the proposed use of auto as secondary way to specify human
References: <20181231003150.8031-1-ischis2@cox.net>
        <20190118061805.19086-1-ischis2@cox.net>
        <20190118061805.19086-3-ischis2@cox.net>
Date:   Fri, 18 Jan 2019 10:35:22 -0800
In-Reply-To: <20190118061805.19086-3-ischis2@cox.net> (Stephen P. Smith's
        message of "Thu, 17 Jan 2019 23:18:02 -0700")
Message-ID: <xmqq5zullsph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> In addition to adding the 'human' format, the patch added the auto
> keyword which could be used in the config file as an alternate way to
> specify the human format.  Removing 'auto' cleans up the 'human'
> format interface.
>
> Instead add 'auto:human' date mode which defaults to human if we're
> using the pager.  So you can do
>
> 	git config --add log.date auto:human
>
> and your "git log" commands will show the human-legible format unless
> you're scripting things.

I think doing two things in this step (i.e. reverting Linus's "auto"
support from 1/5, and adding "auto" that is similar to color's auto)
is OK, but then the title should list both.  It sounded like it was
this step is doing only the former.

>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>  date.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/date.c b/date.c
> index a8d50eb206..43c3a84e25 100644
> --- a/date.c
> +++ b/date.c
> @@ -883,11 +883,6 @@ int parse_date(const char *date, struct strbuf *result)
>  	return 0;
>  }
>  
> -static int auto_date_style(void)
> -{
> -	return (isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
> -}
> -
>  static enum date_mode_type parse_date_type(const char *format, const char **end)
>  {
>  	if (skip_prefix(format, "relative", end))
> @@ -907,8 +902,6 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
>  		return DATE_NORMAL;
>  	if (skip_prefix(format, "human", end))
>  		return DATE_HUMAN;
> -	if (skip_prefix(format, "auto", end))
> -		return auto_date_style();
>  	if (skip_prefix(format, "raw", end))
>  		return DATE_RAW;
>  	if (skip_prefix(format, "unix", end))
> @@ -923,6 +916,14 @@ void parse_date_format(const char *format, struct date_mode *mode)
>  {
>  	const char *p;
>  
> +	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
> +	if (skip_prefix(format, "auto:", &p)) {
> +		if (isatty(1) || pager_in_use())
> +			format = p;
> +		else
> +			format = "default";
> +	}
> +
>  	/* historical alias */
>  	if (!strcmp(format, "local"))
>  		format = "default-local";
