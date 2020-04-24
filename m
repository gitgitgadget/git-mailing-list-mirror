Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F1C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B820920781
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="KkmBbKxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDXQqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:46:05 -0400
Received: from avasout04.plus.net ([212.159.14.19]:57940 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXQqF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:46:05 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2020 12:46:04 EDT
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id S1LTjk3G4pB7IS1LVj63fe; Fri, 24 Apr 2020 17:38:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587746313; bh=yTWranyKvv7dEOoReRdeYzJxRJRep8sv3qpiBVuM9eI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KkmBbKxAthsmmUQybpDJdA2bsKKOGRb3XjdSAabFEorD/UhH4evOlmU5gZb7dcjNO
         oDnjhxZexpQnQFiWMqbPMkNRon4jjA2Cnj1xCtCJVJ7w4L2h1c1OcPRSJXAAcGzByf
         O/PM4z14vv7PvTrS51NWl7dfNU4pi5/Um0BiHctha/ug3mjHSaxkyF3zi08eRYFaWT
         gYyke6elVFnyBVGS3iTgAzVHDvGd5s1BWOyNZ0Sr33vMXGkbbPFgzBWP2uZUYbNcSJ
         oaVJ65LfRwJxD4mq1rygk8ZH1a1I2vIRrW/VLXPv9RO/6+A9NAX6JzQtjApLSt0nar
         fqwh7533m0uuw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MKb7ZPRl c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=mDV3o1hIAAAA:8 a=eD07B8ZR4W1u9_2MgIgA:9
 a=QEXdDO2ut3YA:10 a=Dm5x6NYEbZUA:10 a=9S8CEPD2kXIA:10 a=6Pze8sSNJw0A:10
 a=GXUAyPBqdsIA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=_FVE-zBwftR9WsbkzFJk:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/4] fix make sparse warning
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <86ef24e2-3ab6-5e9c-900b-0eb4dbc1bb04@ramsayjones.plus.com>
 <20200423235809.GA1949@danh.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4ff17acf-42dc-5a00-bb61-b055144075eb@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 17:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423235809.GA1949@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMEkEmcZBr6SGYNA2P6a/uC9YMrs46ifjCCRFh6lG5YHisHSJIHe2oNE81BD65xRjZfnKxIOU/RcfH1mBSJs6xtljx1JuQDq0+1vDWFnArzCvtjWsdrn
 vIUf1PIIKdgTwCXVyBF6C0Z19ZmTWMdr3S36A21DPxwRormx6et3bQecgZCCs5pwOcX0o3Ff3ZoASQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/2020 00:58, Danh Doan wrote:
> On 2020-04-24 00:10:25+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
>>> It's happened that I tried to run make check on project that support autoconf.
>>
>> I try to ignore autoconf as much as possible, so I don't know why people
> 
> For some reason, people refer to autotools as autohell
> 
>> who use it regularly seem to expect a 'make check' target (is that anything
>> to do with ./config.status --recheck?).
> 
> Because it's autotools's recommendation.
> https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Basic-Installation.html#Basic-Installation
> https://www.gnu.org/software/automake/manual/automake.html#Standard-Targets

Ah, OK, that explains alot! :D

I have never seen that documented before, so thanks for the reference.
Having said that, most all 'autotools' projects I have seen have had
an 'make test' target and _not_ 'make check'! (Well, thinking about
it, none of those were actual GNU projects - maybe that's the difference).

[snip]
>> For those interested, the 'too much warnings' on the 'pu' branch looks
>> like (for pu@faf094bf11):
>>
>>   $ make sparse >psp-out 2>&1
>>   $ diff nsp-out psp-out
>>   154a155
>>   >     SP refs/reftable-backend.c
>>   406a408
>>   >     SP t/helper/test-proc-receive.c
>>   447a450,511
>>   >     SP reftable/basics.c
>>   > reftable/basics.c:157:6: warning: symbol 'reftable_malloc_ptr' was not declared. Should it be static?
>>   > reftable/basics.c:158:6: warning: symbol 'reftable_realloc_ptr' was not declared. Should it be static?
>>   > reftable/basics.c:159:6: warning: symbol 'reftable_free_ptr' was not declared. Should it be static?

[snip]

>>   >     SP reftable/writer.c
>>   > reftable/writer.c:231:31: warning: Using plain integer as NULL pointer
>>   > reftable/writer.c:299:39: warning: Using plain integer as NULL pointer
>>   > reftable/writer.c:347:47: warning: Using plain integer as NULL pointer
>>   > reftable/writer.c:426:31: warning: Using plain integer as NULL pointer
>>   > reftable/writer.c:468:45: warning: Using plain integer as NULL pointer
>>   > reftable/writer.c:584:11: warning: symbol 'debug' was not declared. Should it be static?
>>   >     SP reftable/zlib-compat.c
>>
>> Also, my static-check perl script says the following symbols are not
>> used outside the file which defines them (so they could be marked static):
> 
> All of them are in reftable, and they're catched by `make sparse`,
> too.

Yeah, I didn't even look at the output. ;-)

However, the output from static-check.pl is usually a super-set
of the those from sparse - because sparse is really only looking
at the declarations (or lack thereof) in one compilation unit.
In contrast, static-check.pl looks at all object files to tie up
definitions with use (so across compilation units). (which is also
why you have to be careful not to leave stale '*.o' files laying
around when switching branches).

ATB,
Ramsay Jones

