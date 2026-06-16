Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9731EB5C2
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569039; cv=none; b=VzAmxNcEv4JZOrUK5vg5Jn5Ih2mqZoEdkKgaKhyDGFk8J5JGOpnQqmuIFN4FE77rcmsi0bYQK7VtLQVRvxqIU4SqFqP2KFgHWpGHIkfS6EY/ZSNt8UuSgsRJ4FO77QzcerGyedDN7cyfOCVEKnz9JSFwqlY22LyK3+3yT7IWb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569039; c=relaxed/simple;
	bh=XYfjBsCe/R33zuc44CcljaS922ebizVzHPhxdX1AinI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JWNokJXsFF0iNEXrYpl6rMfEwXGoN3iNVmS5Yj2hkZft3H542MYyWByUPh5rcKi06Z04IA5VNUcitgeR+jQENolpQTGjDTrGA/yPyJbAQNTv1xpt7xCjlt5R7LrGN+R+kXytHql09BjGxzQJLXKkgiKgpiLJjwod2v9WeOpIxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OZwXcSdS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OZwXcSdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1781569030;
	bh=XYfjBsCe/R33zuc44CcljaS922ebizVzHPhxdX1AinI=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=OZwXcSdSWP8wEbMHjJsucqXOh5cslSp6ySrtIK+qmBfWfwf7aUXgp8ah+Ou67MRrU
	 hZJppctZglm/hhAL5BGPKVC13FE5KHkc27bfxaybPQAYs+GaNkoA0LzHMvbi9RpoJs
	 7BFzPJyt9DuVM1wXOQz2M4FSWV4GWzBcnH5Kg4Vr918FgtF6T5GStG4jHmOQtnGPf6
	 r0UmwZjMghxJ8FWubUq0H7su7whzRWbVtDwJFP8m3nNKZoBBiUtxLV3UNfQRbWVXsM
	 +KS22yiSFS/p/wrQ815Dko9mGCWGByoe0m/SkKWExNH3r0iMGL3DyWe39eDVcsXVlN
	 ETzkydLlqWU3yqfb9VcBGi0rUcizCxE+o8VMmQkRVa8mtE0sdhXg7yxHD4b0GUwHZg
	 j7OoeKgOxjdfi5IZH8Sa0eIHoTss+K1COrufSXvRiOwRznvVqAXpGdn9Aror1RwpuY
	 ZrZv1RxT3hKm0mgO7dhvxaXlZBBbrwov1wy7bsjAdKpQSho1QKs
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1a01:eb7a:51f5:1fb6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 10590200AF
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 00:17:10 +0000 (UTC)
Date: Tue, 16 Jun 2026 00:17:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: SHA-1/SHA-256 interoperability work is functional
Message-ID: <ajCWBG9RHBrm8jMZ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UobBA69hvM44tB+s"
Content-Disposition: inline
User-Agent: Mutt/2.3.2 (2026-04-26)


--UobBA69hvM44tB+s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm pleased to announce that I have Git fully passing the testsuite and
CI in interoperability mode, both with SHA-256 and SHA-1 as the main
algorithm.  While this is very exciting, the work is not ready to send
to the list and is effectively a draft, since there is still cleanup
and efficiency work to be done.

What is fully functional:

* The testsuite.
* The protocol, including extensions for mapping objects to support
  shallow clones, submodules, and partial clones and interoperability
  with remotes of different algorithms.
* A full complement of functionality for everyday use cases.

Features which are currently unsupported (and which may or may not be
supported in the future):

* Filtered bundles are unsupported because there is currently no way to pro=
vide
	a mapping.
* Multi-pack index cannot be used as the sole pack index format because it =
does
	not yet provide mappings.
* Pack index v1 and v2 cannot be used because they do not provide object
	mappings.  Git automatically uses pack index v3 instead when necessary, wh=
ich
	does handle mappings.
* Packfile URIs are not supported because the protocol-provided packfile is=
 not
	complete and its objects cannot be mapped.
* Large object promisors cannot be used if the server does not actually have
	the entire history, since the server must have a complete history in order=
 to
	provide object mappings.
