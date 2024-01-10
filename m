Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CF659
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+K/csyK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xehelpp3"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E3C263200B26;
	Wed, 10 Jan 2024 01:33:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 01:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704868408; x=1704954808; bh=3Gx1h+29VE
	gyc0tVCYxAfff8I3xhC2oTY7ZwfXTANEU=; b=U+K/csyKiWWvZ3NahUw0VWf7G6
	ENCQs0wL/w26rlltudzKbw00Kp+lxgpG/+DMHMFDBb6nwcpmxvjFBMhmoYZkrsUS
	4zu1+zDshq0SZJfVvIHs6T3W5C/EHXzhqvF3DvfeFy+tujUiMn82jAlAavgpcSfy
	d2RKdJZviq6JX0f4oB3KLRNGvwX0BDSS5iNtI4UIgPhCtYZxch5rRr0ouv6xM/8I
	xoNPRsLIaeBtYS8kWm2aIr1Nl/VyILD0NIkTLAA+dJq0yyWLJQ8a0ucjXZnwXxrb
	fN4+e/GPYYyLOjnSQVvEMzOtQ9B9tTHBJXNwC0JYYqrgtmUwHMIcALhR70dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704868408; x=1704954808; bh=3Gx1h+29VEgyc0tVCYxAfff8I3xh
	C2oTY7ZwfXTANEU=; b=Xehelpp3TVG9Z7EzC/3hOm6zUZr5vwvYff+n0hy/Sw4Y
	KQpkutxpI/wVW0xDxveQ8a9N11v6Dw/JHihe3W1EzGadFwDztxYZzBblx0qR8G+l
	L0n0C2Z/qv3MkG241wA4r69+Eu+xrkYJ0FiuYlvrlrogorEb/vuq23P/+/NldBay
	AJDqiaoSIOp7q3TEJIZl0sNBPJoMzQbRCWxeOEhICMyaNcVAVQORemkERQTBtVc4
	98+qMqPU7Xo1L2i1ulIavTsOcxTiXRYiTuDRr8Y1RqLTksaJZsHMF48efyngKqS3
	6T+M/UCiNTDoy/GAtbdJqfuVDqbd2jm6TaLSWlWFig==
X-ME-Sender: <xms:ODqeZXjS9Jbw7Yz6p6Ozvoj6AbFwuy9HofYT-txtVdYudpznTVBUPg>
    <xme:ODqeZUCJ65lZ4244eDI4tj5xwHoNgszbKySjTJDJnMWNOz7cn0S-fWqWepyEkhFni
    yS51mbPFmSe-oBheg>
X-ME-Received: <xmr:ODqeZXFI-SR5O-oNReikBn4oyMKvQv2UV7nNB-hnQ5Xn1xlrIbMp35yDQorINrmNlEIrmrM5-_-5P8nPV3UU9WWZ-iCocxEzucxywFP1r5ZLmzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ODqeZUTKSMAc3tCAmZvjReMRDzN0VOa9q0EaMWi4Xc9mdWfTQ3GhoQ>
    <xmx:ODqeZUz7qu8q2YuEGj9b63huYw8ioitQ7nMTqMHG-fWfS1yluxa3oA>
    <xmx:ODqeZa7jibwDcjs306Zoz17PdHwX7t3V09GPqQw7F7e0Xxjh7_MEfg>
    <xmx:ODqeZRpaLZJ1tnuskfrzv1cX-6dZh2dphSqbRJjsEwJZZW877HIP9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 01:33:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18850a53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 06:30:44 +0000 (UTC)
Date: Wed, 10 Jan 2024 07:33:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/3] submodule-config.c: strengthen URL fsck check
Message-ID: <ZZ46MrjSocJl-kpU@tanuki>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <893071530d3b77d6b72b7f69a6dfb9947579865e.1704822817.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BYmgeJ2JIk7Puif9"
Content-Disposition: inline
In-Reply-To: <893071530d3b77d6b72b7f69a6dfb9947579865e.1704822817.git.gitgitgadget@gmail.com>


--BYmgeJ2JIk7Puif9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 05:53:37PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Update the validation of "curl URL" submodule URLs (i.e. those that speci=
fy
> an "http[s]" or "ftp[s]" protocol) in 'check_submodule_url()' to catch mo=
re
> invalid URLs. The existing validation using 'credential_from_url_gently()'
> parses certain URLs incorrectly, leading to invalid submodule URLs passing
> 'git fsck' checks. Conversely, 'url_normalize()' - used to validate remote
> URLs in 'remote_get()' - correctly identifies the invalid URLs missed by
> 'credential_from_url_gently()'.

Okay, so we retain the wrong behavior of `credential_from_url_gently()`,
right? I wonder whether this can be abused in any way, doubly so because
the function gets invoked with untrusted input from the remote server
when we handle redirects in `http_request_reauth()`. But the redirect
URL we end up passing to `credential_from_url_gently()` would have to
contain a non-numeric port, and curl seemingly does not know to handle
those either.

Other callsites include fsck (which you're fixing) and the credential
store (which is entirely user-controlled). It would be great regardless
to fix the underlying bug in `credential_from_url_gently()` eventually
though. But I do not think that this has to be part this patch series
here, which is a strict improvement.

Thanks!

Patrick

--BYmgeJ2JIk7Puif9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeOi0ACgkQVbJhu7ck
PpQPUw//WyVbQ433DR0MTdHRIQFoeatnrEMkZRH6jedRkPmePcACxvMTUGz0p/PW
9kZXXSco37J2ZRFFaY1MdsXeOwDJmpeQ8uq7OLwzRHQzli4dOmBVJ+FkndbAkltB
X+8mllq6EySL6Wp51Ty9sbLigU/pPbWmPfEXqMvqRESc6/vXmzLEyiu4LnaKU2qU
v+1PlvMJAZF+QZ9xoZv2RNee109uiBEbfH9/zcwhlwUHfrc9kyyBh4XSdOaNvjfx
LKwI5HA6MYsXHC8PHcTYf/EUTx5h8ZcD0HFAQ9kp6dqcvzQqPPDaEqc63iDHgEQ8
cZjWeMBRxcAhHcfK4mNorBetKwkHKWXSKGRSDYc+gXqu2plNhLIbnhIQkxLe2UG1
nUSdYnuAtiXhkV+D/SpvKIgDuHkOJHxoapYvoerEDn/Zt0stwO1J98BMoANYtIG/
grPAo+25/N1VUXtfvfAC7tFUcw/zANZdu5Hs2d2td1NbLUyzsqPP6WAUMAco4mIV
AuIkSad2Lcz0NEwDI4iAulAzrmmEtCRgWQ5kOSA/6Y/wQkgeLj5y0RU6gjToOX91
PER9sKo6m9mwsvC9IgJmYUautXxxc6DUeMFzpATBB8KtLmbrrxEkrj/MWPS6GD1m
9On2ji/yACh0ceumpXhz1vwA30wjav7DISz+HkZ3ZJL/3sonD1Y=
=CtTT
-----END PGP SIGNATURE-----

--BYmgeJ2JIk7Puif9--
