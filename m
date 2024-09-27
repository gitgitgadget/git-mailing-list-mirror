Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10D14EC5E
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465393; cv=none; b=qAJbB8iBdxXh/rj+HEUomGKsWNnTDZJb5dH3p27JEqZwe8B9gPvmn3YFqbNdcdqfmVV4Mzf39u8GQrjqb8BF5OmXyRYdm7JyuYLhqkkfNoTWRYGlxV8ruN7ulo0hfFlO/W60Ixm/4UQj4i4fpwsb9xEfA9SKymPyaicTHzemQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465393; c=relaxed/simple;
	bh=Q6OIcV3tzPdpAiOw7Z4an4rqd8GqV72BNP7NHdGTLrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIjQW58vg/bD8Mp/L993WU83/Ynuit600QeiA8rMPSYLI0Qvf50tAkPh54CH/Fzvf8276c6qnkP8S2EObpdXlhwm8R6sFwaeN3DhBQseoCupe/SGtMPXc/7R3cpNVcb45+Tq4PFCja9jRxz/9zzqhcyz1btCkkrJVMN6JpUkGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kCyHF/Pf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kCyHF/Pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727465382;
	bh=Q6OIcV3tzPdpAiOw7Z4an4rqd8GqV72BNP7NHdGTLrg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kCyHF/Pff8Y0R70wq8Y+GZgC9oIRMHnLyQ8/xGJZTBdQW3XKVCvqPQHseBtKu+jAG
	 74Exn+ZG5uQ1wvvl6N5RwGsvFOSmMkO4rg8cKZ6En/CzJoFZi9YFEZfgHn4aL93LTc
	 78fexIWMRm8X50ZCdzzS8F7xBcbyGwtlKyZu2fc4BIp++K5+ck1UexgrMrPhKgLy6u
	 30vaIKV0CtFS2l+YiNIaz0PD4RJvjNNjQ8V3fQ4VWmPncExaiGftT8CzYz/IKlVOeU
	 yLxbibLXh5nSisToX1EqPM/VBRD0ExVkam1SMuLpOkWGujjW/+DPnqch3lhx6ox3eu
	 rCQ6YeHVQIzis6r77YerXwtQTlcjetmVTADUNhKpd0WpwB238jbw7vx+CR9iRdkQQ6
	 XFAyZWtffgbWrqOgVIzdrdF1tYZt0tInV8hAzewNBkuPKYXQAhMrE0bEXMT9Jfzc+E
	 7e4MaGgYC9iz2cGv+5i8EOBS6jdK1COP5Vd+XwdOwR/yc9+QZQG
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9DC822007F;
	Fri, 27 Sep 2024 19:29:42 +0000 (UTC)
Date: Fri, 27 Sep 2024 19:29:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/clone: teach git-clone(1) the --ref= argument
Message-ID: <ZvcHpd26te8TPacz@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	git@vger.kernel.org
References: <20240927085438.1010431-1-toon@iotcl.com>
 <xmqqikuggaz5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zVCsVdk5s0ZkM16F"
Content-Disposition: inline
In-Reply-To: <xmqqikuggaz5.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--zVCsVdk5s0ZkM16F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-27 at 19:20:14, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
>=20
> > It's pretty similar to --branch and
> > while --branch takes a branch name or tag name, it doesn't take a fully
> > qualified reference. This allows the user to clone a reference that
> > doesn't start with refs/heads or refs/tags. This can be useful when the
> > server uses custom references.
>=20
> "when the server uses custom references" is a rather weak
> explanation.
>=20
> The answer to "Doctor, it hurts when I turn my elbow in this
> unnatural direction" is usually "Well, do not do it then".  The
> answer to "Doctor, I cannot use the --branch option because I use
> non branches to keep track of some histories" should be the same.
> Why do you want to turn your elbow in an unnatural angle in the
> first place?

I can't speak for what Toon intended here, but GitHub uses some
references under `refs/pull` that are used for tracking pull requests.
We even have some in the Git repository on GitHub:

  % git ls-remote upstream refs/pull/* | head -n 5
  f0d0fd3a5985d5e588da1e1d11c85fba0ae132f8        refs/pull/10/head
  c8198f6c2c9fc529b25988dfaf5865bae5320cb5        refs/pull/10/merge
  d604669e32e847c2ba5010c89895dd707ba45f55        refs/pull/100/head
  55ab0c9399879683b4cc6e1baea5dc41484ca52f        refs/pull/100/merge
  08d39e0bb5b9dbd16e9e4c2250e75848718c453b        refs/pull/1000/head

These are not kept under `refs/heads` because `refs/heads` belongs to
the user, but it is generally useful to check them out in case of very
large changes or changes with complex binary files which don't render
well in the web interface (among other reasons) that might need to be
inspected for code review.  So I think this is a generally useful
feature, although I agree that perhaps the commit message might explain
the benefits in a more concrete way for those who don't already
understand the utility of the feature (such as our illustrious
maintainer).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zVCsVdk5s0ZkM16F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvcHpAAKCRB8DEliiIei
gbcmAP9AhOF2+06/hSRn1e15dn3BjnJRTyN9WYVQOmbIngVM8AD+JlSo5/SnPKRN
Ob1QfEIs9mvWL0HsAhLLFuT5qCIviAY=
=MEIy
-----END PGP SIGNATURE-----

--zVCsVdk5s0ZkM16F--
