Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45650220F49
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007404; cv=none; b=P+ELImDMWN7BmZpTl1CAmFzMbzfcegHH2ojtai6iGAme9+/rd/sD88e2+flJHsZxkZRDV+FnU2YEDxCIZSk9rZ70XpJsjaQoIPgyYFrCXbLCgZ/dWPk86ZZhtKFZTw/+IeVvKr5az5LoT6jHUfikZsqynZyZW3+RZ86Q9DnTH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007404; c=relaxed/simple;
	bh=NEJGD43XH5BSGb7KuwmA+uh1Z1iqNjSi1wfPiJ/22Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7U/fKeNX76PIg+7iOsffB29fYRHS6Bggd44XprhKKCtfi8HP/orP6jkShH78aWvf9un6nKPazU+x6dwqtn0NMVRmbUpcX3YEgmKZt8lI640Gs7EfUdSaSTFjymoe4JPo4Qek79gfcus2U/2ajT35IulIMPrOgIBoHIc8jG/q1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2oBMlnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2oBMlnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDC91F0089B;
	Sat,  3 Oct 2026 06:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791007402;
	bh=H9ZsyqmBTz95iu2q123/kdiHNfZZc6MkE2yvPHe2zLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2oBMlnUpQIEX/DeEo05wnke1qJWkBtC3wQd1BzkpUUsEs5LcNk3Gc93NmsH5TO19
	 r7zYlYz79/YThLbnG+qmbUJo8oxG8oGLEsCOq7T01+WydW6H1eYmrIZ/SxIDeC9RgG
	 Yp2wbFzdXNdpTYmqQjvL+ZXaB+ZU2JWV+irhhLwp+/3GvldWVacLO4aCDh4UX5NrHh
	 LVME8215AP2FI/8s0FyLw1mWP6Jr+/hguS61aB9uPsDNhc7r+MXlZbxhjRlHoDnrgC
	 CjrYCu/1T3Rnw6KX5c1LRoNdKK2JefiPKry32hpXtf1jmSymuXUbQeijyc23Y2uNQs
	 WKk+/XLocH65Q==
Date: Sat, 3 Oct 2026 08:03:18 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <asCaIXYuZFdlFU0J@debian>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
 <xmqqece7vimq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7wqoxxmwryqg7amk"
Content-Disposition: inline
In-Reply-To: <xmqqece7vimq.fsf@gitster.g>


--7wqoxxmwryqg7amk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <asCaIXYuZFdlFU0J@debian>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
 <xmqqece7vimq.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqqece7vimq.fsf@gitster.g>

Hi Junio,

> Date: 2026-10-02 15:32:13-0700
> From: Junio C Hamano <gitster@pobox.com>
>
> Jeff King <peff@peff.net> writes:
>=20
> > On Fri, Oct 02, 2026 at 11:49:01PM +0200, Alejandro Colomar wrote:
> >
> >> Is there a plumbing command for retrieving the bisected commit after
> >> a git-bisect(1) session has successfully found it (and of course before
> >> resetting the session)?
> >>=20
> >> I expected `git bisect next` would bring me to it, and then I'd rev-li=
st
> >> HEAD -1, but it doesn't bring me to it.
> >
> > I'm not 100% sure, but I think "git show bisect/bad" should work.
> >
> > As the bisection progresses, we advance a single refs/bisect/bad from
> > the bottom of the range (the top is multiple refs/bisect/good-* refs).
> > So at the end, it should point to the blamed commit.
>=20
> The only code that gives "is the first .* commit" message is this bit
> in bisect.c:
>=20
> 	if (oideq(bisect_rev, current_bad_oid)) {
> 		res =3D error_if_skipped_commits(tried, current_bad_oid);
> 		if (res)
> 			goto cleanup;
> 		printf("%s is the first '%s' commit\n", oid_to_hex(bisect_rev),
> 			term_bad);
>=20
> it is fed bisect_rev only when it is the same as current_bad_oid,
> which was read from "refs/bisect/bad".  So I think you are right.

Thanks for confirming!  It certainly works for me (I've tested it).

> [Footnote]
>=20
> There is a last-step optimization that made me double check the
> code, but the optimization is about not bothering to move HEAD and
> not moving refs/bisect/bad pointer.
>=20
> We have a three-topic branch X, X is at the tip, X~1 at the middle
> and X-2 at the bottom.  X~3 is on the mainline.
>=20
> ----- X~3 ---- X~2 ---- X~1 ---- X
>=20
> We found X~2 to be good. X is bad.
>=20
>   $ git bisect start X X~2
>=20
> We are asked to test X~1.
>=20
>  * It turns out to be bad.  We move bisect/bad to X~1.  And then we
>    report that X~1 is the first bad commit.
>=20
>  * Or it turns out to be good.  Then we report that X is the first
>    bad commit.  But we do not move HEAD and checkout X.

Indeed, this optimization is what surprised me.  I expected it would
move the HEAD as with every other git-bisect(1) step, but the last one
didn't move it.  I can live with it, FWIW, since bisect/bad contains all
the information I need (and anyway, I will move the HEAD myself, so I
don't need the HEAD in any specific position).  It was just surprising.

:)


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--7wqoxxmwryqg7amk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrAmqYACgkQ64mZXMKQ
wqmx8Q//Y9xvQhfgx8JEyKFNQowvakQpUOSDA0VwVD1AR26Zt4LOH5IgYXHt7NsF
EYniP+q/L4xkUA1R3UTeEnz0BUTbh2EgR/QeBBUUCk2oD6g6bGbORoB+z0Eg4Ukq
HZGzNUq3YQrgbiC29ywnjX++3ZjwwGRZOJeKFnFX+FpePJ9JyTMSdtVSDn1eeQTZ
6bgm+yk3/Mm7p262wHAjT2sRue1kIJZXcKujsolboWrJ29vOLYvp6d8kjsryIxbO
nsvYK11yLgFV/yziwQqQNAdJ6OK+/kgcuVRFZyviZ3AFtvbRYb1LYvHTp4K7ivfg
mqE8k6zOE3hyGH88zSLPQbkmB5p2INemIlH0s4/WrUP5FoWAvR2hRn1V3IIkKL20
F7rVQHE/uESWpExhV5CeyPXI1WY3XYLdhmSibyUFp6LXPcCk5Vp7JsS5utqVWqcH
StAlK2reVMHIywNE8sUelQr0ZwgVwiVlDI3YB5z3hMmGnukS9Cd3zyUUyeaxlpBe
niOxxOByfG7Gm2lmFFmC5B20xnFP4Q75n6LnN/mys3hMP+sWLbZBIVG+HChbNOgE
QZ+uydBmTPjM/RcINmTvJgiaP376RdqDFkPYksdy9HlTMkZPf+tPlnZzv3rBMDg2
J1MUwAOATxk3VK+IP/Cp13ohA73I3SyPXEWW7sHnraeYZ48sRZI=
=u/ku
-----END PGP SIGNATURE-----

--7wqoxxmwryqg7amk--
