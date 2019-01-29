Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C601F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfA2VDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:03:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36606 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2VDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 16:03:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so17215661edb.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 13:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=RXie0y80ni05PtGWnwJDVGkUXYbYJWu3z8ZZGgCG5qo=;
        b=E6ILWYjMa6MvZWxRjs8z6hz6me+NmR4GJg9ioCRAOLrOqoHqiqZK543SmXYMl2Ga+t
         QoFPgflSunEe0M6+X+BH4UIo3ZsoEWbY5lvicZHjwy8fCjTPRaLz4vb60nAgagf5sb6l
         gDIFsgP3/C2C+UFTOupjwqAZK/zkz6qxc6fR0njVskA1EhsY6mjaHXXZONAWg2j3Z+Fj
         CnR0y3dU8P6nWrfhq0S9hquSLCvz8BlzwXpOgGMrwoAaCr0a01+qJSDP5tBi99dAxjTn
         VKqWYqtSqATonbFkKzomGEBPfvy1qxEf+baZiiJqhub5SvxhdDxjcx2VR9HD8jbBymcA
         mpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=RXie0y80ni05PtGWnwJDVGkUXYbYJWu3z8ZZGgCG5qo=;
        b=BAky+Yz1ypHfziEjHveccyNEz2p2tH5iYm9zuNkgvvYE2EG72dDv7+0sJIkyNG7y7y
         T/LYYDwCtlKzw0ZRgCHBMA4PldWeoHPLkBq84bRTUMiie2eEkCowRMsqgKQ9wX/GBwNB
         tyx6HeWDqMUee44xw9ChqXJbhsDmvGMffN/orSZq8H18hYQMzSVfIKUGuISd3sDNR1C3
         Kdj85MTeg9tmcqGngBwC1P0tt7/DDtPyCKt3PUA8sBt26KWHT7s4eBx0D7ekMc2er3d9
         14tEJkNBxUeBjY+zsT5ERkxrHJpYrQE4cEdGV2ydEHAz5FHSGh+8mm2Utj/i4Vf+btMY
         Rc2g==
X-Gm-Message-State: AJcUukfOIOn9DNDMXRAOcvc4H2FFNzC2gBdqH5cKS2H/WyOi5JABOusy
        q2n7TK5qXAv7WFPm/rcb/RQ=
X-Google-Smtp-Source: ALg8bN4oaXqEChokNK0REr5Xx93jks4SveCncQ4ZL1cGUcExdCAh0LXA41jvYSTfYm6fi7VUJIMZ+Q==
X-Received: by 2002:a50:a5e2:: with SMTP id b31mr26483652edc.5.1548795828433;
        Tue, 29 Jan 2019 13:03:48 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k13sm2221797ejq.56.2019.01.29.13.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 13:03:47 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com> <20190129160030.GA7083@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190129160030.GA7083@sigill.intra.peff.net>
Date:   Tue, 29 Jan 2019 22:03:46 +0100
Message-ID: <87zhrj2n2l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 29 2019, Jeff King wrote:

> On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When running the test suite for code coverage using
>> 'make coverage-test', a single test failure stops the
>> test suite from completing. This leads to significant
>> undercounting of covered blocks.
>>
>> Add two new targets to the Makefile:
>>
>> * 'prove' runs the test suite using 'prove'.
>>
>> * 'coverage-prove' compiles the source using the
>>   coverage flags, then runs the test suite using
>>   'prove'.
>>
>> These targets are modeled after the 'test' and
>> 'coverage-test' targets.
>
> I think these are reasonable to have (and I personally much prefer
> "prove" to the raw "make test" output anyway).

I wonder if anyone would mind if we removed the non-prove path.

When I added it in 5099b99d25 ("test-lib: Adjust output to be valid TAP
format", 2010-06-24) there were still some commonly shipped OS's that
had a crappy old "prove", but now almost a decade later that's not a
practical problem, and it's installed by default with perl, and we
already depend on perl for the tests.

I don't feel strongly about it, but it would allow us to prune some
login in the test library / Makefile.

Maybe something for a show of hands at the contributor summit?
