Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C151F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 04:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750822AbdH3EzI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 00:55:08 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44605 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750758AbdH3EzH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Aug 2017 00:55:07 -0400
X-AuditID: 12074414-0ebff70000006ddf-7a-59a6452a2d7b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.95.28127.A2546A95; Wed, 30 Aug 2017 00:55:06 -0400 (EDT)
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com [209.85.214.41])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7U4t5c7001551
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:55:05 -0400
Received: by mail-it0-f41.google.com with SMTP id f1so1888654ith.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 21:55:05 -0700 (PDT)
X-Gm-Message-State: AHYfb5g6MiAtxSx6FqQ+9MGViKCfK+RLnu/irj0NHYd9w+JQC5a9Vop7
        RoQ3i60se60WSk5Ai1u2XclWGlH9aA==
X-Received: by 10.36.185.14 with SMTP id w14mr261352ite.181.1504068905218;
 Tue, 29 Aug 2017 21:55:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.15.14 with HTTP; Tue, 29 Aug 2017 21:55:04 -0700 (PDT)
In-Reply-To: <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
References: <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com> <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com> <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net> <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net> <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Wed, 30 Aug 2017 06:55:04 +0200
X-Gmail-Original-Message-ID: <CAMy9T_Eq+XJyhXk99RA9AMUVx3L8qw+0=KfAOjYsPsTSVSLchQ@mail.gmail.com>
Message-ID: <CAMy9T_Eq+XJyhXk99RA9AMUVx3L8qw+0=KfAOjYsPsTSVSLchQ@mail.gmail.com>
Subject: Re: [PATCH] config: use a static lock_file struct
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1NVyXRZpcGCKpEXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDKurDvLUnBGqOL8ofPsDYyX+LoYOTkkBEwkNh15ytTFyMUhJLCD
        SWJ/01o2COcRk8SMjrtQmR5Gif7eVhaIlnyJfTeuMELYRRKXH99hBrF5BQQlTs58AlYjJCAn
        8WrDDUYI21Ni0t7XbCA2p4CLxILPL6E2fGGReHv8DFgRm4CuxKKeZiYQm0VAVWJrYyc7xIJE
        iQufD0EtCJA4takfLC4sYCVx4+1GMFtEQFbi++GNjCBDmQWOM0qs3nId7ApmAU2J1u2/2Scw
        Cs9CcuAsJKkFjEyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUJCWWQH45GT
        cocYBTgYlXh4d3AvixRiTSwrrsw9xCjJwaQkyqvtAhTiS8pPqcxILM6ILyrNSS0+xCjBwawk
        whtjB5TjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLg/ewM1ChYlJqe
        WpGWmVOCkGbi4AQZzgM0XBxkMW9xQWJucWY6RP4UozHHlSvrvjBxTDmw/QuTEEtefl6qlDhv
        Lcg4AZDSjNI8uGmwdPSKURzoOWFebpCBPMBUBjfvFdAqJqBVsV5LQVaVJCKkpBoYu4uZTf8J
        RMyKyOBl6f7Pu/J32QIv8Wo/8Usml3PPpOUt/26n5Rdwp39F+xE/uZvBKaHb3Rb7bUl727jo
        pEykV3AOx6XqVdmnN9xlkTtu32yis0d3liJ/9hyd/Z4qF4Is+diPaorOONzxX7x72o1Vv/uc
        dwZF3lgaslvpu9ruY0IfdpsaOf5UYinOSDTUYi4qTgQA45PmtSIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 6:31 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 30, 2017 at 05:25:18AM +0200, Michael Haggerty wrote:
>> It was surprisingly hard trying to get that code to do the right thing,
>> non-racily, in every error path. Since `remove_tempfiles()` can be
>> called any time (even from a signal handler), the linked list of
>> `tempfile` objects has to be kept valid at all times but can't use
>> mutexes. I didn't have the energy to keep going and make the lock
>> objects freeable.
>>
>> I suppose the task could be made a bit easier by using `sigprocmask(2)`
>> or `pthread_sigmask(3)` to make its running environment a little bit
>> less hostile.
>
> I think there are really two levels of carefulness here:
>
>   1. Avoiding complicated things during a signal handler that may rely
>      on having a sane state from the rest of the program (e.g.,
>      half-formed entries, stdio locks, etc).
>
>   2. Being truly race-free in the face of a signal arriving while we're
>      running arbitrary code that might have a tempfile struct in a funny
>      state.
>
> I feel like right now we meet (1) and not (2). But I think if we keep to
> that lower bar of (1), it might not be that bad. We're assuming now that
> there's no race on the tempfile->active flag, for instance. We could
> probably make a similar assumption about putting items onto or taking
> them off of a linked list (it's not really atomic, but a single pointer
> assignment is probably "atomic enough" for our purposes).
>
> Or I dunno. There's a lot of "volatile" modifiers sprinkled around.
> Maybe those are enough to give us (2) as well (though in that case, I
> think we'd still be as OK with the list manipulation as we are with the
> active flag manipulation).

I did in fact strive for both (1) and (2), though I know that there
are a couple of short races remaining in the code (plus who knows how
many bugs).

Actually, I think you're right that a single "probably-atomic" pointer
assignment would be enough to remove an entry from the list safely. I
was thinking about what it would take to make the list thread-safe
(which it currently is not, but probably doesn't need to be(?)).
Modifying the linked list is not that difficult if you assume that
there is only a single thread modifying the list at any given time.

Michael
