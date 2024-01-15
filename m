Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063611E865
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qUwT5gkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGuil3/y"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id E06355C005F;
	Mon, 15 Jan 2024 05:35:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 15 Jan 2024 05:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705314958; x=1705401358; bh=2Ll5fifxHr
	TFSHkfcWvd/bREVN3lZj39S9g8jmowYBI=; b=qUwT5gkCTgCHIVMzNa6PUOFQ8s
	MU2B6NZz3Btik7BiPed1ImAG8kAsyb1uWvAfUAazGPf3VRJF0wEA/klYHea5Ldds
	taCiGn352BiG9ySIsLsh62I6wMsFHNT5GNi0j+dR3dhfffZzWvSH6PVFcxORmtHB
	JDeScombLAVs3IvLadLdqhlwKAjHPdtzK9jPjF2rLYYVwaBe9IQ2GqI9JJFJl72z
	eaAsurTnbnYlsHRULQIBRNak5wg9ScKCPkiRHRE5NdwtUv8ORYND3h+BNhee0y6V
	S/Zzpg8Ed2IBA7RYxqmR3UmF6N1kcO5WpFv8vxK5OrRsSiKylT5aOxJDEFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705314958; x=1705401358; bh=2Ll5fifxHrTFSHkfcWvd/bREVN3l
	Zj39S9g8jmowYBI=; b=cGuil3/yoJzDa3/Fd/ZkC/KjrQxiWrM7LqTqQbqB3UeS
	kzLrQj62D7Kh2ASczk3727nbYTK+hSCsVSLlfUgRpJaOCkhcWDPGtMW0XayVu9WD
	YFTivIfyz44e6D9+RNWaE4pxbXFAnUTaiQ15EjgOXY6Kejn4Cm9uHErGpX8SWyXU
	uVhFPDE7S58kw6zwIZOmMwr3V1Rwirz2vR4CV7TDUj0UCuB13zY3iSz7+lBheszq
	Djp68zrVqU7QdCnuPlqYZpaSFH8mXxBbWcaHJe+3T2MEC073e10lrMmKANAChxeK
	1kM/IWWvnhtuRIuknynbw/y62c0ft+aUxoHezWlI9w==
X-ME-Sender: <xms:jgqlZZjKbYlajbe8wQryBcCW7N6ylF-KX-vOqCmPVdM9QGNyeatZVQ>
    <xme:jgqlZeDu2QPbTAb-RRtcsx1LYL44az9s0l8Zr7spRHmenFhW1B74Qv3DIGDAJUgP9
    qFoseqeqnK_TCzovQ>
X-ME-Received: <xmr:jgqlZZFNSN5mhLCUo4etCJ5Py5c38BTljAUSsQi0mygMbzdqfIsMQ4cPssb6D3uYZTzfRSrqBuQG7dcpDX53EN-pLU4KvMhLG4o0jakACywjtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jgqlZeS4CB_8dEOCyTfNVA3PBlNMTTdehj8_Ysk_jOdpx5vdH4HznA>
    <xmx:jgqlZWxVR3PbGH8SGAigQzEEPZnCe7oonK_6M12o2NnrsZOAKHf5xg>
    <xmx:jgqlZU4DlRS4WVt3-Ra0yJCaKWXHryCF8ZSrT5pS8_nZNM6MZtDq1Q>
    <xmx:jgqlZQsYl9Kqo3fez-dlHVCFAQ_rw8yM86foEOv2w8BFFIN7qCUndA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:35:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad0c6e35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:33:05 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:35:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] completion: silence pseudo-ref existence check
Message-ID: <cover.1705314554.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hRQJIO9n8PvHvOT2"
Content-Disposition: inline
In-Reply-To: <cover.1704969119.git.ps@pks.im>


--hRQJIO9n8PvHvOT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that refactors the Bash
completion scripts to work better with reftables. Changes compared to
v1:

  - I've incorporated SZEDER's feedback that he has sent in reply to the
    original patch series that is already in `master`. Most importantly,
    we now discover the repo path in `__git_pseudoref_exists ()` itself.

  - I've included some refactorings to stop leaking local variables in
    `__git_pseudoref_exists ()`.

  - I've added tests for `__git_pseudoref_exists ()` directly, which was
    also suggested by SZEDER.

  - I've marked t9902 with `test_untraceable` now to unbreak macOS CI.

  - I've refactored the completion test to use `git show-ref --exists`
    to fix an issue with unborn pseudorefs that I didn't notice
    previously.

I didn't include a range-diff because quite a lof of things have moved
around.

Patrick

Patrick Steinhardt (5):
  completion: discover repo path in `__git_pseudoref_exists ()`
  t9902: verify that completion does not print anything
  completion: improve existence check for pseudo-refs
  completion: silence pseudoref existence check
  completion: treat dangling symrefs as existing pseudorefs

 contrib/completion/git-completion.bash | 11 +++---
 t/t9902-completion.sh                  | 47 ++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 8 deletions(-)
--=20
2.43.GIT


--hRQJIO9n8PvHvOT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlCogACgkQVbJhu7ck
PpTBww/+MaitvWh4pKQNTKLg74hjWD/aeP0ay3UIHq4LDD26U7u9rqPvFBhRDNDC
jVpvZKklcF8/n5P4Fv36Qx+l9aPgHV7G6leI7i6hZR4yVKzQARPRiT6tnBe2R6Dt
XusbRGc2l392LJLAHgBmvR+HSC5XUpnQn3vV/2SvyrcqM3yekClOJ+HmQttcIZva
9cxn0P3AaPnGCTWcGhvkPYCwe4RHyNSxm81FfigR8xkR5C5da3z+d5sDHhHlegzK
piSclz6fIoAy/TLIRt4KKl7XbfZyxM/ovEZ57rHB2RGw6oFXMSdQcP8g6jc0e7mZ
CQi3i502VdaURQ0tSNoxiZMvHCIuXxm7YsWI26iZGKzTmZEI5D2sr7xDtVDKEayA
awL7m5J3Eh1d+u0J4v4NdrybtgYdY0kdlavGfnhASeVV4+lIxD+RUjqgeCIXcYFQ
cyYhuzGIZd8w80LuT9ltEt/LaTgrNDTuLI0hzIjTU8EaF/ucIT+cLUbtMM94a43t
CPBGM89gXfo2+2qSk9Trh98ozo1qe2leNfrYkwNcbNC3XRCfMI5Jpx1LyTkJjb+4
Xcrzar2yZ9Z+KCE2hVkpxOv3fuj6zwogBmCVmR9hc+b5b8j7hBEIUogZCIOoZ1vX
fdAdTafmicW40LuoPHtDFUBwNMOO4NGrAkXyRXmVPMppmTbDtpc=
=fEuJ
-----END PGP SIGNATURE-----

--hRQJIO9n8PvHvOT2--
