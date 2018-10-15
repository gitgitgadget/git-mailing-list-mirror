Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E2F1F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeJOIYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 04:24:14 -0400
Received: from avasout03.plus.net ([84.93.230.244]:41377 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeJOIYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 04:24:14 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id Bqwigw91wO2g2BqwjgZmV2; Mon, 15 Oct 2018 01:41:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=SZ3MZimLdsEwsjShGyEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de> <20181012222234.GF19800@szeder.dev>
 <20181013050057.GA6805@tor.lan>
 <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
 <20181014025207.GA1527@sigill.intra.peff.net>
 <1e3233f4-ea40-6fff-0951-6b4885f88445@ramsayjones.plus.com>
 <20181015000147.GB13510@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d3d291ea-00d2-f0dd-5a43-cbea5476d64d@ramsayjones.plus.com>
Date:   Mon, 15 Oct 2018 01:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015000147.GB13510@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGq8Lln/gHmJ/V0Jc/0Bl1DoS+DzzAIAVhYc3qloQEcobVZqzQ1nL5vcfSFFSs07jSy34MxcfYE16rm/27FYU9oGKC6JzZ8ZEQFJU2tTkj2aoeVbGDKd
 axfuh87/lbkCZNZBfEJBmaJXVbvCMCHX4X4JWDj83IJhQWDu7R75kKEz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/10/18 01:01, Jeff King wrote:
> On Sun, Oct 14, 2018 at 04:03:48PM +0100, Ramsay Jones wrote:
> 
>>> So I kind of wonder if a comment would be better than xsize_t here.
>>> Something like:
>>>
>>>   if (avail > len) {
>>> 	/*
>>> 	 * This can never truncate because we know that len is smaller
>>> 	 * than avail, which is already a size_t.
>>> 	 */
>>> 	avail = (size_t)len;
>>>   }
>>
>> Heh, you are, of course, correct! (that will learn me[1]). :-D
>>
>> Hmm, let's see if I can muster the enthusiasm to do all that
>> testing again!
> 
> For the record, I am not opposed to including the comment _and_ using
> xsize_t() to do the cast, giving us an assertion that the comment is
> correct.

Heh, I haven't found any enthusiasm tonight. Let's see if there
are any more comments/opinions.

Thanks.

ATB,
Ramsay Jones

