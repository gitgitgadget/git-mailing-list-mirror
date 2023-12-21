Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70104D138
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aM/rB75a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="93aHZhdf"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 78C613200A4F;
	Thu, 21 Dec 2023 05:08:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 05:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703153312; x=1703239712; bh=tMX+JFO/KO
	t2PyWseoKgNbSNNeAPXQ4mJVfkn55PVOs=; b=aM/rB75aHaol4PWf/ZE94SaLRl
	1Qbvz+3eaHMNWEo40fXaFPe7bc+iV1zsYP8pw/cUmZyuoAr0Dla9plWjS7dhcZaG
	QmwLxUDlsuzivauM9XKAxWsmvUraoFGtxb3L49tmHb5qvQvN67As2yjqGazMZkcm
	zmzaGDEpMK1AxhM3l8F3KhcomoJ82BxF8nwBQ4tk3zRWOFno3LCDFhF+kTMMn2Tg
	9WsEgld4CA0NVJvLSTjiGSPyGiuwR1F/RyiUwvFgj3pzUM3O0h1pfuHzgkU/M+1I
	Ka+3W7aaBCWU5ZCHtTb8Ay7RGP7EuknXJpNbR/yKASmnHRkqkdgBGKGLB8dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703153312; x=1703239712; bh=tMX+JFO/KOt2PyWseoKgNbSNNeAP
	XQ4mJVfkn55PVOs=; b=93aHZhdfnMgPU9eszri3aePtjULktSBl0qAcaL/Cg0Mb
	obtaTA4czZ77zlgV4GNI7TGXdyeBR2bInIz3tbwq5Xa9QYYmWwEwtXULKU1JWg01
	Yv7VFzemLv9GIhC5IezXpnPc7/R1fMAAd+W8PtZdRMZM665UAG5EzQBH3e7oATft
	vjcYNXG8ilNSpADVY3Zm69Ilv90E8vfuGcuInVYP+davix35xYov/ICTJAhLGLJZ
	WRK8KoQiqhCMaTBYfXReSrwa9RE7RRpjOYCw8AMLYg47EG9hbBzJRcKwhNGKQXsQ
	1HuJpV1ojVs0TTIrqPDcZIJfEg+dA0wYABFgj/SGpg==
X-ME-Sender: <xms:oA6EZe8pXNt4thoCcJv6DtbJak2tv7Kb8pV97ZVKReaBzDz_YiLCtg>
    <xme:oA6EZeuwNGahhN5YGwRIeXurC2aL2yAxhxb1pi9BLJ_-mkUYuUj7Yi8P8PnsE_XNu
    CxPbnfUHozMpFLyaA>
X-ME-Received: <xmr:oA6EZUDOZrXw_saBxP5G7eLYNEyWYERLEGvuXjmJZim7Vfufxydiy2ww2_rWJK34_QG_50279vMW2CD_5lqbRy8Muk3QN3Ss2dxOe5SBLZxGfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddugedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:oA6EZWe99oHEQlWSK1DBwBOVhpRoJ5eZV_DW7NObZc_eTFE1WEgwPQ>
    <xmx:oA6EZTPzcC2Z7u_0By0jfn8Z_B7i-VVmzwVO_UibXqyPNRbgQu3wpg>
    <xmx:oA6EZQn7gcE8MRb0ylq2beOnEH453nVEBczj4f6FJWNxjlyy6S7GZg>
    <xmx:oA6EZcpYoXGlL_md7tDLNRXZWmd0o_FKApzL_NKumNNKPz5cHMLD4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 05:08:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e673a789 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Dec 2023 10:06:33 +0000 (UTC)
Date: Thu, 21 Dec 2023 11:08:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/4] refs: improve handling of special refs
Message-ID: <ZYQOnAeRWsiGTr6n@framework>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702560829.git.ps@pks.im>
 <xmqqil4ssmfg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dEDM2YAQ0wV7EHjw"
Content-Disposition: inline
In-Reply-To: <xmqqil4ssmfg.fsf@gitster.g>


--dEDM2YAQ0wV7EHjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:28:51AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Patrick Steinhardt (4):
> >   wt-status: read HEAD and ORIG_HEAD via the refdb
> >   refs: propagate errno when reading special refs fails
> >   refs: complete list of special refs
> >   bisect: consistently write BISECT_EXPECTED_REV via the refdb
>=20
> With the clear understanding that we plan to make those other than
> FETCH_HEAD and MERGE_HEAD in the is_special_ref().special_refs[]
> eventually not special at all, this round looked quite sensible to
> me.
>=20
> Let's merge it down to 'next'.

Thanks. We (myself or a fellow team member at GitLab) will work on
converting the remaining not-so-special refs once this topic lands on
the `master` branch. Unless of course somebody else picks it up before
we do.

Patrick

--dEDM2YAQ0wV7EHjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWEDpsACgkQVbJhu7ck
PpR1Ew/8DnWFzF1DNt/A+7AEjrJoqWP98VmJm10wjdaa2L9krUd1rkyaZhxu0sc+
mrwV0/X0VjasndcDtWxe9lPq6921boKK9KENaCWU0ET/GoqS2Wc4HgIxqhXDJBLQ
CkvIATnsJAPndYiDFRAZ/1+lVpLmy2Hql/y5j3o3JU4LSVavNo013ikGHWBYEKsS
beUih5VTkpH1OlGenb5pEJ78xPJDZwNZPtyi8uyGBiP5PnZV6lrdC9gsk+k5ck9v
yNzY1cLU66q2MKuC+RY1LFsSCbcyUzYZzmExl2m3wh0U2VtddtCMaWN4GaPCtIe+
6NnsBhhxQAniK1oZCBc+j5Scg0sugehtCXA9aSra0PLySCvON4oQdzvH3dyxVj9W
PMsEzMg3oQmL5EzANFd2T7aetw56ISxCfmKl0nwcF66Ad5CtZr+nKJrdFhjQHL8o
8YZjsr+c3I+zUJRt0qJWKTCnzFzRgsom4dVwcOS5bgubZbIlZ+C3qyx+BHxJloNr
RqtlwrbrilzExf5L38+xNzlEbgEdS/XlmSO/l+gE83gqtZMnJGVNds1o0tqb7UCt
WdH2cJT0pABc1ROfbeJFBeotlNgbQeWa7aoK85HrpXcCkY5RFpIsqSH6jNRKGElV
215W/8jmAZryKlMazkLBpwxEFZZLJjIhmZsEcBA11D7z9MhvWdY=
=LYs2
-----END PGP SIGNATURE-----

--dEDM2YAQ0wV7EHjw--
