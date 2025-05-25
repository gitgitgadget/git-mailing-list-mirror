Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F72F2D
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204710; cv=none; b=V2PGR5FVsSrLQjgilM0NO5X/8cRjLVq0aUEFDGt6xL8auJnmkZFNYWWbnGWp+8gInPdq9HYUljp6Ua7qcPhMZCjczZVYUUvwkKaan3+xnaP+wCbtSX1d7N++5WcOvrwpTPoT+a8YFKlDufY5hKlAeJaAs9U5z1LnDm0BiY+h6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204710; c=relaxed/simple;
	bh=KHuFH5mKAGaJTUvYg2wL4UMVzcmvO2XpUGdTwwahPm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKg+Ofn21qW07oegRb8zxRSTTB3qlvJSj53EKnc2d5tN4YJAdxwhUDSEMylazbXf+oe++MGlwrD2Mqxx2rjvy5zAKyiPCuPw+DKy8qc7sGnJiZ3zQAHN+sOUYAGp31n89Ws4CFeRkSSNUJJXq4YFwvFJZY5se6rbu3DcjQDxXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N3qz3Efu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N3qz3Efu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748204700;
	bh=KHuFH5mKAGaJTUvYg2wL4UMVzcmvO2XpUGdTwwahPm8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=N3qz3EfunqCb1MXvCGB+lXFPiF7fmRUAz0cIvZyfO+lykxmrZECmD3Cdv4lv70EMf
	 UXP4kCtjDIZwlfPAk1W4MXZo906ZjVfp81jJ6VBWqvBqzBCOT8EulsDm5LKRFFoMZx
	 PkEb/I9pxpjEy+2/ouXpH4IJRimt3t2NoPgm1TpqjMCfO09nKkD3zqkpPhB+A7es8h
	 FdKIMnncT6K6asAb6IY4pTR5ZQZq7QjtrVTvATWugXtI12nLIatW4XuvoZH1mJz0Dm
	 ljH4nuWtnfeD3t/keWTi5bezEsH9mNcBENmDa0lv6Q61LhcodAhlGkbe1CgU1hnEm3
	 N7pPczjpvL5lIDGl/06L/8YsOF3QSUW5Fce7Wn4mGVbxduf7a92JFTUGHYbKHIoPXw
	 uHnOX2sv078iMC4IyUXRtCkaGFLQl9sVBANTflSZ6THwj99ydz8nwh1NOp9JA2zLIb
	 OjtJisEfYyTSU4ZMTXopyULA81k1q6qv2EuHKMDWrQeJbGX5ANd
Received: from tapette.crustytoothpaste.net (syn-071-015-116-126.biz.spectrum.com [71.15.116.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9786D20038;
	Sun, 25 May 2025 20:24:59 +0000 (UTC)
Date: Sun, 25 May 2025 20:24:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>, Zi Yao <ziyao@disroot.org>,
	Rens Oliemans <hallo@rensoliemans.nl>,
	Drew DeVault <drew@ddevault.org>
Subject: Re: [PATCH RFC] send-mail: add support for Microsoft Graph API
Message-ID: <aDN8mYEJS0ARD1d7@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>, Zi Yao <ziyao@disroot.org>,
	Rens Oliemans <hallo@rensoliemans.nl>,
	Drew DeVault <drew@ddevault.org>
References: <20250525110621.64308-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x1wGDOfXS8OWuhg4"
Content-Disposition: inline
In-Reply-To: <20250525110621.64308-1-gargaditya08@live.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--x1wGDOfXS8OWuhg4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-25 at 11:06:32, Aditya Garg wrote:
> Apart from SMTP, Microsoft also provides a REST API, branded as
> Microsoft Graph for sending mails. Upon testing a bit, I have
> found a few benefits over SMTP. Firstly, SMTP servers of Microsoft
> are kinda slow. On an average, initialising the SMTP server even
> on a fast internet connection takes around 8-10 seconds with
> send-email. Once initialised, subsequent messages sometimes also
> face delays, taking around 3-5 seconds per message, and other
> times they are sent almost instantaneously. Secondly, their SMTP
> server does not respect the Message-ID specified by the user and
> replaces it with their own generated string.
>=20
> Microsoft Graph API solves both these problems. It is extremely
> fast, taking around 1 second to send a series of 5 patches, and
> also respects the Message-ID specified by the user.

I don't think we should be adding support for proprietary methods of
sending mail.  There are two standard methods, which are SMTP and the
sendmail binary, that are well known, well understood, and widely
deployed.

It is well known that Microsoft has invented a lot of proprietary
Outlook-specific formats for messages, such as TNEF and MAPI, which we
should also not support because they are poorly defined and not
specified in an open standard.  I would also be opposed to sending mail
in formats or using methods that are proprietary to Google, Amazon, or
any other provider, since we already have clear specifications on how
mail is to be sent that precede this project's existence by some time.

I understand that the Outlook servers may be slow and inefficient as
well as modify the Message-ID, but that's ultimately a problem you need
to address with them and get them to fix.  I should note that I don't
have that problem: I run my own Postfix and Dovecot servers which are
very speedy, and I feel confident any other provider could do so as
well.  I also have never had that problem sending mail through Google's
SMTP server at work.

If this REST API approach is well defined by an RFC or some other open
specification process that the public can participate in and deployed
among a large number of providers, including several open source
implementations, then we might consider adopting it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--x1wGDOfXS8OWuhg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgzfJgJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZx4Qu2MDrcEYPm5B6u7V0wg8C6+iF7IbQnVAlN8GPyLX
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHBzAP4gUpvLNM7LieZ0tnAPsJ8RvAee
f3hnAhDPrJEr+/qJeAEAoSW9hZHDH3rf7b7oUJKQ8+RJpmdq82F+LAg0MxM/MQo=
=XVgM
-----END PGP SIGNATURE-----

--x1wGDOfXS8OWuhg4--
