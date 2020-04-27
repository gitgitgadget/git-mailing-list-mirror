Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346AC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7877920728
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="O8ooUHH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD0RV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:21:28 -0400
Received: from avasout03.plus.net ([84.93.230.244]:35215 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0RV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:21:28 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id T7RdjKHo9NXR9T7RejCW0p; Mon, 27 Apr 2020 18:21:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1588008086; bh=uLrani8D7xdzCIx/Q12V7+va/6hZVsqxtyBEGtJu/1A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O8ooUHH8mb6yKo/fKhjwt3qRp2j6BThfwzzrBBZHIv40rZ8pQMjQ63JI8Zdrr0XiJ
         dNwhuwqG82cpVhqi5zWZiVAp2Bkm+XvNs3GrbhpwEmCJMNG1x9MdDIlz6KHM2wwzg7
         UTOfxSgtPAyJEXow0Zyrs3I+zbMwWLvkcRzx/wt7qesSMrE9uKGqBWqDQdNxYh8fy+
         +rKDdugTw56efYUdAGUYfBLkmpha6+ta4FC3m8zA66GRJUho0yFwegcKMg0kYLSGg9
         iyvBjAbaDMb0Zy3IKeA5wkY+GWkE+EhKagRcmTKzVfmeqh61gvn+vxWYQC8wn58WR/
         5lY755yV7ehaA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Et9JURUA c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=6I5d2MoRAAAA:8 a=3tcz3bTJAAAA:8 a=0mq98zFbAAAA:8
 a=mDV3o1hIAAAA:8 a=pRbr4py6dXifj1iuCjwA:9 a=QEXdDO2ut3YA:10 a=zlJ5AU5v9O4A:10
 a=IjZwj45LgO3ly-622nXo:22 a=4EbjBm0RLgFgoQzmu6QD:22 a=eO0a9QsEYSaFKO5jcxMN:22
 a=_FVE-zBwftR9WsbkzFJk:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
 <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
 <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
 <20200427010821.GD14800@danh.dev>
 <f3af49c7-6c35-d2f6-c87c-e7342b1c2b6f@ramsayjones.plus.com>
 <20200427164649.GA31366@danh.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <55e4e613-fc64-2626-1e06-47d6151bafef@ramsayjones.plus.com>
Date:   Mon, 27 Apr 2020 18:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427164649.GA31366@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBTOUAHdewGdxSGeYtG98EE8fwbYM8jCBvSAKkzn6fbMAZJLQ2wMu9rfX51rKxkON2Q7eyUQ9wRhmKpNg3VHJS+4AgO8ApN7U7T8BGqy0KVyhhG73i9Z
 lYeqYtmOxQPxBeTllE/cQG0q6cq9z7ujJ7JbncFffCPo0KjK/MNn0IFW7KCocqDsp3dpoGMGOSeHsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/04/2020 17:46, Danh Doan wrote:
[snip]

> It looks like <alloca.h> is GNU's invention.
> 
> *BSD defined it in <stdlib.h>:
> https://www.freebsd.org/cgi/man.cgi?alloca
> https://man.openbsd.org/alloca
> https://netbsd.gw.com/cgi-bin/man-cgi?alloca+3+NetBSD-current

Yeah, that would make sense. It's been about 25 years since I used
a BSD based system (Hmm, Irix changed its base from AT&T to BSD at
one point; or was it the other way round - I forget!)

>> As it happens, even on glibc systems, the <alloca.h> header is included
>> by the <stdlib.h> header, unless you take steps to suppress it. So, we
>> would have had the same issue, if it wasn't for the aforementioned
>> '#undef alloca' the the glibc header file.
> 
>>From above information, I think it's fine to include <stdlib.h> first.
> It's AT&T Unix's invention and everyone seems to follow it (except Windows,
> but the lack of complains from our Windows friends may signify that
> their alloca is fine already).
> 
> I've sent it already for v3.

Yep, looks good.

>> When I need to look at pp output, while debugging things like this,
>> I cherry-pick a patch to the Makefile:
>>
>>   $ git diff
>>   diff --git a/Makefile b/Makefile
>>   index 6d5cee270c..cd8753bf54 100644
>>   --- a/Makefile
>>   +++ b/Makefile
>>   @@ -2423,6 +2423,9 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
>>    %.s: %.c GIT-CFLAGS FORCE
>>           $(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>>    
>>   +%.i: %.c GIT-CFLAGS FORCE
>>   +       $(QUIET_CC)$(CC) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) -E $< >$*.i
>>   +
>>    ifdef USE_COMPUTED_HEADER_DEPENDENCIES
>>    # Take advantage of gcc's on-the-fly dependency generation
>>    # See <http://gcc.gnu.org/gcc-3.0/features.html>.
>>   @@ -2474,7 +2477,7 @@ http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
>>    endif
>>    
>>    ifdef NO_REGEX
>>   -compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
>>   +compat/regex/regex.i compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
>>           -DGAWK -DNO_MBSUPPORT
>>    endif
>>    
>>   $ 
> 
> I think it's worth to have this included. `.s` rules is there, anyway.

Hmm, I can't remember if I ever actually submitted a patch; I've had
this patch floating in my git repo for about 10 years or so! ;-)
I don't use it very often, but it's very useful when needed.

ATB,
Ramsay Jones

