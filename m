Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A631F404
	for <e@80x24.org>; Wed, 29 Aug 2018 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeH2WJJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 18:09:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46195 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2WJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 18:09:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so4583912edr.13
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlM7AkCAoEOPL4gPJTh9XLWRVC2yNwW9kX4BV0R3L/w=;
        b=UGdwTQzmZGJOuSmGbGGZRBzkboAvAYxBy3jUQ1OsGIvGKVDlWVjoWYF8T+fv3H6SFq
         tmfVtUIJOd2xoV9LL9nzsKHMM7OHyad8axfDPBIK88FbbAVV3kHiMZI7mEz3hqqxbcGt
         EgrREdA1zLbi/V5n5eKwAfkPbeHJ6vBfDkjmitQNgmbcpjtgX7Jso2JdIs/tgLaLnmmJ
         LUdzvGS1s+uGs0aC/ZTZtyELCDyZzfbgyD6D39p1raRktSHH0jCwyFXd3MwrnUomVnoU
         6mNCp3dUsECxuMGbIY/mEi4m3TYXhoDSQmvyklvIjSe5z5g/hr1WojXcP7EIpqE0Wxca
         h4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlM7AkCAoEOPL4gPJTh9XLWRVC2yNwW9kX4BV0R3L/w=;
        b=l9/kMulJFsQD6rVMofI5IEnN0MNg0mRZ1qE3IcCG79tycsZb5rjGQ2YpJSoQzY5oEl
         hUJmFl1zfn09jvseJKUA3lT0JPcvnw0nwVNlCfSxU7UmJ/LNdrSH20cy/NHTur9OxT7+
         ZeFSsa+NcRcnScVd1IRXJ2JHWVITkoMxUsObuV/xPKgOcfALHmY3btscE/HwK2AEqtDc
         XeNdS0EvGJVKql5YYIQ+0md7NY/iE8PBs9nghcbCNcf9WzoiIK+rCo7jHYQunFrcHKrd
         t/XyYkE77sao/lO5jf7QJl7IStwcRlLU5NPLki3ayGNTIEZG0l8x/yZy5eDgRFyTTdHf
         BQmw==
X-Gm-Message-State: APzg51Csv4QG3BkhMwXs/MCmUQJ9iSkrq3kZsEz4D+Hzglx9/2MYkhyf
        10TVS056UUDlxfqCCpAZJweV87A82owGIjJSr583Zw==
X-Google-Smtp-Source: ANB0VdYo8htDejpCLlcRC/W3vbw4/GwH0gDmcRIgR5DqmNhhfI24UPaUVSktMdyGxlRXX5io5+R3yFt3WaKY8NEZzVY=
X-Received: by 2002:a50:cc0a:: with SMTP id m10-v6mr8766571edi.81.1535566262837;
 Wed, 29 Aug 2018 11:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
In-Reply-To: <20180829052519.GA17253@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 11:10:51 -0700
Message-ID: <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 10:25 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 28, 2018 at 02:35:25PM -0700, Stefan Beller wrote:
>
> > 3) (optional) instead of putting it all in modules/, use another
> >    directory gitmodules/ for example. this will make sure we can tell
> >    if a repository has been converted or is stuck with a setup of a
> >    current git.
>
> I actually kind of like that idea, as it makes the interaction between
> old and new names much simpler to reason about.
>
> And since old code won't know about the new names anyway, there's in
> theory no downside. In practice, of course, the encoding may often be a
> noop, and lazy scripts would continue to work most of the time if you
> didn't change out the prefix directory. I'm not sure if that is an
> argument for the scheme (because it will suss out broken scripts more
> consistently) or against it (because 99% of the time those old scripts
> would just happen to work).
>
> > > This is exactly the reason why I wanted to get some opinions on what the
> > > best thing to do here would be.  I _think_ the best thing would probably
> > > be to write a specific routine to do the conversion, and it wouldn't
> > > even have to be all that complex.  Basically I'm just interested in
> > > converting '/' characters so that things no longer behave like
> > > nested directories.
> >
> > Yeah, then let's just convert '/' with as little overhead as possible.
>
> Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
> colliding)?

I do. :(

2d84f13dcb6 (config: fix case sensitive subsection names on writing, 2018-08-08)
explains the latest episode of case folding with submodules involved.

> I'm OK if the answer is "no", but if you do want to deal with it, the
> time is probably now.

Good point. But as soon as we start discussing case sensitivity, we
are drawn down the rabbit hole of funny file names. (Try naming
a submodule "CON1" and obtain it on Windows for example)
So we would need to have a file system specific encoding function for
submodule names, which sounds like a maintenance night mare.

The CON1 example shows that URL encoding may not be enough
on Windows and we'd have to extend the encoding if we care about
FS issues.

Another example would be "a" and "a\b" which would be a mess
in Windows as the '\' would work as a dir separator whereas these
two names were ok on linux. This would be fixed with url encoding.

URL encoding would not fix the case-folding issue that you
mentioned above.

So if I was thinking in the scheme presented above, we could just
have another rule that is

  [A-Z]  -> _[a-z]

(lowercase capital letters and escape them with an underscore)

But with that rule added, we are inventing a really complicated
encoding scheme already.
