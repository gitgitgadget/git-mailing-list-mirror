Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BF13ADC
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JpcfkzPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p4yz3V74"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1349A5C17AE;
	Mon,  8 Jan 2024 05:05:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Jan 2024 05:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708330; x=1704794730; bh=u03mXpqfwD
	pGRcsqqauszz3ZYI9hwvjIVDUwcoetir4=; b=JpcfkzPt0mHmPCjQ/WXhuWfMvY
	x2SBzhZjl4meQD8Jyy1n/VxFD3h8sgiHTBQLtQnSbrbaN4w3z2eb345TIEDhRL7o
	nbNb5kiBTq4rQixAP53PQla4c3MVxWgUkEnN+b51GL/dHD6baL5inkmgHocmSsnX
	NuUfvhERcEZk4Qc6eDCJiqCiAT1lGevCYrl8zlKTPPsDJzgswkd8vFjOAeSAAWE9
	GPmRimcmIgNwZoWvFUT0pYhf/LihWuIRZ/EhIXercGAGLnvrxMm7dBIRK1EuPhHz
	veJZdkCjNZMH3T1aUq5hX2gh6qLPIfu/mK6UR0zrh0ycPBP5YPgorbzewvTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708330; x=1704794730; bh=u03mXpqfwDpGRcsqqauszz3ZYI9h
	wvjIVDUwcoetir4=; b=p4yz3V74hnQUiO9ehdTasn6dlR1USsEzzUyZEGM8O3cV
	q2I3aPb5Qyk3YlpX6uKGnXhW71mhp8gUZ8ry86S4/0r9BfveuY43pYs26GnzsIh2
	STC0QCrRDR2rLRt7fKaHdUkHo2MeJCv1NznsnYZp53qqa778LQ7MiB5saMipS9rA
	pIB2KDJZ8aK30grt1Ybv6inKel1ayXbpzDVfRtWRgwYAVyQm+rY+mqSlosJsYsYk
	nA1mpOLZ94e95y9VfqrgQoNHUkUTHhOLcGlR3PSEduMFXf5fdAfb0ikH+r0XiwZ/
	ltmrVdWf/u+W3eTj6nX4WeXy6ddjAP5GXUsPowvRlg==
X-ME-Sender: <xms:6cibZbHCx2uMkS66oE20DthrZbZlb5jPGVRjdRlwgRlSvfdZNME7Lw>
    <xme:6cibZYUHG55pytAOPIkdQvj2qujfGHw-HtKhME3F5RzT7ZDE6b6mZkQCqWNBrHsu1
    OuFLYgQDqAP-DjStw>
X-ME-Received: <xmr:6cibZdIJQNbJ9F5P24sMnuqadQcg7ABB1xZ_EyJWzzi5r9Pvj_aHZp7bJH3wl5pEOYpPVMEz-VUWxiPEkPAOQQ49OHn7a5QwlMfhFi-R_J8gukk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6cibZZFGkjBbVKmU88t4tMaHtG7BSjmUOOi7LKQs7_ReUpNNk49ykw>
    <xmx:6cibZRUWniF70Tl0FpgVCHGwF64zwj_--8gaN_1gVmZLs2aXKf2Niw>
    <xmx:6cibZUPhaGqBiuzAM1V0tmgoKky0xJPFZw8Z02TYinjR0_Xha8taLw>
    <xmx:6sibZejw630I8cybl2qZ_sXBDYcSd_drWC76Jiy-IREw_U1WkGmOPA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27d864aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:02:52 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/6] refs: prepare `refs_init_db()` for initializing
 worktree refs
Message-ID: <a4894b3e156617c4350ab2f8d794ab32039d3fab.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
 <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IODYJ/B65FhY5hgf"
Content-Disposition: inline
In-Reply-To: <cover.1704705733.git.ps@pks.im>


--IODYJ/B65FhY5hgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The purpose of `refs_init_db()` is to initialize the on-disk files of a
new ref database. The function is quite inflexible right now though, as
callers can neither specify the `struct ref_store` nor can they pass any
flags.

Refactor the interface to accept both of these. This will be required so
that we can start initializing per-worktree ref databases via the ref
backend instead of open-coding the initialization in "worktree.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                | 6 ++----
 refs.h                | 2 +-
 refs/debug.c          | 4 ++--
 refs/files-backend.c  | 4 +++-
 refs/packed-backend.c | 1 +
 refs/refs-internal.h  | 4 +++-
 setup.c               | 2 +-
 7 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index fdbf5f4cb1..254272ba6f 100644
--- a/refs.c
+++ b/refs.c
@@ -1944,11 +1944,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store=
 *refs,
 }
=20
 /* backend functions */
