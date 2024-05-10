Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24D14B963
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331933; cv=none; b=EZAiCPmqvc/nSYGK+ixWFBEPoHw76VOrgFQBGHEFPjD5rIO6FZynQ5Ltw3fL4gornvfn52MV/weRay6Zv4C7ipDEqwx7VTiMdLM8U5zQFrbKL6fmUDROnghNH8uvD8QV97bmH5inbajKfue2X7fw0u5o+ZnRIiBdE7KBaiCretA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331933; c=relaxed/simple;
	bh=X63tLA1Apx67PyaOt9WwJThslNt3u0qU4tC5teZ2HDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCEzLZBT9bDhaBDBnN9g1wfcahQ6XSB0K8IyKfzz34EFT9R5UnPMJBYM7uOMVgv23VvMOZ5ZTPCpPAOd/HwvLYf7NrSgi5q98h9DfuuP5mHkGY9UOICgnNmCosD+me7tP1hemCyiLQKqFqjttliVaJklfUaCav0TbyucYaL4Tw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJEjdqU8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJEjdqU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58B1C113CC;
	Fri, 10 May 2024 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715331932;
	bh=X63tLA1Apx67PyaOt9WwJThslNt3u0qU4tC5teZ2HDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJEjdqU8tHs5OakNJt6dQTcjktKT+fgTR4nTB1LNEh2yEDZ8rslSJJfX6ogYX79Lp
	 QjiaDgyHfctGcMD2lVe7vml/C9IIOLkZdF32tiGox8LT8wRL+Go1H37hcZ3HMC94az
	 zuA39FH0xEUUrkLbIInEIg6KI1Ior3B6Vqj6wiUAsppwwXzyIwwE/a8WGNkunlxiIY
	 OpP/IddDkjAHSnxfSC0Y/LbGiE2I5B8DOY1Ky8KXI8Lv8D4zD7eFnY6VGqIo1SYNyf
	 sPlTq/V5dFwc2vleitjDHqSyTU/WfK+1oJlOlbd8TlknjfdhpLxX7QnZdM/CXzK8Rg
	 B4OLEFSAJCWrg==
Date: Fri, 10 May 2024 11:05:29 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
Message-ID: <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4mqryouujsaldayj"
Content-Disposition: inline
In-Reply-To: <xmqqv83mqxg3.fsf@gitster.g>


--4mqryouujsaldayj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqqv83mqxg3.fsf@gitster.g>

Hi Junio,

On Thu, May 09, 2024 at 06:15:24PM GMT, Junio C Hamano wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > I'd be interested in being able to partially cherry-pick commits, based
> > on a path filter (similar to how many other git(1) commands behave with
> > -- path).
> >
> > Do you have any opinions on that?
>=20
> Opinions? =20
>=20
> Personally it is a "Meh" for me, because I would instead do
>=20
>     $ git format-patch --stdout -1 $ThatCommit -- $ThisPath |
>       git am -3

Hmmm, I hadn't thought of that; very interesting!

Although I have some concerns with git-am(1); basically that it's almost
clueless when there's a conflict.  With git-cherry-pick(1), at least I
have the ability to resolve the conflict manually.

If I find some time, I'll check if I can program that (although it would
be the first time I do some contribution like that to git(1), so I may
need some help).  :-)

Have a lovely day!
Alex

> which would be mostly sufficient for my purpose, but I do not see
> any fundamental reason why it should not exist.
>=20
> It is already well known that future merges from the same branch
> will have to deal with duplicated changes brought in by picking
> commits with "git cherry-pick".  Having a pathspec-limited variant
> of "git cherry-pick" would not make the world a worse place.

--=20
<https://www.alejandro-colomar.es/>

--4mqryouujsaldayj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmY941kACgkQnowa+77/
2zI4yQ//cPtDaiDshAzINDKAi5kWNe0ynwdtnPlygSO29yWWmGwshFyyNgsYO6Xl
Tb7b1+0j3eFj7iRwQ+2hTPVzgWg+lQkJMcxr8Ju1M2ktF2+lgdgEjUiQKbfzNeiE
zUaZ655CVMWopq1su83YTeQZ7BCnoJgMUnTXLcE2hRcoeMIT7pKAr7VwKnETSjzA
UNDc6udJBPhD8ggMyCYmpZfdtNwS3K1j4pGCyPePza5vG1Bo2BeB5ia3IBNxBBk3
DuQ7kLUNErxVMi8SRDGgtz97YhcgNRT9UTy8GYijU2xfYMDyqS+DWvzBBgl/hxFy
M0mGRSLxpsompR3dQs7wyuIy4VYWO6ujDepSljkYbjMaNLL1sEOgNk+XNbSXHAN0
C7SMblcWIUZBsvAvnuKS8ouPGkXdRG8aHkGGLeQp6eX7DVvjsen62j2ir+SCpr2S
MGw9MD0zfKWDW4vr+88/XqbieUzTIqWyI74sM53QVfkjL5sc+P4N61dRCNmaWfIJ
OgCNTcspLjSLnlOecE9wqfNAyGY3z7IyWjbIHhj2kwKGV3LB6pRkEuCeLUMvREsR
gmTsFDLENKHG+UMZi27ejd0ZIXUn8rxuzPmQu/85SVvrCo6UezHjnfJr7LTvc7Ow
F1u6wEKPq6L+Ny5I+ob3VtylWFILr/uFsDk9W0knyGBM1LnDhRI=
=2wxO
-----END PGP SIGNATURE-----

--4mqryouujsaldayj--
