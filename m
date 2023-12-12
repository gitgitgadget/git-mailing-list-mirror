Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lXQz73RQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bD1ebJYC"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2AEA
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:00:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id BFE913200B0D
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Dec 2023 02:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364449; x=1702450849; bh=uni2VhHKzH
	YX2vT2EIiLdh+SES9Aqq3D9YONPvF6eQQ=; b=lXQz73RQSRUqQ9sxZmCI7rivsZ
	jkExxPAEZ+c5OhdXO029c/ujt53LomInHTZmu1ffzgpIVM04viSHPDJgH6+nfwyA
	PQ/NqKtvVYgviEUOEbl301a25TmrSyoC1D4hoBu7Ja7Yr8e12bdVyPwUXMbM9GFe
	snROwf7b9zFTKjDZ10Fy7RfBlAOMsThIfjmkmBWgLLPwu2BJd2qi3h+WT9Wbmoda
	rW3VyDk4ieAw/NCNisJz/GUI+sS5pRWuSuU+lUDipxgfRqa9la2GSHjdeCqGrMjZ
	nL6VJB2l1F440EmOTg9o6r4vi99qWmuM95nFVFETE7MnOnbp7dvNQKYiF0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364449; x=1702450849; bh=uni2VhHKzHYX2vT2EIiLdh+SES9A
	qq3D9YONPvF6eQQ=; b=bD1ebJYCv94HU9544ncD5tAAxqIdEIjHZeEEF8CnpL6L
	661z+6nECIX7GEA51OleW96Ohx/CB7F5mzQaz2wcrbTgsGjfoNaL8bccGVzBT29U
	c0LXqsSYezlr4INX4u7U4f9AGoHjqTixMdmsp0rq3iUF88gl31l3KjzmkOSYdHSq
	bwJTZQebPupSt3fDCg0oWQyP65UXh2lJhvTZpsXKpfyViwqv3PRbVfNRFFLBsH5i
	wogt/0x/c9es03ZE1eBcBxoO4SMll3FX1/T3FCFRosT5F7xwW/qADgslQYacL9FZ
	duYV/D9d0Rf0xO2XeVjHkkr3uueFbcUKpRjEyxTnQw==
X-ME-Sender: <xms:IAV4ZUQ-zIx9SUKnnVweKdmqjjbPbJgL_ucjYsHpJcczyNlefCyFeQ>
    <xme:IAV4ZRy3jRlL38yjFxphWak5S_CPPa9wQud3htCnP-ZjH8n_s-FBFr9d1Lzn5K8lk
    6tekbAH0_jsgbWCpw>
X-ME-Received: <xmr:IAV4ZR13CkERmqdmJGdhIIBbOCqqso1prJRDukLn_mkhMXenKhyOrLyDalqfgUqQRXaYYiOI4962qmR6rXpRDGRIa6mzUdGYq_Y1R2375QPfMZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IAV4ZYAxGFIshW_kmAQtfLC7_FL7Wbmcf9qrA5R0yNG1hgJkVRfyzg>
    <xmx:IAV4ZdjXCY-fl-QwzGaRz3NkjamsRQjxGazaitGs5bE4oQkCTeOn7g>
    <xmx:IAV4ZUqTI4vHFjot1x8dwI5CP7f9WHQNiDKXNufNT5Qsji9jk50V-g>
    <xmx:IQV4ZXcxz5pd7hAzIU5MIPZX4kEgpCEnRmXEXZBJvBfXNVvuAzAanQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94eb4b6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:09 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:00:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 2/7] setup: allow skipping creation of the refdb
Message-ID: <40005ac1f14c8d0c1fc474351554ebe4fdec1cf4.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ps+zen20DyxrPGPd"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--Ps+zen20DyxrPGPd
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
index 865cfe6743..d6a1c59b7b 100644
--- a/setup.c
+++ b/setup.c
@@ -1949,11 +1949,9 @@ static void create_reference_database(const char *in=
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
@@ -2024,7 +2022,6 @@ static int create_default_files(const char *template_=
path,
 		adjust_shared_perm(get_git_dir());
 	}
=20
-	create_reference_database(initial_branch, quiet);
 	initialize_repository_version(fmt->hash_algo, 0);
=20
 	/* Check filemode trustability */
@@ -2184,11 +2181,11 @@ int init_db(const char *git_dir, const char *real_g=
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
2.43.GIT


--Ps+zen20DyxrPGPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BR0ACgkQVbJhu7ck
PpTsgBAAguVfnmc2+Dmmjm1GScYcbVk/XQCcFGXWuBliycjExXCyYbcP05lKvxBj
z8fbmy32VfWOqOA1utqZys3xs99VQg3t49eSdmJ0vcdxgCqF5E/NxkrMEcBXg4zO
7wpwTSCSHVPaB2Z9GQw//5BWqnp6urAld+5D8fyTJ89gKkFVDfQG979pWZulc0b2
nGYmCuKBDTXy/UebChew3xydF+o0Y3OaDAnfks/oeEfALSkoMU/eHzmtUoePNAy4
SJbSjt7UWxeXfEaWmF2zimExNEthK7VZhD7mH4nyE6VJsNb9GfuGV3/9XPkqDR2t
xfFGfohshfcVThj0nvsf2cW7657nNJxEot4xVK5LK7B26ADkWsXDD0zpFPbCfeWD
gYzM6+Jm5OWesctxoLZ4qFucmwwTN98jzWsxxs+4RYHyOz+QNM6QXiBITzB+SrCB
dJLPI5fmQY1ZPIwlajK+1n4OKdsUizdD5jSGldpkyAgKuhpsNNu/7VxvTf/GzeAJ
xCeMsx6Lwn0hgoMfJXaZZF3PWEfEqEDuRKBr4HgteIJO3yLLR5Q6GKoNi/zpoOpo
tBIRjBkqZpAqkWQGTscQjpfbGDE8R/dDn73KDPfgRO4vkOXOc4idFWH57XB6ECqr
sLUcNQyXm9xPyRKVnFNW3w0Raxh7VbiodT95pfU1Tzxa8S21/KU=
=k2Q5
-----END PGP SIGNATURE-----

--Ps+zen20DyxrPGPd--
