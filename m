Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5131F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 01:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbdASBWu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 20:22:50 -0500
Received: from avasout05.plus.net ([84.93.230.250]:33659 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdASBWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 20:22:49 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id a1Nl1u0010srQBz011Nn9V; Thu, 19 Jan 2017 01:22:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Hr8GIwbS c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=LkHKaP6xa2scjFK4L1kA:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] attr: mark a file-local symbol as static
To:     Brandon Williams <bmwill@google.com>
References: <89290015-7c5f-1a5d-e683-59077ae55bf5@ramsayjones.plus.com>
 <20170118230541.GE10641@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <993c0278-03ae-a28a-df29-beed9864a4ae@ramsayjones.plus.com>
Date:   Thu, 19 Jan 2017 01:22:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170118230541.GE10641@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/01/17 23:05, Brandon Williams wrote:
> On 01/18, Ramsay Jones wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Brandon,
>>
>> If you need to re-roll your 'bw/attr' branch, could you please
>> squash this into the relevant patch (commit 8908457159,
>> "attr: use hashmap for attribute dictionary", 12-01-2017).
>>
>> Also, I note that, although they are declared as part of the
>> public attr api, attr_check_clear() and attr_check_reset() are
>> also not called outside of attr.c. Are these functions part of
>> the public api?
>>
>> Also, a minor point, but attr_check_reset() is called (line 1050)
>> before it's definition (line 1114). This is not a problem, given
>> the declaration in attr.h, but I prefer definitions to come before
>> use, where possible.
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
> 
> Yes of course, I believe Stefan also pointed that out earlier today so I
> have it fixed locally.

Yep, I noticed Stefan's email just a few minutes after I hit
send! ;-)

> For attr_check_clear() and attr_check_reset() the intent is that they
> are the accepted way to either clear or reset the attr_check structure.
> Currently most users of the attribute system don't have a need to clear
> or reset the structure but there could be future callers who need that
> functionality.  If you feel like they shouldn't be part of the api right
> now then I'm open to changing that for this series.

No, I just wanted to check that they were intended to be part of
the public api and that you anticipate additional callers in the
future.

[I would still prefer definitions before use, but many people would
not agree with me, so ...]

ATB,
Ramsay Jones


