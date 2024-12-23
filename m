Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249EE28FF
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985743; cv=none; b=FbGY7ku8j8Yl6GG4wQuyfCrGTd3YeBR5Mw7js7dwZgPNeSYtPBxCNc75YqBAQSqfJCzxMR0v0TWzy4qU5s67C8mBD4FLdA2T1XtW5V3LbmlfTniumA8+MUj83NrDlBe65Q8yyogoFEWbPiQ722+tzRuqKD9f2LS8x86Hzh1cmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985743; c=relaxed/simple;
	bh=K2BNL1Z6buy4cjqnOEK7wmHq3Sy0gp6AFZCOwYW+7Ic=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Go0UQNV+XtlzZ9ronKYW2XUj8ej7SWjY8mXb8Fdvan1PQ4Rwe+wxEePmRp+innoY3vR0+ilejXCzh28iRinsf8DGXonHSXLrG+0Jjz0R3fGC9Jblz/6EY+52rYrwE+//hNqmy4qGO+sGZ74b4YwZ8bHcEt07z+kX+61NUiO64p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFxshegR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFxshegR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB9CC4CED3
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734985742;
	bh=K2BNL1Z6buy4cjqnOEK7wmHq3Sy0gp6AFZCOwYW+7Ic=;
	h=Date:From:To:Subject:From;
	b=mFxshegRn5/YU7Yaj8slVVQXLLj+FTCvGhK+bV23g6idONEW2l0+4rC9IiV7H6etk
	 Jd2yJdRN+zuMGTIag+IqcjHMnkKIaG1KG273W0X37gMBTQ9xYN3ffJM1fnEsmMPmND
	 fYP480EKY5/El0+QlUEHhOkWaliH49l1sFfx7WdIL90FaCj4LUfvMx0+6XfJWwnNTS
	 T22OV3zgfSHAbdpw3Gf+txL5tYe6iqzPrSjkOs0QQLgXPqj1qvera5xVvZeeHOtX/g
	 MM8thg+aA55twRdWuPxTfHVJ6zbNevw5yr27sNH7/xYf7II+lgxgyjPjXCwec7js/g
	 17DDDF+zVfXKA==
Date: Mon, 23 Dec 2024 21:28:59 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-log --format missing trailing newline character
Message-ID: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brntunhnzt6owwr3"
Content-Disposition: inline


--brntunhnzt6owwr3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-log --format missing trailing newline character
MIME-Version: 1.0

Hi!

I'm having trouble scripting around git-log(1), due to a missing newline
character at the end of the file.

	$ git -v
	git version 2.45.2
	$ git log --format=3Dformat:'%H' HEAD^^^..HEAD | wc -l
	2
	$ git log --format=3Dformat:'%H' HEAD^^^..HEAD
	2ff431ab1b46a25088fe40baf1faf35ea9fac722
	e75e6c4504022ae52d877926e63c908d9572088a
	178442837d39560a789a8044a8eb90fde3ad7cd7

Would you mind fixing this bug?  POSIX requires that text files end in a
newline character, precisely for being able to use UNIX tools to process
output from arbitrary commands.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--brntunhnzt6owwr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdpyAsACgkQnowa+77/
2zKqHg/7BmlOlhop6hkcihZRGzW0h9jRC5tNRYPIUhXF0Drrrg3IizrzoeJ8n8x7
bbG+74UlkJi7xTc5IZsdG4TJJGqSCRNyss20GAJNz5aNW59CRZoccunZ6R5kq57E
TEJA0Pq8m3N3fXm+UluVDQCdO+NvT1cBpWGekd/K8MtjNPrtw7xREE+JvzY63NY1
gt4eQ2licsqy8xb7riQLgAM1F0TmwHR9cTsz4seCgWLWdhhtQuEOMc3AdMYOgYsU
fXryA5rWyv/DNvGOLDQ3iLSHJu1beGKPSjMBpk2yNFw5qclYoNgs2gUxBWQJi2U2
qmY3HBzrixOjtGCoWF/h7xK+Wuq9NttWJVI0uMp4QpEk45NJOtRj4IJYd6HjSo3q
hj6boA5fsYLUEmtc/PuI9ckDTX6qpRnuf7dsBbyRw+0siTbb7vkmu27EWdysHJes
EKkKiR/0CZjzd5IivpNI2dsBAQH6E7yk8sqF8Qyt3ls6fVWBfW7nwfcz1PpK9s4Q
2GaMmySYJLLqKnkx6XY5MHtmNNkKL7qnrQZgX3MQ3E1NyOy5zxHCqezHTzGa5R+W
/Jwkez6o/ueyPxv0wnw9Gj5Ic/ivDMy6ds5pVzWAiKG9ysKnMjfOcgwCGBYYLGdj
fGvP4idJrHtQ3eue8j8knyQKZng0nlEv2h7y+2qyMQWic3F3wkg=
=Fmgi
-----END PGP SIGNATURE-----

--brntunhnzt6owwr3--
