Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8863381CF
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H5JtFk0h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wDTQ1Ox/"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id EF0EC5C03B5
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 Jan 2024 07:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704802634; x=1704889034; bh=qfyA/TsoLl
	ZVPSGIW+TMv0/5tVIPVO9g5JoS9Ua/DSo=; b=H5JtFk0hjMR2T/+RlXnf7FKyWX
	JU+7Uzv6xQrwKLJLE+5ytmKLNoH7FEDdv4fafbF3wFEqDegYwOAghJyWIHBPX7OX
	1nG8MPYhUHIW1D/wXCHzOv5gx35NphlQFYWLPmbEggwVd9I3n5LVBNPDXvNNOOhJ
	7jNPjIvIulYw6yCKDizC7SOeJzxWzT+O2EKxYGT/p59DEPup5DBcm+WF5M5idil8
	LmgogVzy3SmQKVxDyOBY/kNjuklDswVy5ZQ9eRyFRezaj0qPSyLVi6Yb9LPYvru1
	TwldsDMJfEcqdF5rW4ZGi2mvdUBQgEww4kStrXvWQQc2+9cKwDhas/Os50aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704802634; x=1704889034; bh=qfyA/TsoLlZVPSGIW+TMv0/5tVIP
	VO9g5JoS9Ua/DSo=; b=wDTQ1Ox/x4eZSua2JUYevmSghY6qb016XdwyyvVwGpmQ
	lAjabwIDH22uyYrDDI5AHQD36F4wlw55xh/Q3hbC3/fNafvTJXhZUKxUD9coDhcJ
	DdikzQiDuqmBQ1ZQxSJ85KV+kie902kU+MqtiPH0ZyXBvImjl1Nq9/C5ueKD9k78
	Cik9Skw8q9BexVigNB55VYR93CcMLpEsK9eFY1uVZkptJIwx0L4R8UZDKaZ4YY1k
	iLZvQ7N251fi7yBO5Xd86Zwv+ChFZfj/xOkNOpv0P7D/un8DylKSCECAiNwb9RK2
	Y606L1vHHJddmiLAsTx1NDJpYoO5eKBbdxaThsUAGw==
X-ME-Sender: <xms:SjmdZQxvErDajIMaSsOCh66owaGNJp9Lm917wAAak35WGOKxILoKRQ>
    <xme:SjmdZUQspJby9mup41MIw99nP9OQ5IF8-9etdWO5o9BMU24hL9lqltfyoFErNm_rJ
    zeQ1ZcSG-fJvW6TVA>
X-ME-Received: <xmr:SjmdZSVJvGF2O2SbHI-5TGzy6Jy5M3ltrrSirr2_Rjwbn5K9bmbQDXlAzFd6qhgkajXjQ0D_uF-IejXyyegAktCKwRiNmCdOSj-9pWAWH-PT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SjmdZejO4Y_uACm7DDtDBVvJZOr0TcsMzTj-WDHEhQcbRxV5n1Tudg>
    <xmx:SjmdZSBNLU2FzDz2hnYx1lpQ_y1Nb6YuH1cf3yJsE2AEJni7sDEWiw>
    <xmx:SjmdZfIy--k37QshjuN8aAf8A4uiS4aS_SMpUkPHHk3ijMYEJMBMxQ>
    <xmx:SjmdZZ8jQHQO-IlZp7cw0GGa0tiZTSUW__xXnrQG_-UElbKofmrROg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 532e71e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:36 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/6] t1302: make tests more robust with new extensions
Message-ID: <9af1e418d47730f503dabb271d30c848bf74fa0b.1704802213.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dePPs/FRauplKo52"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--dePPs/FRauplKo52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1302 we exercise logic around "core.repositoryFormatVersion" and
extensions. These tests are not particularly robust against extensions
like the newly introduced "refStorage" extension.

Refactor the tests to be more robust:

  - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
    repository format version. This helps to ensure that we only need to
    update the prereq in a central place when new extensions are added.

  - Use a separate repository to rewrite ".git/config" to test
    combinations of the repository format version and extensions. This
    ensures that we don't break the main test repository.

  - Do not rewrite ".git/config" when exercising the "preciousObjects"
    extension.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1302-repo-version.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 179474fa65..fb30c87e1b 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -28,7 +28,12 @@ test_expect_success 'setup' '
 '
=20
 test_expect_success 'gitdir selection on normal repos' '
-	test_oid version >expect &&
+	if test_have_prereq DEFAULT_REPO_FORMAT
+	then
+		echo 0
+	else
+		echo 1
+	fi >expect &&
 	git config core.repositoryformatversion >actual &&
 	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
@@ -79,8 +84,13 @@ mkconfig () {
=20
 while read outcome version extensions; do
 	test_expect_success "$outcome version=3D$version $extensions" "
-		mkconfig $version $extensions >.git/config &&
-		check_${outcome}
+		test_when_finished 'rm -rf extensions' &&
+		git init extensions &&
+		(
+			cd extensions &&
+			mkconfig $version $extensions >.git/config &&
+			check_${outcome}
+		)
 	"
 done <<\EOF
 allow 0
@@ -94,7 +104,8 @@ allow 1 noop-v1
 EOF
=20
 test_expect_success 'precious-objects allowed' '
-	mkconfig 1 preciousObjects >.git/config &&
+	git config core.repositoryformatversion 1 &&
+	git config extensions.preciousObjects 1 &&
 	check_allow
 '
=20
--=20
2.43.GIT


--dePPs/FRauplKo52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOUcACgkQVbJhu7ck
PpTJjQ//TUG5vWtnI7YmLgOQrLiS5gZenRI8Vw4mUzDtBdN3Jdv1Ipo+AKyh616a
ZTIIq/zGAM/aTMLYfvj9Ae2TOVmPI/qtblzmUo0tHgBRBQsPXJh3/GQRvPUfeFp3
jSBO7JYl5eEs9kkNCODN8LcGKVV954H/ezt+07Bwyu2et8Ys59WGOywCOa5o/a7p
xFkkweqR4is//8Xq2d6Cv2QvwQDOEC4Q6fBFylQVdjAc+jJgV/m0LZ6uz+M9H3nk
Wp8R2M2u80z3CI8K46m2Xw0vT7tU+wOrF/REiykXFca7Gs1pS6bXzLJ8yFVzGb78
IPw6FGV/Da40zkZ5RNR2dFQxP5rn9gkIaPZ7JararUu92RqULg2EoXEckAAqKYEt
dnvtVITeyt1DWCzCx+l1hbZ9IGar7TwWbvV1Gur82Z45aLo8acdudT4a0+WyrAr4
FUMJK0QPkWa9IsZ0lgaLkbS7aTfj8gmmEq0MmmPpymGMUvMd6kL9dcXL8sveLFoV
f3z6HKxKeDJ2RPYJHQ49YftTCTz4PKdqnJqnMNpJZ1Ooy9uq5gsZYWNwIFqCmtEU
WaztVZ8x9xqcjXgzc/xurLTp9v4ZrA6ST3/9I+xtWZXHt8BNYmIxKVooCEwy2ZMb
5T/1g/fd9vD2HEcTU4CcpFcr3EiIV1T5CaoL0H5dRh3x/K/sSa0=
=saHN
-----END PGP SIGNATURE-----

--dePPs/FRauplKo52--
