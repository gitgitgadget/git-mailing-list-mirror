Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A652F20248
	for <e@80x24.org>; Tue, 12 Mar 2019 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfCLKCr (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 06:02:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39423 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfCLKCr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 06:02:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so1428353pgp.6
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RXO3Pt2N9Xd4YIKbKaIyYkBasLO+KjhRSyR3GVk1AnA=;
        b=Yt0hwTSFRLnC3Q2eOm5RPh4hrBGphd1We8hPkWpr/odJmhNytDi9Fb4ATgUvolc1Xb
         JD7am7eVoq91ilUHW0GGu4/2MaNx346q/nCrdzFn7JRxFRtuQUrzjIfqcVVxFBR6pSnR
         UWGxplRfY22Dkl7Vr/aHYHp2WnNLZfYnvMFhrbMO/hAbNb1sOjRBFwlfKboH3DHHNbPf
         ULVsgx1GJANUNkXvvHEjZx/3QPtuAiSLzJdZcni4S/TASYFW79dcQLIIY3yrJS5wnuU7
         0p25xPAwALY0E1zTY5gW/gL2OT29BSOsH7adjaGw+CqjIoNJi7TNOh34ayDlnKQKrUUl
         I37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXO3Pt2N9Xd4YIKbKaIyYkBasLO+KjhRSyR3GVk1AnA=;
        b=Jb6BfblP+5oNSz8OahFrbFphYB6pwkVFIN4+NhgSWncl4rdyN9PsGDrsuCH+g4FZW2
         hRUNhZqSVf3yMCBwXRXB6J3fwBmyneNnulRPwmv5g4SXA85nFz2oEMczAKjpBiTfhWOX
         icJ/jRVW7np3ZNenyyayBOr4ha4SZCkrbZteBh/gaK13dYsObUhhcgJyqO6SxunyRumk
         V12MblUS9CDRy4eMmurNyRxaMgNSz5lYi+i/fWNnGJaR8usIrEH85QFYO+hG8X3lfcKr
         kSu7au38SpOI1JKoiWL0UaA79ylXXpaARC80YixL1xmGxel5IXMFiHla9LB8RWFGg58p
         1FLQ==
X-Gm-Message-State: APjAAAVcN5diOZzRopGxL2SdVDMEwskxGK5Qt9Y6ygu7GCBOOPgp3pHu
        PEszADupWuGTYXjSERkcpmU=
X-Google-Smtp-Source: APXvYqzG7kZTBnko25QQnUtIAcjHppD/izKCTps+2pagL4LjsCGhQObgZ0q0yoP4ntvaXQgicTEhhQ==
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr37754596plq.144.1552384965929;
        Tue, 12 Mar 2019 03:02:45 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id v5sm12591518pfn.81.2019.03.12.03.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:02:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 12 Mar 2019 17:02:37 +0700
Date:   Tue, 12 Mar 2019 17:02:37 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
Message-ID: <20190312100237.GA20471@ash>
References: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com>
 <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net>
 <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
 <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
 <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 09:18:47PM -0300, Matheus Tavares Bernardino wrote:
> I've been thinking on how I could implement a test to estimate the
> lock contention but had no success until now. I wanted to try
> mutrace[2] but couldn't install it; I tried valgrind's drd but it
> didn't seem to report a contention time estimation; And I tried
> measuring the time of "pthread_mutex_lock(&grep_mutex)" but I don't
> know how much significative this value is, since we can't directly
> compare it (the time of many threads at lock) with the overall
> execution time. Do you have an idea on how we could measure the lock
> contention here?

(I'm supposed to be doing something else, but this is more fun :D)

Yeah lock contention is probably hard to measure. But at least we can
measure how much time is blocked by mutex. Something like this [1]
gives me

    $ time ~/w/git/temp/git grep --threads=8 abc HEAD >/dev/null
    warning: let's have some fun
    block_time = 20ms
    block_count = 10725
    
    real    0m0,379s
    user    0m0,425s
    sys     0m0,073s

From this I know "git grep" took 379ms and at least 20ms (probably
including measurement overhead) is wasted on pthread_mutex_lock(). It
does not look that significant, I admit.

> Another thing that is occurring to me right now is whether git-grep,
> as it is implemented today, would really benefit from thread-safe pack
> access. I may have to study the code more, but it seems to me that
> just the producer thread uses pack access.

That producer I think is just handing out assignments to worker
threads. The real work is still done by worker threads.

The entry point to pack access in this code is protected by
grep_read_lock(). I believe the multithread one is in this deep call
chain (I found it out by gdb)

[main thread] grep_oid() -> add_work() ->
[worker thread] grep_source() -> grep_source_1() ->
grep_source_is_binary() -> grep_source_load() ->
grep_source_load_oid() -> read_object_file()

Note that there's another source of pack access, the
lock_and_read_oid_file() in grep_tree(). This is where we unpack tree
objects and traverse to get blob SHA-1.

This code is currently on the main thread (maybe this is what you
found?) so it does not really benefit from multi thread. We could
still add some sort of lookahead queue to inflate tree objects in
advance in parallel, but I don't know how much gain that will be.

One thing I didn't notice is we currently force no threads in the case
we need pack access, e.g. "git grep <regex> <commit>" or "git grep
--cached <regex>". So if you need to experiment, you need to hack it
and remove that restriction. That's the "let's have some fun" code in
[1].

So, assuming this is CPU bottleneck, let's have a look at how CPU is used.

    perf record git grep --threads=1 abc HEAD >/dev/null
    perf report

shows me the top CPU consumers are

  51,16%  git      libz.so.1.2.11      [.] inflate_fast
  19,55%  git      git                 [.] bmexec

You need to do some guessing here. But I believe the top call is from
inflating objects (either from packs or from loose objects). The
second one is from regular expression engine.

Since the regex here is very short (I deliberately try Jeff's case
where object access dominates), the CPU is mostly used up for object
inflation. That suggests that if we could spread it out across cores,
the gain could be quite good. There aren't many dependencies in grep
tasks so if we spread the workload on 8 cores, execution time should
be reduced by 7 or 8 times.

For fun, I hacked up a horrible, horrible "thread safe" version [2]
that probably broke 99% of git and made helgrind extremely unhappy, so
these numbers are at best guidelines, but..

    $ time ./git grep --threads=1 abc HEAD >/dev/null
    
    real    0m0,253s
    user    0m0,225s
    sys     0m0,029s
    
    $ time ./git grep --threads=8 abc HEAD >/dev/null
    warning: let's have some fun!
    
    real    0m0,157s
    user    0m0,312s
    sys     0m0,089s

You can see the "real" rows show quite good time reduction. Not 8
times reduction, mind you, but that's where serious people dig in and
really speed it up ;-)

[1] https://gitlab.com/snippets/1834609
[2] https://gitlab.com/snippets/1834613

> So, although it would be out of scope for GSoC, checkout, diff and log
> (and maybe others) could all benefit from a thread-safe/parallel pack
> access, right? If so, it is very motivating the impact this project
> could, in theory, have :)

We have to analyze case by case. It may turn out that there are many
opportunity to utilize multi threads. I think checkout is definitely a
good candidate. For "git diff" and "git log" maybe you can try "perf"
to see how much workload is locked in pack access (mostly inflation,
because it's easier to spot from the profile report)
--
Duy
