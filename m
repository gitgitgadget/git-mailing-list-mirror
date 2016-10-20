Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E271F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbcJTUi1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:38:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27387 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbcJTUi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:38:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t0LHN0D4Hz5tlJ;
        Thu, 20 Oct 2016 22:38:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6BDE5534C;
        Thu, 20 Oct 2016 22:38:23 +0200 (CEST)
Subject: Re: Drastic jump in the time required for the test suite
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610201154070.3264@virtualbox>
 <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <530a3bca-e251-cb43-fb6a-e99c1e64a0a7@kdbg.org>
Date:   Thu, 20 Oct 2016 22:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.10.2016 um 14:31 schrieb Jeff King:
> Close to 1/3 of those processes are just invoking the bin-wrapper
> script to set up the EXEC_PATH, etc. I imagine it would not be too hard
> to just do that in the test script. In fact, it looks like:
>
>   make prefix=/wherever install
>   GIT_TEST_INSTALLED=/wherever/bin make test
>
> might give you an immediate speedup by skipping bin-wrappers entirely.

Running the tests with --with-dashes should give you the same effect, no?

-- Hannes

