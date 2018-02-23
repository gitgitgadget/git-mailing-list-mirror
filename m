Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7031F576
	for <e@80x24.org>; Fri, 23 Feb 2018 09:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeBWJEO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 04:04:14 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50204 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBWJEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 04:04:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id k87so3283279wmi.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4BeWdLB50SR4WbtDaFf9sbVcH6ux2CLwCRh6qhRci9s=;
        b=lPiZ9xMA7hHIGv/VzssftdMEL11K50ZqNiTVwLRNR2HCu8OlnM6bSmHyScwAekBgHN
         lSpvFXP0qmB6R6GZiuZL+C87Zjjf4Hw1JWU9MQ9DX4qoUAMMNdYcLQvltBKKQD4gmqXR
         PN8ymnIE5C5H11wVMKXtX01TG63MJPbtM3KdRv2/w0DsnNNTVM7o2YuxQkCkicPW3F2K
         u2xmPomwrN+/Mb/tNm66aFVsInRhnwn4AL5S/TreIHw6NUeGbPM//6MUYaYBvQ1jVDoG
         kniq/8qlctGhb+LeAur4y9Z8VQpwqDLtfDbRqzjqBI5NycrcCvC3tblIw68P/WHeE/wM
         hp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4BeWdLB50SR4WbtDaFf9sbVcH6ux2CLwCRh6qhRci9s=;
        b=lVGoJvrv5O8AlNdgxGVnZmLch+eZ+vE8bzDtZHKUPlfoxwnRwTX77Rnh3FUXrRFcZq
         8zvSEGGkGt6DjKZdos+oCYd79a0CU5bdkmY5IrTJWocChNCfQqg+aVCcorY9zfVAoCsC
         JjAaFn1PM+oDV8OkoQVCeUopVjQGdPBX4fwMY4PYXVizuOoztpgWHtBp/RA3vWLmvzYg
         7zy5ieX7EylqI2riPKnZeH3aGkE/d3M/ek0aePxCHm/Vui1fmPtK2HAcSwmIVoVcatHd
         J9+KS+O4Auh+s28m9I8DfsEe6tiasAZC0s6Fp/sHtguU4z2Nc6sOBcS6hdzW/prq9rbH
         yGuQ==
X-Gm-Message-State: APf1xPDyCe/IX1VxzO1yGgTQQpExCVlm1L72XC4lm+7Zbb/GjzO7I9i6
        EtATRPd1zMaB87ZFcPUAfvE=
X-Google-Smtp-Source: AG47ELtxqDxYSgFjHS8H+LF6OE7Um9OHe76i8Df8xh43O21N67tHtrsjKK8V1mr2itLwvfzgyG1isw==
X-Received: by 10.28.105.7 with SMTP id e7mr1095673wmc.125.1519376651670;
        Fri, 23 Feb 2018 01:04:11 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id s81sm2308494wma.45.2018.02.23.01.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 01:04:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180209203216.11560-1-avarab@gmail.com>
        <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
        <874lm9f6pe.fsf@evledraar.gmail.com>
        <xmqq7er4wzub.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqq7er4wzub.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Feb 2018 10:04:06 +0100
Message-ID: <87zi40dqm1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 22 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Feb 22 2018, Junio C. Hamano jotted:
>>
>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> Here's a v5 (correct subject line this time!). Many thanks to Eric for
>>>> a thorough review.
>>>
>>> We haven't seen any comments on this round.  Is everybody happy?
>>>
>>> I do not have a strong opinion on the new feature, either for or
>>> against.  I didn't find anything majorly questionable in the
>>> execution, though, so...
>>
>> I've been running that here on thousands of boxes (that are actively
>> using it) for 2 weeks now without issue. Would be great to have it
>> merged down & in 2.17.
>
> If those thousands of boxes are all employing one specific workflow
> that is helped by these changes, and the workflow is that other
> people do not care about (or even worse, actively do not want to let
> their junior project members to use without thinking), then a
> data-point from the original author does not amount to much ;-)

Of course, I should have been clearer. I just meant to chime in with the
datapoint that I'm fairly sure this doesn't have any serious bugs given
the wide internal testing it's gotten.

> Let's see how others find it useful and/or if the changed code gets
> in the way of others (I am not absolutely sure if the changes are
> free of regression to existing users who do not use the new
> feature).

I think if you're on the fence about merging it down (and others don't
chime in saying the want it / like it) it makes sense to merge down
1-14/17 and we could discard 15-17/17 for now for a later re-submission
and discussion once the earlier part of the series lands in master.

The earlier part of the series is just trivial code changes that don't
change any functionality, more documentation for how existing
functionality works, and more thorough testing of existing
functionality.
