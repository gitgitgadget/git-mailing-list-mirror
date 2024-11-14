Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BB1B0F02
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628006; cv=none; b=FnwY2MuvVtCOjkwz9V6vbrfHzPAlXP8Owevh1LCwT9c/DQQ18pvkjYFGwdCRQlY5N0+xiyGUuq2td7vU9QYcQ1c28l6YE1cLqpS7Dnq3Os6CNw9sJtDVknJHtlwNVIk6LSo1R8e/OyeA+Q7eon4+xubEL4YmpYKsYSYabxM640A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628006; c=relaxed/simple;
	bh=jrpEoHc9h5neOK+Np3/4Eg8bPoh8iAu3zgLQCyUFK4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+qXuQqudUWhVsT1EE6rYN/bHezDLiLtgP60zDQCNtBEev3CxbviH+Gslwhao2DXoeOmOP4pU7o+IxtgCaV8ogqTEUT72mZa2g3GBxNDrXIVegDTvT8TZVY2kA8eJMR7F5ijPAwCPdQH61gbOA/a/dEX38Rj/mtciMSGv/Yoj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qTCES92D; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qTCES92D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731627471;
	bh=jrpEoHc9h5neOK+Np3/4Eg8bPoh8iAu3zgLQCyUFK4s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qTCES92DwonDw05akgfovBJdHogrlC1GPHo6sAcTti+6dF09z6Xz7OATdso0vJ1Eu
	 WxWPILr/+1RsBkWiPUQT/s9h6O+vGa0b66o+tU2AR/iVvWaX4gPWL23YioCgA7RS7F
	 VfROJV+Nkcd+DWxuAcaKCQyxcJgk6SgW4dPJ3qqJJOihmAF2Bmvb8KyDBqI9QuMkgZ
	 TVXARAQCZ9MfHo9zNvpzxyN2uAs1k7RoVKc1H0Zjzcg9RGEtZVYtO2BMJ3Rhn2NtsI
	 pESZYFio/oSHpdgLtnU2aLvOLfsiDq4DwWfbgPyb6mW2RV7RciIz8RCVD48pFFMYbk
	 H3i+ufY+D+0zP47RXEF17iiwXJ+XOTnBcaAjBGk1ZDKdr33OFMFkV7YOXJMmzXY/VZ
	 1JPpgw4+CtnTjM300+WLTTt/bJNQkkfAH9Tzd4ba1Itl9PEnaZEVJUG0EHi2B64gbw
	 Xq4gu0IYtrpBmfF2w9EoYDGEtrgbFud5oLg8bHjXISHc/2N+kNr
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B59EF200C4;
	Thu, 14 Nov 2024 23:37:51 +0000 (UTC)
Date: Thu, 14 Nov 2024 23:37:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [bug] user may be cornered into delete files #9901
Message-ID: <ZzaJzm4kyYbcDSgm@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	A bughunter <A_bughunter@proton.me>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vT3kgi4MIbARNChx"
Content-Disposition: inline
In-Reply-To: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vT3kgi4MIbARNChx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-14 at 17:53:15, A bughunter wrote:
>  [bug] user may be cornered into delete files #9901 pls see https://githu=
b.com/cli/cli/issues/9901 and look into all of the links.

What you're describing sounds like a network problem of some sort.  I
don't believe this is a bug in Git because Git handles this kind of
thing on a regular basis without a problem.

The only thing which might potentially be a problem on the Git side is
that I don't know if we try to hold the connection open without sending
a sideband during pack generation, in which case if the client side
doesn't send anything at all, then the connection might be closed by the
server.  I'll point out that GitHub sends SSH keepalives, so typically
the connection should not be reset unless the connection actually
drops.

However, you could try pushing over HTTPS instead, which won't try to
make the connection until the pack is generated, so even if we do what I
suggested might be a problem above, that wouldn't affect HTTPS.

I will mention that the repository you mentioned there contains a large
number of TIFF images about 1=E2=80=932 MB in size.  These TIFFs appear to =
be
using JPEG compression, so when Git tries to deltify them (during the
"Compressing objects" stage), that step is just going to waste a lot of
CPU and take a long time, since trying to deltify compressed objects
doesn't work and is just slow.  That's contributing to the slow push
performance.

In general, Git is not a great way to store large numbers of compressed
images.  If you're going to store images in your repository, you should
make them uncompressed (which you can do with TIFFs) so that Git can
store them more efficiently.  What would be even better, since your data
appears to be effectively a book, is to store the data as text, possibly
with a small set of images for illustrations, instead of storing the
book as a set of images.  That would be much more searchable and
accessible as well.  The Git FAQ[0] mentions this and makes
recommendations on approach.

Overall, I would not say this is a bug in Git.  Pushing over HTTPS may
help you get your pushes working in a more robust way, but in general,
I'd recommend storing the data in your repository differently.

[0] https://git-scm.com/docs/gitfaq#recommended-storage-settings
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vT3kgi4MIbARNChx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZzaJzQAKCRB8DEliiIei
gRFpAQCuY6XTFqQ2INjg4jm3zKyP+ZRrZ0+WD72+dvIX1pzirQD/frZrWk5cfLHM
Jyzhe0I2y9AzuPGbK9lhcuy2XUZqYAI=
=mE6d
-----END PGP SIGNATURE-----

--vT3kgi4MIbARNChx--
