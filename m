Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AF4C7D
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192520; cv=none; b=knI660KgAh1twuAtdd6BGmoI6yBVKmj+6CZ70OlrHmpq1DEyy/1TgSyZkUdxbziWU6CbdMaBpWpZdIlMywxYXtG6KXjO7KGcDSCsNLDaZiAoaMIcfaTTCDa/+Qyg2G2yVfu5iQ4o9kfMxHyTcrkJ9oINbQ0xMraLbAIC08BXib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192520; c=relaxed/simple;
	bh=axNbn4lsb6rg/ZvWkJJfVgaX3GtLjKvSda52Sk9grZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCQlsmzJCut2gNKTR+KRpCt0b+H56u4euedKF1gzK9+xOpSiF1RHIi9GC+NDgAIC71wGNpaR4E7ooEqgPNjHwWEsuHbnxF+zjMBAbCNiVoGaofk4NVkVqoUKtnK499tVupAW8873NPP224ReTEF97ix7O8LxIeZcd9/Jv+MwhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YHtELwmY; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YHtELwmY"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5C0DE5D4B8;
	Thu,  4 Apr 2024 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712192517;
	bh=axNbn4lsb6rg/ZvWkJJfVgaX3GtLjKvSda52Sk9grZo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YHtELwmY5gNi7umwi6KghZFH36MBd/NcNcdXqqdoTUeH3kqJovTCNCuHNKdvbwQ3/
	 S++xL+rLa9q5VMNk60uqg2QhS339GYcFycyB0d5RssfFGPEXnH6oOS/dDMS9vR0/cU
	 L5Emz7mltNdpEqf/IAdfQfoz23aBDuAECmV8xAaViKD1eAswlPPpZMjP0kcvB9ibrp
	 AT7050DDqTy+xFqClX49FR+1KB20t6wmZ0RTsm5SQbAIQRHuf3of+rln6cphi6nXJY
	 G4ektL9nqS+iu+78zqDUw1Jsr9Y5JPLJiQOBMGy0WdUJ8vlzDTjEA7WaUHwtnfOrtr
	 UmQvxvIqos1gpMZYhAnipOjzzDKldla41IM/BBOb9oRgfYQCgd+nNCkE+ilrcmErxJ
	 ktzL9rg1GvtnhqoOOKiDmUz4t80IlyVScgICCpfeURx9ew9iW2nG54jnnEZG7+KP1D
	 4mhBTTikvH1OGRyLJCK83E/2SJbftgpJ07tsJm4Pd1I5Vxju51d
Date: Thu, 4 Apr 2024 01:01:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jackson Toeniskoetter <jackdt@google.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
Message-ID: <Zg38BLxLe193zYss@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jackson Toeniskoetter <jackdt@google.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240402222619.2212650-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MST/jF20iIf0Yd52"
Content-Disposition: inline
In-Reply-To: <20240402222619.2212650-1-calvinwan@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--MST/jF20iIf0Yd52
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-02 at 22:26:19, Calvin Wan wrote:
> Hi Brian,
>=20
> While I personally do not know the specifics of how Git authentication
> works at Google, I am passing this series along to the team that does
> own Git authentication (adding Jackson to this reply).
>=20
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > Right now, HTTP authentication in Git is mostly limited to approaches
> > that require a username and password or are Kerberos (GSSAPI).  In
> > addition, we effectively require that libcurl (or, for other software,
> > such as Git LFS, using the credential helper, that HTTP library) knows
> > how to implement the authentication scheme.
> >=20
> > However, this poses two sets of problems.  First, some sites, such as
> > Azure DevOps, want to use Bearer authentication, which we don't support.
> > This is implemented using `http.extraHeader`, which is not a secure way
> > to store credentials, since our credential helper protocol does not
> > support this functionality.
>=20
> My first thought was if using `http.extraHeader` is insecure as you
> claim and we use that internally, then how do we ensure that it is
> secure? Or are you claiming that using `http.extraHeader` out of the box
> without an additional security layer is insecure?

Storing plaintext credentials on disk is just not a good idea, and it's
not a secure way to store them.  This is why `.netrc` is a less than
great idea, but for Git, it's also possible to have a shared repository
where information in `.git/config` can leak, and sometimes people also
just expose Git repositories accidentally over HTTP (say, on websites)
and leak all of their config.  Sometimes people put `http.extraheader`
in `~/.gitconfig` and then check it into their public dotfiles, and then
push it to GitHub, for example.

It's a little less of a problem if it's a personal laptop and nobody
else uses it, but it's still a lot easier to accidentally expose an
arbitrary file or for an attack to exfiltrate an existing file (just
through a bug in existing software) than it is to necessarily execute
the arbitrary code necessary to read the data out of the system
credential store.

`http.extraheader` for Authorization headers usually necessitates that
the data is either stored in the config file or passed on the command
line, and that's why it's insecure.  Certainly, you could configure it
to read only from the environment using `--config-env` or you could
configure your system to store the data in the config only with a
single, highly restricted service account and it might be okay.

The kind of usage of `http.extraheader` that's likely to be fine is just
passing an extra header that some broken proxy needs to be satisfied,
like setting a specific language or faking a header that the proxy needs
to think Git's a web browser (since, of course, if it's not Internet
Explorer, it's insecure).  As long as you're not storing credentials or
secrets in `http.extraheader`, I have no objections.

I don't know what you're using it for at Google, but of course if it is
Authorization headers, then I'm hoping this series will help you avoid
needing to do that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--MST/jF20iIf0Yd52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZg38AwAKCRB8DEliiIei
gS9jAP9GGEzO48vVpKojsNKrk6Nm47tlNV9r6zjG3t2o0mHBGgEAtSQDMeOleuX2
poYzb+xgDvA5EWsoqBoLuQbc/QN+kgU=
=jg3L
-----END PGP SIGNATURE-----

--MST/jF20iIf0Yd52--
