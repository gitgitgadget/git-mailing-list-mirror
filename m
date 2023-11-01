Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D912B9F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z0eHxd5E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIcfiv1j"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F5B7
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:02:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DC6105C026B;
	Wed,  1 Nov 2023 09:02:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 09:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843775; x=1698930175; bh=35
	5BVwRQsgtIKi62U4dRA0FroUzxmbsaxHR7YF2U0wo=; b=z0eHxd5EG1V7Tq9qMi
	uehhDfSpciU8XMySXsAEVtNQoe6K94vMmB+AgZal94IJ1NsDzrbxWBKykVw/aXWg
	wWWE4vl+IRWz7ycJodYHB5Z+of+4STV64TCG3a0pkCobm+MAd6k4op9SkLNAWT7N
	LHDYw0s2AafyZ12D/dEWwtmtUENj7F5bMYNLSmA7dJJMu+4pZh7cwoGSb0JN8HZ3
	qi3oewwQdIfU3ExpHFoHEan54pkeRgvd5DtylRnXC3z1uC9tjiZ+kzzSBr5/PdHI
	9/upj/6mP9Dgrx8jWtebPrCVQE+O3CK+oYLZogmvVH5NaFakPgNL1Q2Qst5CnRZV
	rf9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843775; x=1698930175; bh=355BVwRQsgtIK
	i62U4dRA0FroUzxmbsaxHR7YF2U0wo=; b=WIcfiv1j4aDxgDBfP0OpbvR1SEC1E
	UmSxLTSOXdwJOV+Xuy4NCHvtyXSb9nwKXS+q1q29+GrQVHnPKEhrg1PVjR4pCU02
	w+3SkwZ8dKeDmNMjx2YeXcfE4Ish8jMOcXkdabv29qLa956J/dLigLZ2xxTSjPHN
	uh1NlnJQ5QVzW3zsuX49jKHe267g+TZfoHxDtnj3BoN/hyOj1hakAqoZ23W7Ep/Y
	cNL7igNNFCzL/umxG2ZPc0dXGpTVsD6DUedeIKBDurz96p0r9LXrgzhwtxRuQidR
	opLXOh2hZR2+VIa40hOMinfxap+PZCAiuNL6R2loaywHQkbvO8m8Pa1QQ==
X-ME-Sender: <xms:f0xCZfZ4XqBc2rsYAN8j0SareWpuzvlM_cX2YqMbKPMLUDN0B6v50A>
    <xme:f0xCZeagpEedyR6AL1YiH2CqhyPwanmy_otPKlVZJ4HNL2kjzPpv9g7O9WCeQyxx7
    eqlg69wxMA092MwMw>
X-ME-Received: <xmr:f0xCZR9-DykhQR_EJ57-QnZz5-4PCPPgZJFUoXm1fT06NsE7TarWvYysvlLd50D-yuhIZEtluh2n2BMa_datztKnDylJgB5ePlu_-mM6uI76hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:f0xCZVr5X9LOAaWK3xRiEx1SSNkQ3rKoQcqCinYAOSb0lSH7_h9sZA>
    <xmx:f0xCZarLH_QSzlX5tY1IiGh2M00cA0saiSEp88TFvOIDxDNOw5teeQ>
    <xmx:f0xCZbQPIzAMokwkoQwYhM4siWAPCuEPfM6ixIELFeySPSYFZYsEwA>
    <xmx:f0xCZTnDOqmdh0Ogb_GufD81VO3tfA-xjaagn4DYyRvVQznF-_WtVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:02:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d69b092 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:43 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:02:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 3/8] ci: group installation of Docker dependencies
Message-ID: <6e5bcf143c86650f153de63b0438c9e09c9dc005.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6e57+foKES6zGuLv"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--6e57+foKES6zGuLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The output of CI jobs tends to be quite long-winded and hard to digest.
To help with this, many CI systems provide the ability to group output
into collapsible sections, and we're also doing this in some of our
scripts.

One notable omission is the script to install Docker dependencies.
Address it to bring more structure to the output for Docker-based jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 78b7e326da6..d0bc19d3bb3 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -3,6 +3,10 @@
 # Install dependencies required to build and test Git inside container
 #
=20
+. ${0%/*}/lib.sh
+
+begin_group "Install dependencies"
+
 case "$jobname" in
 linux32)
 	linux32 --32bit i386 sh -c '
@@ -20,3 +24,5 @@ pedantic)
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 esac
+
+end_group "Install dependencies"
--=20
2.42.0


--6e57+foKES6zGuLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTHsACgkQVbJhu7ck
PpSfNBAAp4xCU500+wGfosqiUFo3L/pP1HnuZrcl17Q53L6h82yboOG2IViAiG7P
AQkswLv5byILh/zNW/TW3KyytiLokqVEvFs25ARAGA9WER62AJpoeHiU27UXNuMw
3klg68UlOUtNkobxdh8UwRsulSN8rs98uAHkyiCJM9l1LaXBagTKYbD9/ZgVsz3r
J2fxzF/HIYh0Ajtlvmyqexj0Kwixzdh1OQlJFYE6xfUnuLVAPc05iyKgyg1Pwuyr
dZ9UkKt/gZyz/Nasq9yIpJS44KWqwBfu+6Zp/Py9U0NCQdtE01+Kl4SZ9VqdxURv
jE55NpBCF1nTxN+hE2q2MNCCU/FPRz9EZgd4FVMF/DbQZ/4ntPl0OrB7AvBl/c2X
+C8s3aONV1GD139Gid1hBwM/H0t87pAKP9Whaj4pWnjV6Y32KasMOTlf36xJUhqH
p7FWlC2TJ5mqbKBRzsxM+PhncbeMOQ4XuqvW7VPp8IN4PNh5MDr4zq6T+RPsAqir
jn+qSosxTu//Vg022v/nnvzyDGvbdDq2E7DVvsno9jqKoKGQPYlhUrDOJ2PWvlUX
Hic81scGGZZHHULK3PtZqJNhhUKW8j5SlPL4USSoCeot+zDKoqJOwAaA/C+ZVrHV
U65BQmxyfQOfVfgfJNxQOu/z/AV+uaQdFx8jsFDWNY/plbtOGRI=
=xOa7
-----END PGP SIGNATURE-----

--6e57+foKES6zGuLv--
