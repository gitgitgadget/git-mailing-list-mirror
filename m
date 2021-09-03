Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F2C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AD66112E
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350850AbhICSsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 14:48:43 -0400
Received: from mout.web.de ([212.227.15.3]:39157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350811AbhICSsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 14:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630694823;
        bh=SvYh0a/bwua3VDEduGMCUOnYySdhzQRk23W9GxZlJLY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nNKEqdEo11JJdIg57/IpXN0X7C/lpBORfmtt/XSde62Il4DqDfm3jjDx6G4KWeuO2
         s4nfu2F8jKQninDMYp0zJJgF75gG5uodCzAR10uBezsAjKdB0rMv1FTl3FMDzUBaET
         4Pbm9oqS8ZQ9+TDrKIhyhjjtZlT0nKXwsJKC2P0A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MBjIG-1mGgId33To-00CWBa; Fri, 03 Sep 2021 20:47:03 +0200
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
 <20210903170232.57646-3-carenas@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
Date:   Fri, 3 Sep 2021 20:47:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903170232.57646-3-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5CY2bqnP/8XKEwln9gZp8t7jjZsLaeIXtj+nexM35j324bpfrYj
 AX5yceHMVhSPSf3zVFDHCrpmQrgT3MboRjy/YHqp60qW/hBhnFP4Ms3Sw7x0ebZyu+Lan0m
 dtjz8tRo7eFdDwBn50elJ/IHq163MQJhJtAJKTI22kzmiwPkF3i9RXjIVNoie8+V4V4yWLh
 CxFJy+v+bkuR6cN266rrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kzwvHZgz0Dc=:nG1n113EpNcWKJOWuScnLc
 CLOyIsPQHiqh3367P38q21UhARdYldPUfsp2oIp2oxNnFbN9b9DMigjRbpvPyG0YRWlk4BpTW
 n7ntDzbkQ3u1wgNr1bDap7K/NxPZj2R04rcTWqU9zoagUogF+1PFKjILn3ngl+MHhhFw0KxD8
 BvvOmURRh5jqukiCvC9YdVAtRjcUt0U1hmtBD49CGw+HYbqq/EXQqLMACcFaRiOsKTigUMk68
 cCh0G71k+gSDj+3PMBnnP1TRW+lkmHiAbPB1ajLHCScJ9BwU40Gi56ZS3Mcb3Ldl+P3syWziu
 awtKvhpypzXBxiaXnRhKnSZEDMvoFoO1Utre/EGg2R5vMRc1/CR8+KLG1E3p+9J1YbQijYDR8
 OwCXHGDeYQhr3tdZkdtxA/COq4kdM09nXfueVSW8zJKcZ/e664NpeXKAMejc1vPtXPv76RWzG
 VDROMmxXNpVUBobKvhVkh2/eEb36148HqOveVRawY8lkWA02CRXuC6SAxzm/UJ/+TWxzkMCuU
 EFvXEV1VvlRboSV5rop5jEMXUMiJYCC4WD5/Ks9/opNbTFBG9yHc6j1pgNfv4ayXlXlZDjNYf
 PGrJsS7XNquCIMkhJBIOuCtM0/wIy6oeKBy3ey2JKdzoKaVsqjOjF1R7bduTpkVDs6ddWzBXK
 UTMUhARGbCcY1A43Fg/NwXuxICmTQY2KSMJ0tTaeQA2pzhMKNYXF0cHQLDNIM6S+IZLCrY6wY
 fdAZ66sfRZHPP0dIwN7/Ud5eMCICrsSdryPs7e7y6HGG2aDdm8/yoonTFb0fRNixYwdiUfo0n
 5zeD9TqSan3yNEb9/KkDMm81oWMp24XNIiDTyrvRqT2Aoa+9JaupCoNt7nm5srpumntot2rWp
 yzaDz3fnzXY6nJx1nXD/akyu+aIYJ/omx5ukkgz4ecDdcaW0pCQS+f+6a/gefLyyy1L4prN13
 0+olEnPPTDLV9imnh7cRHKPppXUrF2w7CnkOe47rYt4BO/IitQxebJXrrsRT2f0wK4PPHypUg
 Li5D/Mf9Xj0MJsRpmhdWnlv+MmsRQnPhJCUHhxa8jeby3nV+/qVX2TlWjuZGEMxDfi0WSp5MN
 kHczYeW6rCOZbIh9J3dnyqoLop+xAcJ9RvC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.09.21 um 19:02 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> In preparation to building with pedantic mode enabled, change a couple
> of places where the current mingw gcc compiler provided with the SDK
> reports issues.
>
> A full fix for the incompatible use of (void *) to store function
> pointers has been punted, with the minimal change to instead use a
> generic function pointer (FARPROC), and therefore the (hopefully)
> temporary need to disable incompatible pointer warnings.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> This is all that is needed to build cleanly once merged to maint/master/=
next
>
> There is at least one fix needed on top for seen, that was sent already
> and is expected as part of a different reroll as well of several more fo=
r
> git-for-windows/main that will be send independently.
>
>  compat/nedmalloc/nedmalloc.c |  2 +-
>  compat/win32/lazyload.h      |  2 +-
>  config.mak.dev               | 13 ++++++++-----
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index 1cc31c3502..edb438a777 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -510,7 +510,7 @@ static void threadcache_free(nedpool *p, threadcache=
 *tc, int mymspace, void *me
>  	assert(idx<=3DTHREADCACHEMAXBINS);
>  	if(tck=3D=3D*binsptr)
>  	{
> -		fprintf(stderr, "Attempt to free already freed memory block %p - abor=
ting!\n", tck);
> +		fprintf(stderr, "Attempt to free already freed memory block %p - abor=
ting!\n", (void *)tck);

This change is not mentioned in the commit message.  Clang on MacOS
doesn't like the original code either and report if USE_NED_ALLOCATOR is
enabled it reports:

compat/nedmalloc/nedmalloc.c:513:82: error: format specifies type 'void *'=
 but the argument has type 'threadcacheblk *' (aka 'struct threadcacheblk_=
t *') [-Werror,-Wformat-pedantic]
                fprintf(stderr, "Attempt to free already freed memory bloc=
k %p - aborting!\n", tck);
                                                                          =
  ~~                 ^~~
This makes no sense to me, though: Any pointer can be converted to a
void pointer without a cast in C.  GCC doesn't require void pointers
for %p even with -pedantic.

A slightly shorter fix would be to replace "tck" with "mem".  Not as
obvious without further context, though.

Ren=C3=A9
