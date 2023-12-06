Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qggpKXq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRAFqlAo"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0011F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:39:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 1A7625C0296
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:39:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Dec 2023 07:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866396; x=1701952796; bh=CM
	Kql7Y6w2gk0ZgTan/FbtV8+K23/QmNr1OxXreKeuE=; b=qggpKXq8B841nnedva
	oKUhwjZtWMR02vLJSn0B2S1nRU9lPecur36QRgojhxgMBcCCc3aYdRDmuyRZGVYQ
	S5DLYuz0l5vKS9blPVjKNBl4Sd255S8SJY4Q067vrHnWnRCo45P8yY2X0pMqvMu8
	eFiMfSKCN9ABQ1RkLZXY5h2Pf9kUIZJO23GyU+umFAM+pF/rstzCZvjszyYzJYYL
	Z+SWDk3AZEREiIOV7toVQllE8N8O8uG5k5kGiFUoeWx5zBlzF01RPMZIa/dwOHS8
	MvYfRoVg+UZLJl1/uM1MF0YA4ze9qfO31BlnGnl4m066BJpKnZO3+e7292c4eG3v
	A9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866396; x=1701952796; bh=CMKql7Y6w2gk0
	ZgTan/FbtV8+K23/QmNr1OxXreKeuE=; b=XRAFqlAoMnKDuRmN05F1DlupKySmn
	AbgdkioyVmAJzuR6VVmnL3t4ftdQ7lY+tAF+Bs+PdsXBi4p037kE5ba7yawstLeG
	2bywoF4WJ/+SW8+kGtZiE7JoDNppjr1zb4FKMCNqeKDPtTcPZIbCsob7XUAHrmPb
	ClY3yIE2o7FQmKnm/wHAAhfdvKrNzRodvFerrZyYqTR1dCyfl6ki/BiW1oow8k1g
	GILPwUy0vb+TwWnkcVoabS7s9mi/nRmuyOZeBLWNas42oWylcRsu2IjaP6KCt+VF
	4FNgZoilg/1ziDmk8wOXPn4XfE2M5eOVaAPuC1pU/FzLxITn1NSriYVYQ==
X-ME-Sender: <xms:m2twZSZs8X2I9XMwufRkuF0Ae6NeftcNDirk-NcVgthQw9lHtwqfXw>
    <xme:m2twZVZM83XWIklli7z6bTJCRPmzXizqmllhmYEQCXMviitD3TF1tIaJGP2dVEzii
    8TZksztkII1NaRRHQ>
X-ME-Received: <xmr:m2twZc8c1bnslrFwt4LVkLrZEQHdQo_VdWXUcyqpqZb9fiGc3-yEI2GrHsh3Bp6qILYtnMFhIzgIa3A79k6eN4OWx7jFePEtvN0EBvWaEEa6yLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:m2twZUqqVu1Xm_7V8d-aHGWPydrdbE-B3iDLaSjDYfNHtzrCkZFKkQ>
    <xmx:m2twZdrBYE8uMHnsXfAhnG6Z0gy2hS6SAR0HpNtJBYfOtrgMHSqbNA>
    <xmx:m2twZSQCO_xEkeNwYz1YwUQHFkNp78jAApzbr44XNV04bziV_H83bg>
    <xmx:nGtwZfFz-DI4g0S1Pxucgip2nLD-M4tujyowze38BFdixp5Tspnwkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:39:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b8b4ed6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:29 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:39:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] setup: allow skipping creation of the refdb
Message-ID: <090c52423e3de9c4e94c6694bb18fb8510a3ad08.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7DNmvi2Cj+IB6leh"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--7DNmvi2Cj+IB6leh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allow callers to skip creation of the reference database via a new flag
`INIT_DB_SKIP_REFDB`, which is required for git-clone(1) so that we can
create it at a later point once the object format has been discovered
=66rom the remote repository.

Note that we also uplift the call to `create_reference_database()` into
`init_db()`, which makes it easier to handle the new flag for us. This
changes the order in which we do initialization so that we now set up
the Git configuration before we create the reference database. In
practice this move should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 13 +++++--------
 setup.h |  5 +++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/setup.c b/setup.c