* `git fast-import` does not accept submodules in compatibility mode because
	there is no provision for mappings.
* Remote helpers do not emit signatures in the compatibility algorithm for
	signed tags.
* The WebDAV-based HTTP protocol doesn't support interoperability due to
  the lack of a way to distribute mappings.

Some additional things that may need to be improved:

* We have some recursive delta resolution code in `git index-pack` that
  will need to be made iterative to avoid stack overflows.
* We need to batch object maps whenever we write them, since having too
  many causes `git gc` to kick off frequently (which can be seen in some
  tests).  This will require substantial refactoring of code like `git
  add`, since any time we write an object we must be sure to always
  write the mapping (even if we `die`).
* We will probably want to move the object map repacking code out of
  `git gc` into a separate command that we can call manually.
* We may want some debugging tools for pack index v3 and other data
  formats so that we can show the mapping of objects.
* We will probably want to be able to sign in only one algorithm instead
  of always in both.  Users may not want to sign the SHA-1 format for
  security reasons.
* There is some extremely basic code for `^{sha1}` and `^{sha256}` to
  help `git rev-list` perform connectivity checks for remotes using the
  compatibility algorithm, but it is very much incomplete and will need
  to be completed or fenced off.
* Operations can be rather slow in some cases and we'll want to see what
  speedups we can perform.
* Probably other things I have forgotten.

There is new documentation in `Documentation/gitformat-hash.adoc` that
outlines the requirements for using the protocol.  The protocol
restrictions described there are hard technical limitations that cannot
be avoided; I've intentionally made things as featureful as they can be.
This imposes real restrictions on using protocol interoperability with many
projects, including Git and Linux[0].  Interested parties may wish to look
at t1017 to see what's tested vis-=C3=A0-vis the protocol and
interoperability.

On the end of the series is a small amount of new Rust code that moves
us in the direction of object file conversion in Rust.  All the pointer
arithmetic makes me very nervous from a security perspective, especially
in network-facing code, so my hope is to eventually port that code over.
Note that Rust is already required for the interoperability work, so
this doesn't add any new dependencies.

I also have some unpublished code that could start on in-place migration
functionality much like is done with `git refs migrate` once the Rust
prerequisites above are ready.  This could also make it possible at some
point to migrate any relevant submodules as part of the migration of the
main repository.  I may or may not complete this work, but perhaps
someone else will want to pick it up if I do not.  I'm certain that such
code would be valuable to many people, including forges.

I intend to rebase and tidy this work for at least a little while, but
don't actually intend to send it upstream, since there are some
technical limitations that prevent me from doing so.  I have, however,
been in contact with someone (who may identify themselves if they
choose) who is interested in getting some of the polishing and
upstreaming work done, which I deeply appreciate.

If you're interested in testing or perusing the work, you may get it
=66rom the `sha256-interop` branch of https://github.com/bk2204/git.git.
Please note that it may be rebased, rewound, or otherwise folded,
spindled, or mutilated at any time.

Even though the testsuite is passing earlier than I expected, I don't
expect it to make Git 3.0, nor do I think we should delay Git 3.0 for
this work.  There are approximately 200 patches currently (and more to
come if we add in-place migration tooling), so it seems very unlikely
that we could get the entire series upstream in any reasonable amount of
time.  We will also very much want to give this time in an experimental
state so people can try it out and report back on things that should be
improved, which is further evidence that it's not right for Git 3.0.

I'm happy to answer any further questions if folks have any.

[0] Git uses submodules, which would need to be rewritten first in order
to migrate, and Linux uses mergetags for which the tagged object is not
in the history (which makes mapping the commit containing it fail).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--UobBA69hvM44tB+s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmowlgQJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ7nvORhCD/LyAyIZ/E9ip59yQdEdJHbGoY3v15OHvlbm
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJb3AP0YkPd9IjkMDtzvH3ey0oSH9ioZ
4xJTRWDNys0wrCMaywEAt1SR5r0Ig/cVDPnbnvEQuMO8X7D62BkTJXWmWPcUfA0=
=P9kj
-----END PGP SIGNATURE-----

--UobBA69hvM44tB+s--
