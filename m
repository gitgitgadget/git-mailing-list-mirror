Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49501F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeIACHQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 22:07:16 -0400
Received: from avasout06.plus.net ([212.159.14.18]:34170 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeIACHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 22:07:16 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id vrQIfcDscWLW2vrQJfdvbi; Fri, 31 Aug 2018 22:57:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=__XXf8WCzrIwuwvZrZAA:9
 a=EriaY9-7dgwbay-p:21 a=bTcOBKxtbnkN0Ccb:21 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180830075431.GF11944@sigill.intra.peff.net>
 <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
 <20180830194634.GE19685@sigill.intra.peff.net>
 <xmqqva7r4nof.fsf@gitster-ct.c.googlers.com>
 <c9d51d68-c7ae-64f9-b3e9-a72f33c5afc3@ramsayjones.plus.com>
 <20180831005426.GA2858@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d2f70c00-5247-7af1-b059-a0f423030977@ramsayjones.plus.com>
Date:   Fri, 31 Aug 2018 22:57:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831005426.GA2858@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGJDM56jLBUcucrFqtjfdRCWFwqH7sPdyeUm1q00S5FzsbedWc4jjfCp9JB8VOVkS8Tat0OtgHRjvYvTRU3ustfxNDTRpmex4EhhWPhV2NO9en8gn21j
 NzH/6v6O/rIG+zTPqLvur87KIgBhQs2JC528CJmzOEXP7ZvgHfa2UUA/bgv6I87RkE/6nfjTYviumw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/08/18 01:54, Jeff King wrote:
> On Fri, Aug 31, 2018 at 12:49:39AM +0100, Ramsay Jones wrote:
> 
>> On 30/08/18 21:14, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> I suppose so. I don't think I've _ever_ used distclean, and I only
>>>> rarely use "clean" (a testament to our Makefile's efforts to accurately
>>>> track dependencies). I'd usually use "git clean" when I want something
>>>> pristine (because I don't want to trust the Makefile at all).
>>>
>>> I do not trust "git clean" all that much, and pre-cleaning with
>>> "make distclean" and then running "git clean -x" has become my bad
>>> habit.  I jump around quite a bit during the day, which would end up
>>> littering the working tree with *.o files that are only known to one
>>> but not both of {maint,pu}/Makefile's distclean rules.  I even do
>>> "for i in pu maint master next; do git checkout $i; make distclean; done"
>>> sometimes before running "git clean -x" ;-)
>>>
>>
>> 'git clean -x' always removes _way_ more than I want it
>> to - in particular, I lost my config.mak more than once.
> 
> Heh. I have done that, too, but fortunately mine is a symlink to a copy
> that is held in a git repository. ;)

:-D

Now, why didn't I think of that! ;-)

ATB,
Ramsay Jones

