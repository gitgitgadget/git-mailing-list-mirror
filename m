Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0342C207F8
	for <e@80x24.org>; Wed,  3 May 2017 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757578AbdECTtE (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 15:49:04 -0400
Received: from mout.web.de ([212.227.15.14]:61543 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754402AbdECTtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 15:49:03 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M95ET-1dDwtJ1hdN-00CPoo; Wed, 03
 May 2017 21:48:40 +0200
Subject: Re: [PATCH v3 02/25] winansi: avoid use of uninitialized value
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
 <cover.1493740497.git.johannes.schindelin@gmx.de>
 <758b5a5dbe83832db7362246127b8bd1ca7beb9f.1493740497.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <243bb3c1-d01f-f5e5-544e-2ece2a4e5844@web.de>
Date:   Wed, 3 May 2017 21:48:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <758b5a5dbe83832db7362246127b8bd1ca7beb9f.1493740497.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bl9v0O3jmVdzOQDvGjbwZjd+FoHHJNnM0qjySQIzn0AvK06qk3r
 8R3So3HlH4mnIlU1zwSNxWN3i7gqfx2569qTXXQ8AQ2lkQAkTKnW0Yy7wkNdRIXZVltu0ek
 JkrFGIAAVREZwoe1XeNiHK1QAxjn5u/Iq99d5nUGUd1HX7797Fkfr8cCpjvy5Iihh/nQxbi
 XRq+wyzeIwQm+HgpYc36Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2PxcWizutKk=:6KF7uVgng4MHLKyQFbH+Ds
 UusWxMS3vxlOA7yk2+tiRtNQU6rmNIkj3HCCg/HBKgwrNK9gTi5vKu8UvjTYjsWuV+vqY/lH4
 +roCd+vrZaDcgPdlzHsFD8q5qfCsrXJnWjSMxL6888hj1GKD3H2Ke+NUPpnPeVSaX6f9lqPks
 1dO1nAtip7moTyApbs3s/x5sl5GiM/ZK/YdfnWeuED5ryKXWe32GN7yoaPdiCzkg59GFyKV5m
 98lVlLGl+GR+A68dwmcUQ07fWQt9wMz2b7hiizif+dcUutHE4Vfn8F6KiBG559EbEzqGbjNVd
 +z2BKFl7Mb72VgPbTNeAmjv3uPgBY+ORPzLmhN6BoonRLXZi+xNKo0KCXj34P5OllhVtNgFEu
 t5HDfdvP0v79Cb0vZ82bbEGrAysqjSUkOeH03IbX0s3iOkqp93j2L4xecsPgZOmKnTli+fouj
 28JJpJGnf0zO13ixmO7kRb2Fa1cdRHEIicNqYUsg2qXG2mE3V2QgoZ+4jmhkpHpqhBwq7+HCF
 JFdJ+mk9jKxFU16GRivP+zbczyIsUXa2yAHvGtHaaX3f4msZVO43GqnPsDsd6mB7Ir7Lw+xoq
 f3Zq8FtbrutMNTb414eXPQfFRk7JAoBACNIN7haa2ZRY6jl2CqKeol5UfyJ/thpyHFTAm+XFx
 6/DHLW16CCmn+YiNIexiZDbkywfhInTDBy8ChKY/98h8Xw6RIZVbVh228ootx8j+MUHx7kAtx
 3jPlxrsq5nDiR0/oX9rlclYMLu1meOls2Vz8zgpUVMLs3YwgJYcYC2NPPXq4816RggjG4+Gw8
 8yf3Iez
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.05.2017 um 18:01 schrieb Johannes Schindelin:
> When stdout is not connected to a Win32 console, we incorrectly used an
> uninitialized value for the "plain" character attributes.
> 
> Detected by Coverity.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/winansi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 793420f9d0d..fd6910746c8 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -105,6 +105,8 @@ static int is_console(int fd)
>   	if (!fd) {
>   		if (!GetConsoleMode(hcon, &mode))
>   			return 0;
> +		sbi.wAttributes = FOREGROUND_BLUE | FOREGROUND_GREEN |
> +			FOREGROUND_RED;
>   	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>   		return 0;
>   

So is_console is called with fd being 1 (stdout), 2 (stderr) and 0
(stdin), in that order.  If the first two calls abort early for some
reason we may end up here.  The added code is for white text on black
background.  An alias for that combination, FOREGROUND_ALL, is defined
a few lines down; for a minimal fix it's not worth moving it up.  attr
and plain_attr are both initialized to sbi.wAttributes.

That as a bit more complicated than it looked initially.  The order of
calls is important, "stdout" in the commit message includes stderr as
well and it doesn't just affect plain_attr.

Would a value of 0 (black text on black background) suffice if only
stdin is connected to a console?  Colors don't matter if there is
nothing to see, right?

Anyway, the change makes sense as is, but it took me a while to get it.

René
