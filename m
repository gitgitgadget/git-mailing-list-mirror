Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8E51F829
	for <e@80x24.org>; Sun, 30 Apr 2017 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161970AbdD3SAf (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 14:00:35 -0400
Received: from avasout08.plus.net ([212.159.14.20]:35479 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033875AbdD3SAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 14:00:34 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id Ei0X1v00A1keHif01i0YjG; Sun, 30 Apr 2017 19:00:33 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=NEAV23lmAAAA:8 a=DYPoQUnK8p-edqDCVI0A:9
 a=pILNOxqGKmIA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in
 path'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
 <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com>
 <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org>
 <a575542a-e5b6-389f-e240-d5ac5a4b4107@ramsayjones.plus.com>
 <f9dfd9b4-e753-1a53-175e-8f20fe904501@kdbg.org>
 <alpine.DEB.2.20.1704291232410.3480@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4f88f1ec-eedc-1249-ef12-238a73d1dc7a@ramsayjones.plus.com>
Date:   Sun, 30 Apr 2017 19:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704291232410.3480@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/04/17 11:44, Johannes Schindelin wrote:

> On Sat, 29 Apr 2017, Johannes Sixt wrote:
>> Am 29.04.2017 um 02:15 schrieb Ramsay Jones:
>>> On 28/04/17 20:54, Johannes Sixt wrote:
>>>> Am 28.04.2017 um 05:09 schrieb Junio C Hamano:
>>>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> I don't observe these failures. Are you using a vanila MSYS2 environment?
> 
> Please note that the "vanilla MSYS2 environment" is *not* expected to pass
> the test suite when compiling in MINGW mode. In fact, it is expected to
> fail.
> 
> In 2015, I made a couple of changes to the MSYS2 runtime in preparation
> for the big bump to Git for Windows 2.x (which switched from the old MSys
> environment to the new MSYS2 environment), and released Git for Windows
> 2.5.0 with a heavily patched msys-2.0.dll. My hope was that those changes
> would be welcome in the MSYS2 project, but well, they kinda weren't. So I
> was forced to abandon my original plan to contribute all of those fixes to
> "upstream MSYS2".

Oh WOW. I didn't know you were maintaining your own version of
the MSYS2 runtime. That must be a huge PITA. :-D

> To see the changes I (and others) made:
> 
> 	https://github.com/git-for-windows/msys2-runtime/compare/master%5E%7B/Start.the.merging.rebase%7D...master
> 
> I even started collecting the exact tests that are failing with the
> vanilla MSYS2 runtime vs Git for Windows' fork, when I still had hopes
> that we could test things with AppVeyor (but the builds were already too
> slow, we hit the timeout even before trying to run the tests, so I gave up
> on that front):
> 
> 	REM MSYS2's runtime does not carry Git for Windows' tweaks yet, so these
> 	tests cannot pass:
> 	set GIT_SKIP_TESTS='t0003 t0006 t0024 t1100 t1400 t1402 t1501 t1504 t1506
> 	t1508 t1513 t3001 t3070 t3200 t3301 t3400 t3404 t3513 t3703 t4116 t4150
> 	t4208 t4211 t5000 t5001 t5002 t5004 t5500 t5601 t5602 t5603 t5801 t6006
> 	t6018 t6041 t6130 t6132 t6300 t7201 t7400 t7501 t7502 t8002 t8006 t9001
> 	t9350 t9700 t9903'

I have only (fairly) recently installed MSYS2, so I've only ever
run the MinGW64 test-suite once, which for me failed on tests:

   t0003, t0006, t0026, t0060, t0200, t0204, t1100, t1400, t1402,
   t1501, t1504, t1506, t1508, t1513, t3001, t3070, t3200, t3301,
   t3400, t3404, t3406, t3703, t3903, t3905, t4208, t4211, t5000,
   t5500, t5516, t5601, t5602, t5603, t5615, t5801, t6006, t6018,
   t6030, t6038, t6130, t6132, t6300, t7201, t7400, t7401, t7406,
   t7501, t7610, t9001, t9020, t9350, t9700, t9903

(which I found somewhat intimidating!).

So, as you would expect, it hasn't improved much! :-P

Hmm, I was hoping to use this installation to test some git patches
on MinGW, but that looks like a lost cause. I may as well save some
disk space and delete it!

Thanks.

ATB,
Ramsay Jones


