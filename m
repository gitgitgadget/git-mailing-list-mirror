Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E01E202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 15:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdIVPg2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 11:36:28 -0400
Received: from avasout07.plus.net ([84.93.230.235]:52710 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdIVPg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 11:36:27 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CfcQ1w0040M91Ur01fcSJn; Fri, 22 Sep 2017 16:36:26 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=WwSdDKjx5jGgRq1FgQQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/4] ALLOC_GROW: avoid -Wsign-compare warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
References: <c97784ce-d85d-2b7a-4eb7-d4043dc1a0b7@ramsayjones.plus.com>
 <xmqqd16jl5yb.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b3846c1f-0335-8afa-c155-c2726f57679c@ramsayjones.plus.com>
Date:   Fri, 22 Sep 2017 16:36:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqd16jl5yb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/17 05:20, Junio C Hamano wrote:
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index a57b4f058..a6ee653bf 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -2563,8 +2563,8 @@ struct in_pack_object {
>>  };
>>  
>>  struct in_pack {
>> -	int alloc;
>> -	int nr;
>> +	unsigned int alloc;
>> +	unsigned int  nr;
> 
> This is a bit questionable ;-) but it is something I can locally
> tweak easily.

Heh, it took me a minute to see what you were referring to! ;-)
Yep, sorry, I don't know how I managed to add the extra space.
(I don't think I can blame vim - PEBKAC).

ATB,
Ramsay Jones


