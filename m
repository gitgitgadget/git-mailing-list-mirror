Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916F1E4B3
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715700; cv=none; b=W++/eDV0HYxpdS5PpIMiCaDmZM/f2HcW7sUhEW1lQcV4nPONM6c11L24UDJ3AawO5wIsdqcpg7+riBbW0K+2MroJg7RCbDNOM4XiFtueSNpj2Yqgy/Sz69vf2DL6DeRvlzXtXMORntP7o6X5B4Etcc2saDrbbRZh+qRr7+80K0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715700; c=relaxed/simple;
	bh=zP3vzU7UJBr4rCl3lBvmEM4QHiMvdFaZWsOwhi2enPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4Tm3AYzRKslo7MnhxAdwKi8lhEoZ+DRjQUBv3wJXJ/xVV6O50dwovZxxGYdkhyny6V2pJZpF6djek4FU4qm6HnuY9lAfQ+l55WfZpl30uGhNLXPCZzO01VDvkuZCQfwBcbfltX9zNT9UDDvceBIWnAU4gie7GMjLybfubDrQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YMR7gxbh; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YMR7gxbh"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0C52A5DA88;
	Tue, 14 May 2024 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715715697;
	bh=zP3vzU7UJBr4rCl3lBvmEM4QHiMvdFaZWsOwhi2enPw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YMR7gxbh5guUCBGq9M5I1wKzuUOMLhB7lK7GbstWnpucKMXJMw6d/52lojXC14l/F
	 Y6Za7+wJ6TB0k4A3Ffx3wJxBqbypWH8pxUdnnawoqkyV9OtHbep7rexrsNkkQcogYA
	 g+vjg7VzAyOKcMfDkWStC3kp8846NXAuqD3hzQ3arflgzjUQ6DYjgqg4xp/pG7kNaa
	 SitJPRwDWBzVSy7U5m6BsfuDYQX3mzozWf//vMB59OJDxxMpZO2CMkHBj+0VA4iFXi
	 DtxKg2Pm6we+m+ogwdWw7E1Z5A7I75wtSTLjDseBkeDF5l/Vyi8El9I8fRUetqzaRG
	 7kDWz4lVXk8KpJssWIEgUibhfpL7yTQ/iSO+dKLdHuj8LN6uNi2ntGU5Clo2YGFZNu
	 2T9sBs8Fj0Otwugg4eaBXLFIb+SZLHJzlcBG02rwIouqq8TTknoeRdoaPlALGc0iQb
	 HF0FGaXed/q3k0Osfq/Cwi7OMYNXObUZg9H0LVshC9//l20BhHt
Date: Tue, 14 May 2024 19:41:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Message-ID: <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
 <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fid6H1ZVa1v1EOtu"
Content-Disposition: inline
In-Reply-To: <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Fid6H1ZVa1v1EOtu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-14 at 19:07:28, Johannes Schindelin wrote:
> brian,
>=20
> On Tue, 14 May 2024, brian m. carlson wrote:
> > This causes most CI systems to be broken in such a case, as well as a
> > confusing message for the user.
>=20
> When using `actions/checkout` in GitHub workflows, nothing is broken
> because `actions/checkout` uses a fetch + checkout (to allow for things
> like sparse checkout), which obviously lacks the clone protections because
> it is not a clone.

I'm not saying all CI systems do this, but we probably have broken quite
a few.

> > It's not really possible to avoid the need to install the hooks at this
> > location because the post-checkout hook must be ready during the
> > checkout that's part of the clone in order to properly adjust
> > permissions on files.  Thus, we'll need to revert the changes to
> > restrict hooks while cloning, which this series does.
>=20
> Dropping protections is in general a bad idea. While previously, hackers
> wishing to exploit weaknesses in Git might have been unaware of the
> particular attack vector we want to prevent with these defense-in-depth
> measurements, we now must assume that they are fully aware. Reverting
> those protections can be seen as a very public invitation to search for
> ways to exploit the now re-introduced avenues to craft Remote Code
> Execution attacks.

