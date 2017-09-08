Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FDFD1FADE
	for <e@80x24.org>; Fri,  8 Sep 2017 20:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757017AbdIHUCb (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 16:02:31 -0400
Received: from avasout08.plus.net ([212.159.14.20]:60897 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756976AbdIHUC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 16:02:27 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id 782Q1w0050M91Ur0182SEf; Fri, 08 Sep 2017 21:02:26 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=4oVNRaoNqDAnDs92RIsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Re: cat-file timing window on Cygwin
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
 <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
 <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net>
 <20170826211104.GC10378@dinwoodie.org>
 <c5f3fe2d-6d76-7c08-2a50-fb10c66adc48@ramsayjones.plus.com>
 <20170827113358.GF10378@dinwoodie.org>
 <0822303f-63b1-13e2-be43-8e2e4dab478e@ramsayjones.plus.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8f7e5a78-a90b-68b8-712f-25367819f46c@ramsayjones.plus.com>
Date:   Fri, 8 Sep 2017 21:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0822303f-63b1-13e2-be43-8e2e4dab478e@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/08/17 16:47, Ramsay Jones wrote:
> On 27/08/17 12:33, Adam Dinwoodie wrote:
[snip]

>> Cygwin 2.8.3 hasn't been released yet, 
> 
> Heh, yes, I found that out myself this afternoon. ;-)
> 
>>                                         but I've just tested the latest
>> development snapshot with Jeff's simple test case, and it works as
>> expected, so I'm going to assume the Git test will start passing once
>> that version of the Cygwin DLL is released too.

I noticed that cygwin 2.9.0 has been released, so I updated and
ran test t8010-cat-file-filters.sh which, as expected, now passes.

Since the above failure was caused, in part, by an errant errno
value, I decided to try reverting the fix for t0301-credential-cache.sh.
(ie. commit 1f180e5eb9, "credential-cache: interpret an ECONNRESET
as an EOF", 27-07-2017). However, that re-introduces the failure! ;-)

[I haven't done a complete test-suite run yet, but I don't expect
to have any failures - famous last words!]

ATB,
Ramsay Jones

