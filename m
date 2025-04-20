Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849271DE2C4
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745156252; cv=none; b=lmPUa9TQg5rStEoBpmRC+a/mFr3KecHbI2rAK3YzjViYJ+Ij5uRMGFK9f/PHGV79/bdimmw2LHr77aqN+BNQH+VlWjhC2OhRkwFNpuo8YpYwLrP9cZPWxuULh3WILNZR7IV8SR+fchVI/DaNWIj+CGN39WwlRv4Q5uUOu+RyHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745156252; c=relaxed/simple;
	bh=xUPz2o+xoNl/42S7Yu2113Ge/C0RTDgQuI8GFq8yMFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDg0t+LOv15Im855FnHI64qYRayZVSv9SFrvvBaGHTf3Rgn7gTFUybeuWmebuASZAG4x2uyIcR7gxsFDRR8hB8a3bvrXIRjLqeOFMOIwrTMk+bdkvUrOJbCd3hduse8Q2uXRgYbqOWAD3ipFwcoewntH2ZmX26K51TSnVBP0fMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Osnrk4p7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Osnrk4p7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745156241;
	bh=xUPz2o+xoNl/42S7Yu2113Ge/C0RTDgQuI8GFq8yMFI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Osnrk4p7nI/bSM5kbx24T/W5Zv+TjxVuAyh9jS/Mjnbimx36TCXaFl3E2zgvx9rZp
	 kFkoejLwUswYZQxOkCEBTY2JLwbW/Gi5yklfSBCFxHaAMYSoHKybv5vcQaegOCKINM
	 xnrB854hOlxnpN34eH+mDn6rt0dec+n1t+7u2Bp4QNlPdiqCvYFtck4vG2HkXgx21L
	 RWFz9r8B53UNe+rjyJ8wZ0oPnQ7VhGUlwgxeyjMuqxNCyPm050BnwtAlTIwlX2iYV+
	 ZSYeJnxASkBRH+wtfMvZdRcz0kvzLAWL69MDRu8DkYx+jYVd8isVZ5tz5j2752wWBJ
	 98i/gDGcw9g0dQDmTeBMomf9kOf/pCu98M8ybcQNHp5Fo2yeQScuahCNpoKsNGp9vP
	 ehMJceGRmA7JMQTQ+w4C8kTp0w551AhQDZeA2pqdqDFCYI3qcVvBO2NaK5DutdjSnX
	 F3HNkK1bH69Q+1UB6d12eBp2kX4Sl32OruXsKxWq9rWYw4XWWPS
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E25C920107;
	Sun, 20 Apr 2025 13:37:21 +0000 (UTC)
Date: Sun, 20 Apr 2025 13:37:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Markus Raab <mailinglists@markus-raab.org>
Cc: git@vger.kernel.org
Subject: Re: unwanted interaction of git stash and cherry-pick --abort
Message-ID: <aAT4kHFPEb5qwoMv@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Markus Raab <mailinglists@markus-raab.org>, git@vger.kernel.org
References: <d8c1df4e-a4d7-4c4c-be44-b13de3d9ffea@markus-raab.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Sno+jnt5j42SwB8"
Content-Disposition: inline
In-Reply-To: <d8c1df4e-a4d7-4c4c-be44-b13de3d9ffea@markus-raab.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--3Sno+jnt5j42SwB8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-20 at 13:14:31, Markus Raab wrote:
> Dear git maintainers,
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> git init-db
> git commit --allow-empty # needed for git stash later
> echo a > a
> echo b > b
> git add a b # some arbitrary files with content
> git stash
> git cherry-pick 170bbe5 # any commit that cannot be applied, e.g. the
> initial commit here
> git cherry-pick --abort

Here's the exact shell script I used to test this case:

----
#!/bin/sh

git init-db --object-format=3Dsha256
git commit --allow-empty -m +
oid=3D$(git rev-parse HEAD)
echo a > a
echo b > b
git add a b # some arbitrary files with content
git stash
git cherry-pick $oid
git cherry-pick --abort
----

> What did you expect to happen? (Expected behavior)
>=20
> That a and b are still there or I am somehow informed that the files a an=
d b
> would get lost.
>=20
> What happened instead? (Actual behavior)
>=20
> The files a and b are lost.
>=20
> What's different between what you expected and what actually happened?
>=20
> Loss of data.
>=20
> Anything else you want to add:
>=20
> Everything fine, only the content of a and b is lost ;(

I don't think these are lost.  Because they were added, they were saved
in the stash with `git stash` and can be recovered from there with `git
stash pop`.  `git cherry-pick` won't have done anything to modify the
stashes and in my test case, I can see `git stash list -p` shows both of
those files.

Is this also the case for you or is your situation maybe a little
different?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--3Sno+jnt5j42SwB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgE+JAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ93lVomuYDezFjtTT7ehLwSaXeKzXG+8/QStclmdzTQJ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAEmcAP9a8PIZy2ajeE7+wHUqtTGzcXoc
Q8NYY7MGvi4EUb0TkAD9EzqVylXv83HYRa+12xEla3Nxlgt20DjcqI6oSpAGMQc=
=Eewb
-----END PGP SIGNATURE-----

--3Sno+jnt5j42SwB8--
