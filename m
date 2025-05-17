Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB4190057
	for <git@vger.kernel.org>; Sat, 17 May 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476940; cv=none; b=duM6zeHVrrQsw8Ws4oo2mkt74w9we8yGS3s5oJg9cQQ77zDcQyh+HQRGqyj9gBEXYnTJKjZlTwzCBv2g9h8AKAUIWCNecfVAA6eS82HDIoWEXxNNhc1YwZxvqwgYzhIgBgsxvpNmP+7p1PoCcQzrXi5DgXul1jOLRJAiVHnFSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476940; c=relaxed/simple;
	bh=dwXC2bmoHDJqoZRpfbfEyC40uxAKcJrvO38hMvG7h9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC0vsJb+1nflvu9w/DL2o/CcDurFtkFZFfTB1o8pOXMyHjZk96dnj3OR4ZDHcB3kPvp/iOhMAFfgpwS1EzNMbzFn8NwjLg1hR6M5DOhMv+s0jm1zWvYnoMmuyhO+urTpq5UQKjiSzjo4AJjbTE9jlXnL5DiMJNfFwT51U3M2QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=d2M75+q8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d2M75+q8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747476935;
	bh=dwXC2bmoHDJqoZRpfbfEyC40uxAKcJrvO38hMvG7h9g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=d2M75+q8vIEA+AVIiLanvESF4EOl/PTRXlsdaPwYr/3qcKAIXn5jbtufWbWpbL6DX
	 7VftPBrNUHOJ1GKU6etlnBLq90bbYWUB6BoFh9EKjY7w9XVfYZCHOppdXb2fkUW14E
	 QHUpl22lV+KZgFgsdo5+2grNc6fPvPTUWqNzdC6EAXyJFsHmT3s+VTPn44pm0yKHi1
	 bJ+4FSOZ9dE9aIQ94+rFMVLWeMSIK4EYmSEskQXHtCCzZmGp7eLVcqjj57/dNek4Ru
	 uxgHbWG6Ivj8MxvRqn11aHRnwmhO1/1NkccFn0m5lXQC13I9c4FZCd/iiPA15R5ALg
	 vgMW/0M0halFvOyiw7aJfQvZPbs2aB23c9zYrH6QvMe/cYqTcahZh1r6K/ATgw6EhU
	 rqKwvPtGNeeFoYavnEK5OpRJ475gz9EDVM0ataE/O2NvEAs59hr9BsY1AFOPeGrNjp
	 Hf1uHqxT/lIRCYPRqnJtaczfgevFcu0sCeqsJ2I1wVVDGPl29NU
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4D9DC20125;
	Sat, 17 May 2025 10:15:35 +0000 (UTC)
Date: Sat, 17 May 2025 10:15:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: git@vger.kernel.org
Subject: Re: Small patch to add support for MPTCP on Linux
Message-ID: <aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>, git@vger.kernel.org
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
 <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
 <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Six8zFQWLEBJnDnO"
Content-Disposition: inline
In-Reply-To: <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Six8zFQWLEBJnDnO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-17 at 07:19:59, Muhammad Nuzaihan wrote:
> Hi Brian.
>=20
> On Fri, May 16 2025 at 08:33:03 PM +0000, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > What happens here if I compile this on a system that has a kernel that
> > supports MPTCP but then switch to one that does not?  The reason I ask
> > is that I have worked at places where we shipped binaries, including
> > Git, based on a standard CentOS or RHEL system, but then some people
> > used our software on a system with a very stripped down kernel (in some
> > cases, where IPv6 was not even compiled in) because doing so meant that
> > they could make about $5 more per server per month.
> >=20
> MPTCP supports *both* IPv4 and IPv6. Don't tell me people would also remo=
ve
> even IPv4 as well? I had written an #ifdef statement to check if
> IPPROTO_MPTCP
> exists and enables that.

