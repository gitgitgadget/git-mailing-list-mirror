Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3C145FE0
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245719; cv=none; b=AnLoHaNLw24XdsWg61q97xemH9CrrPaY3PSYuB9vCup/dMJ8tIoeZt3l4Bs9qwhU/YMX2pr/YHVAEhC9SJguLb3FLI7vQXmB9Vniu062FeqwLmqoaND+sAJFRT/V9JJxfeH4O/pTxDXrpGTPU4xLMuY0Oswn4PRPyw2Ad/a/coE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245719; c=relaxed/simple;
	bh=bnA/voHVgA+Gfxy3mGkju6WeX/9MBWN1DUiwCYcKdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFwa1LJsnmvbb+ibg+YyFF8TlyGde+XgKJAHRi7e0NG2cHDn+2SlKfQPOWDHdn/arviGIcSRmiK5pmNGwBWlY4+U2tM2kbwn3qK3ZRyIZM6Wm2p0yCoGtTjYvV/zvrUKRupwgvVAGaMwiA6RnU8FAykZRnckQxXyu30EL/U4+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKoOliSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKoOliSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CABBC4CED1;
	Thu, 26 Dec 2024 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735245718;
	bh=bnA/voHVgA+Gfxy3mGkju6WeX/9MBWN1DUiwCYcKdXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKoOliSz42pUXO9tzZx2GnghoFqMtFJj6Hn4gRdDfqgq8bgyoiiufqtcH6f4D57Vy
	 zfnH0fwcDsY3533d9pSIyEI3aSkNrUuIs6x99LFR08M9cQjTihLftUdwolN77L7KdL
	 uLsCJE0Zx0yo9cOvpdXQO9yHEBYbqkNGMWBNuRMENBq4e/660XC720DMMHgoCO7Qu8
	 6cLK/CxRzG1a6clNxP5u9uQzVk4b99x0/4wtZd9xL4QYoA+g5l0cV7htH0cA55jAeG
	 adJPC/3mrU/hoiHvHmvtxQSlLCsyCOm1YbIl8lWAfPnpfWjAWqySf/BNyBh9Esc8rp
	 cRVy3SBRni2Pw==
Date: Thu, 26 Dec 2024 21:41:55 +0100
From: Alejandro Colomar <alx@kernel.org>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: /etc/git/
Message-ID: <brgripo67yq43wzti5tpsxqezwfrurt2qpaiugnxuuksjvmmab@eeugej54ncxm>
References: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
 <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a3deuif2wqu7hfcz"
Content-Disposition: inline
In-Reply-To: <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>


--a3deuif2wqu7hfcz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: /etc/git/
References: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
 <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>
MIME-Version: 1.0
In-Reply-To: <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>

Hi Randall,

On Thu, Dec 26, 2024 at 12:20:34PM -0500, rsbecker@nexbridge.com wrote:
> On December 26, 2024 12:11 PM, Alejandro Colomar wrote:
> >I'd like to have all system-wide configuration under a single directory.
> >What do you think of adding /etc/git/, and reading a 'config', 'ignore',=
 and
> >'attributes' files from there?  /etc/gitconfig and /etc/gitattributes is=
n't very clean.
>=20
> Have a look at GIT_CONFIG_SYSTEM documented in https://git-scm.com/docs/g=
it
> and let us know whether this might work for you.

That's a workaround, which would involve appending some line in
/etc/bash.bashrc or somewhere similar.  In the end, the git
configuration would be spread and unorganized, just in a different way.
In fact, I think I prefer having several /etc/gitsomething files than
having a dir and then having to clutter the system-wide bashrc.

So, I prefer /etc/gitconfig over /etc/git/config + GIT_CONFIG_SYSTEM,
but I prefer /etc/git/config over both.

Have a lovely night!
Alex

>=20
> --Randall
>=20

--=20
<https://www.alejandro-colomar.es/>

--a3deuif2wqu7hfcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdtv40ACgkQnowa+77/
2zKdHA/9Fyjfgb9AJFmss0lCSdPnvz9rJVYuIShhLUgCcQ3OY8tVMHoqQL5q3PKF
hPzzE6SruIEHeUIXXoTjm1ex8NtDXozxBLGJgpGXEacveLH4Q0wjDJ1yoWE+p0sH
Tp9Kt+y/xmnjCdvgxEhOxqUKuK1AfTNtto+haOKEchk3Msk2QkDw2tda1YLLd/Qo
hr7oWg9CYquw99BXDWpw0wHQ/ydamyKTk3fw8MbulmBTOfDaiFLFFR577AKrUWbM
hZzRTvxjpfbxRuqzmqH+/l5hnjqoB1M+O7OmSB2+l5XlfV+yY6DnZjrLonGKvlNd
6NT3eGKIVH0/OOXn6Hr7OxOOnByTY8TZEQpnFXE4qFEzFJa5QPkAssthtNj5aDR5
y8srQRZ6HYGxKGrOuyCbWCqn3scY+SO9V3VYRb3qTDVqM3UjO8VTWuOhcQPApsD5
fg4ILfKEwEqGO3cKPwgyISg4ejDG92C7YWQrJ6DSYhNTK0MTqKRoZk5cQrELgbgY
2/gieCfBJd4K4uHXtg7dgg48W4IXhxqI/mijoyuCQHv0cX+SE7JWwvOCJe9D6Piu
9Y54f6hIvwPADEbGkgqPJm5xJSXMCilXckkWn/+yOI3+vYEuXM1RgqcV5ZH5b2Tk
MVGjDoPmR3fd5U2mXJ7R+KZVE8BbVDoe+7Wxz2lyo4W+3tiqUtE=
=iusK
-----END PGP SIGNATURE-----

--a3deuif2wqu7hfcz--
