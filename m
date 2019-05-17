Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1231F461
	for <e@80x24.org>; Fri, 17 May 2019 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfEQSdj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:33:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:41497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfEQSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558118017;
        bh=KYxva64Jv+t2SviwpGtPT7+bxUNLFSGuTdoJUAdCBBc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=li2TnhOpn1vXkX9GWv04Yii3oUryjYFO7sekp6grE/VPTSX2iry9M5c54eBchNXA7
         ax6/PxjBGGaD9v/j1QPo7d0bQlHXaHThjaZbxrhd1j8eCtOzJdLmun+wqhRgMdlNaU
         QVEKeueshkaLywWEwMm9F7C+H+G5YS4IkXBUiDQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M35iN-1gZJu33HEt-00swUI; Fri, 17
 May 2019 20:33:36 +0200
Date:   Fri, 17 May 2019 20:33:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
In-Reply-To: <20190515182812.107420-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1905172032550.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1905151040240.44@tvgsbejvaqbjf.bet> <20190515182812.107420-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RyfI+EYauCGqV78XmlRxUWXI0c/lSdNPWnQyT+Q5EipyqYBkdWS
 xSlAvB+mQLxFWvuxHag5QMjdDI6is//9QSQ8DAz6w3BLbx78hY2YkSuVTypVVxfPpOoT39U
 UacbtSzWf95L7X+AkMexf+yXp3n1rb1U64CSjUjP3LW0gpq6Q+B123AK9ojgCuDW+c0jzxf
 IWQl0C/XiHrLcPgMbhoLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hx0sf/lzeqE=:M8ZZd1QRPc5/gqm37hQZA4
 2USfllZBQbEkjL75FH3jwwf06qPOmiO0eUEqzrsbsnfuLXH2nt7ehuo0IpPO/0GjdHym0+Xr2
 viF+3nWO/4Mn2qG8NMifCO3WdRwTO7cvrrcss55f8Uuov2jrkKzxQDUYKwLL+OfsuoIMnODcD
 Qh81Y//xKQINGwtImK8TS3QxwHfS3yvHs6C0QFzIdbE/ft5pe3xaVV+xpdBJ3b0CbmGNde/kL
 1gU9Zz5smmVFYpL2vnbOarBmzCHfYcnGlhf8ms+9sRbRbyKjkXJ8uZgc62kbiHadWwzCoTems
 4P9xC+JbainuOSZyJunvGAcoYTdwUapQdJEBcdBZk0bcoQLCfRwYbvufvVWnbRWJzRFLNlgzN
 9DYhuBKYwc4lGePHMy/mWTMcK1KUHbyjWkkznf+tYY2c8dli/AjRRelABjU3eDlky0OFURtso
 fz+5tz06ZIQBZ6DsjtsxdKtD/ki7Gpic6qETa9JcaRAOvvbQE46ric3GyMFJguzaGxbgKdUp5
 fwsK8gOjKA2pCqm2b5d8tl1hrO2Z4C++c2pTzl7L5gmnvpa/emWcZx7lgx9AugtjLZFw/I5Hz
 9tlXaLqODWiHTaq6uBnMd3EDaWK47IVh+V3Tpeu5hIxgn2beQvySO/6sYp97rOveElDNaedlu
 FvKlmeBkNc2P5GM94/6EU9coDNaS23Vf2NH214P1g5ykvCSyCSXtOi9V8e/MbTDzpOAmRmFPn
 WMYR5iIO/Ymg4L2GDQzLou3iz9zKml/BQUf89ia135r0+k669Jh4yXDz1ktnM/2d9MUt0Jd5C
 OjYFgkhnw7oOSpOI+zOia3WLbJhAXKyikwal3IpBENP7cvz4NHksmu9cs0r5ELKndOrobCA33
 mQU3B8FAyTGMpq3w3Bd1swSqXMnSHkCUJZzJnw6UtViPIKTsGstbAz+8nMhz31ILPccAkUNu6
 w0exCqdGEWhUAvHCOe09MAeIItJAjmVC/Y4Sd+W7VPiVJq/KQxCxO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 15 May 2019, Jonathan Tan wrote:

> > > To resolve this, prefetch all missing REF_DELTA bases before attempt=
ing
> > > to resolve them. This both ensures that all bases are attempted to b=
e
> > > fetched, and ensures that we make only one request per index-pack
> > > invocation, and not one request per missing object.
> >
> > Hmm. I wonder whether this can lead to *really* undesirable behavior, =
e.g.
> > with deep delta chains. The client would possibly have to fetch the
> > REF_DELTA object, but that would also be delivered in a thin pack with
> > *another* REF_DELTA object, and the same over and over again, with ple=
nty
> > of round trips that kill performance really well.
>
> When the client fetches the REF_DELTA base, it won't be a REF_DELTA
> object itself because Git makes these fetches without any "have" lines,
> so the server doesn't know anything to delta against. Admittedly, this
> is just due how to we implemented it - if later we find a way to
> optimize the lazy fetches by adding "have", then we'll have to revisit
> this.

Ah! I *think* I understand this better now. Thank you.

> Quoting from the commit message:
>
> > > (When fetching REF_DELTA bases, it is unlikely that
> > > those are REF_DELTA themselves, because we do not send "have" when
> > > making such fetches.)
>
> I tried to address this point with this sentence in the commit message.
> If you think that this should be addressed more clearly in the commit
> message, let me know if you have any suggestions.

I totally read over this part of the commit message, apparently. My bad.

Sorry for the noise!
Dscho
