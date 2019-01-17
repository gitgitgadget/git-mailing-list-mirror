Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE4C1F454
	for <e@80x24.org>; Thu, 17 Jan 2019 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfAQQvS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 11:51:18 -0500
Received: from avasout05.plus.net ([84.93.230.250]:35752 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfAQQvS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 11:51:18 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id kAstglSV952tXkAsug9UW1; Thu, 17 Jan 2019 16:51:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=c9mFvy1l c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=S-bXDHK2l8b5HSV5epoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] repository.c: fix sparse warning
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <419519f9-1b48-93bb-eead-eacf6b383f70@ramsayjones.plus.com>
 <CACsJy8BWfdCwFwhfKku-AqP5sGpB7CN4O-Qu0b1cm3iTbW8Z_Q@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b6aaaa72-03cd-2b3d-7328-f7a2fb0d85a2@ramsayjones.plus.com>
Date:   Thu, 17 Jan 2019 16:51:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BWfdCwFwhfKku-AqP5sGpB7CN4O-Qu0b1cm3iTbW8Z_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDZT22zEKAZBDJg57UWIwKpvv2G0ExzRp2bMnkx54pPwqofq4l50GmFekIhJGp9N4TRACzB724pdcj9jyQEZBBII+JmRhaSPTixxWBsd7teNDi1Lihyb
 LaIPogx0O7tLxZT1LAKjNTplleT0YM/BTnbAjuoqDbnbw+fOSTWAqTSd/TLp5I9XYedh1jjlzlYP7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/01/2019 10:06, Duy Nguyen wrote:
> On Thu, Jan 17, 2019 at 8:21 AM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Duy,
>>
>> If you need to re-roll your 'nd/the-index-final' branch, could you
>> please squash this into the relevant patch (commit 4478671442,
>> "cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch", 2019-01-12).
>>
>> [the warning is caused by the lack of the extern declaration of the
>> 'the_index' symbol.]
> 
> Is it a false alarm? The variable is actually defined in this file now
> which should also function as a declaration, yes?

Ah, no, absolutely not! :( (er, well yes, but no! :-D ).

I hope you agree that _all_ uses of a symbol should be within
the scope of the same declaration of that symbol (by #include-ing
the same header/interface file). This is _especially_ true of
the file which has the definition of that symbol - how else do
you expect the compiler to detect a mismatch between the declaration
and definition?

ATB,
Ramsay Jones
