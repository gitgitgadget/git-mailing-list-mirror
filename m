Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C1313546
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404580; cv=none; b=tZrBmcdkz2XxL+QihAuhfQU3gAuD0yiC6wCMSNOr0RKVmI+qdGVIAVFgdsKxRZ6hwn7Yea5Ik+6lRMY0fhU8j7OoBZXK60NcS59S3A3OksGKGNjTulQ9R/T55cNl+u52JTbGHswpiPE+RBhZq+2HmzyGW27tXBQmUI3L9L9isSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404580; c=relaxed/simple;
	bh=S9nQSXumO+NSKRVoAmq5hTBZ/PwAMFZyBS3/1BIBQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6Jt2LzULOzGaF67OKM/jVNRMX8wjhNYuCR6ACd19Tb9q6xhU0AP3qTZU4fLaYhEejB7SlcW0IM1gqpYmw1r0uLA+SPI2BHseHQp14F0xyqAiyOJUioGZMJASvsap/T3FPS87SEZTfzTwJXzVB6LoDUqQUgjUvTMvSjAqqhJf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=o+PP/Aol; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="o+PP/Aol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1766404571;
	bh=S9nQSXumO+NSKRVoAmq5hTBZ/PwAMFZyBS3/1BIBQ4E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=o+PP/AolApheYl64Z6SrFrkzRZOuigSXENmgJOQ4Ch+fgMYsP83Gk2VZ9GpZxRvsB
	 /IFa6Rl3bcy9AM3+Winciv1h1P2w+Mubd2kFmePznI108aApX+AXbfd2PqXRjVnZ/y
	 IzNuMZFsWYyfIzMTlVK+HlGshaTQfgnxJKmg60VvOL9H2/Jzr0YJT+Aa7YwgeICnj4
	 L739mgnzLkYiMuK1wHGhRBSw2iJOb8LsaDxy+RddBzNSvK0TgDT1wVFnuwRcOyRyU/
	 RuGNyrKKDcrubtlX+kLblfq9RiiSKTPvXOE0OvZHaHICC0ijin1V9Wwwrw50jLhB+C
	 LHxGz7quRz1psxKERxq16x9YBpfKzGaFQHWeejtKcZ6xD0ahWu2ETduRrTMp2i+Nlh
	 6uxumX+4HC85IXQ2nDDL9BTpq0QgCd3+aiqFcRZuT81hDlh58VnFyn1V1aE/8R+eHi
	 sL8OrUiiRkCNVwuFW7tMFZK+T8FFYfNXQWHHAQyMA2hs9GV/ayo
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ba1b:ae29:eab2:5aae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2E2EC20007;
	Mon, 22 Dec 2025 11:56:11 +0000 (UTC)
Date: Mon, 22 Dec 2025 11:56:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Zhelyo Zhelev <zhelyo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] git restore: typo in error message "could not resolve
 ource"
Message-ID: <aUkx2XYCP75GrCsS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Zhelyo Zhelev <zhelyo@gmail.com>, git@vger.kernel.org
References: <CAMxgZ8KqU9BUJ6T7DLct3CaEh9EYdcMO=dBAMPyQsb=knekSuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DJidtQVQ4j/Z3jMP"
Content-Disposition: inline
In-Reply-To: <CAMxgZ8KqU9BUJ6T7DLct3CaEh9EYdcMO=dBAMPyQsb=knekSuQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DJidtQVQ4j/Z3jMP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-22 at 09:16:07, Zhelyo Zhelev wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> I executed the following command in repository: git restore -source
> my_base_branch
> I have reproduced this on both Windows (git version 2.52.0.windows.1)
> and Ubuntu (git version 2.52.0).

I can also reproduce this using Git 2.51.0.338.gd7d06c2dae8 on Debian
unstable.

> What did you expect to happen? (Expected behavior)
> The error message should be:
> fatal: could not resolve source
>=20
> What happened instead? (Actual behavior)
> The error message is:
> fatal: could not resolve ource
>=20
> What's different between what you expected and what actually happened?
> There is a typo in the displayed error message - the first letter 's'
> is missing from the word "source" in the output.

I think this is due to a typo in your command and I'll explain why it
happens.

You wrote `git restore -source`, not `git restore --source`.  Most
programs use double dashes for long options, including Git.  Part of the
reason the second dash is necessary is that `-source` is interpreted as
`-s ource`, or the equivalent of `--source=3Dource`.  Git was confused
because `ource` didn't match any revision it could check out and
obviously that's because you didn't intend that at all.

So I think this is functioning as designed and isn't actually a typo in
Git.  The code appears to be in `builtin/checkout.c`:

    builtin/checkout.c:                     die(_("could not resolve %s"), =
opts->from_treeish);

That shows that it prints "could not resolve" and then the thing it
tried to resolve as a branch.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DJidtQVQ4j/Z3jMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaUkx2QAKCRB8DEliiIei
gQmZAQCNEs8aOAttPRov50GxuXjjIRjFJ80rtZDECAYzNwO8dgD9GsUm0UFrTDfL
YIITo7ACh1MO1dOwWYqEP6pDfy4JZQY=
=1Xha
-----END PGP SIGNATURE-----

--DJidtQVQ4j/Z3jMP--
