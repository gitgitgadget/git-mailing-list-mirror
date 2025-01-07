Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCE1A83E1
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291409; cv=none; b=Vw1/DIxblDPDBNf04y92uzYWsYZG6fE2dkE0MItFTc5KP4HAFrBo21uG/v1EeSq8yn51vcwK5wAKT8RLo7F5s3IgpKYR29dwM3fUVcl8+Fmqe34JbQOKl9KFa4FPtiYnkbVMTVcIASR2DHB5VpDafRyJDZq/2fR8reF/c+CcrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291409; c=relaxed/simple;
	bh=/TtCgWipSypEenxFEWpnoiKUqIXvvZVPO+oFNPbQclc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6Gxi9BQg4X57qr8p/frZnbV1+ryFrmsTsZZxmVI8GJS2bfuCwdgcXFsyCsyPog6QKDPd3lXXNq6YxmJ+JNmI8E0eanUKNT3sVCBp/UIzzQvxI30AczwQ3uC0ujY9KbDAGccJtbIwYf3z9MkyIfyEb6dfyRLrroDhjkbi9221Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SV9kwX31; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SV9kwX31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736291398;
	bh=/TtCgWipSypEenxFEWpnoiKUqIXvvZVPO+oFNPbQclc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SV9kwX31TcoiH3SVXxA9q6DFu8J/NMVaZr1RB5tyicuL5vlY83bnf67F0Aq6OQKLb
	 kJdvuvJ1o48Mg1LnDIeqlE/56G0DrE6II1X2TL4ymDNq+WoZTmwYqkKZP1+QgcGH/i
	 rPLAqTax6Goh353y2Nyk1TmZlPnbjDwYHs0XwOqNR12s3bF17BRTmRfZpbeyf9jxsM
	 fOYQj6LUAU9KOtF80qH35B0um+ltiK3d5aYCbURWLNWBKI3cYObXGvfq9mmWaIo+JS
	 SzLjeFd17TYSU9Va3gNDLKn483BujNw9oxUebxhdgBL8l5w8uV6j7f+/wnH8YZZ7xj
	 dEYdgKE/gElMuEmbORsiv222fA90xoPENIn9RgABC6D7bP7PyKX161g9Uh/yFnHxWU
	 LWbIq9UmBrLNC9wutEbqlqoCg/6Jvjy5BXmQ6rQLTkDA1KHEujByEQZX56xYrcyRqx
	 9oulz18sK3qAr9oNIKj3uKyDMi5xsf6gP7iPMAu3gxrutkl5A4H
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 55931209BF;
	Tue,  7 Jan 2025 23:09:58 +0000 (UTC)
Date: Tue, 7 Jan 2025 23:09:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Vadim Zeitlin <vz-git@zeitlins.org>
Cc: git@vger.kernel.org
Subject: Re: Would it be possible to add an option to disable validating
 submodule paths?
Message-ID: <Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
References: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WjrTWuSbv8kaERma"
Content-Disposition: inline
In-Reply-To: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--WjrTWuSbv8kaERma
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-07 at 22:00:58, Vadim Zeitlin wrote:
>  In e8d0608944 (submodule: require the submodule path to contain
> directories only, 2024-03-26) a check that submodule paths don't contain
> symlinks was added to Git. I understand that this check is generally usef=
ul
> and helpful, but I'd really like to have some way of disabling it for some
> trusted repositories and _allow_ some of their submodules to be symlinks
> (see below for the rationale).
>=20
>  Unfortunately, there doesn't seem to be any way to do it currently and I=
'd
> like to ask if I might, perhaps, be missing such a way or, if I don't,
> whether a patch adding an option to do it could be accepted?
>=20
>  As to why I'd like to disable it, it's the usual story: this change broke
> my workflow (https://xkcd.com/1172/). I have a relatively big Git
> repository that I use as a submodule in many of the projects I'm working =
on
> and I used to just symlink the corresponding submodule directory to one,
> primary copy of this repository present on my system, instead of really
> initializing the submodule. This saved me many gigabytes of disk space and
> is also much faster than reinitializing the submodule every time I start a
> new project or, more frequently, create a new worktree for the existing
> one. And this worked just fine for many years but doesn't work any longer
> as any operation on the repository, even just "git status", now gives
>=20
> error: expected submodule path 'submodule/path' not to be a symbolic link
>=20
> as soon as a symlink is detected. Under Linux I can use mount binds
> instead, but this is much less convenient for many reasons and I'd really
> prefer to just keep using symlinks. Would it be possible to (optionally)
> allow using them again?

Since this is a defense-in-depth change and it seems to have broken a
reasonable workflow, I think adding a config option for this would be
reasonable.  We've recently had some discussions on trying to limit the
defense-in-depth measures we implement on the security list in the
interests of allowing better discussion and feedback on the main list
and avoiding regressions in people's workflows, and I think your email
lends support to that approach.

I'm not presently planning to add such an option, but it shouldn't be
too hard to add a global variable for that (or maybe something under
struct repository) that's updated when parsing config, and then check it
in `validate_submodule_path`.  We'd need docs for that option as well,
but that would probably be it if someone wanted to do so.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--WjrTWuSbv8kaERma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ320RAAKCRB8DEliiIei
gR3fAP9VtYX7PjXyKKtffC7wJ/7BR4fyLWHmvmSTeZFlq3RHpwEAzYyUCVnWS+18
ml99kmRQeadD3LcVz+GB+OzXXR2Azgs=
=l2Mx
-----END PGP SIGNATURE-----

--WjrTWuSbv8kaERma--
