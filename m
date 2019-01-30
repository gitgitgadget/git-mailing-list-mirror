Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EB91F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbfA3TcO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:32:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43305 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfA3TcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:32:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so569821lji.10
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8xjdkDFFE2fGjLjYrYYZWK7JNPFyPPHe2kOQrE0/LZY=;
        b=K9FEPPGv4MCt829H8hRmpLfEDOEC69DYSKb0nzj28a1q8s4HLfXCFhcYOUT9CgL7ke
         7oQlIRApKNlNMO89Lvo0vojBN+4gdt0eENffOVi+rsgx2QWhyCjrvlJgkOhrqVqMDSnh
         u2rClX21pIFyM9RcKF39WNdys24UlX2K/GiGZqoQJIzXyQzlbFkWoVUQK7Z6HWLNdSq6
         bYUCYJ1HCAzOjclQ1paL9hmtE6Oo+c3b8zcSrctdKU1h9Yfw8XBvgj//SQXq1GqbJ+fS
         PrdLkdn6gUPDXIM/kyHm1LXdukYplZ/IpV2XDg8f77FQ91a1pQWVbGZbz7v5hVUrLAPU
         tovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8xjdkDFFE2fGjLjYrYYZWK7JNPFyPPHe2kOQrE0/LZY=;
        b=ldwyzejzybCNjDPhKkKX4wp5/BbNNzpUtZmLedcjZaRPdHTxmByi0DSENRkkDPe3VM
         QBNgsMezx8Te25FTMaH9K0VH7QNxTG7N650CGSFs2gq+UfElNyLq5polnF+0eEhG1dRD
         rrKf0X7P5BdGHGGYVTHgwtUjk4aZKtz8fBdGv/Tj0WINU76OuhojC+dMGXA5Ajhl8US1
         vyEoB3Gocq0SnZbkyn01+8rGkYcIyd1ZhlzMOPK8gNbZb0O1C7VNw6tVHVlm+vM4UnRJ
         n8I+l+ETxhfrVGIqcd4z9AZQ5O+BcHM5OzYIHrxYb4r5SNP0Xr8h+iaXBig2DqhqCyWU
         u0RQ==
X-Gm-Message-State: AHQUAuamib7U8nWmFq9E0LabNNnn4n1SPWYF9srJ5/YiUBz9fYuUCUzO
        JHJuk5jb89fsXJG+XkOwNls=
X-Google-Smtp-Source: AHgI3IagAXap2qj7ZpFdUviBMtLyTDPZhT6JrPYfyLeH9bwJNHvg39WihKWYSq3AkJtX7VBPIldeLg==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr219637ljj.102.1548876731546;
        Wed, 30 Jan 2019 11:32:11 -0800 (PST)
Received: from evledraar ([62.119.166.9])
        by smtp.gmail.com with ESMTPSA id t9-v6sm411203ljj.87.2019.01.30.11.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:32:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com> <20190129160030.GA7083@sigill.intra.peff.net> <87zhrj2n2l.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1901301317120.41@tvgsbejvaqbjf.bet> <87y3722sz7.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1901301935010.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1901301935010.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 20:32:08 +0100
