Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE81AA791
	for <git@vger.kernel.org>; Mon, 12 May 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087494; cv=none; b=QAzAOR7iipL9lbvOMnVz3IeZS+0nmvjto/YgFXEldiiIQTCLGPlO75b1KAJuXFJV9yS14YyxPWHmIpGLEtGpl4bA1c+H3jof4WqUZG+fY4p+yFBoZWdoGX+xG/0E2ECEOS8i0BWAvJb2XspSHc1myApLhHKZNhXsdTbx1/3IKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087494; c=relaxed/simple;
	bh=OXNyTGYUnTUdhczFZ4Ubz9Sv/ppTv4tUr5siN27/XTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd1ZaYljn+4mEjpHdagF3wZcQGp7nOos7hYFkuCEZ7TjB8UctuK75N5O3aY2JE3v/p/moiUREWajt1fWdag+hb/tHaWROREqTYD/qhVVJAVgNqQl64I3Mgn9oGt/XkT5e1fUrUA+eSXAwB33jVJqbJqYuJ7vjQXw3EtVX3sE9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hZQMU9Gh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hZQMU9Gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747087490;
	bh=OXNyTGYUnTUdhczFZ4Ubz9Sv/ppTv4tUr5siN27/XTw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hZQMU9GhXkGYWFPM4LIsy/uH7o+ICENWTJ+d7ZV8NCkNONH2qs9YiYpgzPQ/K4Auj
	 cDbgCX60TN+oKhdgS1d/1+Z5DKp/jQco4vu0jUUwgjilxmFX9giJAoRupeeg5Ddxq0
	 o1v3Gj7tR2Ud8h+ODLxQkIaV7BrESdxk+ruPg/VVDHPG1XsNdJVVW8lx8X1kcdzsOG
	 bMI9675DKmIazd3k6yjwQSmvfkiVicyeAB3eyCNehX9zWT9/ms/VkJ+39XPcJycokd
	 85S4vfqes9Jk99YWALwTziWgkV15tkTM7+kHZe8kKsdKRKGdEiZdu5UfzVLd4l4gSI
	 8VnwPXofiKY7bD12E3Ie2pREOVvoV2f2R6k/+ckWswxBbidasZbi66WByAhgK2KU6J
	 yuVnporuHSKS815ag0/e9yKPvkCT8KDRSfy/yEz/8M/kKR8pFJOUIUJ6Chv5yEmk0+
	 L+ay+OWom6NPNOyXDJ2OhQKEMCNAlolkZJ4b2nMj7i7TBq0HUDg
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C6E4D2010F;
	Mon, 12 May 2025 22:04:50 +0000 (UTC)
Date: Mon, 12 May 2025 22:04:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Nico Williams <nico@cryptonector.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Remo Senekowitsch <remo@buenzli.dev>, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aCJwgWaNoBVjvImJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Nico Williams <nico@cryptonector.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Remo Senekowitsch <remo@buenzli.dev>, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
References: <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby>
 <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
 <CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
 <CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
 <aCJi+4q6DZhnfdy+@ubby>
 <CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+AybEXP+6e+vGLi"
Content-Disposition: inline
In-Reply-To: <CAESOdVD_Cse6AjwLb-4QKjdo4ESWwF3FzSS5JaHbE6ZrMjFeZw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--w+AybEXP+6e+vGLi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-12 at 21:43:46, Martin von Zweigbergk wrote:
> On Mon, 12 May 2025 at 14:07, Nico Williams <nico@cryptonector.com> wrote:
> >
> > How is this stable ID constructed?
>=20
> It's just random bytes (16 when using the Git backend, 32 in the
> Google backend).
>=20
> > How would things other than jj construct these?  We spent many messages
> > trying to work that out and in my estimate that wasn't settled.
>=20
> Random bytes has worked well for jj.

I would like to suggest that we use a deterministic approach.  People
rely on Git commits being deterministic, including in my stash
import/export series[0].  In addition, it's important to avoid any
allegations of side channels or leaking information in commits, which
would be a concern in many environments and which a deterministic
approach would avoid[1].

I'd suggest a simple SHA-256 hash of the original commit data (for both
SHA-1 and SHA-256 commits, but one that would change to a new hash if we
added one) or an HMAC-SHA-256 with a fixed and documented key.

I would also recommend a config option to avoid creating these IDs for
those who don't want them included for privacy reasons.  I expect to set
such an option, for instance.

[0] That series will definitely require that they be disabled when
creating commits, since the goal is to ensure bit-for-bit
reproducibility between different Git versions so that users can
immediately tell if the stash history is identical.

[1] For instance, it's an easy way to leak keys or other credentials
without people noticing just by pushing an innocuous-looking commit.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--w+AybEXP+6e+vGLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgicIAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5juTIJl7cNbbuR8X7Nr0Mmxj64urZk7+e3aDUj8OY2E
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJqKAQCcZuNntbXaW+j9mI2ZFm2X4v72
ams4AoG8NTggOk7wYQD/c6N1Ntt8lm6MJHmGs0Ubj4QNdgUpENdRoZDa6MMlEAI=
=+iQG
-----END PGP SIGNATURE-----

--w+AybEXP+6e+vGLi--
