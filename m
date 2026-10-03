Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430B233924
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037357; cv=none; b=TFUUoFvpPJwbViGCrQQ5K2H4R1nU3lp8ersRiYJ0s9FkNDUCp0f+ywEveMM3Mdkyf6WmW+saFZPu+60xBp1alcWAwzx/4QKMB7e9gmXGbVo4GdohavWp69uwUPE0LrOZ8KvGyXRQDJW+XuwH06c2D8vOeVImo/POWS984cBmNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037357; c=relaxed/simple;
	bh=Xm3XsFR6LN5E9Qe6h8JqrcfBEIBXBuExGDm5ybF4voI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlKfgKxTsjOg3OY1zn3lxO0i0p2HryEUvkpfksJ6TVmxqhM+qaIV+f5B7dj9pdZrlJGMDKv9wsczySgiTLmF6uSLxr+mVuvBJjdJ0wJMFjJLXBS+A7fOsfTc0TXMMighNnpkLr+r7RcJASOwfi0gYfRpsXlIZ1vRllZNc6GDO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Cg34cq3b; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Cg34cq3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791037353;
	bh=Xm3XsFR6LN5E9Qe6h8JqrcfBEIBXBuExGDm5ybF4voI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Cg34cq3bBcXe3N1RCVwgm86ncwsl8q7ZsBYmfAcrHw932lVA+pGefyR1BqsKJ5FTN
	 Bj8x6qMHJ1lKKptdTQ4grQIVF8qVozG/4y/6salDLfUW6XTrqdqDpX2ar0AqfbhwWc
	 gaXNIMWFIuwp9QeNH4GGjZuq8yGJJdLvrParVib9rxEG/ChEZDGWfRaywZWi/tbWIS
	 K+tAhbq/bDln/yJNTjCBJmg4AiTl0N/gbUcuoPB4idpRhSx5kO+Gp1WAEQmKZlZfjl
	 LSHcWio+Qg90DVXt/+F5xksyTJg/QcuxuJT01451WeGOp8F6cLeD3YPwcQzw0Te31Z
	 l271VvDMErnCE2zmzzldQKen6C5RRWtwrN2NUzjGy+2o8QwShzmn3MWuP+4w4CbrMe
	 xSxtbGckOgGANr7mnqjCw6VTiFWRSwKP8H4HV2K04eUXmePFueSUON0GeffE7cecuD
	 wFlZo6vUthm5KUIKicdgGlGzA4FjR4xgoJKCzOcIjMfiA06B+rF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7c1:8d15:f288:f856])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CBFAF20075;
	Sat,  3 Oct 2026 14:22:33 +0000 (UTC)
Date: Sat, 3 Oct 2026 14:22:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: a "limbo" object-format state for empty repositories?
Message-ID: <asEPp6Bg3xDpA4e1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
References: <20261002224400.GA834158@coredump.intra.peff.net>
 <asBVY1WniGUo6bQS@fruit.crustytoothpaste.net>
 <20261003012512.GA1324483@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVAz6Ta4I8OnYBVD"
Content-Disposition: inline
In-Reply-To: <20261003012512.GA1324483@coredump.intra.peff.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

--iVAz6Ta4I8OnYBVD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-03 at 01:25:12, Jeff King wrote:
> Yeah, that is a problem. It breaks older clients (that are at least new
> enough to understand object-format=3D) worse than a mismatched format
> does. I was thinking we could solve that with a new capability, let's
> call it "magic-limbo" for a moment. Older versions would ignore it.
>=20
> But then what do we put in the object-format=3D field? We have to put
> _something_ valid, as even if we put nothing that is an implicit choice
> of sha1.
>=20
> So I think the best we can do is advertise magic-limbo, and then new
> limbo-aware clients can always do the right thing. Clients which are new
> enough to understand object-format but don't understand limbo will use
> the server's object-format unconditionally. So the choice there does
> still matter. But if we don't switch to sha256-by-default until
> magic-limbo is implemented, then anybody who has a local sha256 repo got
> there intentionally, and presumably knows enough to configure the server
> side to match. So the sensible protocol advertisement for a limbo repo
> is "magic-limbo" plus "object-format=3Dsha1".

We need to declare the other object format as well because we need to
know that the server specifically supports SHA-256.  If we add a third
hash algorithm, then maybe SHA-256 is unacceptable for that reason.  So
maybe `alt-object-format=3Dsha256`.  We do definitely need to be sure that
multiple options are accepted, though.

As I say below, we probably need to initialize with some hash algorithm
at first, so we could also have `object-format=3Dsha256` and
`alt-object-format=3Dsha1`.

You hint at delaying SHA-256-by-default until this is implemented, but I
don't think that's a good idea.  I agree this would be a nice feature to
implement, but I have no intention of implementing it and you said you
didn't, either, so unless someone decides that they are going to
implement it imminently, I don't think we should hold up Git 3.0 or the
default algorithm change to then.  As I mentioned, Git is really behind
the times on moving away from SHA-1 and we need our users to choose
sensible defaults as soon as possible.  Git 3.0 moving to SHA-256 by
default was announced in 2024 and given that I managed to write a
functional interoperability implementation in that time, there has been
plenty of time to say something and implement a solution.

> Yeah, I thought about emitting multiple but it seems like that
> introduces other weird corner cases. I think we really need a new
> capability so that new versions and use it and old ones will ignore it.

The bug I mentioned was apparently not a crasher but an infinite loop:
aa962fef27 ("v0 protocol: fix infinite loop when parsing multi-valued
capabilities", 2023-04-14).  However, it was fixed in 2.41, before
SHA-256 became stable in 2.44.  We could therefore implement it that way
if we're willing to abandon versions of Git that only have experimental
support for SHA-256.

> Those parts seem outside of the scope of Git, or at least its protocol.
> But yeah, I'd expect a forge like GitHub to let you say "do not allow
> the creation of sha1 repos in this account/org", and the object-format
> selector for a new repo (at the forge UI) should be a tri-state: sha1,
> sha256, or limbo. How that translates into Git commands is TBD: whether
> via config, or more likely, that you have to select the limbo state
> explicitly with a command-line option to git-init.

I disagree that they're outside the scope of Git, but I do agree that we
should add support for this either in the config or via a command-line
option.  I think config would be better here because we also have to
deal with the fact that someone might use commands other than push to
write into the repository (on a forge, that might be the API) and we
need to specify _some_ hash algorithm for that case.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--iVAz6Ta4I8OnYBVD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrBD6cJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZwMIf5V0Q2e/smJeceKJYJBRrnpg5/mSp8FwImr3q/aL
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKyrAQCDVUzUVUx+P/AwtyFJW511XPE1
R7ZrzFGsSeJRaTV6jwD9FBJ9AuDKwetqyGXKYMhVGnqKU5c1rvmMVH4oGTaj2AE=
=s2La
-----END PGP SIGNATURE-----

--iVAz6Ta4I8OnYBVD--
