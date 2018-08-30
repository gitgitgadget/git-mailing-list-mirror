Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4D01F404
	for <e@80x24.org>; Thu, 30 Aug 2018 23:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeHaDyU (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 23:54:20 -0400
Received: from avasout07.plus.net ([84.93.230.235]:57644 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeHaDyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 23:54:20 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id vWh1flejYjlDzvWh2ftoDe; Fri, 31 Aug 2018 00:49:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=viJLg71AaVlS8H9KoNAA:9
 a=M1YOofZegMB8ItoO:21 a=35Rv1NEDlrlXCSGx:21 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180830075431.GF11944@sigill.intra.peff.net>
 <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
 <20180830194634.GE19685@sigill.intra.peff.net>
 <xmqqva7r4nof.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c9d51d68-c7ae-64f9-b3e9-a72f33c5afc3@ramsayjones.plus.com>
Date:   Fri, 31 Aug 2018 00:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqva7r4nof.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDQrT/geOg27ptyLPgQPiMFic1ygfWaipb1M2TtX3Twlje+ui+ERz7dKeQyab+qFeLWYXwt5awhE8ErJt5Mrp6XXvBTkG62Q9Gxlj3qxRmoANypPzGJU
 NW5k2Ca+sRTABvw7UNbIMqXGK7SEKwPBJqHxEVCzCa7rT8dMQT27aZInxpq3NtCY1r0zqHTOueQZ5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/08/18 21:14, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I suppose so. I don't think I've _ever_ used distclean, and I only
>> rarely use "clean" (a testament to our Makefile's efforts to accurately
>> track dependencies). I'd usually use "git clean" when I want something
>> pristine (because I don't want to trust the Makefile at all).
> 
> I do not trust "git clean" all that much, and pre-cleaning with
> "make distclean" and then running "git clean -x" has become my bad
> habit.  I jump around quite a bit during the day, which would end up
> littering the working tree with *.o files that are only known to one
> but not both of {maint,pu}/Makefile's distclean rules.  I even do
> "for i in pu maint master next; do git checkout $i; make distclean; done"
> sometimes before running "git clean -x" ;-)
> 

'git clean -x' always removes _way_ more than I want it
to - in particular, I lost my config.mak more than once.

So, no I don't trust it. ;-)

ATB,
Ramsay Jones

