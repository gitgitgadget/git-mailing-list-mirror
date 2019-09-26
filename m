Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC4C1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfIZNXJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:23:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:33689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfIZNXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569504180;
        bh=U4j43vkOtApR+DJXl3Z+WeNE/DjMj0gNOF742FeyYBM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cOeVPP/BxquaEj5iwS0MJ7iXibNF1WvbhErP7woaUt46RJRaYTAtMizfdOwxxmcTD
         dfKwnFAxZ44wW30U28oF2kyXiEfjZ8WmMLVgD5izKkpqbnd2rQxCoxu6zYbwBiAcDj
         TMQsTclr6u/N4UpvmA8hGdpKlei6MLR8pd4jlAfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1hpu510AyB-00pZ5Q; Thu, 26
 Sep 2019 15:23:00 +0200
Date:   Thu, 26 Sep 2019 15:22:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: sizeof(var) vs sizeof(type), was Re: [PATCH] git: use COPY_ARRAY
 and MOVE_ARRAY in handle_alias()
In-Reply-To: <20190923222659.GA22645@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1909261521380.15067@tvgsbejvaqbjf.bet>
References: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de> <20190923222659.GA22645@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-325765174-1569504181=:15067"
X-Provags-ID: V03:K1:3f99UdYIapHBQKpsSGbukKqiDfvyKL05qXEbyepl+FQV5yYhI2i
 f3CnUKSV72k1JUw9RB3OhQLfEtDE8y28ZsKr14MavO+ire876ZmE47DKi0tbSlm0XBK38zK
 6EPjtxdU+D9NMSKr5ANdwDPbCmVzNZ0ld713ujWMHA7ZboiM2G//ceLHvVaWynZvDilPYvq
 cdCHgFuHvweu2lXOZ7DyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tOm0iht0VXQ=:V/yAU2Sp31lyzZ7eS8w/EN
 MQhI5H+xSq7QAwh20yEv93njiZcws6mV/jR3Tbnzcs471mwii0FhALxvJbU2JXCXWk1d1g3uw
 GBwxHstNvirJytOft4TnANij+u1dDFswNhwMBPRN3Z/naXuiLZxPZVsOoHAFqg7ZHS9YsmPrr
 0W0akDRhMrrLD9MZRLMZECnJUMEJ+ljB/YROPVJdffgt8kpoA+7s3bYpRv+Auwv+gElBKlKHX
 nYwNKWLni8Xyf2+p3ToyYksCG6KQiHMSnWNst5MaficFAHTYKe3rlKN0Wo9mRtQDCdBv1J258
 yEGuNIsc9uACjCxnNvvgT36zGZKqVAa1jtHNkszMmFRL71KGcNn8FhGKY/8+DN/iqRbjXjDlO
 fK2UsmnjvrKGExmkOCC/W9NB3cLG4+ohNHxrB9gojeOhcgA712mUZVaRwRkCqBY1ePW8rr/DJ
 OUSNqSEQgsSFCWuT4LdW7ZGlgQe59AuTrg986lLWZJtP3y6miZKtFavAVp4urVa+6+f14xAQ6
 RyVoFoA9VjTYrPvCsEoXmjdV6jQtsHMCY8xrDvXBW6Uah0SWlWh9sz0M9GDX8tdRWEVSzhxCN
 qvZWQQzBj4Vgzs4hhYlJPhroGomWzVR/r9HVPsc23AhvmF6UJhWAel2wAQPd1jXtLJ+4JO8n2
 0AIBuA68yN6a6oFgOwgAcGDvYai3BR9ewGw+CTcIG6bm1Q2dJ0b8agdFoEI2wccHifnN6Ajzu
 lvG89qO6u/LWqNpUglQfA8SvSCRiiWX6B44R6ppcYkzH17fxgpOtImRAW+6Pr3XijWBPrgbVS
 worboHMUQuH6CJjpopqwK20Klv5FZZV/nQDKjs0DIhFUDhLEZMNHhXZ4xwD9iOMvj0SmCNyIv
 C6gfdkUzQio0Eqx3540LgH2mmwVJsJHUvIvKO+RHTMaaKxeAbqyCpzeRkoaNfMIxDuoDHoKVI
 Po9YhAyHYJI3bAl3nj1OsXsO4O8sVHIHUkJeudLE9fuCNig7SVpheH5h8Og7pbpgaCIV4Ryas
 6xBG2uNULxiEyGXTMmFTbC/sLhByF0xUo1r8YeJrOySLnrKFN7CF9ObEPjGiU0ZMKCBYftHv8
 3f9cXxL4Zw2dOgWp5Fo3V5zB/UQG3od4oPqduzzGhoW7DiawrPaJHIpS63OSsLE16TYtaLwyp
 /J2bfmflmDNMasS9cXffaJFMz6SALI9C/HEGBlbdgg1Mz4cufHUxhlxPPmle/ouXSIskcaTJt
 +wOe5epOKajJ2klw96yKRClwxH/PGFSo2DKoVH/sXj/z1evEGPQUxM21h5v0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-325765174-1569504181=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Mon, 23 Sep 2019, Jeff King wrote:

> On Thu, Sep 19, 2019 at 10:48:30PM +0200, Ren=C3=A9 Scharfe wrote:
>
> > Use the macro COPY_ARRAY to copy array elements and MOVE_ARRAY to do t=
he
> > same for moving them backwards in an array with potential overlap.  Th=
e
> > result is shorter and safer, as it infers the element type automatical=
ly
> > and does a (very) basic type compatibility check for its first two
> > arguments.
> >
> > These cases were missed by Coccinelle and contrib/coccinelle/array.coc=
ci
> > because the type of the elements is "const char *", not "char *", and
> > the rules in the semantic patch cautiously insist on the sizeof operat=
or
> > being used on exactly the same type to avoid generating transformation=
s
> > that introduce subtle bugs into tricky code.
>
> Another good reason to use "sizeof(var)" instead of sizeof(type)". :)

That is indeed a very good reason, in addition to getting the type right
automatically (by virtue of letting the compiler pick it).

Should we make this an explicit guideline in our documentation?

Ciao,
Dscho

--8323328-325765174-1569504181=:15067--