-int refs_init_db(struct strbuf *err)
+int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err)
 {
-	struct ref_store *refs =3D get_main_ref_store(the_repository);
-
-	return refs->be->init_db(refs, err);
+	return refs->be->init_db(refs, flags, err);
 }
=20
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
diff --git a/refs.h b/refs.h
index 916b874ae3..114caa272a 100644
--- a/refs.h
+++ b/refs.h
@@ -126,7 +126,7 @@ int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
=20
-int refs_init_db(struct strbuf *err);
+int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err);
=20
 /*
  * Return the peeled value of the oid currently being iterated via
diff --git a/refs/debug.c b/refs/debug.c
index b9775f2c37..634681ca44 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -33,10 +33,10 @@ struct ref_store *maybe_debug_wrap_ref_store(const char=
 *gitdir, struct ref_stor
 	return (struct ref_store *)res;
 }
=20
-static int debug_init_db(struct ref_store *refs, struct strbuf *err)
+static int debug_init_db(struct ref_store *refs, int flags, struct strbuf =
*err)
 {
 	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
-	int res =3D drefs->refs->be->init_db(drefs->refs, err);
+	int res =3D drefs->refs->be->init_db(drefs->refs, flags, err);
 	trace_printf_key(&trace_refs, "init_db: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 43fd0ac760..153efe6662 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3220,7 +3220,9 @@ static int files_reflog_expire(struct ref_store *ref_=
store,
 	return -1;
 }
=20
-static int files_init_db(struct ref_store *ref_store, struct strbuf *err U=
NUSED)
+static int files_init_db(struct ref_store *ref_store,
+			 int flags UNUSED,
+			 struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =3D
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 8d1090e284..217f052d34 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1246,6 +1246,7 @@ static const char PACKED_REFS_HEADER[] =3D
 	"# pack-refs with: peeled fully-peeled sorted \n";
=20
 static int packed_init_db(struct ref_store *ref_store UNUSED,
+			  int flags UNUSED,
 			  struct strbuf *err UNUSED)
 {
 	/* Nothing to do. */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8e9f04cc67..82219829b0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -529,7 +529,9 @@ typedef struct ref_store *ref_store_init_fn(struct repo=
sitory *repo,
 					    const char *gitdir,
 					    unsigned int flags);
=20
-typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
+typedef int ref_init_db_fn(struct ref_store *refs,
+			   int flags,
+			   struct strbuf *err);
=20
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
diff --git a/setup.c b/setup.c
index 1ab1a66bcb..6c8f656f7c 100644
--- a/setup.c
+++ b/setup.c
@@ -1943,7 +1943,7 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 	adjust_shared_perm(git_path("refs"));
=20
 	repo_set_ref_storage_format(the_repository, ref_storage_format);
-	if (refs_init_db(&err))
+	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
=20
 	/*
--=20
2.43.GIT


--IODYJ/B65FhY5hgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyOUACgkQVbJhu7ck
PpS0GRAAm/gWgk8fc63U4v9+HMi9u84dTss1SqWFAGxhFgVSjnEvyPr5CwlM9YdV
ldOsZQ4sbjKEltdCcS20Fa5Aun3cPqilrflvn+SSyYWGgyjAKrMw9G7/xcNRp2Ml
7O+KxPNiRtIq0TYJvu0LPzmFwwfg8jCNMkXf4UIUq8IlJCS3oIKtBqlRLYLYDiUR
gW4ZSK2MTR02c/s5rZJz2+MqQ6e6nYXi8JCMaqdEuuYZ22s+DBwkoARjfZH6OhdH
BY8GYhFd0pr/DZddm3OqbnQriMXRjMXLVQ5OlCxy99cquN9U6IJ+nKi5CminnMEQ
y89xcVAhefX6NPBisqDPgD6/HJYC/8Ojb4z6e+7uIAuIiD8vQqNmgUcdQagW41Bc
iK3WU5OIl4xn7IY2BFwbKhhtFZ9ENEGWC9tXAP7fCgBCHXomIjfUIgdnGvPOFk4T
2Solg8wCNG6pQwQDdy4BNfccLSK8z05Nzfoj/xqOEcQd01ELLfAdBVvl2BTCaF59
xwGIHkbzEWqPMeBJIV34fgNb01Sc58TeJ6O1qS74+azk7H8s0PmXkgqnSe14y1a9
h2KzE0ooN4D96FiSou7DlKmac7ipYxGoUgCpV2KvBgfT/bzKFuNYBj5KzlbQtxvM
/3PFIs3deH2/qaFdkAVqSBGhbc/RCLr9MFJdA5b5k8UelSrxke4=
=lwHe
-----END PGP SIGNATURE-----

--IODYJ/B65FhY5hgf--
