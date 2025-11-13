Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D82D3A72
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075751; cv=none; b=f6HV+l+wVNCONlzPCRM2Ckf1gw8Gj1KSJqHApy8TVWMBId9YF45Cy3ETPgj+NVWV5+CeFLVcwimjDD6dy3coElYMDNPi/77FEX+aABVTJ+sPV9TWaWh0YNKJ5XdwW/VCGMxfU7JEJ+IJ8Bb5+bTLKni8sSqNnMnrxPG22szJdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075751; c=relaxed/simple;
	bh=R2wqUj/MPzgxCtfvuEROy3epbUx8n/6RnHrlOHfQAe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC/WOUkgMz7M7kWKUyx/EJvAIjfS85xLpqlCDAxBRZSyrmJMlkDDS9KCaNfxLcY41uRLdSRe39HiyFD/l96b4g18h1tGOuNZemsd7vEZjOTG7fCZpATXusKTbWym5hxa1i41IsJomhhcbnxSUbsKwqlK+f4XOy1iXvPVwLsdQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0Eaec5Cm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0Eaec5Cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763075746;
	bh=R2wqUj/MPzgxCtfvuEROy3epbUx8n/6RnHrlOHfQAe0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0Eaec5Cm+giPHPpQQkzBHwN69+YOeGF7s/NbiKZfZizhp7C8N50sOnvb351kSTspM
	 VgfTtMVY/gXo58o7exM/7cy6a+ZT6/zziRDaTfIXMJWHjk02QtxKIIIkpNAl/usyM5
	 9ORJz+/t+XO/ZLAbIXYGQdPvTuEIgEKLSYEUDG4UwA4Q8KnKlxnqWmZG72bSXtkTCV
	 Mno1I06VGBcQ5IOAzqO4bjJ9KBZ6+QhZum7z1xLM7kNEVaYTspaouz6T03m0wJ0pLa
	 mvK/9zASU7WcM7nkR46dsItDAX7zXZBDVSLMEFfeWpK4+rlEs9raG8xPo8mHJ9nfkt
	 EQ9dR+s45Ft8Ark7V3QeK3YOWlXk1r6vLX0k7SUW8yDl4MCdgkP/mzwmbyNivs0ClV
	 xNbFtV3MGRY7FlTGVdvkc6+tsubTdRwraVUe4W9+0BblENILfBez+T0xhqO7Nlamm7
	 BrwFUYkKvj6GhHarmY1F+nK5qF+0fGW4zf2NRc/lCFAhN6PThnG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:663d:867d:4eb4:3b8a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 34AE420065;
	Thu, 13 Nov 2025 23:15:46 +0000 (UTC)
Date: Thu, 13 Nov 2025 23:15:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Wilck <mwilck@suse.com>, Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH] object-file: disallow adding submodules of different
 hash algo
Message-ID: <aRZmoAI_RjkRgB8l@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Martin Wilck <mwilck@suse.com>,
	Adrian Schroeter <adrian@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <20251112235434.1499699-1-sandals@crustytoothpaste.net>
 <20251113032619.GA1739649@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7V/QX/5/76Ey13j"
Content-Disposition: inline
In-Reply-To: <20251113032619.GA1739649@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--x7V/QX/5/76Ey13j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-13 at 03:26:19, Jeff King wrote:
> This makes sense. I had meant to follow up on our conversation and patch
> from last month, but it was still on my todo list. Fortunately that
> earlier attempt gives me something concrete to compare to. ;)

That's why I CC'd you.  I hadn't seen your patch and wasn't sure if I'd
missed it or not.  I wanted to avoid us doing duplicate work.

> OK, you're checking for it here in index_path(), whereas my earlier
> attempt did it in add_to_index(). For the most part, I think your spot
> makes more sense, as it is at a lower level. add_to_index() eventually
> calls into index_path(), and so do some other code paths.

Yeah, I was hoping to catch any code path someone might use that updated
the index by path and this seemed like the most likely candidate.  I
think we'd be okay for `git update-index` or other things that update by
hash because they always interpret the object ID as the main algorithm.

