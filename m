Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB074243956
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760222; cv=none; b=CWo4nbH3WJCI+MJ71elIlPLRl2/MjzN3VUqug6GQh1wMtXn0cwfBCtyzXBPBLzGVJFPfmWTY1eVa9zLS7qiI0kC5O7qwif+yewdgBiUl9Ld7aoRWiUIdPhTOZuNAnM1ppIHkCvr1X2D/DenXZoUz73xD+KFVLEgm1vjixhqVq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760222; c=relaxed/simple;
	bh=IU2QNWIBULaR9N/efo9MSFMB7u7o1z3MBw5Wo4h3n4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyicdzR97qBXj/NA7DPpEpASlD/Z+mljoayRG+De+aM6TipUIn8+Ofd50oJBtCIueTB75Crlrwhez+hxoBX3hhQnlGPkwvEtOEtqFRosBUFGiYeeP3bAqyVh7VWwoGScvzuVyIxZ7yADWRxCTDrAirQJY4gigam6SZYGqAziUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dLf0+I9d; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dLf0+I9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772760219;
	bh=IU2QNWIBULaR9N/efo9MSFMB7u7o1z3MBw5Wo4h3n4k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dLf0+I9d8SwtnnrkgqU/5OhhzWcHK/oCCLi0o0+VOmpZl1srdjPhd5/RtMVw8Jyqc
	 YTtdlwqX4gROyLLBYmC1Bxjq8q3sZYlV+ZApT2IibYJr7lAzbdtHcwyi7cfZXU9f20
	 OM4Wea9kofUne/VpxqgAObH+VDU+706CrryI4OD+1fqjvH7vBynnodCCF/KiVQU8Kv
	 pBukgnl4lXt4p9N3WtvIkIlayzzVFEjjeSUjmC+QvcxxtmQhyGBmlqkxgFf1mTwu7B
	 w1cj9rz1ILpYyYB3cDcUODt9OxVSx7/xnFc3R3Ofun0V4VaW5oDeKOYM7iAFlxyDS6
	 OlNYF41ORDglRBJ8WwwiVKKu8TkZwWc9F85u21wy7949xThiqF3oOyxQ5LNgnL/ZSt
	 s9pamlN/7iKsGiBjjcbz9Gzkl2CSWqSVcOU5TxCaU4VKqjPs+cXe5Wz2WuV32X2uBe
	 3BCf7CUTaWvbAb0HuCKJaOZSgs7JWhu8vMRJSlf4reFRF6LnrCT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C99662006D;
	Fri,  6 Mar 2026 01:23:39 +0000 (UTC)
Date: Fri, 6 Mar 2026 01:23:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ivan Ivanov <qmastery16@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
Message-ID: <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ivan Ivanov <qmastery16@gmail.com>, git@vger.kernel.org
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7fGUmF1gbY1b8iGu"
Content-Disposition: inline
In-Reply-To: <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7fGUmF1gbY1b8iGu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-06 at 01:05:58, Ivan Ivanov wrote:
> To clarify, in addition to t0300-credentials.out ,
> t0301-credential-cache.out and t0302-credential-store.out are also
> failing, however a similar-by-nature t0303-credential-external.out
> succeeds fine. Very strange. Seeing how it's leaking to the primary
> console, I suspect something may be wrong with shell handling: i.e.
> for t0302-credential-store test I am seeing these prompts that are
> waiting input for a user (could write any message here or just press
> Enter to get a new prompt) :
>=20
> Username for 'https://example.com':
> Password for 'https://%20@example.com':
> Username for 'http://example.com':
> Password for 'http://example.com':
> Username for 'https://other.tld':
> Password for 'https://other.tld':
> Password for 'https://other@example.com':
> Username for 'http://path.tld/bar.git':
> Password for 'http://path.tld/bar.git':
> Password for 'https://user-overwrite@example.com':
> Username for 'https://example.com':
> Password for 'https://example.com':
> Password for 'https://user1@example.com':
> Username for 'https://example.com':

To help us understand more, can you provide the output of `git version
--build-options` on the affected version, as well as the shell you're
using (bash, dash, etc. and version) and any configuration options
you're using to build?

Using Debian unstable with Debian's dash 0.5.12-12 as `/bin/sh`, I don't
see this problem when running with the following command in zsh:

    time make -j12 all && (cd t && ulimit -c unlimited && GIT_PROVE_OPTS=3D=
-j12 GIT_TEST_DEFAULT_HASH=3Dsha256 ./t0300*.sh --verbose --debug)

Note that Git should not prompt on the command line because of the
following code in `t/lib-credential.sh`:

    write_script askpass <<\EOF
    echo >&2 askpass: $*
    what=3D$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
    echo "askpass-$what"
    EOF
    GIT_ASKPASS=3D"$PWD/askpass"
    export GIT_ASKPASS
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--7fGUmF1gbY1b8iGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaaosmgAKCRB8DEliiIei
geCwAQCuKo2eZDKIQ5YeSvy+ihh+udUwZQydgoW2LHKFJe6Y0gD+Pl+D/NkT6Jgg
r7I6NHEuTn+KMxAfzKjFnCnnJIHmywY=
=BkU5
-----END PGP SIGNATURE-----

--7fGUmF1gbY1b8iGu--
