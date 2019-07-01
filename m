Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE581F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfGAMLh (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:11:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:38915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfGAMLg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561983079;
        bh=noK08a3Tdav03EnXHqflgY6dxnuo+9uGjVKAMs/FUbc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HjqoPsuKxuzxeLnQmMTDx9mmAuRx1/gQcRI/kal0wZyfsIfvfSxpcGjxVRiQoF8hh
         zTJqzw6q3dpgz1WjzL8MUtlZG/6HjfUjvr/6HCFRAUARefH58qUILmoHfGnkKhWC3Z
         t+Y01alZxz+xWgZa01Z6JEYvm+Bhz7G/vb2B4G5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjuR3-1iEV1535In-00bsf9; Mon, 01
 Jul 2019 14:11:18 +0200
Date:   Mon, 1 Jul 2019 14:11:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
In-Reply-To: <20190630222537.GA21696@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1907011409420.44@tvgsbejvaqbjf.bet>
References: <pull.261.git.gitgitgadget@gmail.com> <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org> <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com> <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sQDWYNswyzp4mDYBPcEV6QXt7sxZv4DSPVTcZiS0t+62obzmAfu
 mQeuj+/VI+ldvQUi5/RVWiU87Caw2rBeKF32ud7eyImk33krrNrdSV2CqotwRsZHi52JyXP
 oyhkuDu0dVCg7gI+2Ykedjb6dSUorWRsGI4S0MxwWERS0U5cEfmol+ht7BJaZ99hpHwKQps
 7obQ9Ru/KLNYeWOA76diQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G0ZqAZ5rgws=:mhOurAg7RcQ3DZQX+2vpMr
 LAYJ/xAI5qHlRus6zpuii70cby2G5KjYqEzckXH90X7tSh7Pg7Yiu6qubNi3JDYfIJ+gZFzyZ
 /PF4wKd3toMk8nbd1Q8in0YEx91bCbc60aeQ23ENoDYdV/53cBkhAS3Wam1CB1aqyIvhqTXei
 LJO/55eJk8/RmCmoybyRtX2TL1oIO3qs9TVtsH1DE/pMOtbmMzwZxkDCWomABaHUxDWBoPgIl
 jH0RDKGgS7CHG6JExdNdPI7FKdhU1xyXx9Zkx31c5TeGLqJpqyW+x1I+UizZwhWe53EPQYpRO
 XWXvmgrs/DCvB7OWSzjBKKVJZ9r2b7Uprs0xW9ty1ga5WoZPGNulEZtxwRoblFpjWGgqV0oG1
 7+7BTm16jFT5uc1Og2D8eMdJoEgkr9FH0At1MNbcEYSUxFRfkFJsVF7s7JIzpUQ+1GDISr9QA
 y7nogML3w2wpsS3TpFYdnlMdViwjR5ZVoHEhdejQlFRX90HzN38zWF3LBUe4c6zecteg4G1gr
 RYORxpz4JsmRAQaldLsgXCmnwtqwEfpdniFx55rgHjS9Kt/ms8sRVM6v377ijZ0XZiRZ507xo
 6wK75PmB5mm0poby4LmkAOiyqIQIN3UibHhJIem2kuVci3Oc3Lu2Pp6vEtLZNvQqbGGUMk+Ac
 9jCG8JmR+Y+IdlW1Zhiz3XNJ+Kk/CkmkjjaUEcTHT40F2EmGDnXs4E4G+VrM0AUoVgzrkZpUq
 sPuOmYzDv3oT1r4DOyyH5wuTyAWvgRxHXUC/t+VQ9jF0AwWvqe3rVhIsNe85SGR6AOVphyXGn
 35bTph4mnag9d6O5vXfEwIIRTmZBhZVpHaVKEPuSchetZdoTs5tm2bFp8avaLoIfn7ufJRUMd
 veqjIlPnB+q7AVQbKSmMSPeumSuNo3veLsy7JhjQJxx31SqxHWq9s2OTipRNaZ+JgsB+m6+v2
 lBc4ke4vb8fEm2HLWmX0Brl/mxNogbWfyZlX1+rnSsIZ/N+4PXuMaArHtYiHPkFnW1kfpjng8
 /Nqu1Vbdhe1jJ7VBWsKZwQpZWRYbAfKNy+jbPzOLTuHDqRYYCRKD/eAFSQRL8s67htZS04eGy
 wAhYdhjRxlS2HcNMgiDbvaMk0OyUuawAPYN
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 30 Jun 2019, Jeff King wrote:

> On Sun, Jun 30, 2019 at 10:59:34PM +0200, Johannes Sixt wrote:
>
> > Am 30.06.19 um 21:48 schrieb Eric Sunshine:
> > > On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
> > >> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index=
.sh
> > >> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size d=
oes not alter existing packs' '
> > >> -               MINSIZE=3D$(ls -l .git/objects/pack/*pack | awk "{p=
rint \$5;}" | sort -n | head -n 1) &&
> > >> +               MINSIZE=3D$(stat -c %s .git/objects/pack/*pack | so=
rt -n | head -n 1) &&
> > >
> > > Unfortunately, this is not portable. While "stat -c %s" works on Lin=
ux
> > > and MSYS2, neither that option nor the format directive are recogniz=
ed
> > > on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
> > > need "stat -f %z".
> >
> > Ouch! I did notice that stat(1) is not in POSIX, but hoped that it was
> > sufficiently portable. I need a new idea...
>
> If we are OK relying on rudimentary perl[1], then:
>
>   perl -le "print((stat)[7]) for @ARGV"
>
> works. If you want it more readable, then maybe:
>
>   perl -MFile::stat -le "print stat(\$_)->size for @ARGV"

Or we stop introducing new Perl calls, and use the perfectly fine
`test-tool path-utils file-size` command:

https://github.com/git/git/blob/v2.22.0/t/helper/test-path-utils.c#L302-L3=
12

This solves not only portability problems but also avoids yet another
obstacle into making a `NO_PERL` test suite run really work without Perl.

Ciao,
Dscho
