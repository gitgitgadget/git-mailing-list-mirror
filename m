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
	by dcvr.yhbt.net (Postfix) with ESMTP id 090481F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfIZVB5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:01:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:49779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfIZVB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569531710;
        bh=NONGklYyQGl991Usb7NhYaoLQp7LPjl7SrBPOWv4Z/Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xh+uHl7kFQcjTnQWAdnVQ1i/mJNwAwN400LVRVdd+ZSGm4ICkrH6K4+7sDRDrBJJE
         2rkIFlXpXZmvKOV///Fqkbllz5UgQJKZ8QNUUFADRIWpxzGxKdf4kYWflV2KkjXjxf
         EI1ZoxDHUKZry2cfLNZU0tLvCLc8Xb+oI0LGjp4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1igng41vyM-00XcbJ; Thu, 26
 Sep 2019 23:01:50 +0200
Date:   Thu, 26 Sep 2019 23:01:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/13] msvc: avoid using minus operator on unsigned
 types
In-Reply-To: <20190926172022.GA41037@generichostname>
Message-ID: <nycvar.QRO.7.76.6.1909262236550.15067@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <2abe1e1fb0bf3025489c2e543b9a9c648a164827.1569486607.git.gitgitgadget@gmail.com> <20190926172022.GA41037@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:74znEv88x4Nur1oiAqE3Jk0Tg8m5lhHEjIdAV9AQk9EeznKyQQh
 8ohjaRYzdAT5DfoLwMMTpna9L29CP943LQFQtZ59otgSAZOXnZNY3B++bLojuYnT3BoqcT4
 6txd19swoahzFCV8vjlSUK1K4u1aQhLZ5YJnl+Fy5x0BdWAs5WVn/onSF3uEZQ5gEaMj2Nc
 0gkas0ln6qL8tg3bQyrHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NwlK96UegR0=:oYNb5ne1Kj6HWFg69x2T77
 yGrnWJFveM3DHYcg9nrKJpahJulCO8sWFI1imzTGYK9jwkJOCsXW7GLQfqZ3qR0b44zR2KhWm
 TlrosTwP0ZGgE99GKm3DcQEHnEQKPw3kKRlqQsxhhjU87aHVvZ1k2Ciu1tB4v1MywU3NOk4UQ
 nxQwsxndOQf1wGeZU9pg8uDGa1W6FWuSZknKLW1CPu4Po03wreFie/eCbhOnQwAEMXK4lnr02
 sAdhhImUxR8PpQBUpOySLLcdxtnJombv8Z3XmYLhwwR4jDvyZDcbuiRL9zexjPU6WbiBFQdSn
 t+4aovDPVd90EFEyvaCJyy68L41NVT+vuyf5W/ENhrasnGkq0cw9+4np6gXYagUZbDTI5vfYh
 05FGzmXOXMFT1QAbwW9GvZ2oZ+xoTsqq71H0DBpIBJE+d33Dj/krqbOcu/VD4AL/sWOHT5fBi
 W6Gq0XEVAVRacLPdN1UdMYMuC2nqnyrODjejlFdjqpQ9YtvHaWNqICBzxXVMyfMZGlD0AiYds
 IxaRe5hamepFzvTPx14Fwzo9aR/atBGTJBABmGbUrXgGbtaVJOk01szx8bKywhQ7F8wCi8EgM
 dPo0bDhFEkC0xGXqSsnAyef2uDWEa7jZCBDeh+nwjnJBmr4YB7waERQIMQp+2hh03B45QDCvi
 TJ5lTh8RJv04JKmlHfDQepfKJn91FmV/DSmULMF7Yl7thnEi+Cy0oW49jqGwAQ0i4DLXWEMNF
 ELK3c7qPgbrdTVZUtow/b4vhrshnnLvYF9rkX4vwj9oV9Vasm8M9TE09IjPqlffHO+PJ477CW
 qfqrO7yj72PaUKAy44tiieTaFLnJ00Qs1KqmZgSwq+2Eqk+fgBqq3mMaJ9ALBpjQCJyn3bpTT
 vj20T2sLrx1v2Mu4d5rYmEAA/DaqUQ2QxlH16iYFvTLqdadiVgAzc1568iTjvgD99tmDyoqD2
 bz0g+kwGlGJdLASom6BA9ut9jWWuYTMn1rfHa4ooInCJxMF0cVNXPGc5XhwOUaCIVcxQLG9lR
 j3EJdlOGQZXfLCUFvy2khBDWXw8Ka2C//Kh622eBUAxcyLL+fYS61AWc/bkyp5VTpeCELArZ7
 dU0IIXltuIV1oalPPfKNGO2QzcRM146fJ+x4uWp6gzxtn8nU/79VcozoyWFqbUMMIBGImMuQj
 t0lZ7iD7/ERlJoDBemiND+HixbXMKBaSvVWK5+0X1DbuGeR1VT8zPaf5SdQqFkRabWJvWfAHN
 hhH4EZEB8EgVYKG3gZz8u/vH/umgH1gh3L+GN4Mpg3e8r5E6q0JAhjT+q++I=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, 26 Sep 2019, Denton Liu wrote:

