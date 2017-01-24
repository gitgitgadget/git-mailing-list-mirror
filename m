Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6291F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdAXSA1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 13:00:27 -0500
Received: from mout.web.de ([217.72.192.78]:53987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbdAXSA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 13:00:27 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qOX-1cJdFD2ckn-00yxHv; Tue, 24
 Jan 2017 19:00:14 +0100
Subject: Re: [PATCH v2 0/5] string-list: make string_list_sort() reentrant
To:     Jeff King <peff@peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b333ecd4-a147-904d-b1ce-b49179c4ad26@web.de>
Date:   Tue, 24 Jan 2017 19:00:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:C85YQSvd0zAUQDNsTCDC42DXgec2qeNqQUYnN2RBys7Ip5B5EFt
 Ai8DN5ZYszm61dm1OctmOjRrQNB2OgVr73xmTMxuT9GUCLPWT+rl5MgTGLBrx/OvYvZkVTa
 7NcCLjNx5aoTnH8ab5IkP8GjBFAn55yek7ZdmD0foc8a3jX1Bx6UICBuN57SHuHguhssRaP
 b1afkaiXTpwgX521g9h0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8BIilTBLV9I=:6kyhOsktMQ+q211+YJcKS5
 aSzaUinKioPY3iAa+3qEL31grLLCzj1xItYAHEj4wCCex7qTnIHkQCkiFNEliS7b3IWOOXRxb
 2aukBfcm4PHt1LDV69Zm2GKYOx2gh6CPXucHGXBj0LsN2iwdmyJaSS5Cw0JndQb3KzFxAvay8
 /U2qnUm47Ha6KvIvwCG5nXhSiU0bDRbY1jENgT3o3kaAv38RB8O6tvsfZUEzVcnSD1eRecO5z
 2za8RYHslPB3lLMwatoTRqvmJm34dGyc/LDsysnEe5QfT76ujRWg12R4iGiKGkdSErPAk/ttJ
 zrThQBMhW+GD94wHlRs4LBT0w2o1UVjUFMOjas7V7HrDom5cBN1oMxIQ7f37hndUa8X6ovhs7
 kHtKX999UE6dVXvdnK+5Gw4jHc7uykglH/h2AeXYgRfRQi9I4U6aCnW2HuiDmDan3wJBaMzBu
 kwckOrEODLUBaVqbdzYWBg0VhBD9yILNOIamGuwkJsw6aOQ6JK2Dw1rM1Mk+CEc8cQx9sYvAw
 RESxW3KfrpIE250eBByEYC0H7gXfxMKmLJTOqKiuTFokGBQiWA20/Wh6F+9IHql01SFz0rWIg
 03YFhgybna50vDv+58sywbzuu/N6eDkE+YMLpFObZUg7JdqLHiVGmTYB+YcjIvLEpb4FKhSHQ
 5S8f+mx+WZJXklY4gpWfax1QKhZzShmlFwyfAUPlfkOlsAhHibazCnARfb/OdAFNrQ18wyFzd
 4WivZ74fAOadu/EQJYNl9nw8canYjraTSCGMW5fW0ZNzpTybl36l8tmFxazj+ns4KNzeHHLsE
 qkMIhOy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.01.2017 um 00:54 schrieb Jeff King:
> The speed looks like a reasonable outcome. I'm torn on the qsort_r()
> demo patch. I don't think it looks too bad. OTOH, I don't think I would
> want to deal with the opposite-argument-order versions.

The code itself may look OK, but it's not really necessary and the 
special implementation for Linux makes increases maintenance costs.  Can 
we save it for later and first give the common implemention a chance to 
prove itself?

> Is there any interest in people adding the ISO qsort_s() to their libc
> implementations? It seems like it's been a fair number of years by now.

https://sourceware.org/ml/libc-alpha/2014-12/msg00513.html is the last 
post mentioning qsort_s on the glibc mailing list, but it didn't even 
make it into https://sourceware.org/glibc/wiki/Development_Todo/Master.
Not sure what's planned in BSD land, didn't find anything (but didn't 
look too hard).

René
