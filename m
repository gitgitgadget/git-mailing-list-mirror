Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD101F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030476AbcJQRWD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:22:03 -0400
Received: from avasout03.plus.net ([84.93.230.244]:58649 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030397AbcJQRWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:22:01 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id whMy1t0020zhorE01hMzSU; Mon, 17 Oct 2016 18:21:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=uSi3qK7dmUmVTdVgD7kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
 <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610171058580.197091@virtualbox>
 <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <16298e68-c0f9-b7ff-d4b5-0d4b79306377@ramsayjones.plus.com>
Date:   Mon, 17 Oct 2016 18:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/10/16 10:37, Jeff King wrote:
> On Mon, Oct 17, 2016 at 11:04:19AM +0200, Johannes Schindelin wrote:
> 
>>> Gross. I would not be opposed to a Makefile rule that outputs the
>>> correct set of OBJECTS so this (or other) scripts could build on it.
>>
>> You could also use the method I use in Git for Windows to "extend" the
>> Makefile:
>>
>> -- snipsnap --
>> cat >dummy.mak <<EOF
>> include Makefile
>>
>> blub: $(OBJECTS)
>> 	do-something-with $^
>> EOF
>>
>> make -f dummy.mak blub
> 
> Hacky but clever. I like it.
> 
> In the particular case of git, I think I've cheated similarly before by
> putting things in config.mak, though of course an arbitrary script can't
> assume it can overwrite that file.

Heh, I actually have the following in my config.mak already:

extra-clean: clean
	find . -iname '*.o' -exec rm {} \;

But for some reason I _always_ type 'make clean' and then, to top
it off, I _always_ type the 'find' command by hand (I have no idea
why) :-D

ATB,
Ramsay Jones

