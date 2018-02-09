Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C461F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeBISaR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:30:17 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52347 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeBISaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:30:16 -0500
Received: by mail-wm0-f46.google.com with SMTP id g1so16999562wmg.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Q/7BLvLcU6SQ6N/SQ9q249zFem5V7/dwgmAiu9FkbAQ=;
        b=dmErUuv4ekUO8gfw+rbWNkzYNcUIBYh8I35Heu/Z+tW51+x7FTWbLzygnysCt6UdTo
         32kzu22WPrQ8d+W7ZhJmeImAYHbJI1GUGXu8KCBcN7HmwqApWAhsesSjtPFq9LKM6c0H
         Wyp/B+EQyEgohQxWF0Pkm94POAXPdfFkBdzXBwxGjXECDN712uCG/bp9xTWkl9Qbu1vY
         pqVHWZW6ASsQkEzemuy9UhffuU6Skt+S1H5tvWWx2T4+jSPkOnospcGNYv3IEJVuNumi
         YmI5DQuFitIYi4vbEJklCorLTVeE2Fc4Z70/kwowXHzABTVSgFiQriVdbkkEuMFBEodN
         fhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Q/7BLvLcU6SQ6N/SQ9q249zFem5V7/dwgmAiu9FkbAQ=;
        b=C0Dimhdz34UgVLtgnx0dQ9C9qO9Kvuv2uRI3qjqPTwhr2/DAbtueySbkDr5n0uFyoc
         gxr8B+RWAvpBszsQ//KxmiI6J/ULzQHaSHOlzlCXDeSdsjqDsFsTXMNr1ndpTyoibits
         b1l5va2D+EzzhWsCyG07EcYjLRisiAcjJNqt9mE9VoDSJvVJuZW3T4eYYWWphWOPtMaG
         /bDPSoEXTQ57VEGCQLF8+yIV0MIfg38pX4NafW/6CYft9KKGpvj76fWHYQkj7AEVnvK4
         oOX6ly5lUGWrB3VWfkqQZmYMpGtxedndplQnYwzi2WSJXqHYh6x8KsQ6BHEH8w2OgNY4
         0d8A==
X-Gm-Message-State: APf1xPCoZNAHbbth/tzyOHw7KAfycmurvO6M8maUaosoOY/Yz/yJJU33
        6aXnIZ5BcBMafNzcyC0E24E=
X-Google-Smtp-Source: AH8x224lol18AIPYRlZ46Mee7AvsCdO4FrJ7lIafu1C1jRibecKhaulki8P6IlGUIuzJ+1+pyUq36A==
X-Received: by 10.28.107.69 with SMTP id g66mr2655899wmc.145.1518201015475;
        Fri, 09 Feb 2018 10:30:15 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p29sm3902945wmf.9.2018.02.09.10.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:30:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com> <87mv0tm0l7.fsf@evledraar.booking.com> <nycvar.QRO.7.76.6.1802091805590.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <nycvar.QRO.7.76.6.1802091805590.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 09 Feb 2018 19:30:12 +0100
Message-ID: <874lmqm2x7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Johannes Schindelin jotted:

> Hi,
>
> On Thu, 1 Feb 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>>
>> > * ab/wildmatch-tests (2018-01-30) 10 commits
>> >  - wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
>> >  - test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
>> >  - wildmatch test: create & test files on disk in addition to in-memory
>> >  - wildmatch test: perform all tests under all wildmatch() modes
>> >  - wildmatch test: use test_must_fail, not ! for test-wildmatch
>> >  - wildmatch test: remove dead fnmatch() test code
>> >  - wildmatch test: use a paranoia pattern from nul_match()
>> >  - wildmatch test: don't try to vertically align our output
>> >  - wildmatch test: use more standard shell style
>> >  - wildmatch test: indent with tabs, not spaces
>> >
>> >  More tests for wildmatch functions.
>> >
>> >  Expecting an update.
>> >  cf. <87vaga9mgf.fsf@evledraar.gmail.com>
>>
>> The 2018-01-30 series is the update mentioned in
>> 87vaga9mgf.fsf@evledraar.gmail.com. You probably noticed this / just
>> didn't adjust the note since you queued in in pu already, but just in
>> case: the known issues in it have been resolved, but hopefully Johannes
>> Schindelin can test it on Windows & report.
>
> Sorry, I did not have time to look at this. All I can say is that the `pu`
> builds are green for a couple of days already. Which I celebrate!

Thanks, if you get time it would be great to know if:

    time GIT_TEST_LONG=1 ./t3070-wildmatch.sh

Runs cleanly for you, and how long it takes now. Even though it's going
to take a long time still, I optimized the test a lot so I expect it'll
be quicker.
