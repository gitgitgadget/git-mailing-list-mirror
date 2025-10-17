Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECE33F8DD
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729472; cv=none; b=ucb9Z2BYKKR7rrQUgQFKgjcjHhP0lNHzOIGg87ez/TIevYYZu4OuBPOiAQV2evFJ8mhtI3ydRcbYlHqaicrDTqnV8/bh9XNNaOU9xw9O4hmuv2b65oV3dGQMclSwzvoa3K1IdLkKFhzddDCCnzMl1Swn9cxkz254IpF4RJNirs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729472; c=relaxed/simple;
	bh=VbOewWLU86duLSMyLhb/hToXFxq9LkCaR6dOo2AHso4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1H/KqCFEXs5JDgJYw2rAzXiXihokg3gTMHqX93MCBfSSg1bxXRi0cvT4M+231x3CwMowTWKVaeBCZGR/tC+NN+x1F+YlVU2RqBUvkohPxM3I9CjH1hMG/caQmx5uDwsrH931aKl7iS++FTFCefN8cl7MV/UIkPrAt9m6gNh/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=muJsCrXU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="muJsCrXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760729467;
	bh=VbOewWLU86duLSMyLhb/hToXFxq9LkCaR6dOo2AHso4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=muJsCrXUZ6xTEbF7xlU8NA0QstoPKqyjsSnEdxDDeSfb1CLkL1wInoAAOLwjJeKWx
	 T2CmtHrmmxeg+KUpqJnIk0l/EfDrjC79XwX6HVH6IU/M6VhDzABidDKVreNHWCJh/l
	 /njAmpieY+57CRiKX7fViGAw4EIeP4hqyJsE+vkcuVfW4ikGGGWCJauzYhOv9VE5oG
	 m29srUpbQsVotUotWrhdvqVKa7iTBGRIr14x0ropMKbHg7+I/cDhdYgGUG8//vucC3
	 7iWjfZ4TZFGoqBb80ygWmIJIVaWBPwRd0OX391LRQafq8XOvr0OTfEUZ81HMUfpft1
	 xXTkYF5SdXEgnPtqAZCWSh21GcWoEcorTZbsbsIhSfjS0PhlzYzZrnYtG7wbIOKhCH
	 ACwOhS2EUeCXv8UVsZYCyIMVfuugu4/cmFbXjMzYAOROiCnHMNOXS/mchZIHXxDIs/
	 DdJ/0Bb8Ru0ICCdJg9ot5OEJHGC4T/dLn11Hb/AtcZMV3+ruQtC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5c18:db3b:8800:f1b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E67F820128;
	Fri, 17 Oct 2025 19:31:07 +0000 (UTC)
Date: Fri, 17 Oct 2025 19:31:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Lauri Tirkkonen <lauri@hacktheplanet.fi>,
	Collin Funk <collin.funk1@gmail.com>,
	Xi Ruoyao <xry111@xry111.site>, git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
Message-ID: <aPKZeqTK-tIcrfFB@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Lauri Tirkkonen <lauri@hacktheplanet.fi>,
	Collin Funk <collin.funk1@gmail.com>,
	Xi Ruoyao <xry111@xry111.site>, git@vger.kernel.org
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
 <87o6q6nux7.fsf@gmail.com>
 <20251017070912.GA4068463@coredump.intra.peff.net>
 <aPIR8fB4w5Jkeiq2@mail.hacktheplanet.fi>
 <20251017105400.GB1015973@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4innED1saKbwulDJ"
Content-Disposition: inline
In-Reply-To: <20251017105400.GB1015973@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4innED1saKbwulDJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-17 at 10:54:00, Jeff King wrote:
> On Fri, Oct 17, 2025 at 06:52:49PM +0900, Lauri Tirkkonen wrote:
>=20
> > > If I unset SSH_AUTH_SOCK in my environment, then the test consistently
> > > fails. But I'm somewhat amazed that nobody has complained about this
> > > before. Surely somebody somewhere (especially CI!) is running t7528
> > > without SSH_AUTH_SOCK set in the environment. Which makes wonder if I=
'm
> > > missing something.
> >=20
> > I believe the issue surfaced only now because prior to OpenSSH 10.1,
> > ssh-agent would put its socket in /tmp by default, not under $HOME. See
> > https://www.openssh.com/txt/release-10.1
>=20
> Ah, of course. That explains it perfectly, thanks. So we're going to get
> lots more reports as people upgrade. :)

I had not had time to properly analyze it in order to say something more
thoughtful than "this is broken", but I can confirm it breaks for me on
Debian unstable:

  ERROR: ld.so: object 'libc_malloc_debug.so.0' from LD_PRELOAD cannot be p=
reloaded (cannot open shared object file): ignored.
  ./t7528-signed-commit-ssh.sh: 1: eval: directory.t7528-signed-commit-ssh/=
=2Essh/agent/s.5w4CQ2109U.agent.5l0ixCaX1S: not found
  Agent pid 1429798
  Could not add identity "/home/bmc/checkouts/git/t/trash directory.t7528-s=
igned-commit-ssh/gpghome/ed25519_ssh_signing_key": agent refused operation

Note that OpenSSH in my case is broken because of the space in the
home directory.  I've reported that to Debian and we'll see if it gets
fixed.  (I did mention it breaks the Git testsuite in the hopes that
improves the likelihood of getting it fixed.)

> > We saw this failure in CI on Alpine Linux and worked around by adding -T
> > to the ssh-agent invocation in this test, but I suppose that won't work
> > for earlier releases of OpenSSH.
>=20
> Yeah. We could either do something like "ssh-agent -T || ssh-agent", or
> we could go with "ssh-agent -a" (which has been around since 2002, but
> does raise the potential relative-path issue).

I think like `ssh-agent -T || ssh-agent` would be better because we know
$HOME can be very long in our case, whereas $TMPDIR should not be
excessive (since presumably it worked before and other services, such as
tmux, place their sockets there).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4innED1saKbwulDJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPKZegAKCRB8DEliiIei
gcb2AP9MmASXv31SOHXVDqdB4Amk61s6Aa50MiOCzelyItCfnAD+NnjzxW7JTaRp
bnjnKiRm66VibqGJhwejkuVRM9+sGAA=
=cWAh
-----END PGP SIGNATURE-----

--4innED1saKbwulDJ--