> That does leave two interesting oddities:
>=20
>   1. In add_to_index(), we have this code:
>=20
>           if (S_ISDIR(st_mode)) {
>                   if (repo_resolve_gitlink_ref(the_repository, path, "HEA=
D", &oid) < 0)
>                           return error(_("'%s' does not have a commit che=
cked out"), path);
>                   while (namelen && path[namelen-1] =3D=3D '/')
>                           namelen--;
>           }
>=20
>      which is run before we hit index_path(). So it may get an oid
>      result with an unexpected hash. I think that's OK, because nobody
>      ever looks at it (which would be a lot more obvious if we declared
>      the variable inside the conditional block here).
>=20
>      This whole lookup does feel a little funny and redundant. It comes
>      from f937bc2f86 (add: error appropriately on repository with no
>      commits, 2019-04-09), and the main goal is making the error message
>      better. But should we just improve the error message from
>      index_path() for this case (in which case the resolve call above go
>      away)?
>=20
>      I think this is mostly orthogonal to your patch and we can ignore
>      it for now. I only bring it up because now it's weird that we are
>      trying to catch the hash mismatch, but have this unchecked extra
>      resolve.

Yeah, I think we can.  I may have touched this case in my interop
series, but I think it's just to add another parameter to the function.
I don't recall anything super interesting about this in terms of hash
interoperability here.

>   2. There are paths in add_to_index() that _don't_ hit index_path(). In
>      particular, intent-to-add entries. So with your patch, even though
>      a regular "git add" is forbidden:
>=20
>        $ git add repo
>        error: cannot add a submodule of a different hash algorithm
>        error: unable to index file 'repo'
>        fatal: updating files failed
>=20
>      I can still do this:
>=20
>        $ git add -N repo
>        warning: adding embedded git repository: repo
>        $ git ls-files -s
>        160000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	repo
>=20
>      which skips the hash check entirely. Which kind of makes sense,
>      because the resulting index entry does not have a real oid in it at
>      all (it gets the empty blob oid). But it does have a real 160000
>      mode.

Right.  I at first tried to add the check there and the I realized it
was actually storing the empty blob OID and thus the hash algorithm
would never mismatch.

>      Can we make things worse from there? If we try to update it, for
>      example, that will fail:
>=20
>        $ git add -u
>        error: cannot add a submodule of a different hash algorithm
>        error: unable to index file 'repo'
>        fatal: updating files failed
>=20
>      So...maybe this is OK?

I think it is, or at least it's the best we can do.  If you do a commit
with the empty blob OID as your submodule, you already have a corrupt
repository, so catching it later on when you do `git add` or `git
update-index` should be okay.

> Makes sense. Purists might complain about "git ls-files" on the left
> hand side of a pipe, but I think it is OK here. Though you can golf away
> a few subprocesses at the same time with:

I stole that line from elsewhere in t3700 and modified it.  I agree that
it is maybe not the ideal style for our codebase, but I did appreciate
the elegance of doing the operation in a single line.

> Is it worth checking the stderr of the failing "git add submodule" call?
> Adding a repo directly via "git add" is already something we generate a
> warning for, and it's possible we might eventually make it an error. In
> which case the command would fail without even hitting your new code,
> but we'd have no idea. Adding in a test_grep for "cannot add a submodule
> of a different hash algorithm" would at least make sure we're hitting
> the error we expect.

I can do a v2 with those changes.  I will say that I also added changes
for `git submodule add`, which would catch the problem you mentioned,
because I thought that was the code most likely to have a different
implementation at some point in the future and I wanted to catch that
and also anybody doing the sensible thing in terms of adding submodules.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--x7V/QX/5/76Ey13j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRZmoAAKCRB8DEliiIei
gQx8AP0d7NB+eR7YbOcTssPbVA4hWhs2FXb4nvRl6je/FMQhvAD8CkQs+T9qzNk2
YrcUlyefHTJQVceIDZP9gxw75XQ6RAU=
=wfoK
-----END PGP SIGNATURE-----

--x7V/QX/5/76Ey13j--
