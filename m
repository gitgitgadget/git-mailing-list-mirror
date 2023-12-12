Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CHt9r275";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aOQyzKo9"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7CD0
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:01:11 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 11A023200A9F
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:01:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Dec 2023 02:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364470; x=1702450870; bh=bOT+z6R8k/
	5v7YfXC2EnggLRhGaxzZB33nYv8RPQaG0=; b=CHt9r275PpJPhf11SEn6HXLCPE
	O0Jo9a9Bq5lUsLX+jYSjdFYeKKkH5T5MTPSaU3adrReyI6V/ZvUfOFExoDYuS3vA
	h+KEXxW7H5mBcA4/EaBfP2a0MChSGsgYdXrdsuppxUUkQw2MDu1MvjSm2iaZ13MU
	lpH/R0Xp2m/aCL8zu6vOloqn4WeBoq/ap0D4jH+szVCLCz828UJ+A+Oc1nDf/LjA
	Z9BYLAZGMf+eDTi8Yt5TT8Mq8fjU1Bo+UXQpDJFSfQwUjqJhGI7JRKdy6s9q8KEF
	MGz7U5gm30U8YUd5sRZbQdjCrmONwKt5yc6hErYqJftKAtjBTudxIqrCQkNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364470; x=1702450870; bh=bOT+z6R8k/5v7YfXC2EnggLRhGax
	zZB33nYv8RPQaG0=; b=aOQyzKo9H5Mc2Cpfd5SF4/dHnzzh72mhP++UmYmMqnTE
	UQUOlSn0OnWP2n76T8ZFwyfT25CDFVijQgiBleSTyx6jGyB2b5vxXUewQIDl32pi
	Xi3Fx+TWa2H5X2IUKSXNrDlnNICoj81RTEwFMJVkz523DpLYx9CR8NHEchcQanFO
	S3PbSxY+hi+umPeTd78khOwTYRcP59rFwTlgxvS7UqnaQOh/2v9FbrULaVOL8IHd
	utSDuxsHM3UnxKOZ+Scha5gqn4w0dD2N3UCtactQAjQ2YrLC0NVmEx/1OVjoZ8lN
	y9FMLtN1WuQR+IfXOERe+7ez+v3RGUM/luTE9OIpjA==
X-ME-Sender: <xms:NgV4ZXYetVpPWq45aWqiJQVPevCjxIs1QeyBN_yGriK-YB2a8nbn_A>
    <xme:NgV4ZWYYOgm0BUXJdWCai3y5npJj-473iZywIbl3iT2vC2AlX5yOyj4mWf1mJJ_M4
    qNFLyA4G-ynLKxisw>
X-ME-Received: <xmr:NgV4ZZ9fEAmHH4BrgKgfLLzlrh_k1t_j5k4-ZaOCJ-obEMwm3NSSxeX936vHHdYJeJOuQFl9s8-W-0H4qdlOmQqgx-9RRezQvXD9Y-Un7Q0YYHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvhfekhfetgffgfeejfeetffetieevtd
    etfeeiteetjeeljeekudegtefgtedvgfenucffohhmrghinhephhhtthhpqdhfvghttghh
    qdguuhhmsgdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NgV4Zdr8WN_OwzBpjbKL2AHwh9BFmhw_GCoBbWEodipS08w6dXoUWQ>
    <xmx:NgV4ZSpJS20v7rOP-jsUWU8_Suv6-7MX0N0Ya20Kky_-pubF3MEtNQ>
    <xmx:NgV4ZTR_aIy9pDez0idDRPj6mh4I_hjN9w96mo0ulQw2Bhi-zr-FIQ>
    <xmx:NgV4ZQGyJpayfVnZHtgQnPl4AsLoUXAuhbPepRNBBKWgnBQGsbPQuQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:01:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7aedc92c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:31 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:01:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 7/7] builtin/clone: create the refdb with the correct
 object format
Message-ID: <f062b11550a559fb0c96ef0fa188110f6116e3c6.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fsUzyuzVlamY7YiF"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--fsUzyuzVlamY7YiF
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

