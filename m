Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18871F404
	for <e@80x24.org>; Fri,  6 Apr 2018 06:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeDFGFH (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:05:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43512 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFGFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:05:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id j2so37339pff.10
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzbzFcjqdKJJF39fOXwU2k97N2bQXq6Q7BrmkZOSg34=;
        b=ziMO76JzVC4w+lu2X5tahL0Nr5RYxeiEEVtUhQY75Qfx7+/tkqCgdhM5zyj8KlCHl2
         XXEhOIv8fAWaVr8PN9EkEjv7dltizock6cKR/DpywoDUTRxdKEXzec/oMmN2IK5pWgMO
         GamfkDSXlv5Y/PTyWkPauSapHDbfuS8/+lAxgDK4059MIas17xmtjplOn91Or5I9uJhp
         tulxr5hzAqPkr50Usw+K+1Ggi7DYpKV4pxvyGX6GFRLebma2e/Aj7HOtUr1Ctly5oVx4
         slxFqx3qhhLDRHiZnHMZ8LSjrSMnrjqU+TlFHYaD2hC5kCD9VwndtSBkMWWEBQEBmz/W
         N2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzbzFcjqdKJJF39fOXwU2k97N2bQXq6Q7BrmkZOSg34=;
        b=IK6PEKHXeDqPq2fSxtA93g/WGDRgJlbLCNDMDt5P+c3druYKmNNFEz1QaXLMzolAvc
         Fhj2JJxLyj/x8zbp4//NiWTm6JxicFqMsU6VAXWwdV8YhdmxwLj45faobpblrjmteRNb
         8xh4zFSvzBz7MRcC9esfti/kJemMsEc/k6ftiuZ+0JLnJsehkj7B05ltTVOF4cplF+2o
         vg9xJBtR6TMA9TQMn4TCxkS3LaOzqNH6UphPgCzgQYFdpdIMJl+WFD937fSlSY6UuL4X
         cHwsNcCkUmw5qIQpFd1aPx7CanCvzHFjQ7nP61HFKx6HxlDdM9xS1HCQlei1yQ+AIgsn
         DsqQ==
X-Gm-Message-State: AElRT7F5wxzlWdfo6tvgyRH86NtKFCtdXF56XBxMQ1yObF6kOq2KPQEH
        wd5HHtTp7Q+1NAwhEABFb3LFeg==
X-Google-Smtp-Source: AIpwx49gzjQUiSwWhkRT15z0gt891wm80yCJclZmBVdh3iQbraESjj07/9msMvOQM2+OR74X0lMOQw==
X-Received: by 10.99.43.70 with SMTP id r67mr17157594pgr.422.1522994706107;
        Thu, 05 Apr 2018 23:05:06 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id b5sm17726496pfc.87.2018.04.05.23.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:05:05 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:05:04 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180406060504.GD62593@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025917.GD49902@syl.local>
 <20180405223620.GD29117@sigill.intra.peff.net>
 <CAPig+cQoTQ47n13q3t5MMS+UZQR6jbFDpVSP8Z=L4qckjrsxeQ@mail.gmail.com>
 <20180405225320.GA10913@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405225320.GA10913@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:53:20PM -0400, Jeff King wrote:
> On Thu, Apr 05, 2018 at 06:52:29PM -0400, Eric Sunshine wrote:
>
> > On Thu, Apr 5, 2018 at 6:36 PM, Jeff King <peff@peff.net> wrote:
> > > On Wed, Apr 04, 2018 at 07:59:17PM -0700, Taylor Blau wrote:
> > >> +     if (type == TYPE_COLOR) {
> > >> +             char v[COLOR_MAXLEN];
> > >> +             if (!git_config_color(v, key, value))
> > >> +                     /*
> > >> +                      * The contents of `v` now contain an ANSI escape
> > >> +                      * sequence, not suitable for including within a
> > >> +                      * configuration file. Treat the above as a
> > >> +                      * "sanity-check", and return the given value, which we
> > >> +                      * know is representable as valid color code.
> > >> +                      */
> > >> +                     return xstrdup(value);
> > >> +             die("cannot parse color '%s'", value);
> > >> +     }
> > >
> > > And this returns the original. Good.
> >
> > It's entirely subjective, but I find this easier to read and
> > understand when written like this:
> >
> >     char v[COLOR_MAXLEN];
> >     if (git_config_color(v, key, value))
> >         die("cannot parse color '%s'", value);
> >
> >     /*
> >      * The contents of `v` now contain an ANSI escape
> >      * sequence, not suitable for including within a
> >      * configuration file. Treat the above as a
> >      * "sanity-check", and return the given value, which we
> >      * know is representable as valid color code.
> >     */
> >     return xstrdup(value);
>
> It may be subjective, but I happen to agree with you.

I agree, too :-). I have changed this in the forthcoming re-roll.

Thanks,
Taylor
