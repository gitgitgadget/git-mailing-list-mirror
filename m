Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6330C20248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCNAyy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:54:54 -0400
Received: from avasout01.plus.net ([84.93.230.227]:42922 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCNAyy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:54:54 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 4Ee2hNyqkbKva4Ee3h76J9; Thu, 14 Mar 2019 00:54:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cdb8UELM c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=EBOSESyhAAAA:8 a=9Kb_mmEdrIPCyOE3YvkA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] packfile: use extra variable to clarify code in
 use_pack()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <a026ce9f-b825-7fc2-2ad5-c0b00bc508b4@ramsayjones.plus.com>
 <20190314001940.GD31968@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <aca43222-bd4f-ec4d-9cbf-bc85623d34fc@ramsayjones.plus.com>
Date:   Thu, 14 Mar 2019 00:54:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314001940.GD31968@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHnzA2PjZdpVT9Me1qBmlFq3XHM4v1bJiqvbpuK5ci9uM57RRQEO84cLSZbL8fF24jIq8NjB1JWyHtuaEUpIKjAHIuGG55Ixi6XIiLL0NwPzbGB26UfM
 HTszK96YA7BA2xUOf8onG43r1vYyPzYRyChOMCejL4hAtbwgizy8eViVNP7Ybu7VVaUYKGi+Cu6gfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/03/2019 00:19, Jeff King wrote:
> On Wed, Mar 13, 2019 at 09:49:58PM +0000, Ramsay Jones wrote:
> 
>> From: Jeff King <peff@peff.net>
>> [...]
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> 
> Signed-off-by: Jeff King <peff@peff.net>
> 
> Naturally. :)
> 
>> As promised, I am forwarding a 'saved' patch from Jeff, which was
>> a by-product of a long-ago discussion regarding commit 5efde212fc
>> ("zlib.c: use size_t for size", 2018-10-14).
>>
>> I have tested this patch on 'pu' (@6fd68134c8) and directly on top
>> of commit 5efde212fc. (see branch 'mk/use-size-t-in-zlib').
>>
>> However, whilst I have been waiting for the tests to finish, I have
>> been looking at the code and concluded that this does not _have_ to
>> be applied on top of commit 5efde212fc. (I haven't done it, but just
>> tweak the context line to read 'unsigned long *left)' rather than
>> 'size_t *left)' and this should apply cleanly to 'master'. Also, it
>> would have _exactly_ the same effect as the current code! ;-) ).
> 
> I think it does apply, though the reasoning in the commit message of
> "this is OK because 'left' is large enough" becomes a lot more
> hand-wavy. The patch is not making anything _worse_, certainly, but the
> fact of the matter is that "left" still might not be big enough, if it
> is not a size_t.

Yep, the commit message would have to change (it says 'left' is
a size_t), but I think the patch is _still_ an improvement on
the existing code, even without s/unsigned long *left/size_t *left/.
(ie the code is still 'clarified'). :-D

Anyway, it was just an idle FYI while waiting. ;-)

ATB,
Ramsay Jones