Message-ID: <87womm2b7r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 30 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 30 Jan 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Jan 30 2019, Johannes Schindelin wrote:
>>
>> > On Tue, 29 Jan 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> >> On Tue, Jan 29 2019, Jeff King wrote:
>> >>
>> >> > On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via
>> >> > GitGitGadget wrote:
>> >> >
>> >> >> From: Derrick Stolee <dstolee@microsoft.com>
>> >> >>
>> >> >> When running the test suite for code coverage using
>> >> >> 'make coverage-test', a single test failure stops the
>> >> >> test suite from completing. This leads to significant
>> >> >> undercounting of covered blocks.
>> >> >>
>> >> >> Add two new targets to the Makefile:
>> >> >>
>> >> >> * 'prove' runs the test suite using 'prove'.
>> >> >>
>> >> >> * 'coverage-prove' compiles the source using the
>> >> >>   coverage flags, then runs the test suite using
>> >> >>   'prove'.
>> >> >>
>> >> >> These targets are modeled after the 'test' and
>> >> >> 'coverage-test' targets.
>> >> >
>> >> > I think these are reasonable to have (and I personally much prefer
>> >> > "prove" to the raw "make test" output anyway).
>> >>
>> >> I wonder if anyone would mind if we removed the non-prove path.
>> >>
>> >> When I added it in 5099b99d25 ("test-lib: Adjust output to be valid T=
AP
>> >> format", 2010-06-24) there were still some commonly shipped OS's that
>> >> had a crappy old "prove", but now almost a decade later that's not a
>> >> practical problem, and it's installed by default with perl, and we
>> >> already depend on perl for the tests.
>> >
>> > It's not only about crappy old `prove`, it is also about requiring Perl
>> > (and remember, Perl is not really native in Git for Windows' case;
>>
>> We require perl now for testing, NO_PERL is just for the installed
>> version of git.
>
> Which is confusing, if you want to put it nicely.
>
>> If you change the various test-lib.sh and test-lib-functions.sh that
>> unconditionally uses "perl" or "$PERL_PATH" hundreds/thousands (didn't
>> take an exact count, just watched fail scroll by) tests fail.
>
> I know. Oh boy, I know.
>
> But we do not have to keep that status quo, nor do we have to make it
> worse.
>
> It would not surprise me in the least if we could accelerate our entire
> test suite by reducing our heavy reliance on scripting (including Perl) to
> the point that it really takes too little time *not* to run. (Right now,
> if you are on Windows, you better think twice before you start the test
> suite, it will easily take over 3h (!!!) to run in a regular developer
> setup. Even on a regular Mac, I would think twice before starting the run
> that blocks my machine for easily 20 minutes straight. Needless to say
> that few developers, if any, use it to validate their patches, in
> particular on Windows. Meaning: for all real purposes, the test suite is
> nearly useless on Windows.)
>
> So let's not bake *even more* Perl usage into our test suite. Thanks.
>
>> So my assumption is that anyone running the tests now has perl anyway,
>> and thus a further hard dependency on it won't hurt anything.
>
> By that token, the effort to turn many a script into a built-in for better
> performance and substantially better error checking would be totally
> nonsensical. "Because anyone running Git used those scripts anyway, so
> making them a hard dependency won't hurt anything"?
>
> I do not believe even a fraction of a second that that effort is
> nonsensical. Just like I do not believe even a fraction of a second that
> it makes sense for our test suite to rely on scripting so much. Or for us
> to make that reliance even bigger, for that matter.
>
>> > I still have a hunch that we could save on time *dramatically* by
>> > simply running through regular `make` rather than through `prove`).
>>
>> My hunch is that on the OS's where this would matter (e.g. Windows) the
>> overhead is mainly spawning the processes, and it doesn't matter if it's
>> make or perl doing the spawning, but I have nothing to back that up...
>
> I have at least the experience of several thousands runs of the test suite
> on Windows, together with a couple dozen hours spent recently *just* on
> making the CI of GitGitGadget at least bearable.
>
> So I do not quite understand why you offered a contrary opinion when you
> have nothing to back it up.
>
> I mean, I would really like to have an informed discussion with you, to
> benefit from your skills and from your experience to make the entire
> design of our test suite better (there is so much room for improvement, we
> should really be able to put together our knowledge to enhance it). It
> needs to be based on facts, of course.

Let's get some numbers then. On master, go to the "t" directory and run
this:

    for f in t[0-9]*.sh; do (echo '#!/bin/sh' && echo "echo ok 1 $f" && ech=
o sleep 1 && echo echo 1..1) >$f; done

That effectively turns all our tests into a "hello world" with a sleep
of 1 second.

Then run both:

    time prove -j12 t00[0-9]*.sh

And:

    time make -j12 t00[0-9]*.sh

For some value of -j12 and t00[0-9]*.sh. In my testing "make" is a bit
faster, but not by any amount that would matter when this is run for
real.
