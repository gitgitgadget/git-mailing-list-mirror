Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627FB1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755297AbdLUUoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 15:44:04 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:44102 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbdLUUoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 15:44:03 -0500
Received: by mail-it0-f67.google.com with SMTP id b5so12076458itc.3
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q22kM+cvTdXQlQy9468oe7lehu0By2ICNN5FNusqdsk=;
        b=FimQJVd/Vi0wZzpE2rwr5exAuod5yHe7eFJ/MmGYcA2oJ0LsraqNaOThnMaQKENxAi
         2h6XGUkptFoexwxS3zYwBUiqti+h1Lh+X72j99Oy3hsk8zmYrwDvfRQUP+UsvGD2xa/h
         hjgQMtiy6C//aYPEPYNcRJq8rmwW/VC9qpCwxuCqNkuzJeYdPKX622IERxpZkrTJDFvz
         ZrxWtYGMcfUT0Qhbydg0I9MOgUfG0OSirETJ0sosz/I+gAPUs5E084OkJcfMsUHlvDoM
         gJt5Xth3eoLXzRLlPDNr6Q8SbNWmehQbSv66Rl1x6H6m66WZq45vLeE/sKquP41vPHi9
         nCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q22kM+cvTdXQlQy9468oe7lehu0By2ICNN5FNusqdsk=;
        b=Ar8bAkmZJdWSsNBYqFVuFSXqrOjsY5w6M/ImNchzsqujifnjcPfcyi25a+I51+iEaW
         9jrIB/8CsNg0N8x2fF+eQRvKe/f+ggjZChLs8Sq/R4BXLVT1xIkgp0M3Y63cAR/ErrI0
         yK+MmfSLjyxEA7tDQPKXVajLS03PGFeGsD5IPNCw1Tg9DD0Rt3IxlTxhG6syjn446EfS
         lou12GN8R9b88ah+QjPM9qZuiFQi86owtN/z2BjhHYl08nHaaqZSlxKQiCvt++20nTB3
         HB9TKM72eYx4hVeXHw9I2sDb2B3njeUN1Y6025JkhLd4n3ePQmRb+N9VesooL2FMR9Ni
         2Y0Q==
X-Gm-Message-State: AKGB3mKUyl9N3wkujxXJ1hDni1jmhFL610EwcbAHluzBpqh4VwGYHX9d
        zMZ+hUpJW+Gjyafg1CX5oOU=
X-Google-Smtp-Source: ACJfBouqggxmgJI0pnd/DpL2dlhR9viXkVD0BKRsR1llyopTV1UtlwM6l5xTbg1ywXpXYhTMv9OWbg==
X-Received: by 10.36.244.78 with SMTP id u14mr14734732iti.151.1513889042779;
        Thu, 21 Dec 2017 12:44:02 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a202sm4672932ita.3.2017.12.21.12.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Dec 2017 12:44:01 -0800 (PST)
Date:   Thu, 21 Dec 2017 12:43:56 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
Message-ID: <20171221204356.GA58971@aiede.mtv.corp.google.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171221190909.62995-2-git@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> Created core.aheadbehind config setting and core_ahead_behind
> global variable.  This value defaults to true.
>
> This value will be used in the next few commits as the default value
> for the --ahead-behind parameter.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/config.txt | 8 ++++++++
>  cache.h                  | 1 +
>  config.c                 | 5 +++++
>  environment.c            | 1 +
>  4 files changed, 15 insertions(+)

Not a reason to reroll on its own, but this seems out of order: the
series is easier to explain and easier to merge down in stages if the
patch for --ahead-behind comes first, then the config setting.

More generally, new commandline flags tend to be less controversial
than new config settings since they cannot affect a script by mistake,
and for that reason, they can go earlier in the series.

As a bonus, that makes it possible to include tests.  It's probably
worth adding a test or two for this new config setting.

[...]
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9593bfa..c78d6be 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -895,6 +895,14 @@ core.abbrev::
>  	abbreviated object names to stay unique for some time.
>  	The minimum length is 4.
>  
> +core.aheadbehind::
> +	If true, tells commands like status and branch to print ahead and
> +	behind counts for the branch relative to its upstream branch.
> +	This computation may be very expensive when there is a great
> +	distance between the two branches.  If false, these commands
> +	only print that the two branches refer to different commits.
> +	Defaults to true.

This doesn't seem like a particularly core feature to me.  Should it be
e.g. status.aheadbehind (even though it also affects "git branch") or
even something like diff.aheadbehind?  I'm not sure.

I also wonder if there's a way to achieve the same benefit without
having it be configurable.  E.g. if a branch is way behind, couldn't
we terminate the walk early to get the same bounded cost per branch
without requiring configuration?

Thanks,
Jonathan
