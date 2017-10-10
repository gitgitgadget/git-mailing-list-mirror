Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50482036B
	for <e@80x24.org>; Tue, 10 Oct 2017 19:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbdJJTDT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 15:03:19 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:55179 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbdJJTDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 15:03:18 -0400
Received: by mail-pf0-f170.google.com with SMTP id m28so13266854pfi.11
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoWW6QuPZ4/+MV3YFJG3awuUlhTamE0TRzcWtLnwI/E=;
        b=noqXlzldgGFvqyv6tennkx86htn7g+/pHVZPi6X1NqJVuCvb2/HUYFBq0q3PTYBxb0
         YJTxIxY7EAQx4WkzR43x/G2Ynhgc4fgSR2DJJqrlur8W8yvqK1jmYKWH87gk3bo8hDrY
         iEoyIcU0U981vwFXHQ6DA7v6IA90GIjvve4yVHMYN0JmSz0ITIm2QxxiZ2ieDLemBhQQ
         a/LEapvalLXF9rprn20vn38hxfVAcoUdC10gIhEN8DGUr4/v6Ud/4NHSPMv7j39hNtPF
         NcUs0NfXTKQUfNIsn10jeqqRF8F8BdARKZw8+O/+IqI/Pn88pA+bpDcgyvtLaKdeA/kI
         Uh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoWW6QuPZ4/+MV3YFJG3awuUlhTamE0TRzcWtLnwI/E=;
        b=ek58x/uikLIoDfJvqBdslEncBsVnzeNOF19+BdAWqj8Um1mN29Uu7WAe8ZubLAWgo3
         0DlZlMIuHvtZ0kzDPGlV0jc3qtQGL2n+mqwyzt024yghKD/N0HdOrRnQCHV6j48MtCz1
         o9+zEc7UavUSREUd0LKTt5ExpJ7p8bIl2Mny2J1XqxkNC8XesLW48GcSmtuKhi2JpROg
         tNlu6zi9O9v1KnNsuGlINRDKXUQNTxSB1Qy1Gv9+rBh2SC2fJ80iiTYEtO1ITlP+GH1O
         qlx3cqLHZG446rWcOp1z1NaUBU2liXjeT+H3RiEeySy4vGXVatL/+2b2GwjZd09dDENP
         wKMA==
X-Gm-Message-State: AMCzsaUTXNgVtbA7UWs4C4S3WHJ4BH2sGOcUSwTkWPpEsYS5hb6R+Llq
        Yi7lzYLzXYYKmjP3JilIgPk=
X-Google-Smtp-Source: AOwi7QBgV5dkFaiJeSEk018nR12isGB32auFe35ZTFVYOTGx7rLq/M+SIP1P4IWf+jJcyGDDyAT27A==
X-Received: by 10.99.96.213 with SMTP id u204mr12996073pgb.377.1507662197529;
        Tue, 10 Oct 2017 12:03:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id k10sm17309745pgq.92.2017.10.10.12.03.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Oct 2017 12:03:16 -0700 (PDT)
Date:   Tue, 10 Oct 2017 12:03:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nazri Ramliy <ayiehere@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
Message-ID: <20171010190314.GW19555@aiede.mtv.corp.google.com>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com>
 <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
 <20171010005942.GO19555@aiede.mtv.corp.google.com>
 <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
 <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net>
 <xmqqfuarp3mt.fsf@gitster.mtv.corp.google.com>
 <20171010130602.ivhsbu2ymnzt7gko@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010130602.ivhsbu2ymnzt7gko@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Tue, Oct 10, 2017 at 09:51:38PM +0900, Junio C Hamano wrote:

>> I think the right fix to the original problem (you cannot remove
>> auto-color from the plumbing) is to stop paying attention to color
>> configuration from the default config.  I wonder if something like
>> this would work?
>>
>>  - Initialize color.c::git_use_color_default to GIT_COLOR_UNKNOWN;
>>
>>  - When git_color_config() is called, and if git_use_color_default
>>    is still GIT_COLOR_UNKNOWN, set it to GIT_COLOR_AUTO (regardless
>>    of the variable git_color_config() is called for).
>>
>>  - In color.c::want_color(), when git_use_color_default is used,
>>    notice if it is GIT_COLOR_UNKNOWN and behave as if it is
>>    GIT_COLOR_NEVER.
>>
>> Then we make sure that git_color_config() is never called by any
>> plumbing command.  The fact it is (ever) called can be taken as a
>> clue that we are running a Porcelain (hence we transition from
>> UNKNOWN to AUTO), so we'd get the desirable "no default color for
>> plumbing, auto color for Porcelain", I would think.
>
> Yes, I think that's the simplest way to implement the "plumbing should
> never do color without a command-line option" scheme.
>
> I do wonder if people would end up seeing some corner cases as
> regressions, though. Right now "diff-tree" _does_ color the output by
> default, and it would stop doing so under your scheme. That's the right
> thing to do by the plumbing/porcelain distinction, but users with
> scripts that use diff-tree (or other plumbing) to generate user-visible
> output may unexpectedly lose their color, until the calling script is
> fixed to add back in a --color option[1].

I think it's better for the calling script to be fixed to use "git
diff", since it is producing output for the sake of the user instead
of for machine parsing.  That way, the script gets the benefit of
other changes like --decorate automatically.

So I don't see that as a regression.

Where I worry is about commands where the line between porcelain and
plumbing blur, like "git log --format=raw".  I actually still prefer
the approach where "color.ui=always" becomes impossible to express in
config and each command takes a --color option.

If we want to be extra fancy, we could make git take a --color option
instead of requiring each command to do it.

To support existing scripts, we could treat "-c color.ui=always" as a
historical synonym for --color=always, either temporarily or
indefinitely.  Making it clear that this is only there for historical
reasons would make it less likely that other options make the same
mistake in the future.

Thanks,
Jonathan
