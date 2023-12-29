Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86936749E
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PP3PcLcS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+Vo8+WJ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 8CC515C0170;
	Fri, 29 Dec 2023 02:26:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Dec 2023 02:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834797; x=1703921197; bh=UlzgFyWtOj
	RN8FyJ+RcOA+QGgYplpC0mh8MpSMHX4/4=; b=PP3PcLcSNLAYV0Atnua3J8RTJ/
	fZUy0XBR0q0pwUjqt+7rx8Ru4wMMZxgFzzQDv7fbn6H0LRD3RZlaakOan0r/3V7b
	SdlLTAhJUY66sQQbPst1hxRo2nMXkw3l/uPDE7TFQrwGObgH/pWURXzd40F0MTaH
	qsPv3wm0Ndjv/4A98Q1+l7ScJ7MzAhrWYcKsBF0jtKNgP1pfD29WqR1igZ9bhSdH
	Yjwa1xbINHgXlLdz8sDNfv4FA+SIdOIiKshJ3s2KeeCzaTLVLKzFY8ZD7pad0C6G
	SHGw4wWxLkjKgMXVVABShRNiuhBnG9y808VoJyF1YduKkifCurfmt2P4CeuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834797; x=1703921197; bh=UlzgFyWtOjRN8FyJ+RcOA+QGgYpl
	pC0mh8MpSMHX4/4=; b=c+Vo8+WJ4VaZ46VcTfI/7lb0y1VTXWcbO4oUHZv+Z0Vr
	B3g090M8B1P9DXfEyNq1Q/rFQF9tJOnUSx97Q3ANWvvStKeJsbPwdqKfA5eTmv9o
	+I+FIFuYrvP665jhhopvNg5Ppbmg5pVNQ2A6w9pMdfsJXBiFXwKN5jpGcgpd6Ho9
	6BivAXDhyouplIz3I/p+ScZlI0BYvMCfp5khNDiNggnCHxRVBcocGipwA0tZQONT
	h3M9n1V14RCA+cJ2/cYzcmReGGtfmBFySYcVsD6fclePTYTUtQKs93k0HUkJ+mnx
	cThChd3bYXuWlkTAd0dGR0kXOukrkjYLWAVx2jQY+w==
X-ME-Sender: <xms:rXSOZQ1RbstSczvZb3EzEQZnQ-il_EW8xKR2WE2NHrTLpp6Wy5kEEA>
    <xme:rXSOZbFMvAD1KBQaTTm9enT4c2EBdgVJJmR-lUkitMa2964yAC_rSKkANV6mBKehU
    gSfFNcEo6fgl4AYRg>
X-ME-Received: <xmr:rXSOZY4FoKUCfCHhHYlr_UaX9SKR3es-FDXc50N1BwgsqXGmniUyXydEnv2fKzWjQxqPnqbWq2Pi6SN8hjnYVk1tbMRtS6c8_QYoWKa2yI2SbGsu6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:rXSOZZ1d69EQ12AVSDn6lLLabvq8knOIcEA13L44tNBi7dylIW4unA>
    <xmx:rXSOZTGuUYYxSwwjxng6_JSvmp6LcdXyHBbMIy3scRTdrPIhGj5OOQ>
    <xmx:rXSOZS_NWSfMHImpRSjKaqj8i1Kr0deqhq5GvUXQNmKKmF1qLMi6dw>
    <xmx:rXSOZYTwl2TR1DPHK27EfAsBfetTRZweqqq8x2zUNgJ-D73xLaoEnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c6308e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:20 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/12] refs: refactor logic to look up storage backends
Message-ID: <47649570bffe2d3b9c6bc0322f23c549827bce1d.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LIzJYhn9ndQvPAos"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--LIzJYhn9ndQvPAos
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
index 16bfa21df7..dea3d5c9a0 100644
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
+static const struct ref_storage_be *find_ref_storage_backend(unsigned int =
ref_storage_format)
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
+unsigned int ref_storage_format_by_name(const char *name)
+{
+	for (unsigned int i =3D 0; i < ARRAY_SIZE(refs_backends); i++)
+		if (refs_backends[i] && !strcmp(refs_backends[i]->name, name))
+			return i;
+	return REF_STORAGE_FORMAT_UNKNOWN;
+}
+
+const char *ref_storage_format_to_name(unsigned int ref_storage_format)
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
+	unsigned int format =3D REF_STORAGE_FORMAT_FILES;
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
index ff113bb12a..11b3b6ccea 100644
--- a/refs.h
+++ b/refs.h
@@ -11,6 +11,9 @@ struct string_list;
 struct string_list_item;
 struct worktree;
=20
+unsigned int ref_storage_format_by_name(const char *name);
+const char *ref_storage_format_to_name(unsigned int ref_storage_format);
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


--LIzJYhn9ndQvPAos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdKkACgkQVbJhu7ck
PpSgag//Z+SYPN32A+0YBwXQ6feJcKbQZ6Y1yg5Y9qxz+IJMKsz9nRcDv9CsLAHv
aKfC6SHXhyWQoOCo1lq5IXnk7knSlnD+tofAVX0PsVe6feLRfrMKwvEKjWZNic/z
IVjnu6cjaVIQRO3xN+zq2wUKCjhCVKG29ulaopaiXhZtUrDrsnnponzFTOs/JY8b
ITJg1j9qfEmbdNUE41tyM2CSYY5rJvx5qQVaSPgHZg1CiZmub5AbhDgnV1DSosS1
W2jdxvfh1tc2c6zl3lRFqi/w0UVUxCFKS3FydvdjYiH/gUPkkqYzk1qvP9Q6tqi8
gnsCxCeLqSSbvqz4KT5+sOcvAd9m2+FyoIfNHz9eLMqF/TP4BKMZbqLnKkfbTInM
uDkKhjjTCUEnlxFceGmMgJC9WGUPyFSy9xlQzc4KNwf8zgZJELWzcBdTBcL2aRBO
r4sF0P/7+E0Qqerly8CKTgxgY1BIxbaTVXqrsIXTAPsoqmjSWQYUUYxGo3ESKmrZ
4ZsYlrbdKdF4z4UiTin3hIMLHi7y7QWWudq5Ya+opI17nxQwM0MW205tzWxUnRcO
LW4A4BMlJ5u/dItuKpmHYeCqnMEnhG/9xE3gr3DN3HVxNNalACsvFJRQcYVuJ7bM
QNjz4sWUjyiAuXin9xnkkZg5gYyon4VlR9sGS+fnsj/xwwqnfz4=
=a5Ea
-----END PGP SIGNATURE-----

--LIzJYhn9ndQvPAos--
