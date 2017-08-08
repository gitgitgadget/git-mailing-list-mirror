Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E212E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 23:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdHHXzM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 19:55:12 -0400
Received: from avasout05.plus.net ([84.93.230.250]:44884 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdHHXzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 19:55:12 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id unv91v00D18PUFB01nvBWz; Wed, 09 Aug 2017 00:55:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=MZYHxiS0tvsB-1DhoTQA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] builtin/add: add a missing newline to an stderr message
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
 <2821200b-0428-a5dd-9680-f291cee0ec47@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a04808d5-8a53-d9d7-0168-55a9aa79cf7b@ramsayjones.plus.com>
Date:   Wed, 9 Aug 2017 00:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2821200b-0428-a5dd-9680-f291cee0ec47@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/08/17 22:45, René Scharfe wrote:
> Am 08.08.2017 um 23:36 schrieb Ramsay Jones:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> I noticed this while looking into the t3700 failure on cygwin tonight.
>> Also, I couldn't decide whether or not to add the i18n '_()' brackets
>> around the message. In the end I didn't, but will happily add them
>> if you think I should.
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
>>
>>   builtin/add.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index e888fb8c5..385b53ae7 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -43,7 +43,7 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
>>   			continue;
>>   
>>   		if (chmod_cache_entry(ce, force_mode) < 0)
>> -			fprintf(stderr, "cannot chmod '%s'", ce->name);
>> +			fprintf(stderr, "cannot chmod '%s'\n", ce->name);
>>   	}
>>   }
>>   
> 
> FYI: I brought this up yesterday in the original thread, along with a
> few other observations:
> 
>   https://public-inbox.org/git/3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web.de/

Ah, I missed that.

Hmm, I just looked at the code in builtin/update-index.c. Yes, it
would probably be a good idea to harmonize the messages - but just
where did 'flip' come from? ;-)

ATB,
Ramsay Jones

