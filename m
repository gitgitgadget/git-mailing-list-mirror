Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59558749A
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456954; cv=none; b=slOqq6ZGV+rkcu8/eWstYEEshdEjeeVSCpcEKzgEp97TazOe8OeGWZYQWHto4QO+KObq6PV5+sgM1QpoHD4ASwmLcNkOAL/F/cI+PyXhyCjWqzRRPRFBuxNmMWjECTZzKj15RM8nVoxSt3VofGBo+eRzupfI+zmm9Es0lQpnj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456954; c=relaxed/simple;
	bh=WAopodz2C2AZJT1z8YmSxhmmrhFhU9dWrXqtzMSoFXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiRkqORLFMV8nZQxbQsgIzEYWJg37kpWBo597id/HipDgfG6ZJjz5GccBT1UqYHT9TjZIdzNWx0uoPidiyJVH7e/8Dh26RSSemhffafNEJ33sZtFmIMsO+wimrk1YyO7GhKArac3khUMkuBmwmlr5VFP3r1MUXoTQ4nDNz9FGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=po2l4DU+; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="po2l4DU+"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 26DB45B3DC;
	Thu, 14 Mar 2024 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710456951;
	bh=WAopodz2C2AZJT1z8YmSxhmmrhFhU9dWrXqtzMSoFXU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=po2l4DU++y+fbPHPvOXHfNHuU45lYLRowYsi4VSlLFWmE5UlMjwYJKNwYNh2117ZA
	 A4JjNdcRFCbPss0Y9SNmB9v1MvXMPEH969w4XHnRWmTycU/HDx/Fvh5tBxF85OPSMf
	 egUDiz7R6Mlqyyjhz1OKWvQ2+A7yg/9tjQBK+uLbvl5CzW9nbfCWM8cnbSppKS1t/8
	 JsDk2MghV5XWVrZjXZYit/vg5xvVOfergTqRyJj+PdKTJB1hDFpC+xqoXxI9IAJkfb
	 883tYTPDk+4vXmVRZZ/A0AVIlW7ltnMweGvu+Yk5lWIms5mUo95cAHW2RCWdrVy7Ph
	 Be0F38XFf0fDeIRyiFrF0Lix0CLwA7Ht949YFpIUUrVgiSea0x2FclxKY4wO1PO3Vs
	 rpaG5zxSKCew/f38b9l4KW3Paw1O5/WJsUsPt9+K0DZb4wVzFYY0EsdmULhhd5jgFb
	 UVkKyl4KPBY/endZsfV7BbjAwvNAG2+UZsUULc4PqlhJe2yJb5U
Date: Thu, 14 Mar 2024 22:55:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christopher Lindee <christopher.lindee@webpros.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Message-ID: <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christopher Lindee <christopher.lindee@webpros.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aRgd+0QEYJ06HU9H"
Content-Disposition: inline
In-Reply-To: <xmqqa5n168nh.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--aRgd+0QEYJ06HU9H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-13 at 22:58:58, Junio C Hamano wrote:
> Christopher Lindee <christopher.lindee@webpros.com> writes:
> > This changeset proposes to address this issue by adding an option to `p=
ush` and
> > `send-pack` that, when specified, will send refs where the old-oid and =
new-oid
>=20
> "where" -> "even if"
>=20
> > are identical - instead of silently skipping these refs.  The first com=
mit
> > introduces the `--send-up-to-date` option to toggle this behavior, whil=
e the
> > second commit updates the commands to output an `(up-to-date)` notice f=
or each
> > branch with an identical old-oid and new-oid.
> >
> > Notably, the `--force` option will not send a ref when the remote is up=
-to-date.
>=20
> And it makes sense *not* to update `--force` to do the no-op push,
> becaues you may not want to (accidentally) force push a ref that
> does not fast-forward.  As I already said, tying this with use of
> the "-o" option is not sufficient.  So I agree we may want a new
> option to trigger this behaviour.
>=20
> A radical counter-proposal for the design is to update the client
> side to do this unconditionally, without needing any new option.

I'm not sure that would be a great idea.  Since it's a push, that will
trigger authentication, which may prompt the user (e.g., for a password
or token or for a YubiKey touch with FIDO2 SSH) and which they might be
able to easily avoid.  As a server operator, I also expect that there
are people doing lots of needless attempts at pushing in automated
systems (because with enough users, there will be at least some who do
bizarre or inefficient things), and I would prefer to avoid serving
those requests if I don't need to.  (For example, for us, reference
updates need to go through a distributed commit protocol to update
multiple replicas of the repository, and if there's no ref updates, then
we cut out multiple services which we don't need to contact.)

Note also that no-op ref updates cannot be simply omitted on the server
side because we need to verify that the old value for the ref is
correct, or we need to reject the operation as out of date.  While it is
_unlikely_ that the ref has changed since we fetched it from the server,
it's not guaranteed, especially if there's an expensive `pre-push` hook.

I do think the proposed change is valuable, though, and I'm in favour of
it with a suitable option.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--aRgd+0QEYJ06HU9H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfOAdAAKCRB8DEliiIei
gcjzAP9wq+v0hihDIGIWR6l5cUWfnLj2veJdt5EYqwLABvFYLQD/WcKu0dKLA4OA
RtT2Q9GHNtc8JnpxD/PhPDznwmfWegc=
=jxYx
-----END PGP SIGNATURE-----

--aRgd+0QEYJ06HU9H--
