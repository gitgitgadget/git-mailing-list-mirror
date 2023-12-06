Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HwdzjbNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXpbIAbs"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363911F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:40:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E09135C029B
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:40:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Dec 2023 07:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866417; x=1701952817; bh=Si
	NMrssfWAqK6wKLQudCbA7utvmo8GD+9E6sFgkqLN0=; b=HwdzjbNc3MNq/tEFVq
	PR8aoS8IdJ/TN6kNp8kyBeq3RrJ07auvbQlfNP63IHXIz8oRvZNkuh/AhkunRW8b
	HfPYNX/4w6zQtHMFW1odPVKfUzOI+v9Uuu0JqDXs3p9XtEHMbDFpr00IGrHJS9Ji
	rucYxIGjOvxQ9QK73seW7cF5rAtpVXXlHqTlcn9Np8MDN+DQ/f6a+9LEowvjmOxo
	stdzHqWJJ2B1kvZxjmXueWfDRT8FkrUJWlbWHk0yi2An9MGjApQM2WaNTIKbgD1H
	mUjAi9YOzfjRT7vvWfXrcIP6aV6niHDeEr7ys1cI4nicAMhjhfWCZZIYAR/ebAAl
	QPqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866417; x=1701952817; bh=SiNMrssfWAqK6
	wKLQudCbA7utvmo8GD+9E6sFgkqLN0=; b=kXpbIAbsXuRQsTIGAYzkPGyPEaLTW
	lY3HYJHjGpPYw15wAtYodPJTT2BW+8/HrZTG58rcW/8qElGuLD6pTcuK9l81BoBr
	5Bpk79EAazHkcijRsWThtud6/LGJKVeKavNLhD766pQdn7TMAoLht5K9QYF9UZGN
	6VDI8GCYUMbNj++AMg+0w0RoK5PPwHCibic1lJUPjGf3hvMcK3XUv/Z/qfKuNvUu
	txX3/Np9aTJWN5pjPPDrNJdcCEBu22vzYFpI1nMDb21oU4cR3UGw/5p1Z/HKl1qf
	RDrdMHE9DvZjklynx9lMtVrE5CFgyjKv7mYksI6K1OY32dj7+ohgC4xmA==
X-ME-Sender: <xms:sWtwZR0WFeEzq5-JHRSnikHuFV12LILP7Gv7VrloBeS4VUB9KQv3pQ>
    <xme:sWtwZYGUiphch7XPjwAnsDPrNQzkq3DF2dqMll4eJ8vFzt-anl4JFawiPex9XS5rY
    XDvcvjXQ0diNCXWXw>
X-ME-Received: <xmr:sWtwZR55uTA_gCNKNy4ms30ea9dTX_0JjvxDe2i5bcRoWcUYH9Sx080wwI9eBFKnobwYWe_Gb9fxyXxI-eWM5Xj2bN7q9uUsF6Myw9byaIe4rk8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sWtwZe3xVFIr0PAabts0DfqfsIRnOHtmX650Qq4hdPojOIdMfpbFGw>
    <xmx:sWtwZUG0RSh5Gy-D2qac9ODicWjKgXqr_4cwSzojHc5l4lqKtUWddg>
    <xmx:sWtwZf_BctCHGuVs1M3cvckWaHewxyM3PjVuaIsoenniEWQJv89DCg>
    <xmx:sWtwZXx2gsHeWPAzumbx3BK4b8fxTNocUhsXkntBnCTt9y_YAWcE3g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:40:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 482bd64b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:51 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:40:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] builtin/clone: create the refdb with the correct object
 format
Message-ID: <eb5530e6a8760c5023340766c0103f1a7a2ebf3b.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aQue9KY4UXezgYAY"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--aQue9KY4UXezgYAY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're currently creating the reference database with a potentially
incorrect object format when the remote repository's object format is
different from the local default object format. This works just fine for
now because the files backend never records the object format anywhere.
But this logic will fail with any new reference backend that encodes
this information in some form either on-disk or in-memory.

The preceding commits have reshuffled code in git-clone(1) so that there
is no code path that will access the reference database before we have
detected the remote's object format. With these refactorings we can now
defer initialization of the reference database until after we have
learned the remote's object format and thus initialize it with the
correct format from the get-go.

These refactorings are required to make git-clone(1) work with the
upcoming reftable backend when cloning repositories with the SHA256
object format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 9 ++++++++-
 setup.c         | 2 +-
 setup.h         | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 06966c5d4c..fd052b8b54 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1097,8 +1097,14 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
+	/*
+	 * Initialize the repository, but skip initializing the reference
+	 * database. We do not yet know about the object format of the
+	 * repository, and reference backends may persist that information into
+	 * their on-disk data structures.
+	 */
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
-		do_not_override_repo_unix_permissions, INIT_DB_QUIET);
+		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFD=
B);
=20
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1282,6 +1288,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	hash_algo =3D hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(hash_algo, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
+	create_reference_database(NULL, 1);
=20
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index a80fc09b9c..e1d0ce29c6 100644
--- a/setup.c
+++ b/setup.c
@@ -1897,7 +1897,7 @@ static int is_reinit(void)
 	return ret;
 }
=20
-static void create_reference_database(const char *initial_branch, int quie=
t)
+void create_reference_database(const char *initial_branch, int quiet)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	int reinit =3D is_reinit();
diff --git a/setup.h b/setup.h
index cbf538286b..3f0f17c351 100644
--- a/setup.h
+++ b/setup.h
@@ -178,6 +178,7 @@ int init_db(const char *git_dir, const char *real_git_d=
ir,
 	    const char *initial_branch, int init_shared_repository,
 	    unsigned int flags);
 void initialize_repository_version(int hash_algo, int reinit);
+void create_reference_database(const char *initial_branch, int quiet);
=20
 /*
  * NOTE NOTE NOTE!!
--=20
2.43.0


--aQue9KY4UXezgYAY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa64ACgkQVbJhu7ck
PpTkUQ/+KCHyPz4755BcMBQVv3EJj9drM3EAIMfdLRTZsXvlzRj9+E/+5cililfn
Ubc8uEz+CsEnSOTq00/vsCQXweQtO8WgQswFSZJoCxOmH9EBSsLRSLKBgptcukzH
KauVE/1NRSpX/0mW1uoow0kZq258sZuCFV561/+/kg+gRhPZC+2frEwyl+bUt6KD
iepZ6WehInqcSbyXd+K4IE6aos7ePSukynWh4DJwojdeHgNsfH49DU8+9U745sap
BYKvEgQg+dlcTyX5qHK67eLxx2KappWkpXOPy6wPOH/mCBG3cbTmTJUU+3jnIM7C
koSq+dwxXRTLFxOxp+WhhT81dcfZfORLQX58ENTKQG4pkFIteaj52Oj4g1EyS2wq
4lqqGqcKQlFRU7yImwmnHEK9jSWcWMfaqc11zBKFBO0+MHgkdNXck7ZfVxreTFOw
2RLQ80QwpiCQNZjpXc7JkCVb/L9+OdoLB6z1rdr+AE5Wa5bGAS+AV828jT+LJ78k
VnmVFcrWqG07qpSSkYzHdd/dvX6Byi3IeAOgPuWKpuLZBh7dDsGehHHEw3gYqEiU
1UjHf9rdJixW/M2WLNfZJlAqa27bRvRkIlpYCEjAVvFGa5BK8gH3836nNsiipGsL
50DurgqPRsRZH/dwQ9If31uPE2D1XD/Wux/a4X1frNNeuYDEDEs=
=9epu
-----END PGP SIGNATURE-----

--aQue9KY4UXezgYAY--