This change breaks a test in "t5550-http-fetch-dumb.sh" when cloning an
empty repository with `GIT_TEST_DEFAULT_HASH=3Dsha256`. The test expects
the resulting hash format of the empty cloned repository to match the
default hash, but now we always end up with a sha1 repository. The
problem is that for dumb HTTP fetches, we have no easy way to figure out
the remote's hash function except for deriving it based on the hash
length of refs in `info/refs`. But as the remote repository is empty we
cannot rely on this detection mechanism.

Before the change in this commit we already initialized the repository
with the default hash function and then left it as-is. With this patch
we always use the hash function detected via the remote, where we fall
back to "sha1" in case we cannot detect it.

Neither the old nor the new behaviour are correct as we second-guess the
remote hash function in both cases. But given that this is a rather
unlikely edge case (we use the dumb HTTP protocol, the remote repository
uses SHA256 and the remote repository is empty), let's simply adapt the
test to assert the new behaviour. If we want to properly address this
edge case in the future we will have to extend the dumb HTTP protocol so
that we can properly detect the hash function for empty repositories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 9 ++++++++-
 setup.c                    | 2 +-
 setup.h                    | 1 +
 t/t5550-http-fetch-dumb.sh | 4 ++--
 4 files changed, 12 insertions(+), 4 deletions(-)

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
index d6a1c59b7b..155fe13f70 100644
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
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index e444b30bf6..4c3b32785d 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -66,11 +66,11 @@ test_expect_success 'create empty remote repository' '
 	setup_post_update_server_info_hook "$HTTPD_DOCUMENT_ROOT_PATH/empty.git"
 '
=20
-test_expect_success 'empty dumb HTTP repository has default hash algorithm=
' '
+test_expect_success 'empty dumb HTTP repository falls back to SHA1' '
 	test_when_finished "rm -fr clone-empty" &&
 	git clone $HTTPD_URL/dumb/empty.git clone-empty &&
 	git -C clone-empty rev-parse --show-object-format >empty-format &&
-	test "$(cat empty-format)" =3D "$(test_oid algo)"
+	test "$(cat empty-format)" =3D sha1
 '
=20
 setup_askpass_helper
--=20
2.43.GIT


--fsUzyuzVlamY7YiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BTIACgkQVbJhu7ck
PpT5WA/+J3Zl6/kZDUPqk3kuDuUw4goUNHwy6wVcE+WZOmKGAMWIVOHtw19iUl1q
cluE0x5ZsTsPn906PnEQB8tFveq85Q1P0YETDQ06kGaacMRuIkFurrQ03ERtX89M
I+a6w1M6nrdz8Bp7z1JkQN5sLlZFBePvXWOsRBNz3CmFj9j9FhsJci7ekT4b6mR0
2h4r2dnCIqKEfksv/GL+ZLMr/WZF2n+xg5dsXDD5sPbMCPWKN+NdLjz+g2C3Avhc
wPomsYPOemyz2P5HxjWASKl6FFnTteCp2urDEqVyuSouRqsOWaI5tHEaXoDn//aK
Uz1kHWaDyUYl3gELpP0g1C+/4Sj88qKO6qaRgaiaod+HYZQgkUvVsk5SYNHZngdG
/Ss/crdhhnwLb4zPIWm81nApC0Wsp2hGC1ebpRuLBg8AMmrE3YSirtTWBgUCOd/t
dnD6N0GH3dL5OIr8FYWsFS1/i2lHwzjpPVHzc+vBxy6x327s0dbYzyzKJ6TPO1bg
Cgszg7hkvV7h1r9TPqhD22x1gRrEt2OOZy4Bh0ObQdJTjMC5ll7A2sbeImrIo7XQ
X7cHXTwluxBHuneHmUnb1na93wbf/isAz2B3wZwLVy6mvDDZHUfmMf++02aE3Ei2
hfqaIqxJI6QJes4/ziTlY1jFyKbYpVkUEtC3nm4JnkqqN8y9t2s=
=MR1a
-----END PGP SIGNATURE-----

--fsUzyuzVlamY7YiF--
