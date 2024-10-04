Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C217FE
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000969; cv=none; b=jJoypxikmWozTZCTiiIp6kx6+2RHoXwF0UY+jToolHPwDnGqnrxdgxdkA86FZnCIE04UR8KRl3C05588bgimvAnIrSDlpNNfacTD1AUD4O1cT68hz8F/pQ/8/UqLAak9cgCWHifSZXODvYilgqf1FCd4IqMtvNMG1qvTNxW7ERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000969; c=relaxed/simple;
	bh=ilMn4WQL7kxTagVeMy0Vokg/jwFv4J9IYB4Kw/xOzJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvfRTJJGsThpFttO4HyWC+b+sBVp9zr6osvNiLaGrP0Sedotmm5Zl5tR154EXQe6Plj9DhAe/ak11VjraY8awxSdTSpB8sb3vzqCMLZywhfmHixOyHtocbvIK1IrPFYSg/t+aMcSWjx6wsO46tzZc+IwFB2r2RkrDPN7MJqO8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HGgg17D9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HGgg17D9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728000959;
	bh=ilMn4WQL7kxTagVeMy0Vokg/jwFv4J9IYB4Kw/xOzJ4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HGgg17D925gWFCkFsKNjnK+OalA/uIRiF0VbI4X4YBhNo9USEgyaM7wZlroWTsV8t
	 KN/GEKbgEbtMXAw462nYplZmOpW8BJR9PNhsBlUWpMHZC8Ffdzvva9vnRO+SzBxyve
	 kIiJWCrKvl7LyXxx215SL8BOs/AaR8aqVqXzVNTT65gXBtmJqfudkMkwskOAYc+QLs
	 CnWRH5fsYkh+M8ABw9XGvEe1CHfZvFtP8jIHgMBaHKO3X9e8lXlnwNHhbMGkUGtiB9
	 BtJEz2eJ3Jydw1vXBiHBa9Nztc9bE1oA/3P+xCL1uWhouURomDw8IUEa7zHjrKoflz
	 m1o7kcDQxxxzNnUD3ecxkSuyY0W6LlhwDzXfzR5AgTDbSRwUWKfhLhNTlGWTnk9ZM6
	 J7MEUGR/7K3ZdJwI9AOGKiLVw9FN5czCdHDxVcXYlTjLlN/UMbW2pzISHB5DeEWmiK
	 0u9nYuuxBlG6BY7vTRX89iaB6jB3qib2laP3FlHWQoMLdtipaAR
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 57ABB2007C;
	Fri,  4 Oct 2024 00:15:59 +0000 (UTC)
Date: Fri, 4 Oct 2024 00:15:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <Zv8zvogCJ9EZDBQC@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
 <CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
 <Zv3IHd0c4_0NPjOK@tapette.crustytoothpaste.net>
 <CAPig+cQjk5_VJ-LNc9Hx3Q4n6H5bgg5cAztWhFpuweG8wFTjMw@mail.gmail.com>
 <xmqqwmipi342.fsf@gitster.g>
 <CAPig+cSta8arLqa+v1rVwMdd7w0q4RxNzrooCzKAma88cR25hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ueLhbT9zkU5N4viM"
Content-Disposition: inline
In-Reply-To: <CAPig+cSta8arLqa+v1rVwMdd7w0q4RxNzrooCzKAma88cR25hA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ueLhbT9zkU5N4viM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-03 at 22:27:29, Eric Sunshine wrote:
> On Thu, Oct 3, 2024 at 12:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > That's why I said in my original response that I didn't understand
> > > your response to Phillip. You seem to be using a non-justification
> > > ("other programmers suffer, so Git programmers can suffer too") as a
> > > justification for a non-ergonomic design.
> >
> > The statement may be a bit too harsh [...]
>=20
> Yes, sorry if that came across as harsh, brian. The "Git programmers
> can suffer too" was my (clearly) poor tongue-in-cheek attempt to
> soften the earlier part of the email in case it sounded harsh.

I'm definitely not offended.  We can certainly disagree on the merits of
the proposal; hopefully we'll find some solution that the project
generally approves of.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ueLhbT9zkU5N4viM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv8zvQAKCRB8DEliiIei
gWwvAP925Mm93wIapxWtHt6MUht9CefnKuzcrzbcoeg2PNs4xwD+NVEw5FzIHuyJ
cqfZRqg1qB2l7YLM24Jn0cz18JRzYgk=
=4adC
-----END PGP SIGNATURE-----

--ueLhbT9zkU5N4viM--
