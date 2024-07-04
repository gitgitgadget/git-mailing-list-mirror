Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279045945
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127411; cv=none; b=d/KFHxGqHTfeWouY3XVA5oGeIJKGwalbu4lzmQRLBH03zbJanDk1J19z49ic7Mf0djJ1xlJtHJXioC2hDxVhRb4GIrcKNupNzK/Nn2cY+rTJygQiT+B6c2TgGddBX79/miBjzd7tILSOFAg9Uz5DdBooJ7FKqc6UU28aEW3CYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127411; c=relaxed/simple;
	bh=chJ0rvS1cRt7RQ5lm6tsyzxVWvGL4Oc8zaLdNJhYJdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy56NLNJz4oAt7aStf6F/Lee4XJQOT8SetJIJfk8Pwvy/wFg48U7ZVPZMWGQLN0DPOrt38pxidRGdvjMpkw49td3TaYV/o6DecGNiwogcvxDEYkTbXdY5wkyHNTyx0RZFTw6R8H9ZA6RK7V+f1ot2Da/iFhiz9HOs0KR43YvebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=L0BPlQ1F; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L0BPlQ1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720127408;
	bh=chJ0rvS1cRt7RQ5lm6tsyzxVWvGL4Oc8zaLdNJhYJdM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=L0BPlQ1FzuRafioe2ScDObTfIaIOprxTup+5RrsUtj3xZgpeEUYzM3V8volpprrn4
	 6JGsyNhEf4hGF9DNw0sg8K2jNU1SVfNOsBePiySjaJyDQbrgwO8nu39RzK2qF1FhBY
	 N7oP++k9ESKest84Gphlk1rCIS0RNQ6f4Uvq//pwjzzWpTZkhQsguRBAYAcHAQdSxU
	 khlq3OILIT+13Yw37oc5ExiJ8YMVRTptw9KVW/JO14DVHLPumv84GEBsvuCvpYB/eE
	 OKJKH87YN2FHYtiv69Ih3CjeI14+AfZyV5+KKvOQb8Re/MWJJOjv/3O351fW/iUzlO
	 lxehEoayBrl6YeKH4MuZD9ASArnSwr192psUK4AkVHNX2Zi45YEnJ2/OHYf47Ft6ks
	 qDM9LlXnMCFHfxij6scHJ7mtO9pSYLoQ0JkrziAsLksDB2bTKb9M6qD0mxl9PsJGGO
	 D8QT+TludbViMFT83hXSX07FRtWsox4sh4Fm+jDubnB6a8Jxu0K
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8D3A020992;
	Thu,  4 Jul 2024 21:10:08 +0000 (UTC)
Date: Thu, 4 Jul 2024 21:10:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] gitfaq: give advice on using eol attribute in
 gitattributes
Message-ID: <ZocPrtrOVTqSeUTY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <20240704003818.750223-3-sandals@crustytoothpaste.net>
 <xmqqcynt91fe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XBcn90xhbwqaT+TV"
Content-Disposition: inline
In-Reply-To: <xmqqcynt91fe.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--XBcn90xhbwqaT+TV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-04 at 05:22:13, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > +With text files, Git will generally ensure that LF endings are used in=
 the
> > +repository, and will honor `core.autocrlf` and `core.eol` to decide wh=
at options
> > +to use when checking files out.  You can also override this by specify=
ing a
> > +particular line ending such as `eol=3Dlf` or `eol=3Dcrlf` if those fil=
es must always
>=20
> "this" being ... Not what gets stored in the object database but
> what is done to the working tree.
>=20
> What is being "overridden" is that the earlier two mentioned here
> are configuration variables that apply to _all_ text files in
> general, and the attribute mechanism is a way to give settings that
> are more tailored for each path.  I think the reason I found the
> above a bit hard to understand when I read it for the first time was
> because it didn't "click" that this paragraph was about configuration
> giving the general default and attributes overriding it.  Perhaps...
>=20
>     ... are used in the repository.  The `core.autocrlf` and
>     `core.eol` configuration variables specify what line-ending
>     convention is followed when any text file is checked out.  You
>     can also use the `eol` attribute (e.g., "eol=3Dcrlf") to override
>     which files get what line-ending treatment.
>=20
> or something?

Sure, that sounds like a nice improvement.

> > +have that ending in the working tree (e.g., for functionality reasons).
>=20
> I'd strike "(e.g., for functionality reasons)" out, as the next
> paragraph makes it sufficiently clear.

Sure, I can do that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--XBcn90xhbwqaT+TV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZocPrgAKCRB8DEliiIei
gUuuAP4q2bAlSxWYICygSpF/OicfdVOftgd0oedO2LXZvwaO9wD9Fg2BBEbneeCk
zu8HOT43IeRA5KCdB15XfYsxuhC/cQI=
=58sl
-----END PGP SIGNATURE-----

--XBcn90xhbwqaT+TV--
