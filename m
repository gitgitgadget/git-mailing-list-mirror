Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5614266
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g4zmtaX3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sEQJRLtG"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5F51C5C17B9;
	Mon,  8 Jan 2024 05:05:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Jan 2024 05:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708333; x=1704794733; bh=s4xbS+L9qu
	J9xOdGKy77LMJFrpA3anHhlbHcNIQgu7w=; b=g4zmtaX3rF1PzYUa3+5SuChwew
	PHc3IT84O+KW+wMPcbHN5PTy76gTgDR+SyKOQ+M4VQs0ne8YuPwWKEDv5u9lrGLl
	D43JE1BMpgAsRbz7jHBk1anQeLGQe6+ayzYr83Nin+wR+WQVHEkvIAJQopUc/cMU
	9cUqvMIQBjAr0V7SotHqcAPhJbBlgX5++Z/GyRRaDa3M+EDkYJt9vPk8EbXLJDXo
	U8nExi4s4U4Vv1VjWdQgrGB/UnuCvPnLIH8F8dnMVW4KzEoOVBIJp0j58WNI21xh
	MOpKGzmwIQy8ZspYlibLfKiV0GWO0eIiU34q+0E6s7gHafs4T+sM60B61vgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708333; x=1704794733; bh=s4xbS+L9quJ9xOdGKy77LMJFrpA3
	anHhlbHcNIQgu7w=; b=sEQJRLtGXVZ+3mPEb7ACcKrxlwkyRLoSYzvuMwPaR+yz
	8o9xm0ca7bPI7dgPiTR5qzI9oEF8ZtjYRwiw8JABhW5ghUomO700hzJlGN8jYqEO
	2FW6szMiiZSHxi5eeKIHqM3s8TQKUM4ximKI9nc/oOycB4d+qxNFTf6COmI+9Tw+
	+0kmsQpQBKtHn6SjkTIJsM+ni9Ktm0F1caqgjBl+GghHLiW0zv/fMYaGSKV5o9lg
	8PyVd/eaS1e4porefAH5OKxJ0m+qFC9lZ3gc3RmBj7ZnlaZp28nJvV3Nosv/MXRD
	lyHdh95DzNamIGLjxCg1DtVpeewdsrluZZas/aQYxA==
X-ME-Sender: <xms:7cibZShyCVqGuBcQQvG2r8B4P99ui27UMk_QxMz0NhanJ8mC8bZqLg>
    <xme:7cibZTCnaweOv2U88TpGmkyTmusoXAOO0XigIdhXQXGAJfQFjYpTZfqIs4Yy9Rx5T
    siC3_-R4vjXKTrsUQ>
X-ME-Received: <xmr:7cibZaGnq5hiIyzVTDWwJ8Z_TTC5Zc3qwIqjgtfO9zfH8OFjS3gX2CzAo4-Y4l4bifSGE5iQZI9R_MyoGQLh62C_A-2ZZrV0vsATsxvmLMo68lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7cibZbRxAKVbP5EcErYbLFzXj45IFNX0871hImDJsLoFNutcE-lS5A>
    <xmx:7cibZfzli82cHR5xJunXB4XUQic6NdLY25jTjWnKEVpLkM81XTtxsQ>
    <xmx:7cibZZ7wZ0JnTSe-HXr3L4TAAk5jTwFOIpSTGCl3I79mmHX_70Gtcw>
    <xmx:7cibZa82F-GiF0VBsuC6zGWZ3A1IwS9Kn41H8cxwbQ6Vf6j7QNDXBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64c7f77c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:02:56 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/6] setup: move creation of "refs/" into the files backend
Message-ID: <f500db51c22276e4add904df452697c470764d0b.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
 <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RO+IjdYTX0XUqDgM"
Content-Disposition: inline
In-Reply-To: <cover.1704705733.git.ps@pks.im>


--RO+IjdYTX0XUqDgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating the ref database we unconditionally create the "refs/"
directory in "setup.c". This is a mandatory prerequisite for all Git
repositories regardless of the ref backend in use, because Git will be
unable to detect the directory as a repository if "refs/" doesn't exist.

We are about to add another new caller that will want to create a ref
database when creating worktrees. We would require the same logic to
create the "refs/" directory even though the caller really should not
care about such low-level details. Ideally, the ref database should be
fully initialized after calling `refs_init_db()`.

