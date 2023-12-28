Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AA76AA4
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r2sXgHq7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGmGpSj2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6EA9B5C009A;
	Thu, 28 Dec 2023 04:57:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Dec 2023 04:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757459; x=1703843859; bh=ThHNvtiBE1
	DXdy2l1mKw/6f1SBDmaL/UZAf45/H2Kwk=; b=r2sXgHq7k29a2MmaqqFMgeudU8
	pDQCVlwzoa2BC9e0ajGD4WNHCEfSawKlaQVPCHcw+Kbq7nvIt+BH/X+tFxwsR/3q
	4kAftn3UynPJpVX3rlFui1epgzc4DQ7whKKg7V8oQptb6nosDl6GMLIBS/syT4Kb
	YbUrcFhJ0H5336u+tNflm2t5SgBhxK8UmuaT5D8n+zAP9U/X5mHTr0PqMrJcsnrl
	EVcDtxP7kDAYaccWpaxNbIRpTUzIH2h8Mhj+GGpHPcIFxtAP3RtqbN3cu2D1BNv/
	Zl80drkrPbHA+wJ21x+Qbv2Tok8qPFc9X9AItBU8gwhCV83mckNPR1t+2zfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757459; x=1703843859; bh=ThHNvtiBE1DXdy2l1mKw/6f1SBDm
	aL/UZAf45/H2Kwk=; b=WGmGpSj2a+kDV0U8uJzFXFFgAneVJUi1rzA75J0NqxmJ
	vNPwslBV1RgtAi3dsxNafFWubiXOZNpNrN2s55q8h0xWhjvBS/gEMLIxMBXmrola
	TSYgySQ25pkA3x2iaQj15Vyw+3Jp22HT/ihPzRuNb2BywzluXQ8pCC0AYs0ZxsRe
	YKwtgFnIqUlKT7ZJNbMENVPgl/QzcpE2i7qPKfCurtlxLbGO1oKMXQ1lQU21ei3x
	/sOjAJXxzNcEMZBRDmc1wOGAxzmEbpYTRmKG3ZM+KMvXCFvVhSmmnB94+KkEtePU
	9HUHyheS9uHRsiFWfimL7R/NHzsc3bJl2Tk9MBPo6A==
X-ME-Sender: <xms:k0aNZdjHkIDiO5k758_M4edJ3h2FD4lhhrg2P-39LlyGThVgYZHGXQ>
    <xme:k0aNZSBDR6RC5vUu2U0OWKkbUUEh7pf9qs8W_FQy2BX1b4S7ja9-rV_-ByazEEf0_
    toTTxDNL5Qh54gWyw>
X-ME-Received: <xmr:k0aNZdGshpF2OsU4TQkpGB0ISN8ltHa3jlTvrQiJyKoVP9TIiiWNST-EcS3XA9JN3q7w-xIkiu41HZFS1qXdm_ejT_3a5zZ2466dgrTfXqcAnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:k0aNZSTHKsm-mbSeHNWb6cykTfSNHBEPOfaf4v9jrt6Ef7bLwi-8nQ>
    <xmx:k0aNZazmlB91M7AdhQPi67i5keTatsxkyP1HOicJUyWAYXODza4vbQ>
    <xmx:k0aNZY5bG4nnRl9aK6CBEkZc4mDymHsebNqWEZIP2q_PiveqqIwFrw>
    <xmx:k0aNZfoSvr9v2-INI7sOmS7Q8gn8aRliX3p7RjJYlL-UIYiPRPTG0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54df6443 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:23 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/12] refs: refactor logic to look up storage backends
Message-ID: <12329b99b753f79fe93fe017e71b08227d213c1e.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvuTqvYHElgRe7TD"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--kvuTqvYHElgRe7TD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to look up ref storage backends, we're currently using a linked
list of backends, where each backend is expected to set up its `next`
pointer to the next ref storage backend. This is kind of a weird setup
as backends need to be aware of other backends without much of a reason.

Refactor the code so that the array of backends is centrally defined in
"refs.c", where each backend is now identified by an integer constant.
Expose functions to translate from those integer constants to the name
and vice versa, which will be required by subsequent patches.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                | 34 +++++++++++++++++++++++++---------
 refs.h                |  3 +++
 refs/debug.c          |  1 -
 refs/files-backend.c  |  1 -
 refs/packed-backend.c |  1 -
 refs/refs-internal.h  |  1 -
 repository.h          |  3 +++
 7 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 16bfa21df7..ab14634731 100644
--- a/refs.c
+++ b/refs.c
@@ -33,17 +33,33 @@
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends =3D &refs_be_files;
+static const struct ref_storage_be *refs_backends[] =3D {
+	[REF_STORAGE_FORMAT_FILES] =3D &refs_be_files,
+};
=20
-static struct ref_storage_be *find_ref_storage_backend(const char *name)
+static const struct ref_storage_be *find_ref_storage_backend(int ref_stora=
ge_format)
 {
-	struct ref_storage_be *be;
-	for (be =3D refs_backends; be; be =3D be->next)
-		if (!strcmp(be->name, name))
-			return be;
+	if (ref_storage_format < ARRAY_SIZE(refs_backends))
+		return refs_backends[ref_storage_format];
 	return NULL;
 }
