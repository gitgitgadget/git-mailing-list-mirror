Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9BA202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 13:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbdGHNjA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 09:39:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44707 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdGHNjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 09:39:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3x4Xcy05V1z1qrf0;
        Sat,  8 Jul 2017 15:38:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3x4Xcw6V4Rz3jgY6;
        Sat,  8 Jul 2017 15:38:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id s8Evsh3Vn7FS; Sat,  8 Jul 2017 15:38:56 +0200 (CEST)
X-Auth-Info: n8+gn1G+fli+1RNsEKo8LT/gEjpGwev5UVt7oZ2rP4xTcaRfuzaZicj9CTrKy57V
Received: from igel.home (ppp-88-217-9-219.dynamic.mnet-online.de [88.217.9.219])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  8 Jul 2017 15:38:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2C94F2C378E; Sat,  8 Jul 2017 15:38:55 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in gitdiff_verify_name()
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
        <87tw2ngp94.fsf@linux-m68k.org>
        <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de>
X-Yow:  YOU PICKED KARL MALDEN'S NOSE!!
Date:   Sat, 08 Jul 2017 15:38:55 +0200
In-Reply-To: <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 8 Jul 2017 13:43:02 +0200")
Message-ID: <87o9svgia8.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 08 2017, René Scharfe <l.s.r@web.de> wrote:

> Am 08.07.2017 um 13:08 schrieb Andreas Schwab:
>> On Jul 08 2017, René Scharfe <l.s.r@web.de> wrote:
>>
>>> Avoid running over the end of another -- a C string whose length we
>>> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
>>> with another C string.
>>
>> That's not a good justification for the change, since memcmp never reads
>> past the differing characters.
>
> Interesting.  Where does that guarantee come from?

Sorry, I misremembered.  It's only memchr that has this restriction.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