Move the code to create the directory into the files backend itself to
make it so. This means that future ref backends will also need to have
equivalent logic around to ensure that the directory exists, but it
seems a lot more sensible to have it this way round than to require
callers to create the directory themselves.

An alternative to this would be to create "refs/" in `refs_init_db()`
directly. This feels conceptually unclean though as the creation of the
refdb is now cluttered across different callsites. Furthermore, both the
"files" and the upcoming "reftable" backend write backend-specific data
into the "refs/" directory anyway, so splitting up this logic would only
make it harder to reason about.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 17 +++++++++++++++++
 setup.c              | 15 ---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 153efe6662..054ecdbca3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3228,9 +3228,26 @@ static int files_init_db(struct ref_store *ref_store,
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb =3D STRBUF_INIT;
=20
+	/*
+	 * We need to create a "refs" dir in any case so that older versions of
+	 * Git can tell that this is a repository. This serves two main purposes:
+	 *
+	 * - Clients will know to stop walking the parent-directory chain when
+	 *   detecting the Git repository. Otherwise they may end up detecting
+	 *   a Git repository in a parent directory instead.
+	 *
+	 * - Instead of failing to detect a repository with unknown reference
+	 *   format altogether, old clients will print an error saying that
+	 *   they do not understand the reference format extension.
+	 */
+	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
+	safe_create_dir(sb.buf, 1);
+	adjust_shared_perm(sb.buf);
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
+	strbuf_reset(&sb);
 	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
=20
diff --git a/setup.c b/setup.c
index 6c8f656f7c..abb271e017 100644
--- a/setup.c
+++ b/setup.c
@@ -1927,21 +1927,6 @@ void create_reference_database(unsigned int ref_stor=
age_format,
 	struct strbuf err =3D STRBUF_INIT;
 	int reinit =3D is_reinit();
=20
-	/*
-	 * We need to create a "refs" dir in any case so that older versions of
-	 * Git can tell that this is a repository. This serves two main purposes:
-	 *
-	 * - Clients will know to stop walking the parent-directory chain when
-	 *   detecting the Git repository. Otherwise they may end up detecting
-	 *   a Git repository in a parent directory instead.
-	 *
-	 * - Instead of failing to detect a repository with unknown reference
-	 *   format altogether, old clients will print an error saying that
-	 *   they do not understand the reference format extension.
-	 */
-	safe_create_dir(git_path("refs"), 1);
-	adjust_shared_perm(git_path("refs"));
-
 	repo_set_ref_storage_format(the_repository, ref_storage_format);
 	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
--=20
2.43.GIT


--RO+IjdYTX0XUqDgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyOkACgkQVbJhu7ck
PpQQ7Q//deOAYUi/1i780K4XweUuMO1MR9lW62sFQjMeQc66TfFIS6M4kM7kcsok
e4WhIwLMA4DzITPImkObKMZZfGCQ+W/cMS9U589pQGqxUp4kj6eyREnU01zSy30M
Ii63tAISR0nr49Gi0JBIXJEJ/TfH069SYXgwZT9b2SuHIsGMZHSxYzRePERHVl1n
c+Kk3zdw2Czbc2HCtgR56M06iGUGL0XlJvHH5yeeKNMtclNB+pIsVKfP+HOYLuRa
gi0icZtsbtB/I/DSaLh2rAqJN9NVckAG0TL5NRkU4TUTQs0r5YAOYOaaFExPKAuI
mc1MfgQwAjO7ApeUsD/2BRLsfDLRyhZXEW0D2joN2Z7PWg/+y9DWD0pHibva4VGO
uLS0N0yA61OgOa5QPEvaoLiXXsI+0tVpVmwK5TK/UdOLf3b1RIVT7GDU2w7jwTd3
VIn+jkZDHoY1lRrs4KJwbtjImUbTvVmZHSvnpOWPFCFDNA4uH75svY8HgnkT2uV6
IboAPMeCxI9mxZ5S5TqBioHHnVtiLPm+ot8inHfR+IJb8+x9+SaMkgM8YlivaMR4
r6jymtl4RBCcbSZ4hxrIbmjjgrAJ0h6LwgtRT3ayXfQ9DXtdSPTHhJHl3HZc7EKG
2tfoywqeNQddKaOG0SSfgqc8PXufU0xkYD6A8OjvyxFzPBooDv8=
=2Zom
-----END PGP SIGNATURE-----

--RO+IjdYTX0XUqDgM--
