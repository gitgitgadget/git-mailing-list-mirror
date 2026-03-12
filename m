Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877E3B3883
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307615; cv=none; b=cfLkY/IMB0jTUEMwF6HSG+FteCig87nigCDaQajWbslgWvkAOKLX429DZW2CXksRaozd1v8ecoyeZEle8NSg6Pk7vMebhbcWlMNgSprDFbU4M+vMF88dKeGYQAWlmUivD/KgPY8frWMN/3HZ4ERNBpf/fyhKyl/doYIUApYVRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307615; c=relaxed/simple;
	bh=VtDjH+eef9f9QHR82mppPqhXSjcURx4oaUcvYZgZTGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBIQ8izlv8Evh0tdRxhiGTBJDZpcMtmcB59co1thLZB09WccEXBD1xZHuu2/bpdep3Tsq2O5QMDSZILXG++FY0qgDAchTEhzUH7paZ6t9Mcn8AVsToiOzcaFZXapnRkcnpo0Vx6mCkBXfayki8r3Ld+jQ5LC2+I0ERCJnrMpK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PSYJH87H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PSYJH87H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773307607;
	bh=VtDjH+eef9f9QHR82mppPqhXSjcURx4oaUcvYZgZTGQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PSYJH87HlAUb00tn/xKMpXeqVK8Zz0X5rud0GBe26u199AcLKN+RrvObUY8hf567b
	 xRsBoSp65uxx8vUMs5G+qxDnr3td2wVZapLz24DYVIG3Xe4QwOKPbQDN/+Txj3ekTF
	 2BKBowlWLdQNAtitEOmJ8TUMpJ2dqpbvGoxsfyMqnGpUZFK84BrVaw8XkkU/su5yFm
	 vCKam+qinnQ17TW0eCvejHlGcvNGLewuG2G26wXj/6pp32R9OuZK1LpSdmxM/RvFVR
	 dzApcbm6NlEPy5GOxGrVM4ySIsB4rgz3epsTS+A/X4MFHIRONvVTmXyR38GMLFVUo8
	 /zwYSVTL6A8EowwiljWKC6NsN0cZpj3KvgcKCmVbwNPBfstr/V15siU1JUHN+CNzOd
	 81s0LXsZYufxadFFSkWKwikGM+t0/F2lVadMuWHLw4CEJjahSfm/5ILEERwhJDXmYs
	 n5SNNVJzi1i5yVn73CyGEBhVyFPz5L6xho/pO//m7Chqj1sJpvp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1cc6:4e25:b9fd:13bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0833E20116;
	Thu, 12 Mar 2026 09:26:47 +0000 (UTC)
Date: Thu, 12 Mar 2026 09:26:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t: allow use of "sed -E"
Message-ID: <abKG1U3fVuNV1w_9@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
References: <xmqq5x72m4lu.fsf@gitster.g>
 <xmqq3425lvtq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Be1zv/t9PKRgnlV4"
Content-Disposition: inline
In-Reply-To: <xmqq3425lvtq.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Be1zv/t9PKRgnlV4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-12 at 00:45:21, Junio C Hamano wrote:
> Since early 2019 with e62e225f (test-lint: only use only sed [-n]
> [-e command] [-f command_file], 2019-01-20), we have been trying to
> limit the options of "sed" we use in our tests to "-e <pattern>",
> "-n", and "-f <file>".
>=20
> Before the commit, we were trying to reject only "-i" (which is one
> of the really-not-portable options), but the commit explicitly
> wanted to reject use of "-E" (use ERE instead of BRE).  The commit
> cites the then-current POSIX.1 (Issue 7, 2018 edition) to show that
> "even recent POSIX does not have it!", but the latest edition (Issue
> 8) documents "-E" as an option to use ERE.
>=20
> But that was 7 years ago, and that is a long time for many things to
> happen.

I think this seems reasonable.  I know this works on both reasonably
new Linux machines and on macOS, and I did some spot checking with the
FreeBSD manual page viewer[0] and it's present in the following:

* at least FreeBSD 9.0 (current is 15.0)
* at least NetBSD 7.0 (current is 10.1)
* at least OpenBSD 6.0 (current is 7.8)
* Ubuntu 18.04

so this appears to be reasonably well supported across major open source
distributions.  The irony is that Linux is most likely the OS holding us
back here, since older versions labeled this `-r` and the newer `-E`
wasn't available in Ubuntu 16.04.  I myself only recently learned about
the fact that `-E` had been officially standardized, since I'd been
using `-r` for a long time.

And, for the record, I agree with you that `-i` is totally non-portable
because it _requires_ an argument on BSD sed and the argument is
optional on GNU sed (and cannot be specified as '').  I have a testsuite
at work where I gave up and just used `perl -i` instead.

> Besides, we have been using "sed -E" without the check in question
> triggering in one of the scripts since 2022, with 461fec41 (bisect
> run: keep some of the post-v2.30.0 output, 2022-11-10).  It was
> hidden because the 'E' was squished with another single letter
> option.

Yes, I think if nobody has complained about it in three years, we should
be fine.

[0] https://man.freebsd.org/cgi/man.cgi
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Be1zv/t9PKRgnlV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabKG1QAKCRB8DEliiIei
geKmAQD4VkI0X9OwJnyD4yIWoyUTxDQlPiXR+qoj6y+e+PvfDAEAmfl3Bp0uyNoo
ndFBO866IvfyKG3uNFhqoUm3156CywU=
=Qtgw
-----END PGP SIGNATURE-----

--Be1zv/t9PKRgnlV4--
