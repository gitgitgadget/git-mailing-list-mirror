Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1669A1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfARSrY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:47:24 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36384 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfARSrX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:47:23 -0500
Received: by mail-wr1-f53.google.com with SMTP id u4so16301937wrp.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RbyVKCGW1lIRkStyrU+UB1roMzHjzyi07GFQzrlo/dc=;
        b=kM/7oGASCBCNEwybTkTf7IKvxEFNmaKY9lNqe+VlXsZzsVbTVaKUGIBEwzqTKVhKKq
         /SXYk3EM+zWbfh+Lj47waLQShKEZQTClsQdakTZoxtndVsyDHvTkQaHTcCMT3o5dRH4Q
         dTRilureEg7kXSeVAj7kGaetAnOWONQRyQnZjGQ/5rvBYYzGBRCvG0/NDeY57te13H6G
         HyuIzBneIrNFhKJWjIWJWS6egsQayNAOMEhpUXgCqSConVhYdC/x1h/rz/UD1lECueOg
         00x3bduW7ClajzDSMMP8RFkknh7hzFbi3mjJtpFB/ceHwOLwNBiCS4REUgyhSDxYNSL4
         uueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RbyVKCGW1lIRkStyrU+UB1roMzHjzyi07GFQzrlo/dc=;
        b=jmioIiLitb53KExDfsZhU6b3l2IJEWfM04FLntzNAQn+1KxGnaTuW1jihoNA4BQ/9c
         ymSjT5t0bVFEfJXs6AA7S+J79BdbApnO2UO4akNkCjGZ4tWMYH7e13UOfg1YuFhbBgzE
         sMGk/BGh05G/k22cmjavVwh3cPqLLhW3NyW2DMlNTnXJ2rrrwHyjtxZZa/ChHZTTVCFa
         ROGt5ZUXIsniMVZd2LJUMxvdRiMkWhHeZV9DFD47BoCKxyeZ/pPE429LWh/i8uz6eQeu
         Ah5SyfNgH8ESY7WOmVcjVkxh6FJGUHsEDupnSpvYLZ8lTds59vaQ02xw1eJFEIYN+ppQ
         DRRw==
X-Gm-Message-State: AJcUukeG4UnRwTh5SR053wW1KuquIkZZ2DxvFzvPXT0uzDP9y9IySaX5
        WSyDvWbDgFG9DsK/48oeAhs=
X-Google-Smtp-Source: ALg8bN7GbOPlJzXvkVLi9CenOldbnpVmvqdKvO5UQz9P1ST9qNGxPOJADY6L4hbxowK3v9lji9+q9w==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr17181028wrr.271.1547837241433;
        Fri, 18 Jan 2019 10:47:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b13sm79541138wrn.28.2019.01.18.10.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 10:47:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 3/5] Add 'human' date format documentation
References: <20181231003150.8031-1-ischis2@cox.net>
        <20190118061805.19086-1-ischis2@cox.net>
        <20190118061805.19086-4-ischis2@cox.net>
Date:   Fri, 18 Jan 2019 10:47:20 -0800
In-Reply-To: <20190118061805.19086-4-ischis2@cox.net> (Stephen P. Smith's
        message of "Thu, 17 Jan 2019 23:18:03 -0700")
Message-ID: <xmqq1s59ls5j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 90761f1694..1d2d932c76 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -193,6 +193,10 @@ log.date::
>  	`--date` option.)  Defaults to "default", which means to write
>  	dates like `Sat May 8 19:35:34 2010 -0500`.
>  
> +	If the format is set to "auto:foo", then if the pager is in
> +	use format "foo" will be the used for the date format, otherwise
> +	"default" will be used.
> +

This text is good, but this would break ASCIIdoc formatting,
wouldn't it?  Observe how "notes.displayRef::" section does
three-paragraph description and mimick it to make this two-paragraph
description, perhaps.

>  log.follow::
>  	If `true`, `git log` will act as if the `--follow` option was used when
>  	a single <path> is given.  This has the same limitations as `--follow`,
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index bab5f50b17..5d58f35d19 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -835,6 +835,12 @@ Note that the `-local` option does not affect the seconds-since-epoch
>  value (which is always measured in UTC), but does switch the accompanying
>  timezone value.
>  +
> +`--date=human` shows the timezone if it matches the current time-zone,

Is it clear in the context that "it" refers to "the timestamp being
shown"?

I think the behaviour is that timezone is shown only the timestamp
being shown is from a different timezone (i.e. if it *does* *not*
match), though.

> +and doesn't print the whole date if that matches (ie skip printing
> +year for dates that are "this year", but also skip the whole date
> +itself if it's in the last few days and we can just say what weekday
> +it was).
> ++

... and also omit hour/minute part for a timestamp that is old
enough.

>  `--date=unix` shows the date as a Unix epoch timestamp (seconds since
>  1970).  As with `--raw`, this is always in UTC and therefore `-local`
>  has no effect.
