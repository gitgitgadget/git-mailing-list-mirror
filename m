Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1145338D
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728258459; cv=none; b=uW8Ed0F4aql2BKR1vm1n6ndyyBfefHb/2mNyUYpT+R7J5Lel/MNDECeGYmYXE56fAAqz73qB4pCZzCVyHWUXy12k/6BONgzWiXhnDfxK/mPKrKlr3PLsYY5vpkPtg9wIQZ6MH0Y4Um4ertPsygNLrvpIdnpbJV6+N/qd9xx9OK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728258459; c=relaxed/simple;
	bh=3fH9e4KNYxqAh5DZDh/noFxHJ6AIJenX8rEV8RYxyuY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnScOPcpiYO3yzqm/a0u+4eb9hbv/Izsvn8haBwyjULkkG8xpNugnnk3cJu0odb5lpygNRFzl+swhdqJLh1m/ObXtpujRh3kzdo/EL4MIRWgzKQIzP8qi/kBE2abRMn5WLxrr2FNMoMogbrzT8KgQfD49mcGkjWkefDOyESoOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rB8yzHqT; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rB8yzHqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728258454; x=1728517654;
	bh=3fH9e4KNYxqAh5DZDh/noFxHJ6AIJenX8rEV8RYxyuY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rB8yzHqTOwmK3EQYsJDcDqrV0r78YTE1aI0jwBRTiN08YghYVqBsrFZHvj4YYbsIV
	 kxYDy771Pzpwcd4I+mvc6jwOgm4PSsJ1OEwk0Kzwkgzex92/7XGpBM4UQ/3Pq/Nzds
	 nqPc+13M9T+BDSWV8E7+wNjjcenug1/6cmUc55xJJssNJRkq3eBcCMHPJuoWLOTMyU
	 D9LeB7GSahIRWCTUa9WOcb2/lbcnd4oIkfMiFHVn1RPMfy5V0I/jDx74OKfEjZnUOi
	 yFmS85pYD4WIJaGQ3seKy5G5L/CR+34cUmtD60+l4+aqplCDH1xi/pSTLZcDcwLjjf
	 uNTR936jNS0UQ==
Date: Sun, 06 Oct 2024 23:47:31 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <Exjb4s8fML6YqFE6Nkf7SQoyvOJxinkwuk-V_TRJvjl5yRxDrrn3rRsPHsnmXqfuu2zFasuP26eO1A8MfNo7shKbIlj_YsPx-mzvelinkPw=@pm.me>
In-Reply-To: <ZwKoNg-HYGaohvCd@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <ZwKoNg-HYGaohvCd@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 9b07d110ad87831e975ce05a2c88b77a2366bef3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------3c7e4fbdbc27a0787df30cc74f41d9cdd3d9d59c0abaf38f1240a14f13d1070e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------3c7e4fbdbc27a0787df30cc74f41d9cdd3d9d59c0abaf38f1240a14f13d1070e
Content-Type: multipart/mixed;boundary=---------------------6ecf977b0dc516c66fc99f60931af003

-----------------------6ecf977b0dc516c66fc99f60931af003
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 10:09, shejialuo <shejialuo@gmail.com> wro=
te:
> I think we should first say why we need to add the change in the commit
> message which means we should express our motivation in the first. It's
> wired to say "I have done something" and then talk about the motivation
> why we do this.

I can reword this commit message.

> Because we leave the life cycle of the "inferred" to be outside of this
> function, we should not use "strbuf_release" to release the memory here.
> Make sense.

Yes, however, I just realized that I should likely reset the strbuf when i=
t
enters the function (or before it is written to) which is similar to what
the relative_path() function does.

> So, we create a new variable "git_contents" here. I suspect this is a
> poor design. In the original logic, we will do the following things for
> "backlink".
>
> 1. Call the "read_gitfile_gently" function. If it encounters error, it
> will return NULL and the "err" variable will be set to NON-zero.
> 2. If the value of "err" is 0, we would simply execute the
> "strbuf_addstr(&gitdir, "%s/gitdir", backlink)".
> 3. If not, and the "err" is "READ_GITFILE_ERR_NOT_A_REPO". We will
> call "infer_backlink" to set the "backlink".
>
> Because now "backlink" is "struct strbuf", we cannot just assign it by
> using "xstrdup_or_null(read_gitfile_gently(...))". So, we create a new
> variable "git_contents" here.
>
> And we will check whether "git_contents" is NULL to set the value for
> the "backlink".
>
> Why not simply do the following things here (I don't think
> "git_contents" is a good name, however I am not familiar with the
> worktree, I cannot give some advice here).
>
> const char *git_contents;
> git_contents =3D read_gitfile_gently(...);
> if (git_contents)
> strbuf_addstr(&backlink, git_contents);
>
> Even more, we could enhance the logic here. If "git_contents" is not
> NULL, there is no need for us to check the "err" variable.

I was trying to not make huge changes to the logic flow, but I suppose I
could revisit this if desired. I can likely move the `if(git_contents)`
to the start instead of being at the end. I was not aware that if an err
occurred that the function returned NULL, I thought that perhaps there was
the possibility of git_contents being filled with something and an err sti=
ll
occurring.
-----------------------6ecf977b0dc516c66fc99f60931af003--

--------3c7e4fbdbc27a0787df30cc74f41d9cdd3d9d59c0abaf38f1240a14f13d1070e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAyGFCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADOSAf7BkfXHbAsVQiiGoISaM2E9GBjYajLW3k0dhZnZRelEoxm/pVK
Uusc3bwmrSKQP5+kloudBzF/KdAIRI6OJXrmzXM5tsKCXxxQREWMZieEa9nL
yGhnPOi9DMnpm84HXRclJXrq4e1f4XXwtXcpHL/N9d+GIwTYQJmZGojDqn+h
qhBMNNg5g5xHMTIRLxYBfAJ7EdgYAkU0MTkte61DItyopAtanPXTfhaH9deV
ntspHK6QbFE8aypUurhfHRtRkOSXc7SaUWdu9cuxvvJFewxwsUDldvaphz3t
kl4He9SMUzmGpvAzscXBgPy3+bFKOfr5YANpOuBhvjW1LjVgK1XZ2g==
=ydWE
-----END PGP SIGNATURE-----


--------3c7e4fbdbc27a0787df30cc74f41d9cdd3d9d59c0abaf38f1240a14f13d1070e--

