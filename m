Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0071EB2A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738801766; cv=none; b=CMajYnjiCcG753QjqOK4HXpf7SoFs50bNUMtGEkkOoK1IYo1XLUAUm5VGnQoWdp1+/dWO2aNhy28jZS7QmbVPiwcLGniB33xprIzl9Ud/6q4SxHN9q7xjnqtcZ/gq31LkWIi5ndBTgYONh5GOVVo52eFo6sml5eCzXtkjblplR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738801766; c=relaxed/simple;
	bh=clNoyd+a6lMA6Ts9fAyrtFLkIhI4a9FkvuOj/EnydbA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beT4TJwtaR2Y2oirNzL/T8sQ268eOU3/Nnjw5ma0c6+Dh8nhhvPo3e8eF3AczNQN/4YVKQPft3eKGoZfyXgfE5MVAeTF0syV++9R8RmPTCmbJ1bHxHzOAIiqmFBdqNjM0WhTUciUdzLFSMJclKze2Qdw5CY0PgBE9A1dNJwVl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=V9PyFSlA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V9PyFSlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738801762;
	bh=clNoyd+a6lMA6Ts9fAyrtFLkIhI4a9FkvuOj/EnydbA=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=V9PyFSlA8EbVX5LxqefJ82Ty08tnm7xmI3W23UWUlDRWAwiQlkjBKY+wWnU49IbFi
	 ztf8N6CUbkv9wkSQp/0QDfFhWscixB/nbKOnD4wa33iZwWSvda1Rp4uIII2SmSHdHq
	 vqkqwP/OPRusvX657S0mV2ywh+FrbiCVK9ERtq/3YDF4YVJpOE1LDa2miS5tdr/8fo
	 9xRyS2Ju3VswP9eZpCsSotBkOw9BjBDadsiuXoCVjwjOPYvt9zIC8xf2PBfX9+Mj1n
	 xi6DG+bgF2RVbAIIs3rbokIfPT9Y2Jq0gjMLiVUt6tL/k+/N4ovSylUKQMZWSe8yeb
	 EWItj10nrm3L9P75i91zRjreMHbtsIK1d1q2boLiBNR8NNXN6stsDOzfhn1I7uzZeN
	 M1GdbNwa2n9ti9m8epaJdTEKEupaEtCB0ilTrIynClJ+sahQf+xzFVZJahffQXCFQV
	 baa9YiTZlOHAXEeCRkLwf0hEKOjioqRTO1v6CV80uinr+DswDZU
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C1E7E20067;
	Thu,  6 Feb 2025 00:29:21 +0000 (UTC)
Date: Thu, 6 Feb 2025 00:29:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qQcOvIiYgIdMF/B3"
Content-Disposition: inline
In-Reply-To: <20250205235931.GB30202@raven.inka.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--qQcOvIiYgIdMF/B3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-05 at 23:59:31, Josef Wolf wrote:
> > > BTW: It does not make any difference whether I add "-c merge.renormal=
ze=3Dtrue"
> >=20
> > That option also does not exist.
>=20
> Well, this is described in git(1) manpage:
>=20
>    [ ... ]
>    SYNOPSIS
>        git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value=
>]
>    [ ... ]                                            ^^^^^^^^^^^^^^^^^^^
>=20

The -c option does exist, and apparently the merge.renormalize option
does as well, so I apologize.  It looks like it's only used in
merge-recursive and not merge-ort.c, so I'm not sure if it's still
effective.  Elijah would know for certain, since he's the author of
merge-ort as well.

> > git rebase --root -x 'git add --renormalize . && git commit --amend --n=
o-edit'
>=20
> Unfortunately, this runs the command on every commit and gives a warning =
when
> a cmmit don't touch a filtered file:
>=20
>   $ git rebase --root -x 'git add --renormalize . && git commit --amend -=
-no-edit'
>   [ ... ]
>   No changes
>   You asked to amend the most recent commit, but doing so would make
>   it empty. You can repeat your command with --allow-empty, or you can
>   remove the commit entirely with "git reset HEAD^".

Yeah, that's a problem with a rebase in general here.  You could try
`git rebase --root -X renormalize` here, which will use the
`renormalize` option, but you may run into the same problem.  I _think_
with the default merge strategy in rebase that it will keep the empty
commits, so your linear parts of history won't be changed, although
you'll probably drop the merge commits (and any conflict resolutions)
unless you use `--rebase-merges`.

If this is a small project, that may not be a problem, but I would
recommend `git filter-repo` here if that's an option because it will
preserve your history in a nicer way.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--qQcOvIiYgIdMF/B3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6QCXwAKCRB8DEliiIei
gUV1AP4+NTzeG81uTgu3HPXZgr5XIIB0GLtzdSglVnp+biDrXwD9FtB0QKIuUTYm
XR7pfzvwlNntqBLkAfXEVFGm7cFB2g0=
=n5KX
-----END PGP SIGNATURE-----

--qQcOvIiYgIdMF/B3--
