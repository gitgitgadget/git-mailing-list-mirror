Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BA15B0F5
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974403; cv=none; b=Jb8miSzIN0GZsKWQgHCCgsZKNPwSHO3i4ipVWJSpY8NCVMM60gXjJXt3ReLMMb6ZIVOIVPgZsEMBjvoaqpN+IggzRrbXgQYCVdAKktTW5vYf8ZqsEHiDQy/EWPH9Kibra+nVPIWiCUhHS0RvLmmtvTKO1cltiAmL32LujRO16DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974403; c=relaxed/simple;
	bh=OtGDjz6H2gL+b2dEWXoHOj/gRpeOCYnRb4xtx+FLQmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4opr2eydFOjAmtOY1T+aQqhho98R9Bt28N7XOpo0GIitgDuAfGC81fIH67XpQJLsRz9pTCTRFah/fS9F06AeRJd+U8SOU/eWeSCVWSv9j8jYlaIctHHDl6DlwmRDuZ4MYU0nouQxl7JHr0cqLQupFUirW4SupjaW9WTpnUm/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kf4swbXH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N5b/bacx; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kf4swbXH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5b/bacx"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0E9C71800183;
	Wed, 29 May 2024 05:19:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 29 May 2024 05:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716974399; x=1717060799; bh=0Rr1XyQQ7K
	QIExzWo4sDnHHjdkxBuvzcBWHhnJ5dpoc=; b=kf4swbXHcLwKd/SlDLu4in7Sjw
	S1STjfqR3LWdt5Ol2ncaRjjp4GgtFMYLr6zeZVUYL4RhB4P6O+D4ohuMGcR/RlMM
	xnWJTDB2z+F8p5jwfsx5cRmESQbJuG2veXMOIvB8EZtFAa5LMCMwEDG5FqUkqO/j
	cLAWBV1oOugwIDHgbwD9Xb2iPixf/bfKvfo7IhPSRUmVxhLbTx16VL2UQLv9XGOt
	nUJGtFsC2ldvLsVOplxUADDa2xLyyOebiz5A5Gh+5Tm2iJeTmEOVDfS845d2xKfz
	A9QtG3FRFgGxbNFOICBbk4cWT0iP4cVd0c6lhvPMLXt3sE4spq13PqSVy6Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716974399; x=1717060799; bh=0Rr1XyQQ7KQIExzWo4sDnHHjdkxB
	uvzcBWHhnJ5dpoc=; b=N5b/bacxMrMeWQL5j9kD5ffc/X1qxLPRmyrer4WoX+zG
	sw9Z5+3BoDS/gZZDJeriFUdIUCTgYPwTprNpn3WMYqnxhdCcI6GzGIpMxpyCEB4l
	LHp70X7HunfN9gNKZeVbUj1u9zogS3dzUlMxyjUsyiRhVdCOfR+ZbCi7ux8VEjje
	L60TLy5FGsL99CS/w1vFQu88Qp6ZJN5wN1OLqj/3Gc27dMYtdfd43IJBAE0yg2hq
	CZYFXrDrLqy1XnqzdvFr2tCVn6yqE9J4hyrZIJCTZlJirNMZt6DfPDfw6erQNNpY
	8oLy2yzxS7Df42OIRZZbDNUOAJMKlrXRZaO6/aiToQ==
X-ME-Sender: <xms:P_NWZt26IXvPgt6PY9jkt4GQubB9cXelbEnCp_at9QV3bMHGs6L7Og>
    <xme:P_NWZkE68ez5vGsAD6IdcSK30-zTCZanMrD4TooaEakUhRhYGqEhsBIG6dleC0JLS
    chtAoKBXDH5rQNqOA>
X-ME-Received: <xmr:P_NWZt6LWKajz1G774gY-gObAzuEKh807MtYUh0QN4YXAPmZUlc0VqmoGg3TV3dwfLPTKQWcCJvl9GGDdYL3uoWYJ6mZruZ4w2BmxNLTyYgf9NXB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P_NWZq1t6Br4mO0qWxvkveuDMrnoziuX1a2JJJa7jgSqTafPWsAFIQ>
    <xmx:P_NWZgHlP6Xyu6_45uYg6mLJqprheSGBHvK33THzgIj3Y4NPYZOxZQ>
    <xmx:P_NWZr8Dxj-1rf5cO6lVlMoxXs3M7Axb1_y7JNLX7pSOBTljFnvWxQ>
    <xmx:P_NWZtnDXpfImRUExvba153vgOLUyQkBtXEeK9OjWZR0ik0HOJCIpA>
    <xmx:P_NWZr3WkcPpmqMTeJtTqRVCS1Yb2-1HwHyuc6_Sgz1PTho2nHq_XOxT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 05:19:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd17b140 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 09:19:41 +0000 (UTC)
Date: Wed, 29 May 2024 11:19:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: ach.lumap@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [GSoC][PATCH v5 0/2] t/: migrate helper/test-{sha1, sha256} to
 unit-tests/t-hash
Message-ID: <ZlbzOVgvSpUZOv8F@tanuki>
References: <20240526084345.24138-1-shyamthakkar001@gmail.com>
 <20240529080030.64410-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="COm1n8jwkFdWCPTm"
Content-Disposition: inline
In-Reply-To: <20240529080030.64410-1-shyamthakkar001@gmail.com>


--COm1n8jwkFdWCPTm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:30:28PM +0530, Ghanshyam Thakkar wrote:
> Changes in v5:
> - addressd Patrick's feedback about formatting
> - changed macros to be in do while loop instead of simple block,
>   according to Patrick's feedback
>=20
> Ghanshyam Thakkar (2):
>   strbuf: introduce strbuf_addstrings() to repeatedly add a string
>   t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash

Thanks, this version looks good to me based on the range diff!

Patrick

--COm1n8jwkFdWCPTm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW8zgACgkQVbJhu7ck
PpSyjA/+JrV50mgwxYTw5x00mSZb/i8337v/AI9Ez2sp6kssu6avBR9LU/5w2SgJ
NlfqIFtCSAETnfr9pwEVC5MKk1Btk0wKr3QxGyE02eaudnWJK8ppJ5fsI8XcbZJk
i2NQmdSkXDsqxEWz7D8uv2k+w5FGtCyS7GAI3TRKyvRTZMYn1SiGs+3nzMFtpEUZ
ddlV+a6fcy5i6XTQij4FzyG3dKiDnvweXOR+j59WKXBTJyGl6he1tCiZ8w5X1F4E
60zPvq130P+dqvEyaHaDeSuoMUM1wyf7Rt2ouTLvtw/MDi/Yi/0kgq3EbMjtTRpE
j8jPwhsTq1398zk1+wUnPnqqB3GG44J0lF6BxZUrfbZ86zbAF1waHyalBGrzkFuE
OahjM6yahxvGfePCAxxJLjdsfI3mAJoz+Yaeek4wLmy92d1AKKqJrzhQrfyMIBmc
zeuK3Y8T8LavAtKdoJmWF885AX7dem5mDLpsWlLAtRRbTaxPhkTilgtZtWa+578+
VCx1odzQoN7Vshufm0T8f5hvwSAUnrXpM2OW4js1t1sjroCwpDWZVBPkra0SXUSm
Frx1tHdzAKYreZcSgbLnVtwIvz1Epuo9wbr6V+YgRu6MeI3GvGNJn6vW3np5NfsD
Rv8XuBDzpyUrnav6ckRZ+90UQAVD79/4XldSRaMcZeLKPW019uY=
=tk1l
-----END PGP SIGNATURE-----

--COm1n8jwkFdWCPTm--
