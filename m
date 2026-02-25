Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C43339B32
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058662; cv=none; b=PrUEba42Em9esdG+kSsz81YygLZl/XDwRTZfJ3QRMNuPF4boiwp0quJaEq168dlqbREN7+e/scBe+gLMSnzgs0zc2BIF3A4QKlXmaZT01diQlqDmdS9l4yBP2d72WoyIjJ8k3vDd5UtC/ny65GXQkmmqKuBsrjK9hZ37zRm/G8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058662; c=relaxed/simple;
	bh=aYEicOxZ7Px15yyttIL4YD6ClpjCNT63SfWAfwXIPpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsJEExyGLoo5Mrc1iN0aRdGP8WuV0/nqqfcVv7+UC/6+pRSW51Kgg96FBRszjhTe7+hG4HWXqAbKgKWw+kmyGjNK+Jk75VLq8KYKsKBq68FbukJfnu2jNX7SayADCNRbcDEBV9VJCldCywtRElwfbgPvMvy+3v2GPfZU+CLwru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IB3rVGEC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IB3rVGEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772058654;
	bh=aYEicOxZ7Px15yyttIL4YD6ClpjCNT63SfWAfwXIPpM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IB3rVGECqdnomIMnlfwIapvHqvbL+5SvcoPhhRgZjhZVeebxUOaaPRMrF3jlgHW0R
	 2fTyDkaY3A25AZ+9JdTZEhkxFIf0YFcG8yodzr0zFs6azNEsDGp3zRAwwlp+9r4G9B
	 UjMTbYcZD4HQnPQq5GnlFbK/CPDUN/0pYc5gcFjF9PCMYGonwZzQWMnyoP8iVdzMah
	 J40ttyr7hj70kF7jLREIJaXEYxoGuNAfD0Pw6XZ0vmMAg3L6pZ8P9QF8Y7Bg8OeGKi
	 xBBgaZa1hbd3Uaw9fulTdtG2dgr3hpCIVAe8BfhWc/5BQkHnF/HjOTs9ySxpTxa1ex
	 ZZQEvfuu611XF3ibDszIDXBeZysQ7WovvZV0liYp7ffyChIWaZNnhCaE3EbpAd+86d
	 qJTBNRWfRpnoqzPgze5VeIEZBSCR9Q7oXXjHv+Y8tiaE4bMRWQyo5vg8TD1GENPxXB
	 NipA6fyjdsNcxzloTU3mCiwcrBs9vt3QkN6j4DRe4JEuPLlrLgm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:754c:74b3:5794:b1f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B646020106;
	Wed, 25 Feb 2026 22:30:54 +0000 (UTC)
Date: Wed, 25 Feb 2026 22:30:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
Message-ID: <aZ94HdcOUGp91UBT@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <aZjuTSopOMvwR4hQ@fruit.crustytoothpaste.net>
 <87o6liw4s1.fsf@collabora.com>
 <87ikbpwr13.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C0o6HKOazLVCSXM6"
Content-Disposition: inline
In-Reply-To: <87ikbpwr13.fsf@collabora.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--C0o6HKOazLVCSXM6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-22 at 00:39:04, Adrian Ratiu wrote:
> Hi again Brian,
>=20
> v2 of the parallel series is out if you want to review it:
>=20
> https://lore.kernel.org/git/20260222002904.1879356-1-adrian.ratiu@collabo=
ra.com/T/#u

Thanks, I'll take a look either today or a little later this week.

> P.S. I think your spam filter is blocking all my e-mails? I get this
> reply from you:
>=20
>  sandals@crustytoothpaste.net, ERROR CODE :554 - 5.7.1
>  <sender4-op-o12.zoho.com[136.143.188.12]>: Client host rejected:
>  CONN:SPAM
>=20
>    Original-Recipient: rfc822; sandals@crustytoothpaste.net
>    Final-Recipient: rfc822; sandals@crustytoothpaste.net
>    Status: 554
>    Action: failed
>    Last-Attempt-Date: 22 Feb 2026 00:30:10 GMT
>    Diagnostic-Code: 5.7.1 <sender4-op-o12.zoho.com[136.143.188.12]>: Clie=
nt host rejected: CONN:SPAM

Yes, this is because one of Zoho's customers sent me spam and they
didn't act on the spam complaint in a timely manner.  I've removed that
block[0] and we'll see if they've fixed that in the past six years or
so.  If not, I'll re-block them and you can have their postmaster reach
out to me at my postmaster address to discuss things further.

I regret that this is necessary, but unfortunately when you run your own
mail server, you have to deal with all the abuse yourself and many
companies choose to ignore abuse complaints.

[0] It may take up to thirty minutes for Puppet to update the mail
server configuration.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--C0o6HKOazLVCSXM6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaZ94HQAKCRB8DEliiIei
gTX8AP9Dh2mzAhxNEK8tWxGz7DXhqY1WUnKJ0UGouPIzEo1MmQD/fdXZs2hWVW6o
eevfWwLniEFhHnHdhrynSfP796bi/Aw=
=bgJg
-----END PGP SIGNATURE-----

--C0o6HKOazLVCSXM6--
