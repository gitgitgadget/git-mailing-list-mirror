Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A1C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 16:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF16A206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 16:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Qju2J23g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgDZQZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:25:04 -0400
Received: from avasout03.plus.net ([84.93.230.244]:49022 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgDZQZD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 12:25:03 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id Sk5SjIvD1NXR9Sk5TjBuRK; Sun, 26 Apr 2020 17:25:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587918302; bh=JG4SAoeDA8IyyQ5UKdWfcjVLcK7X145PkiU/rjIs29Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qju2J23gzi8HD+hw5k+/2nWX3n/OLjR3b+qmTe+LUmyjVY1lzT8hx1yQwW8EFTjvP
         EDy51MheTGTYE6rEpHBFg74HT1Olf086WA3+7fD07pDjopKxRQ3RqX0BvUMaeCC1C+
         TmDrsLdyOlsfcri/3Ib2gJzshhQ5ex5BFP2eWJFvnc3HYlU1DyR3zGowOMxHqVxRLu
         5RdVMoCZZtf+dbAzDSmDAZfB1641W3U08jJ4USJSzFx/aaQOUPxX0hwxbQZj1CpN19
         7kmhA1Asfsq8A4RI8YH54Xib0kMLgr/JiUCccrZJraf2gligsoOcgUY7YRQnAlBLbV
         NK64yG+X2m1+Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Et9JURUA c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=5p_tG3gqAAAA:8 a=w0RzvLSWAAAA:20 a=OG28PukoKu8pJPdwfKgA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/4] fix make sparse warning
To:     Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2004251511550.18039@tvgsbejvaqbjf.bet>
 <20200426033201.GA14800@danh.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <45522b6a-76a4-a7d9-3cce-a3581aaca899@ramsayjones.plus.com>
Date:   Sun, 26 Apr 2020 17:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426033201.GA14800@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCRLGRXB0jBgf1d6+iareoJIb6hrWSGlsg8lStd/5vS1DS/IeHcQzuXAabMx8yf78OaPH+nLK81wXBTOAuw7xzmkbFEaIABTRnsEjR2W/N0rCL3zlg6u
 mm3MzQuDoAFsr1GKrbSE2oEowfN+JhixcSgp+NTT6W1yXZKWh5h9zy3R2bjtk8bg/J91NhrR8AK8MA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/04/2020 04:32, Danh Doan wrote:
> On 2020-04-25 15:13:53+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi Danh,
>>
>> On Thu, 23 Apr 2020, Đoàn Trần Công Danh wrote:
>>
>>> It's happened that I tried to run make check on project that support autoconf.
>>> Git's Makefile told me to run `make sparse` instead.
>>>
>>> I /think/ if we have a rule in Makefile, we should adhere to it.
>>> I also fix another change in ds/blame-on-bloom, which I think it's worth to
>>> fix, see: <20200423133937.GA1984@danh.dev>
>>
>> FWIW there is still an Azure Pipeline building `sparse` for Ubuntu every
>> two weeks: https://dev.azure.com/git/git/_build?definitionId=10&_a=summary
>>
>> I created this Pipeline in order to support the proposed project at
>> https://github.com/gitgitgadget/git/issues/345 which is: teach our CI
>> builds to run `make sparse`.
>>
>> Maybe it is time to tackle that?
> 
> I don't think it's ready, yet!

Heh, not too long ago, the 'master' and 'next' branches were 'sparse clean'.
(on non NO_REGEX builds anyway, and even on those for some of us. ;-) )
The 'pu' branch was frequently 'unclean', of course.

ATB,
Ramsay Jones

> 
> May be it's.
> 
> But we'll need
> 
> 	make sparse |
> 	grep -v -e 'plain integer as NULL pointer' \
> 		-e 'redeclared with different type'
> 
> The first one for:
> 
> 	struct foo val = { 0 };
> 
> to zero structure.
> 
> The second one for different in declaration and definition (which is
> fixed in sparse's master).
> 
> 
