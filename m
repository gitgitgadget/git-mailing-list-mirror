Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338362BE043
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066014; cv=none; b=pydg4MWwyhNcyC+6D0cafHBA9ThjCnaKu2TfDCV+PtZwXDZkP8Pd7U/TGHDQNIvbS19x4/CYqmUfrKuV70Rzl9vM6kt9JpHH4NBTTIFuAiF4tTEihVYrQs//pLbUUkDzxTr1EDzX42tie9d1Q4HhJ/ME1sfsxx8KjE3m0JT6esM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066014; c=relaxed/simple;
	bh=V/QjPt15NFFsar5nnBjS2K1U/yLGizSw1jG2RUEmuXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzX+LOkhxZRFlLeofQNO7Ud2F9o3UHW0RzdEyYa5NKFZG0+hKxoZ4ISyPd2i/ZwwKf6/L80SC24BtWeXLjd3zM4doobpm9OevTDC0xxs0PfHen/L7RSZDbnZ3FWok6Lt62IHGg7z9vIXRpLJoCsTDoUV/iqt8rduidJkj9rEq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=e9w1NXj4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="e9w1NXj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1768065965;
	bh=V/QjPt15NFFsar5nnBjS2K1U/yLGizSw1jG2RUEmuXo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=e9w1NXj4DP5ZwNbA4W+5QMb3rM8lUWSBkqz1cKK0TlnLrpvsu+7J+FLFww44g4D/i
	 HyPlZX/IZp8roamp58UwYBkzec+GkedMYgoci9P5d1U8PurZ+DqlRo3On2A1tGT9fl
	 Vz3gPAz12PsIItepWzsO9kQoQAmZ3zhzE51HtGom7Q936gPuqy2v+3Q2BPq5RGUER5
	 8tMS6XwR1Pol0o5yC68t11kwP89srQqxh9VZXbj+IF7rX23PAfg2x0UORl3hnei4xo
	 psrOQhnzvTQGDq5vZZoq5o2g/M/aVG0VSbk8BuYzhXUI3qbuvm8lSFc3hc6hMZ/3tl
	 8unui4+BkBf5iVvgqFNPmBlEsYQhzMUdoF4t6crk9bMjax2gYhlSoV4fExcm/ugqTA
	 oM0jkj0lGFNaQLo3KiD2jU5qdDspsSJsxre9oVsGUViamXL+eT1jmtOLj9W22m2cY5
	 z1lVPz/5mxIMKK21mrGktXDpNBvaiCcRm7Nwlyt0gAxfU0ED8WC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:33b5:dd0a:e744:6c8e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C9BC9200B5;
	Sat, 10 Jan 2026 17:26:05 +0000 (UTC)
Date: Sat, 10 Jan 2026 17:26:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="91KSI4w9KwMRjkbr"
Content-Disposition: inline
In-Reply-To: <aWD2x154F5f-c3pL@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--91KSI4w9KwMRjkbr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-09 at 12:38:31, Patrick Steinhardt wrote:
> On Wed, Dec 17, 2025 at 02:23:42PM +0000, Johannes Schindelin via GitGitG=
adget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Even though control sequences that erase characters are quite juicy for
> > attack scenarios, where attackers are eager to hide traces of suspicious
> > activities, during the review of the side band sanitizing patch series
> > concerns were raised that there might be some legimitate scenarios where
> > Git server's `pre-receive` hooks use those sequences in a benign way.
> >=20
> > Control sequences to move the cursor can likewise be used to hide tracks
> > by overwriting characters, and have been equally pointed out as having
> > legitimate users.
> >=20
> > Let's add options to let users opt into passing through those ANSI
> > Escape sequences: `sideband.allowControlCharacters` now supports also
> > `cursor` and `erase`, and it parses the value as a comma-separated list.
>=20
> Hm, okay. I don't really see much of a reason to allow these, but now
> that the code exists already I don't see a reason why we should remove
> those options again.

The reason these sequences, along with other sequences not mentioned in
this series, are useful is because people run tools like build tools
(e.g., Cargo) or linters in pre-receive hooks and print the output and
those use a substantial portion of possible escape sequences.  I did a
brief survey sometime back of pre-receive hooks on GitHub to see what
escape sequences were in use.

I think Heroku has a push-to-deploy technique that leverages this
approach to build and deploy your app, for instance.

This is one of the reasons that I was opposed to this series: it tends
to break what is a very common use case.  Certainly it is not as common
for cloud-based forge environments, but it is very common for people to
do these kinds of things in self-hosted forge environments (where custom
pre-receive hooks are commonly used) or in non-forge environments like
push-to-deploy.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--91KSI4w9KwMRjkbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWKLqwAKCRB8DEliiIei
gdKYAQDQWjM59eyHOIhU+2BG3Q3Y+EbIngly/ER56c+T+YDIwAD/fkyEhGnCjH6o
ruM1nejVIIwa8LQHPEadf6OTxMwgvQ4=
=kImT
-----END PGP SIGNATURE-----

--91KSI4w9KwMRjkbr--
