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
	by dcvr.yhbt.net (Postfix) with ESMTP id C51961F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 09:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfJDJzt (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:55:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:51321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbfJDJzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570182943;
        bh=Sr3eV38r9OE7SEsSKO6l4Fm1MXJNEnGsOymdsK91OMI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PO3Hiec9cXzNw80DNzPslj4h3bXrsrXNLMn3hqzJdMrTBW6qWtzZNTQsW5Dm4vd+4
         thdIffhO3lHCEzfVFbh4sb82tozjI6F5CCoZczhv1U9J8WBPrNnbpnj1uBqW3W7E4F
         leGgN5hXmmbNH5M95ILB71W3+Ba5pEwwcCYhttFU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1iRvAn0RrK-00Netn; Fri, 04
 Oct 2019 11:55:43 +0200
Date:   Fri, 4 Oct 2019 11:55:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned
 types
In-Reply-To: <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <pull.288.v2.git.gitgitgadget@gmail.com> <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com> <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pxre6c0Eied/5gSeAy2rNP7D5ot2t5A/y2ZxNtDcvzkjzJaFJtT
 4M5Lsd/IQ+1oD+aCcSRp8pVA3xyRvTBWH8yJVcbWSdBHg0zF9vr5Ng4dAiGQSAEwQySMzGn
 /Iq58wK6jAIVpRWuwbV341xmLYBOcqHMR6ZPZKI7eDnGWUPa1TIwjMcc3YvAgFTqLha1MXx
 BpHuCT68zsfVNXj1J2ntA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wlr7F4gz9UQ=:49tAp5cK1wUSbKyg6WArg9
 QFZG6Z4bMUUkRHo4ejCz+qdbu9/JZCE4aDNdugjUIZaY09FiLEVYvfhnuG5LzkrBKhRNN2PiF
 1Wr1DrXH2kdrUifeZUaZCqatkAaTv4CbBj0ggdSU+EpOio2+PeU8yquPt1M6Gi3vcZ41ufKt9
 UP0vYMLl48u5fvRBwPuA9iVh8ZCcBsYRovj+HJftWIgU1P1KD9flAxvqgTJWr3i91E/f343Di
 1CfmnBUqbPPSMUBMLaOYyyjz1AuVmnBeeuIxdJZq/qx4ANhH91D39m4PkO3FNnnJxdwinLSyO
 1nAoLZlHIsXtvd0YmEf3vOtN3LQu+W6aiT1upxNKCv8SpBaHbnJMB0BNfM4kSMdq0FzStxg9Z
 9+lKc7+7ogiyF3kntKmouYMiGVVPAJlzF+i12lhoKnaqBIY0oOpPg1FUnI2TFPjysLTxiSfEl
 yybhweGuf0cJHwLqSEQnz89tY4aQdmvI1y+/VcqbboxnyARoJ2/aBr6PZCd+18/YQh9PgKTuL
 LymcrGO1qd44TiUaTkaSB0fzSfqXoD/DKi3tXUXz8Aoe8Wh9SellnTXzR5ETl69qU+GoghT71
 gL7hKvg2dDI6/IINMU+g0M6YpI15AAzGHaczRIxbPsXaPX5kkgVQIvtOTvBZksjt31zigPyu6
 2pNvTjXy0zqzgt2bNvBuilcz27fMGDXWjPhiplHoaJSbuz1pI9MPQ8Hqr1By4UQHL70qiOB1S
 O61BzON+nTWBwk6V8hMdKA4lmOp8/5SeIKTKI99OZZT844pChc6Ph1m2ppYq6s1bM5tQr2nA1
 H5rUAHjxNIslHUHjo/PVVDh0sPKnIue5rgcq8C8BX0TAnC8EK3RxOFgrOONhiEILUO6RR0yIk
 ZfSmy9l7iuyPb2yzhFl8oS4p+iG1HsuxdVmDzCZM6cQbKQuK6fbw7LZBl+GzCK+OBbqS4jOBk
 G4OElNSpbtlHwMKwsmEW/zQ31RYq+BUVhmChQzRJp/hl34CkrI/52QlP8xwj6kOryQyzAluHc
 HPne8mnOL5Y++KL2xrymAaze0e89ck+REOUxufoGfSIW7qJpO9zQveXee2/R/27g0+XPcGHJq
 vZUm4WQRHzIthE6QqxdWv8PFS4/k7GJwjHYidoUCd7TJ4FcZrkwdjB1I6AGhLC3jgj0FfRX9s
 kwr0UoOKUkEJJk4ZOsMkL8GbJUSk24+GT0vUkPm8C1t1oDGMhKcGkgqjPqpdW7wB2L0ZOqhiu
 mqw8kMsGoepWaDUcx4VrSwB7rFmT8sHtiGby3AG8NFUiooACP+7130FdZvzU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > While at it, we take care of reporting overflows (which are unlikely,
> > but hey, defensive programming is good!).
> >
> > We _also_ take pains of casting the unsigned value to signed: otherwis=
e,
> > the signed operand (i.e. the `-1`) would be cast to unsigned before
> > doing the arithmetic.
>
> These three look good and too similar to each other, which makes me
> wonder if we want to allow them simply write
>
> 	return insert_pos_as_negative_offset(nr);
>
> with something like
>
> 	static int insert_pos_as_negative_offset(uintmax_t nr)
> 	{
> 		if (INT_MAX < nr)
> 			die("overflow: -1 - %"PRIuMAX, nr);
> 		return -1 - (int)nr;
> 	}
>
> to avoid repetition.

I tried not to do that because there are two different data types in
play: `unsigned int` and `size_t`. But I guess by making this an
`inline` function, compilers can optimize for the common case and avoid
casting _twice_.

Will be fixed in v2,
Dscho

>
> > Helped-by: Denton Liu <liu.denton@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  read-cache.c  |  9 ++++++---
> >  sha1-lookup.c | 12 +++++++++---
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index c701f7f8b8..97745c2a31 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1275,8 +1275,11 @@ static int add_index_entry_with_check(struct in=
dex_state *istate, struct cache_e
> >  	 * we can avoid searching for it.
> >  	 */
> >  	if (istate->cache_nr > 0 &&
> > -		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> > -		pos =3D -istate->cache_nr - 1;
> > +		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0) {
> > +		if (istate->cache_nr > INT_MAX)
> > +			die("overflow: -1 - %u", istate->cache_nr);
> > +		pos =3D -1 - (int)istate->cache_nr;
> > +	}
> >  	else
> >  		pos =3D index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_s=
tage(ce));
> >
> > @@ -1894,7 +1897,7 @@ static size_t estimate_cache_size(size_t ondisk_=
size, unsigned int entries)
> >  	/*
> >  	 * Account for potential alignment differences.
> >  	 */
> > -	per_entry +=3D align_padding_size(sizeof(struct cache_entry), -sizeo=
f(struct ondisk_cache_entry));
> > +	per_entry +=3D align_padding_size(per_entry, 0);
> >  	return ondisk_size + entries * per_entry;
> >  }
> >
> > diff --git a/sha1-lookup.c b/sha1-lookup.c
> > index 796ab68da8..bb786b5420 100644
> > --- a/sha1-lookup.c
> > +++ b/sha1-lookup.c
> > @@ -69,8 +69,12 @@ int sha1_pos(const unsigned char *sha1, void *table=
, size_t nr,
> >  			miv =3D take2(sha1 + ofs);
> >  			if (miv < lov)
> >  				return -1;
> > -			if (hiv < miv)
> > -				return -1 - nr;
> > +			if (hiv < miv) {
> > +				if (nr > INT_MAX)
> > +					die("overflow: -1 - %"PRIuMAX,
> > +					    (uintmax_t)nr);
> > +				return -1 - (int)nr;
> > +			}
> >  			if (lov !=3D hiv) {
> >  				/*
> >  				 * At this point miv could be equal
> > @@ -97,7 +101,9 @@ int sha1_pos(const unsigned char *sha1, void *table=
, size_t nr,
> >  			lo =3D mi + 1;
> >  		mi =3D lo + (hi - lo) / 2;
> >  	} while (lo < hi);
> > -	return -lo-1;
> > +	if (nr > INT_MAX)
> > +		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
> > +	return -1 - (int)lo;
> >  }
> >
> >  int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nb=
o,
>
