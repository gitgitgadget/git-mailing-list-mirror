Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1C81F858
	for <e@80x24.org>; Wed,  3 Aug 2016 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbcHCNrq (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 09:47:46 -0400
Received: from avasout07.plus.net ([84.93.230.235]:44698 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcHCNrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 09:47:45 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout07 with smtp
	id Sdni1t00423PrXV01dnjkx; Wed, 03 Aug 2016 14:47:43 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=g8U9EZG_aLTQ-AW1PcIA:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
Subject: Re: [PATCH] apply: mark some file-local symbols static
To:	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com>
 <CAPc5daVo2o7zxTGVARoZc8AmX2WAJC1cWB4R=9sG8TH8ddKkuA@mail.gmail.com>
 <CAP8UFD2NFZCAF=ZWNf4YF+F2L7A4ZM0XS98o-cR_MjuLLR8pfg@mail.gmail.com>
Cc:	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2e615a57-cf15-9deb-0a35-d6bbe175edfa@ramsayjones.plus.com>
Date:	Wed, 3 Aug 2016 14:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2NFZCAF=ZWNf4YF+F2L7A4ZM0XS98o-cR_MjuLLR8pfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 03/08/16 10:47, Christian Couder wrote:
> Hi Ramsay,
> 
> On Wed, Aug 3, 2016 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Tue, Aug 2, 2016 at 3:33 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>> ---
>>>
>>> Hi Christian,
>>>
[snip]

>>> What am I missing?
> 
> These symbols are still used in builtin/apply.c until 9f87c22 ("apply:
> refactor `git apply` option parsing") at the end of the series, for
> example:
> 
> $ git checkout 4d18b33a
> $ git grep -n apply_option_parse_directory builtin/apply.c
> builtin/apply.c:86:                     0, apply_option_parse_directory },
> 

Heh, thanks. I thought I had done exactly this, but I obviously
messed up!

[snip]

> Yeah, I did not notice that they no longer need to be extern.
> Now there are different options to fix this:
> 
> 1) remove the symbols in 9f87c22 ("apply: refactor `git apply` option
> parsing") at the end of the series, or
> 2) move 4820e13 (apply: make some parsing functions static again) at
> the end of the series and make it also remove them, or:
> 3) add another patch to remove them after 9f87c22 ("apply: refactor
> `git apply` option parsing")
> 
> My preference is to do 1). This way, or if I do 3), I would not need
> to resend the first 31 patches in the series.

FWIW, I would go with option #1.

ATB,
Ramsay Jones


