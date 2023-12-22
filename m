Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577702C186
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="IITpOjaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703270399; x=1703875199; i=tboegi@web.de;
	bh=TlIPnr80dGq5T+CMgTroRSyXBpZ8gtyxwBNFq37f5Ds=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=IITpOjaqjwT/2nb6+pXbKPqalND7e/2XL77RpQyJMLQxoTeFdMFcWATbTfEGQU13
	 glzTRLKagUhhEz4WKhvC334YDwTFx3XcP3nPBHdlqqhxL+92W5VAaoM61useL/iC9
	 EopLkFuHfTzLy2FMILnP+C58MxXXT4Z6gulugKJSFXjAqCHQ3Ta/hNDUV98NrYRiZ
	 IWBBAnFoFSSfCvnJL1N5JqISjYjVqM5w3N2CkDzwd6PETAdTCliZM9r520t9en29x
	 7qaOz7mZkCmays+QnP7KDx7jAZeD1TN2Id8g3zP9Qxf0LzPEQ8JdjkILyo6W4kPgc
	 V6yqWFhRc6XBOYqm6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1qoH6S2Vg3-00gSTw; Fri, 22
 Dec 2023 19:39:59 +0100
Date: Fri, 22 Dec 2023 19:39:58 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH] sideband.c: replace int with size_t for clarity
Message-ID: <20231222183958.GA3355@tb-raspi4>
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
 <20231222175747.GA2880@tb-raspi4>
 <CA+J6zkQ=+bCsi7URtpTfgawTrmVVALvMi3kdnMi=mUjB_Yxxwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+J6zkQ=+bCsi7URtpTfgawTrmVVALvMi3kdnMi=mUjB_Yxxwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:y7p/72aXXAiw0EhzesuQmVfTjr8S2qxRPz9nWDeWZxL2YMR8J+t
 lnr/bJYdeToZRLDHIlGZltoRPZKcRcHJXA5NZ8lQD1eFhx7AbKaCLXjE60g4ey/EmcrU2Ig
 YZM+zU2I/EsmYM1JVzHKgJjDhcNugjRvi9IuuP727wmjKzI/4Thw8g/BB3oWwBlS0le2X05
 hWuWJQoRe3CNw46SzCjsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TSohlHIYbPQ=;56mmhZTTVMO62gHn4OhRq+YXFHJ
 eN11fwEJjSPJ31ND/uL29LQfXQzGLsZTGQfFgSeWBU/bWdcUfvxWkJg/AbWBa7h3mLmJvwYrc
 QpeycFP46u4dd7+5VxCHxtZBUlEmtOSep3V089mzyaAkq7SlcKXCFtiEFO5hu3Lv/fJKOp99I
 R+wnkbHtl3HWFd9PwNr0Ta1g3QTwJhSFcNf1GdI4HUa1F38g0GwSLLD+N7GmsOaUJizWTshZO
 BZFjjYwPRpc1GnqPXTtqrkVurGPtkUmDm7ssGzFs0gdtTbFGYMXYuCdrGn1INC/2PYl7xR/on
 +CI8yOw0iJSXBGHTmlTrJwuzu2cgaEJDeqwp/NU7v5M+eX7g0/MntcgalgvcSinGW8w3q2DC2
 HBZxvXiB/mgkb5G/IeIWbTcPRiZppIGQ9PnF/Dnih9kZlVqXVmIEh3T/YnVh3brJEBC4oN50T
 hqZ64g50dPVPiPQAwxEIEXa0jaktazA9c28V7BDNAltIY/A/iyyIR1yJkUrYSHSl7He0prUtI
 mSovDMNj8tzAFvDCUBguSPmp1JnAnE4RSPHN/bz9nEAVPzz496KCSr5eutDxgvjlbXaIR8FSt
 YZpMD9orw9Rdhm9ND2fj8UhblmddlHYzFos6tE4+nF8J6IZBtIS6aZqvVlZbG+IOwP9+MHFS1
 /xCS5Q7ioEkK/oeHh+pScap/+iqFVq/0Poho+6bnj0tR5q7QAois9gLfD6pfSlveIq6SUYzt2
 R1Z6jF9uhpAZKV/a5DOEjupWku3dlDydLuGnShPQGheTnHibmQYzc0TZfJ3CKqXmeAcsrsEFv
 eCdGAUitSdLC2zDRIRsMClL7PxVfiyIX31bJc1ery0FLF8kd3IJ/EP5q2YVGt0TgoBp8AFP7f
 1pE60lw5bwGRb9wdwcz6xCVC+tDVFARMsoclMsw1splwWFKnXNbyirZKl8RIRe3OXZ5h/xFbt
 mIirSJTxAykg0TdPJ4PzzEUI01U=


