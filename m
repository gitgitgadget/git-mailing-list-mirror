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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEAF1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfI3JuW (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:50:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:52811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfI3JuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569837016;
        bh=CBpAlYQa7Ikt9XrM/2K3SZR0Wpy0GYe7Q67f2b3DquM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OMdgR9ownssbm+Z/tCYsh8908ZRqWZjtfIGIvy2+yeNJZZQ/iO77xP7J0ZX7r4Eym
         94auuO+oL1Mi4/nJcnBICcrx8lVChbykPznxye3mA7k25L3RhyjcSUr94zhoiN224O
         MJdYitox64KkQctKMS3GrzUE+EELjClJ62sjW2GU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1iMswK1VFf-00HKGU; Mon, 30
 Sep 2019 11:50:15 +0200
Date:   Mon, 30 Sep 2019 11:50:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/13] msvc: avoid using minus operator on unsigned
 types
In-Reply-To: <20190926235753.GA94990@generichostname>
Message-ID: <nycvar.QRO.7.76.6.1909301149070.46@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <2abe1e1fb0bf3025489c2e543b9a9c648a164827.1569486607.git.gitgitgadget@gmail.com> <20190926172022.GA41037@generichostname> <nycvar.QRO.7.76.6.1909262236550.15067@tvgsbejvaqbjf.bet>
 <20190926235753.GA94990@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TRtArS/Y0FgI5b5OWBtmUtAjDMksM0fL5ccz0dsxGbCp1B1TANf
 D+zRjdl6FG7XjI+juZWU6Bcs+hI4lQMTUKreliEHCbFLeNJKexbIT77qD0aD0WNUIGWoqFs
 NYGMCS8PoChLE3EkcJPggLCnscw755b1uufUu/40IZoydG59eeu8T4vXvGyQazmqioj7K40
 ahaQMACOEcwhC9jfNxByg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HOESi/NBB/A=:Nz5aGP6uGrDKVwCAatuQPy
 bB/0DXQxyp8XsHevArSZGgBJe5ohV5WZo+3zTs7t/DzSD5XVW/zrX2Fj52SW9sS3T3h6pSfAu
 /O7KGGLBORXdDw9JtHD0FxdSrMn2TfT0bP7b7lHtVz1xIDs7D6CMWQJ4pB2jeFA2SMVZdfxaY
 YrFnKke72XmXmLzwA+n9IiSCBqOTaUnxdCBVzvGAn4hwJ8Ef+kF2YNXxlLDu42k4uUq4w0L1E
 DJCFLAgOkFxW08vbX+gWD4fS3YbXWehs3Yw8eqgH9O+FPU90xr0u+kPfazS3cx1ZXXOQnaLf9
 SOFXl698TuVVgzUHHH2ToGuHHoywXNBXzW4cjVHi+Y5IEoYAtmfxss4EaQU7aVtmLqTJ0zBNu
 o/h0awjxU/rGM6FpEZZqM0rowz4mOxLlHknr2TFmp6QQHcJQq0hfe/Jo3YV5HNT314vExgXFq
 A9SoE64eNBUAuCuFtdWtuzDcfOKhggj71237AXbRzUgxfpY6PnYfxkxGslX3Z7Ji1MBKFiICq
 +wZRQn7YdNpau/e04LPHqUWgGtSBo/rqI86UJRZ/ztYW+kUW8rfkoe7o+Afh8LquyIPM6NyfN
 B0XoRwGxI/vnHPtM4GO/rx7tlpV/kZynDqxuB2mXh/QezgmoeY+RW4YftEot6FRCm7JmhqcAD
 GSLT/N6QlEAh69G+Gc5ZyRF68aRoLxrc2ekKf71fO0c6lMbhenX1OVVWMtPCgl4vS99jumYWW
 O0oYEbSEVULEb4qPRzQKCOA+1NIAK5NbO5W5fx2bobEtCHzRMLCdWtYgNba1878zTKdgafUVa
 jLcA4Aq7kO6FNeGCOTil/CgKLYrteFAMSj+5CZr29dQioRrkg1JgiGUNWqWXTcSfAWl+Ut8FI
 j0qKu+0f2a8f64ObJlZSviYLkwZbcKiY7u1c8jWZMaaPEo2cBQUXzldIyeGD+l/KM//SlB0Tm
 w2mtxIFuoK4nMkVP/7ZSArTIxAObePc3g/c98w45qT6fGpfCrZP8oSsh55PUwEad38ZuVSavf
 UbYOnmQcRqG7bWadckaYN4eqIy2oaLUNCy1bJgiInuYYQYxpk5MEX+YvJtOIdcpWEzLeMT5Q2
 9eJIHHV5itBvcXI9cqIHz2IKe3EeeLggNYz5rvQ6naFCVuaqLe47mLEGfmsCyVgxuKFLJKVxT
 L8o3lY/xycYEm4fgdioLO2RkNr8Y4H3DtuYdqROtEWgWgM8wzltPxbnQT6nUaZ5eGm6q97KgC
 c4pu2y73OB8egcT88FblSBUGKHVG6W2CQ8d5mQe+QG6E6HvOkltl+aJ7ka1Y=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, 26 Sep 2019, Denton Liu wrote:

