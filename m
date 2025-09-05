Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF2248176
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102177; cv=none; b=ce/sQHU7NNXTglVt8kDCgbFwF842f5tPPDLTDeOawXUpC4VYOW1XQj6PXA+3Xi3bp8DdTRG/grxepMaVvrCBhWbeM9U8iVVSr5BWv5QKJ3Gb7IeNT4hZAo6vzoNinroFMUigQu8dVDuc4NP5hLz2urDit1CjE/2574AB+vAj8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102177; c=relaxed/simple;
	bh=vPC3eAzZYQv4bDUaoT6ok+PXcXazXmlxpuGtOcgTbNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYeYKuWzM/QGzYCO8I02wEWQwDCOzJVLwYXWg3gZBMuz5V3H3BjZU9tyIHcrSLN4tofGlku7A4mkHsIs6OWZux9DJ26NspqvcxMqESqsCHeWFbPdUjiBDEFoStH3T+74fYDboMItvp/yDPNuOD9EJO7b6SdNjrTVDo6Llvr7BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jPzM6wbW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jPzM6wbW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757102174;
	bh=vPC3eAzZYQv4bDUaoT6ok+PXcXazXmlxpuGtOcgTbNc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jPzM6wbWfIqo1F0BU2CNI0Ru2UaCqH8tBM63ojqKgRbYwl2eX4shUEW3RUppI63SZ
	 y71IgBn7NarSdDBDotbKtF+7W1EecSfcefFc9KB9HvIa1jt6/4Db1h9V4LJdaG+s2S
	 Bhcrwbn0SCw5c2qLKUAIafDRg+xXmB+iPOq4Y281GCao2xl9TpO7+GzwFusyxCabVA
	 MfCNe+SOEVG2gqOV16doIiWgvvaGpIk2yzYX0I+FyEkKRFOjifW5ooWx5i4Xtelgn0
	 lPgy5CF9WK+Ka0kOE2vhgpIzTX+udRDdJET2RPJFTw7rNOmfXig6x2fKFg20/AbzC3
	 iUCcXILcYYBthFkw0K095woVo01yx1X6nJGAnBBrApyxAqelacFrJstWYgut9vbjpw
	 Z5uqJf1GblzvOeRNeJumuBOD3rlZaV8HQzJBS0K4EdjcyCE7YXSzvafL7FfSHrDx7y
	 Si8kcT6+QdFwTYhD4SHg3NfeQjJy/Le5YbZWNVJqTmV1XydOTIW
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8f0:4bbe:8989:f575])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3739D20100;
	Fri,  5 Sep 2025 19:56:14 +0000 (UTC)
Date: Fri, 5 Sep 2025 19:56:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 7/7] ci: enable Rust for breaking-changes jobs
Message-ID: <aLtAXYUQ1GRRL6xg@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcWlYFuagkjWK6uU"
Content-Disposition: inline
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gcWlYFuagkjWK6uU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-05 at 11:51:03, Patrick Steinhardt wrote:
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 4eaf3514d6..4c58c7238e 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -31,7 +31,7 @@ alpine-*)
>  	;;
>  fedora-*|almalinux-*)
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils =
diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel cu=
rl-devel pcre2-devel >/dev/null
> +	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils =
diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel cu=
rl-devel pcre2-devel rustc >/dev/null

I know nothing about how Fedora packages Rust.  Do we need a cargo
package here as well, is that automatically included, or is it
unnecessary?

>  ubuntu-*|i386/ubuntu-*|debian-*)
>  	# Required so that apt doesn't wait for user input on certain packages.
> @@ -58,7 +58,7 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jr=
e \
>  		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-pe=
rl \
>  		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-s=
sl-perl libdbd-sqlite3-perl libcgi-pm-perl \
> -		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
> +		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
>  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE

Seems reasonable.  That will definitely pull in rustc as well.

>  	case "$distro" in
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 3680446649..c718bd101a 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -9,7 +9,9 @@ case "$jobname" in
>  fedora-breaking-changes-musl|linux-breaking-changes)
>  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  	export WITH_BREAKING_CHANGES=3DYesPlease
> +	export WITH_RUST=3DYesPlease
>  	MESONFLAGS=3D"$MESONFLAGS -Dbreaking_changes=3Dtrue"
> +	MESONFLAGS=3D"$MESONFLAGS -Drust=3Denabled"

Looks good.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gcWlYFuagkjWK6uU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLtAXQAKCRB8DEliiIei
gaq7APoDONF/qNrGNpFDsusLj7ccsJJZHOWwTWPCUpSd7LvJDAEAgbBgzLn/2+UV
lbl97ZZhOsm8q8rDLDiE00gYdwji9Qs=
=4VTI
-----END PGP SIGNATURE-----

--gcWlYFuagkjWK6uU--
