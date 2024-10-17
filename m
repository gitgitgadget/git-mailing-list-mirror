Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABA1C1ADA
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203708; cv=none; b=MV5+fnkaiYQJs/ILz1HPqBSP4ZlMn9ZdBbqQNoDi8Kb59nh0xIa5irhZkN8eq6+fDCkt69zudruuXzwbWfTe3vmWP/L+ZCeTeuWCv4bNzD4Qtkks9z+Ao/jNmgfE4jSndsSjNLnAOPisnnOaAjLMzbBcnf5kNaaO4aLOJTZmcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203708; c=relaxed/simple;
	bh=u58Z+GJe1HOiOcfBN0DcSi5XaRvtoV0X22306lN6bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBRCB5s6HcvTuRayXt3YZtDGblqiGz2VN1ZXCCk/yikrMGz9YodjI6t0W45lsHPMXH/YfJic1qJJ+xluK33uO27fEHm8LHbcIkazN4w2tbGpYDd11P4TsrjcEfYOtnGUOBWVgwTTWW9zjKOGsyz1DSp+2jp2pjG82T9XvBTtnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=D1XtSKBk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="D1XtSKBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729203704;
	bh=u58Z+GJe1HOiOcfBN0DcSi5XaRvtoV0X22306lN6bv0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=D1XtSKBkTYopKgCsRJjNVnLx5nvyO1kLedhjhV8TkPiQDDcoLeE6Fe89a8ceWFktZ
	 1R45f9zD+aUgU0b9UkbnRkSIqDtzBlFonTnHbqaIwTotvtPxqUprsSaXAq+I8/NemS
	 HPkBr2A1JvM8GWHAF4FEkwa4FHyvIZNEUc313N9GmpyAqA1aK6B1JjGtBh3rsWd++G
	 TybNy3kiNBQtAikZLeE0hwmUUck0aWpF41y5nNS1BxA6PypkjGmOppTpizeCVfUqwo
	 DD0G53IgrAO7NxqsBiNLA2o11f+4l5088IH5TcI2IE56H76BTJ9tBI1iNjWZmA0WPy
	 8imUWuoW0B8lIv7259lVYHOR2kwFtI7RvSBuLVhicM4O72nSpI77JESq/KqtAMO3Z+
	 9OPKpEFICN1lpRY5hBTuJF9zZV2NoEipTVbQAxJKn50Hsk7oWrc76+O/oqi/+MqnoT
	 y/Ilu+psH0mFaP8qadBpkk0PyzeSD3PtOQ8diBPHHMVA0H3Al3A
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D3130200B3;
	Thu, 17 Oct 2024 22:21:44 +0000 (UTC)
Date: Thu, 17 Oct 2024 22:21:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ozrua/5OQkeNB21I"
Content-Disposition: inline
In-Reply-To: <ZxEXFI80i4Q_4NJT@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Ozrua/5OQkeNB21I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-17 at 13:54:28, Patrick Steinhardt wrote:
> On Thu, Oct 17, 2024 at 03:33:51PM +0200, Patrick Steinhardt wrote:
> > On Thu, Oct 17, 2024 at 10:51:05AM +0700, Bagas Sanjaya wrote:
> > > Hi,
> > >=20
> > > Since clar unit testing framework was imported by commit 9b7caa2809cb=
 (t:
> > > import the clar unit testing framework, 2024-09-04), Git FTBFS on ucl=
ibc
> > > systems built by Buildroot:
> >=20
> > Wait a second, that doesn't sound right to me. `wchar_t` is part of ISO
> > C90, so any system not supporting it would basically be unsupported by
> > us from my point of view. And indeed, uclibc _does_ support that type
> > alright. I guess the issue is rather that we're relying on some kind of
> > platform-specific behaviour and thus don't include the correct header.
> >=20
> > I'll have a look, thanks for the report!
>=20
> Okay, uclibc indeed has _optional_ support for `wchar_t`. But what
> really throws me off: "include/wchar.h" from uclibc has the following
> snippet right at the top:
>=20
>     #ifndef __UCLIBC_HAS_WCHAR__
>     #error Attempted to include wchar.h when uClibc built without wide ch=
ar support.
>     #endif
>=20
> We unconditionally include <wchar.h>, and your system does not seem to
> have support for it built in. So why doesn't the `#error` trigger? It's
> also not like this is a recent error, it has been added with 581deed72
> (The obligatory forgotten files..., 2002-05-06).
>=20
> We can do something like the below patch in clar, but I'd first like to
> understand why your platform seems to be broken in such a way.

Yeah, this is definitely broken.  We require ISO C99, and according to
the draft preceding the ratification[0], `wchar.h` and its contents are not
optional.  The similar draft for C11 also doesn't appear to make these
optional.

I think users of uclibc will need to compile it with full ISO C99
support.  I expect that a wide variety of other software will be
similarly broken without that.

[0] Chosen because it is available for at no charge and the standard is not.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Ozrua/5OQkeNB21I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxGN9gAKCRB8DEliiIei
gT2sAQC86C4cUWax84mhzHdJnPzY5cCqwRC4VQhf/SpFe2UXGgD/X4DzMaeWopk9
nOOVOfT3c3sJI/hkHIthcNApos9UPQQ=
=UP/w
-----END PGP SIGNATURE-----

--Ozrua/5OQkeNB21I--
