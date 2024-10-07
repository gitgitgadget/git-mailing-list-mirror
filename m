Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5785695
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728268017; cv=none; b=MlYxRvbFJEfjIwGlQix+JI25Q1zXokXziuOuepOVIyZ7LPxVNFnRf+m/mnTIz+DlxATvIEovNsPLniWsO9sd2SD/HSSoz9bQgCRk/7A0+wjLMTwX3YRmy2//AlSuDN/dd+UKHsU3aYeAwir0caaczg81e+1cT3o/NuX78z7kHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728268017; c=relaxed/simple;
	bh=jafok7TP9m++SIDsCcepvOaVOPL9H1jqcgpNl9AuUqA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XC0sM+DduElODjJIE7XPz9HYZH+VHJp/MmULqAqoJ2UJYdCbP1638h3utEAhQsHjxkQuF+78uaWCm6np/4e60DgFZEgu0B6abYa2YOoWapHGsdDLKcXvrjD9xX2ASUXIgIP3ARxlrS+LN+erVBZBLz6oGmsx2xDAjZ3KCbYGaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZMayFMkm; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZMayFMkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728268013; x=1728527213;
	bh=jafok7TP9m++SIDsCcepvOaVOPL9H1jqcgpNl9AuUqA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZMayFMkmSzZVbaOUeLxQ8kjh+unu/TI1rxuoTX4ds2I3W0W0MiIH9PnMnprCwSGD2
	 1i1V34ITT0P9XXQzkrkwP19XY1dORUM241h6O8Nnnio+Qmi4wCu2uNY9DT1IymX9bW
	 MGOCgmuBwl0NQQcGSY74nYx81erh/r3lHkHtSIWrbXBj+RrKbtidR4TDGf/7JK/bQz
	 rOx5/1uxQUVZY4E2jpXUgurD10LdvFORBW3OjUbrDSOjJ7N0KPJQdPK7SYJraT4vgI
	 L0NKW0WScFva4npqp9NaXkUOzdSchET03fJK2s1UqFbAk4KpbfgX1BR97R5u1esnt3
	 YyPpxj0t3lmKQ==
Date: Mon, 07 Oct 2024 02:26:51 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <o7jQV4JUYr2iQtErKFhCrjCySiGn7_I18gmdInKbOC9TAsvqazG0O_fPUtiWZ5UfiGLr25OZ5xvqIhfOIwCG-s1RGgri-BJIdHqiokIw4z0=@pm.me>
In-Reply-To: <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <ZwKoNg-HYGaohvCd@ArchLinux> <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: f1061db6063c18a760f33f60ef1006e31d94f030
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------c7b6229b45148926e3a056325e11d0de1752ca61a6987dccbfd970158714da06"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------c7b6229b45148926e3a056325e11d0de1752ca61a6987dccbfd970158714da06
Content-Type: multipart/mixed;boundary=---------------------9d55193a50c92ffd319fcfe6885af545

-----------------------9d55193a50c92ffd319fcfe6885af545
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 13:41, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> I found the name "git_contents" clear enough and understood its
> purpose at-a-glance, so I think it's a reasonably good choice. A
> slightly better name might be "gitfile_contents" or perhaps
> "dotgit_contents" for consistency with other similarly-named variables
> in this function.

I will rename to `dotgit_contents`.

> It certainly makes sense to check whether "git_contents" is NULL
> before trying to copy it into the "backlink" strbuf, however, if
> "git_contents" is NULL here, then what does that mean? What does it
> mean to leave "backlink" empty? The only way (presumably) we get this
> far is if read_gitfile_gently() succeeded, so (presumably)
> "git_contents" should not be NULL. Thus, rather than conditionally
> copying into "backlink", we should instead indicate clearly via BUG()
> that it should be impossible for "git_contents" to be NULL. So, rather
> than making this part of the existing if-else-cascade, we should do
> this as a standalone `if`:
> =


> if (!git_contents)
> BUG(...);
> strbuf_addstr(&backlink, git_contents);

We can't use BUG because this is handled as part of the err
conditions. The contents can be NULL and `backlink` could be
filled with the inferred backlink. I moved this to the top
and I think it reads better.
-----------------------9d55193a50c92ffd319fcfe6885af545--

--------c7b6229b45148926e3a056325e11d0de1752ca61a6987dccbfd970158714da06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA0bbCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACoZQf/RowCZSB2m/C2MOl+MlhqR9dZnsOLXfJD/9aczz2Kvw4fgIru
7NMX1QExDYKMscAE76ER7zDqM6mucjPQC/bcRvCRe19G9+eYqvwGwxz5xx6B
6984NbtO5DsKYmPfyngrC2U92FxGkDdfnfsFWX1guxwhOwS7cViv51WnT60E
4pBFyJVlvcr5rdXyf5Jv4Cfty1ukJ+j+TqUlisNkokT642kwyoWA5Ak8HYxC
Xorq3QFtb2iMNmT4R4t306p9kW7xYmiFOZvhbq48RFeYBOKoDZVmawgDLkmx
/e2hV8eY+dDLElsFOHZ4MgCIw14SM1AtTeJPIXed1i05BD1Gs8xLJg==
=iyfk
-----END PGP SIGNATURE-----


--------c7b6229b45148926e3a056325e11d0de1752ca61a6987dccbfd970158714da06--

