Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92481D47BD
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895035; cv=none; b=JhsDpUcMFlOvWYg7PxLx7+TOs15PwpQmjg0QvXSRZpSGIbnx6bNENXYWh+UOigHhEN7vCUWSMchCFA83NUfAXLJbgnbmW4bO4DrAOT4kBZkvlluqiuqjI8aEIawZvmbHjnq95o1LnBobenNWHMOINgYycTjmjEWcabL00fGU42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895035; c=relaxed/simple;
	bh=xto3lTntWDwT4JlQIic9v3hLOdNqGwKSjoyHYzulr5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YADHI8ZH37i8isJB4utSLBX5Q9rDWWJQ22X+AWD880umNByAexNyB+zApiZWLnlmJ0oEjD7LaAewFhNQ8dmo1aY1ku97TTfjrqppmtTOVpU5NMPy8ez1xbvhCehPTZb557+4gLUBSEbiZY/AjZaH24+uoZ+KmQHY1pnGba+J8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=avcn6DYv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="avcn6DYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736895026;
	bh=xto3lTntWDwT4JlQIic9v3hLOdNqGwKSjoyHYzulr5Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=avcn6DYvF6gz+5kl4ckto5uFNO9dzvrPkMjB/4Lbhga+tCqGVGRxfJmEgWsixsJc3
	 kwdO9KDdWfYHZ0RqSmcnzuTdCGzcK4wXExTAxJIwYV1IXvYvPYXn0fzEi/Avs/AhVc
	 JQAEhX5hI5uAhYKA3yg/q2cU1ngzdXTFvfOY82yib+jdlsBdeFLBXDShuOQTO6zFvq
	 DVYAgsDY+GW9Hob75pw5RWb6btvdg4CisvuN6iLUtq2TYBVmICrhIwSuYry5IZbVVP
	 AXzsi0f7bXZRcNSQEPyV2d63d2PhhysjxZsPzp5BOmYXwprJHc3zMG0+4Zv4gvyX8O
	 DMQfSlHDDqob3zC7wCAulSy0YEdTDvg5rr2tZBuOi5yM7vhgjU3XPEdMgMr4jBEUdR
	 1QU+AQSnQfVxqILmGYFl1k7xRx8tqke45+vkfVJNPhpYnUYL+QZF241aLLHahcK+3i
	 bMjoUXp0eVUIMEfLpfb7aycjuuCA5LpWhkZWrvxQvqEcXmKIwaR
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9A031209C6;
	Tue, 14 Jan 2025 22:50:26 +0000 (UTC)
