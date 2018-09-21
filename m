Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F8A1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeIVFVs (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:21:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42020 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeIVFVs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:21:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so11953543edw.9
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yhnYaxdtlZHH77DI4D0dIMA7u2bKSgJPLevpCghviug=;
        b=s4K7PMB2zjRwGk88wP6ja230oDGc/brR1VLP60dgVE41ENtOwoPevScYBxoex4YQqZ
         JvOkU5iaVKnYVApLEu7QVZPmeAhrmXuTpPtH5flufKpAph7TwdcEXyHazAqtJxFsieLJ
         to5Tqsov2/dEsxrpBbDJwCrqwebb7PQeQCPMIS+tx6a87IwQbl6lZiZi8/i/mY9MiQ2X
         86Frd6hGIp8IOUx2Q3QQdDFKrg/58cU1iAYNcl1HMnDvUj6l+7Y/B3QKNmymrXFD21J8
         DzUuX8A2jXIEcJjNvbmJ3y97PwntxgATI9xsirDlr97UbnWvPl6aRVy/ZFRU1+WXps5S
         K2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yhnYaxdtlZHH77DI4D0dIMA7u2bKSgJPLevpCghviug=;
        b=Z69tUxCVlFEV7nz+AAOFkGlkE7qGU5jZuK21uEqTkSZZBSD47Fgry77IT1I/3RvpmR
         8CtiOBe8loCv0BZ7U9wVgEygLJlDeWIneQzaVx6lt9HjyzYQKlyUSy2B9ZHGmllrAl/S
         C3pOTWkdg+xtOWjzZqWYCr2kugXb8vD6qWnW4FTxImejnd1IkWDmS8bzpKW9f/TETx6S
         2F19yHi0Vz7AjMNdEBo2kHMvFWQEh7D2JK3o7wGCDBJb8jLxqkSBhhWk5BaXxGdu0kmL
         BO/Sl0zSxWK1RBKwQEJ/UaKZ3Hdu365HLQgfpP7nfBvclB7/jIcbljn4oKEuy4kXR5aG
         XAqQ==
X-Gm-Message-State: APzg51CiH7IC/YEEz7QNk6JShklkkJJI2Z5cXKKK80SerqQtg2eXDtB2
        ZSGCch4X5wv87xXHdFDfK3c=
X-Google-Smtp-Source: ACcGV60DHHoGAHLEz6kvdjkEIrxaw7exLjSHlEtlfbmY8Tz1d6sOau0SYRI+pyIi4hvZvslAtUSnOQ==
X-Received: by 2002:aa7:d386:: with SMTP id x6-v6mr21737edq.144.1537572639778;
        Fri, 21 Sep 2018 16:30:39 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id s7-v6sm2690116eda.19.2018.09.21.16.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:30:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Gniazdowski <psprint@zdharma.org>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Very simple popen() code request, ground-shaking functionality openned by it
References: <315083291.15466.1537536854535@privateemail.com> <20180921222454.GD11177@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180921222454.GD11177@sigill.intra.peff.net>
Date:   Sat, 22 Sep 2018 01:30:36 +0200
Message-ID: <87musajun7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 21 2018, Jeff King wrote:

> On Fri, Sep 21, 2018 at 09:34:14AM -0400, Sebastian Gniazdowski wrote:
>
>> Git default progress indicator for clone is very unattractive, IMO. It
>> does its job in providing all the operation details very well, but I
>> bet most of users strongly dream about a gauge box!
>>
>> Have a look at my gauge box constructed as git-stderr pipe script:
>> https://asciinema.org/a/202401
>>
>> The main point of my feature request is: git can add
>> core.progress_pipe option, where e.g. `/usr/local/bin/mygauge' will be
>> set (a script like the one in the asciinema), and then simply do the
>> ground-school-known `popen("/usr/local/bin/mygauge","r+")', and write
>> **unchanged current-progress data** to the pipe, then read from the
>> pipe and forward to `stderr', where the progress normally lands in.
>>
>> This will allow users to free their creativity and provide probably
>> dozens of custom Git progress bars.
>
> I don't personally feel that the existing progress bar is that bad, but
> if anybody wants to pursue this, I think the most sensible path is:

I don't think it's bad either, but one thing that's really neat about
Sebastian's suggestion is that it's using some UTF-8 terminal ASCII art
to render an actual progress bar.

It would be very cool if we had some "we can use non-ASCII for such art"
core.* option, similar to how we pushed the boundaries with what was
acceptable with pagers and having colors on by default (and perhaps we
could even turn such a non-ASCII mode on by default eventually...).

Duy's
https://public-inbox.org/git/20180920161928.GA13379@duynguyen.home/ is
another recent thing that reminded me of this, i.e. that suggested
"\\|/-" spinner could be made much neater with non-ASCII.

>   1. Add a trace_key for sending machine-readable progress output to a
>      descriptor or file. E.g., via setting GIT_TRACE_PROGRESS=2 in the
>      environment.
>
>   2. Teach the trace code to open a command for piping, so that you
>      could do something like GIT_TRACE_PROGRESS='|mygauge'.
>
> That would make your use case work, and I think many other use cases
> would benefit from both of those features independently.

Yup, that's all sensible, and would be great both for this and other
stuff if we wanted true extensibility for this sort of thing.

I'll just add that a 3rd thing that would also make sense would be to
add a feature to configure the value of these GIT_TRACE_*=* variables
via the .gitconfig, that's been suggested before (too lazy to dig up a
ML archive reference), and would make this as easy to configure as
Sebastian's suggestion.
