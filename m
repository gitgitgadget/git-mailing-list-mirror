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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE71C1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 18:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfFUSSA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 14:18:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:41459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUSR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 14:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561141056;
        bh=TTVv+lYanItfCku5Lgv5UfxYfjGkP75RndEkwcwcTgQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J49iX6wvjwALFZd3qOef7f8cVrCMnzv/qp7TLaKkZvpMKfpU8wSeks7GvdcBzw57i
         WGSpKPDZHEB6hlSXIRKb/I4oZ/U7BLqBS1JImz+GTzATway8OIyLxtISoqHXRw/np+
         Sutko6s3HcHXYl9afIzseABd/Cpskmh7CJ3T6gEw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1hymGL45pC-00OpsW; Fri, 21
 Jun 2019 20:17:36 +0200
Date:   Fri, 21 Jun 2019 20:17:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matthew DeVore <matvore@comcast.net>
cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        peff@peff.net, emilyshaffer@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/10] list-objects-filter: implement composite
 filters
In-Reply-To: <20190618202216.GA35347@comcast.net>
Message-ID: <nycvar.QRO.7.76.6.1906212017150.44@tvgsbejvaqbjf.bet>
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com> <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com> <nycvar.QRO.7.76.6.1906181040490.44@tvgsbejvaqbjf.bet>
 <20190618202216.GA35347@comcast.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VevRwCuS6zSIa1CsM+TI9X1fbkTuZViJVDzla4MG+GdCQR+M19I
 mmDI02icdXVT3YmqlpOZwqvW5q3213zd/tFZrT+JjHLXjOwTFOI+ggo9brd307gZr/FzUbO
 /QblGP+hyJSy5CtEnv71o716Z4YwDP2J1wKBol2Y0to5fIIi8n89TXWxA37queWoSn9pVSU
 6Wbu8VqDqlze/cOz8L6hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v4lWuYJGC3Y=:Cjil1BVzofxrwV27M4H0rf
 EQvtc9yiN0BjoNiSsLaVTFHJO6If1A5gNDsBhh+M7fuA91rd50bphxp4Q/vdiahws5RJnXQiT
 ga7zUWD1tD9WYU2uI1PkzPrnn5/feZF1vA67UbdqVZ+eFlAdccYn+sefopXoQR+z1mG/xtqzA
 sSDAwxVMUdpcwudnuOMB8bR3X+CmhKraveZ2xAnEtG2R7KF8mpjd7orJWaolWIb2Ef54ihPI7
 1vuBBsCZXGlfR1cGS5SizNs2j4m9Ip2GVo0YEEvroz39A1f7xeFtjZKmyKmiNsYvO5dQWAqwU
 MzSW5smQTPYqP+NKFVAJGLv8H5lBWYt/gaUfNe8kkKu/LFotY9cAvTFlNaDhKrSemefmt4SsC
 pnLLmcN1fa1YtnpJPSn1X72SAeC7E/lt6KYYOJMdQlEp+3/Y1yEAAzJlJEX13gfKSeaRqk8mG
 hNzIj++xh4QtbJQULM+4OnbCudYasmfKv0uDHBvBu6tcVJVqY1nx1Xk9+/lGmdesMxqVj5BQH
 ed3tpB/YMGwinnF0Wa/NugwO/c1XcqmqdeiZqHnpbEJUFoDjKO0E7yCTxFWwt20Xg+sNL+Xu1
 2s+vbpZBf+Sk1ZvpoT3NAhbHJCMXGjxoWbfoClhrkFQgLuWvZZsvgwIp1vl3uGwcjQ+0tDLAF
 x7Lio/Yx7FKIaLqcO2uZysdIE3nFP4mbl+yvC3DWAyMHnQ3Z47JqUMuzVjYZJifNQVmrx2ATj
 VfAPGVUtdVywOILpbA2JqP0GAaCQvhJvevUWiWQK43l/LSHZypol93mIlZ71pKukMLK0agWbj
 5JqiTsBD8IiA8BQydrIBiKe9WwNUUStdcXqdTlv5Opoxtv5oAi9kEaCEpTxi5At9dsHevD6E1
 n46yjZKgX8b6JMrpX+2CR83xJNxGRS796r7MuYu/WVR+qSRO3XXBJqbBge2dwTpG99uhUgRd1
 KW/YaTVvngP1iqYJGTxDWrQdoKWilx9OnlFxuuIjA6VpBs1KHrcG0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 18 Jun 2019, Matthew DeVore wrote:

> On Tue, Jun 18, 2019 at 10:42:10AM +0200, Johannes Schindelin wrote:
> > > +	if (!subspecs[0]) {
> > > +		strbuf_addf(errbuf,
> > > +			    _("expected something after combine:"));
> >
> > Please squash this in, to pacify Coccinelle:

Junio, maybe you can apply a SQUASH??? on top? This is the reason why `pu`
is failing in the Azure Pipeline.

Thanks,
Dscho

> >
> > -- snipsnap --
> > diff --git a/list-objects-filter-options.c b/list-objects-filter-optio=
ns.c
> > index 5e5e30bc6a17..483ab512e24c 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> > @@ -150,7 +150,7 @@ static int parse_combine_filter(
> >  	int result =3D 0;
> >
> >  	if (!subspecs[0]) {
> > -		strbuf_addf(errbuf,
> > +		strbuf_addstr(errbuf,
>
> Thank you - fixed locally for the next re-roll.
>
