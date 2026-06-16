Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D6319871
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645491; cv=none; b=A9Rpvz6YV7feZwini1Fz1BA+/zi8j9e/QJtG+0866OtggJpNTSkTL8Hl3bySiVxRVQutTlK1oN4h8tYq/4zvRLaKwkTSLKEUIESr7Ix97JJmY3ax2Rsg2+8gf/frYhICTvpBzdSPSX8YQMuIBOffejAW3I08t5oJtjo/ZMmNz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645491; c=relaxed/simple;
	bh=JOGfjYaqsBbBuEGP/0Dde07rZpdFNqbcPT1EK5YAU48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZR4EzcuK4l5F3xMG4+v9s032PpcAbDmUdfmYrSvpAB4dY4d1da/LmuOS/33o6d4EHQTtCrjdkiKZXQdAkqUmwKjQmuMIpBF5+cIw0PNQbwLKN+b9NGhOnIDW6j4+GLWnlaaBjWGzLdjp3jvI1RHJH6t5jBOCp2DRcpWjEjAViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=m5ccfRQr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m5ccfRQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1781645488;
	bh=JOGfjYaqsBbBuEGP/0Dde07rZpdFNqbcPT1EK5YAU48=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=m5ccfRQrapS4thdk9DCwatIa0DjczWq82SacG/BUVati9G9Rsb91Ulk5ByGdsBsn8
	 jKqxFlR7Bo2MkP9svJCU+vEf29sfD9DVKfcMb5skGulqXajmcxvHC0w06rjk4qMu8R
	 rEbn7F4iotmB/WFqVYv65ubYq23/uaZdYz0XE6uDH+kVxk3R2iG96K6y5LBsvQhX17
	 +IF3Vx9caT/xX/C9JZGUb2DjY5YdAetLDDATPaAoP2OEDMbp1TqciDLLPhj+x3Bpd3
	 V1aDdarQezbXDbiooXIwS4R9YljhFdmVPXTFFETYgt55LOxt2Q60G7yEJuQD9gwJmK
	 ptXC14As7VDrSQ7D2fPVl9utHNsAva7jFRi0QPDV3PGFagc1HFrEHoYCB6TJoqXI1m
	 H6xJ4z4NuZxebnNpj7CoXGE7d1jP1IifFiKvUuPsme+PaMBhQgBa94sFipy61Yla4r
	 LsMRQh4+IL1kbXdruXNQ6aCzf5JQLG1Xkk/v1IY5nZHe8DIzx25
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:daa9:328a:5833:a04f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4B1C7200AF;
	Tue, 16 Jun 2026 21:31:28 +0000 (UTC)
Date: Tue, 16 Jun 2026 21:31:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: SHA-1/SHA-256 interoperability work is functional
Message-ID: <ajHAr5XL3Tzery7J@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <ajCWBG9RHBrm8jMZ@fruit.crustytoothpaste.net>
 <xmqqldce2r1a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z7Eq2ElxbtnInJAP"
Content-Disposition: inline
In-Reply-To: <xmqqldce2r1a.fsf@gitster.g>
User-Agent: Mutt/2.3.2 (2026-04-26)


