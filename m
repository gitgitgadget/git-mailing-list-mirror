Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3321F404
	for <e@80x24.org>; Fri, 24 Aug 2018 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeHXLbR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 07:31:17 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36145 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeHXLbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 07:31:16 -0400
Received: by mail-wm0-f50.google.com with SMTP id j192-v6so734049wmj.1
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Y0kXtzNUyeb0yeG9cZYy67RaSaL3B9VM2hRwL361NxI=;
        b=Ud2czkhcXYNu7HgZ/Ho5uPtkpGhiAncOEE+VgUUPJYl8useq25aQCsUv8YWjaUU8tW
         tFecgNau4a6kXQw5hU7qyAeGURUiaIvRBhCkw2doerWBbZt6ddCBwif8e55rK2UCo27F
         wz/4XXDa/0WodJxTvLEJdjgtIhoWPLSthYuIWmskPNXe8ZYqkgEHqziaTwHsRZdFw8R8
         MGEsWsvpfzrbRJxKR8tzPRuzOI8Du7NY4mr6z4pU9ClIV596pXaj/XibY8vhS7LrMLX8
         bqUT4i5CgUheRJ0njvD8B0qXXwhn4cl4XBgrdQuCCFJqOCCbai0RvCNaLnofBk0Ti/Mm
         zFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Y0kXtzNUyeb0yeG9cZYy67RaSaL3B9VM2hRwL361NxI=;
        b=DHbN9t5WsSwH3vb2ChRn/yUuh1xpuNoB/IfVsIGo2YrY3FncgbBqdmClXEqQThGRWi
         j1yw3W2oNzy8IZJKsPM6EixEwHwzwRSvIGTzVGFz2WbthAmq+HedB3FcUd6F00WUM0Jn
         XUIq4RPbe87/tzMMzf/V711A8sEkPyTQYzE0FCutYiMKZp9XCgkv+E1Qik8hNuZ1xLrY
         v/pf4lF+94L1+DqvVGrTna/nGqVS27yH6jcykt0R/jf4i2YYqgOrT9+ZhcbO9/nBVdXa
         xu4rc/Vvne2asUq9pmY1DP6jZzyWxP732YATl6N47D/SdTgCt6+RVYeX+lmpMe5jkruM
         kUvQ==
X-Gm-Message-State: APzg51BqwrKYMF9AxjHYbu5XGQmjznDli9nYd9nCbrh7RQu9dliF2+c4
        HBcOG2/L99kjMkwNUUWnyyk=
X-Google-Smtp-Source: ANB0Vdag/KU4lWbJh0UObKQoK+d6q8+nEPzWCbNynktCF82VccNnFkZ7i8RzaZV36oJHjvONVjc9jw==
X-Received: by 2002:a1c:8c49:: with SMTP id o70-v6mr621663wmd.11.1535097467606;
        Fri, 24 Aug 2018 00:57:47 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id 204-v6sm1162159wmh.25.2018.08.24.00.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 00:57:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Steffen Mueller <smueller@cpan.org>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
References: <20180822030344.GA14684@sigill.intra.peff.net>
        <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
        <20180822152306.GC32630@sigill.intra.peff.net>
        <20180823012343.GB92374@aiede.svl.corp.google.com>
        <20180823021618.GA12052@sigill.intra.peff.net>
        <20180823034707.GD535143@genre.crustytoothpaste.net>
        <20180823050418.GB318@sigill.intra.peff.net>
        <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
        <20180823185317.GA12534@sigill.intra.peff.net>
        <4b0168ee-4826-1f14-fc83-04c4cec18687@gmail.com>
        <20180824065625.GA10556@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180824065625.GA10556@sigill.intra.peff.net>
Date:   Fri, 24 Aug 2018 09:57:44 +0200
Message-ID: <87zhxcdwnb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 24 2018, Jeff King wrote:

