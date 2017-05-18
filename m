Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D1D201CF
	for <e@80x24.org>; Thu, 18 May 2017 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933837AbdERROl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 13:14:41 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:14136 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932288AbdERROl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 13:14:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wTHqL4vhdz5tlJ;
        Thu, 18 May 2017 19:14:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2D0E9139;
        Thu, 18 May 2017 19:14:38 +0200 (CEST)
Subject: Re: [PATCH 00/23] Prepare to separate out a packed_ref_store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
References: <cover.1495014840.git.mhagger@alum.mit.edu>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6d84ff31-0282-00ec-83d6-9be2a8b7a776@kdbg.org>
Date:   Thu, 18 May 2017 19:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.2017 um 14:05 schrieb Michael Haggerty:
> This patch series is the next leg on a journey towards reading
> `packed-refs` using `mmap()`, the most interesting aspect of which is
> that we will often be able to avoid having to read the whole
> `packed-refs` file if we only need a subset of references.

Which features of mmap() are you going to use? We have only MAP_PRIVATE 
on Windows. We do emulate PROT_WRITE (without PROT_READ), but I don't 
think that code is exercised anywhere. See also compat/win32mmap.c.

-- Hannes
