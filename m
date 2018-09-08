Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3D61F404
	for <e@80x24.org>; Sat,  8 Sep 2018 22:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIIC6D (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 22:58:03 -0400
Received: from avasout06.plus.net ([212.159.14.18]:40559 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeIIC6D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 22:58:03 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id ylRFfuhC5WLW2ylRGfoXMG; Sat, 08 Sep 2018 23:10:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=96aTsS6CZgoN24keTB4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: git silently ignores include directive with single quotes
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
 <20180908211436.GA31560@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
Date:   Sat, 8 Sep 2018 23:10:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908211436.GA31560@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPyucLHZ6Nh7R+k7doF3tZamrmlHoeugQe5qyCE3h/7qwwaPM/Bt8WlPCMrqoBYx4z844+7/Gb+fSN9xufU7VRlD2ntNvuPvrzSJKLxA9uMud1ohwKIc
 4ku1wNPfGCzDSdTtIHIIhuvF68PURoxjB1C3Hx+ZnPIkrmi6b9oFAdH4/ZCK2nWBSmvUud2NbXbDTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/09/18 22:14, Jeff King wrote:
> On Sat, Sep 08, 2018 at 09:54:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> The reason missing includes are ignored is that the way this is expected
>> to be used is e.g.:
>>
>>     [include]
>>         path ~/.gitconfig.work
>>
>> Where .gitconfig.work is some configuration you're going to drop into
>> place on your $dayjob servers, but not on your personal machine, even
>> though you sync the same ~/.gitconfig everywhere.
>>
>> A lot of people who use includes rely on this, but I see from this
>> thread this should be better documented.
> 
> Right, this was an intentional choice at the time the feature was added,
> to support this kind of feature. I'd note also that it mirrors other
> misspelled keys. E.g.:
> 
>   [include]
>   psth = whatever
> 
[snip]
> That said, it _does_ behave the same and people are likely depending on
> it at this point. So if we introduce a warning, for example, there needs
> to be some way to suppress it.
> 
> Probably:
> 
>   [include]
>   warnOnMissing = false
>   path = ...

I was going to suggest, inspired by Makefile syntax, that
[-include] would not complain if the file was missing ...
except, of course, it's too late for that! ;-)

I suppose [+include] could complain if the file is missing
instead, ... dunno.

ATB,
Ramsay Jones

