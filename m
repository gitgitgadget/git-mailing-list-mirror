Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF001F424
	for <e@80x24.org>; Sun, 22 Apr 2018 21:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeDVVs5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 17:48:57 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:46220 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeDVVs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 17:48:56 -0400
Received: by mail-wr0-f174.google.com with SMTP id d1-v6so35965950wrj.13
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LCQbBRM1D0OC6C4Fi3rpQn5DCVm9wvtic5SJQWSXHaA=;
        b=uyXUBbcyydT2FJXRjq9BvbaeMwg2QhTQbZ87vTipIn2K9PaSoP3dEBvyZjQm+h1vM0
         1u4ZBn+Qup8G+xwD9BEmnzioKIMrs++ldBKWbU7/r63aRIPkMysghMPbqxOCllnMXJDU
         haDizKdDwvX+HYLbGafDONE2S0syqgiV/SgDgFcogHDkHqt6BMQrAh8DC1wuCjBBns/P
         S3FvAyRlLZqfmodTV2BRuvrxJQ+vB4GvAy90kp1Y8DBw3I3JEXz5HJQnyeTni7GAZIua
         LuosYpXR8FPAHTc+Reh9OcDIQV66AsFZQcFKZzW3A96davTzdg3Yof5hpNwWlinXE6R5
         tEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LCQbBRM1D0OC6C4Fi3rpQn5DCVm9wvtic5SJQWSXHaA=;
        b=Fw+GKFm9CJfakk4OOOmdIs87ysL/OlTHyEA/zFWA8mAXbZXDFEVcD6/rtp6TRzQAp0
         QgZWf4WXUUY85RCb+7+bNa9gw5QmI0V76mBioSSCzQtKmDEMz9jNEs1g+/ud8tsfpYvz
         NONBW1aK51M6fVhSzqIPW20Rhl1TPYlep7PvOujKCF6hYTegzpjJAxNlaRtEC+bZVlOc
         KEXuX5X/tNFdEdQOODh8s/8V/7Ab3SWkZp5LrXNwaadENSZS3e4pzyg+XwO/hQqkKmeA
         bU9i02qZbaB4NitS5aFGSI5ngs9JXzAUyoF7z7WJhoi48Y53U1KlO/dN4pN3cznKGWZn
         EbcA==
X-Gm-Message-State: ALQs6tAM02YcngXoCQ/WFuAxDQtkgHqhnoSWx4cMQfeF72IS8kvQZbsN
        h0ApM14dYPF++8/DX7NRxAWAefrP
X-Google-Smtp-Source: AIpwx48yuK/wWW53iZ49lCp2NAN0ffmrhjVrmb9dXfJGhMgoEYhyEIaXg/tsXLkuuStKqJlltGfOoQ==
X-Received: by 10.80.247.136 with SMTP id h8mr25474646edn.37.1524433735166;
        Sun, 22 Apr 2018 14:48:55 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id n3sm6741107edl.27.2018.04.22.14.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 14:48:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 5/6] builtin/grep.c: show column numbers via --column-number
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com> <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
Date:   Sun, 22 Apr 2018 23:48:53 +0200
Message-ID: <878t9eewu2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 22 2018, Taylor Blau wrote:

I think this part though...

> While we're at it, change color.grep.linenumber to color.grep.lineNumber
> to match the casing of nearby variables.
> [...]
> -`linenumber`;;
> +`lineNumber`;;

Makes sense as its own patch at the beginning of the series, since it's
just related cleanup.

> +`columnNumber`;;
> +	column number prefix (when using `--column-number`)

Here you're using --column-number...

> +grep.columnNumber::
> +	If set to true, enable `-m` option by default.

...But not here. This needs to be updated

> +grep.columnNumber::
> +	If set to true, enable `-m` option by default.
> +

...ditto.

> +--column-number::
> +	Prefix the 1-indexed column number of the first match on non-context lines.
> +
> [...]
>  		OPT_GROUP(""),
>  		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
> +		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column numbers")),

Maybe "show first matching column"? I.e. the main docs say "just shows
the first", but this seems to give a different impression.

It would also be nice if the docs briefly explained what this is for,
i.e. the git-jump use-case.
