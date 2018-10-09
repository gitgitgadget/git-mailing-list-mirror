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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3955E1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJJCDf (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:03:35 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41508 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJJCDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:03:35 -0400
Received: by mail-ed1-f51.google.com with SMTP id x31-v6so2653992edd.8
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5M0TTBjkvrnLpHEqXVrMpTNEG7trvLsyWmiAil6Hfvo=;
        b=JKFc0yen77uGE6eTRFzxp6+FSbVLk8wZ5BBaOYKgqDscVOWfVoNpjsp13JLJ429uA0
         yYQnTZETCSa1t5LeHM4zydAJdRemrormM8RBS+GFp6osXWS1E45q6EBTWtVoX/HULN5B
         Uc6H91L1PmqsjmgoUouI15a2b/OutdI1ztEE0OUvjk7fXvQ3TMw00aXyjDxgxu67xLU/
         VNIEJr3V7YFhyOO47dy+KPuX20XoalGWGATl9gwP1GcAKx/U8WeHyjvWIJwGMI3WK7Kh
         LGGQI1wbyF27OLDB3YhLmSomJ2XiMBLJu3QOlQNedgE0QOsnTbk5WITfoe2trPUi1iWW
         FoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5M0TTBjkvrnLpHEqXVrMpTNEG7trvLsyWmiAil6Hfvo=;
        b=GTfecbubgyJINrydSHmk2Z9TbosLbN45RqKgIP+VfQwnhxPtVutwUH5dkZ1vMWweP3
         K+eVTxUA1Rbddrv1Lkzjv9Ac6/2bbE+z+SxiO+5MRgllUdpuHNhCo61zMYWEBBGhGWbq
         nHGGd10ZdWE3WAFEjIdPIhd/dEnS6ocnm/Vj0n3BKJBOlkDx6Kg1csMsnSQsZslsPc5O
         I5PyGk/1YCjB7nH6QVTK9aPU0PkfJbEl8po/4YXeZ5Xph+oxxGK79Pc+JMEnZNWCtecm
         M4lzVETxB8U9souW4rN0t/hJIJa3cuCICdfq0sE3r6fYybDz8cx7qLU7I1gqGaGk1cxb
         dANg==
X-Gm-Message-State: ABuFfogRluBno3a7mirX5yew8QP4sWNtWU65L+iDoGKgJ7tTbX2FLjSW
        Q8u0YwcJjBF1JeqKo0MdlpQ=
X-Google-Smtp-Source: ACcGV63GXOw+GHrzLQ3Q1rOHx0BAavctA+YBzARZVACK89c0Iw/zj5E2byuZ/AL+hC7E/ANDoBdw5Q==
X-Received: by 2002:a17:906:4ac2:: with SMTP id u2-v6mr29467275ejt.202.1539110713762;
        Tue, 09 Oct 2018 11:45:13 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id q3-v6sm3730260ejb.0.2018.10.09.11.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:45:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bloom Filters (was Re: We should add a "git gc --auto" after "git clone" due to commit graph)
References: <87o9cbglez.fsf@evledraar.gmail.com>
        <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
        <87lg7ehnps.fsf@evledraar.gmail.com>
        <20181003185156.GA20709@sigill.intra.peff.net>
        <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
        <20181003191805.GB16666@sigill.intra.peff.net>
        <20181008164141.GZ23446@szeder.dev>
        <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
        <20181008181015.GA23446@szeder.dev>
        <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
        <20181009030803.GA6250@sigill.intra.peff.net>
        <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
Date:   Tue, 09 Oct 2018 20:45:11 +0200
Message-ID: <87ftxfez7s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 09 2018, Derrick Stolee wrote:

> The filter needs to store every path that would be considered "not
> TREESAME". It can't store wildcards, so you would need to evaluate the
> wildcard and test all of those paths individually (not a good idea).

If full paths are stored, yes, But have you considered instead of
storing paths, storing all trigrams that can be extracted from changed
paths at that commit?

I.e. instead of a change to "t/t0000-basic.sh" storing
"t/t0000-basic.sh" we'd store ["t/t", "/t0", "t00", "000", "00-" ...]
etc.

That sort of approach would mean that e.g. "t*000*", "*asi*.sh"
etc. could all be indexed, and as long as we could find three
consecutive bytes of fixed string we'd have a chance to short-circuit,
but would need to degrade to a full tree unpack for e.g. "t*". We could
also special-case certain sub-three-char indexes, or to
"bi-grams". E.g. to be able to index '*.c' or 't*' (first char at the
beginning of a string only).

It would mean having to check more things in the bloom filter for each
commit, but that's going to be hot in cache at that point so it'll
probably beat unpacking trees by far, and we could short-circuit exit at
the first one that returned false.
