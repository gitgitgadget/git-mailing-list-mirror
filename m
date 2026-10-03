Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CD230BE9
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007189; cv=none; b=Y1XwFd9ZuRjGAnTtA3jlwqZ9lFFcJUZaD3Ww3WGgnMhhPc0yW7eLtYLLHW/Kaf16t161c8wfQb+nL+rd742TMumnetRCyHF0+JUACmPfy0IQ3wclNsK4hO9Wt/X0OP0xm0nnkUyV9zivd919qlaDZj3P1c3vn1T41HWJHM2kmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007189; c=relaxed/simple;
	bh=ar5aG0FPXiXcKwgTqo3uqzKfjZbxSmOjMFVbSKly+dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgEriHidAoM4AncSdxyAORLgsqvaW5ap73cNiw0JdqVIJsHfLK0WBoMcVZYSQAUBR3Jhj/SWNvfTVja9ODIntgHw2rUfklVgS/PE5RP3BsDn25ypd+8xpEWLDvOcsl2Upwo4qIFl1NDW+mUFEI0KvlwVvSgGT2L9C8STqHs1A1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxkQQQFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxkQQQFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48E61F0089B;
	Sat,  3 Oct 2026 05:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791007188;
	bh=v7a3fMPPwX4x+utgR9fLUw2XSMxxh2sIHrYIiHv0WzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxkQQQFjrWzJHxs6WRC5eNi6rX/nzBNm9EWj7fZ3hoOJdYOheP3/61OL3IIudTYVX
	 +yAb2t7lym2Jx7CVScK2hAOIlb6EY4FiwUdjJyu1F5/4KND7AuFsg8A7I/Rk6dPOWg
	 maLQycFv1NfeTtLkubn1wD4s08H5uckKJhMpau74HA+9Eeu5hXjZYdzK+iwNgiawge
	 lRb6JNvF+g/JBzmqX04xU+AxIqrX8xxsdPMOxzgaBWvFrRw1pwbSbwJrnOCB4mauN5
	 rLdA5A+sO9sGixfKO1P5bEvbiwhn82ZAEIDdFYMSv1siU4see7Oi1q31fbgHHmORGc
	 LbQ8sI6r4/nBA==
Date: Sat, 3 Oct 2026 07:59:43 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <asCY8kLEV4OAG1BG@debian>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxt6cdftgzvqxglf"
Content-Disposition: inline
In-Reply-To: <20261002221154.GA833115@coredump.intra.peff.net>


--bxt6cdftgzvqxglf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <asCY8kLEV4OAG1BG@debian>
References: <asAbOSQ4BkuCTPY5@debian>
 <20261002221154.GA833115@coredump.intra.peff.net>
MIME-Version: 1.0
In-Reply-To: <20261002221154.GA833115@coredump.intra.peff.net>

Hi Jeff,

> Date: 2026-10-02 18:11:54-0400
> From: Jeff King <peff@peff.net>
>
> On Fri, Oct 02, 2026 at 11:49:01PM +0200, Alejandro Colomar wrote:
>=20
> > Is there a plumbing command for retrieving the bisected commit after
> > a git-bisect(1) session has successfully found it (and of course before
> > resetting the session)?
> >=20
> > I expected `git bisect next` would bring me to it, and then I'd rev-list
> > HEAD -1, but it doesn't bring me to it.
>=20
> I'm not 100% sure, but I think "git show bisect/bad" should work.

Thanks!  It works.

I guess the plumbing version of it would be
	git rev-list -1 bisect/bad
right?

> As the bisection progresses, we advance a single refs/bisect/bad from
> the bottom of the range (the top is multiple refs/bisect/good-* refs).
> So at the end, it should point to the blamed commit.
>=20
> -Peff


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--bxt6cdftgzvqxglf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrAmckACgkQ64mZXMKQ
wqktTg/9GofwNLSbLcg1ND3XWwf9VN1Om1oXYQBNhzwGgpiRqTA1awuQcrnhDLA6
xhcmwCpafW26HzbDLej1tDt8xQGNmRd58EmUGGojOSdEeaPEVjQu7rfIUalwjEiW
HGZFKtzAZhE8JmCboxFovaHGfORixvl6veT5QO8aOhKbgPCmSgWUirk4YliutoIb
pYtdTfPy9kKnY91cObSRT/t3qx29SDNDv2qjeYNTet7IgonDnTJUsb5ddbUnelZI
Z+ChHirh1GQPQxmupVK5atukVh2hn92ZME9FkB3jgX+hqNILJwJDQ5madHN2yQG5
TeFBCCqU3j09+KARiQYwmn6JNg2qsSeB3jsXxFip925JiLZcRZv/fDMF5gjeNrVQ
ct11IDznDnOLQXXIKl08E31ukFnhZ5NVFcCcgjoekdKG7taNviSPPtJrRgD5dABJ
I6zzgZ3JIiQN6huGntgV/t0HmFBsCzbylYV4jIhIan+103D8RmvgaTJNxKyTUwVM
xmXlHxAxPEgGMHEMqfAcNF2nwtPeh6kxKMyUuo4iGwGK3xFUc+lXQR+YjZOCCeep
t3Xl20fuugNHXf+qFwQUU/cfctcdHomG4x3hNwviIK6J2JcKhrUsPL9FAfZsf6ZA
8XQZKlPQHIWs/aKbqBrpeJ/rlzdJit1IvYDu+LCCcCxlQoCnp0M=
=IDX5
-----END PGP SIGNATURE-----

--bxt6cdftgzvqxglf--