--Z7Eq2ElxbtnInJAP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-16 at 20:01:37, Junio C Hamano wrote:
> Not that I specifically care about packfile URI, but this one is
> curious.  How would regular "fetch" and "push" traffic work under
> the new world order?  Presumably we will keep one characteristic of
> the protocol, that the packdata stream is the only thing that is
> given to the other side and no object names are given, because the
> receiving end would not want to blindly trust the object name the
> sending end _claims_ to have sent and instead recomputes the object
> name out of the packed objects in the data stream ("if we rehash
> and recompute the object names from the datastream, the other side
> cannot lie to us" IIRC was a security measure).
>=20
> For a regular "fetch" and "push" to work, we would need to recompute
> the native object names and also somehow compute the compatibility
> object names if we are in interoperability mode, no?
>=20
> If we download *.pack files from a packfile URI, wouldn't it be the
> same story?

Let me explain how conversion works.  Say you have an empty local
repository with SHA-256 as the main algorithm and SHA-1 as the
compatibility algorithm, plus a SHA-1 remote.  When you do `git fetch`,
you get a SHA-1 pack.  You cannot write this into the repository because
your repository doesn't use SHA-1 as the main algorithm, so `git
index-pack` takes the pack and maps any objects.  If the objects are in
the new pack, they get rewritten based on the dependencies; otherwise,
Git uses the existing maps in the repository to rewrite the objects.
`git index-pack` then writes a completely new SHA-256 pack with an index
containing the SHA-1 mapping, using the corresponding deltas[0].

However, `git index-pack` can only index and map objects for one pack at
a time.  We therefore need any pack that we get to be connected to our
existing history so that we can rely on our existing maps to remap
objects that are not in the pack.  For instance, if we get a commit
without its parents, then we'll simply die because those objects cannot
be mapped and we can't write the mapping in the index.

The problem is that that packfile URIs result in multiple packs (one of
which is the dynamically generated protocol pack) that, _in total_,
provide a complete history with what we have, but are not necessarily
individually connected to our existing history.  Moreover, the
dynamically generated protocol pack is sent _first_, so if we have
packfile URIs, that pack is almost certainly guaranteed _not_ to connect
to our existing history.  We would therefore have to pause index-pack,
download all the packfile URIs, index those packfiles (which would have
to be connected to our history), and then unpause index-pack to rewrite
the history.  This is not impossible, but it's tricky, and it has yet to
be implemented.  Someone may decide that this is a valuable feature and
implement it, but it's not on my to-do list.

This doesn't pose a problem with single-algorithm repositories because
if you have unreferenced and unconnected objects, no big deal.  They
just don't get used and will eventually get GC'd.  But since we can't
map those objects in a multi-algorithm world, that's fatal and those
packs can't be indexed.

> > * Large object promisors cannot be used if the server does not actually=
 have
> > 	the entire history, since the server must have a complete history in o=
rder to
> > 	provide object mappings.
>=20
> Again, this one worries me a bit, but perhaps I am not reading it
> correctly.  Does this mean that the server side says "this is the
> data for object whose name is X in the SHA-1 world, which translates
> to X256 in the SHA-256 world", the receiving end blindly trusts
> without having a way to verify?

The server provides algorithm mappings for for submodules, shallow
clones, and partial clones.  For shallow clones and partial clones, you
have to trust the server anyway because you're already getting a
truncated history.  If you complete the history by fetching the missing
objects and run `git fsck`, then it will detect if the mapping is
invalid because the server was dishonest and complain.  You will have a
corrupt set of mappings to the compatibility algorithm, but those could
theoretically be repaired.

However, in order for the server to produce those mappings, it has to
know the entire history.  If there are objects that are outside the
repository in a secondary location, the server will not have mappings
for those objects and so it will abort the protocol.

The server does not normally provide mappings for non-submodules if
you're doing a regular fetch or clone, since the client has a
self-contained history and does not need those objects to compute the
mapping.  That means that regular clones and fetches work just fine
against existing servers as long as no submodules are involved[1].

The tricky part is submodules.  Because the data is in a separate
repository, we cannot be certain of the mapping.  The documentation says
this:

  There is a potential security problem with providing mappings of
  submodules over the protocol.  Namely, there is no way to guarantee
  that the SHA-1 object ID and the SHA-256 object ID correspond to the
  same commit.  This means that, for example, a malicious server could
  provide a SHA-256 object ID for a submodule that was up to date with
  all security fixes, but map that to a SHA-1 object ID for an older
  commit with security problems.

We therefore reject submodule mappings if fsck verification for
transferred objects is enabled unless the user has explicitly enabled
submodule mappings.

[0] If A deltas against B in SHA-1, then when those are rewritten into
SHA-256, we delta the SHA-256 A against the SHA-256 B.  This does not
guarantee the best possible delta, but it is much cheaper than
redeltifying and because we expect remapped objects to have the same
shape, it should delta well enough in most cases.
[1] For instance, if you build my branch, you can do
`git clone --object-format=3Dsha256:sha1 https://github.com/bk2204/lawn.git`
and it just works since there are no submodules.  My dotfiles, on the
other hand, have submodules and will not work without protocol support.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Z7Eq2ElxbtnInJAP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoxwK4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ98QLIR0oYFXXLy/visqb53r5tJypnusoJ2xezdGYLn7
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKRNAQDTkyA9Q4BcU4Mj7zjc1nzhZ265
p8Pu0mnHVyvnLV/FkwEA70Nzcf6k2sFLKUb2ZHIHsmGHgdVPOR4JKYTDjjaHeQo=
=iGCC
-----END PGP SIGNATURE-----

--Z7Eq2ElxbtnInJAP--