index 9fcb64159f..a80fc09b9c 100644
--- a/setup.c
+++ b/setup.c
@@ -1941,11 +1941,9 @@ static void create_reference_database(const char *in=
itial_branch, int quiet)
=20
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
-				const char *initial_branch,
 				const struct repository_format *fmt,
 				int prev_bare_repository,
-				int init_shared_repository,
-				int quiet)
+				int init_shared_repository)
 {
 	struct stat st1;
 	struct strbuf buf =3D STRBUF_INIT;
@@ -2016,7 +2014,6 @@ static int create_default_files(const char *template_=
path,
 		adjust_shared_perm(get_git_dir());
 	}
=20
-	create_reference_database(initial_branch, quiet);
 	initialize_repository_version(fmt->hash_algo, 0);
=20
 	/* Check filemode trustability */
@@ -2176,11 +2173,11 @@ int init_db(const char *git_dir, const char *real_g=
it_dir,
 	validate_hash_algorithm(&repo_fmt, hash);
=20
 	reinit =3D create_default_files(template_dir, original_git_dir,
-				      initial_branch, &repo_fmt,
-				      prev_bare_repository,
-				      init_shared_repository,
-				      flags & INIT_DB_QUIET);
+				      &repo_fmt, prev_bare_repository,
+				      init_shared_repository);
=20
+	if (!(flags & INIT_DB_SKIP_REFDB))
+		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
=20
 	if (get_shared_repository()) {
diff --git a/setup.h b/setup.h
index b48cf1c43b..cbf538286b 100644
--- a/setup.h
+++ b/setup.h
@@ -169,8 +169,9 @@ int verify_repository_format(const struct repository_fo=
rmat *format,
  */
 void check_repository_format(struct repository_format *fmt);
=20
-#define INIT_DB_QUIET 0x0001
-#define INIT_DB_EXIST_OK 0x0002
+#define INIT_DB_QUIET      (1 << 0)
+#define INIT_DB_EXIST_OK   (1 << 1)
+#define INIT_DB_SKIP_REFDB (1 << 2)
=20
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
--=20
2.43.0


--7DNmvi2Cj+IB6leh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa5gACgkQVbJhu7ck
PpQu7w/+MKVnV9Gbyh2mfYMA9FTLUE6edR7WBXGRfqMiCm5eAz0T48UTjIH5nnBP
/BxqyIixDn3DK1e5BonkBvEcEYrMrWUJdGsugXMunjSsVeb8otNIi/kNapBYD3RZ
IgjXIa1EbHEkrofPZd9nJVL5884/q4QBS965cUGkoUvEcTSrqOG3SdGizKxoodEd
kieMr9OyYX4mg/Tj2FOKwnE1PNsxLm+OUvhw/08TAyhLoDKfmHKZiC4F85VhFGaz
qNEjrMUQSXruCaeRUOV1TRSZPyOJQ4hxZagl9zEMaYj5W3jr2PQ8PgNwhivQLU3P
JwEREe+fND03zyxhMZpp2I9JWCDX0HcHoHVQVhQEYBD3aFzccKq3nNgW3o4habNx
6q2OunsQUduA272p74GOSBObaCHHEqI3rTFm868B9pvCgs9kDu+x6SQUiXDVFdxw
KLewBTh08G3zq6gGnfINaXT1oPzHBA+PCU8duri5U84F8Mbuc6krThHtXjd8jchN
qqUgIzp1vMGfgMG5UBBhSCZ3USKPgW7N5UXukLREJqPiSMwX26U7VlyRP9cY98VG
NHnoaf30auhyVrOAWTgjMNm1KMF3Y4Mh12eaG1vUEC8UgqalcJpjYakPcuscm8YO
+wOfmuSf0+QHBTMw6DtIl8tnJEg36aJaJuVHmE9WjobRIPBvKPU=
=R7JJ
-----END PGP SIGNATURE-----

--7DNmvi2Cj+IB6leh--
