Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A9323F42
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060885; cv=none; b=QUWXOxtN0sC35H/2pwUljZ2x5u92pGzfbbTEBeBLXRbsl5akGFrFTb14AkgAe1nXj/cae0BGQGLNyh/EzmnnyUQaMSwX6Tj74nRp4cwGZeodClEXuK6NrMrHPIycg4IoW44+y8S22ZsOjp2MM0I2A0ZHglxU+pcxauHJlWPjGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060885; c=relaxed/simple;
	bh=b9ioL/8H3jUspLBvhW97NuuqoXYmCddcuRgoENoSsAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N06+xtvsJMdK+jV+LlqGtvFt/od6XIRqo/UVvS/MLrdrNjs59DYHa10XUdZ+p/ui+K6XXTGPHGiSwJ56HEqvcLHrPYnEXox6A1Jqg+cD7MosQslZTcLMML4xe+D0K+uNFG0UhkiUSv0fHsDjcHqdbI48dAbocGFEpzLILzqo72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZvTNKvw1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZvTNKvw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758060876;
	bh=b9ioL/8H3jUspLBvhW97NuuqoXYmCddcuRgoENoSsAQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZvTNKvw1ulCT+46/X8cBRZArWtM4Q8Vjl55ppMzCoa1WaL5tOhWOCj9ufArU/XwMS
	 McaArSTVPVCLtnDHvj6wvSUp0LttQdNVUejePX82p1bM7PzQt/n58v/NcNhGLBEI2i
	 eJeWbK0vy5VdMJw6oT+9feKoB2HP10HpsaFt8CZ8FvCCMHTXCX3myROgJpARAFwAKZ
	 tvajU4qX5TRfNzK/Baq0kjcbbfO63r2R4Ew6yRVryf1LMy7CZWCXQmpBpoNoP9u6P5
	 ZQiuZDxm4zcBhhzdbzD2QjG5SFaEYSNqrrwuvi3nwcxWnmnh5Dk0+HPxlSbCHKhnnV
	 ZdMRi/IvjTxZWYv/5AKYqM4TCOkwVFzUZKA3S7ASOC2Ces3FelEVRloa9MsArWv3Cv
	 g2Ult5K8tvPfITMd+/DW2p8XLzSXU5nDPmi5m6Gy6LPtCMTrrCLEZjzAEw/2QOOhhJ
	 ICOW30/0Gn3HHO0bvvpS1cC34BS4kvyE2lm/svf7blMOoFVpqYZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:838b:b45e:5922:53b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 308C220105;
	Tue, 16 Sep 2025 22:14:36 +0000 (UTC)
Date: Tue, 16 Sep 2025 22:14:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Antonio Mennillo <antoniomennillo87@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git-rebase-clean: =?utf-8?Q?miti?=
 =?utf-8?Q?gating_a_=E2=80=9Csemantic_conflict_cascade?= =?utf-8?B?4oCd?=
 during rebase
Message-ID: <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Antonio Mennillo <antoniomennillo87@gmail.com>, git@vger.kernel.org
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/fZtFXfrDUXC9kCh"
Content-Disposition: inline
In-Reply-To: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/fZtFXfrDUXC9kCh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-16 at 21:39:46, Antonio Mennillo wrote:
> Hi Git community,

Hi,

> Problem (observation, possibly a known limitation rather than a bug):
> When rebasing feature branches whose commits are semantically interdepend=
ent,
> Git replays commits one by one. In practice this can trigger a
> cascading conflict, similar to a loop. Example:
>=20
>  - Commit 1: add interface IUserService
>  - Commit 6: add UserServiceImpl (depends on 1)
>  - Commit 11: change IUserService signature
>  - Commits 12=E2=80=9315: update implementation/tests to match

Usually we would recommend that each commit be atomic.  That is, each
commit should compile and pass all of the tests, so commits 12=E2=80=9315 w=
ould
be part of commit 11.

> During rebase, conflicts may appear at 1 and again at 6/11, forcing the u=
ser to
> remember prior resolutions and reconstruct intent across commits. If I=E2=
=80=99m
> mischaracterizing the model, I=E2=80=99d appreciate a correction. I=E2=80=
=99m sharing this
> humbly to verify whether this is expected behavior or if there is prior a=
rt I
> should be aware of.

Are you familiar with `git rerere`?  I have just done a complicated
rebase of this sort and it remembers resolutions for you so you don't
have to.

> Mitigation (userland workflow): I built `git-rebase-clean`, which
> squashes the feature branch first and then rebases. This concentrates
> conflict resolution into a single atomic step with the full final
> context visible. The obvious trade-off is commit history granularity:
> you lose individual commits but gain atomic conflict resolution. In my
> experience this reduces repeated/conflicting resolutions across
> dependent commits.

I think most people on this list will consider losing the history
unacceptable, so I don't think this is a thing we'll want to encourage.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/fZtFXfrDUXC9kCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMnhSgAKCRB8DEliiIei
gQzdAQC/2g22bLrWLYU2chpFr5WRBxDAt2gHzEsW5uVeF+Xi4wD/VEsKdMsOUggH
vsflPFrb8v6yCiV0FWxKJG6AM1sJ0Ak=
=sub3
-----END PGP SIGNATURE-----

--/fZtFXfrDUXC9kCh--
