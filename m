Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264352;
	b=0EN4HAzxsaQJ2Opxf/iHjRvqfbgBvY+hPDlBCV/NYptYFBojx9EXdOSSb7Z8397W+CQb
	 TY92eVC5td00qYiwz6P0jf1NB6yuTB/AOH3mAD9R0g0e6Wbggojirnj0x6pkQ5iZg99Gr
	 L5JQ7hL14eyP4AfLQzL/A4kiGt2eG83q/q70CGH4nIUzL5iDhyIXyNobeCX2KM6/Za6lG
	 X7lI9w4lznxgaHduHrPDFJbI7dtGC/eBpR6kfLPouG9BeZFY53K603ZOI4cW6ulma8s4j
	 wxCFW4BItTu6TucQwagmMAi6mbeixQCH7/1m/SqCRAyroRC5IHAqM73ENjZMgq0/row==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264352;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=6YpxPQLhC5GYhJMZVQU/EX0SwaFHozdIe3HLVp7Iy2A=;
	b=YJIvnOlVYRvUx0iQCtvp3M83ub/NBnx4pWsA7FvAZH7wGITsDJpQ6QiAUDkF7ldeiptR
	 7ZPZ34fSh+gG4Z418fPK+uh4Na9Egg9OsuoO3I5KHQ5o/O53GtEQC5T/lDt8BlY27dUQM
	 MMx/cZqjOpnyiUG2yWi1GiM5AKF7OlWGcE09QociroEs8AxkE1vFYrCgQHylkkVmydl16
	 emV6Ra0DK0BihzyArIamZRY3Kkc6rZIUcX0RDywKwZlM3Bn4rJ7q/5orqqBQmyYauRqgI
	 BNrNx8mK3ShofGIXc6MT6ryvugOhcJ3btdTTpNTHJmLGApjmtY0T3mF6iqM0ZffeUdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=ZBGKecxk;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A831606A334
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A831606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=ZBGKecxk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794264351;
	bh=Awo6HTO698LGlGLbafvjgDCnAcOv4d53ZzhLCxBTT5Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZBGKecxkeeTR7RGXcZaFDf09xXRNfIYElcT0NkNiR9Z8dh90+rUY9LRzFqC2oOgJm
	 83bVEmwoVP95TncRUt+jUUE3aWUFpuip8i6DshjdTx5AQ8CpOP8jm8Xv2K5rCHkP0h
	 wHqbMbglNC0BPw7pAjCEOpO006qoJyiKY5x5t//fIfqQfd28MdsKXSRwPJ+Hp8TK2S
	 Ppb0UPXwLpeqxxy87T8yPN3XZ/C2Brv/eie5LbSxwRKz6HQ/IBoQI9hk0wtdldeBAM
	 F24SfdcJbDViXtQQNhgdrIv2mceVuHb2rOEeg8ZwfT7wWDSbcDuLp0qrWhppceWkf/
	 5M6ExynV7ANy9TMXU/gRINVSANUDxrQxJkJQo01Tq4dwXyeL7OSpv/UR2Hl2ryJBpG
	 j9COoSiDe3k+LttGpG9e9i/KMD08KcULQ8z7dFXByExHLfldtps6pyJuWgVqdXPcLh
	 iZUmIxtgS4sekVj1Yyfck7GfQkuEWLKbcm4HzfUBILVnhAwiyUQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7f1c:2d92:cd33:5059])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 01FC720069;
	Mon,  9 Nov 2026 22:45:50 +0000 (UTC)
Date: Mon, 9 Nov 2026 22:45:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tanga Joris <tangajoris@gmail.com>
Cc: shrimech <eddinen77@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] hash: handle invalid algorithms when formatting
 object IDs
Message-ID: <avJNHSZLiZVffCjJ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tanga Joris <tangajoris@gmail.com>, shrimech <eddinen77@gmail.com>,
	git@vger.kernel.org
References: <20261103043756.61627-1-eddinen77@gmail.com>
 <CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com>
 <au0ZOsuyo0YYyZsa@fruit.crustytoothpaste.net>
 <CAKrRMNqBCiH06xsre-YafBJiqPTiBgPnNZ3xPrhjTQWU3czwHg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q5WZUlnk+C8FYX4l"
Content-Disposition: inline
In-Reply-To: <CAKrRMNqBCiH06xsre-YafBJiqPTiBgPnNZ3xPrhjTQWU3czwHg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--Q5WZUlnk+C8FYX4l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-07 at 20:22:01, Tanga Joris wrote:
> Hi brian,

Hey,

> > This is not a valid configuration.  I have a patch on my sha256-interop
> > branch, 5b208e4a3d34ffba0fbeafe991643d6d47a5caa0, that should make the
> > members not public.  It depends partially on things other in that
> > series, but it should be fine to drop those pieces if you want to pick
> > that up and send it in.
> >
> > If you pass the structure from C, it's intended that it panics if algo
> > is zero.  That's because we don't want to rely on the behaviour of
> > depending on a mutable global in Rust, since that's unsafe and leads to
> > action at a distance.  We really should just drop that fallback and fix
> > all of the relevant callers at some point.
>=20
> That makes sense. I didn't know algo 0 coming from C is meant to
> panic in Rust, rather than depend on the default hash.
>=20
> Since this is shrimech's thread, I think shrimech could pick up
> 5b208e4a3d (making the ObjectID members private), and I'd be happy
> to review it.
>=20
> Could you also push 5b208e4a3d somewhere public? I could not fetch
> it from https://github.com/bk2204/git, whose sha256-interop branch
> seems to have an older version (c38d0c8475, "rust: don't expose the
> internals of ObjectID"). That would make it easier for shrimech to
> pick up.

Yeah, it's in the history of the temp-sha256-interop branch there.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--Q5WZUlnk+C8FYX4l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmryTR0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0MR33g2aciBEV/aANhrvsKBnP+aXGsTwdEXORlfklpI
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALC9AQDlNYSSSwBNaXk2SR/sEClopVcY
6NLJlaNfsBG7JEO72QD/XSGlI95FZPqjpLnJog1Wr6LjoU2ZsMBfk3Tnd0JU7A8=
=ifLQ
-----END PGP SIGNATURE-----

--Q5WZUlnk+C8FYX4l--