(PLease, avoid top-posting on this list)
On Fri, Dec 22, 2023 at 11:57:25PM +0530, Chandra Pratap wrote:
> Thanks for the feedback, Torsten. I was working on improving the rest of
> sideband.c as you suggested when I encountered this snippet on line 82:
>
> while (0 < n && isspace(*src)) {
> strbuf_addch(dest, *src);
> src++;
> n--;
> }
>
> Here, we are decreasing the value of an unsigned type to potentially bel=
ow
> 0 which may lead to overflow and result in some nasty bug. In this case,
> is it wise to continue with replacing 'int n' with 'size_t n' as the
> NEEDSWORK tag suggests or should we improve upon the rest of the file
> and revert 'size_t n' to 'int n' ?

Yes, that could be a solution.
But.
In general, we are are striving to use size_t for all objects that live in
memory, and that is a long term thing.
Careful review is needed, and that is what you just did.

If we look at this code again:
while (0 < n && isspace(*src)) {
  strbuf_addch(dest, *src);
  src++;
  n--;
}

When n is signed, it makes sense to use "0 < n".
However, if I think about it, it should work for unsigned as well,
wouldn't it ?
We can leave it as is, or replace it by

while (n && isspace(*src)) {
  strbuf_addch(dest, *src);
  src++;
  n--;
}




>
> On Fri, 22 Dec 2023 at 23:27, Torsten B=F6gershausen <tboegi@web.de> wro=
te:
> >
> > On Fri, Dec 22, 2023 at 05:01:09PM +0000, Chandra Pratap via GitGitGad=
get wrote:
> > > From: Chandra Pratap <chandrapratap3519@gmail.com>
> > >
> > > Replace int with size_t for clarity and remove the
> > > 'NEEDSWORK' tag associated with it.
> > >
> > > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > > ---
> > >     sideband.c: replace int with size_t for clarity
> > >
> > > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-16=
25%2FChand-ra%2Fdusra-v1
> > > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/=
Chand-ra/dusra-v1
> > > Pull-Request: https://github.com/gitgitgadget/git/pull/1625
> > >
> > >  sideband.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/sideband.c b/sideband.c
> > > index 6cbfd391c47..1599e408d1b 100644
> > > --- a/sideband.c
> > > +++ b/sideband.c
> > > @@ -69,9 +69,8 @@ void list_config_color_sideband_slots(struct strin=
g_list *list, const char *pref
> > >   * of the line. This should be called for a single line only, which=
 is
> > >   * passed as the first N characters of the SRC array.
> > >   *
> > > - * NEEDSWORK: use "size_t n" instead for clarity.
> > >   */
> > > -static void maybe_colorize_sideband(struct strbuf *dest, const char=
 *src, int n)
> > > +static void maybe_colorize_sideband(struct strbuf *dest, const char=
 *src, size_t n)
> > >  {
> > >       int i;
> > >
> >
> > Thanks for working on this.
> > There is, however, more potential for improvements.
> > First of all: the "int i" from above.
> > Further down, we read
> >         for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
> >
> > However, a size of an array can never be negative, so that
> > an unsigned data type is a better choice than a signed.
> > And, arrays can have more elements than an int can address,
> > at least in theory.
> > For a reader it makes more sense, to replace
> > int i;
> > with
> > size_t i;
> >
> >
> > And further down, there is another place for improvments:
> >
> >                 int len =3D strlen(p->keyword);
> >                 if (n < len)
> >                         continue;
> >
> > Even here, a strlen is never negative. And a size_t is the choice for =
len,
> > since all "modern" implementations declare strlen() to return size_t
> >
> > Do you think that you can have a look at these changes ?
> >
> > I will be happy to do a review, and possibly other people as well.
>
