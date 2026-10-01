Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36542668E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886589; cv=none; b=D60FONNz9h+63Ak7C36LUqCM4gjjbrgevEiqmPeYshPggQa6jTswtpV0DUgZY3vefGeHMv7Z7/TOARaLZ6B8d1JjKZqyC0mLtZItYe3u+89M+55VqLqpA+J3C04Y0DR143B3Z0W73oH1v6k4DP8iQT8YpmHoaAJZFPhhx/jejfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886589; c=relaxed/simple;
	bh=8zCMyyvCPewFRTxehZY0BI9eRyu/EutIsTh3jMF/56w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B73JrP8B0WRnzxwWKySociJ9lRpP7UG9B3S+1Hw0ez0Ml+x8HOX4Gbclswr8S+cKLqicpogCxCqpNsJll5VS2rbU3FkwnLtexNL2lRSgLYJK8q72+EShDcO6GSL7u/FKOGdIplhDG6Ae9mB5GuuRCSR+3aBNb+wHFfrxa9Q8Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO54q8jC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO54q8jC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F631F000FF;
	Thu,  1 Oct 2026 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790886588;
	bh=sqwtVaw2qwMLKD6n4ihU60nUeUstv3Lq/47CuffobAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QO54q8jCTjNFdQ5fRQ3EGUuGOPSFANAnnSzLUrhQCQDryOnT9uJsrzvB+Kso4f8/q
	 Rw43WmxUJrLgFrprG9sngJpRcXx9vgSUIFggYyHVg1fqX74NwFQ2vU90j9IYQbo4k1
	 YLYcLYONTeGxqlQXfeMDX4oLOyngSQM7x94oOv+ZuqJBSgxHIpfxZgAIaKarGFQXkF
	 UmcTgdN7pGV09EZu1MidueZNtJJbJOf/Kfm15/64RXYARBlQ3r94jwcnohVyHUdaJm
	 OSPFDHB1X3gb+XAjkLKBHtLuZJK1nmCuP2do0UznGbynafotkU1a5hfzHeHyia8jdy
	 YHg5bLdfTm7GQ==
Date: Thu, 1 Oct 2026 22:29:41 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar69ZZ4r9ZxISIHz@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
 <ar6LUeH3AjxbiMgd@debian>
 <ar6a8OkGhmYVoM7E@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hircdko3mxt6dm5b"
Content-Disposition: inline
In-Reply-To: <ar6a8OkGhmYVoM7E@ubby>


--hircdko3mxt6dm5b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar69ZZ4r9ZxISIHz@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
 <ar6LUeH3AjxbiMgd@debian>
 <ar6a8OkGhmYVoM7E@ubby>
MIME-Version: 1.0
In-Reply-To: <ar6a8OkGhmYVoM7E@ubby>

Hi Nico,

> Date: 2026-10-01 12:40:00-0500
> From: Nico Williams <nico@cryptonector.com>
>
> On Thu, Oct 01, 2026 at 06:50:08PM +0200, Alejandro Colomar wrote:
> > > Also, you need some extra handling of conflicts.
> >=20
> > No, that's the nice part.  It works as is.  When I see a conflict, I get
> > stopped at the rebase that caused the issue.  I solve that conflict, and
> > then can --continue that one rebase.  Or I can --abort that one rebase.
>=20
> Oh, because of `set -euo pipefail`, hah, yes.

:-)

> > > https://gist.github.com/nicowilliams/ea2fa2b445c2db50d2ee6509c3526297
> >=20
> > Hmmm, 93 LoC is certainly more interesting than the 4k+ python script.
>=20
> There is that, indeed.
>=20
> > I'll have a look.  I'll also attempt at writing a bisect-rebase from
> > scratch myself, to compare.
>=20
> I love that attitude!

Heh!  Thanks!

I've already tried it, and it seems to work (I've only tried it once;
I'll test it more before considering it stable).

Here's the implementation:

	$ cat $(which git-bisect-rebase)
	#!/bin/bash

	set -Eeufo pipefail;
	shopt -s lastpipe;

	tgt=3D"$(git rev-list -1 "$1")";

	## Try a regular rebase.
	if
		git rebase "$tgt" >/dev/null 2>/dev/null;
		test $? -eq 0;
	then
		echo 'Successfully rebased.';
		exit 0;
	else
		echo '[conflict]';
		git rebase --abort >/dev/null 2>/dev/null;
	fi;

	## Bisect.
	while
		git merge-base HEAD "$tgt" \
		| xargs -I{} git rev-list {}.."$tgt" \
		| wc -l \
		| read -r n;

		test $n -gt 1;
	do
		if
			git merge-base HEAD "$tgt" \
			| xargs -I{} git rev-list {}.."$tgt" \
			| sed "$(echo "($n + 2) / 2" | bc)!d" \
			| read -r mid;

			echo "$n commits left to test in the target branch (trying $mid)";

			git rebase $mid >/dev/null 2>/dev/null;

			test $? -eq 0;
		then
			echo '[ok]';
		else
			echo '[conflict]';

			tgt=3D"$(git rev-list -1 "$mid")";
			git rebase --abort >/dev/null 2>/dev/null;
		fi;
	done;

	## Perform the conflicting rebase
	echo "The conflict is at $tgt; about to rebase now.";
	git rebase "$tgt";

