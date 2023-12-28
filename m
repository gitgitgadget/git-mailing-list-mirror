Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E417461
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WT+WFJ21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIKZm0B8"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9B9555C0082;
	Thu, 28 Dec 2023 04:57:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 04:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757467; x=1703843867; bh=pb7Gf5hkHK
	VqfrgDH0TyjEGPrfgq0QFPk1dw4Z9Sgp0=; b=WT+WFJ21LYPEBEHPjODHGritAo
	XnKFaxXFmJDq3cDrQq2qGKIl+qWRyjummy2eZ+BEZ3uVgQ4dCCvrgWUT5/wHmPzK
	v0faWTfGNqkv4JlGOx91YQppcqgpusT9zmZU/i38nRqtgWGiSAqeZEPn7xGZcs4J
	eVyne84Vv4naH16TmNO5phUJ/+lV38u81aK/s1SEzzEaIsE+0qwKsQhvSfMzWdQa
	Js7MDizHWxzDaoex0auo1bryyNcpzky/JXZIsUsxj1bOeU/3XVdg/wqXX1YOX8BL
	rx3p5URQE5COK5r3PzcIArpYKoJ/NYsYmw2Y0PMgToLXS+IaFH1WF2wnKq6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757467; x=1703843867; bh=pb7Gf5hkHKVqfrgDH0TyjEGPrfgq
	0QFPk1dw4Z9Sgp0=; b=NIKZm0B8SKKm0+DOafSNGWKN02RbZdJvQU3oG8fi5NBp
	VEpdsFyrrMosMxnvMmLRjBM+TLGA/i1I5wQ16kMHjz7h98sgdTnJ/WfgrSAMX7JO
	6Gv3/Z4iL6IBtonlu+u/Dk+3ypooEUyY6IwV6KXPDE6thxBcHNyPw1svZu+WwV4r
	ilwzPHK1z1pVIlBNy30SniKtY1kLT8HZLoO8GktvmnI+snRkdTU2hl4/VROFYJee
	JO5BWXcY3Tr9/4h8tqeibOKAR/Au90vWvXYgah4d7gtFKQie54Sf8DkeJKxTXnx1
	qc1DL1biOWmPLsaV/Xnuw3G207MiTwB0Uat3hTTpMQ==
X-ME-Sender: <xms:m0aNZXye_hV0UIuaNHNs37HMZMECQ1gtJ_F1OkBOPHbc0ZWR-j4r7g>
    <xme:m0aNZfT-EgqHQICoPsEJdww0SdZlajGPLGsk-lqqQQ2Nu6f5WVHkHT91PinIysRsQ
    KiDfeECzF8Ncmp7sg>
X-ME-Received: <xmr:m0aNZRUedvNPqx9YDc0pADzhFYps6YnIIf35HYJO7ISveOix3TaGVM450W6PS4gFkAqVrQDpn1dASmUjnow3kj7X2_MGu6MzpYgB2GjLU9aFzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:m0aNZRgZkf5j-E4igOfVAUSXc5L8vFk2AC5OUbixN-8gp-3NYKRu0A>
    <xmx:m0aNZZADt-4kIj-UG4YfZpCzfPafFEaRO0og30TnsvwoTurbSBtOBg>
    <xmx:m0aNZaKAxrpEoBgBEP0bTlR179eWgXiN6dBdsJYL2Rrt5MEuHUMznA>
    <xmx:m0aNZW4vGZN18f5-dFeJrNlV_3FZkHA1d42b-MM3v1P6I3ujiFp54g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c44918c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:32 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/12] setup: set repository's formats on init
Message-ID: <01a1e58a97b4d1935d4f7c7f49eaa56ccedab3b1.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvPMFZAAjtcrnQlf"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--lvPMFZAAjtcrnQlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The proper hash algorithm and ref storage format that will be used for a
newly initialized repository will be figured out in `init_db()` via
`validate_hash_algorithm()` and `validate_ref_storage_format()`. Until
now though, we never set up the hash algorithm or ref storage format of
`the_repository` accordingly.

There are only two callsites of `init_db()`, one in git-init(1) and one
in git-clone(1). The former function doesn't care for the formats to be
set up properly because it never access the repository after calling the
function in the first place.

For git-clone(1) it's a different story though, as we call `init_db()`
before listing remote refs. While we do indeed have the wrong hash
function in `the_repository` when `init_db()` sets up a non-default
object format for the repository, it never mattered because we adjust
the hash after learning about the remote's hash function via the listed
refs.

So the current state is correct for the hash algo, but it's not for the
ref storage format because git-clone(1) wouldn't know to set it up
properly. But instead of adjusting only the `ref_storage_format`, set
both the hash algo and the ref storage format so that `the_repository`
is in the correct state when `init_db()` exits. This is fine as we will
adjust the hash later on anyway and makes it easier to reason about the
end state of `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/setup.c b/setup.c
index e58ab7e786..3d980814bc 100644
--- a/setup.c
+++ b/setup.c
@@ -2205,6 +2205,13 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
 				      &repo_fmt, prev_bare_repository,
 				      init_shared_repository);
=20
+	/*
+	 * Now that we have set up both the hash algorithm and the ref storage
+	 * format we can update the repository's settings accordingly.
+	 */
+	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
+
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
 					  initial_branch, flags & INIT_DB_QUIET);
--=20
2.43.GIT


--lvPMFZAAjtcrnQlf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRpcACgkQVbJhu7ck
PpRNBw/+JIx6Zk3OqYeVfh2UzE8RPaAICouSLjQDdZHbXvmBTizuXdboTjoue85u
J/DsIxMFV/WxVEkPPwxQyIVZ8P40FxqgQQw4M1kXJr7DzcqARFGgSyt+Q4VJsPlu
+E4/xmTZ9WFhx3Mfp9eKrDYnMClMtVJiaDiCytu1fL/FySkKwLYgBZiX+o3iTc7c
6ChtuHF2UBlGzR+T/+/4a1gsRnj+o/syRXPdM6Gub8az/kV+NAsdiEet/thUgc66
yX9CBzDe78t627LGf6RV4sjSuh49bLfsIi1PD0GpeGEcZdWAGRZKLCwfK+8xa1Ef
UGVH7sO7dlhO5NggIoOe6sMfucYBfdzAJyhrWygu1E2ARrJ4+J+3S1lpDKUBFOuN
Fv+WUUu+1wWAEpA7v9qNodGcMfSbrlJLV8852aAd/b/qqZbsnm+2tuBWkJodrOKa
k31jDRMCEG1zwniZGIiaYoNHJ6jjXHeV0IHFPAFIALhISWAvND3IvAZdwgBXigOI
2v/j+e5yr+DKC8R8N/WqOefWpDyfz/6MFLQMmmRKHP0OASSCAR4w0IV7tN8T6UlZ
YQMTdSkk1Dx7qq+0sUqkufJnPEUSwi/CP1eCzJd8PprqgCQiGoe+fUw30WCHMn5R
MzQBUiLHUVxw+fkiWYAPm9CFs6QOLISHltR1h23jFNHoUtjJuXs=
=D4iV
-----END PGP SIGNATURE-----

--lvPMFZAAjtcrnQlf--
