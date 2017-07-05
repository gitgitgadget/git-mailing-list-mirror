Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D316E202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdGEL02 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 07:26:28 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34361 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdGEL00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 07:26:26 -0400
Received: by mail-wm0-f49.google.com with SMTP id 70so31308492wmo.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=dkvc9VW7cD2/H1HQnU2AJ7MLQf7IZcsTlHufLbUiT8g=;
        b=fjv54c4NI1A1fGP9MNnxLUDSfEW99ZAFaJvZY7l/8Y1Ze3/2OBEOVz0EdM7jrEDJFu
         PfVUa6p7wNaJE8ljkQ63C0dEjvq6+Gx8hXXVVkrCN/VtCBKMydeGR/Q56BGUS0rMBWJD
         BNeXsElSkIrUR/DO3byIr1YY+o9k/bIvbQo2ghn1NfNeKGtW1dLYcpXGtI/WbtCu8JTy
         ptEcVWjeVtXUcowoTlXm94FpqjfBYc0C0UB6AONHhzddtnxiAtEBx02xm1/sOC3rUcVS
         OHnwrUVPD6o8zfBLQ38q8WN2Kn8e/S0WhEweV/gqLGtpt++gD7FvWjjzBXGmTmfhQ7Sb
         hAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=dkvc9VW7cD2/H1HQnU2AJ7MLQf7IZcsTlHufLbUiT8g=;
        b=a2tkPL1sw3+5rsvAs4ok8yo6/pDM1AlKdSZZRubp3EzqKhYswNB2W2x6r5qZv3MKYo
         vILR0zcDaPjQFnuV2Be2vje+wRFipdXaSvoCdmpY7aT+FNn+ddGd9Lyk6xjuJ5GegXMt
         m1sAn73m3YUYMxPP5U8myo+uoGMXWLtwv5T7DnDfU37Qtsq32wVWn1MfbZRHKOMvduPT
         yJVS8ZUDlMQWJJmP50RR5ocYPCnU5gsOb8EbACQCpsbPIt2ycDTvkyLqNrW4bNqKcnZJ
         bOvgGoWFvWpdAlBZDOAHHrkmgv6MDyrcRGI4MzfmQi3LaRDk4JttHkQW8hW6Y20zEbDe
         StBg==
X-Gm-Message-State: AKS2vOx7+cT6pdgV9ben5KzEAHZL81CoQVf9zRTE6JF9RAL4gKw4ENdv
        7sFTMCh4+jiiOZGrfqQ=
X-Received: by 10.28.128.215 with SMTP id b206mr22961394wmd.61.1499253985539;
        Wed, 05 Jul 2017 04:26:25 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id d91sm30482505wma.7.2017.07.05.04.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 04:26:24 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dSiRr-0002yS-Hh; Wed, 05 Jul 2017 13:26:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Francesco Mazzoli <f@mazzo.li>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com> <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com> <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
Date:   Wed, 05 Jul 2017 13:26:23 +0200
Message-ID: <87eftvazvk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 05 2017, Junio C. Hamano jotted:

> On Tue, Jul 4, 2017 at 11:34 PM, Francesco Mazzoli <f@mazzo.li> wrote:
>>
>> Could you clarify the danger you're referring to? E.g. give an example
>> of surprising --force-with-lease behavior that we do not want to
>> encourage?
>
> https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/

In the context of this patch I don't understand why you're concerned
that making --force mean --force-with-lease makes things worse.

See my
https://public-inbox.org/git/CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com/
(follow-up to the E-Mail you posted):

    To me the *main* feature of --force-with-lease is that it's less
    shitty than --force, without imposing too much UI overhead. We have to
    be really careful not to make --force-with-lease so complex by default
    that people just give u and go back to using --force, which would be
    worse than either whatever current problems there are with the
    current --force-with-lease behavior, or anything we replace it with.

I.e. yes there are workflows with some background auto-update that will
make it less safe, which I documented in f17d642d3b ("push: document &
test --force-with-lease with multiple remotes", 2017-04-19).

But it is still the case that --force-with-lease is categorically a more
safer option than simply --force, which has none of the safety
--force-with-lease has. It would still wipe away history in this
scenario you're pointing out *and others*.

Surely the point of having an option like this is to have a net
reduction in complexity.

I think it can be argued that it's bad UI design though to have --force
mean different things depending on the config, and we'd be better off
with a patch that disables --force.
