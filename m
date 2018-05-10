Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211F91F51A
	for <e@80x24.org>; Thu, 10 May 2018 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEJTsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:48:05 -0400
Received: from mout.web.de ([212.227.17.11]:42165 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbeEJTsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:48:03 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1eOeGL1EyZ-00yTok; Thu, 10
 May 2018 21:47:58 +0200
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
Date:   Thu, 10 May 2018 21:47:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:epVrg9O/Yb5KUqB/s4b7qLuSe1dRsWJdzeBxEedTjqbJF7f8cPn
 SmNsoqo72wOjXxLGdPc/AK1yZJDV7e3tdlfbg1KlrvEm8kbzGWgpwZhCArYp0t6bZ/xmhU9
 6C7GmTQP2nrXSO4IOp2Kqn9zY+RrdWKs5smpJ8icPjq26TbRfYWL1AA52q67mOhN+raYyQs
 T9HRgX2LErpc8WxyPvQ7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xWJzcrYVprU=://8xFafl7rkHAmAYp1PhB/
 63e+qiIptDusrrZjptj7fBKMP+R6PBHvLA8VGUukPXPkK7kC+QSLgwry7gQ43C+bhOjI+wOS5
 48+7PkM/qIVPDtJBd0oykqq1iiCMz15iFzPyG3zsNJ83ir0TyrMHL+oKOUsZiktEYOx8kJET8
 VWTX2AqpbbSXI6u56Kvn82JQ5a7TrF3HslUHKDoUx5ANLyiCGAbBXKUlhUfUAj3D5qDRVeAY7
 SHkFhSTIZvX2SGzt0E3lSgktt1AHhIguStk+oXpVKdYGhs1eAP8t+yZqRQ222RLNXkFjH7izJ
 +dV4NGHrX1/LIjRRVIiys5/++Hh9M0JB5hKV0JbBrnUysolSgQkkp9TItq4aPKjKmRTdCdnC/
 gttycAWaMoErHPcVInu5MGfD5WGDD6Ys5jfAc6of8pd2oAWUFjiLua1Smnib6vf1NeDI+Ue1l
 E5qQmMRWcrkOWJdBh7fTAILOf1YvIdySO/BaLCvq5Kr6GG3esAdtdoectYjmb0OEMXYUTGZBt
 gkWS2gXuv+WcXkHMe5VGIqWADEsBqR0aLDG9NjNi4/s2RF/GHSy38z2N4nWunnAiJF2HWmIXN
 eYBxhXUUGjM/+CD8HOTJhzNBTu9iargw2nFhh9KMS/zns3yPf3H1AzUN8edy4dBo74zRGt6IE
 wAwzr/v0YsU7b3Je8YX/qRDs8bc9sPU/1bkgZLDje+OdK3HvxNFjil5chxp+HPj5M6n7VRtfM
 ao1crue1Z1nj23BAbQlwk29+n0j7frbFVflH5guThni2Kpa3PjCsUxuRH15Dz/ubcoWsfS9EC
 M2fSNm0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.05.2018 um 12:51 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> The standard says about uintptr_t that "any valid pointer to void can
>> be converted to this type, then converted back to pointer to void, and
>> the result will compare equal to the original pointer".  So void * ->
>> uintptr_t -> void * is a proper roundtrip, but that doesn't imply that
>> casting arbitrary uintptr_t values to void * would be lossless.
>>
>> I don't know an architecture where this would bite us, but I wonder if
>> there is a cleaner way.  Perhaps changing the type of the decoration
>> member of struct decoration_entry in decorate.h to uintptr_t?
> 
> In order to ensure "void * -> uintptr_t -> void *" roundtrip holds,
> the implementation would guarantee that uintptr_t is wider than
> void*, so what you suggest technically makes sense.  We should be
> able to store any pointer in the field.  And we should be able to
> store any value of an unsigned integral type that is narrower than
> uintptr_t.
> 
> But it somehow feels backwards in spirit to me, as the reason why we
> use "void *" there in the decoration field is because we expect that
> we'd have a pointer to some struture most of the time, and we have
> to occasionally store a small integer there.

Yes, fast-export seems to be the only place that stores an integer as
a decoration.

>  So I'd naively expect
> that
> 
> 	uint32_t mark = 23;
> 	de->decoration = (void *)mark;
> 
> would be a good way to store mark #23 in the field and
> 
> 	uint32_t mark;
> 	mark = (typeof(mark))de->decoration;
> 
> would be a good way to read it off of the "void *" field.  Of
> course, this assume that (void *) is at least as wide as 32-bit and
> it also ignores the standard ;-)

Right, it looks deceptively good and works fine if memory is flat and
valid values for pointers are in a contiguous range starting at zero.
The standard allows for other models as well, though.

> This is an unrelated tangent but the mark-to-ptr() and ptr-to-mark()
> implementations feel wasteful, especially when we worry about 32-bit
> archs.  A naive platform implementation of
> 
> 	(uint32_t *)mark - (uint32_t *)NULL;
> 
> would be ((uintptr_t)mark) / 4, i.e. the de->decoration field will
> always have two LSB clear and only utilize top 30-bit to represent
> the value of mark.

That's right, but I don't see what's naive about it, or how a 32-bit
architecture could avoid wasting those two bits.


Using struct decorate in fast-export has the benefit of not
requiring separate allocations for individual entries.  Switching to
struct hashmap would require individual allocations.  Adding a
custom clone of decorate with a uint32_t payload would be an option.

René
