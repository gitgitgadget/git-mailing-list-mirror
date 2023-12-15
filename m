Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DC107B8
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RfkGShvc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ynTmPPXZ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A1C1F5C0254;
	Fri, 15 Dec 2023 02:58:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 15 Dec 2023 02:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702627137; x=1702713537; bh=7cMv0EbM28
	KLEgieSNrZK8BL/POFw4apzgHwnPb/byM=; b=RfkGShvc6QvB3gUtjDWLAN2F0v
	K8YDgMNXUeMP378fDWYug6Ri1sBdWMJkk9IMpSDA3+FELJmaxq/IpV8k2K5VOTCV
	A0/bV3phy54P4eN0vTqeIjRSrAvxoBVZPCq4YWvAhsE4Ts71XyT2sTQs9ovki/+C
	Kunyq7M28WbRTBbab9c5uUCW6TBNVxPgIiClvFRQQoNDGjx4MZA+ncgbWp6cvkIU
	PMH/c+tC0XBM+df81tPaZ4qiNQ7OZzdO+v3NzQEm5QL3Zdq+MmGl6b7TV4HRM9nl
	l07rmVKq2PX8tzKvbLs472LTCzNKcDLS4a1pJ4pEFPzfIfgP06nWGo8mAuVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702627137; x=1702713537; bh=7cMv0EbM28KLEgieSNrZK8BL/POF
	w4apzgHwnPb/byM=; b=ynTmPPXZ1QyyBbqUvu+fNqyDEYwIAaFaGPLKtajw+92G
	7cRd/aVm9gD5cGR2gTR2rAUAqEtp+Ab7VFKgoWXLWJ/a4lxTgb8+NTmNNkL8fts5
	JCH2iozZ1ufwEcRz8nO1FzFqIbMeZYAM042eN1BjiYRKslRrwFQUzgEeI3DeZMYM
	mmMR7lIvkUfQqfTUavu9Dxqqhhq+OSr38KaZPiZDN40Q8YR7IxsXUQCaMqq9ODPR
	QQQD1fzWScp7l/jE3Dw5M51Sfsp0o7QIKPq0KWm6DzGFs7FpeCKj9gUH6mIz2hR3
	sh0/MMGD57In8mQfwPGZzNRgPxBYIh8Kwf6WmU7gpw==
X-ME-Sender: <xms:QQd8ZRQzYb7VnnGh6nDFMcgnBPTpl38WKIODRw9fEfi7r90eKFE-yg>
    <xme:QQd8ZazTrBlhJIgtuYhsaRkqGkSnQ_chU8IVkNJn2Gy_Tmez6CYcGu_gFASC2w1dz
    ev-J1J0fflhsz1n8g>
X-ME-Received: <xmr:QQd8ZW0As3Z2aWy7_HWgt4F_Ul-xTQf1ch07Z-j_lzkPrTxYhlcPT3ckZDCENSpBhvpMSmCt1uiDcBC5qlMXMiRSV_rs2xGttQhm8QMrMyrVlrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtuddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QQd8ZZCI-IsBtk5vhvtQpJGwZEfkA3Dw-08GRHB6nFiALV7YLks_ow>
    <xmx:QQd8ZahJh-QW05oI_Q5AQwbxMopamd_fBDzvEApDSuZbkfkN5DKkYQ>
    <xmx:QQd8ZdrojfH4ssaoY8NNLXE-SJJI8UYz_z37kQIgGv2GD5E-OfvNqw>
    <xmx:QQd8ZdvjQjbqiQd2P5Nd7M3m9xMOqxq4FPj46mxoup8ya7A8OQnycw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 02:58:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 466da6a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 07:57:09 +0000 (UTC)
Date: Fri, 15 Dec 2023 08:58:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 0/2] avoiding recursion in mailinfo
Message-ID: <ZXwHPL3sWhzwamrp@tanuki>
References: <20231212221243.GA1656116@coredump.intra.peff.net>
 <ZXlYIZ0Hb1kN84NU@tanuki>
 <20231213082027.GB1684525@coredump.intra.peff.net>
 <ZXqxoKLFG19tMFpF@tanuki>
 <20231214214444.GB2297853@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VBaNZ63Cb/fsAbm+"
Content-Disposition: inline
In-Reply-To: <20231214214444.GB2297853@coredump.intra.peff.net>


--VBaNZ63Cb/fsAbm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 04:44:44PM -0500, Jeff King wrote:
> On Thu, Dec 14, 2023 at 08:41:20AM +0100, Patrick Steinhardt wrote:
>=20
> > > @@ -72,11 +73,14 @@ static const char *unquote_comment(struct strbuf =
*outbuf, const char *in)
> > >  				take_next_literally =3D 1;
> > >  				continue;
> > >  			case '(':
> > > -				in =3D unquote_comment(outbuf, in);
> > > +				strbuf_addch(outbuf, '(');
> > > +				depth++;
> > >  				continue;
> > >  			case ')':
> > >  				strbuf_addch(outbuf, ')');
> > > -				return in;
> > > +				if (!--depth)
> > > +					return in;
> > > +				continue;
> > >  			}
> > >  		}
> > > =20
> > > I doubt it's a big deal either way, but if it's that easy to do it mi=
ght
> > > be worth it.
> >=20
> > Isn't this only protecting against unbalanced braces? That might be a
> > sensible check to do regardless, but does it protect against recursion
> > blowing the stack if you just happen to have many opening braces?
> >=20
> > Might be I'm missing something.
>=20
> It protects against recrusion blowing the stack because it removes the
> recursive call to unquote_comment(). ;)

Doh. Of course it does, I completely missed the removals.

> The "depth" stuff is there because without recursion, we have to know
> when we've hit the correct closing paren (as opposed to an embedded
> one).

Yes, makes sense now. The patches look good to me, thanks!

Patrick

--VBaNZ63Cb/fsAbm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV8BzsACgkQVbJhu7ck
PpSNBA//YBq0KkZ5S/K4wqYZLLOyzL22th0gw+xzP6jvD1RLzAaft04CyjJzdGHv
PbUStMdJTavM0tprbgvVdraeMx15bsYNca6svsTb2PcEuZemLcQ9jOzzSIlcU5ok
MjBXAj7pOMPaVSoxiJnUfIEjxloQs6VMRmaYo3mvKpbkraVDF5gZxKW4eEbz3pvQ
xqlA5evCls4xMDHy38xKOkS8cHJEZ8HLnRsssD61qwo64KgjdgsSSuO+XqRWA+Cb
IdSg9bBOExqgP/hgYsjrV+dZfXX+MUWY9syzSAHg0y3V+dFfhtyLAm8nBqBJf67i
ekVQZuefwYogrlsP0ySCixl7YhBfSQSrLu9LW54bkIdOEABIQA1N9yt7qvvRpK73
b9lXLXgDN+RJUcDnnNPK06szsKstFkW9AYkDJbZV2BsSI2f6gaP9uK1Pl2vKKD9R
HsrwXqeS4ffGOPhzWR97adZY+MpoHKJwtpGWlnYAnF4C54pr7sEt4Ci813fJtTKm
T1PcFXvIHKL40GEbbCYYpyIPtXkZ4PxZJ5431jtVnSs96TKrKk82JoigCUUH7mby
rWatAZUMGnb4nsNzQCLKKDzlmUGjw46XXeSOj6isDLR4d/7sCcPL5/dkSX7fIkBG
hi14BdRwoV1uSi+djUISIOCwR7eHyQzw+3aiX6hA6jGFggQxZC0=
=4UvZ
-----END PGP SIGNATURE-----

--VBaNZ63Cb/fsAbm+--
