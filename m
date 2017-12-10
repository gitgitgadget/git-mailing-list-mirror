Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09391F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbdLJVCr (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:02:47 -0500
Received: from avasout04.plus.net ([212.159.14.19]:54096 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751100AbdLJVCq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2017 16:02:46 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id O8kFemRU3zbmWO8kGeQXLf; Sun, 10 Dec 2017 21:02:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=v4k-zLG_aTZ2N9TvizcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: t9001 failures on 32-bit Linux?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com>
 <CACBZZX7+tTCNrLQzjh2dP-bnty3BegpaO+xrUqJQ7_Nh22JyDw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <95fe2703-07b2-88a7-dfe6-c3c29cb565a3@ramsayjones.plus.com>
Date:   Sun, 10 Dec 2017 21:02:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX7+tTCNrLQzjh2dP-bnty3BegpaO+xrUqJQ7_Nh22JyDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPRGNOa00ShBY5JICuJdIMvivsDkurvUIYg3AN+UjZxy6G8nnE+jxcWAnUlaTw7b3g6JwMrz5ak33RV/Ai87S+tNPPpygtjcT0kZR9iuXCP9K23JMsQ1
 0VBwJM1WaJQsxUIgeucPL1uhtepWzsVJNxRvDJ27K8ze+/9HMCK285T5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/12/17 20:33, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Dec 10, 2017 at 8:58 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> I noticed the revert of the 'ab/simplify-perl-makefile' branch on
>> top of 'pu'. So, I fired up my 32-bit Linux and attempted to see
>> if I could debug this t9001 test failure.
>>
>> Unfortunately, I could not get it to fail. :(
>>
>> Both of the 'pu' (@77e921d77d) and 'pu~1' (@cfef1ebefd) builds pass
>> the full test-suite and, likewise, running t9001 in a loop for a
>> count of 100 (about 45 minutes run-time each).
>>
>> [If it makes any difference, I don't have sendmail installed (no
>> /usr/sbin/sendmail or /usr/lib/sendmail), or any sendmail in my
>> $PATH.]
>>
>> Sorry I couldn't help with this! :(
> 
> It's a bug in my patch, I'll follow-up with a patch once I figure out
> what it is, but for now I wanted to say it's my bad.
> 
> That this is failing has nothing to do with 32bit per say, but that
> system doesn't have Error.pm installed, so we fall back on our own
> copy, there's some bug in the new Error.pm fallback logic I
> introduced.

Ah, OK, that makes sense.

Thanks!

ATB,
Ramsay Jones