Date: Tue, 14 Jan 2025 22:50:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
Message-ID: <Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ApafbLwfjNKt/HhO"
Content-Disposition: inline
In-Reply-To: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ApafbLwfjNKt/HhO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-14 at 18:19:29, Johannes Schindelin via GitGitGadget wrote:
> When a clone fails, users naturally turn to the output of the=C2=A0git
> clone=C2=A0command. To assist in such scenarios, the output includes the =
messages
> from the remote=C2=A0git pack-objects=C2=A0process, delivered via what Gi=
t calls the
> "sideband channel."
>=20
> Given that the remote server is, by nature, remote, there is no guarantee
> that it runs an unmodified Git version. This exposes Git to ANSI escape
> sequence injection (see
> CWE-150,=C2=A0https://cwe.mitre.org/data/definitions/150.html), which can=
 corrupt
> terminal state, hide information, and even insert characters into the inp=
ut
> buffer (as if the user had typed those characters).

I could certainly be mistaken, but I believe the report feature (e.g.,
title report), which is disabled for security reasons on all major
terminal emulators, is the only feature that can be used to adjust the
input buffer.  If there are others, then those would definitely be
vulnerability in the terminal emulator, which is the place they should be
fixed.

> This patch series addresses this vulnerability by sanitizing the sideband
> channel.
>=20
> It is important to note that the lack of sanitization in the sideband
> channel is already "exploited" by the Git user community, albeit in
> well-intentioned ways. For instance, certain server-side hooks use ANSI
> color sequences in error messages to make them more noticeable during
> intentional failed fetches, e.g. as seen at
> https://github.com/kikeonline/githook-explode and
> https://github.com/arosien/bart/blob/HEAD/hooks/post-receive.php
>=20
> To accommodate such use cases, Git will allow ANSI color sequences to pass
> through by default, while presenting all other ASCII control characters i=
n a
> common form (e.g., presenting the ESC character as=C2=A0^[).
>=20
> This vulnerability was reported to the Git security mailing list in early
> November, along with these fixes, as part of an iteration of the patches
> that led to the coordinated security release on Tuesday, January 14th, 20=
25.

I think there is some disagreement as to whether this constitutes a
vulnerability.  I personally don't agree with that characterization, and
a CWE is a type of weakness, not a vulnerability.

Note that all of these problems could also occur by SSHing into an
untrusted server, running `curl` without redirecting output, or running
`cat` on a specially crafted file at the command line.  It is
specifically expected that people use SSH to log into untrusted or
partially-trusted machines, so this is not just a thought exercise.
None of those cases would be addressed by this series.

> While Git for Windows included these fixes in v2.47.1(2), the consensus,
> apart from one reviewer, was not to include them in Git's embargoed
> versions. The risk was considered too high to disrupt existing scenarios
> that depend on control characters received via the sideband channel being
> sent verbatim to the user's terminal emulator.
>=20
> Several reviewers suggested advising terminal emulator writers about these
> "quality of implementation issues" instead. I was quite surprised by this
> approach, as it seems overly optimistic to assume that terminal emulators
> could distinguish between control characters intentionally sent by Git and
> those unintentionally relayed from the remote server.

I've done some analysis of this approach after discussion on the
security list and I don't think we should adopt it, as I mentioned
there.

Where pre-receive hooks are available, people frequently run various
commands to test and analyze code in them, including build or static
analysis tools, such as Rust's Cargo.  Cargo is capable of printing a
wide variety of escape sequences in its output, including `\e[K`, which
overwrites text to the right (e.g., for progress bars and status output
much like Git produces), and sequences for hyperlinks.  Stripping these
sequences would break the output in ways that would be confusing to the
user (since they work fine in a regular terminal) and hard to
reproduce or fix.

There are a variety of other terminal sequences that I have also seen
practically used here which would also be broken.  Other sequences that
could usefully be sent (but I have not seen practically implemented)
include sixel codes (which are a type of image format) that could be
used to display QR codes for purposes such as tracking CI jobs or
providing a "receipt" of code pushed.

I agree that this would have been a nice feature to add at the beginning
of the development of the sideband feature, but I fear that it is too
late to make an incompatible change now.

I realize that you've provided an escape hatch, but as we've seen with
other defense-in-depth measures, that doesn't avoid the inconvenience
and hassle of dealing with those changes and the costs of deploying
fixes everywhere.  We need to consider the costs and impact of these
patches on our users, including the burden of dealing with incompatible
changes, and given the fact that this problem can occur in a wide
variety of other contexts which you are not solving here and which would
be better solved more generally in terminal emulators themselves, I
don't think the benefits of this approach outweigh the downsides.

I do agree that there are terminal emulators which have some surprising
and probably insecure behaviour, as we've discussed in the past, but
because I believe those issues are more general and could be a problem
for any terminal-using program, I continue to believe that those issues
are best addressed in the terminal emulator itself.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ApafbLwfjNKt/HhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4bqMAAKCRB8DEliiIei
gciMAQDGtivqNEc3Fi65nJYIOlEJS4xeX0P8TDAPk6Ybvqe4lgD+J/MhjrCeFmNn
pGUs6DyTGHL4rZMmo1LQbvKAuiNezgM=
=vBLl
-----END PGP SIGNATURE-----

--ApafbLwfjNKt/HhO--
