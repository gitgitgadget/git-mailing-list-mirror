Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9411F4615
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831849; cv=none; b=IvNzxo0t7HRKqZz8zNSqG255ZCQZpZArf12lmhSzEsUgkbSZMC2FOqDAzPj/KqwsJufhkXRaN5hMVhnFisBWOILu8Gz/F0UBgy/cndrdwDreSuuSrNKCF3OQHiiZlSY6SpCFgWbf9mWFbIWh/4Tdtd2uXYO4Thu9FgRIcWye5NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831849; c=relaxed/simple;
	bh=DaDul8fj5cQwUUXsia8LcKBPOoxILm/WdTR60A9rI+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIH/JmoFZrTmsxdkNOiRl54WF4MHvfdVC62MqTtfmhQs7NKUmsv41+KmwQLSqhWsmaAwv/W2B5AE5z1kbhcCypdObeQ/TSs4PUiqOc90xIA/3kDJ4SpZOkmCOGIYRI8z7gA4kBRMkc7zfXhV4HB9y/AKajybh2298xo5fDXfAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=D/Oio+ON; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="D/Oio+ON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772831846;
	bh=DaDul8fj5cQwUUXsia8LcKBPOoxILm/WdTR60A9rI+k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=D/Oio+ONnmDIFIJOkU3yKmF/NvRWExwkb8DAZfCU7LJQKCsn4vPv7Dsaxj2EL82GB
	 fRW82HGDOanF5XTbixACdprwEwnLBDOYODYuLrzJihLW+g6ldyjo7R1TXtLqEDKtuw
	 6C6FmQi5AF7esFmisU9DC9Y0jgm3FGSiuE2DoNDAmj8HZ/i4D1RGDSihx4E3UgTN8o
	 mW1TZDdNRSKaCS+CY9PStRbSwrhCO6s5qQH0ex11j2AifUjIEJEvzTv33wJ1lsxjdq
	 YM0iAjE8i7DtYVFR3aTdHcIm7BFd/8B2l+WZeU9eHCAgiHJ7VFNNNNHBeaGXJkvsM7
	 gHYV5OBNOZXAlbPpSV4SjvaSu39fFhY21TeD1kD8WUf1+pWt7ClGTJvqMfqZWPXF0P
	 QN5H+/tUkiAoxrfk89w0b752/J7OmY9LBag4KzllyAboTQOTTFvj8+1GMoYS5d9zJy
	 bjgSoQXubjckNu9RvcYgMN5AI3gfumDeQM/X9T3Vt+Htaw9GxRr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BA0B020112;
	Fri,  6 Mar 2026 21:17:26 +0000 (UTC)
Date: Fri, 6 Mar 2026 21:17:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ivan Ivanov <qmastery16@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
Message-ID: <aatEZfGPkZTVT4uJ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ivan Ivanov <qmastery16@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
 <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net>
 <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
 <20260306043821.GA3465674@coredump.intra.peff.net>
 <CAAaskFD7wmtqppatb5T5GMTviieR0Ttk9y4+c3khuF3bZBfE=g@mail.gmail.com>
 <20260306160131.GA3577004@coredump.intra.peff.net>
 <CAAaskFBNBEiPW4tLRtPQqkntHFpDTgjwrx8Lqg-qax1Cb_mEhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WiEH5bQJAZXx/AwL"
Content-Disposition: inline
In-Reply-To: <CAAaskFBNBEiPW4tLRtPQqkntHFpDTgjwrx8Lqg-qax1Cb_mEhQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--WiEH5bQJAZXx/AwL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-06 at 17:36:35, Ivan Ivanov wrote:
> Sounds reasonable, but - if there is only an issue with askpass and
> everything else is fine, couldn't we just execute askpass from its
> origin - instead of copying it to the destination ./git-test/
> directory?

We actually do generate and run quite a few scripts in the testsuite
(`git grep write_script`).  All of these will be generated in the trash
directory we create for each test and some of them contain dynamic
components that cannot be generated before the testsuite is run.

It may be, for whatever reason, that only those tests happen to
malfunction in this case, but we're not willing to do the testing and
maintenance required to guarantee that the testsuite works in a noexec
environment.  There are some cases where we accept patches to deal with
uncommon cases (for instance, I send in patches to fix the testsuite
with zsh in sh mode from time to time), but I think this is a case where
we fully expect things to be very broken (at least I do) and the amount
of effort required to fix it would be substantial.

I am sympathetic to the downsides of noexec temporary directories
because I've worked on systems where `/tmp` was noexec, but we assume
that most people on Unix systems have at least a home directory where
they can execute things (if for no other reason than the customary
`~/bin` directory).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--WiEH5bQJAZXx/AwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaatEZAAKCRB8DEliiIei
gXQmAQDsRHNSK2G5FCoCagBTkVsEFEnp+26pHw5egInYEVt60AEAhq/eVwqtdUi8
E7bvguDEp3Ns+amO6ShQ2lLMuVVb/wM=
=Tp9s
-----END PGP SIGNATURE-----

--WiEH5bQJAZXx/AwL--
