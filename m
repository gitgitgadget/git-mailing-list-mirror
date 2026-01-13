Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED3284B54
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768270333; cv=none; b=UkxVHkC/ce17FhTMSinVq6QuI+rGGOWUdtCfcZDACIfayFNX/wnnhHrzjJvblzDFPIS8J3cJ6zrd3HpGr79wm0vCVWMzQ8mqyT32plYMPN/m96/oKQ0A0BEbT+iBmSB2m6UIGYoZmhy8C0ALe8sbPzSmxX/JkzEZXrz61u9Opw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768270333; c=relaxed/simple;
	bh=fCLwJISOGWvJ3ibLKUaTVD2oGE1RHjEKRIbYx34YPUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TksHLUbBf3bJlY0rOAe6K0pqVQ4D8EpRESUYpQa5Qh1IDM+xXhVS8m8AUcMmChD+Whzrv98HuuvgeSMplIEPLL5D4uPwy7hbN7HtuD8zhSS9vOZ+63IbpJ8piEDra2vt9kQ6UwMbRSDVWxCa3v0eRl9soOeiqoHyv1LikgmpIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=a5FZAPNp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="a5FZAPNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1768270329;
	bh=fCLwJISOGWvJ3ibLKUaTVD2oGE1RHjEKRIbYx34YPUI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=a5FZAPNptpN9zOaACqbLG/7RrLs0Xe/C9IR3h67hHlgvKo8dH20XojgfbqnkLYELt
	 nAWOUkmdK0cCe5FSC45s5zyVJbBVyd9/M24i+BLoXOOCfVDYqLjsW5PYCXubNWvt7d
	 kjPeEqyzZ8rXqB5kruCQQltFelO0zleEydQDqJTkCuZMAkeIhs+3FusSWWBli8SFfM
	 g4jgdr2A4zxPadFCqE6TMbE9sTcjSd7YS0doPPoMTGXOQJsYDEVlSh5Ch/XzXM14DP
	 JVR0diYyQ3A9kdpsAIegWoE2rcocWBDsz7Kf7bs8DfgzFupAx+tHjkVKY4+J7P/eDE
	 gKmRNOzCtD++JSvyhXNeKtCI3a2cAKCNH0Jhs/k4NGShxzgcQMH2980lG+b0IvAivz
	 HUNZFvLAG5ids5JZ4QhycWFDqVLclSej6BoIo+UcpZyvD8CGnJkuhxBF66TAq2+6KX
	 N4BwvlnY7D0HeMKtn0qLhbOK/T1GLUP7o5oiq1NOwkFu+xVjH6V
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e6a9:5e22:aa44:8800])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E6CB920081;
	Tue, 13 Jan 2026 02:12:09 +0000 (UTC)
Date: Tue, 13 Jan 2026 02:12:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Chris Darroch <chrisd@apache.org>
Cc: git@vger.kernel.org, Chris Darroch <chrisd8088@github.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: pre-push hooks and stdout regression
Message-ID: <aWWp-FPzKdL72c9v@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Chris Darroch <chrisd@apache.org>, git@vger.kernel.org,
	Chris Darroch <chrisd8088@github.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
References: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24103HI8V/R8SniS"
Content-Disposition: inline
In-Reply-To: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--24103HI8V/R8SniS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-12 at 23:21:42, Chris Darroch wrote:
> Hello --
>=20
>    I'm one of the current maintainers of the Git LFS project, and we
> happened to notice that a recent change in Git's "master" branch has
> introduced a regression in our test suite.
>=20
>    Specifically, with commit 3e2836a742d8b2b2da25ca06e9d0ac3a539bd966
> ("transport: convert pre-push to hook API") from the "ar/run-command-hook"
> merged last week, it appears that when a pre-push hook such as our
> git-lfs-pre-push program runs, messages it writes to its standard output
> are now delivered to the user's standard error stream instead of
> their standard output stream.

CCing the author and submitter.

>    I suspect this is because the pick_next_hook() function in hook.c
> sets the stdout_to_stderr flag for its "cb" child_process argument,
> and that function is now used to run the pre-push hook.

That's likely the case.  96e7225b31 ("hook: add 'run' subcommand",
2021-12-22), which introduced that code, didn't provide an explanation
for that decision.  I think that's required for hooks such as
pre-receive that send data over the sideband, and it may be that the
code was simply reused.  Of course, I could be mistaken.

>    However, I think there remains the larger concern that users who
> depend on the existing Git pre-push behaviour in some way may also
> encounter regressions, perhaps because they expect (as our test suite
> does) to see certain messages either output or not output to stderr
> during a Git push operation.

I suspect that we're also going to see similar regressions in other
software.  pre-push hooks are really popular, as well as pre-commit
hooks, and people are going to expect both standard output and standard
error to be connected to the same place they were before.

A quick check of pre-push hook frameworks on GitHub indicates that a
substantial number of them print to standard output, even for error
messages.  I expect that we will actually see quite a bit of breakage in
this case, especially from automated tooling and Git graphical
frontends, which may expect data in a certain place.  I don't have any
proof of this, however, but it does seem like the kind of thing that
people will have come to rely on.

I'd recommend that we avoid using `stdout_to_stderr` for hooks unless we
did originally or really need to (e.g., for things that might go over
the sideband).

>    Please do let me know your thoughts on this subject!  If the
> consensus is that the new behaviour is correct, we'll adjust our test
> suite to match it, but I'll wait to hear the outcome of any discussion
> before making that change.

I will just state for the benefit of the list that Chris and I are
colleagues and we discussed this at work, so I asked him to CC me on
this issue since I was curious.  My opinions here, as with everything
originating from this email address, are mine and not my employer's.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--24103HI8V/R8SniS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWWp+AAKCRB8DEliiIei
gXieAP4zH5u+G6VzRqE+zq9eo2UDgB9P2BA2PWeXoDFORt76KwEAld76ZjF/qcCl
PfxAMunp1RIfc4XTMRYxI0StkOosBAw=
=T2wY
-----END PGP SIGNATURE-----

--24103HI8V/R8SniS--
