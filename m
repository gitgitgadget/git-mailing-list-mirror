Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F51DD526
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796136; cv=none; b=GRu0bIxKvHIdFnHRWoOFPJCzXESfVWqPnk9y/KVy0s3IaiMicezQ7m/lK3r22j8VCc2k6BW52S+ee3OnWTJAZgx9t2FlZ4zD6aK0mpWA8GQu+ZpgHB+45A+VQZ3hBLC5HahatZGxWHO65vvKpK7Dvut78nZZ3tTfT8QkyoK74w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796136; c=relaxed/simple;
	bh=4ejimv0SwNfYzSkGRQcxJk2TU56FJQu7NbnPahMv9FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZELNXRNa1E58cW04vVxgOS2DmCBXDBRO+YSAotqM5h5dwcxcJRfE2orBP8Ob6P2XxlVgrgXvwSNC1Qu7Rg5X5PJojxcAEtEqJaJxbhnUzM6kFCUEuYwbC7c+7KeJRg6g7+ilV4rI0NccTQX+WTd/yaaYy/RC7D9QMUng5mb6z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TPrSh0wn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TPrSh0wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738796125;
	bh=4ejimv0SwNfYzSkGRQcxJk2TU56FJQu7NbnPahMv9FQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TPrSh0wntz9FcYkvSO23nlknvTpr2ofPGmFKev0WNAh5puHwY8Bt2cMSesHt2dQp5
	 Uvp+j5MVAIo4xkvdm6QqRs8UVKWD31DPl2g/lYb0BKzhp4LfFBoKtqFdo5ETy4Omq3
	 cULhiiwxcRuMk1SIIf8uqsvH9mZ/D8qOL3a45ZbEcttGpKGRilRDqM9jXSlY9F+8hK
	 Q/Oc6kl4rBDVJmwMY6dCBf8T2j/WPAI0RtZkcEPM5zdCOt17G5u6vVH0IU2QnRNZuS
	 xWxy6+/BLVyMhyYB7XvUGqT6mfwBrd4oLK5PBnv1dfxd2rtZodncDyjycsOrNdSVH9
	 7Z5CN8ajjC/jmezPVRx5nbIzlX1+fnTAaRTLfeMirxBi7WsE0lz4sZtspN34j8290G
	 VnPIpE0frnxlMsAPBjCqQpG63PKh+AWb2xogFt6/aeP0FKTuGj1B39Une29jJN65Jh
	 +EuwC9KEJKuMNRQ/ukFlKlFhPrBq9sov0wouSOMLxqz1m5oH+6E
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CC5DB20067;
	Wed,  5 Feb 2025 22:55:25 +0000 (UTC)
Date: Wed, 5 Feb 2025 22:55:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
References: <20250205214726.GA30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OBgU5rBm4bCKBjQi"
Content-Disposition: inline
In-Reply-To: <20250205214726.GA30202@raven.inka.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OBgU5rBm4bCKBjQi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-05 at 21:47:26, Josef Wolf wrote:
> Hello all,
>=20
> I have set up clean/smudge filters to normalzize files from an applicatio=
n to
> reduce the pain when those files are tracked by git.
>=20
> The clean/smudge filter work well on new commit and the result of
> smudge+smudge+clean is the same as the result of a simple clean, so the f=
ilter
> should be fine IMHO.
>=20
> But whenever I do any operations which introduce not yet normalized commi=
ts, I
> keep getting errors.

Yes, this is known to occur.  It notably happens with Git LFS, which
uses smudge and clean filters, and suffers from this same problem.
Renormalizing is indeed the right solution.

> So to get rod of those errors, I'd like to also renormalize the history:
>=20
>   $ git rebase --root --strategy renormalize
>   error: Your local changes to the following files would be overwritten by
>   merge:
>         foo/bar/baz
>   Please commit your changes or stash them before you merge.
>   Aborting
>   $ git add foo/bar/baz
>   $ git commit -m renormalize foo/bar/baz
>   $ git rebase --continue
>   git: 'merge-renormalize' is not a git command. See 'git --help'.
>   error: could not apply abcdef... Foo Bar Baz
>   [ ... ]
>=20
> Huh? I never entered a command "merge-renormalize"

When you use command like `--strategy foo` with a custom strategy, Git
calls a binary called `git merge-foo` to implement that strategy.  So
while you didn't explicitly invoke that, when you used the nonstandard
strategy `renormalize` (which, by the way, does not exist), Git invoked
it when you rebased, since rebases by default use merges under the hood.

> BTW: It does not make any difference whether I add "-c merge.renormalze=
=3Dtrue"

That option also does not exist.  Can you tell us where you found such a
recommendation?  If we've been misleading people in our documentation,
I'd like to fix.

> What would be the proper way to renormalize history?

The command that needs to be done is `git add --renormalize .`  I think
you probably want to do is something like this: `git rebase --root -x
'git add --renormalize . && git commit --amend --no-edit'`.

You might also be able to use `git filter-repo` to do this in a nicer
way, but I'm not aware of how to do that.  I've CCed the maintainer,
however, in case he or anyone else can provide an answer.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--OBgU5rBm4bCKBjQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6PsXAAKCRB8DEliiIei
gWPUAQCtewrJl/L7IlQsgyZldVP42U0KZOQ1AVRgEgN1IWWfsQD5AcN1w0GZxweB
9/6JnwSePfr7sq6Trm+tKtaxwNagJgk=
=osFE
-----END PGP SIGNATURE-----

--OBgU5rBm4bCKBjQi--