> On Thu, Aug 23, 2018 at 04:59:27PM -0400, Derrick Stolee wrote:
>
>> Using git/git:
>>
>> Test v2.18.0 v2.19.0-rc0 HEAD
>> -------------------------------------------------------------------------
>> 0001.2: 3.10(3.02+0.08) 3.27(3.17+0.09) +5.5% 3.14(3.02+0.11) +1.3%
>>
>>
>> Using torvalds/linux:
>>
>> Test v2.18.0 v2.19.0-rc0 HEAD
>> ------------------------------------------------------------------------------
>> 0001.2: 56.08(45.91+1.50) 56.60(46.62+1.50) +0.9% 54.61(45.47+1.46) -2.6%
>
> Interesting that these timings aren't as dramatic as the ones you got
> the other day (mine seemed to shift, too; for whatever reason it seems
> like under load the difference is larger).
>
>> Now here is where I get on my soapbox (and create a TODO for myself later).
>> I ran the above with GIT_PERF_REPEAT_COUNT=10, which intuitively suggests
>> that the results should be _more_ accurate than the default of 3. However, I
>> then remember that we only report the *minimum* time from all the runs,
>> which is likely to select an outlier from the distribution. To test this, I
>> ran a few tests manually and found the variation between runs to be larger
>> than 3%.
>
> Yes, I agree it's not a great system. The whole "best of 3" thing is
> OK for throwing out cold-cache warmups, but it's really bad for teasing
> out the significance of small changes, or even understanding how much
> run-to-run noise there is.
>
>> When I choose my own metrics for performance tests, I like to run at least
>> 10 runs, remove the largest AND smallest runs from the samples, and then
>> take the average. I did this manually for 'git rev-list --all --objects' on
>> git/git and got the following results:
>
> I agree that technique is better. I wonder if there's something even
> more statistically rigorous we could do. E.g., to compute the variance
> and throw away outliers based on standard deviations. And also to report
> the variance to give a sense of the significance of any changes.
>
> Obviously more runs gives greater confidence in the results, but 10
> sounds like a lot. Many of these tests take minutes to run. Letting it
> go overnight is OK if you're doing a once-per-release mega-run, but it's
> pretty painful if you just want to generate some numbers to show off
> your commit.

An ex-coworker who's a *lot* smarter about these things than I am wrote
this module: https://metacpan.org/pod/Dumbbench

I while ago I dabbled briefly with integrating it into t/perf/ but got
distracted by something else:

    The module currently works similar to [more traditional iterative
    benchmark modules], except (in layman terms) it will run the command
    many times, estimate the uncertainty of the result and keep
    iterating until a certain user-defined precision has been
    reached. Then, it calculates the resulting uncertainty and goes
    through some pain to discard bad runs and subtract overhead from the
    timings. The reported timing includes an uncertainty, so that
    multiple benchmarks can more easily be compared.

Details of how it works here:
https://metacpan.org/pod/Dumbbench#HOW-IT-WORKS-AND-WHY-IT-DOESN'T

Something like that seems to me to be an inherently better
approach. I.e. we have lots of test cases that take 500ms, and some that
take maybe 5 minutes (depending on the size of the repository).

Indiscriminately repeating all of those for GIT_PERF_REPEAT_COUNT must
be dumber than something like the above method.

We could also speed up the runtime of the perf tests a lot with such a
method, by e.g. saying that we're OK with less certainty on tests that
take a longer time than those that take a shorter time.


>> v2.18.0 v2.19.0-rc0 HEAD
>> --------------------------------
>> 3.126 s 3.308 s 3.170 s
>
> So that's 5% worsening in 2.19, and we reclaim all but 1.4% of it. Those
> numbers match what I expect (and what I was seeing in some of my earlier
> timings).
>
>> I just kicked off a script that will run this test on the Linux repo while I
>> drive home. I'll be able to report a similar table of data easily.
>
> Thanks, I'd expect it to come up with similar percentages. So we'll see
> if that holds true. :)
>
>> My TODO is to consider aggregating the data this way (or with a median)
>> instead of reporting the minimum.
>
> Yes, I think that would be a great improvement for t/perf.
>
> -Peff
