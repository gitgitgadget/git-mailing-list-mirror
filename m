Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D1E20A26
	for <e@80x24.org>; Thu, 14 Sep 2017 17:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbdINRbL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 13:31:11 -0400
Received: from avasout07.plus.net ([84.93.230.235]:51387 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdINRbL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 13:31:11 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 9VX81w00H0M91Ur01VX9yk; Thu, 14 Sep 2017 18:31:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=FEWp7enXAAAA:8 a=igRvKs3pAAAA:8
 a=KEBdS_LikDasUoXedywA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=IjYSrUNMXUflr7qE6tl5:22 a=TvETph7qJS3LYjDAKe5U:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] test-lib: ulimit does not limit on CYGWIN and MINGW
To:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
 <00b6d2a5508520635956da1d2db656bca126cd1a.1505400392.git.git@grubix.eu>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5b0fcb15-cb02-92e4-29a9-39f45eda1786@ramsayjones.plus.com>
Date:   Thu, 14 Sep 2017 18:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <00b6d2a5508520635956da1d2db656bca126cd1a.1505400392.git.git@grubix.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/09/17 15:52, Michael J Gruber wrote:
> ulimit succeeds (by return value) but does not limit on some systems.
> 
> Set ulimit() to false on these systems so that we do not rely on its
> output nor effect. As an intended side-effect, ulimit based
> prerequisites are set correctly (to "not-have") on these systems.
> 
> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> This is independent of my series, but should best go before so that no
> ulimit based test is run on CYGWIN and MINGW.
> 
> It follows the basic assumption that a tool like ulimit is either
> present and functional or not present; and that we work around by
> defines or such when that assumption is broken.
> (Alternatively, we could set ULIMT_LIMITS or so and depend on that.)

Heh, this was my first suggestion, if you recall, but I decided to
go a different way ... ;-)

Also, Johannes made a good suggestion, which lead to a new version
of my patch (which could easily be extended to cover the FIFO).

I don't have a strong preference for either approach (but I would
have to test your patches, which I haven't done yet), so I would
be happy to see either applied.

ATB,
Ramsay Jones
