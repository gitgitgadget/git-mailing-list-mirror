Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193511A38F5
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464251; cv=none; b=nS4omH7S2TAYRlZB7QegsvlVi0rAb9zsrm+Jhx3mW2izQTTniu0JAluQ3yoOKJCGJyQZQEdh2e86p0EvwGw2FNOfT+lp2bV/q6u6QkEFB8TVvnGm7kPzpYqPRXE7o+hJM1/2KVQWmD/bE1CXEbdSB66dk6JHRr2rwQ8QB+V7fIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464251; c=relaxed/simple;
	bh=D6lh7CImVWDMD6Ez2zL7iEUJ+HW8hn/a4lusUPIw2+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnYM+yqy+vFmb1w/kyIshKk2hu6zwIZJLVx1ty0OoTZP9ty+J7O+KvOCTxS7d0NPAUn4025YPXZesh0cS5XZ4DqcTJgXluaRnN5HgtGtU4bsA3Y2BrMXmQHHvSmOxQjeNEwlgpv/i5LYEOzM4I8CiFjhbJuy0FKhnSmt3nfRXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=M3iU+u6Y; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="M3iU+u6Y"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F1CA05B3DE;
	Fri, 15 Mar 2024 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710464248;
	bh=D6lh7CImVWDMD6Ez2zL7iEUJ+HW8hn/a4lusUPIw2+Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=M3iU+u6YRss4r7Ym/+cWP8FCDel40LTAQ1HlW8Hernc222O4gBkSDVYFQIpRGxy7H
	 e9mA6OA8tSpv3UR1esC+hzIMrr3ITxQaLfIGmzpPRgvasLFxuuyaj+ZqHO5c37iJ7n
	 TLB6fJBy/Vg/UhPhNhDHN74MrMNJN8d28GQqdh+vILZCn20j4m+tCWbHK7QWS9yudB
	 rK4fiXSENpchKZcChzEEFeY6saiIFIfvw9+yi3BcMKY4reD1SIH7oqZDA80gEmntKa
	 W6AtoLOiyF6v3cyoFwP07KxqONQg9bpdh20DOnNweT2kkaw7ia7/NFXV1CfSXTjXXs
	 RVY2X8b7hDWJI/qpnkbemcSMhPdQNeSq3OLrYNJWkjwkmyV6cqdCsdK+2Ln7ankLtz
	 Altv2RRSoVLBjCdu2irxpVGL/OdumXMuEyu+Pd5dfNbx9WH9jooj8op1HmLzZM9X8m
	 Q23DvaTemtvKebwWxKDQIdtfQoRqNx3YnQXyiWveRBdL/Guix3h
Date: Fri, 15 Mar 2024 00:57:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Chris Torek <chris.torek@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christopher Lindee <christopher.lindee@webpros.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Message-ID: <ZfOc9hrayymnJNPc@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Chris Torek <chris.torek@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christopher Lindee <christopher.lindee@webpros.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g>
 <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
 <xmqqv85otmsb.fsf@gitster.g>
 <CAPx1Gvez4Ema9Yi-7Ei8OOkq9t8AXmBYN=yy948k_C+ZBKdXmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G8+zj+Jgb7v/BX5S"
Content-Disposition: inline
In-Reply-To: <CAPx1Gvez4Ema9Yi-7Ei8OOkq9t8AXmBYN=yy948k_C+ZBKdXmw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--G8+zj+Jgb7v/BX5S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-15 at 00:04:25, Chris Torek wrote:
> On Thu, Mar 14, 2024 at 4:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > In any case, I am OK with the feature.  I just was wondering if the
> > end-user experience may become simpler and easier if we did not have
> > to have a command line option.
>=20
> Would it make sense for the *server* to request the option?
>=20
> That is, you run:
>=20
>     git push server-remote ref
>=20
> and if the server at server-remote "wants" to know about "no-op
> pushes" because it will do something for this case, it says so.
> If the server says nothing, the client doesn't bother with the no-op
> pushes.
>=20
> (This could be either per-ref or global, too.)

This is an interesting idea.  I don't think this can be per-ref because
at the capabilities stage, we don't actually know what the user wants to
send, if anything.  v0 capabilities are too limited in size to declare
per-ref options, although I suppose v2 could, in theory, support that.

I do worry, though, that even if the server may be interested in
additional push options or push certificates, as Chris's series
indicates, it may not generally care about no-op ref updates, and thus,
it may not be granular enough to avoid the kinds of performance problems
that I've mentioned elsewhere in the thread.

For example, I know that GitLab uses push options (and GitHub has
support for them as well in some cases) and thus the proposed feature
would be useful there, but I suspect we'd still want regular no-op
pushes (without push options or push certificates) to not be sent for
performance reasons.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--G8+zj+Jgb7v/BX5S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfOc9QAKCRB8DEliiIei
gd6dAP4onbgj9EnsODzSXq2af0+zxfsWfEqARc1HJS8qPY2K/gD/ZBvU6C1UMh8Q
gbOAAjYP2obPVPXqwVBAKJqrG/GLvw8=
=cwgI
-----END PGP SIGNATURE-----

--G8+zj+Jgb7v/BX5S--
