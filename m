Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7658123A
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988445; cv=none; b=Sfv2vgq49PHPrXMQ1A58Nei1dQ2DlKJtpfM/pgnGNSadRTaJGwzDIAWewm2mfC27teXndASOClDiAJ3NNqE4LtW36k+GRVDzpfuzbfL/AyRSW0zTayPzmmZzcBt5TAJi6SvFhV7ha5J1tQeIGTSObVFnK26iDKH79vtDb15F2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988445; c=relaxed/simple;
	bh=C8p5LCVY65tlarY1q6FNZD7cmZDBb31K4m6jHd4O9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZA5tqXX2rFz+QrNEJ42/9BYlUW3L9AAgOUm6xCkrD0Ung8V7lIlZ0KvhB7882TLNysxSYsqq8DhJN5UOyVUryrMK6G6JJJ2WRjgqKNcDoy//iiyJpHOColLeKTatu0p4BNjlL7fpp4TvbVTeVbHeT9JxyB4dXhQCh0O1zhclVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zsXnVRkj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zsXnVRkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788988431;
	bh=C8p5LCVY65tlarY1q6FNZD7cmZDBb31K4m6jHd4O9y4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zsXnVRkjmqPsWL67Z0iSf89hm49rVwLSMxGj77uLg1kHzkEPr3hUiLgK2BJe+TO7V
	 QKKBkMV7JPkQRWHZ9I+QT/V0WSkyARPHGpt2bCg/5hU03+txNcLN3x+mxyf8G13vJx
	 tFTjx4tpRyW0A5t81xuhb+TY0cvK2Mwkt1ilcTlaJwWRN3jkydtRo3Yaj69GIjkIWD
	 z6QFjOD4gUQVAy0AdtfnZfdy9LbYaMYEiaXGkPmt/3SGWngve1t3EkG32tV6nbwFE6
	 yotHnEtHrTErvO7i1XgP5qLNWskFvU6T6YvCpOohEazdpyZiQrrXeopc88Jh5sZFBl
	 4hjDlcL3HGjUfJumbjFrUnb3WwvYiTU/KtkZbY/MUGsF6VMm8R/+SK3eDY9K5M3grr
	 soBI+Ch7Zi6sQjUfTSS7KmBwbWj0R1a2SN3DyR1BYVNLeWx5QkV97tRIj1lheZje0J
	 h8zJ84mDMO91q9JkTZQF2fmWrxkk34t5KfFhqa4WDvvxzppoOqo
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5ae1:51d4:8a53:5f3d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3581D200A9;
	Wed,  9 Sep 2026 21:13:51 +0000 (UTC)
Date: Wed, 9 Sep 2026 21:13:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v3] Move rust gitcore crate to a different subdirectory
Message-ID: <aqHMDErmQ0BdQlVD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	gitster@pobox.com, ps@pks.im
References: <20260209224847.1416916-1-mh@glandium.org>
 <20260909013858.1729643-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DcTgScj3miVDls+Y"
Content-Disposition: inline
In-Reply-To: <20260909013858.1729643-1-mh@glandium.org>
User-Agent: Mutt/2.4.1 (2026-07-04)

--DcTgScj3miVDls+Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-09 at 01:38:58, Mike Hommey wrote:
> Having `Cargo.toml` at the top-level of the repository implies that one
> can run `cargo build` directly, but this doesn't produce anything useful
> on its own.
>=20
> Additionally, when including the git source as a submodule of a Rust
> project, it prevents the git source from being included at all in the
> crate package because cargo skips directories that contain a Cargo.toml,
> assuming that everything in the directory is relevant to the crate.

So what I understand is that you have a project which has Git as a
submodule and you want to include the Git source code into the crate
package for that project.  In other words, you're vendoring Git to use
its C components, but not its Rust components.

If that's the case, how do you plan that to work in a few releases when
Git 3.0 comes out and the Rust components become mandatory?  If you
don't plan for it to work, wouldn't it be better to adopt a different
strategy now rather than implementing a workaround that will be broken
in a short time?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DcTgScj3miVDls+Y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqhzAwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZwJ4VSCi6rKCZpCEicoR2XGbkCjSWsydXdQjBuzLr7OY
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAXdAP90Wu3CAcn0C/ygOQxK/5eRNNhf
ht8eqOUROUaK4cmMSwD/RoTf3iTgtixxFg0QthzJZF9tybuCb4ffFVHnjnbYxAo=
=Le4+
-----END PGP SIGNATURE-----

--DcTgScj3miVDls+Y--
