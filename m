Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEAD1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 01:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeJYJzO (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 05:55:14 -0400
Received: from avasout03.plus.net ([84.93.230.244]:35140 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJYJzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 05:55:14 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id FUOBgEjxsO2g2FUOCgfuJW; Thu, 25 Oct 2018 02:24:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=C6mKuMgBzr4_TqTqwj8A:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
 <20181023210154.32507-1-avarab@gmail.com>
 <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
 <20181024074400.GA31239@sigill.intra.peff.net>
 <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
 <20181025010905.GA4458@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a5535030-65c1-613c-e4ea-d4379b243b87@ramsayjones.plus.com>
Date:   Thu, 25 Oct 2018 02:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025010905.GA4458@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOp2T+ki5mtbJp6TCToEPb38oPLXt0GkQwKrWJ0H/dH1Q89PiaRjxfAhVvqu/jquMV3GUjozfXvneus6cdQtds4zUxbDwoamMPpDEkwbfylEfEw48sVb
 Vvkl7881IKnUSQOvw/XyS3gSDLB66/wioEOuG/dm2bsq2AqeNTBn70xV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/10/2018 02:09, Jeff King wrote:
> On Thu, Oct 25, 2018 at 10:00:31AM +0900, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> but then you lose the default handling. I think if we added a new
>>> option, it would either be:
>>>
>>>   # interpret a value directly; use default on empty, I guess?
>>>   git config --default=false --type=bool --interpret-value "$GIT_WHATEVER_ENV"
>>>
>>> or
>>>
>>>   # less flexible, but the --default semantics are more obvious
>>>   git config --default=false --type=bool --get-env GIT_WHATEVER_ENV
>>
>> Yeah, my thinko.  The latter would be closer to what this patch
>> wants to have, but obviously the former would be more flexible and
>> useful in wider context.  Both have the "Huh?" factor---what they
>> are doing has little to do with "config", but I did not think of a
>> better kitchen-sink (and our default kitchen-sink "rev-parse" is
>> even further than "config", I would think, for this one).
> 
> Heh, I thought through the exact sequence in your paragraph when writing
> my other message. That's probably a good sign that we should probably
> not pursue this further unless we see the use case come up again a few
> more times (and if we do, then consider "config" the least-bad place to
> do it).

I was thinking:

  $ git var -e GIT_WHATEVER_ENV

[-e for environment].

... but that is really no different than git-config. ;-)

ATB,
Ramsay Jones



