Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD730B658
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bm5YRR7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u/vA47KO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E03B75C0179;
	Fri, 29 Dec 2023 02:26:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Dec 2023 02:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834814; x=1703921214; bh=aK4mQ/wIXH
	2viYpfA0nIPcVXr9gdmn9q8h/Df5ViYU4=; b=Bm5YRR7M6/OmPmSwTKUSJNO4Y4
	dATeAWasGbn9zS8pMsGK/FdV13Zi3rhGXAsakxb/sL78EU9ThiNu0XpToU7yeWcM
	rFzX0bIbFvkoE4MVnrz7rEBOlvSGlzi+NHgM8ZyRNq0xkNjWaVUj3w7aD/a7Pnar
	FKinUp8BdNRY1F+G0bcKd4NwoOT6ArwG5/qw1NhYlsdlFfjT9bTj3lY2eNqHoNsu
	11UUj83mSLjuNN70StB8dOZ82SbY6k5GgUl8B0DaPsHJRE9eyFXVrNmBjZ5w8V8B
	2CmLC5Gfy9Je/y909op4EtuNMO2MbFitk67rZE8YKMRMWb+01gIwJjqvSrjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834814; x=1703921214; bh=aK4mQ/wIXH2viYpfA0nIPcVXr9gd
	mn9q8h/Df5ViYU4=; b=u/vA47KOkCod1Xzh5ZDjCAXWJ8Hzjqc7s8bnvxzqEPC2
	vEtB5AHmUDLxqPJDgnl46haaTO30iACMOPfdIN2FZn6cFXDPukKdT1EtyyHrULLx
	0gWuwHS1Xq1JevP1sDU2Sin/grSbWTMhDTtQQ9w3+354/aOQXRhnRM1N5olmvJrh
	mxqGIy3D2n0BVI8uPQPLVQm/cc22+jOmtl15xtO7jWrQm8p84pq3bs8JwRehl/At
	pc4yDuiDK4+PweWFU1qHRLnVZ/htd5DgXUfrxqVofvCbegRNr8GVQBJvrkbzE35/
	GwY4z1kaMqaP0i0YyEmBjWgWkLODFL8l7agT9QAwAQ==
X-ME-Sender: <xms:vnSOZfADdkKlWBmHvYX8Q6LuPszxWpXVCjRbfX_HclAP5tPGOVd5UA>
    <xme:vnSOZVhp_1xODfxMZTujiixmgWHKO4whlJhQVDkqW_pl5m1TcYqbRixd8vZgIWIv3
    bZ8df4vOQwHfnX65Q>
X-ME-Received: <xmr:vnSOZalC5XU26WRnU4ZULIawwPs58EfTWnC-XzIh0VgNTo8hX0OmambscCMWI4Ouj0Gycjhx9ZT1Kcm33ZuD2LZT7wV48jl_CwkjavfLrGz76GG0sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:vnSOZRykMHM9PU9dfuz4V8DpasKGuKsJHPtMotxDGG6imFRymdX4Iw>
    <xmx:vnSOZUTMOo2sZ8-H5w8qYK79Tp18B1LBMAdYwDKn9LlRmcY0MF-Byg>
    <xmx:vnSOZUatJL0VPt7aSl6zIaTXut9YINLD6KaZEmFL7-9QoPd-zZsd-g>
    <xmx:vnSOZfedETjyWdcNNVsgOHCC6u8c784vYV5EFzIeyNzHv18xTq9T9Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1aa22eef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:38 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/12] setup: introduce GIT_DEFAULT_REF_FORMAT envvar
Message-ID: <5ffc70e9be3cd3a4d6300dc0497c5cc0f12c0967.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6M1vFtWLNYeJ4YL"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--c6M1vFtWLNYeJ4YL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new GIT_DEFAULT_REF_FORMAT environment variable that lets
users control the default ref format used by both git-init(1) and
git-clone(1). This is modeled after GIT_DEFAULT_OBJECT_FORMAT, which
does the same thing for the repository's object format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt |  5 +++++
 setup.c               |  7 +++++++
 t/t0001-init.sh       | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index bf9e6af695..88e4ed4bd6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -556,6 +556,11 @@ double-quotes and respecting backslash escapes. E.g., =
