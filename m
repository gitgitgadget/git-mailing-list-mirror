Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5644A1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756305AbcLNTSi (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 14:18:38 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:43166 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750991AbcLNTSX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 14:18:23 -0500
Received: from bsmtp1.bon.at (unknown [192.168.181.108])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3tf5vd4jG3z5vsB
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 20:18:21 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tf5t46p0yz5tlD;
        Wed, 14 Dec 2016 20:17:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 845EB2216;
        Wed, 14 Dec 2016 20:17:00 +0100 (CET)
Subject: Re: [PATCH v2 28/34] run_command_opt(): optionally hide stderr when
 the command succeeds
To:     Jeff King <peff@peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de>
 <2637bed1-c36f-32f6-b255-ea32da76d792@kdbg.org>
 <20161214125322.o3naglvyuzgk2pri@sigill.intra.peff.net>
 <20161214130640.ginadvry7wor3tkc@sigill.intra.peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f4a72743-3488-3466-5b9f-0dacec102a54@kdbg.org>
Date:   Wed, 14 Dec 2016 20:17:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161214130640.ginadvry7wor3tkc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.12.2016 um 14:06 schrieb Jeff King:
> On Wed, Dec 14, 2016 at 07:53:23AM -0500, Jeff King wrote:
>
>> On Wed, Dec 14, 2016 at 09:34:20AM +0100, Johannes Sixt wrote:
>>
>>> I wanted to see what it would look like if we make it the caller's
>>> responsibility to throw away stderr. The patch is below, as fixup
>>> of patch 29/34. The change is gross, but the end result is not that
>>> bad, though not really a delightful read, either, mostly due to the
>>> strange cleanup semantics of the start_command/finish_command combo,
>>> so... I dunno.

The cleanup semantics of start_command and finish_command are not that 
strange as I thought first. I just hadn't looked well enough.

>>
>> I don't have a strong opinion on the patches under discussion, but here
>> are a few pointers on the run-command interface:
>> [...]
 >
> And here is a patch representing my suggestions, on top of yours. Not
> tested beyond "make test".

Thank you, that looks way better.

If there is agreement that this approach is preferable, I think we can 
have patches on top of the series; they would be orthogonal and do not 
have to take hostage of it. (And it looks like I won't be able to follow 
up until later this week[end].)

-- Hannes

