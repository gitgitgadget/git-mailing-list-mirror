Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84391388
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143587; cv=none; b=h9/iQQS3avVa1j3gUS1Fm0XKHIXnS5YRuRtfjD3j2+3vtBqSODZ2sHCeQOyP4RE5cadSBYuWVlIZkolBqOBPDI/mkbzoC7PHe41oZZ3aDK/GDRplwSfpiwiS5QrGN7UMWnQ/NJgGhPeKFo1EjucqMZKafaMjkPdFno5A+h6BTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143587; c=relaxed/simple;
	bh=P4htjwb3X/ecUKG8P5HdTcrh4Zv+flBCVtDmNLEQshg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEAkxovcMFfpUXTuHJNvslFKpB3eAZ+HLyZl5c8rageTarK0nk5uIki0Fioprnf0lz6VvWRaHxm2FzRIAJrguQjMjRkt+6Eg3fV0uZawWJiAIu0S2G24P68x00Os3M5+u9VCzYAZT0f7llz3uk1uDX79XFl0KX6SdwgvObbTvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fDf4CxSE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fDf4CxSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1753143583;
	bh=P4htjwb3X/ecUKG8P5HdTcrh4Zv+flBCVtDmNLEQshg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fDf4CxSE8reHMhKbGGS2NGirfvyyB5Pxz1ZSWSaX5oBaEC3SZ0+ba2VUzQhM+GeU+
	 8aLmTcM04ohX8jXhAf2yD1qntKl9zlLGtl9GFPYqff1m3nnnX610IYQZ5maZMfwlgc
	 7K9BOrXhVQ0NwWSnkCVMKHpIb9j9J1IBzPx/oYVrqEZ2ZmBnvLBuvrcSWHU0ZwC62k
	 IO3NhPKlY0aceSovgAnTfXgzoO0nuif0LQVg3njrGfFXlNmzSEcrvNr1dvxLV0fCu9
	 7wadaXYSVzC6ZQvR9r17tZWQ6xL8b3mdSTg+NAXB5cCRCmTJtYAWrLH0QJk+8I6Er6
	 NFaglIVo1AC1+PJ7x+isLdJixoqupzw8Uc0KGR7I359SI5g5ed2Eit/6IFFKibBV99
	 sJ2Ctnqc9JIzFjcW5v6oH0KOwr3RNsi6nJbmr01F8rhYq31IUosVJRSgrxgipgWiIV
	 i4xoxUT4G8z7mpSMFCjwo8UukuPW/Ud7WVojwi040hxXi8LB/q1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:2eaf:a208:a152:a406])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 62ACF20079;
	Tue, 22 Jul 2025 00:19:43 +0000 (UTC)
Date: Tue, 22 Jul 2025 00:19:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aditya Garg <gargaditya08@live.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
Message-ID: <aH7ZHlA4CtIBHSgX@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
 <xmqqpldtxsp7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y4eBgAYQxhXDvGoi"
Content-Disposition: inline
In-Reply-To: <xmqqpldtxsp7.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Y4eBgAYQxhXDvGoi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-21 at 19:13:56, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
>=20
> > +sendemail.imapfolder::
>=20
> Do we expect that the use of IMAP in git-send-email will be limited
> forever to store outgoing e-mails to the Sent folder?  I highly
> doubt it.  For example, would it be plausible that given send-email
> has so much richer feature set compared to imap-send, it would not
> be implausible for users of imap-send that want to stuff messages,
> with Cc's, threading, etc., all prepared by send-email, to their
> outgoing folder.
>=20
> And when somebody wants to add such a feature to "git send-email",
> how would they find this variable that uses imap-send for quite a
> different purpose squatting on its name?
>=20
> Same comment for the --imap-folder command line option and the
> internal variable(s) used to implement this feature.
>=20
> These things should be named with words like "sent", "fcc", etc., to
> clarify the use case this new feature is trying to support.

I think this is a good idea.  We should be thoughtful about our option
names here.

> As imap-send is not part of my daily workflow, I have no strong
> opinions for or against the proposed feature, and I didn't find
> anything glaringly wrong in the implementation, other than the poor
> naming that would block possible future enhancements.

I would also like to advocate in favour of the feature in general.  I
run my own mail server and there is no magical functionality to add my
outgoing emails to the Sent folder, so I can definitely see the utility
of this functionality.  I'm sure there are also other, larger mail
providers for which this would be useful as well.  (I suspect the patch
author is on one of them, in fact.)
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Y4eBgAYQxhXDvGoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaH7ZHQAKCRB8DEliiIei
gc/yAQDlKB816ldkC0FxjxxI+VE0gBJIO5drPigq3JpUkyONVwEAuLs/QRbjG/VU
x7a7M5VEifKMb49uJR8Ldb1AiuLh9gg=
=GAht
-----END PGP SIGNATURE-----

--Y4eBgAYQxhXDvGoi--
