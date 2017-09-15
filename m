Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0492220281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdIOQi7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:38:59 -0400
Received: from avasout07.plus.net ([84.93.230.235]:45275 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdIOQi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 12:38:59 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 9sew1w0090M91Ur01sexix; Fri, 15 Sep 2017 17:38:57 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=6aO5gyqN1zcqzLfYSJsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] test-lib: group system specific FIFO tests by system
To:     Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
 <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
 <alpine.DEB.2.21.1.1709150020070.219280@virtualbox>
 <a159230a-d406-c772-13f0-f82a36faf763@grubix.eu>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <42f879a9-c85a-2662-18e2-a5a26e8fb02e@ramsayjones.plus.com>
Date:   Fri, 15 Sep 2017 17:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <a159230a-d406-c772-13f0-f82a36faf763@grubix.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/09/17 11:31, Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 15.09.2017 00:21:
>> Hi Michael,
>>
>> On Thu, 14 Sep 2017, Michael J Gruber wrote:
>>
>>> test-lib determines whether a file-system supports FIFOs and needs to do
>>> special casing for CYGWIN and MINGW. This separates those system
>>> specific settings from those at more central place.
>>>
>>> Set mkfifo()  to false in the central system specific place so that the
>>> same test works everywhere.
>>
>> The mkfifo() emulation of Cygwin seems to work, no? I think it works even
>> in MSYS2, but not in MINGW.
>>
>> So maybe this patch should affect only the MINGW arm?
> 
> I only reorganised the code, so in that sense the patch does not affect
> any system ;)
> 
> If indeed mkfifo works on CYGWIN than a separate patch should remove the
> exclusion of CYGWIN; alas, I can't confirm (I wish MS still had the old
> academic alliance programme).

I haven't tried recently, but back in 2013 Mark Levedahl wrote
in his commit message that mkfifo was known not to work on the cygwin
mailing list. (see commit 9443605b5d, "test-lib.sh - cygwin does
not have usable FIFOs", 04-07-2013) In fact, you can see that this
was disabled on cygwin before MinGW!

It is possible, of course, that fifos now work on cygwin. (I will
put it on my TODO list).

In any event, this is indeed a separate issue.

ATB,
Ramsay Jones

