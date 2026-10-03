Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057D33998
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790989672; cv=none; b=K0I5+pEYd4rfyq8T12L75Fqp0RglKKf+6WqT5GXtheVaeHU9dd6X4Vl3sN/YPPaaePjR5Br0l0KR87CjGVxVMKWAPT6SPhaYZkqRpwcgj6c2Ir35j4zlPaei70Jhus2IKePHu/ymjimDHyew12NFxPloUJfozLwaVZetUk8snQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790989672; c=relaxed/simple;
	bh=w4wFTTBXJy8bDS+euGr5F74kvKxzTmIBXVbdLWaW+/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP0TiwXtu0y96DAseFE0QVm2qmz+ZwSMzIlfoPqyifr9wyUS+gpGF1XAW3U8AFWIdVnvSfGIqLIWeR3SZS9kTOVzFYzzYrjF/wtuphbJWDth4TAHYGKQNyVeqGM99RX0H2v4PSHk9j6RcKm4P0kEAtSWPgeYs/mJ5STbjShctLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xvS1QfWo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xvS1QfWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790989669;
	bh=w4wFTTBXJy8bDS+euGr5F74kvKxzTmIBXVbdLWaW+/4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xvS1QfWo5gqAHj6MguJMd5sYlQ4p3LXO+8S4t27JehEoqeX4kSchwJ35g0g4iBlqZ
	 taaLVsNjMjqjgzoCy3Cyg7Gun8Evl4TK1aL41YIgScxp1XNtpKvHgFhjacHHqo6DfK
	 gr092HMlP4TraDrTQ1OkiMZb0B7cUIt6sK+gOUlrUT74oWbH1m87uxnjsiglKQm4wm
	 /vpCVQnKHYvcqYumdQ1xPZQfzl1xdTmOKEZ5EnqP/glnINKl8tkGKVTiUNZw/b134v
	 Aj6ijKM0NAE00k7vcdjzxy6ZImE7xPOdlDd1yw1aXLZ3xvSjhXL5+SuTdA0Fw4+dQo
	 2jaQjvxUCFwrjDD09kkjMWBM4OXNJNGxeFzfyXJN6rXrH9pOof7GRvdDEsY5CZShL8
	 eWAbSYRMeUqUL9e7IgxK8rgdfyLnZsgpmG5JItwjE3aNAGas5E1n+AfVrnWSz3UKPx
	 g16ds0vXpACGGQa0fJ+ItPNcHsqFKushk0mUS5mwc+LdyBkyCLN
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7c1:8d15:f288:f856])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9B5EC20075;
	Sat,  3 Oct 2026 01:07:49 +0000 (UTC)
Date: Sat, 3 Oct 2026 01:07:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: a "limbo" object-format state for empty repositories?
Message-ID: <asBVY1WniGUo6bQS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
References: <20261002224400.GA834158@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q+9P0WkMnkP4Keak"
Content-Disposition: inline
In-Reply-To: <20261002224400.GA834158@coredump.intra.peff.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

--q+9P0WkMnkP4Keak
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-02 at 22:44:00, Jeff King wrote:
> It would be nice if the empty repository could adapt to the object
> format used by its first push. Then everything would just work from the
> user's perspective, no matter what they push.

I agree that would be nice.

> So what I'm suggesting instead is that the server be allowed to
> advertise a limbo state: it has no object format yet. And then client
> can recognize object-format=3Dlimbo, and send back "I'm a <sha1|sha256>
> repo, so that's what I'm sending you" in its capabilities response.  And
> then the server receives that and shifts its local object-format to
> match.
>=20
> There are some tricky bits on the server side (e.g., you'd want to flip
> the value atomically so that if you get two simultaneous mismatched
> pushes, one of them gets rejected). But I can't think of any reason that
> it couldn't conceptually work, and I feel like it would save a lot of
> headaches.
>=20
> But I also did just think of this idea, and haven't implemented anything
> (nor do I have immediate plans to). So it might be half-baked. But I
> thought I'd toss it out there and see if any body has thoughts, or feels
> strongly enough to try implementing it.

That is definitely something that could be added, but it's also
incompatible with every existing implementation.  Specifically using the
`object-format=3Dlimbo` approach means that no existing client from 2.29
on will work with the repository since `limbo` is not a valid hash
algorithm.

There is some support for multiple `object-format` directives, but I
don't know how well it works and I seem to remember that we had some
sort of crasher bug in the past.  That would be the best possible way to
advertise that, though, if older versions support it.

There are also going to be some policy decisions, for instance.  Some
organizations will not want to allow one algorithm or the other, so
Git will need some way to allow that behaviour to be expressed.  Or more
likely, Git needs some way to allow the fact that it's in versatile
mode to be expressed and that it's safe to rewrite the config on initial
write into the repository (which, to be clear, need not be a push; it
could also be a commit or add).

All that being said, it's not impossible, but it's also not easy.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--q+9P0WkMnkP4Keak
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrAVWMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2hMyTlzAsNVdoTEvzC2L2H0wk6ihGLtq0KRuxUa1Lbr
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOOKAP9C5NiYnlUO4E039EJOnF7X8MjZ
MFxf5w87DwSpqAhuCQEAzzd3t50m76GpWfU7vZ+Pg5Vf2RR+7Qddz2wFSHH4Dwc=
=7xBu
-----END PGP SIGNATURE-----

--q+9P0WkMnkP4Keak--
