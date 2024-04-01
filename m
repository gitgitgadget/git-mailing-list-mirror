Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B54683
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009655; cv=none; b=L/jYhk4iMGQXJxtyhazcMITDrSuNpyxVvQGJdiKfwnYPGy1qAj5bKP2FYPJ3dAa38k+chCnj12rv0jc3VXis6eYucoz2cLI9wpc0Xrx4bFBcnRdaSozgKLacpssXip58cyCqn0JuZ/iBcbeirA2+B121mQJLvg11eHz0J7o3Z4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009655; c=relaxed/simple;
	bh=bvxWQhXRMxnax3Qw7DSdes1YC7TOaZKVkva/iZtxquM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBxFyZtxXgayEY56hpoS4fhqxzAa9wSzKkB5s8Fn/x+rhjFk0ZTUKX5mprrJRf5+LMKqTilgP3XLPQbJXUk9oBE6wjf0T+dDDf+47MVh+Lfhb+83xfsBE7T6t8uwDxdcdUCp2caHe0eFNUK1b6wP0O8Dvosw4XnKgeU5bHBsdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uVbU/yub; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uVbU/yub"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2105C5D4B2;
	Mon,  1 Apr 2024 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712009645;
	bh=bvxWQhXRMxnax3Qw7DSdes1YC7TOaZKVkva/iZtxquM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uVbU/yubLFN+ESDWx1AhaOvq9AnPLkTOE0L58a3YaV99wVQcA02UYnSxnnni6B8ot
	 ZDPI2MwRKfeWTb6UX/2fCcMxR7YxAFTqFfIJoKGar4rSP50+Q2oo5ztfKJuDYG+GQa
	 /q6OqAcgUDFlyh4G3MlTiJL+77urv/T4X13Qsy7Px1aHp/WEr8hUVeQjEtMIiEzArc
	 26QVvk4NscRWYfbQWT+Aj1gVIWMNE1yD9g1rWijAg5kN1/UP3H73B9COEb5G9wNVRN
	 cX497mbUjI1jJLuirtbYvpu8+cFE/+GrEuTDDOx7gudFuAncjJ0+tK66mtRw4bSgYx
	 cdKEShqMEYM0N/Hx2P3nX/L7QsDpVVRo58ZBojLyQ9YQBSwmDbbap9tCdiu11Fvdhd
	 zDxh+rmUqebcXHqi70brsXj89Z+gRVAuSSyIN7L003siN57LFCTdArD/oYH0/HzbD4
	 SK8vGOWqx0dyq0aoW14ov3aRdgfE1OfAUbNsHSHezvhsAIYzj+9
Date: Mon, 1 Apr 2024 22:14:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: mirth hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 08/13] credential: add an argument to keep state
Message-ID: <Zgsxqj_gkt041VCN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	mirth hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-9-sandals@crustytoothpaste.net>
 <CAKcCxfBi55OoR=Li23o6p+kkCNaZHr_8NDmVXhmfvYzR_G2Qfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BmmJL6VWz7/EIgQV"
Content-Disposition: inline
In-Reply-To: <CAKcCxfBi55OoR=Li23o6p+kkCNaZHr_8NDmVXhmfvYzR_G2Qfg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--BmmJL6VWz7/EIgQV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-01 at 21:05:28, mirth hickford wrote:
> On Sun, Mar 24, 2024 at 1:13=E2=80=AFAM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > Until now, our credential code has mostly deal with usernames and
> > passwords and we've let libcurl deal with the variant of authentication
> > to be used.  However, now that we have the credential value, the
> > credential helper can take control of the authentication, so the value
> > provided might be something that's generated, such as a Digest hash
> > value.
> >
> > In such a case, it would be helpful for a credential helper that gets an
> > erase or store command to be able to keep track of an identifier for the
> > original secret that went into the computation.  Furthermore, some types
> > of authentication, such as NTLM and Kerberos, actually need two round
> > trips to authenticate, which will require that the credential helper
> > keep some state.
> >
> > In order to allow for these use cases and others, allow storing state in
> > a field called "state[]".  This value is passed back to the credential
> > helper that created it, which avoids confusion caused by parsing values
> > from different helpers.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  Documentation/git-credential.txt | 29 ++++++++++++++++++-----------
> >  credential.c                     | 20 +++++++++++++++++---
> >  credential.h                     |  7 +++++++
> >  t/t0300-credentials.sh           | 29 +++++++++++++++++++++++++++++
> >  4 files changed, 71 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/git-credential.txt b/Documentation/git-crede=
ntial.txt
> > index f3ed3a82fa..ef30c89c00 100644
> > --- a/Documentation/git-credential.txt
> > +++ b/Documentation/git-credential.txt
> > @@ -196,6 +196,15 @@ provided on input.
> >  This value should not be sent unless the appropriate capability (see b=
elow) is
> >  provided on input.
> >
> > +`state[]`::
> > +       This value provides an opaque state that will be passed back to=
 this helper
> > +       if it is called again.  Each different credential helper may sp=
ecify this
> > +       once.  The value should include a prefix unique to the credenti=
al helper and
> > +       should ignore values that don't match its prefix.
>=20
> Does Git ever populate state[] in 'store' or 'erase' requests,  or
> only 'get' requests? It might be worthwhile to spell this out.

Yes, it's populated with whatever the last state value was from `get`.

> This seems somewhat different to other multi-valued attributes,
> particularly the "set at most one value" constraint. As an
> alternative, how about a single-valued attribute stored independently
> for each helper (vector length equal to the number of configured
> helpers)? Then in repeat requests send the "nth state to the nth
> helper". This would avoid the complexity of the prefix mechanism.

I originally tried that approach, but if you have external callers of
`git credential` (like Git LFS), that doesn't work, since you need to
make two separate calls: one (with `get`) to fetch the credentials that
returns multiple state values, and one (with `store` or `erase`) that
sends the data back to accept or reject the credentials.  Since there's
no internal state in Git between the two calls, it's not possible to
only send certain data to certain helpers.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--BmmJL6VWz7/EIgQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgsxqgAKCRB8DEliiIei
gZpuAQDf1S6ztw0X3M687huS/GyYqa+CNLDfbiVj7iaTG65wiAEAgYzpIR0KBoRx
XWkZFSTYcBAIHwuGfjuBEpSPMqjf0g4=
=9fbo
-----END PGP SIGNATURE-----

--BmmJL6VWz7/EIgQV--