=20
+int ref_storage_format_by_name(const char *name)
+{
+	for (int i =3D 0; i < ARRAY_SIZE(refs_backends); i++)
+		if (refs_backends[i] && !strcmp(refs_backends[i]->name, name))
+			return i;
+	return REF_STORAGE_FORMAT_UNKNOWN;
+}
+
+const char *ref_storage_format_to_name(int ref_storage_format)
+{
+	const struct ref_storage_be *be =3D find_ref_storage_backend(ref_storage_=
format);
+	if (!be)
+		return "unknown";
+	return be->name;
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
@@ -2029,12 +2045,12 @@ static struct ref_store *ref_store_init(struct repo=
sitory *repo,
 					const char *gitdir,
 					unsigned int flags)
 {
-	const char *be_name =3D "files";
-	struct ref_storage_be *be =3D find_ref_storage_backend(be_name);
+	int format =3D REF_STORAGE_FORMAT_FILES;
+	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
 	struct ref_store *refs;
=20
 	if (!be)
-		BUG("reference backend %s is unknown", be_name);
+		BUG("reference backend is unknown");
=20
 	refs =3D be->init(repo, gitdir, flags);
 	return refs;
diff --git a/refs.h b/refs.h
index ff113bb12a..e2098ea51b 100644
--- a/refs.h
+++ b/refs.h
@@ -11,6 +11,9 @@ struct string_list;
 struct string_list_item;
 struct worktree;
=20
+int ref_storage_format_by_name(const char *name);
+const char *ref_storage_format_to_name(int ref_storage_format);
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
diff --git a/refs/debug.c b/refs/debug.c
index 83b7a0ba65..b9775f2c37 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -426,7 +426,6 @@ static int debug_reflog_expire(struct ref_store *ref_st=
ore, const char *refname,
 }
=20
 struct ref_storage_be refs_be_debug =3D {
-	.next =3D NULL,
 	.name =3D "debug",
 	.init =3D NULL,
 	.init_db =3D debug_init_db,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ad8b1d143f..43fd0ac760 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3241,7 +3241,6 @@ static int files_init_db(struct ref_store *ref_store,=
 struct strbuf *err UNUSED)
 }
=20
 struct ref_storage_be refs_be_files =3D {
-	.next =3D NULL,
 	.name =3D "files",
 	.init =3D files_ref_store_create,
 	.init_db =3D files_init_db,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b9fa097a29..8d1090e284 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1705,7 +1705,6 @@ static struct ref_iterator *packed_reflog_iterator_be=
gin(struct ref_store *ref_s
 }
=20
 struct ref_storage_be refs_be_packed =3D {
-	.next =3D NULL,
 	.name =3D "packed",
 	.init =3D packed_ref_store_create,
 	.init_db =3D packed_init_db,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4af83bf9a5..8e9f04cc67 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -663,7 +663,6 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_=
store, const char *refnam
 				 struct strbuf *referent);
=20
 struct ref_storage_be {
-	struct ref_storage_be *next;
 	const char *name;
 	ref_store_init_fn *init;
 	ref_init_db_fn *init_db;
diff --git a/repository.h b/repository.h
index 5f18486f64..ea4c488b81 100644
--- a/repository.h
+++ b/repository.h
@@ -24,6 +24,9 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
=20
+#define REF_STORAGE_FORMAT_UNKNOWN 0
+#define REF_STORAGE_FORMAT_FILES   1
+
 struct repo_settings {
 	int initialized;
=20
--=20
2.43.GIT


--kvuTqvYHElgRe7TD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRo8ACgkQVbJhu7ck
PpTgaQ/7BhhljrNCAGIKgOg9iO1A4hQNOD5Nz88SS6KPeKMicPHLi9KjsYBa9/RN
sLP3zpQYgUlQRT2jqljuJj8T6JAZ7+lEb1MoNpSlo4dO3aU1CKxIhC46f8SeXXA5
2dMXJRPrRvCriXRC9kZQES9Hl+JvM97EE90xoExZraA//NonDbvlx2As5Suh+VWl
JmkJzlx0+5FoGoGT5pX0oY4b68pRtYtlPoH3E8wLKiVyq0mY5RY9JMMhx4dkVWu9
j6z6HO4XFm0+lUzkZnLInVq1LqkFogFkoa0Xkh+WW/8v2YDLU+ZgtqXTVQVsOjdm
MjpQTgLnQ7c3eNYJLUk7syb5V55I4T1UleCs3NRtzGm/f9UJe6E+6ioBmBubATQZ
Yjret4mlwxZn2uyhmhfgoGdgJQwbFUEQoBU8xs/K1FlOaql2IPOWyiNH57D87UQp
2TyxNCzPuAT/VP+23fomFX3FMxXuE4zguxxg+Gzgv0iuZvq6Jvp3sT1/3nJQhnRA
lS2lM3bL1HGV6XHqOxIgbjjBrNYKAKijCvaaTqzSmY32daYyRqN232D0i7BfQyaO
H4UEyf8pX/IykRSEh8WKf7EG0HC1SUO2l98da5gzVBkeuQxB0qgWvP9zqJQw5idG
P4UuctwxUnrLkQlfpCJLS2slYTR8QRjJK2yO7XuoEIrmXox/cAg=
=8Qxq
-----END PGP SIGNATURE-----

--kvuTqvYHElgRe7TD--
