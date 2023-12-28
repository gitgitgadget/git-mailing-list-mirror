Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20B63D6
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VJ3uR70I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vwZszBJa"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 237395C0089;
	Thu, 28 Dec 2023 04:58:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 28 Dec 2023 04:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757498; x=1703843898; bh=pMqLJY39SC
	PbTS3XJrNELmSwAVpwVzPG1mwvj77mJnQ=; b=VJ3uR70Iq2IX61Xzpnf138rV2O
	sEM2k3f5lG96MtkzS8S7oHiMYC/LJs802ZIDQUgfTqSKclB9g5MC/G8cBGYeZGTp
	c//6dHHwAXDI/bmTSUpKfY14dYkSSEK6AH60nilCSZNGFqLM8tIIH+CRd/U4QF+B
	/ZNNeZt1a2MA2HN1QOSwtlufQpt4UlybNeuqWViPoRe1NaO1xCA7+BFVyI8a/C1b
	o8voAcEbLCAQwOJmyhH9kTBNInNFMVEUqX+FkhckcxxAHLWV592TKzdejOjVwYEM
	WlCvURIZTNHOQhxRe/ByXnfl5OPLoHbGkWrhiI2Pj728YWysj9uA8ZrhUJ5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757498; x=1703843898; bh=pMqLJY39SCPbTS3XJrNELmSwAVpw
	VzPG1mwvj77mJnQ=; b=vwZszBJaGvtswLSafCXIuSBsA/Gl8LGxG+2qpsWhajfX
	UOP7W9e5D33PS+Y5OhFon8n2287rQtOYhy33WsTOFKGj6IqhyrZDNAOF6NDgNLjS
	E06EqdjCQXoOI0JTm0tCmTQygzZmAa45nRMJpdvLTIVY+UbW6jekVx1jvl7QxRQW
	fcqucUESy55izZNSIFxeczyeA3iKayGzA0IHXdctWmH72V/1/PIEL4XYwJAj2HsS
	SXC6eDRj7oAIn4+UZIto2Nk/JgP+vZ8RjmhBNUKEekerpvtIyAJZ3DoDHaPRWJ/I
	F9ATBlGUtnVokNCGOgab4Yrl4wVPzFcwHaVY0+yi7A==
X-ME-Sender: <xms:uUaNZWRZLiSNBDGN5ieYkOpFExmFU2zyS-g0d43G_XKOW1n-uS_zdw>
    <xme:uUaNZbwDMnSQOjqRI1pe7erP0qpQUZ8FKb_sE8v3JUrDvqHO3Ej-CbUMKZfwYmT0Z
    JW3nPC_qmz1xFLqAg>
X-ME-Received: <xmr:uUaNZT3XVtk8_pPqFRYdkloZIDmKWFcdwiqDSx3Vol5qUPGKvJj6qFF3-jkUxqyl8hBnqKNqA4Fbr6GKuX-wm-WRJt3gyeijWjT3VuUPWkHgwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ukaNZSDfeSamxc2k2vQEbJS3OvGyHjJf--4rdSH2fsFt3n661_us_w>
    <xmx:ukaNZfiEHo7Qn29sDMmXkYrvcPHREwGOV4M0OM0uE7NbfieVUZ6cPA>
    <xmx:ukaNZeoJ_BMQElGspjU1u0IyvLZ1WdIP3Z1x2ldNb4rvpllVrdzIIQ>
    <xmx:ukaNZXauQeLo9JsL3UpcpzGN0qiWoI7AL7UB01ms4RnBRpbkqcKVpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:58:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3fd55846 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:56:03 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:58:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/12] t9500: write "extensions.refstorage" into config
Message-ID: <b8cd06ec53091b124273f621db8de13cdb38835e.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ASouvGO9qylCnB/I"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--ASouvGO9qylCnB/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t9500 we're writing a custom configuration that sets up gitweb. This
requires us to manually ensure that the repository format is configured
as required, including both the repository format version and
extensions. With the introduction of the "extensions.refStorage"
extension we need to update the test to also write this new one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9500-gitweb-standalone-no-errors.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standa=
lone-no-errors.sh
index 0333065d4d..7679780fb8 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -627,6 +627,7 @@ test_expect_success \
 test_expect_success 'setup' '
 	version=3D$(git config core.repositoryformatversion) &&
 	algo=3D$(test_might_fail git config extensions.objectformat) &&
+	refstorage=3D$(test_might_fail git config extensions.refstorage) &&
 	cat >.git/config <<-\EOF &&
 	# testing noval and alternate separator
 	[gitweb]
@@ -637,6 +638,10 @@ test_expect_success 'setup' '
 	if test -n "$algo"
 	then
 		git config extensions.objectformat "$algo"
+	fi &&
+	if test -n "$refstorage"
+	then
+		git config extensions.refstorage "$refstorage"
 	fi
 '
=20
--=20
2.43.GIT


--ASouvGO9qylCnB/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRrYACgkQVbJhu7ck
PpTV3w//St1rN5HKQ7bU/7+FxxF3IDFuEVeI7OOKL29+NrANG5d5HDtwbltDViIb
SDpJpFD9PLmGuLBgT1OcO11kLEf+h0IzzOk5sh5xZ/v5cZm4F1bQn9Y3l7LxxBsH
WU1InwcN4FAZKTCypEpRNjBq2y6IpFkpYRUi3XJinIj8+IDCxvv3PRr2hvf3AyBT
u8OiiOKKGJG6zCbkGXe+KhJze+2FMit/1HRhf6Mwgo6ilJikVArkb6OOqZB5bpVr
8wm2Mubou6M3Q3eimTrBkcapDtNF8zAJPZd5K2TILB3IlBni/wYisNQQA/zcSiYr
zggkX1Pzu+AKCCQ+0/I9hnX7xbMOONh7XTdewu3XiQhB7Jv/G3UZUYdUuIanbSco
vWhptxY2JPrJ4PJPHK8aGTCsVM4AOape+lsWDewoswZQjG/ae5agLnVX2NmO/azT
AEykshQUrd7E4pJKhnlkXLExHw2Dm12gHZv28B9pUgI1cQ1RpjI6s7hmFEdwTCtt
2+H/flySEBHilPjQw2q2IG5jrgIVTfoCrjg4GL/66PAcSRqju69QR7fPrPrbk/0u
nv5nNVvq1LjjhJqwZyQoP3nsUxV4cqExNV8e5Tz2P9rDN/f0VhR1iMuTGLqmmB96
4QtSWsoBEP2jKS+wDjbYgsoIYz0QH7zmFhv7vtPfGNt0V1JdHEs=
=AHBl
-----END PGP SIGNATURE-----

--ASouvGO9qylCnB/I--