the value
 	is always used. The default is "sha1".
 	See `--object-format` in linkgit:git-init[1].
=20
+`GIT_DEFAULT_REF_FORMAT`::
+	If this variable is set, the default reference backend format for new
+	repositories will be set to this value. The default is "files".
+	See `--ref-format` in linkgit:git-init[1].
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/setup.c b/setup.c
index fb1413cabd..1ab1a66bcb 100644
--- a/setup.c
+++ b/setup.c
@@ -2164,12 +2164,19 @@ static void validate_hash_algorithm(struct reposito=
ry_format *repo_fmt, int hash
 static void validate_ref_storage_format(struct repository_format *repo_fmt,
 					unsigned int format)
 {
+	const char *name =3D getenv("GIT_DEFAULT_REF_FORMAT");
+
 	if (repo_fmt->version >=3D 0 &&
 	    format !=3D REF_STORAGE_FORMAT_UNKNOWN &&
 	    format !=3D repo_fmt->ref_storage_format) {
 		die(_("attempt to reinitialize repository with different reference stora=
ge format"));
 	} else if (format !=3D REF_STORAGE_FORMAT_UNKNOWN) {
 		repo_fmt->ref_storage_format =3D format;
+	} else if (name) {
+		format =3D ref_storage_format_by_name(name);
+		if (format =3D=3D REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), name);
+		repo_fmt->ref_storage_format =3D format;
 	}
 }
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 38b3e4c39e..30ce752cc1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -558,6 +558,24 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.re=
fStorage with unknown back
 	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ=
}" err
 '
=20
+test_expect_success DEFAULT_REPO_FORMAT 'init with GIT_DEFAULT_REF_FORMAT=
=3Dfiles' '
+	test_when_finished "rm -rf refformat" &&
+	GIT_DEFAULT_REF_FORMAT=3Dfiles git init refformat &&
+	echo 0 >expect &&
+	git -C refformat config core.repositoryformatversion >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C refformat config extensions.refstorage
+'
+
+test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=3Dgarbage' '
+	test_when_finished "rm -rf refformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail env GIT_DEFAULT_REF_FORMAT=3Dgarbage git init refformat 2>=
err &&
+	test_cmp expect err
+'
+
 test_expect_success MINGW 'core.hidedotfiles =3D false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&
--=20
2.43.GIT


--c6M1vFtWLNYeJ4YL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdLsACgkQVbJhu7ck
PpTN0A//bvRGX4Lhkc8VuZan2Nrip7KqaGctGT8mdeJtNAYntTjRgBCAFMt90nzn
6LOLfS7L7nUKYyy3qZXm5J3dSIpg6zvz7CVbgnk+kUwwxnhfQL+00kyY71AXBE8V
+x41mvanDnZYqLha34jnpHizFp/mgxMP8Sa3lKukzUxMvix9eqhIN9S4zi+PggW6
45K6vST4J84LYLCvMW4Lw2UVHg6QSI0FjaJ1SWL/M6cVZJoVonhVmT2eepnX2Q78
7Lg3J/nxYvg7z0novtuplKLv+BuRTG0ZxcFjhMRy+FHgD4ZF2cN+2aYWjUTPFLBi
bhnMwr6JCcCNaGhrjaYRxB1HWHO0TIR6hIWjLJdrOQlmcn5FBPGaG19DCs31yuYF
oOPT8RI162xQIVSlTrpfWS3y62qAed2T3A2CbBd4aeFaU5ehaLC246WqDo4797K8
jpew47wIk3cmEY7s3LFAF0MSw4s50WghHRFJwv2xc/gp6lp3oHpp+ycqnY8ZRBND
O+fvXJZC9jPUDQKTNMIJ5T4gQc468CUR+lUvUrHZQGTUk6WxaQzq8MLJ9DEWFeV5
3bfv4+5g1bx7Yo/9YJDeXa1+MYMJ8mGRaJ2OXHJzyIZPvW41pXJ0ZwAYsH2LX3WC
/miVgVYWMaji+wDn7xB9HJHwoNCNF/QOTkK3f/4IIsli/a0g0Bc=
=joaY
-----END PGP SIGNATURE-----

--c6M1vFtWLNYeJ4YL--
