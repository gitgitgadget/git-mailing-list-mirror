Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C671F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 13:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdAZNtT (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 08:49:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:49336 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbdAZNtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 08:49:18 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWkep-1czUUO3ryt-00XqbO; Thu, 26
 Jan 2017 14:49:12 +0100
Date:   Thu, 26 Jan 2017 14:49:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation
 based on GNU's qsort_r(1)
In-Reply-To: <20170125185153.obqwxiniyz2omxsi@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701261446540.3469@virtualbox>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de> <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de> <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com> <4e416167-2a33-0943-5738-79b4da5f2c11@web.de> <20170124203949.46lbmiyj26xx4hrk@sigill.intra.peff.net>
 <f41e5053-ee24-060f-0fb9-b257b3ba35a0@web.de> <20170125185153.obqwxiniyz2omxsi@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1958089053-1485438551=:3469"
X-Provags-ID: V03:K0:gaPAl1kdSZGUVZDyBK52anK5nARaVeL8Cirl1ieMN2qxTLaUu+y
 4W580PV5Zd/niedeFKCA1412iXAdUJj6GoDrG7mvLN+ooV3PJeeOK3Si+AqBLP+x9bbw7WP
 2GQGtMa60hZSVJKmzcg7GEPvlwurvDEaQCd+MAlSRV6UtsBhTybgJJ1tstArALMmwkn7FWH
 l18O5FX+rUVyeJ52CkHKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i57quyCMosE=:17vPfsFy4lQaUjumfatT87
 DGYJ5z+D3gmpXqfSzdOt0sjY6rnK9dTzxqG8ZhAOc23k6y2mHbXmERqeqPEwhagJVSp+WEEuS
 5WFPkVwM18e8cUlTtczy7svTDDXsebTqADDMK4DnvaygtfAoQ5MleY7A3PonzQou2kjT9mEfI
 XFqiZRTG4Dl1hdU65X+Mvl8XoSnYfD3/r9ZBU+gkjMEDvFCbWe2SpyfaYbBkJxoLiusO+GCYQ
 puWxiOM4PCgSsqyg69yJ3q3cdwb0BerQ8PMagm/t9FA2SzPj/nNkbx+Wd8nRiLwNXdTJoSPYI
 i+md0oEH26C+uWW0ysPyI0UHwVBgc9XVY2KAqtQWDW7cr3Fb0Lql7MPLLNOznsfDAjbx0lytS
 gAJDPD+2RVogJNBLtiCLGrlLPvG8qvQmGCh2yCiVREB2KrPsSbDFnMSBzVIyGVLqVkE3HSIIU
 0QRORupw5z2Q3oK/L5CuLgUlxUCEAyUqRE8fRYmq/NW//B86WO6xYtFkVPDrIwtDGGvuWRfTw
 GNPaVyA97bucYi38hRhS4y+Q+4lyogcfb3TIW4ySllomjx74etZqZr1wyeWO3JBHr7yUEMWPz
 AH/fLF6FKfgaTGd6h3zmhW6cpLpq+TF2XPpecGH9fOwhESbwZ7UswNbipbDc/lMOB8Hse1PXq
 VxOpWJiH3lCx3EY1o6S1Yev5dan/zrtsq1wqn/IK5CBf20H3aDfkHa7Hz481D+o1mPadumvbR
 GTIasq3NGMtr3u6svL1rsrQvNEyCczaaG2LotDfbynlZVSYtjPKCzWXyQcTMdfb+B3rNopuKr
 xJs5lQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1958089053-1485438551=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 25 Jan 2017, Jeff King wrote:

> On Wed, Jan 25, 2017 at 07:43:01PM +0100, Ren=C3=A9 Scharfe wrote:
>=20
> > If we find such cases then we'd better fix them for all platforms, e.g.=
 by
> > importing timsort, no?
>=20
> Yes, as long as they are strict improvements.

I think in many cases, we may be better off by replacing the use of a
string-list for lookups by hashmaps for the same purpose.

Ciao,
Dscho
--8323329-1958089053-1485438551=:3469--
