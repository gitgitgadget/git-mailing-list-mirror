Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DDB1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeDECss (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:48:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34436 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDECss (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:48:48 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so17128894plq.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=boL4gfgHABu2I7R/Ccsc1cUtuLpeM+ZmCMlv1gDNExs=;
        b=osCq1LS1UMVBu8lbVMlgk0ZDYcTcmsNMyXQzKJWkD5nYStB/ooHCVgw5DwDo/bDwAU
         NaLbwPrYrAnAudQK1yK2h1dnCk36m8RnTwOdqYU45vEK6+mNnW1mGkr5PG3v3Y54jzCj
         i6HTDuVBJLqPiUdUcAKm0J5f9klyFB0PGOIFFwCBdzx/xso+177aht2eL4CY4YiP/UkX
         YSnc03V1CiG7gMFhz9LyXgRNERmp1X1rQctoR9hX7ht1fQvIZvrOEBol4cxaxioR3A0j
         dLoW7TCVAR62fleTspmdVKk5FQv4KflX6C4zpiNz6qaznleuWEDoIqfZLJA08zdvRjDo
         kqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=boL4gfgHABu2I7R/Ccsc1cUtuLpeM+ZmCMlv1gDNExs=;
        b=OBGP/D5m0S+XhqhynAQkWVyMKkvcu/233B6ewkELHwcEthE7d+MV3bfid9vsamS2L+
         q3DrDXEmbDmCSVU/GX/BfTxv5e6xUeZ8wYF+lQs1VOA18YtYobIMFaSZ7R3lqL929Tfh
         NzlnyIDUTZRSrxlwm/TOahiCeCxrvyoZbSVLx/7aasyLsx1ciouEMPz4lNtSXbz/zBtx
         cwkIKSmyQoYXuhD5zwPiF6Gl3hydWh7v8xH3mUHQEAGh0sGHzcLLxci/Dl64rc+dXvI2
         nFNAYDR7I1Aex2Tx+aLfjg34GO8olHrKhXwc1Wi0R5keaiIEtmtKFHLT5VA6T2pYbHq9
         Y5Ig==
X-Gm-Message-State: AElRT7FQ7YNDAmonFR1mnrQWOJZu3m6Dk4+/YcwHn64H5aUih8CU4GBC
        d6ktwFluU1BbzltsV6Njuk4+3s+n9GBAEQ==
X-Google-Smtp-Source: AIpwx4+wOsJs+N7S6J9e+EB8Sr+0Ad+HaWnTO2NPXFSmJls7klyob6jHxkkQ9lcuhAqFqWZwKsbzPA==
X-Received: by 2002:a17:902:a582:: with SMTP id az2-v6mr21428468plb.37.1522896527334;
        Wed, 04 Apr 2018 19:48:47 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id p21sm1297417pgv.4.2018.04.04.19.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:48:46 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:48:45 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180405024845.GD31883@syl.local>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
 <20180329011634.68582-4-me@ttaylorr.com>
 <xmqqtvsx3060.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvsx3060.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 11:09:43AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -184,6 +183,7 @@ Valid `[type]`'s include:
> >  --bool-or-int::
> >  --path::
> >  --expiry-date::
> > +--color::
> >    Historical options for selecting a type specifier. Prefer instead `--type`,
> >    (see: above).
> >
> > @@ -223,6 +223,9 @@ Valid `[type]`'s include:
> >  	output it as the ANSI color escape sequence to the standard
> >  	output.  The optional `default` parameter is used instead, if
> >  	there is no color configured for `name`.
> > ++
> > +It is preferred to use `--type=color`, or `--type=color --default=[default]`
> > +instead of `--get-color`.
>
> Wasn't the whole point of the preliminary --type=<type> patch to
> avoid having to add thse two hunks?

For the first hunk, yes, but not for the second. The series that adds
"--type=<type>" was meant to make it possible to say "parse this as a
color" without squatting on the "--color" flag.

So, including "--color" in the list of historical options is a mistake.
But, using "--type=color --default=..." over "--get-color" is the
desired intention of this series.


Thanks,
Taylor
