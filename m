Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152B2DE6FA
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491296; cv=none; b=YIYLkmrAgeHlaq+N7WRZOxI66mODk4GWYqYjqteQkS300QGlVFBl6NEmdMYFkLlP02WerHyDRg+1J4g+cuMp6KBOCi+peuZWiZAYD6RWkTYKlD0hLOCCkQydvExkcwHCQNFX/JQYs1U7XdZmNwyAEK3n6AhUs6RUiUx3Bm1gP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491296; c=relaxed/simple;
	bh=E2fzhGUF0a/aw811IJ/4Lrec6xOqOXb2BnpYfZaK+4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6WeprzBfFay93jLcCVQ/Y+zPCW7co5tmbyJBSWJixt6+e91X7UQbBlsJ4UJ013XJLdkvmkFHqFtt+xL4V57WC1XoG7y901XWw6yi0AX8dW7srh9SHZQaFApCeFbVb8f5efeULSfrI8cBk1t1h2XN1zcwsLMc0Sb1TLS6n9FhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tSsckoxT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tSsckoxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751491286;
	bh=E2fzhGUF0a/aw811IJ/4Lrec6xOqOXb2BnpYfZaK+4o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tSsckoxT+8TkYETdJD0H/QCuFBUHeNHy8JNe2LkAMnB1L0wWSceRWNrb0yEAQW+oD
	 JEGFhoSizEIVW7H8bxrJt3vjxn9PMN8rzcQIb7ZHSkBBNuy7wcoMwdo4FA7+KLdRT5
	 m7sWCncBFb3J6LdkfHjgxPw3SsQclJXJxzlOTdLXw+yuRNwwZU20u8hotOv5I2pzfy
	 8e+Zdmy/3J0Kq4nIEbsi+O8JL2WSWvphFKV62PsG2ED2484bWGYbT5sx4RsyQVbtop
	 +IsBGQShh5RLD+nGMHLh3rDo0Dg6ushi+rAsMGISb06FBkyAjEfySEj2WPIU94dCdZ
	 h6EJfEtpMMre6CqCXDXJ32+47DzZx+x/FTgrl3E/EMvdgyrndn4DMzzGVCdG54L8P+
	 MJjH0qKSbZTKe++DQLiMmn/DiOwFl2AIHXlsynTA230Yv0IEd7XOxreHpc7vOVhfFy
	 m0pFeVHKJ+XeCEN58HSUjJCaOfSV4A58kufo0kQf1Z9v3Sx0+jJ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ba1:ff85:fdc6:571a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8B0C62003B;
	Wed,  2 Jul 2025 21:21:26 +0000 (UTC)
Date: Wed, 2 Jul 2025 21:21:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com
Subject: Re: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
Message-ID: <aGWi1bZMlbKCgB74@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
 <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
 <xmqqbjq2ed9e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Swam71C4HDpPdZy"
Content-Disposition: inline
In-Reply-To: <xmqqbjq2ed9e.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1Swam71C4HDpPdZy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-02 at 17:03:25, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/Documentation/BreakingChanges.adoc b/Documentation/Breakin=
gChanges.adoc
> > index c6bd94986c5..c96b5319cdd 100644
> > --- a/Documentation/BreakingChanges.adoc
> > +++ b/Documentation/BreakingChanges.adoc
> > @@ -118,6 +118,45 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.=
com>,
> >  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
> >  <CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
> > =20
> > +* The default storage format for references in newly created repositor=
ies will
> > +  be changed from "files" to "reftable". The "reftable" format provides
> > +  multiple advantages over the "files" format:
> > ++
> > +  ** It is impossible to store two references that only differ in casi=
ng on
> > ...
> > +  ** Writing many references at once is slow with the "files" backend =
because
> > +     every reference is created as a separate file. The "reftable" bac=
kend
> > +     significantly outperforms the "files" backend by multiple orders =
of
> > +     magnitude.
>=20
> These list benefits of using "reftable".  Can we also add one point
> that stresses why we want to make it the default?  Something like
> "Having to do X once per user to make them opt-in is too cumbersome"
> is probably good enough.

Maybe an additional line about "most people pick the default option and,
given the information above, we think that users will have a better
experience with reftable as the default" (especially, in my view, users
on case-insensitive file systems).

> > +A prerequisite for this change is that the ecosystem is ready to suppo=
rt the
> > +"reftable" format. Most importantly, alternative implementations of Gi=
t like
> > +JGit, libgit2 and Gitoxide need to support it.
>=20
> ... in order for them to access the same repository.
>=20
> How common is it to use a single repository from these multiple
> implementations these days, I have to wonder?

Pretty common.  I know Rust's Cargo package manager uses libgit2 and I'm
sure there are other development tools that do so.  At a previous
employer, we had a linting tool that used libgit2 and we used
command-line Git for normal operations.  I don't work with Java on a
regular basis, but I expect that similar kinds of things happen there,
especially in Java-based IDEs.

> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index f11a40811f2..e0f27484192 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -658,6 +658,22 @@ test_expect_success 'init warns about invalid init=
=2EdefaultRefFormat' '
> >  	test_cmp expected actual
> >  '
> > =20
> > +test_expect_success 'default ref format' '
> > +	test_when_finished "rm -rf refformat" &&
> > +	(
> > +		sane_unset GIT_DEFAULT_REF_FORMAT &&
> > +		git init refformat
> > +	) &&
> > +	if test_have_prereq WITH_BREAKING_CHANGES
> > +	then
> > +		echo reftable >expect
> > +	else
> > +		echo files >expect
> > +	fi &&
> > +	git -C refformat rev-parse --show-ref-format >actual &&
> > +	test_cmp expect actual
> > +'

I might just make a recommendation here for a `default-ref-format` key
(or some similar name) to `git version --build-options` as well.  That
will get put in bug reports and troubleshooting output and will help
people figure out what might be going wrong if there are any problems.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1Swam71C4HDpPdZy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGWi1AAKCRB8DEliiIei
gYbUAQCEMGwJF8VbJtCvPT1aAbPY2CC+pMKWqTTIZ/hjd3exwQEAiYIY3AUvrb3h
PgcIXFugRDhSKQFiF9+66K+88EcwAg0=
=NafZ
-----END PGP SIGNATURE-----

--1Swam71C4HDpPdZy--
