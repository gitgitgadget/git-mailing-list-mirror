Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE84A06
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959361; cv=none; b=JrYLin+H/TZ9/LY/IWeMwD8ltxog2clGS6l8xxT+BNlvdHCDNb25k60DrJPap2Yw0lBHs42i7qFb3ki8nIOXaQPRLWxi6tYIdoH8fCXPUPxEE/5lwOM6FzKT3W50g0h9axRLkp3CyxOE1BjXg861B/VHm8vDqOFnqw0kcRiH7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959361; c=relaxed/simple;
	bh=ZsloaIwH44GQ5oYieyftPjXtMBTxDBEArG6W9ccPyA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL1IVpIKPoGK+5AexRM5D88IGfg2fuzC0+429DgUWZ4hlF2iIbH6XqVuPH3Ro9fc25fML7yHwt/EwWtuqNaxiOulQUJ/cNZAYkG00JX8OMuYxp3K0O8+UYhZaDrwEpmCknA3FCzTARldKvBTKG1ACJEQfRNuhM+RJI/mjtqJXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NtzH/WMU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NtzH/WMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759959357;
	bh=ZsloaIwH44GQ5oYieyftPjXtMBTxDBEArG6W9ccPyA4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NtzH/WMUqTZpjm4gziZGIV2wJ1iCdXyp/dYw4RSDy17f8UU5OplBK6oV6Ki98hD8y
	 UTjjJImvNlGzm6wSQZG3cGxz0xyV7JrJDRF7zkuryqUYjApRMYeSKDMZ6qzp0UMugo
	 zUxnvj1SLpwAGstFVR/lXGL/iUT0FSl//APtUdzNQfG7rV864/EWwAMNHcwZYso/Pg
	 Gllr2WkzNN3ztltwWJ2FahPKuDcJWKrLcErEolaEfnx8piYUo2zO4RmAS8EBjgAk5x
	 cJOSu0oKnO25+eRTFPfNVHEL7PFXzlzYBcaqZaOhe5siiQUPBnxSIj3bF32Y4cuXPk
	 OXxpaoIdELqsYLxIm1JxinMUYz8cy8CQ7+hxIhw8Cc+dhk6zOGuF25fgL6UD6PTVyu
	 pR6EVgcXS5ICV6RtUTQH31/m/lXuZTVU9c1tgIjJzhgb4BBwRxWinLeaFRB70ZUGCW
	 H99IG+fbe/aVQ1P5WJSPlYAu4OBtx2FXc3wnWVM8S+sM/o9A5wA
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:225c:7da:a6d4:350c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BA11C2011C;
	Wed,  8 Oct 2025 21:35:57 +0000 (UTC)
Date: Wed, 8 Oct 2025 21:35:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [RCF] Secure git against involuntary arb. code execution without
 feature loss
Message-ID: <aObZPJ3JK-YVI-g7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Lohmann <git@lohmann.sh>, git@vger.kernel.org
References: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opQDTWrgz8rDQOoX"
Content-Disposition: inline
In-Reply-To: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
User-Agent: Mutt/2.2.13 (2024-03-09)


--opQDTWrgz8rDQOoX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-08 at 21:02:03, Michael Lohmann wrote:
> Hello everyone,

Hi,

> Hooks, as well as certain config (e.g. `core.pager`) can do automatic
> code execution for you. In general, this is a great feature and should
> be kept without the user noticing any changes.
>=20
> BUT if you download a random folder which to you unknowingly is a repo
> and either you or e.g. your command line prompt automatically executes a
> simple `git status`, it feels bad if this results in arbitrary code
> execution (ACE), e.g.:
>=20
>  https://www.sonarsource.com/blog/securing-developer-tools-git-integratio=
ns/
>=20
> and
>=20
>  https://github.com/justinsteven/advisories/blob/main/2022_git_buried_bar=
e_repos_and_fsmonitor_various_abuses.md
>=20
> Apart from one core maintainer, all git user I talked to were surprised
> and shocked by how simple an exploit like this was.
>=20
> * Proposed solution (keeping all existing features):
> - On first use, git generates a secret "token" (e.g. a random string in
>   ~/.gitsecret)
> - On calling `git init` or `git clone`, the secret is copied into the
>   new .git directory and serves as proof that this clone was created by
>   this user
> - Before executing any user-defined code, check for the local token:
>   - If present, proceed as usual.
>   - Otherwise abort.

This has all of the downsides of our existing per-Unix user approach and
is also more complicated.  You'll notice that when we changed to the
per-Unix user approach, that broke containers, shared repositories, and
even the detection of whether a directory _is_ a repository, and this
would do the same thing.  It would be even worse for containers because
if you copied a token into the container from the container user, you'd
end up polluting that directory with lots of useless tokens that never
get cleaned up.

It is also easy to bypass, since if we share multiple repositories as
collaborators, as soon as I can read the secret from one of them, I can
then write it into any other location.  It would even be sufficient if
we were users on the same system (such as is common in universities or
some businesses) and I could read the repository.  Many websites even
accidentally expose their `.git` directories, which would not only
expose their repository but also allow attacks against all of the
administrator's repositories.

What would be better to see instead is a config option that restricts
which external commands (via config options or hooks) can be executed
=66rom local config.  Then it would be possible to say, "Never honour
local config to execute code."  With `includeIf`, this can allowlist
certain repositories to do that and leave the rest disabled.

Maybe something like this:

[safe]
  config =3D core.editor
  config =3D core.fsmonitor
  hook =3D pre-receive

If you wanted to implement _that_, I'd be all over it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--opQDTWrgz8rDQOoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaObZOwAKCRB8DEliiIei
gU+OAPwLhivZKKoNiBLdoy+G1xlMHAHlNIZ5cWDQqOwyU0YG/wEA1xQxoVTTmgVR
/Q4C8/8dAalqdGyOJw9TdrtKTZWfqQ0=
=HK3l
-----END PGP SIGNATURE-----

--opQDTWrgz8rDQOoX--
