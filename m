Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A461F424
	for <e@80x24.org>; Tue,  3 Apr 2018 11:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeDCL2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 07:28:22 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51619 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755193AbeDCL2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 07:28:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id v21so33089829wmc.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AAXidTxylrRJUU/Pkh0tuUdl/jqbuL/prDWQHNvCOzg=;
        b=Ex80O98A4anKcvQTOzUNZQAzMduS6l3o/vGsBcRKzRsQb9AbqsSPGtKuc7ztATbbPk
         JN+xFx2T2/qJ2nnTw6v2AtakU6K/e3mL7M1ul06EPrY6+KDm4pHraaQzJXlFIRLbFIsX
         9qso3kZ75U/gVgXkU99Eua/VEhtXeKZp0euODBhQz6zoimaBfVgXgmelPiwFaDxmeZ2u
         /GyYa76fEb1d9L9tHvXl25LKcPc9J6LuvjOteTCQGVhFgcyBHQyjOPToa+jX7eUlOyVO
         9b2NdommCZLdxmWmIeNOSF9EAnYRElyClAZOceOZEPrQ3/WSgvVz3cRipJu4b4Q5lCzk
         bF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AAXidTxylrRJUU/Pkh0tuUdl/jqbuL/prDWQHNvCOzg=;
        b=JI3XYY1lkNWCsMbaSc5XKLrHBXcy8vPRO4YWK3uAlrbIndEDZwjmzzVWsYW0LTuEAU
         mN82LFVhHgfzC47iajPxUlH1IWaRv2FDzzWERqoIccnaBCbZhxr+T4KOk///UCXbNshu
         /j5+aZCvDQbkuMtTDhhzjuXfD59IWS3TdshLyEYuRSKLhmsbKrOOWsE74oMrPxGFmSyn
         qdMcn3/pq5/PckS8k5exgX7qAnzUDq5kMW8nYkWGvzYYNT6hkYp3HlAnj3hJcJNJfn8Y
         cHEEaw4uS0BaoWfIo4MmFXhwJDKNfy/IiOnSklbm1btc47GZQn6h1rCmeYwwtI4uioLt
         FwnA==
X-Gm-Message-State: AElRT7EstYGIJZ5S/hBG1tVaJBXryQj3UoT7gnSG2VYu88rlBDFXgY3S
        6xNxbOKGiy5yUiMpSZcqDLM=
X-Google-Smtp-Source: AIpwx49MAUBYD5eqdMyyuvopfeGuYXW3KCthSKSxWf/QsqQXuvm27lY19yGdDXbhZS5j/fROYQY3pg==
X-Received: by 10.80.250.13 with SMTP id b13mr16074242edq.290.1522754900283;
        Tue, 03 Apr 2018 04:28:20 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id r1sm1604760edc.0.2018.04.03.04.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 04:28:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
        <87fu4hwgfa.fsf@evledraar.gmail.com>
        <20180330191620.GA32338@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1804031133270.5026@qfpub.tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1804031133270.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Tue, 03 Apr 2018 13:28:18 +0200
Message-ID: <87sh8cv8a5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 03 2018, Johannes Schindelin wrote:

> Hi Peff,
>
> On Fri, 30 Mar 2018, Jeff King wrote:
>
>> On Fri, Mar 30, 2018 at 08:45:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> > I've wondered for a while whether it wouldn't be a viable approach to
>> > make something like an interpreter for our test suite to get around
>> > this problem, i.e. much of it's very repetitive and just using a few
>> > shell functions we've defined, what if we had C equivalents of those?
>>
>> I've had a similar thought, though I wonder how far we could get with
>> just shell. I even tried it out with test_cmp:
>>
>>   https://public-inbox.org/git/20161020215647.5no7effvutwep2xt@sigill.intra.peff.net/
>>
>> But Johannes Sixt pointed out that they already do this (see
>> mingw_test_cmp in test-lib-functions).
>
> Right.
>
> Additionally, I noticed that that simple loop in shell is *also* very slow on
> Windows (at least in the MSYS2 Bash we use in Git for Windows).
>
> Under the assumption that it is the Bash with the loop that uses too much
> POSIX emulation to make it fast, I re-implemented mingw_test_cmp in pure
> C:
> https://github.com/git-for-windows/git/commit/8a96ef63a0083ba02305dfeef6ff92c31b4fd7c3
>
> Unfortunately, it did not produce any noticeable speed improvement, so I
> did not even finish the conversion (when the cmp fails, it does not show
> you any helpful diff yet).

I don't know the details of Windows, but it sounds like you're trying to
performance test two things that are going to suck for different
reasons.

On one hand the pure-*.sh comparison would be slower than just diff on
*nix, because it's not C, so you'll get that slowness, but gain in not
having to fork another process.

On the other hand the C implementation is going to be really fast, but
it's going to take you a long time to get it started on Windows.

Which is why I think it would be really interesting to see the third
approach I suggested, i.e. hack the shell to make the test_cmp a builtin
and test that. Then you won't fork, but will get the advantage of your
fast C codepath.

Also, even if test_cmp is much faster, Peff's results over at
https://public-inbox.org/git/20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net/
suggest that you may not notice anyway. Aside from the points raised
there about the bin wrappers it seems the easiest wins are having a
builtin version of "rm" and "cat".

Are you able to compile dash on Windows with some modification of the
patch I sent upthread? If not it doesn't seem too hard to do the same
trick for bash, see:

    git grep '\balias\b' -- builtins

Once you have bash.git checked out. I.e. you add a bit of Makefile
boilerplate and you should be able to get a new builtin.

>> I also tried to explore a few numbers about process invocations to see
>> if running shell commands is the problem:
>>
>>   https://public-inbox.org/git/20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net/
>
> This mail was still in my inbox, in want of me saying something about
> this.
>
> My main evidence that shell scripts on macOS are slower than on Linux was
> the difference of the improvement incurred by moving more things from
> git-rebase--interactive.sh into sequencer.c: Linux saw an improvement only
> of about 3x, while macOS saw an improvement of 4x, IIRC. If I don't
> remember the absolute numbers correctly, at least I vividly remember the
> qualitative difference: It was noticeable.
>
>> There was some discussion there about whether the problem is programs
>> being exec'd, or if it's forks due to subshells. And if it is programs
>> being exec'd, whether it's shell programs or if it is simply that we
>> exec Git a huge number of times.
>
> One large problem there is that it is really hard to analyze performance
> over such a heterogenous code base: part C, part Perl, part Unix shell
> (and of course, when you say Unix shell, you imply dozens of separate
> tools that *also* need to be performance-profiled). I have very good
> profiling tools for C, I saw some built-in performance profiling for Perl,
> but there is no good performance profiling for Unix shell scripting: I
> doubt that the inventors of shell scripting had speed-critical production
> code in mind when they came up with the idea.
>
> I did invest dozens of hours earlier this year trying to obtain debug
> symbols in .pdb format (ready for Visual Studio's really envy-inducing
> performance profiler) also for the MSYS2 runtime and Bash, so that I could
> analyze what makes things so awfully slow in Git's test suite.
>
> The only problem is that I also have to do other things in my day-job, so
> that project waits patiently until I have some time to come back to that
> project.
>
> Ciao,
> Dscho
