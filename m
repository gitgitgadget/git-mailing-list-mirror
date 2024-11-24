Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767961CD2C
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732483781; cv=none; b=GeH1VrH+vnsU0DrNGsiLLCecZFuB7Y2OxP1/Cn2/2Jx0zBJqhjMg6FYNnO1WKNeb9RCM4gNgRL62zBfilD0lOsBLmxq9nmtLCTUqHmVbjt3L682ZtzUsSZXg7Gwj1AXlebf5+sIOZpZwb8bszFN7gdcDP0xk+ehzguCntfhBe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732483781; c=relaxed/simple;
	bh=YuxCJkatDeMZsw3nYECtwlAQktm8pyh3GPQUjh/7LeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byfl8G2vDKZJZ3KFgoMasZVqsCfP81fLg2Cj1hwfF9xboR02yXra05itWSig9JZbKCDUM+9H1d9WK+QF7OY00EWcfsNrysk6Kd6Wb+f+a/asE2HvvV9UnwqnhGjCVNQvbkBaaTrRAesBa+n0N0uT0OoImP+fpTe844QJN+fRPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hqZGyMs/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hqZGyMs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732483776;
	bh=YuxCJkatDeMZsw3nYECtwlAQktm8pyh3GPQUjh/7LeM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hqZGyMs/Ma62Jqh7U0n7xjeZ0iFmjtoxH4mxJVvoVqDKq4+L4GzRgfnIYI4ZLh18b
	 FZNkWnj47u+4vGG/c/m/EGlCPA1i4hCE9FMSXSH1UeXMGAdI3qnBZ4FwbwRIwEZM91
	 FQCt6CRdiXYuSnF9akNbSNAlMYbJiM0xna0ukUDeA/B4lQy4W1VUtuszBa+ob/pZVf
	 pVczbq3qvGIbo6irffEX+ycD4UB/EUMnsHofYDevntcHNtKhpJnXB1T2cEvNl5obvh
	 0tk2idwsWlwUPQA7sfNyly/fvuvO+986/6j50ongFCgT9hSvvuNaLExNGO3JZSc2wm
	 X0HjjDH5imQZB7axqkZLOSl9Ewrb/VZw5cVlV0QoSg8yycINhsKKmJyK9TlkCIiajz
	 GHYDzaOmVrXz0NW28xPjlNWuA3P7BTjDmXfmuKjfOG6BhyQBlFpAz4z9xCGJJY9g8m
	 RPYe3+gAegkgcQtYGEDIPN/acG9g3BgiKMH3a/hp3RiiKUjDkH1
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E2E1F20994;
	Sun, 24 Nov 2024 21:29:36 +0000 (UTC)
Date: Sun, 24 Nov 2024 21:29:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jacob Pfundstein <jjpfst@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug with SSH keys loaded into ssh-add
Message-ID: <Z0Oavzr03tTMiKfl@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jacob Pfundstein <jjpfst@gmail.com>, git@vger.kernel.org
References: <CAFmt1jx9OHDnNRdcgB+sPNH90=eZYFRVEbO7PcETiN0ojMQi4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g88oz46H3FtoXsuo"
Content-Disposition: inline
In-Reply-To: <CAFmt1jx9OHDnNRdcgB+sPNH90=eZYFRVEbO7PcETiN0ojMQi4Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--g88oz46H3FtoXsuo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-24 at 16:23:21, Jacob Pfundstein wrote:
> Hello everyone,

Hi,

> I've recently encountered a bug/issue while using Git for Windows. You
> can load a passphrase-secured SSH key into the ssh agent using
> ssh-add. As long as the key is loaded into the ssh agent, you don't
> have to enter the passphrase when using the key. However, when I do
> git pull or something similar, Git still prompts me for the
> passphrase.

This isn't Git prompting you for the passphrase.  Git passes the
terminal through to OpenSSH, which is prompting you for the passphrase.
There's really nothing that Git can do, since it doesn't know what
OpenSSH will do.

I can make a guess about what might be going wrong here so you can try
to see if that fixes things, and if not, you could try contacting the
Git for Windows issue tracker at [0].  Please be sure to search first,
including the closed issues, as the question may already have been asked
and answered.

My guess as to what's going on is that you're using two different
versions of OpenSSH, since there are two with Git for Windows.  One is
shipped with Git for Windows, and one is the one shipped with Windows. I
think MSYS2 may implement sockets in an unusual way, which means that if
the agent is from one version and the `ssh` binary is from another
version, that they may not be able to communicate properly.  In such a
case, OpenSSH would prompt you again since it can't contact the agent.
You could try using both from the same version (I think there's an
install option for that) or try using Git Bash to see if that fixes the
problem (even if that isn't a good solution for you, it's useful to know
=66rom a debugging point of view).

As I said, this is just a guess and I don't use Windows, so you'll have
to try what I mentioned above or open an issue.

[0] https://github.com/git-for-windows/git/issues
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--g88oz46H3FtoXsuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0OavgAKCRB8DEliiIei
gX65AP0TjBbNKvLsfICIC0Bb/mKIXiPgqEd55/gnVHUUPabWgAEA36HaNf3DUFxz
uR0OF1tzmZoIFH10iVQSvwODzR1uuQ0=
=crf2
-----END PGP SIGNATURE-----

--g88oz46H3FtoXsuo--
