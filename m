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
	by dcvr.yhbt.net (Postfix) with ESMTP id 193911F453
	for <e@80x24.org>; Mon, 29 Oct 2018 18:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJ3DdW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 23:33:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42965 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJ3DdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 23:33:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so9852856wru.9
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zXCmQfPwShe2KYAByaS4MDZBMmYV9u/4TIDtCr4my/E=;
        b=QkxriLjygP7QcLK6Bx6DCOR3QTqj4BThmgwJ5Umr63O+AntsiblzsE0dyGhkLLkg8G
         wvX5jwc6mPhtLBIWUdUxRNKN8OJjF1Yb4MjlIaArJykIQPQ5qV8MnJMjGOt+rxbMmfSf
         0lTglVGA+jOj/h6wZOK8MWonpFyq0OEah+1VSdZJHrcNDHrWgnKnxsbf3vyY2fa6r/Qe
         xdPKQ6XChq1bpb8a17KYp5kNId/3reoh6h8GV3vnVhqei4e3wprqs9eckhZmqB1BKrKm
         rkHg5cQB6wuQPztn6EbPprFOxAtqckAnVXiJOkWcRQC7JPpG/BU04XYzjQSNADJQap+Z
         bxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zXCmQfPwShe2KYAByaS4MDZBMmYV9u/4TIDtCr4my/E=;
        b=kqituPWyDZB9HmGda+VnTo5pMQOaJ1sFW4RFQdBLeDGOGz06K1Xd61Cyn8BiWiwSL1
         oo7ZyuW6+qZpt7tn+Xt3hnHTvYd+O1REfVWxptqWaQpFXoB1hVvSn3xkApjIlWb/LFrW
         lniKS6XOE2GvZ7bFG9qisSE5QAq6UYFlbp7uAGugAbHzpxT+5aE+iWy1nvLjBDhMRHDO
         1rJDaWDEWpGm7h+UaISbggBD8Gk81F+5qXv++zOSyGW+WPfA3INCATv6+yQxtcIjl3Qa
         4tL2d2BAUGAatEt7FUXvWDxxx7V801JPGwBRo+Ws3q/6NImL9AXKB4CeO7Opq6cRJDjw
         /PYA==
X-Gm-Message-State: AGRZ1gJ8BvrSaRYuHxD0f7DfUxomhNEFVZwYPf0VwXA5W0kSgMrFcBoA
        SaQVWkjyMiu/9oAKAG2tNyk=
X-Google-Smtp-Source: AJdET5eZsNHqAxDO6XJQ6UcxncJ2L5wHRMGFrQhHmeJknqD/gVKt3MeToFqxo0x82z6Jbz3pkmZ97w==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr14491991wre.55.1540838605822;
        Mon, 29 Oct 2018 11:43:25 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id l14-v6sm16567806wmd.43.2018.10.29.11.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 11:43:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Jansen\, Geert" <gerardu@amazon.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
        <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
        <87o9bgl9yl.fsf@evledraar.gmail.com>
        <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
        <20181027093300.GA23974@sigill.intra.peff.net>
        <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com>
        <20181029152032.GK17668@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181029152032.GK17668@sigill.intra.peff.net>
Date:   Mon, 29 Oct 2018 19:43:22 +0100
Message-ID: <87d0rslhkl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29 2018, Jeff King wrote:

> On Mon, Oct 29, 2018 at 09:48:02AM +0900, Junio C Hamano wrote:
>
>> > Of course any cache raises questions of cache invalidation, but I think
>> > we've already dealt with that for this case. When we use
>> > OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
>> > accuracy/speed tradeoff (which does a similar caching thing with
>> > packfiles).
>> >
>> > So putting that all together, could we have something like:
>>
>> I think this conceptually is a vast improvement relative to
>> ".cloning" optimization.  Obviously this does not have the huge
>> downside of the other approach that turns the collision detection
>> completely off.
>>
>> A real question is how much performance gain, relative to ".cloning"
>> thing, this approach gives us.  If it gives us 80% or more of the
>> gain compared to doing no checking, I'd say we have a clear winner.
>
> My test runs showed it improving index-pack by about 3%, versus 4% for
> no collision checking at all. But there was easily 1% of noise. And much
> more importantly, that was on a Linux system on ext4, where stat is
> fast. I'd be much more curious to hear timing results from people on
> macOS or Windows, or from Geert's original NFS case.

At work we make copious use of NetApp over NFS for filers. I'd say this
is probably typical for enterprise environments. Raw I/O performance
over the wire (writing a large file) is really good, but metadata
(e.g. stat) performance tends to be atrocious.

We both host the in-house Git server (GitLab) on such a filer (for HA
etc.), as well as many types of clients.

As noted by Geert upthread you need to mount the git directories with
lookupcache=positive (see e.g. [1]).

Cloning git.git as --bare onto such a partition with my patch:

    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     60.98    1.802091          19     93896     19813 futex
     14.64    0.432782           7     61415        16 read
      9.40    0.277804           1    199576           pread64
      4.88    0.144172           3     49355        11 write
      3.10    0.091498          31      2919      2880 stat
      2.53    0.074812          31      2431       737 lstat
      1.96    0.057934           3     17257      1276 recvfrom
      0.91    0.026815           3      8543           select
      0.62    0.018425           2      8543           poll
    [...]
    real    0m32.053s
    user    0m21.451s
    sys     0m7.806s

Without:

    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     71.01   31.653787          50    628265     21608 futex
     24.14   10.761950          41    260658    258964 lstat
      2.22    0.988001           5    199576           pread64
      1.32    0.587844          10     59662         3 read
      0.79    0.350625           7     50376        11 write
      0.22    0.096019          33      2919      2880 stat
      0.13    0.057950           4     15821        12 recvfrom
      0.05    0.022385           3      7949           select
      0.04    0.015988           2      7949           poll
      0.03    0.013622        3406         4           wait4
    [...]
    real    4m38.670s
    user    0m29.015s
    sys     0m33.894s

So a reduction in clone time by ~90%.

Performance would be basically the same with your patch. But let's
discuss that elsewhere in this thread. Just wanted to post the
performance numbers here.

1. https://gitlab.com/gitlab-com/gl-infra/infrastructure/issues/109#note_12528896
