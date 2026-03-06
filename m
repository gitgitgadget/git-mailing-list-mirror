Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EF35BDBA
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839790; cv=none; b=d/T5dke1nRmvnzLRQAeY0a/aqYGje0Ef4SU234OGEFR9R8FmfiXapR8ZZ3FT5CYvZKCkEN3rezGZPtA3fDZxy8jVYK1mKD4yMm66hwpXec5skE25ZQuI60lXRg9l4w97NGbKt5ivOJ3zI5Zh+haBQEP8LRpElFBRUs5XZbHwm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839790; c=relaxed/simple;
	bh=eBjbodowFoFMi8Q0iXUQsqmPkfUM5oK7RIJlVBP0MZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNd23j67qHmFn2J8HnooUZ+LIxZfSZg3zrDPSVGMyAUpNVOGaxIA1g/1oMFAK7xKIgmNBwVi8dwZsCCAFVqEp76gwTMaR/zLAvOX7znw1Dp1hY+SG7eoFHydvmVQRHRiLgFULjdln4q3MKlXFMoiC73Nkov4pdi4sW6veNUFaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kgtbsqup; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kgtbsqup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772839787;
	bh=eBjbodowFoFMi8Q0iXUQsqmPkfUM5oK7RIJlVBP0MZ8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kgtbsqupVqtYVNvDz96ruIhvmYR6aw219d8E7ICd5flV89YoS/dvcZHkospB6gEaC
	 ZKwdMYg8hDwnN1OUf4/crNuF+/n45v2FDY3RKd1vhLSQNLS2eRtZGNOdCfzdmIIpGl
	 VJ6QgkxvnKKn9E+WCpJOFzn6wxkMbkTiyYTd4W0GtZwYKEVDz9od11hCK4dwVktkD7
	 irDAHRbzVzab/Pkrb9PsVqky8x3/oTQKrN0DSJFx3incUEmfsIyJkFr8apT4s+pjsg
	 lxXs/DqUgeDu14+7avafxQFiBu1oKjNRwG1Z+UGSxohiXszqFVAsayL3l6hANZ4YKI
	 oDFB6on3tw78HHvnkt3iiKgsCI2GKAQsPEAWAefNgtQMwhO05wlbQNbitCUkVmjdez
	 grBFJPNQtvX6o0sycw3CmNjzfrXnwOOjgTUewEeZAo3aRO0EHn0S3d7tVlw0DvTTZ6
	 Hz0s1gOm03Vgb1mvY8LoDNpQNP7MNrImc68o/1cnlCtbvKD/QxW
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ffb:2fcd:f6c3:a675])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 906ED2006D;
	Fri,  6 Mar 2026 23:29:47 +0000 (UTC)
Date: Fri, 6 Mar 2026 23:29:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Banon <mikebdp2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clone, progress: add --no-turtle-speed option to abort
 slow clones
Message-ID: <aatjasMiPIeT0s27@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Banon <mikebdp2@gmail.com>, git@vger.kernel.org
References: <CAK7947msLiGgrYTcg1m3ew+bP0F+VNbRaTy=ZW7zkkHh69bN0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hc8wDc4KlR9SAcz8"
Content-Disposition: inline
In-Reply-To: <CAK7947msLiGgrYTcg1m3ew+bP0F+VNbRaTy=ZW7zkkHh69bN0Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hc8wDc4KlR9SAcz8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-06 at 22:14:28, Mike Banon wrote:
> When cloning large repositories from a website with multiple Git servers,
> the client may be directed to a "turtle-slow" server, causing the transfer
> to proceed at an unusably slow speed. This can lead to stalled downloads,
> particularly problematic for automated scripts that clone many
> repositories. This option makes Git abort the clone if the download rate
> falls below 128 KiB/s while receiving objects, typically catching slow
> servers early in the transfer, enabling scripts to retry the clone until
> they obtain a fast connection.

I'm not aware of any servers that this option would be useful for, but
I'm willing to assume for the sake of argument that some exist with this
design.  I don't think it's a very good design, but I admit that there
are many things on the Internet that are poorly designed.

I think it would be more helpful to provide an option
`--min-speed=3D128KiB` or something.  Assuming Git is still around in a
decade, we might consider 10 MiB/s to be absurdly slow then and an
option that hard-coded the slow speed would be decidedly less useful.
Many users might have different speeds that would be more tailored to
their environment even now.

I also think that the word "turtle" in this context might be poorly
understood by people who are not native English speakers.  I agree that
turtles are typically thought of as slow creatures, but they may
epitomize other traits in other languages or cultures (such as wisdom or
longevity[0]) that might not bring to mind slowness.

In addition, I would think we'd want to update the manual page as well.
My guess is that CI would have caught the fact that the option was not
present in the manual page.

I didn't give extensive review to the design, but I would think passing
an option to the child process or using some sort of option message
(such as in the HTTP helper) would be better than passing an environment
variable if that's possible.  If it's not, perhaps the commit message
could explain why that wouldn't work.

[0] https://en.wikipedia.org/wiki/Cultural_depictions_of_turtles
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hc8wDc4KlR9SAcz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaatjaQAKCRB8DEliiIei
gfY4AQCJzGmpyewC52dsvn4nnvTeWxe0fwP1YTkhiRJ1LGcj2QEA/cCNTx08gLAc
aPkpD7iIecYLXk7dt5jHjxt0/KApjAk=
=enw8
-----END PGP SIGNATURE-----

--hc8wDc4KlR9SAcz8--