I provide this as an example of people compiling even "essential"
features out of their kernel.  The question remains: if I compile on,
say, Debian, which has this, and then I switch to the same version of
Debian, but with a custom kernel that removes MPTCP from the kernel
completely, does this change continue to work, or do we end up with an
EINVAL from the `socket` call?

I want to point out that the kernel and libc headers used to compile a
binary need not reflect the actual code in the running kernel.  With the
advent of containers, people frequently run a different operating system
inside a container than they do outside a container and thus we need to
consider all of the possible combinations.

> > Do the operating systems which support MPTCP make it a compulsory part
> > of the TCP stack, or could we end up with cases where we're unable to
> > connect here?
> >=20
> > In addition, Wikipedia mentions that FreeBSD has only IPv4 support, but
> > I don't know if that's up to date.  What happens if we run on a system
> > where MPTCP is used, but it doesn't work with IPv6 and the only remote
> > IP is IPv6?  Do we fall back properly, or do things fail?
>=20
> This patch *specifically* targets Linux to check if IPPROTO_MPTCP exists
> in the Linux system. I think you have not read my initial patch descripti=
on
> properly nor even read about the new changes for MPTCP.

Git runs on lots of operating systems, not just Linux.  If the case is
that the `IPPROTO_MPTCP` #define is only ever available on Linux and no
other operating system ever ships that option or ever will, then that's
fine, but the commit message needs to say that.  I know that many
operating systems ship MPTCP, so I'm going to ask about how this works
on some non-Linux systems because your commit message didn't explain
that to me.

> Please read up on how MPTCP falls back to regular TCP if it could not
> connect using MPTCP.

Again, your patch tells me how things work on Linux.  I am interested in
patches that work across a variety of other operating systems as well.

> > I ask these questions not because I'm opposed to this feature but
> > because I want to be sure we don't accidentally break things for users.
> >=20
> I'm not sure but you have not even bothered to read the documentation abo=
ut
> MPTCP.

On the Git list, we try not to assume that everyone has read all of the
technical documentation about a subject and instead we explain, at a
high level, how the change is and how it's supposed to work.  Your
commit message should convince me (and everyone else, especially Junio,
the maintainer) that your change is valuable and should be applied.

> > I know that for instance Go 1.24 enabled MPTCP and that ended up causing
> > problems in some environments, so I would recommend that we make this a
> > configurable option instead.  We can definitely default to MPTCP, but we
> > probably need an option to fall back.
> MPTCP v1 (again i am repeating myself) and not the old MPTCP v0 does the
> fallback
> more effectively.
>=20
> Do you know of any references that mentions that Go 1.24 with MPTCP enabl=
ed
> (normally this is the current MPTCP v1) is causing the issues?

I know that there were circumstances in which there could be kernel
panics or similar problems with it enabled[0].  I haven't heard of
actual network problems, though.  Since most people were previously not
using MPTCP and Go 1.24 enabled it by default, upgrading to that version
caused some people's systems to panic under load.

I do think that enabling features that cause Git to induce a kernel
panic or the like, even though that's a bug in the kernel, should be
configurable.

> But what you explained about the downsides of MPTCP (without evidences)
> and not even implementing MPTCP for git protocol does not make sense.

I'm not arguing any downsides of MPTCP.  I'm stating that we have a
large variety of platforms that have to be supported and you haven't
explained how this works or will work anywhere other than Linux; that
there are people who compile out important features from their kernel
and, though that is improvident, we should probably not break Git for
them; and that we should be careful about enabling features which have
been known to cause system problems.

[0] https://www.wiz.io/vulnerability-database/cve/cve-2022-49198
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Six8zFQWLEBJnDnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgoYcUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4N1nhkMy+jnnD6PGP4G5RL0dBnGyoj9wyuTusF+BY4G
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAK7wAQDR6GkfdBiji0cHgdLcJctFGYZA
dvLcGuGXDI1pv+7J2AEA4JQ02htl8aK/pXrtcF4fSlsp2z1RAvMJBx6ClzZY4Ac=
=YLxY
-----END PGP SIGNATURE-----

--Six8zFQWLEBJnDnO--
