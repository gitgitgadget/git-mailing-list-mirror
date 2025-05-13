Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39578F58
	for <git@vger.kernel.org>; Tue, 13 May 2025 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095221; cv=none; b=rbFHYDzKXsTZqJzKpYf3T7chaziqtnkkn4FPvmPCxMBial5WqsUSqLBpMzIKB8ZZMN7oxL0CIjSpHhwsCn40K/H2oqdWp+N10tegCFbZ6Pl9+vDN7UjgFv5zxMrjeYE6tf1vrV0ZqQRy5eYIckCG5+GVsw+cj3MR2IEmqJUMvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095221; c=relaxed/simple;
	bh=T5ITu13ue+gEwGu3RMhOahiXIUeyQMKI+BXceCNwu2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1EdEcnn57DmRPhSobPv+KN09Zr1SQa01UptWfhRF1DfeQBKTlzVglxMGzbh3Z5Z8+9ih6DKHYcgejEPsplFHVV9bMMQhrEpqZB/bZoMQYeBhl2DF/m02ND4ydKtpcNF+lVCReKdNYNqoItB3Cqw+9oB7WwIKfEOhYr+ga0/rUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oXYYuzlr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oXYYuzlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747095211;
	bh=T5ITu13ue+gEwGu3RMhOahiXIUeyQMKI+BXceCNwu2E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=oXYYuzlrb4zC1MZVTvLgpHKaQYBYDOzzoGhOvrSHJ5ScYxBo1436wgUitppDsUkNt
	 gMRLC0FWLRJWH7q7G5nGq89m1epnhpnDhFjFtsh2v2RodXsQQqj4ODdXUCHQVrzrCy
	 yDpq0JqpwYdgiYs2EmviGDgdG3l3KiXvluZXS8ZvNc3xYjwdHDsD4pfEpHyvuCFnFf
	 LwANZNQtqJkt9fvKYZ6YVC2DBZdyvFMd+TBg5OxxhbL0C7VoexeVLZuKil0y91vlBH
	 TSBFQ6XjhRlMBqGPRdH0MyW0dkinzS/PIKAOwTP0CYR/CaDj0EyiIjYgOoweg8GEEA
	 Jk2NnvntrE89zoAj8Ks/hXXq/0YtWkSqvCcYgJavM+4ed7lJHzN8wEeTqPC3LuZLUJ
	 DfuzXWIBZvoRXCmDG39fPTHeTMSfSaC+RNQ2VkTA7yGY7wHBJOyytFVYM49uN8CrkA
	 qphbsBA/q40q3vo9vVcGQ1li837LZsKQ9A9qZ3getN6OR6l89KM
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E50BB200BA;
	Tue, 13 May 2025 00:13:31 +0000 (UTC)
Date: Tue, 13 May 2025 00:13:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
Message-ID: <aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
 <aBhZHA7av8bWH9Ac@pks.im>
 <xmqq5xieq3fs.fsf@gitster.g>
 <aBmg1_wlF2fuk96M@pks.im>
 <20250512135017.GC1191957@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OMzurJfV7WosbJki"
Content-Disposition: inline
In-Reply-To: <20250512135017.GC1191957@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OMzurJfV7WosbJki
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-12 at 13:50:17, Jeff King wrote:
> On Tue, May 06, 2025 at 07:40:39AM +0200, Patrick Steinhardt wrote:
>=20
> > Other than that we also have some bits and pieces that _are_ actively
> > maintained, but that just don't have a better place to live:
> >=20
> > [...]
> >   - Diff-highlight.
> >   - git-jump.
>=20
> These two are due to me. I don't have a problem moving them into their
> own projects if we want to clean out contrib.
>=20
> I think diff-highlight is something that _should_ eventually happen
> inside git-diff itself (because it would be more efficient and we could
> do a better job). But it wouldn't share any implementation with what's
> in contrib/.

I think there are definitely users of diff-highlight.  I remember seeing
a reference to it recently and not realizing it was in contrib, but it
is actually used by others.  I don't use it myself, though.

> >   - Credential helpers.
>=20
> These ones are tricky. In theory they could be spun off into their own
> projects, and we already have examples in the wild of things like GCM
> which are maintained totally separately.
>=20
> But I think we may need to find people to step up as maintainers. In
> particular, I think osxkeychain is probably used by a lot of people, and
> probably shouldn't just go away. But I don't know how the maintainer
> would be. I wrote it originally, but don't (and never did) use it
> myself, or even have access to a macOS machine.

These are often shipped by distributors.  Apple ships osxkeychain, as
does Homebrew.  Many Linux distros ship libsecret and it's the
recommended choice for desktop Linux.

wincred, while not super popular, is still used and is smaller and
lighter than GCM.  It doesn't actually look like GCM is seeing a great
deal of maintenance either at this point, so I'd say they're about
equally well maintained.  Since I don't use Windows, I don't know if
there are other usecases (such as noninteractive uses) that are better
supported by wincred, but I'd recommend keeping it.

I definitely want us to keep these somewhere since they are quite
commonly used (even wincred) and getting rid of them will break a lot of
people and leave them without a secure credential storage option.  We
could promote them to the main repository and simply build them with a
Makefile knob (or by default on the appropriate platform) and in CI, in
which case we'd at least know they build.

I'm not volunteering to be _the_ maintainer for libsecret, but I will
definitely contribute to making it work since I use it.  This is much
like I am not _the_ maintainer for making Git work with Kerberos, but I
do certainly often fix it should it break.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--OMzurJfV7WosbJki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgijqkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxOmB4iIPtyPfBUG4fTsftspmmxR8fzK9CFFp9Crv69K
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAF1FAQDznXO8ix+qU4w4+o0Qa7+4dEOr
AMe9y683G53HIdMt1gD+Ox8ueT1vCqHKn+KwOwP6b7kGW5IrARWPkAA4sQQYRAw=
=4Hds
-----END PGP SIGNATURE-----

--OMzurJfV7WosbJki--
