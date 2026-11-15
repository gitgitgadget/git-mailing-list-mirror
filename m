Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759873;
	b=BIgIom82Uahix+Lr/u2Loy1oOVUt+jx5Qdx8x77bv6n8eHOUwQZWQjKgAjgtUCEWe8uV
	 tCZPqAf3u2wgUSekegmNiGzM58P0q3jSISeCyhMamawsyXSAr5bTCuuA2vQMKFS0nqLLJ
	 jLTuUtIZ3Atl9xnvB2coySN3YAHjb6nTXMAwuD0Hsw2+zc/VoaCtKnpTJH8ybokJTIcM8
	 gdKZ4hTPJDphQNCN+Cq/XKAxspR2xWAy2CpQvE/qR2uVMt3ex0WCdRsXCaKZTTZD4shUq
	 e7FVnECVRuzzPqneBQwiy9rK6qsBnvT1QXSrpBeE0985ngCvTPY6uGNxMf0Oej5Dt4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759873;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=dINMq3iTJ++IWlBTja7D2FcDd14bvTrcBY7n7yu1QnU=;
	b=DadW6kbQ7jwIrLE0I5S5wkafTooIrJSZYRKtG3PbWnV0AS5zwwASee8UECpvJca5eZjb
	 +j1c9YYKcY5NMr4jqVnepo2Q3LZOGN6gt54RAWltk8+atEFrFs48BMuZck7GV2Ftx9zCH
	 UKWL+0jCmbaqwo7SNZ8esByig3Za2Hi58Xyo1gL9Q8nC41G4IDdzWdp8xmh0Bz68bjh/j
	 aCTtcro9x9ytsJ+9hBfzsMAGqQzaFQlm4Pe5Yh9pm1QGYpD+HeUL1s1OYJbe7z1YSOVvV
	 1Nm1FON5TOzXPboJ/ACghs+SffoZLf1tyCle2N/jcR5JmTBxlnixvEIn0rJ2h62Muug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=rKpDLP8j;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EC606A327
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 16:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79EC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=rKpDLP8j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794759866;
	bh=1J5Hf66MQmJ+0rfRIA8L+52u4U2QSFsx3IwO4tYE7GE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rKpDLP8jm3sSnMiAAFLqckj/xCPgtVojiYm5I6xF1RS5IZzDqFrwnEwb6CUpk0rIz
	 wIYl7M14zL0gTSL9leIRkYz+3D3Y3AWZcKlLuzIx9JcN7j5rhDngwyKSCaZXStNAN5
	 gcJYj7oQ23bcKjgPR+IbmoDvd8gaIr4FH8zGlYB9eAs/sB/mQz/i5loEZDucQADc/8
	 1gg47ZaKS3V263JflOfFNdxsdXF+P0OlHb6NUYwwlxffezOWex2/iiVoqXThg7a+Pq
	 2JazdW2SmidtAEkRt/kNumMi0wVDMGmBs7OAc3QlNMzOr9ElLSCZeiNHie3PS9sXRs
	 Ut0X+rkuAJPGHcQzp027eaHMSB08SB2JNHsoCApZ1xI/KqAP/ZumPhgl2olPfGew7J
	 +M2egoNt6jWU0r7C/0Vvo4cVDs0H044KKE88F/eY7fybsh2xY2Ra872laCXfWqWVOD
	 edk/z3mZMjHZn9PhzukX6q36p0EwW60itST2QCYLp9bJRj/vCl8
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ebc9:13c:f282:e7b2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E7F9E200AA;
	Sun, 15 Nov 2026 16:24:25 +0000 (UTC)
Date: Sun, 15 Nov 2026 16:24:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ewout ter Hoeven <ewoutterhoeven@live.nl>
Cc: Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
	gitster@pobox.com, phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, nico@cryptonector.com,
	rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
Message-ID: <avnct0KGKN3a76lB@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ewout ter Hoeven <ewoutterhoeven@live.nl>,
	Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
	gitster@pobox.com, phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, nico@cryptonector.com,
	rikingcoding@gmail.com
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <adWTKt20ISC3qz2g@fruit.crustytoothpaste.net>
 <GV4P192MB328727D81CAED2956E2C682BC07D2@GV4P192MB3287.EURP192.PROD.OUTLOOK.COM>
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
	protocol="application/pgp-signature"; boundary="YUXQPdstHNQkas1A"
Content-Disposition: inline
In-Reply-To: <GV4P192MB328727D81CAED2956E2C682BC07D2@GV4P192MB3287.EURP192.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.4.1 (2026-07-04)

--YUXQPdstHNQkas1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-15 at 11:03:05, Ewout ter Hoeven wrote:
> On 2026-04-07 at 23:28, brian m. carlson wrote:
> > Absent some well-defined documentation describing what it means, I don't
> > see how it could provide good value.
>=20
> A concrete use case could be stacked pull/merge requests.
>=20
> GitHub's stacked PRs (CLI in github/gh-stack) and GitLab's experimental
> "glab stack" both have to answer "is this rewritten commit the same
> change as before?" after every rebase. Without an identity that
> survives rewrites they guess from branch names, recorded bases and
> patch IDs, and the guesses fail in practice:

I don't think that's going to be helpful there.  Users can modify
change-id headers in commits, so they can't be trusted as a source of
unmodified data.  Only if the server does the rebase can it have
confidence that things haven't changed.

Otherwise, a malicious user could get a review on v1 of a series and
send out a completely different v2 with the same change-ids such that
the server would honour the existing review and accept the malicious
code.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--YUXQPdstHNQkas1A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmr53LcJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZypubcrOgtSsYcKx9MtXLAt6phqzEOgjT8w0vdD9qgBr
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADmcAP95gi1sWfwPy7cZg2jS4ubdCN9I
+bRluE72wLj/IfT/zwEAo3YO1wqBVTdnRXE2KQp25xD0cPLmrTSGqdJeBA8WVwA=
=llEe
-----END PGP SIGNATURE-----

--YUXQPdstHNQkas1A--
