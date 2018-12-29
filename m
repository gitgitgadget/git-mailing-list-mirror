Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8515C1F405
	for <e@80x24.org>; Sat, 29 Dec 2018 04:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeL2Emh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 23:42:37 -0500
Received: from avasout04.plus.net ([212.159.14.19]:39694 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeL2Emh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 23:42:37 -0500
X-Greylist: delayed 5784 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 23:42:36 EST
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id d4x0ghIG4AOoyd4x1gvMIQ; Sat, 29 Dec 2018 03:06:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=1iVCE9HKdlCLrhvSmiQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] t5403: Refactor
To:     Junio C Hamano <gitster@pobox.com>, orgads@gmail.com
Cc:     git@vger.kernel.org
References: <20181224212425.16596-1-orgads@gmail.com>
 <20181224212425.16596-2-orgads@gmail.com>
 <xmqqmuopl1qz.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5d3609cd-c934-fd3a-437a-30c6db930093@ramsayjones.plus.com>
Date:   Sat, 29 Dec 2018 03:06:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqmuopl1qz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCVlviB3cLBtMpnEI7M9oaSe5tZLZw5ckby74DeY5B0/BBHqek2zKROdDZFtpLwRHQMktXfElqG1WteCPjFmUFT1XheTqaYs9+iqr8TMoYJiIK4X1aKV
 ndVCgwO6uo07bWRA1LLvPR86r2jtCA2b+x3GIULeVvMKiMAgzVoEfFot
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/12/2018 22:34, Junio C Hamano wrote:
> orgads@gmail.com writes:
> 
>> Subject: Re: [PATCH 1/2] t5403: Refactor
> 
[snip]
>>  if test "$(git config --bool core.filemode)" = true; then
> 
> This is a tangent but this conditional came from an ancient d42ec126
> ("disable post-checkout test on Cygwin", 2009-03-17) that says
> 
>     disable post-checkout test on Cygwin
>     
>     It is broken because of the tricks we have to play with
>     lstat to get the bearable perfomance out of the call.
>     Sadly, it disables access to Cygwin's executable attribute,
>     which Windows filesystems do not have at all.
> 
> I wonder if this is still relevant these days (Cc'ed Ramsay for
> input).  

Ah, no, the 'tricks we have to play with lstat' mentioned in that
commit message are long gone! ;-) If you remove that conditional,
then the test passes just fine.

ATB,
Ramsay Jones
