Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8044381CF
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rQxu/Lnp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvEHXr1E"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id ED7C05C0398
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 Jan 2024 07:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704802630; x=1704889030; bh=6fU+oW09JB
	NaxYqxMZ6J3nKCBC51//u8lHdlHLmHX50=; b=rQxu/LnpxaLX21qJ/Z4er4lK94
	kESSyfojbUL3+3/vyha1YkQPDZ431y9RzLtUCYIgHPcsNVSLuR8bob2qIFAdFMvs
	UPg8VvIyqIFJOy8THPIA17z9vd5miFpROOo5igKej5y0eYgwUfq8YzZD3vAhTTxN
	GNxhTAan7Wdu/hrJ6ewLBH26Q8kc4MKV0JwBaHw7MpuZVN7EXPdImV9LTEMk7Y8W
	7yDUjyrb9hwdi993nH6f6PVUVfRThYz9Rdlah68mYeMXJnOkv6T5qEQZgD5QLVZU
	nWSG3r2T6CyTTyQTimQLFSfktihM1h5mKr3qieNeC0Oxt2HEYnoui8mRIl0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704802630; x=1704889030; bh=6fU+oW09JBNaxYqxMZ6J3nKCBC51
	//u8lHdlHLmHX50=; b=yvEHXr1EI3ahvEoqcf9dTesZ5zrtXMnoGKyzuUeA0wKr
	fcyvaSo/GCLNmq4tqOFmosCEEoknp27jHwxnKdOc+T/JA9eYnLeg2kVEJMNqGcVd
	Rj9yuiz1pvE3ivP0ivp7RAAHXBwyMQbG7MpawRsePzj30T0bHH/G2N23hLI1XmmJ
	t+wRAC40qwFYBcBczsQX4dyDwD/s5abDvHtRpJuIi+cO3FmfWnXLOuIo+WFOdgkK
	C5D+PklP7TF+iRBZ20VhBP/vWrWEFFlTVfDtEFWsL4sDBwhx6Z5eHUbJbK9pl4Wc
	W52+FjnhFe1+TMUnmTOf9qmoTWzeugFchDBX9ylpfQ==
X-ME-Sender: <xms:RjmdZbKP7EAod_Jw68MV8R7ts1GUH2HrE8eyw_IliL9KsELFdeRmZw>
    <xme:RjmdZfI24Uka_gFrxTJQLmwQkUpxms-PH0DQsocfoecIRIHVdKDUgr8S6gqCwI6wb
    -6vnKRSmY2xjdlU5g>
X-ME-Received: <xmr:RjmdZTspukY37qBGVrEU910_7y11gNSGlnnpnr2UTdNnYPit-HYcl7Jt9f2DAq0Ti4UfFucQCDGX3HWz79EB15JoLo49ezL7y4P6HNYgRK5p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RjmdZUb8lc9VIkB7Eqk70QrkvcgrXFjPZOh39HVjO4ciKj9Kz48tBA>
    <xmx:RjmdZSYST6RGLczuDSrsj2VllvbRMZTrq5ZqOQ0HUDrRYlo1P9rXmw>
    <xmx:RjmdZYB65y8ydXiFK0PMrutWmzMXQ9NMv2Kjx3p1oHdsb5FQD1D6JQ>
    <xmx:RjmdZQ2W5hWjQ6kG6v6pRkyS-75PU7cP20xohAB3gyK5PzbZPcW8KQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eec94501 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:32 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/6] t1301: mark test for `core.sharedRepository` as reffiles
 specific
Message-ID: <68e308c200ca5a8b0add1a2cf855d78febd2bf36.1704802213.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DDaS3alDeVs5e4w6"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--DDaS3alDeVs5e4w6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1301 we verify whether reflog files written by the "files" ref
backend correctly honor permissions when "core.sharedRepository" is set.
The test logic is thus specific to the reffiles backend and will not
work with any other backends.

Mark the test accordingly with the REFFILES prereq.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index e5a0d65caa..8e2c01e760 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -137,7 +137,7 @@ test_expect_success POSIXPERM 'info/refs respects umask=
 in unshared repo' '
 	test_cmp expect actual
 '
=20
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedReposit=
ory' '
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.shar=
edRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
--=20
2.43.GIT


--DDaS3alDeVs5e4w6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOUMACgkQVbJhu7ck
PpSEpQ//RIFKayYFfrLkD3Nxk1cqhR8CrgEDKBWFEoJo63kggtP0mKoVS7ZuoHoK
dBjlsbb4llTMiws81bKWZoeaUyrPmFi1A6Z5PRVtXlaY1AfYbTZGzHc8FzWIONyU
bwB2QXPxxs4ee6n6mza1gDzkjD0VcPzCjFen/dVWodT4UCQhARE5rz5FgA7ipOCT
zWmm/Oyy+K68aDHlWzXds65Tp8PAFe5chfIMwCbkocMswPwyabgh3DgyeMJZHE9Y
yQHHRWI6KQ57qCokxCYX6UAsUX7FHTEC5eqmsDShcI8ZYcaWHbptiypy00bW6c5Y
SxAdbWuEgz4Hv4P0RxwSeeuphQOjCLrlQMLBqAS7hLAI4yuPYrVOKAv10kfpq4UA
DYjjczfZvgUMUE1TSrsAxK7A09V+tgO7MhTdVxMeqzQPv1Dg1YW6aASIV/UwV+vw
lr3EhRk8GqiCgXsylBMLHy8VWE36oDNdaELBWhtp+KsBjCdAWc2vPe2AdlvI2+2q
fdbu/1syKR5nkl+VtKFEwKqGXd0t4aNX8Uu6/etL5Mm29EGUhPhZMth4XIMkSXNV
Vm0oRpI6/7LhAT4yTac0fU1cWz48Z4DcsVNC0lhjqwHo1WU503sq0HO5tb0w/2DV
l9+SQEQhXbvatfahmc3JGNFDSn4Risr8NVrSYqZgniUvsvMfRcM=
=EdEq
-----END PGP SIGNATURE-----

--DDaS3alDeVs5e4w6--
