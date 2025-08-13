Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC327FD46
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121804; cv=none; b=PND5zWidhQLqIcdqzE5YFO6GQhc3PVNLvZ3E8Zzxt22A58zbUsmBjzfeHIgQ4TDqgWhgul3Xus5DCT2Egfq5R4SEb/oY0vBpKSCu2wJy7RkTQsviV5BSJjqZkvpkK8TtQyAB9G7VpWYmke2lwIWhaSfDxy0gOEr0SlveoXPo7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121804; c=relaxed/simple;
	bh=Wv0OHR3cCIjmQgSB19rT/9zAXVktG2IHriH1wGsV7YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc/JDr7632S8VzGMJm7tubi3qsStZ4RDbV46vJlVN6MyRY8VLDBR17pIjOunujsqXRcuvjOSpKbXW6hqD0l/nXEwc5VyZwN4FWMHpdKstm9CDXGz12HX2rV16+OKxQez8FqKKMSGBykCkHBmfAKeuSOL+dGfC0urDPSBVcLqF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bnaq/itQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bnaq/itQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755121793;
	bh=Wv0OHR3cCIjmQgSB19rT/9zAXVktG2IHriH1wGsV7YU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bnaq/itQ3F3x+452287spU/Wto9RtvkY6NtgHbrjuTF5SAQqWvr+c/VEYTbRRnsc2
	 HD3yPewtxjXJSQkDqEVFQofPKGyD9z8kHa2clK3LNUoU06UZjD23/1WB8F58/rRky9
	 A960/BhOVXa5YkG6gVOWrjpI7jnAiy0+9VmO0Wvi7XDLuf6u/+b5QmxkgqlUxc59Cm
	 yo9aQwQSJiMf3he+7y+bB1m3qHFHUJbWgVuE4JiSeAX12SDnwEdQyk9bw+ezTFvHeS
	 FhRp4L9vcMXQYnWo1CfTL5Rw3WinHLOOCD6pU+nM7bazPU1C+sYeMvKiIUrg3RfaOj
	 t2fGc/YG+YRIz0EIjCjLwuJ04QZVYU7YvCEgbe2Jdz+7zEUCPyCQuds16w5AqtcnRN
	 pdA2Z8YCrpvk4M4Hczx55XSXdpoZ0iIRkzC9M7UJRjlFE3PVaIinRlPwi4ha7MUYgk
	 5vSJi+86xPIxfIPI4c2DKiuRuCO2L6util0OTvtnnA0sZiwTVZZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:dcf7:b1e8:faac:b3aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C42A6200B4;
	Wed, 13 Aug 2025 21:49:53 +0000 (UTC)
Date: Wed, 13 Aug 2025 21:49:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ryan Johnson <rj.amdphreak@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Implement feature to link/include other gitignore files in
 gitignore
Message-ID: <aJ0IgPBaJrOMr1q6@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ryan Johnson <rj.amdphreak@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <LV8P220MB2017EA88974F2311DCFB7665F52AA@LV8P220MB2017.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ERJHIV6XdykSI9tZ"
Content-Disposition: inline
In-Reply-To: <LV8P220MB2017EA88974F2311DCFB7665F52AA@LV8P220MB2017.NAMP220.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ERJHIV6XdykSI9tZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-13 at 21:09:50, Ryan Johnson wrote:
> Feature request:
>=20
> Let .gitignore file link/include other gitignore files:
>=20
> ```
> include .gitignore.python
> ```
>=20
> Why would this help?
> https://github.com/github/gitignore/blob/main/Python.gitignore Look at
> how long that Python gitignore is. If I am developing a project with
> multiple languages, imagine how long and how many duplicates will show
> up when I copy templates from these other languages:
> https://github.com/github/gitignore=C2=A0. Now imagine a team of people
> adding new gitignore patterns. They will inevitably add them somewhere
> I don't want, like in the middle of templates. I don't want people
> editing the templates, because it's too difficult to see their changes
> vs the template. I want the templates to be linked so that we can tell
> people to copy updated gitignore templates, without having to analyze
> the file for lines that are custom-made.
>=20
> Respectfully, consider adding this easy effective idea.

I don't have a strong opinion on this idea, but let me provide some
context on why it may not have been implemented yet.

First, doing that is an incompatible change.  The include directive you
specified matches the file "include .gitignore.python", which is a valid
filename on Unix.  Even if you think that is a bizarre thing to name a
file and that we can break that case, I assure you that people name
their files in many bizarre and nonsensical ways and do many strange
things and we still try not to break them wantonly.

Second, lots of things read the `.gitignore` file and will have to be
updated with the new syntax: other implementations, like libgit2;
software that uses them, like Rust's Cargo; tools like rsync, which
parse these values to decide what should be transferred and what should
not; tools in the Git ecosystem like Git LFS; and so on.

Third, most projects do not use giant templates like the one you linked
as they stand.  It is unlikely that most Python projects use all of the
tools in that gitignore file, so most projects can deal with a much
smaller subset of that file.  Newer languages, like Rust, put all of
the generated files in a small number of directories so that they can
be easily ignored.  Most of the projects I've dealt with only ignore
those specific patterns that are necessary to exclude build products
=66rom being checked in, so they tend to be relatively small.

For instance, Git, which has the style of building everything in the
root of the repository, has only 256 lines.  Many build systems place
everything in one directory, so ignoring things (and cleaning up with
`make clean` or the like) becomes easy. libgit2 does this and has only 8
lines of gitignore, 6 of which are editor or OS cruft that people should
be putting in their own personal `$XDG_CONFIG_HOME/git/ignore` files and
not in the project's gitignore.

So I don't doubt that this feature could in fact be useful for quite a
few people and I certainly wouldn't be opposed to seeing an
implementation of some variant of it, but in general, most projects
structure their code in such a way that it ends up not being a feature
they need.  I do, however, disagree that it is "easy".
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ERJHIV6XdykSI9tZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJ0IfwAKCRB8DEliiIei
gccCAP4t68f/HwmM98S1b1FJhkkQnSDr59Wll1RtvOtl7vkxyAEAmHDxM2gYaIUf
xDAHYoggDp91VQwACS/rIDPIWT8xTQA=
=7aTe
-----END PGP SIGNATURE-----

--ERJHIV6XdykSI9tZ--
