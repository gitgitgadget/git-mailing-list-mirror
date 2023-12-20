Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B2520DCE
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qkwh2IO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjNIFCLZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DDD3B5C01EA
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 20 Dec 2023 05:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069705; x=1703156105; bh=NX15AkWQiH
	XZTuHvUlE8zxVn+1KsfwobacLj7bPUMpU=; b=qkwh2IO7lpA/5jsHwX4MksC8rJ
	EZCBB+h0HZab6ErVI+GeU8RhUlM3jLpJywBlSUm1RHiylT0D6TMPoFi6qHArGin1
	x+NN0e/OFI9n4YL4sdT46Z4/ek5zeO5Ifd1+Ti0OK0vOy4IpVVhPa3q50nvC09ze
	V+BlDV5oMp3Fu8yRvpVL55seQZpqVQ2KtcFBszDWgit9XfYq3RIO1AgD1GIRgYXB
	CpxBMvaN1Ip6FkkwNzYiQu2JqIkXIIt1gjvJ6Da9UL3X7nXEgkmCN8/BVRGyv+hS
	QV+MSP/kybW+d4wb/xc2hkXmqIQJ3330u7OWmuqmi8nZMnJQZpsD7jNzjdpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069705; x=1703156105; bh=NX15AkWQiHXZTuHvUlE8zxVn+1Ks
	fwobacLj7bPUMpU=; b=kjNIFCLZxwm7bNm07n/zhL3d12ncjDWlmoxF1D4Dh8bl
	6El9oNCVI2cMg6po0cLXwIzCZyYTrOjccI5CX8GmUNu8Lj1kkZSJZrHwzVZie1iB
	k7iNCwKCVKHwwLxo/X6u4bA46rUnZtc8237KZV+X3wSamsIN5Y9ouD98NVtAqK3f
	D3s4p+v6ZaZMEEOlQjBAYkxZ8jbGB+L5CtC874GjofN1cDbl/u/jrQwz57lGXQuW
	V1AUKgIrIMA9NohxMYMXeeGdKHeQU64vPubMfPlP7D2apGUJFt3JnZ2Umt7oXce0
	hIynS4RACTeqhXdlCfqe3frNfbB/Eh6V2MI17J7QHg==
X-ME-Sender: <xms:CciCZSiUkV4mX48-c3BoS6uyKvDq8ZFwCYoMQHJc4cP0QUgP6J57GQ>
    <xme:CciCZTAh7puvEvBOVFxRkb9KZn96GuHLUQuwwTNVSIyqE_CPFKs8vaU0Vz7MTDEuI
    RbXS1tq927SlyuLUA>
X-ME-Received: <xmr:CciCZaGZ1YV8F_PFneE7KYykb_ovJrBrCNPXEf2M2uTJgzwcFUAmFC67z-7IlqAzR6tKmN_HmQFGng-AlX2tAvWIciPQNhLLbKxXoh-wHbQUTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CciCZbR7SGdhoYZHEwXq5YHB4p_ZntWkTk_ykKGmCI1KFydXn_19Tw>
    <xmx:CciCZfwnNHeSpyx2_OQpmsT7dnl-0YSk5CGKBUjSpKo_lgfAGKxvvA>
    <xmx:CciCZZ4KWIIeLd7qHe_8cYefIfE3QsiUbtICqTdIeet9mDpkNTAaaQ>
    <xmx:CciCZQtKAwziEOvoyy88pEP6Q8hr4K6LuDJRe3tbrzKWH3kJpkmVNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 957c7c2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:10 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/12] refs: refactor logic to look up storage backends
Message-ID: <f712d5ef5bc5bed423cf50a0d0489095ba103df7.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LCUyAZtwx+2dt6ug"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--LCUyAZtwx+2dt6ug
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
index 16bfa21df7..e87c85897d 100644
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
+	if (ref_storage_format && ref_storage_format < ARRAY_SIZE(refs_backends))
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
+		BUG("reference backend %s is unknown", ref_storage_format_to_name(format=
));
=20
 	refs =3D be->init(repo, gitdir, flags);
 	return refs;
diff --git a/refs.h b/refs.h
index 23211a5ea1..c6571bcf6c 100644
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


--LCUyAZtwx+2dt6ug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyAYACgkQVbJhu7ck
PpQsgQ//c8nNNT9+vaJlshLjGd6yb/Kusfg+XEUyCCXZ55kUgyesqyE2XPnWvOWB
4v1VWxV/p1DFPIESVacJP64efTDM1/n7V3xs4X0d7Etf/q7WXcNfC7r+046qEO7z
JarbzOc0WpJiCKj6FAMkgVUgPw2VWjH3D4BLoa416kHEeRbdGLEgYz4U9WymtAyC
TTqfH4Nk3JfGKnAB6l5TJGo96iX+6hXd5n59KlnlxRVrE4FbYSMnfgUCz8Y5zyqc
pnf9nAuDbu6TTshvn7Ja1SB/2A/IWVPvbidH4OkXPxVLNoKtP2g7Kkv4vM/p7aCg
NDF27CyvX/s978RUKWQ96SKxHGhC5ymJn8R6TuqBeUPzaH5f8LKwY9niKzBjsycf
u8M03sUviVjl5SuWpUmChLMeTGFfhYQmbGFlcUIT3KzXYPGX4TEVTbRmIkljshh8
lSZyShUj9t82y/2sJOg5OicMM9Y0gFzpY606ADQWsAqzxBLuZyXLZ1V2EQPbd5uT
VpYlwozsAtZKjfI0k1s13hIpuEl15p9RigATrKqlryve3WGSe46iuXxckNZFfQ1x
P2S2XmPoEGIeVbMo4gYmJejSznwZ8TjIBzE3tb1kd686ubR/72IjJmOjh8qz7nGi
xyhF+N8tUubJgX+gIoTCvzI+LyIKAd5YsfnzpwCUYKPBQRAfDko=
=FZNn
-----END PGP SIGNATURE-----

--LCUyAZtwx+2dt6ug--
