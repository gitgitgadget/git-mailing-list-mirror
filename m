Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677A720282
	for <e@80x24.org>; Wed, 14 Jun 2017 17:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdFNRej (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 13:34:39 -0400
Received: from mout.web.de ([217.72.192.78]:49631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752554AbdFNRei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 13:34:38 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOilO-1dREKe3x9K-0064xQ; Wed, 14
 Jun 2017 19:34:31 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org
References: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <20170613222445.15575-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1d4c9a93-5061-96db-d8aa-e798948650dc@web.de>
Date:   Wed, 14 Jun 2017 19:34:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170613222445.15575-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KFNqbVLz579qD4g1auoMOSR2ZBxTpJk9dpps73/6v/j8fNrTQay
 rIYQqoEflVILjMBYxKyqp5k0CVtVjlLUbfgubLn0uPcYhkH4NWyjbZtnGpSvCXEB8wD08sm
 v6vIKo1fFj4QJ1vJYIDViqCHQrtKyBSpb8MwYSRY8uDRDw8wELE4LcH/8KPSPLAyMaKJsnB
 agYrmqnFFZnXzcNprx3Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1MkrDPukiQk=:avVkl1/DrmAnC7K4xA04gH
 mHZZqju2k4EHZXpf1ch+6NzBX5lyc9hNcAXU4RqXK5i2R9V53OjE0axpSoc5RMdiHXvybR1Bb
 jwRWtMsxi90va+7wlY7+UXkLxQnGbamdLQ0FAUnAOY6A6Ikhv1Z7r0AkwLk47AW8pkIND1hhB
 c/bvwd+J/9SHm90h6S/9a7a7ClaMGYo4siYeCDyzQqtcz6gwTeLEz0L4OXY3Fhaz7s1Me5Tgn
 7pGqzDuwf5NKDZl9JtHoq9psz3530defEgLVAqA69WQPtTxvxE3SJQf++wK+yCkjmuZpmt8tI
 rm9jJriOgNzu4nC2IwtH1ZAjYmuuKUFUbsUVPCUUn9wVNsuqP0FPcKCs1nKCHm45WOH58eGsF
 FQx9jzPhOmLR6Maux2Nt772c3uXf1Df6zmQi1Hg7rnOto0eZzbvSpxOml7kYXxZFUGcBA9jfQ
 oZrfWHE9rKIRUMvilzH34vj9wX/z0Eh2HS29xuQx0HjjiQyOfqQ/fvIoQt5hme3A0945eI+nN
 pzZUQmZo6FwZhBSTUuE5cMRlYWh6TWN64fycpIC20cG+bD+06prStslM3yTOjPJYYJP5sKHbF
 P+pUZAV9s1dTxoAEoFI3txzMWGx1fv3/V8vQuLQI70Jfhx4n9ZXQaH/l3d9FI96vJ0Hx47sU4
 WZzErVoDewp1FYbKl8Ror1nYUNf7DwDT2eTx+KHDRZHk57WHE/CpZFscItz2bP+4ZnzOeWvvC
 U6f+5eDo8eSDpNlmL4n9C+JZVDioPKViNSOTkKHyxHIWWo1mTejO5BLLloWzCmsWblMYnX1TP
 9Oa0XJ3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.2017 um 00:24 schrieb SZEDER Gábor:
> [sorry for double post, forgot the mailing list...]
> 
> To throw in a fourth option, this one adjusts the expansions' cached
> offsets when the magic makes it necessary.  It's not necessary for
> '%-', because it only makes a difference when the expansion is empty,
> and in that case
> 
>    - add_again() doesn't consider it cached,
>    - and even if it did, the offset of a zero-length string wouldn't
>      matter.
> 
>   pretty.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)

There are other modifiers, e.g. try the format '%h%>(20)%h' -- its
output is obviously wrong (contains control characters), even with your
patch.  We'd have to update the offsets for each placeholder that
changes the output of others.  I don't think that approach scales, alas.

René
