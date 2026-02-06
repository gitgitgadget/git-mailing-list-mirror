Received: from norsu.hel.sur5r.net (norsu.hel.sur5r.net [95.216.115.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B23425CD7
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.115.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400270; cv=none; b=DwJZAAF9dLaRdoXqL2Q6fEgfCXk/v99vs5x6GoSgoia9FryU5sUpyamu+T5NHSGIlWnLVc016lZn5j0E2NkyIK8GU/yWAlw1g3veDhz+3T5/SZry6ZwCJa6E3QsSLuvy8aTHQztB22iBfcj5frMhEUADezqM6mGHwu7ZBdOcZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400270; c=relaxed/simple;
	bh=lOhShLIcL6XzPPyi7l+zY39ylz+AsWvJR0nYKub0HPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzpOzhJkLRlfOAzeNk32rFFZQ/Hfy2lH5261qT8AVz6KNLCNpm3nLLU3YvEIh+pADJnQDsQVI87j76d0lgaqxJ3Q8qTaZKzVzaln5SwNLfWIUWH9hhdccYQ5AOBrNP7V2THzeIG6ieWCXr0Pp0rqRZ41Vahd1cHE4Hh7j+LhPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sur5r.net; spf=pass smtp.mailfrom=sur5r.net; arc=none smtp.client-ip=95.216.115.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sur5r.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sur5r.net
Received: from beer (unknown [IPv6:2001:4090:e000:5e00:e068:28ff:fe6d:7eee])
	(Authenticated sender: sur5r@sur5r.net)
	by norsu.hel.sur5r.net (Postfix) with ESMTPSA id A9C242F381C30;
	Fri,  6 Feb 2026 17:45:16 +0000 (UTC)
Date: Fri, 6 Feb 2026 18:45:08 +0100
From: Jakob Haufe <sur5r@sur5r.net>
To: git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: Re: git-am applies commit message diffs
Message-ID: <20260206184508.5a014df2@beer>
In-Reply-To: <1b1f8959-aa11-4bce-8535-7245c8567d6a@app.fastmail.com>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	<1b1f8959-aa11-4bce-8535-7245c8567d6a@app.fastmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4VXAJJBTPxiXYuOMdR2oGrk";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/4VXAJJBTPxiXYuOMdR2oGrk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 06 Feb 2026 09:43:04 +0100
"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:

> Like Jacob said the cure is to use indentation for code blocks.

That doesn't help here as stated by Michael on GH and his Mastodon
post. Also, to make sure this doesn't get lost:

=46rom patch(1):

---
If the entire diff is indented by a consistent amount, if lines end in CRLF,
or if a diff is encapsulated one or more times by prepending "- " to lines
starting with "-" as specified by Internet RFC 934, this is taken into acco=
unt.
After removing indenting or encapsulation, lines beginning with # are ignor=
ed,
as they are considered to be comments.
---

It's not exactly written in a straightforward way, but it show that the
behavior from patch is intentional. So even if git-am gets a fix, it
only partly mitigates the problem as I'm pretty sure I will not be the
last one to pass "git show"/"git format-patch" to "patch".

Cheers,
sur5r

--=20
ceterum censeo microsoftem esse delendam.

--Sig_/4VXAJJBTPxiXYuOMdR2oGrk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEe/X2rDZDH11A3BN6TPKyGPVNrj0FAmmGKKUACgkQTPKyGPVN
rj1T/RAAps9SglTh3SnoGGZPPfMNZ/dCberFu67jcQyOKa+7uUYT9FdEJUA/uXdo
MOJsoudKGMkBKVPzHN7xGmIGxH+c3lUquX1ILZ2Y3BGUtJKFSJj48n4EhcJfnZCE
Qs0a6rthCZLyhKfNwdFMze29MxZK2B3shF6JW6rkatVOCB434hMgaGZIMGURrRcG
f9l3zjXd/9Xa0JHdnzStcRZ9YlwqG84FyiHawUuEZ6E7jgguxymAh4hfD8P9E1Hz
TCz/cexmRm4TG7NtITr9/YpNzbSLrNOTrdfQwWSdu+RdhBnCJR8qeK79Vc6oiLvO
Ht2tkFNnxRBETsqYul05HYnYlG3Woh+e+RABJE1ID0iPY+jFpo6gC5EFEtD9MMhp
LWANC24cmiEg7e+Quii3w9DKHtd4WSVLSVXjH2Wh1IK70uSGuM+OX6G7FlIfKzos
1gKCBu4UESt36xk2bJwGbVEIqlyeLHczqB9sN22d7aKTmJIp3QLqqHH5JRm1x/fk
2iyPyUeM2W35XXumOSxdOc4EfkMFGWcRpnYYnmWVaDI62CT/BTQKQBQ/iFgAO6Ql
ZCaCf2mkMBpqWSKc27nGijkYf8U7KQzZRk/2W45UWifqebubADdRmQgXa/VShl18
56j81yKTa/W5zMHMLB+nEXYzKe3RswA4jXgLCIlnfA6qGrzARVg=
=pIbY
-----END PGP SIGNATURE-----

--Sig_/4VXAJJBTPxiXYuOMdR2oGrk--
