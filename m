Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FAD271
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YPhjOGWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmzLEIM7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 7ADEE3200A48;
	Thu, 11 Jan 2024 02:33:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 02:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704958396; x=1705044796; bh=M0/tAtz3l2
	WvD4t3QCXovyBrsFSbm0fmXP5GcSNQXrk=; b=YPhjOGWuH9spLODg6vzIFb4mFe
	OFXu51o3mJGC0mnq2+qAHVJc8MtuLonL4WdPtlPiLG+uJCoLtWY8ld1IgkYIhA5B
	+uZ2UfD+iTizHyjVX1s3vVcII9VIlce0bgn3ihhIo5u+tDLmww4g/Z/3yrR4/73p
	gfT+zsEBVlKL0/IIb2Dp6W13nDwlUOiXhabfaUMi7IUhYKMTp/TC/6o2tv7VG6mM
	F6kL1j5Z2KOVogVDitXmE2cXTeQy0uoWwvUYUr/XWA8E8ukVLyIbHeeYwRWZi5Yb
	H2tif2y08VqftApd16DAbKRdTXu3qx6yIoTK1WC1EIfKOFi4191wphZDQryg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704958396; x=1705044796; bh=M0/tAtz3l2WvD4t3QCXovyBrsFSb
	m0fmXP5GcSNQXrk=; b=bmzLEIM7P6P/YGDgqTD5Q9gtVzk2Hv7E5wSXI48AAQ9x
	u/SygyZQEHEPUegmCDRhLZJ7Gf3lkXT/vEwh7hb4ibv0MmzhUH6wmMB3HhgZaXvR
	3HdVkNdRBY6+szv3OHhi2JVLQpYJosnc6SWDSOpLoOdsQLvQ4uigOT9vW6KA+G/N
	iFuhIaItkP+Y+x8cNx/aP0z4qe1+gFj5e6uRmtQkWiHyfixInQDe5PbYRfdaBMJ/
	uI2qcllnVxOfbLkG8hLfHFOOxCBCtRLj6c0pWN4eh7M5g2Vr0Yp3lo2YIOIzJx32
	gAVeYUZ8G/STJdBydpzR2GLZFj6WN6OJqA5cdNNCwg==
X-ME-Sender: <xms:vJmfZdTE_HjcVG9VhQH8ZpKZnY13f8B44nUEBmVi1XSnFFmb6cKxLg>
    <xme:vJmfZWxi3C-Wu6NcZEPdZFV5JeVXDDjSyYezU9cVxiYj56ZH67AS7u--VzWcGMepR
    UXarvN_zdKsWx72Xg>
X-ME-Received: <xmr:vJmfZS1IM7xAyfVjA26dAnanDcKdx3EpDnb13laqNG4cDd-sN8gZ_7QHHC55LhfAta1R9lJfML1B-yUaUnyGxLAuNTmUjn4GYFEeUsYuiHD09tbCBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vJmfZVCVDQlHersVJ8fcdaMMPo95NOtmfaKh_ztBeokxkSsF-Kkiew>
    <xmx:vJmfZWg38lBvvNEGlDIhXMrPaU9vyZTvybKyLarPWj8GCt_bxhs_pw>
    <xmx:vJmfZZqjr9lSGnnZsVwa-qR7x2w4DVw5CcL4jY3hVAgSg8YxYRVD5g>
    <xmx:vJmfZab6Y_r8jHo8Xdjov_NTPivHu3GM2ciRB1EaviL1IfcPIcfwqw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 02:33:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b035e1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 07:30:32 +0000 (UTC)
Date: Thu, 11 Jan 2024 08:33:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/4] reftable/stack: refactor stack reloading to have
 common exit path
Message-ID: <ZZ-ZuCBevbNot97m@tanuki>
References: <cover.1704714575.git.ps@pks.im>
 <01ece2626dd4cb494829e146d99c172fa8428478.1704714575.git.ps@pks.im>
 <xmqqmstdccz8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mEQaYjJqj0DLYFc/"
Content-Disposition: inline
In-Reply-To: <xmqqmstdccz8.fsf@gitster.g>


--mEQaYjJqj0DLYFc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 09:30:51AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The `reftable_stack_reload_maybe_reuse()` function is responsible for
> > reloading the reftable list from disk. The function is quite hard to
> > follow though because it has a bunch of different exit paths, many of
> > which have to free the same set of resources.
> >
> > Refactor the function to have a common exit path. While at it, touch up
> > the style of this function a bit to match our usual coding style better.
> > ---
> >  reftable/stack.c | 86 +++++++++++++++++++++++-------------------------
> >  1 file changed, 42 insertions(+), 44 deletions(-)
>=20
> Missing sign-off.

Ah, sorry, I forgot my usual `git rebase --signoff`. Will fix in v2.

Patrick

--mEQaYjJqj0DLYFc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfmbcACgkQVbJhu7ck
PpRNhg/9FiV+6a0w57Z7hDJt3+owB+zfO5WO5evv4wWJuJQbVoRvdsP9ULtFwQnp
y7MDUkCF0FN7lY9ZoHw3ZEGYYtKrqR4ZbqVSut4pHN7G5eVJmQhEpb6eKwN/ugQ9
k66tkDrz5WyK2ZtotaYsrclhRF7ZKX2J3p4DNsBwEHxRRLsLGa/iCpVU+N1AR8YD
IaFNz8AyohVyXO790g4U5Kfrf54LkqVfVdQXMUWimZjwHfh4GB1scDfwDSN7FsrH
82KVeR40V7TcLPhS/+qW2bxeDAm56Czhz5sO+5bJ6almbO+yjV2gme2JTPGlN/lP
M/o3naYX+2KzZN95py8JngmluiR6bTvksflcivE2IuEBXBQdFAq7/hf8Np9PsbhF
bHU7bVmOa/AbPVwuH3GsNmvl89p/rsA6ffHIzZ2U6QEp93WjchblLRWRtocYftbe
JC7Pt1nbA3aCyCNBV2cEXzyWvdxSiwJbi0zpunrEOVA7n26OieOO9DQk4zYOioMy
a0nzbaefhlbPG17niDRhM+p3A3loWxBBkY/5BADnXbCVPd604SSQBR0nXwFUG2tZ
YtZrIDdVDVLaRAzYnmIrUZ4T2ENR7WpXw/+XFQHRg4aHRNB0bqUTm7neHXp7NRUM
mvNIelLlUkLS9CHgevPeo7tg489Kfg54dcuTwvzOLbXIgEnpTuc=
=Wike
-----END PGP SIGNATURE-----

--mEQaYjJqj0DLYFc/--