> Hi Dscho,
>
> On Thu, Sep 26, 2019 at 01:30:10AM -0700, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > MSVC complains about this with `-Wall`, which can be taken as a sign
> > that this is indeed a real bug. The symptom is:
> >
> > 	C4146: unary minus operator applied to unsigned type, result
> > 	still unsigned
> >
> > Let's avoid this warning in the minimal way, e.g. writing `-1 -
> > <unsigned value>` instead of `-<unsigned value> - 1`.
>
> [...]
>
> > ---
> >  read-cache.c  | 4 ++--
> >  sha1-lookup.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index c701f7f8b8..11f3357216 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1276,7 +1276,7 @@ static int add_index_entry_with_check(struct ind=
ex_state *istate, struct cache_e
> >  	 */
> >  	if (istate->cache_nr > 0 &&
> >  		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> > -		pos =3D -istate->cache_nr - 1;
> > +		pos =3D -1 - istate->cache_nr;
>
> I've been thinking about this and I'm still not certain that this 100%
> correct from a language-lawyer perspective.
>
> If we do `-1 - istate->cache_nr`, then the unsignedness of
> istate->cache_nr takes over and the whole expression is a very large
> unsigned number.
>
> Then, when we assign to `int pos`, we are converting an unsigned number
> which is out of the range of the signed number. According to a
> StackOverflow post citing the C99 standard[1]:
>
> 	Otherwise, the new type is signed and the value cannot be
> 	represented in it; either the result is implementation-defined
> 	or an implementation-defined signal is raised.
>
> I'm sure that most platforms that we support will handle it sanely but
> could we write this as
>
> 	pos =3D -1 - (int) istate->cache_nr;
>
> to be doubly sure that no funny business will happen?

I guess we should use `signed_add_overflows()` to make extra certain
that it does what we want it to do, kind of like `st_add()`. Or just do
the check explicitly, like so:

	if (istate->cache_nr > INT_MAX)
		die("overflow: -1 - %u", istate->cache_nr);
	pos =3D -1 - istate->cache_nr;
}
>
> >  	else
> >  		pos =3D index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_s=
tage(ce));
> >
> > @@ -1894,7 +1894,7 @@ static size_t estimate_cache_size(size_t ondisk_=
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
> > index 796ab68da8..c819687730 100644
> > --- a/sha1-lookup.c
> > +++ b/sha1-lookup.c
> > @@ -97,7 +97,7 @@ int sha1_pos(const unsigned char *sha1, void *table,=
 size_t nr,
> >  			lo =3D mi + 1;
> >  		mi =3D lo + (hi - lo) / 2;
> >  	} while (lo < hi);
> > -	return -lo-1;
> > +	return -1 - lo;
>
> Same thing here.

This is even more critical, as `lo` has the type `size_t`:

	if (lo > INT_MAX)
		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
	return -1 - lo;
>
What do you think?
Dscho

> [1]: https://stackoverflow.com/questions/50605/signed-to-unsigned-conver=
sion-in-c-is-it-always-safe
>
> >  }
> >
> >  int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nb=
o,
> > --
> > gitgitgadget
> >
>
