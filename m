Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256619F
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710463180; cv=none; b=BcULGu1y4pzbU2FvLhKYjEY7kcuMGfilhuxUgKIwkv60TPFPuT4fltlAm39E64FhM35czXfnyKn3fHqepGJCXlzQ1NFXRNev+lZ9SuwRy9MBF2iiXKpouxmcCgsfTJfoSHgwDw6EZSiaDK74K8HFo6RmU19ZocVXQmlTRA/Ye0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710463180; c=relaxed/simple;
	bh=XNZfz04rlH5IF9tgc9A0Ng8WLSfV++kIRTO+4ca4OpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAkzqMSsEBlqtWnOhHRIicPcQpe5p1/TQV73Lbaq8h42ANy/K4BrPyazQjt6ZcJLzvQnkv7gya7c70SE7iVY6Li4TBZWUTxRdZ1wUS+Tyn7O9qQVRXEqXUUkdggDkCpOWsD+9mV1baFC0wQUAiEwVc6bA+Iv/xqINYHbKIfcVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JKPHHWFe; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JKPHHWFe"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 39AD85B3DC;
	Fri, 15 Mar 2024 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710463176;
	bh=XNZfz04rlH5IF9tgc9A0Ng8WLSfV++kIRTO+4ca4OpU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JKPHHWFebmYFm+O3z47WDB7a5BD+bW5yPls4ibtc4DjCvDUt1HVM5kR0P7EYrXpBo
	 nygLt5r/OfWVsPynHkMreFGI/sBQ4RB7s9Ixlu+It5NwLONegxSsucButFYofjb939
	 6he4bad83u8g6xUDciPuKJI2HfX7TGuJ9rIfFMJo25yrwa8HQfz3fXBLc18uiLNs2G
	 FltWehYdmcadaxfV5/o1CbihDb0YJDOmR+SPe/GNuVjwDJiNhP3jcNMkNsmUGfOeGz
	 GCpruQTw7PmhLxWu1bPqzxVfK0gBqtEPmT3bSMAiqISqRWCyHXDGtQOyoZyXL4G2U6
	 Gk5y6wZaZd0qMBsm7aw0/iMGV4xnGArdZmklMCsDjDNnh4rRzYDBh8uO9zwp4+BdGg
	 su0TcFvndplgqe5ItlRAk8OcpCSbj092qKSWVRxHyJZfpDOx1PyzTU9eqjoPGXBaCw
	 BH7LXkSpmKrixKGAqPa+wCJ8pa37zxfHEp9DgFuDtOXDfvhzbkQ
Date: Fri, 15 Mar 2024 00:39:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christopher Lindee <christopher.lindee@webpros.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Message-ID: <ZfOYxnRHwyFdU4Y3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christopher Lindee <christopher.lindee@webpros.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g>
 <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
 <xmqqv85otmsb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wd3rYW72UQQSXmTt"
Content-Disposition: inline
In-Reply-To: <xmqqv85otmsb.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--wd3rYW72UQQSXmTt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-14 at 23:29:40, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >> A radical counter-proposal for the design is to update the client
> >> side to do this unconditionally, without needing any new option.
> >
> > I'm not sure that would be a great idea.
>=20
> Thanks.  I was looking for a push-back ;-)
>=20
> > Since it's a push, that will
> > trigger authentication, which may prompt the user (e.g., for a password
> > or token or for a YubiKey touch with FIDO2 SSH) and which they might be
> > able to easily avoid.
>=20
> Do you mean we first go unauthenticated to find out what commits are
> at the tip of refs at the destination repository, and then switch to
> authenticated push after we find out there is something that is
> worth pushing?  I somehow thought we need an authenticated access
> only for the initial ls-refs exchange.

It depends on the server and the protocol.  Protocol v0 allows
unauthenticated ref exchange, and then the push itself can be
authenticated.  It is customary to require authentication on both
pieces, but not mandatory.

> > As a server operator, I also expect that there
> > are people doing lots of needless attempts at pushing in automated
> > systems (because with enough users, there will be at least some who do
> > bizarre or inefficient things), and I would prefer to avoid serving
> > those requests if I don't need to.  (For example, for us, reference
> > updates need to go through a distributed commit protocol to update
> > multiple replicas of the repository, and if there's no ref updates, then
> > we cut out multiple services which we don't need to contact.)
>=20
> Yes, but if you have an extra no-op ref update in the bunch, that
> one is excluded from the set of changes to be synchronised across
> replicas, no?

As I said, we can't do that, because we have to verify that the old
value is correct.  Even if we did perform that optimization, once we
know we have a write, we have to contact every replica (in case the user
does indeed send us a pack, which is allowed by the protocol, even if
bizarre), whereas with a ref request or a read, we can satisfy that with
a single read replica.  I'm sure I can satisfy at least one to two
orders of magnitude more no-op push attempts with the current
optimization than I could if we didn't have it.  It might even be to the
point of three or more orders of magnitude.  (My guess is that reftable
will improve this even further, but I haven't yet measured.)

I'm sure this is also true for most other implementations; serving
reads, like ls-refs, are almost always substantially cheaper than writes
and most server implementations are highly optimized for serving large
numbers of reads due to CI farms and such.

> > Note also that no-op ref updates cannot be simply omitted on the server
> > side because we need to verify that the old value for the ref is
> > correct, or we need to reject the operation as out of date.
>=20
> Yes, but isn't that something the user would rather want to find out
> earlier rather than later?  Your push without no-op update may say
> "ah, we are up to date" when we are behind or worse diverged.  If we
> do the no-op update more often, we'd have more chance to catch such
> a situation where the worldview the end-user's repository has is out
> of sync with reality.

Well, we were up to date at the time the ls-refs operation completed, or
the push wouldn't have the same old and new OIDs.  The client has to
declare the old ref value that it got from the ls-refs output in order
for the operation to succeed, since the server-side Git won't update the
references if the old value doesn't match.  (This is how the client
knows whether a push is a fast-forward or not: it computes it, and if
the remote side has an unknown value, then it's not.)  Other than
updating the push options, there's no functional benefit to making a
second request, since the ls-refs output already told us where the
branch is.  That's why the current optimization is functionally correct.

In any event, there are alternate implementations of the Git protocol
which did not implement our current optimization and did, for purposes
of mirroring, make excessive numbers of no-op requests, and we did have
to ask for that to be fixed.  I assure you, the no-op behaviour is
better for users because it's faster and substantially more likely to
succeed (because it is effectively a read-only ls-refs request), whereas
a new ref update is less efficient, slower, and substantially more
likely to fail (due to functional limitations on write throughput).

I also expect there will be poorly written `pre-push` and `pre-receive`
hooks which will not like getting a no-op update and not handle it
gracefully.  I'm pretty sure Git LFS will handle this just fine, but
lots of people have various shell scripts that probably will not.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--wd3rYW72UQQSXmTt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfOYxgAKCRB8DEliiIei
gcj0AQDKpejBcFiU9r9RzyoXP1FQ0OQPhOjpzRm8wfsoUcJwYAEA9XkFZTC2ZM2b
qUGq0uJxInRcMfdtY9bf2C0/NhXA+gc=
=FvOq
-----END PGP SIGNATURE-----

--wd3rYW72UQQSXmTt--
