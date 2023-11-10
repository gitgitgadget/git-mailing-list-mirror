Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8A3588A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8totqMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B55C433C8;
	Fri, 10 Nov 2023 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699650376;
	bh=+nXU/cbw68fudoOJYTDsDBSc7lz+FrlZeeeKQHo/8r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8totqMF7nxSdpbgWDB54XzU4kSqKJfYXtlPyCJMUWe8pygQtInjzuSsLEkKpQRzN
	 IAFKEfNYC6SzwHNzhX6Ug7BgW2jsHGtGAta4/c+8MregAwS4IJrPIyPnBA7OYYF6B7
	 K3GskMsMmlR7U5rq6Ovgp4XiFsf+d9J71utuA/ZZrCccdQgE5eeqe1aSlI4gVJQ8mf
	 P/q28vX/llllgVRfEquK4xBRAA9wBhBqxsLIEVJmQt0riDfw/9ulKVG8TyNmujJ8q9
	 hcShSXDVdp698/G+nbCvB+/U2+HBCQMkgJ3wD6ag5Pr/fIFGxXC27QecU7ZFS7FUyO
	 bUsQE8vTXcVXg==
Date: Fri, 10 Nov 2023 22:06:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZU6bRb-BXsQfn4ji@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <vooebygemslmvmi4fzxtcl474wefcvxnigqeestmruzrsj5zsu@5kkq3pveol6c>
 <ZU0aAQhVj7BQwr0q@debian>
 <5yn2w52iymgnobesoi2jdwpyzaf5foc4sytxfdzl4vavlox62j@7att57ya6scz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7WVc/cwe0i7Aty1B"
Content-Disposition: inline
In-Reply-To: <5yn2w52iymgnobesoi2jdwpyzaf5foc4sytxfdzl4vavlox62j@7att57ya6scz>


--7WVc/cwe0i7Aty1B
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Nov 2023 22:06:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Konstantin,

On Thu, Nov 09, 2023 at 12:59:23PM -0500, Konstantin Ryabitsev wrote:
> On Thu, Nov 09, 2023 at 06:42:19PM +0100, Alejandro Colomar wrote:
> > I haven't yet tried b4(1), and considered trying it some time ago, but
> > really didn't find git-send-email(1) and mutt(1) so difficult to use
> > that b4(1) would simplify much.
>=20
> Well, sending is only a small part of what b4 will do for you -- the core
> benefits are really cover letter management, automatic versioning and
> simplified list trailer collection. It's all tailored to kernel needs, bu=
t it
> will work for any project that depends on mailed patches.
>=20
> > But I have tried patatt(1) before, which is what I think b4(1) uses for
> > signing.  Here are some of my concerns about patatt(4):
> >=20
> > It doesn't sign the mail, but just the patch.
>=20
> Well, no, it signs the entire thing, not just the patch, but it's true th=
at
> it's specifically targeted at patches (hence the name).
>=20
> > There's not much
> > difference, if any, in authenticability terms, but there's a big
> > difference in usability terms:
> >=20
> > To authenticate a given patch submitted to a mailing list, the receiver
> > needs to also have patatt(1) configured.  Otherwise, it looks like a
> > random message.
>=20
> Yes, but that's a feature.
>=20
> > MUAs normally don't show random headers (patatt(1)
> > signs by adding the signature header), so unless one is searching for
> > that header, it will be ignored.  This means, if I contribute to other
> > projects, I need to tell them my patch is signed via patatt(1) in
> > order for them to verify.  If instead, I sign the email as usual with my
> > MUA, every MUA will recognize the signature by default and show it to
> > the reader.
>=20
> I go into this in the FAQ for patatt:
> https://github.com/mricon/patatt#why-not-simply-pgp-sign-all-patches
>=20
> Basically, developers really hated getting patches signed with PGP, either
> inline or MIME, which is why it never took off. Putting it into the header
> where it's not seen except by specialized tooling was a design choice.

It would be interesting if MUAs would support PGP signatures in a
header.  Did you consider that option back then?  Maybe patching a
mutt(1) or neomutt(1) to do that would have been simpler than developing
patatt(1).

>=20
> > It also doesn't allow encrypting mail, so let's say I send some patch
> > fixing a security vulnerability, I'll need a custom tool to send it.  If
> > instead, I use mutt(1) to send it signed+encrypted to a mailing list
> > that provides a PGP public key, I can reuse my usual tools.
>=20
> Right, the goal was really *just* attestation. For encrypted patch exchan=
ge we
> have remail (https://korg.docs.kernel.org/remail.html), which worked
> significantly better than any other alternative we've considered.
>=20
> > Also, and I don't know if b4(1) handles this automagically, but AFAIR,
> > patatt(1) didn't: fo signing a patch, I had to configure per-directory
> > with `patatt install-hook`.  I have more than a hundred git worktrees
> > (think of dozens of git repositories, and half a dozen worktrees --see
> > git-worktree(1)-- per repository).  If I need to configure every one of
> > those worktrees to sign all of my patches, that's going to be
> > cumbersome.  Also, I scrape and re-create worktrees for new branches
> > all the time, so I'd need to be installing hooks for patatt(1) all the
> > time.  Compare that to having mutt(1) configured once.  It doesn't
> > scale that well.
>=20
> Also true -- patatt was really envisioned as a library for b4, where you =
can
> configure patch signing in your ~/.gitconfig for all projects.

Overall, I think mutt(1) works better for me than patatt(1) via b4(1)
for crypto operations.  I don't use software that doesn't work with
PGP/MIME, and it's more versatile.  I'm still curious about the other
features of b4(1), so I'll try it for those.

Thanks!
Alex

>=20
> -K

--=20
<https://www.alejandro-colomar.es/>

--7WVc/cwe0i7Aty1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVOmz8ACgkQnowa+77/
2zJVahAAqDkqNM1joJo82UPim0jgXOP8dG4wROhNTLi9DGybVYolXktxGmmiB31r
zqNrA/OxELNiPqa41eGjd5Zmn51GRe+snFMH53Ou3OXA/aHmN19c7KD0ji5rcbjU
Ub5I98Y1zGIi3jLt/VaCZPqTSE316OidxOviHPQ4omiQR4cpDe1y7IEquSMiVE8E
O/UQxC+ucki+em1jld8imX7E7DjmB9DbAYEY30Y8Nm0zDZ+hAJXpBxgGgHn6/bd+
JkKFHRyNUiZsp2mK7wQVTZqcLtE0L2ng+zd4/wKWYLNIdSiivDv2190raAa7rlU+
gyO0jqkA6tfPeveJcPICdpjcGeRA0gBF9EPSuf7tHZzNASWDQHLaaGkkFaVjDeTz
9bzr8zJc3grgfwxHSky/5Q2ttsvLAnqCFuUaGfQZ2QVIr5pSh57bOuRLGL9qBOC5
LeZBN8XGe8+AqMBHNkoyJWuP/ZYLy8LIJSm1LaZBmWbFJ9Lx4hpj6C/pm2EpSAJI
SMRWZvq8IwRcyISFmK8VyUSgwFYLDpbY3ryD43nPWEc8I2xwNM5ZHFohDYKC0idn
kaZLjx/2osuBUr3sYcqTpXcNjfOsdQZu+32P8DdoOJf6BeZ8M01B+JJhy6EZXkbV
G17c5NczUMAhSr4i6KKVBAR20FfyXiWW1/sCiQJBOiJNqB7IMRw=
=P6wH
-----END PGP SIGNATURE-----

--7WVc/cwe0i7Aty1B--
