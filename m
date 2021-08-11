Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FFC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A344060FA0
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHKO61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:58:27 -0400
Received: from mout.web.de ([212.227.15.3]:36977 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhHKO60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 10:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628693873;
        bh=+ueJ+9o06uVfRQrVHVzw7hGPlyfH17/SmqYGXc+jcNQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z2vy9LcW9KpZg9CYNT5tc9OdICla6cQEAQRX+FrLCuk0GTzu6djES2SYqjhJqkXcs
         n0mjxTIiZRGuGk9Z8Or1RW38RrpWL36Cp3rubHo17qk+kbJ6n+IXMRCDWpSTnJnucC
         kprJC+y83P1Yl/t3EjWiSvEDPRZQ9ADP9rWN9tIU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MDMzC-1mN94J0scQ-00ArNm; Wed, 11 Aug 2021 16:57:53 +0200
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org, Andrzej Hunt <andrzej@ahunt.org>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <xmqqtujyftzx.fsf@gitster.g>
 <YRIZsOaguDW0HaeI@carlos-mbp.lan>
 <0b973579-748e-ce2f-20aa-a967765cce83@web.de>
 <CAPUEspiWdGRQoBnpn_uwjkqV7ffMm+MkzbNVU1rZ6yCwkpmNaA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1a18a701-7d14-d6c5-6929-30636e688006@web.de>
Date:   Wed, 11 Aug 2021 16:57:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiWdGRQoBnpn_uwjkqV7ffMm+MkzbNVU1rZ6yCwkpmNaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nH/t8AFWRBmX5+WtOMnhHzdCM9BPwKi5OsbllgqxSq46TSlUyff
 tgxd1pSrUUj7pgGBwvjpVBSArzCXKURxwqw4QKSMBVlrSi3UWYe/w2aXYp9Z23SYoGqjOh7
 EVqijZDXHlXm4cs+uqFGGFdxAKvZ+k2h8ia9ex6MKCUyi3+qEKt47d/GdvXxj7NVecE/agE
 yarzOeSGhx4EMp41GsSwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ycgR3U+xBQ=:BuTBbNHwtFYEXfcTI+fk7N
 Y4dwFol1s5X4bjWEBCc95a2np0kgwXsnNgpspCF5hAQtC0sulWm/0oSt3nmtBEtJ5xtQYDgqh
 kPyK66uPKxlhW9B6KUy0DNhAuMDD27N/zwfJKi4WKOGaadS3h7iM2cfrhJYm9I4p9APqiC9M5
 vrV9zA+lYvuXVT++9qwEzRPRgjlRQ1Q9RdhmXAW13fHDzTax0CVWyD2X0EgZUu4UZ8wseG9Wn
 +ShtKCH6Zw3oEWtyUof8OykXDw2vZ4T+Hy9cRHXz3cmfgJrnTYeD7OvnJ6ILGcE2h76qki9E1
 Xvsw0W0gv9mC//XNHcu1xbKS+6bep/8fyYNZits3zIlV5zETSZSRlGc6tA4oLajM9RhT4kmyQ
 0XV+WHwfK7B2ieXzdKoC2gddk+6GcPNk2JtowOCON3J3vIUcWmLShmn5EDJ7NbqFc08sQn910
 i1/qArBBwJ1F0eBmhSye7IRmnp6N9ObXHjW/rGF0bVWq9mY8JpA8l8JXiM4S1cD0tHHrgBcvh
 VnHoUMFaZqyAc0A7QZWNf7uUVxZ0fklttQccp5+ymN2vXj8VoE2n5U+qXfB6irtTowdRkllBV
 CLKYczX2MN8qKAKtNCfUO3QWcMnNPqhZMfKQe2cGiLUfBWg0lkvXvSNu+beumvrVRIhwAJLYY
 NJJQXCQsvOLnC3ZC/Q3z4VBezDwkGbFxhsI0VaOjVEYzqKyewJZgbv/PSF9AsVC19KtPd58wC
 0Jpwz4D5lfmOnFj18cN6T691SAWtF9zOkYplJ4k+8xT08vPSlPNbwcb8FmNUZ/h9E9+8sAnDH
 v1BNBEXcarC0vw9OUWu1I89qm8Fvb52rm6J6kteTow0kHT7FD3vyKwCNhB0J0XXdI5QklxBp+
 MsqIm/MVom8PLLUbOrsnkJVO/tUGgoSHYyzUWJkvhqO67WWC05aEpQFkLWLWv1ORNyxQhGJvM
 og0vdGF6jZ9VjBbDvQZw/z3s1NaacfQqM4SkxGCF693ZJ2vgROJvAkxrGqhJzW+q8/TTsvrma
 B2PGVmY70347YkjRAgNe/IB+t/zc10zzX8almtyn0mtDOr/r8X8R4hvJdEp+gKenY86nGyW76
 Mhx+H39kGpTmWbhk2ZYqm4sWuRlonTewYk+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

Am 11.08.21 um 01:49 schrieb Carlo Arenas:
> On Tue, Aug 10, 2021 at 12:30 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Those are different issues and they should be addressed by separate pat=
ches,
>> I think.  That's why I submitted a patch for the second one in
>> http://public-inbox.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de=
/.
>
> agree, and that is why I mentioned not to merge mine but use your
> whole series instead when it is published (mine was just a stopgap to
> see if I could get SANITIZE=3Dundefined to behave meanwhile, but that I
> thought would be worth making public so anyone else affected might
> have something to start with)
>
> would at least the two included in the chunks above be safe enough for
> RC2 as I hope?, is the one with the additional int too hacky to be
> considered for release?;

I think your -pedantic fixes 1 and 2 should go into the next possible
release candidate because they fix regressions.

Same for my signed-left-shift fix in
http://public-inbox.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de/
(or some improved version if it's lacking in some way) and the yet to be
published fix for the alignment issue.  I assume Andrzej as the reporter
or Eric as the original author would like to have a shot at the latter.

> FWIW hadn't been able to reproduce that issue
> you reported in t3301 even with an Apple M1 with macOS 11.5.1 (I use
> NO_GETTEXT=3D1 though, not sure that might be why)

Strange.  I use Apple clang version 12.0.5 (clang-1205.0.22.11) on the
same OS.

At least the reproduction on Linux that you mentioned in your reply
means I can calm down a bit because it's not just a problem on my
system..

Thank you,
Ren=C3=A9
