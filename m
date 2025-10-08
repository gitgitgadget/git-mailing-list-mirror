Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084621D3CA
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951746; cv=none; b=RkswXXMKAaj9etm2HfANbOsgBDgd1AtaKroPzbdwfYhEdU1lmNnVPXLjcx4Ub6r4bGUgPcJ1Ff3Px6bZaohAX1IqYcW0Wvux2t5PBGV3gJOwdBikkpN8jLJFYMUk9ZAsMyQhOOE2m78CxEEO9XHpFEQPXhtOjMyAvqSL+KAyT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951746; c=relaxed/simple;
	bh=7KStVkAequbvFX6Xt7AY/j3as50KmH2FNe+muqG3b0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtUOZXaiE+xycYMQuL7hQZchhbIuEVyMUHNEi6y4DcIaJxA/l1Nm9WQyCtHXao+CeudpHckJ4U+7B+FwYqIY6fcZnBV08hidu2rwP7FMTDj9glW0f8sEf/KhLH0tLl0kfBaPwxRmkYMQQjYqHv32yxNdLg5mgbB0ixdRnUH6PXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=R+a3Zcik; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="R+a3Zcik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759951743;
	bh=7KStVkAequbvFX6Xt7AY/j3as50KmH2FNe+muqG3b0s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=R+a3ZcikfSbF2lgrUX4On7b+8+6CZn2llY2efyEKSiHj0LehEo8KvOOsY7e3s/SqI
	 CEzFHYmKHfmmN6lCw6MP+DmXqoLg65Yj8rLYgU5x33PLDba35pdj9kekNCc4rF1Ut/
	 yVvATwPeG6pBzbAzW7EUhdiuGTOL8n6/gqf9pZ8GpBjLYTHH1AhCngjhamkSs4NYZ4
	 dvIY9KQdKfwFnkT2/J6XgGbnz7XF3rbFdsHjn0SRq8OaCQpGPU3pBaZV3weayJrNXQ
	 n5myvexzfE1r51jTBwvOWMRPKRzVxE1GZjG71lR7eqkqEmwwrnotZnLn87OlshJmUo
	 KFuCmW1UIVBccswEvjgxYOtF7Z8bM6McZ/wkY13kZFVJs3F8jtzyrufmJg5sXw53RQ
	 Gfr9gYtV1nYRwEMQRplxHLE2YnNhNyQrlVQPrFhHIwg0d8k/EqkLj2tS34JN0Qw0Bn
	 eue9euU2ZxqKn4RznMf+wxhzkwwcunTaHn4tt0vWWxji8ZaoHPv
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:225c:7da:a6d4:350c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0B10220114;
	Wed,  8 Oct 2025 19:29:03 +0000 (UTC)
Date: Wed, 8 Oct 2025 19:29:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [rfd] a new core.whitespace class "\No newline at end of file"
Message-ID: <aOa7fWV5RgbyApiq@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqjz15fg3i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4hsSgqNfRPvvNhy"
Content-Disposition: inline
In-Reply-To: <xmqqjz15fg3i.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--m4hsSgqNfRPvvNhy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-08 at 17:39:13, Junio C Hamano wrote:
> It would be a good sized internship project to introduce a new
> core.whitespace class that is about a file that ends in an
> incomplete line (it would be way too big as a microproject, so I would
> not add the #leftoverbits tag to this one).
>=20
> The student needs to learn quite a lot of things, including
>=20
>  - they need to study the diff machinery to learn how existing
>    whitespace breakages are reported, in order to figure out how to
>    add a new class of whitespace breakage;
>=20
>  - they need to find a good name for this new class;
>=20
>  - they need to study the apply machinery to learn how existing
>    whitespace breakages are reported or corrected, in order to
>    figure out how to add support for this new class.
>=20
> Thoughts?

I think this is a great idea.  I've noticed that many newer developers
are using VS Code, which I believe leaves off the trailing newline by
default.

I think most people on this list understand why having a newline at the
end of the file is valuable and have configured their editors
accordingly, but for less experienced developers, this kind of lint
could be useful to help visualize these problems and even catch them in
CI.  Possibly the documentation (say, the FAQ) could be updated to help
explain why this kind of whitespace breakage should be avoided as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--m4hsSgqNfRPvvNhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOa7fQAKCRB8DEliiIei
gW2hAQDk+ZyOYeqdrOULuc0q2bIrow0Ht7MvtQsQ7r2Wj5mhVQEAlElegoA/x6cW
jvokDIpjw+DfXat8a9yg6GnWk84vpAM=
=6ag3
-----END PGP SIGNATURE-----

--m4hsSgqNfRPvvNhy--
