Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD62153808
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575226; cv=none; b=YjtLhBY8E6B5tw2RQck4mWJTTbk1Pda67sfhJHvQPgZ5VUSIwlC5PNGFN1nfubN/S0IrK/uexApCojt/DTRTS85eR2mD9ut/9PL5viEhqXOxoeBe23/kbU/FmzMGcfFsAeexffNuUm6Tkt7mZnQK5zxmDP0McnGUT3MoYoJN56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575226; c=relaxed/simple;
	bh=2k5Pp2dnMDIp9E8BetFggBQpENrg40CYDF2zubh2AtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf31GyvgyC++pv2D3ipy/50VgY1NNKUjiWXhXkY0QS+nvPu88s7/gU8WfVZDMkPXpHA2dwrRl3aI6Orj9UrVpMQTfmpml6im5RGUsmpFE7bT3SkocZEN6U9kSd0dPvsKYuP+K/QiVqBss6JTeS2Hhc+lye00D6nZ4b1Kef903eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=utaSBRKZ; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="utaSBRKZ"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 41FA95D40F;
	Wed, 27 Mar 2024 21:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711575217;
	bh=2k5Pp2dnMDIp9E8BetFggBQpENrg40CYDF2zubh2AtQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=utaSBRKZdtmwQD61fskpUy+j4eJdmVIkHKyZgRhk/hJ2apeWFgDH1tolqvH0Xx93Q
	 fs6/nBdhwA7seuNcD64f6Eo1ACMIUg4aL28IzHUdARnypWOyqzbXpTc36mLiNsT15S
	 IkcTar49Ks2HCKr4laG175lwAeF+RBFNM35QrQO5Ony0gI7a3/aaK0Jj7CpPnk4fmT
	 069yojG9hqldglaeiooVcfhpeqCEjP01Txe/FwH277o1kcazmJYi0yq+eeEriRKThD
	 pjNrIXDqYDO1lwNGCEvcJvquLU4tYao071CkNoTw07Pz/eq/htZQrN64DaQ1cW0kcD
	 tgYHBZsb61qd5jU4wAWv8AtXTxGXj65pOHaaud9u0hf6NTAC/KyV62OelZTz1v6ycO
	 mKiJzIPeHIpMxAcLsnwJHV+QzwXLhAJY60Qq8VB9PX/2Vt3Y8CiP7ao8uO9ytJ2OwW
	 g06TQEtLBECA9YpUStIE0OjIlOORE1HlfsMOX4XSDdyNZVwFFwV
Date: Wed, 27 Mar 2024 21:33:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <ZgSQr7uQdIA8oVNn@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
 <ZgPSn_D8luXQyZGf@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aiHN/ua+q/tN7O7m"
Content-Disposition: inline
In-Reply-To: <ZgPSn_D8luXQyZGf@tanuki>
User-Agent: Mutt/2.2.12 (2023-09-09)


--aiHN/ua+q/tN7O7m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-27 at 08:02:39, Patrick Steinhardt wrote:
> On Sun, Mar 24, 2024 at 01:12:53AM +0000, brian m. carlson wrote:
> > +static int credential_has_capability(const struct credential_capabilit=
y *capa, int op_type)
> > +{
> > +	/*
> > +	 * We're checking here if each previous step indicated that we had the
> > +	 * capability.  If it did, then we want to pass it along; conversely,=
 if
> > +	 * it did not, we don't want to report that to our caller.
> > +	 */
> > +	switch (op_type) {
> > +	case CREDENTIAL_OP_HELPER:
> > +		return capa->request_initial;
> > +	case CREDENTIAL_OP_RESPONSE:
> > +		return capa->request_initial && capa->request_helper;
> > +	default:
> > +		return 0;
> > +	}
> > +}
>=20
> I think I'm missing the bigger picture here, so please bear with me.
>=20
> What you provide here is simply an `op_type` that indicates the phase we
> are currently in and thus allows us to check whether all of the
> preceding phases had the capability set. But to me it seems like a phase
> and the actual capability should be different things. So why is it that
> the capability seems to be a mere boolean value instead of something
> like a bitfield indicating whether a specific capability is supported or
> not? Or is all of this infra really only to support a single capability,
> namely the credential capability?
>=20
> I'm mostly coming from the angle of how capabilities work with remote
> helpers. When asked, the helper will announce a set of capabilities that
> it supports, e.g. "capabilities stateless-connect". So from thereon the
> client of the helper knows that it can assume "stateless-connect" to be
> understood by the helper.
>=20
> I would have expected capabilities to work similarly for the credential
> helper, where it announces "I know to handle pre-encoded credentials".
> But given that I have basically no clue at all for how the credential
> helper works there may very well be good reasons why things work so
> differently here.

Let me explain a little bit.  There are two possible flows that we can
have for a credential request:

  git-credential input -> credential.c -> helper -> credential.c -> git-cre=
dential output

  git-http-backend -> credential.c -> helper -> credential.c -> git-http-ba=
ckend

Let's look at the first one (which might, say, come from Git LFS or
another external tool), but the second one works similarly.  When we get
a request from `git credential fill`, we need to know first whether the
requester supports the capability.  If we're using an external tool from
last decade, it's not going to do so.

If it _does_ support that, then we want to pass that along to the
helper, but if it doesn't, we don't.  That's because if the caller
doesn't support `credential` and `authtype`, the helper might
legitimately want to provide a username and password (or token) instead,
knowing that that's more likely to work.

Similarly, in the final response, we want to indicate to the external
caller whether the capability was in fact supported.  That's useful to
know in case we want to pass the response back to `git credential
store`, and it also discloses functionality about what the credential
helper in use supports.

We can't assume that the helper does or doesn't support the same
capabilities as Git because it might come from outside Git (e.g., Git
Credential Manager Core, or a site-specific credential helper) or it
just might not be capable of storing or handling that kind of
credential.  By not making the assumption that the helper is implicitly
capable, we allow users to continue to use very simple shell scripts as
credential helpers.

As to why this functionality exists, it exists to support the two new
capabilities in this series, `credential` and `state`.  A pie in the sky
goal for the future is to support additional request signing
functionality, so it might learn things like method, URI, and TLS
channel binding info, which would be an additional capability.  (I might
implement that, or I might not.)  All of those are boolean: they either
are supported, or not.  If folks in the future want to expose
non-boolean capabilities, I don't think that should be a problem.

> > +/*
> > + * These values define the kind of operation we're performing and the
> > + * capabilities at each stage.  The first is either an external reques=
t (via git
> > + * credential fill) or an internal request (e.g., via the HTTP) code. =
 The
> > + * second is the call to the credential helper, and the third is the r=
esponse
> > + * we're providing.
> > + *
> > + * At each stage, we will emit the capability only if the previous sta=
ge
> > + * supported it.
> > + */
> > +#define CREDENTIAL_OP_INITIAL  1
> > +#define CREDENTIAL_OP_HELPER   2
> > +#define CREDENTIAL_OP_RESPONSE 3
>=20
> Is there any specific reason why you're using defines instead of an enum
> here? I think the latter would be more self-explanatory when you see
> that functions take `enum credential_op` as input instead of an `int`.

I think an enum would be a nice improvement.  I'll include that in a
reroll.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--aiHN/ua+q/tN7O7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgSQrgAKCRB8DEliiIei
gdecAP9JRL08RT9HchCjRyUAto13JwpBCfmJzZCDq85f8pmcJgEAuV6P0j500628
HpBHggHUmDI4slWUpkGgjPie7ZZQNwg=
=OxMh
-----END PGP SIGNATURE-----

--aiHN/ua+q/tN7O7m--