> On Thu, Sep 26, 2019 at 11:01:32PM +0200, Johannes Schindelin wrote:
> >
> > On Thu, 26 Sep 2019, Denton Liu wrote:
> >
> > > Hi Dscho,
> > >
> > > On Thu, Sep 26, 2019 at 01:30:10AM -0700, Johannes Schindelin via Gi=
tGitGadget wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > MSVC complains about this with `-Wall`, which can be taken as a si=
gn
> > > > that this is indeed a real bug. The symptom is:
> > > >
> > > > 	C4146: unary minus operator applied to unsigned type, result
> > > > 	still unsigned
> > > >
> > > > Let's avoid this warning in the minimal way, e.g. writing `-1 -
> > > > <unsigned value>` instead of `-<unsigned value> - 1`.
> > >
> > > [...]
> > >
> > > > ---
> > > >  read-cache.c  | 4 ++--
> > > >  sha1-lookup.c | 2 +-
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/read-cache.c b/read-cache.c
> > > > index c701f7f8b8..11f3357216 100644
> > > > --- a/read-cache.c
> > > > +++ b/read-cache.c
> > > > @@ -1276,7 +1276,7 @@ static int add_index_entry_with_check(struct=
 index_state *istate, struct cache_e
> > > >  	 */
> > > >  	if (istate->cache_nr > 0 &&
> > > >  		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0=
)
> > > > -		pos =3D -istate->cache_nr - 1;
> > > > +		pos =3D -1 - istate->cache_nr;
> > >
> > > I've been thinking about this and I'm still not certain that this 10=
0%
> > > correct from a language-lawyer perspective.
> > >
> > > If we do `-1 - istate->cache_nr`, then the unsignedness of
> > > istate->cache_nr takes over and the whole expression is a very large
> > > unsigned number.
> > >
> > > Then, when we assign to `int pos`, we are converting an unsigned num=
ber
> > > which is out of the range of the signed number. According to a
> > > StackOverflow post citing the C99 standard[1]:
> > >
> > > 	Otherwise, the new type is signed and the value cannot be
> > > 	represented in it; either the result is implementation-defined
> > > 	or an implementation-defined signal is raised.
> > >
> > > I'm sure that most platforms that we support will handle it sanely b=
ut
> > > could we write this as
> > >
> > > 	pos =3D -1 - (int) istate->cache_nr;
> > >
> > > to be doubly sure that no funny business will happen?
> >
> > I guess we should use `signed_add_overflows()` to make extra certain
> > that it does what we want it to do, kind of like `st_add()`. Or just d=
o
> > the check explicitly, like so:
> >
> > 	if (istate->cache_nr > INT_MAX)
> > 		die("overflow: -1 - %u", istate->cache_nr);
> > 	pos =3D -1 - istate->cache_nr;
>
> Could we change this to
>
>  	pos =3D -1 - (int) istate->cache_nr;
>
> so that we alleviate the problem I was talking about above?

Thank you, I had missed that.

> Other than that, it looks good. Well, it might break on one's complement
> systems but I don't think we support UNIVACs anyway. ;)

Let's hope that nobody tries to run Git on such a system, indeed.

Thanks,
Dscho

>
> > }
> > >
> > > >  	else
> > > >  		pos =3D index_name_stage_pos(istate, ce->name, ce_namelen(ce), =
ce_stage(ce));
> > > >
> > > > @@ -1894,7 +1894,7 @@ static size_t estimate_cache_size(size_t ond=
isk_size, unsigned int entries)
> > > >  	/*
> > > >  	 * Account for potential alignment differences.
> > > >  	 */
> > > > -	per_entry +=3D align_padding_size(sizeof(struct cache_entry), -s=
izeof(struct ondisk_cache_entry));
> > > > +	per_entry +=3D align_padding_size(per_entry, 0);
> > > >  	return ondisk_size + entries * per_entry;
> > > >  }
> > > >
> > > > diff --git a/sha1-lookup.c b/sha1-lookup.c
> > > > index 796ab68da8..c819687730 100644
> > > > --- a/sha1-lookup.c
> > > > +++ b/sha1-lookup.c
> > > > @@ -97,7 +97,7 @@ int sha1_pos(const unsigned char *sha1, void *ta=
ble, size_t nr,
> > > >  			lo =3D mi + 1;
> > > >  		mi =3D lo + (hi - lo) / 2;
> > > >  	} while (lo < hi);
> > > > -	return -lo-1;
> > > > +	return -1 - lo;
> > >
> > > Same thing here.
> >
> > This is even more critical, as `lo` has the type `size_t`:
> >
> > 	if (lo > INT_MAX)
> > 		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
> > 	return -1 - lo;
>
> Also, could we change this to
>
>  	return -1 - (int) lo;
>
> Thanks,
>
> Denton
>
> > >
> > What do you think?
> > Dscho
> >
> > > [1]: https://stackoverflow.com/questions/50605/signed-to-unsigned-co=
nversion-in-c-is-it-always-safe
> > >
> > > >  }
> > > >
> > > >  int bsearch_hash(const unsigned char *sha1, const uint32_t *fanou=
t_nbo,
> > > > --
> > > > gitgitgadget
> > > >
> > >
>
