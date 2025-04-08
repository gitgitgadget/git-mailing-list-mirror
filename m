Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050C1B414A
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744075368; cv=none; b=SUjmdwb1xLeS5ui6NCDPK1q/DESv0suUmQdYGWmZu0S98ahXy3to6o2vB9nkxacYJQ00VSZlqgRIu4pyaMiXlHPxYmyUZj8bZ3UtTyEHHSKmDtA7fsYmd13MIFYTxhbT7b1ywSAmKrfQqSHKn/Di17OSghk2V3Tzj9U9kp1vU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744075368; c=relaxed/simple;
	bh=bA4h4awsCC58mIcps+9s6QgkmF/L/9MEbB9ZilB44aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEqvHAFrKbGK+PnwOXRV6a/F8rJ/2m5T0ek9h2IGsPzWsdNFCtz9HCLTgjzyvzSvMKjfSI1ZvgGeB9hqIu8aHGIRQs+XX5fNFcrisdhDBFjOz0T0vADKZ3b/9/ahkB2KLh2J4d1imyIdaPE76GAeYpn74EwtI8nlEIchf82gzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YKTkRwX6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YKTkRwX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744075356;
	bh=bA4h4awsCC58mIcps+9s6QgkmF/L/9MEbB9ZilB44aw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YKTkRwX6ZxIq2ktNynx9fYtzE1XOluNtas5Mgu8/hT6Qiv4x/U3/Gf0EeXf7qtLY8
	 Lo7cV+zOYEK9dL3iavteacbggQqeB5wG8zlcOG0KLTirE6UREeq8Fn1hZQpOX8j1np
	 e/a5AoHB2bidxFOF0RRFCzOafpoqca+QEklrDvyNA3H2dSwbYr7hUPDXJ3URqsSr2l
	 EdVLB8LFJ6yZOcwA6yBnPtA1Jx6+YrSUUv3KTsoiNaafWGl1tIe3Nd8lEyeUOIujak
	 rmd6FlmayEyFMI0F0U1p3c0dAwBYBIP1aNojbeMM6pTvkBM3YFIgc6PVZy0zMeKiB9
	 J6tKM6TeW+/7R+zzXlZ9BIkChmqwgYg786tOA7oHPnBRmk30E68CRh5Y6/8CsZAd0W
	 GSGPe2/kujOBALBc6BdyVTAHRl3kAwT4cUCqnjdYrgHPDrBFyGQtL0Zta05E7JsSGT
	 rfsAyfPtX5L7bA8LV98vo34aym3kZ85jEuNbdGRtZvcDRSJ9K4Y
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9584C200C9;
	Tue,  8 Apr 2025 01:22:36 +0000 (UTC)
Date: Tue, 8 Apr 2025 01:22:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] [RFC] rebase -m: partial support for copying extra
 commit headers
Message-ID: <Z_R6W_yjJEYuWo0A@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NgPWiK2WYFIA4CPA"
Content-Disposition: inline
In-Reply-To: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--NgPWiK2WYFIA4CPA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-07 at 15:52:43, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
>     [RFC] rebase -m: partial support for copying extra commit headers
>    =20
>     This patch is largely a response to
>     https://lore.kernel.org/git/Z-5rpWKAVPmz32jC@pks.im/ . I'm in two min=
ds
>     about whether we should consider merging such partial support but if =
it
>     helps forges preserve extra commit headers then it may well be worth =
it.

I'd like to see command-line options to control this and ideally a
configuration option.  Right now, we know nothing about these extra
headers, including an expected format.  If a future version of Git (say,
3.0) adds a new header and the user includes invalid data in this extra
header (which happens all the time with author and committer
information), then 2.50 will propagate it on rebase and it won't be
fixed until the user uses a version of Git that understands the header
and can fsck it correctly.  That's not really great, since it means we
can unknowingly spread corruption.

I am pretty sure that at $DAYJOB we'll need to have a discussion about
whether we want to propagate these headers during rebase and I'm
personally leaning against it.

Why, you ask?  I've seen at least the following types of corruption:

* Missing timezones
* Timezones with less than four digits
* Valid timezones padded to more than four digits with zeros
* Timezones which don't exist and never have (e.g., +1700)
* Timezones which are so absurdly large that they push the date to a
  year when nobody alive now will still be living
* Date stamps that are larger than 2^64
* Date stamps which are smaller than 2^64 but beyond the expected life
  of the Sun
* Extra angle brackets in the email field
* Nothing in between the email brackets
* Nothing before the email brackets (no name at all)
* Names which are not UTF-8 but without an encoding header
* Names which are not valid in the specified encoding
* Emails which are not valid UTF-8[0]
* Emails which don't meet the (ludicrously generous to the point of
  being nearly unparseable) RFC production
* Encodings which are not valid IANA charsets
* Messages with no body and no blank line (just the newline at the end
  of the final header)
* gpgsig headers that include random non-ASCII bytes and control
  characters[1]

Note that all of these must be parsed in some meaningful way because
users don't want their forge to serve them a 500 despite them having
sent wildly invalid data.  I encountered these during part of our
transition from Rugged to Git (reftable, SHA-256) and they definitely
added a lot of interesting complications (plus the need for lots of
tests).

Considering that writing valid data should not be that hard[2] (and
should definitely be a priority) but apparently is for many people, I'm
very wary of us propagating headers we're not ready to fsck and I'd like
to have an out for users and forges who would like to be a little more
careful.

With those constraints, I'm not totally opposed in principle to this
feature.

I see Patrick is CC'd here and I'm interested in his thoughts, as well
as, of course, those of anyone else as well.

[0] SMTPUTF8 (RFC 6531 et al.) specifies that mailbox names may now
contain UTF-8.  For instance, you can email =F0=9F=94=B5 at this domain and=
 it
will be delivered to me.
[1] It should be noted that all of our signing implementations produce
only non-control printable ASCII characters plus newline.
[2] Maybe I am being unfair or unduly harsh to implementers, but I do at
least agree with the half of Postel's Law that says that one should be
conservative with what one generates and I would hope others do as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--NgPWiK2WYFIA4CPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/R6WwAKCRB8DEliiIei
gQTxAQCZinMl/mKU6qv12FjgucS7g8yK4VxxGS8roNyyaSHCHwEA2gL5tvBTyLOu
IuuCDkhohK3rkNPlGTnpLjRcscxlzg4=
=6IjN
-----END PGP SIGNATURE-----

--NgPWiK2WYFIA4CPA--
