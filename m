Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D619E1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 00:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeDQA6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 20:58:38 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:40244 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQA6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 20:58:37 -0400
Received: by mail-wr0-f172.google.com with SMTP id v60so26879887wrc.7
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OpTVqKDa7uoa8txqAYtnIhmvNzJKTB0oAohHQu+gWys=;
        b=Kep2GmVSSuAXI0RCDEXuR1uoLK7/xmtKD8A7RRSzLI2tsxrOfoeASADutxpF0xsiUZ
         saYismm58qlj446Z+o5un6DBR3oETUTz9riCmquCKpTLv0FXdj0P0bYE17hvW7wJf5FY
         fQGgU9X57OpArLLeVpC8ILtF0frmKu9djSY72efDEOrJQGd3B6RVw2UhfXhxc/iUxowT
         99CHI91DgsaFkvREfvZ1Ez/2LreFfP9D6Avv+KP7GDumEmbEZpYbsRbz7QHhcAGFQ7D5
         3NNzPSNl4RKEznOfnqGv15eBDrcgNDbcKs8CNCWtdM32G55IL4jltq5C49ZLsi3VgIyh
         LKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OpTVqKDa7uoa8txqAYtnIhmvNzJKTB0oAohHQu+gWys=;
        b=FHHs9HD3kBanOt0QhenXyE/YULsURE2s6ex2m+ZxcM2KgHyGhvaJjPjXDPBreZS6e+
         RHTq6o/6a4BsobLb5KN2OTYKjj9Do0pjQSsF8Jk71Ia1+SOGVcFy4TJHKll2XtmJ3pgx
         tjwf+hu81JV/tI5vftqMRrZBKZTh1b3o1MYJJi81RtNHEwzbI1fCR0oRCffH+R8EDZbZ
         U1O0aDq0NXp6pM6JDza7CyZ8OrS0/85bBQFpwFus/4Tmu1KbrOUfRr0dNGSBg9vbeB5L
         i/9CCRDm9zdkcbPA52m/Da5dU3hd37TojOKaqthfMAlyG/Ug2ZOTcweM9o0BSyHazdDk
         xuuQ==
X-Gm-Message-State: ALQs6tCNR9xzfOW6mStPr73NtbcQQmd23OWiKVxYjNVtZGXZDI+hykh7
        GUomnlZxDBEwgTTr/50hIwdUcyWx7fhyXC2Y1zo=
X-Google-Smtp-Source: AIpwx49c4RNDOhaFxwu1wue7iXhd39904z3vJqV9PGtD/XklO8LdSnk8gsqoROzCw0oL4GLl0a2JgOjOghGCXeEZ4K4=
X-Received: by 10.80.172.196 with SMTP id x62mr517514edc.265.1523926715854;
 Mon, 16 Apr 2018 17:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 17:58:15 -0700 (PDT)
In-Reply-To: <CAP8UFD3ei7NEfiqBbWe_PKdrcW93t2pA=u-ub29X+jGOi9-Jwg@mail.gmail.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com> <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com> <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
 <87efjf6uwg.fsf@javad.com> <CAP8UFD3ei7NEfiqBbWe_PKdrcW93t2pA=u-ub29X+jGOi9-Jwg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 17:58:15 -0700
Message-ID: <CA+P7+xq1M25NFEBzXtWEe=mD2trY+7vip_MCHegrr=qtgTBLyQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 3:30 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Apr 16, 2018 at 5:19 PM, Sergey Organov <sorganov@gmail.com> wrote:
>> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>>
>>> 1. I see the following sentence in the "Rebasing merges: a jorney to the
>>> ultimate solution (Road Clear) (written by Jacob Keller)" article
>>>
>>>       "A few examples were tried, but it was proven that the original
>>>       concept did not work, as dropped commits could end up being
>>>       replaid into the merge commits, turning them into "evil"
>>>       merges."
>>>
>>> I'm not sure if 'replaid' is proper English assuming the past tense of
>>> replay was intended there (which I think is 'replayed').
>>
>> It could have meant, say, "reapplied", -- we need to ask the author.
>
> Yeah it could but I would say that it is not very likely compared to
> "replayed", so I changed it to "replayed". And yeah I can change it to
> something else if Jake (who is Cc'ed) prefers.
>
>> While we are at it, please also consider to replace "original concept"
>> by "original algorithm", as it didn't work due to a mistake in the
>> algorithm as opposed to failure of the concept itself.
>
> Ok, it's now "original algorithm".
>
> Thanks,
> Christian.

Replayed is accurate.

Thanks,
Jake
