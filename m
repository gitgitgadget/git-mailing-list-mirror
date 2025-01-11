Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB533E7
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554090; cv=none; b=me+BlWhlzyCpmVMo9F6OCwhwZYOg4IZIBd5KwyJylFfBiCrp7QnWqI2UACfDzMUsLYSCQ5O26WSsxhdQm0v1pgAM+KHlaQNBKQTj7TVGl6He60dnx428huoaXQ2YKX5elvpuFh7MbpOfB9gj2BT3X1yHxMju/6+7dP/1RAkNrps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554090; c=relaxed/simple;
	bh=Ip9Tzju63qrXKHmQJD3tfmxuXzlDialV25mwOOAcQqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW9WLU96Nb9vZZlI72C0MCF5FoqJDkuEU79iLr0P0Rk1Va51jZ0s3G926kvX1trGpj7VAMxRRaAWi0IMpUZufjTb5jF11ZSmIsXS9CmjREYjw8UUEH8KamrARt8vw0OY8+KFUnt0ZtCJ8wRtaTwwxqqrXXu+Qr5+Yba2CVfFBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KgI5aWta; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KgI5aWta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736554086;
	bh=Ip9Tzju63qrXKHmQJD3tfmxuXzlDialV25mwOOAcQqU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KgI5aWtaz6PlRl9Y2TbAXYOwcNwgo1hHDo6MU+jyW3uPGNyuJglCcmlxqyaTJNcdO
	 36aUapbNQSnKMPBa4wMbfoXS9Ojrly5H+y6c/dK36pt9qDSXMp09UZBkyAoGPhET52
	 fVxRbWY8Q9pcYw7T/i1uFTkFR39f55nrERVPh/Ea8iHaKBYEW+qVNB/IW8yvOfr4Cz
	 zv4bhYn+/LQXtb1Xy5iKjmDW3Kbu9Xw/v7k6ty86eX1mmHR853hfwJ7F0cMmBKmIkN
	 NFtBe6rjkFrRbneZzXBhvwbFQTXcJpQmfUDWPNuG+04KTbdrbzizwTkWXd30MpgHg8
	 LtLNHUH0B5g9FKeJP6xPcnRbA4bGNdiPjyJFqTHW0vJWn8bKNJhuIQ54Kr0UxHlU3B
	 JzEC2HIlye/JDacI/aUnADW+H6YvMaXcxvky7437QXuIEFHmxadZlPIj5HRGHJpT87
	 vlvH3U8ydigrqZWbRBrKZ+ok4wuC/uYQ0xnswW5j+Xf7d+UjrK1
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9F78D209C3;
	Sat, 11 Jan 2025 00:08:06 +0000 (UTC)
Date: Sat, 11 Jan 2025 00:08:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	derrickstolee@github.com, stolee@gmail.com
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
Message-ID: <Z4G2Ze8S5PKfKjmI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	derrickstolee@github.com, stolee@gmail.com
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
 <xmqqh6665p8j.fsf@gitster.g>
 <Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>
 <xmqqa5by5lm2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hq8qIOvQOxJVQ0zN"
Content-Disposition: inline
In-Reply-To: <xmqqa5by5lm2.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Hq8qIOvQOxJVQ0zN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-10 at 22:51:01, Junio C Hamano wrote:
> Yes, I do strongly object us to keep a hardcoded list that can go
> stale (or be stale from the beginning).
>=20
> What I was wondering is that because we are in control of the Git
> end of the credential subsystem (even if the user may be using a
> third-party credential helper), we
>=20
>  - can notice that the URL has embedded single thing (which could be
>    username, but which could be a token);
>=20
>  - can also notice that we asked the credential-helper, or
>    keyboard-interactive, and obtained a password (or not).
>=20
> When the former is true and the latter is false, it is an indication
> that for that site with the username-or-token, there wasn't anything
> necessary to authenticate and the access was authorized.  Which is
> what the original poster wants us to warn against.

No, I don't think that will work in the general case.  Here's why.  If I
do `git push https://bmc@git.crustytoothpaste.net/git/bmc/xyzzy.git`,
that uses Kerberos (Negotiate).  There's a username there to make
libcurl enable auth, but it's never used and a credential helper is
never invoked, so case 1 is true and case 2 is false.

Now, we _could_ do that only for Basic auth, which would catch the
GitHub case.  However, it's _also_ possible to use TLS client
certificate auth (and I think Bitbucket does support that) and use the
username only for choosing the account (because, say, your work account
uses a client certificate and your personal account uses something
else).  There might be Basic auth sent (say, if you'd set
`http.proactiveAuth`), but the server would ignore it since you were
already authenticated via the TLS cert.  That would also make case 1 be
true and case 2 be false.

Perhaps that latter case is not worth worrying about, but it is a
possibility and I'm sure some people will hit it.  Maybe with a config
option for the advice that's okay, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Hq8qIOvQOxJVQ0zN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4G2ZQAKCRB8DEliiIei
ge36AP0Tbxjcj6xT72JxrOGc4PaHYaxyZm7cHbBDg9eG3x5uWgEA4zj6kZr/UcOL
evDe5mlBUWQR28hXguEUhbILTuSd0AQ=
=Ht6s
-----END PGP SIGNATURE-----

--Hq8qIOvQOxJVQ0zN--
