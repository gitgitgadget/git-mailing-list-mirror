Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F55920A40
	for <e@80x24.org>; Sun, 26 Nov 2017 17:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdKZRnd (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 12:43:33 -0500
Received: from avasout04.plus.net ([212.159.14.19]:53178 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751046AbdKZRnd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 12:43:33 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id J0xle3WIqzbmWJ0xmeGrXf; Sun, 26 Nov 2017 17:43:31 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=twwbvcQvIRU_hx687qgA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <CAP8UFD1YY_f4Ds0sYK86OBb7Wyud_YWr2Wx8nx1pdnwSsPgJ8A@mail.gmail.com>
 <xmqqbmjpitl2.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2sWE9cZe=OO1UQjf6Boih=Go9xJg=gDgEUzbXNuood5w@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <be2b6fd3-b405-7537-ba38-60d5eb2b341a@ramsayjones.plus.com>
Date:   Sun, 26 Nov 2017 17:43:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2sWE9cZe=OO1UQjf6Boih=Go9xJg=gDgEUzbXNuood5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC9+dX9fUEgdH9QHLP6RAPbmvJlzXjmkrO/Yo5oazn4rCpTihVoC0Y1604j5LMktvhq9qWcj/GmvbAwstfagqTJS7vZGoMOe++v9vsp40SuX59rPwiQc
 qiA4nqe8AgY/8BB+v4cH7hDki2P0Q/8moMbLkt4ntgdlOTyiCc/c69AV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/11/17 14:00, Christian Couder wrote:
> On Sun, Nov 26, 2017 at 4:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> On Mon, Nov 20, 2017 at 6:15 PM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> By default running `make install` in the root directory of the
>>>> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
>>>> and "gitk-git" sub-directories to build and install these 2
>>>> sub-projects.
>>>
>>> Has this patch fallen through the cracks or is there an unresolved issue?
>>
>> I had an impression that the conclusion was that the existing error
>> message at runtime already does an adequate job and there is no
>> issue to be addressed by this patch.  Am I mistaken?
> 
> This patch is mostly about what happens at the build step. Its goal is
> not much to improve what happens at runtime, though that is improved a
> bit too. If the build step was good enough, then I would agree that
> what happens at run time is adequate.
> 
> Let's consider only people installing git using "make install" to use
> it on their machine, as I think I already discussed the case of
> packagers and added the BYPASS_TCLTK_CHECK variable for them.
> 

I haven't been following this thread too closely, but I have the
feeling that the best course of action is to simply not fall back
to using a tcl version of msgfmt in the first place!. ;-)

If a given platform does not have gettext/msgfmt, then you just
don't get an i18n-ed version of git. (no need for BYPASS_ ...).

Am I missing something?

ATB,
Ramsay Jones