If these protections hadn't broken things, I'd agree that we should keep
them.  However, they have broken things and they've introduced a
serious regression breaking a major project, and we should revert them.

I'm not opposed to us exploring other alternatives for defense in depth
measures on the list.  I definitely think such work is valuable and
important, but I want to make sure the changes we make don't regress
important functionality.

> I have pointed out several times that there are alternatives while
> discussing this under embargo, even sent them to the git-security list
> before the embargo was lifted, and have not received any reply. One
> proposal was to introduce a way to cross-check the SHA-256 of hooks that
> _were_ written during a clone operation against a list of known-good ones.
> Another alternative was to special-case Git LFS by matching the hooks'
> contents against a regular expression that matches Git LFS' current
> hooks'.

I have replied to those on the security list and to the general idea.  I
don't think we should special-case Git LFS here.  That's antithetical to
the long-standing ethos of the project.  While Git LFS is _one_ known
project to have been broken, there may be others, or people may have
forks of Git LFS under other names, and we want that tooling to be able
to take advantage of all of the same features.

I'm also opposed to any kind of pinning of the Git LFS hooks to Git in
general, whatever the approach is.  Git LFS runs against multiple
versions of Git in our CI, and if we change the hooks in a way that Git
hasn't pinned, either via SHA-256 hash or regex, then Git LFS (and its
CI) is broken until Git gets an update.  We've already had to deal with
small incompatible changes that have broken Git LFS, and I don't think
coupling the projects in this way is a good idea.

Finally, it's very easy to work around the protections by merely placing
a malicious binary called "git-lfs" earlier in the PATH, so we're not
necessarily getting a substantial amount of improved security by
requiring that binary.

> Both alternatives demonstrate that we are far from _needing_ to revert the
> changes that were designed to prevent future vulnerabilities from
> immediately becoming critical Remote Code Executions. It might be an
> easier way to address the Git LFS breakage, but "easy" does not equal
> "right".
>=20
> I did not yet get around to sending these patches to the Git mailing list
> solely because I am still busy with a lot of follow-up work of the
> embargoed release. It was an unwelcome surprise to see this here patch
> series in my inbox and still no reply to the patches I had sent to the
> git-security list for comments.

As you may know, I don't read the git or git-security lists except on
my personal computer using my personal email, and I have been at work
most of the day putting out fires related to the Git LFS breakage above.
Thus, I haven't seen them until just recently, when I did try to get a
reply out.

> I am still busy wrapping up follow-up work and won't be able to
> participate in this here mail thread meaningfully for the next hours. I do
> want to invite you to think about alternative ways to address the Git LFS
> issues, alternatives that do not re-open weaknesses we had hoped to
> address for good.

I don't want to put undue pressure on you.  Please feel free to respond
or not at your leisure.

> I do want to extend the invitation to work with me on that, for example by
> reviewing those patches I sent to the git-security mailing list (or even
> to send them to the Git mailing list for public review on my behalf, that
> would be helpful).

I think the substance of my response was the same one that I gave above.

With all due respect, I don't think your patches are the right way to
address the problem, and I fear that by bringing them to the list, I'd
be giving the list the misleading impression that I endorsed them with
my sign-off.  While I respect you as a colleague and a contributor, even
if we may disagree on this or other issues, I don't agree with the
approach in the patches, and I don't think it would be a good idea to
apply my sign-off in sending them.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Fid6H1ZVa1v1EOtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZkO+bgAKCRB8DEliiIei
gRzBAP9YyG3vMrGb98j1mPwTCynpKPGO6QHXB5ZDdDvH5AHuCgD+MmW6/P6pxIcF
b7a6M6y48rbx99DnVgu4wsk06aG0oA0=
=N6av
-----END PGP SIGNATURE-----

--Fid6H1ZVa1v1EOtu--
