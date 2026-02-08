Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251F4086A
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592893; cv=none; b=g3DiGl6Fe/AyPgd8SHbCr4TCmaqtnXrTW/poK1MmFbJG1FugYRss9og6B5ONj0djIgwjOSOsbbWJzcm6wxmQ1Tnz34Tdt2nfjense9EOK0zzOmxra+7ljOaimiPrHFT891cIJsAGX4FMQna4VYs91umyr51V0Dg1CJzWMZ1xm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592893; c=relaxed/simple;
	bh=7xXna4K8Df+dzheKNFKFYkGwJBzch+pPo+tgFyIa8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9N8sPcOHsvuRnGVB+8IM6kFpdeKVUVsH4qoK3y+Buy8vfFnpbou0dxuqe5yh24FssGYBCJyBwI+YF1tTmBPL0VSHJsgXNj5dN7TwZtAviRS7fMpV3uqOUbYd6GBabNrZtMBG/kSRVl3s41qQ9uhpeAKVRBHj4+ycIjJtFHXv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lGYVM9M6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lGYVM9M6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770592892;
	bh=7xXna4K8Df+dzheKNFKFYkGwJBzch+pPo+tgFyIa8kI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lGYVM9M6HFHfLc9I/faB/1l1eFkvEqa+pgzBRHxPkwPuKqifo5OIswrlKAutpFRll
	 /HsHti7mZz3FNH0asJguHwtyjdr6EiYrnb4oNPAeQ/FIZYtpIzXZ4gzV6oXGhVi6IG
	 TMIWPwJNXEIINlJuv91ho0rbOmAajgqpacV24tFItJyIQjTqRVJbwQsYRiWbnwXNZu
	 391QIKfOFdRFoDV7T9yv9CNe6u6OFwM4duKXzGM9aJQRDHVPr44BXTA5jmM2tgKMct
	 CHPwiyqa84+eiWjuz6Kkl9TdzCRtkXEeExlL69yRg5HyhiDgUt1+Be/WAqZK41dqL6
	 /tjEO9YS+ThxGcwJfd2ULMn6fYVXR8ZEZANU0sG4G9OOUMtjRuO0UKb4ej28KrHvaA
	 hJR2vYuBuEXVto21ViT9YANJ2AwY9Fdeg/+DmpZgLckyBIb+z/iZDhOvfupJepCksn
	 e42+m5KsvBSQ8/4qd0czr/Myi4fiAuNKLttZnnTliBT7mjI8bqb
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:452d:fee3:684a:bd07])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 19898200B0;
	Sun,  8 Feb 2026 23:21:32 +0000 (UTC)
Date: Sun, 8 Feb 2026 23:21:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
Message-ID: <aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="69ccrwoohiwwiVUW"
Content-Disposition: inline
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
User-Agent: Mutt/2.2.13 (2024-03-09)


--69ccrwoohiwwiVUW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-08 at 15:30:02, Jonatan Holmgren wrote:
> I think the best approach is to support UTF-8 specifically for alias.*
> variables, which would mean modifying the git_config_parse_key() fn to al=
low
> UTF-8 bytes and make non-ascii aliases case-sensitive to avoid complex
> locale-dependent case folding.

Yes, I don't think anyone should be relying on case folding for aliases.
Not doing case folding also avoids locale problems with Turkic
languages.

Our mailmap also doesn't do case-folding for non-ASCII characters,
so there is some precedent, although I wish we were consistent by not
doing case folding at all.

> The main pain point would be making sure all platforms handle this nicely,
> esp since mac uses NFD and not NFC Unicode.

I don't think this affects command-line arguments, though, which are
just bytes.  Since running `git param=C3=A9trer` would just be passing
`param=C3=A9trer` as a command-line argument, then it should pass that value
as an unnormalized UTF-8 byte string.  It would only be normalized if
Git invoked `git-param=C3=A9trer` as a binary or script.

I don't think we have any Unicode normalization code at all in Git,
though, so if you want a quality implementation, that may be a thing we
need.

> Before implementing this, I'd like to hear:
>=20
> 1. Is this a feature the project would like?

I think this would be useful.  I don't personally plan to use it, but I
can imagine a lot of other people would, and in general I'm in favour of
better i18n and l10n support.

> 2. Is my implementation approach reasonable?
> 3. What concerns should be addressed in said design?

As I said, Unicode normalization may be a thing you want to support
here.  Not having it isn't a complete dealbreaker, but it would prevent
hard-to-debug breakage.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--69ccrwoohiwwiVUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYkaegAKCRB8DEliiIei
gScdAP4zBMJHzJRBpxDS/owrCynyq3TOzN8zZfpOgkI3tvYWnwEAxbz8y3i55N9u
NJvpJv1FGkzKECfK7VZliC4pqz0PpgQ=
=wIjI
-----END PGP SIGNATURE-----

--69ccrwoohiwwiVUW--
