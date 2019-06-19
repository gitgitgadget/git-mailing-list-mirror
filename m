Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386CB1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 12:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfFSMuv (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 08:50:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:43485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731731AbfFSMuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 08:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560948640;
        bh=yYkoqH5HOjDqNBrqp2+aNPfpeJLUm5Dd7Ew2zvGMmIw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RdrwFpTTSeobBPgML09CUuuivgew+OGf2mgpVsQ7joQSxho87iQnrVDfDtacyyaIo
         HaECnDCBI/SgHEN6MoxCKEb1FryOQA1IGwmxu4pmIxMReev4SNdndPbVpoB23pHowQ
         eUReKio084OBgM0Im2LKDBE0FPXm4B7tiGXmICsk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1iIQZP3bnw-00esgk; Wed, 19
 Jun 2019 14:50:39 +0200
Date:   Wed, 19 Jun 2019 14:50:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 13/17] msvc: support building Git using MS Visual C++
In-Reply-To: <CAPUEsphHXxa6xbckKym7Nbx_E6aOzJYL+5j=xXa0oe3BLMrtbQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906191442240.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com> <CAPUEsphHXxa6xbckKym7Nbx_E6aOzJYL+5j=xXa0oe3BLMrtbQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lEn8cLyymnlnVyxGww4XDo7I7RqSHT/ZrJVmqsXw/sofmtfxBKs
 8Y8oTluIKYRHGnOdFU4yRuWV0bWI4rgoQ5FIbbnHk0tO9hFpRq2ZEJBCjm2iAc7xYppqpkX
 +p+2boDoWz4FuMBj+ZKadqkk+A6RU8pEzX+pV55Yahs3q4CDobNqH94yeUD3vbU+DkLncPC
 Y0zzbnovyJNhEVgHgNJTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LYfZTerZV60=:ROQhLATvp+7YSw1hnK+B2C
 Yr2+W6UV8msvgPES5GL47dQHCYbBto0tC2uG63uoSDfyZm8YPUQrZ/HJQMEHBVoo+26UCZpc8
 3w3qcrPgOCF3xsSGCtT07i04xW7ilf5yqc20l1Z9DXxIii9iztSzWi2dKn42Tzxt0miyWzaYf
 de9TcZUNnFZSBEKcmQG//GkOLM+xbVue0rx7U4Ab6eqPaiGGQR4ZZ7TVhF1SlMPm2Z5agy9XH
 97hz3z7VsVNLwQUaYuTxL/crJcSyvMlqVVG6D6+73unnieQ7WBzaJrcab0appTgtELkHzZSLr
 ilBiI4Z3CWOqlqY32aiJswR9qgIVqygABvX2soAbXV4KeOiDeYnAIWY7pNbkYIE3F4GILUChw
 Q4ckbiNvem4q0HwNsOdv4ZBxXjWyYN0lCPqA43Xx8lMwUSfsjeElXgP6j38fmk7DSZ/lUA/Hd
 yOpQRpaYluYUwvheMAa55J0NiUkO2xgDhupOXNeRmPehykX4aVL2i6+wTDzuzhQSpbuAB2srL
 +ipTxfOEOgRJEnCEQ7eJ4k0eyNam6QCoYOk+BR0i7/I4v6CWmdTpnL3LN3KmIO2fhFFvEtAzb
 K39mS9ncP2/KGHkez47kx5YKRqGViw925hvtlDWZKaFF3MDt3E5qV+rBHXfrwn2d1b6F2skxC
 ltC4Bi8RJNYJnREKAZLM3CMvykO2g5dxyqs2VPLPKQVIHLLNiXo7VDtjMzHuWdpXUNIHw+BKs
 qv0XSHmtjz7CYQfzImI64UlIrnR1iwUZo0SV8kS7O5fugaBAB8SJYsJacjkGy5+8KFZMmLn7Y
 ewxOdH8KR8s7Cf8ClXxX6cYYx5MB3DbLZJygWORXDqRU+9DjmHP1n8gaKNV3q8tL3Oe+sGeaI
 IRnUWgMmkyEPR6e4aE29R9rcMOqDy6V7HuzzMcf+xex0RVLlBX0Pj/1Kpt8czxWl/Dd+tHLLf
 Wh9SLl7cIbf9vpJdM9M1/0J3xKGoDB9Gbbyh5A6ZHKbvlpbuaMXHq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Tue, 18 Jun 2019, Carlo Arenas wrote:

> On Tue, Jun 18, 2019 at 5:26 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index d14d33308d..667285887a 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -2388,6 +2388,12 @@ static void maybe_redirect_std_handles(void)
> >                                   GENERIC_WRITE, FILE_FLAG_NO_BUFFERIN=
G);
> >  }
> >
> > +#ifdef _MSC_VER
> > +#ifdef _DEBUG
>
> why not use DEBUG instead (without the leading underscore), then you
> could also drop the -D_DEBUG below

As per
https://docs.microsoft.com/en-us/cpp/build/reference/md-mt-ld-use-run-time=
-library?view=3Dvs-2019,
the convention is actually to define `_DEBUG` in debug mode and `NDEBUG`
in release mode (yes, it's a bit redundant and possibly contradictory).
My reading is that `DEBUG` is only a historical wart.

> ...
> > +       # BASIC_CLFAGS +=3D -DUSE_MSVC_CRTDBG
>
> typo

Yep, and a copy-edited of the tyop I introduced in df5218b4c30b
(config.mak.uname: support MSys2, 2016-01-13)!

Thanks!
Johannes
