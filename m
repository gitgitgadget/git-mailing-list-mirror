Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED99C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6EF64DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhBPHVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:21:00 -0500
Received: from [93.83.142.38] ([93.83.142.38]:56572 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229782AbhBPHU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 02:20:58 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 6139C1C529;
        Tue, 16 Feb 2021 08:20:29 +0100 (CET)
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210215155020.2804-2-avarab@gmail.com>
 <xmqq7dn8u7dz.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <10e6cd64-8c1c-20ea-154e-89fad6664a5e@kdbg.org>
Date:   Tue, 16 Feb 2021 08:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dn8u7dz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.02.21 um 02:30 schrieb Junio C Hamano:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>> This new behavior does give us the edge case that if we e.g. view the
>> diff here with "-U150 -W" we'd previously extend the context to the
>> middle of the "is_func_rec()" function, and show that function in the
>> hunk context. Now we'll show nothing.
> 
> To me, that sounds like a grave regression.  Why lose the
> information?
> 
> This may be coming from the difference between us, i.e. I read a lot
> more patches written by other people than my own changes written for
> my next commit, so every bit of hint helps, and the name of the
> function I am seeing its latter half in the precontext is sometimes
> a useful thing to see.

I totally agree with your assessment. I wouldn't even have removed the 
hunk header in the case of "-W wins", either, but that is a case that I 
can live with when others think it makes sense.

-- Hannes