And here's now it behaves:

	$ git bisect-rebase agetpass
	[conflict]
	215 commits left to test in the target branch (trying 0482fd5f353c473268af=
f39e38513df2fb589a52)
	[conflict]
	108 commits left to test in the target branch (trying b21a76f759492f883888=
40d69f85b8d27ad5dffe)
	[conflict]
	54 commits left to test in the target branch (trying db3ca9f917efff9e2dab2=
fe36fa02fd6ef81ab08)
	[ok]
	27 commits left to test in the target branch (trying 4df3f783c4d936e698559=
0981a2ddaf0377a3785)
	[ok]
	13 commits left to test in the target branch (trying 93c675ef030e4eb226f60=
a317f3759755cd5bc5d)
	[ok]
	6 commits left to test in the target branch (trying b4adbe6387ae8d95dbe0bd=
547a157492842bea12)
	[conflict]
	3 commits left to test in the target branch (trying f7c712c3ade10c1d14916e=
a44408e42495fd1a8a)
	[conflict]
	2 commits left to test in the target branch (trying 0bb39793716a2466aa1f47=
7e4634e9d86532df80)
	[ok]
	The conflict is at f7c712c3ade10c1d14916ea44408e42495fd1a8a; about to reba=
se now.
	Auto-merging src/gpasswd.c
	Auto-merging src/newgrp.c
	CONFLICT (content): Merge conflict in src/newgrp.c
	Auto-merging src/passwd.c
	CONFLICT (content): Merge conflict in src/passwd.c
	error: could not apply e22c98497c16... lib/, src/: Use getpassa()/passzero=
() instead of agetpass()/erase_pass()
	hint: Resolve all conflicts manually, mark them as resolved with
	hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
	hint: You can instead skip this commit: run "git rebase --skip".
	hint: To abort and get back to the state before "git rebase", run "git reb=
ase --abort".
	hint: Disable this message with "git config set advice.mergeConflict false"
	Could not apply e22c98497c16... # lib/, src/: Use getpassa()/passzero() in=
stead of agetpass()/erase_pass()

It seems to work fine, and the source file uses 52 lines (including
blank lines).  The behavior seems intuitive, and not too verbose.

Now, compared to your script, the source length is similar (most of the
difference is printf calls).  I use more pipes, while you use shell
features like arrays (I have a very hard time reading shell code that
does heavy use of shell features).  Other than that, they look
fundamentally similar (except for the paragraph below).  :)

One thing I'm surprised, though, is that you take two parameters instead
of just the target branch.  I very much prefer my script in this sense,
which is like git-rebase(1), which rebases the active branch on top of
the target commit.  It's up to the caller to make sure that the active
branch is the right one.

> > I'll certainly try your script; thanks!
> >=20
> > Out of curiosity, did you offer this script to git(1)?
>=20
> No, though I think I've mentioned it here before.  I'd be happy to
> submit a patch, but I'd first have to get employer approval for it
> (which is not a problem -- it will only take time).

Please!  :)

Or I could send mine; I don't need to do any paperwork.
Actually, due to the difference in parameters, I prefer to send mine.

>=20
> > If not, why not?
>=20
> No real reason other than bureaucracy on my side.

Ok.

>=20
> > This is something that would clearly be helpful to people solving rebase
> > conflicts in many projects.
>=20
> I agree!

:)

>=20
> > Have a lovely night!
>=20
> Cheers!

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--hircdko3mxt6dm5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmq+wqkACgkQ64mZXMKQ
wqnmMA/9EreOuIrak+V+e6cIi0i7VBW5rQKe1myTBcdsvcqmA8Vs/6ANZ0wo3eb7
GqP9CYgOIkJKX0oZc3h5+rPkOL8M4McnWvVOzRFZQJss86IloeL6jov2KvKm5qA0
nMpJ3/KNy76zDXjEuPiTJZT3d/ht4t6FgShQ2Yb70bh3WX907VqumzoB3jvUb/ZS
72DZ2zfLsmCu0rB7gomfAj3RzHbr5Pxfrn/CAJAIqq8o92GrWW3WkCzD9BcQLXkZ
EOiLXU2VxOl+JgtRtalkOhUd+CABgPuvP0L3RUsikvE0qCKhpGZlcBhcCeu0OVGR
K6GoVB7Occ0i/ZLCTJNfx5wi8L7mmqxB1/tTwjh9mYgkCM92lCni8vvgtVZpwqDo
/EFfqSLWX4h5//7T/54gds4FOvAJzDdhlkWcRCtZ9ilBHV6H1S9zoE9o7smSi8Ia
QfhvyKiXeVi7kYwxrvdUzxlaDCJ+x6ofPJnXtjCsvdmXCAjbdnv4NwT7VOB+ThBS
9Rl7IW5ZsviFQHa5ojH8nOgVdGSvvsD6D6em6Pqmm1VFF6ATJ1RHubH6L1TR4+ra
k3O6l+A+WnbVMfYKST0uTjr0yWCuBjllo0QuZkCU3sKbMEpE21ECPtUm0su9JrJ/
+QOGV0jQcpz2xaBMM2rBu8o3CCvX0x5BgMATr6EiQts23/Aa5TE=
=5XYa
-----END PGP SIGNATURE-----

--hircdko3mxt6dm5b--
