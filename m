Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353BBE49
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rpXIDRiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJOdwCNb"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F2102
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 891733200B2A;
	Wed, 18 Oct 2023 01:35:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 18 Oct 2023 01:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607323; x=1697693723; bh=4h
	V1g1aNgStGJuJ8XIHnhw1/XGrGF0EMBq/6t0w+pvE=; b=rpXIDRiTqLRiovfDf8
	Iw2ApGT/7KbB4mHw0JEA1qDY2fR9E5tBw7n4JJXpBaz1BaGYuhyY8HS8uAQBBVIZ
	uXaEAjC3ivJX4b0hfMThXU1pjfKPvYyBe8YWe9W6Q95MmNY/VDSFXJsHQmRfVMTa
	3VfyFmh9qbwBBvYyEbenrkkIUTvAKCkAdAQt0PlMrDqoAMIFAcz1dULNESgDa2yN
	nxNLKno2Wx+ZXGHc67ksdpD9xC/r9L9sjnPdPde47D8ioQ5LpkMIG5oORiK5Mv9i
	Uylm8IRSTZMdh87ts3PWyu4G8YxxIHL/J0P9UPD/jvfzQj8kJo/RCx1CQHs/YZhD
	BvyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607323; x=1697693723; bh=4hV1g1aNgStGJ
	uJ8XIHnhw1/XGrGF0EMBq/6t0w+pvE=; b=DJOdwCNbX5Zk9ixeqqLO6VHnb8dTv
	sIvufuqbG/qbd1fM0vBTZ3Wjz4WhPhOwTJdN8GQm4cdLC9EJZpx/YStqkAFz4gr3
	mZUiXjXeopLe1UEPacU5T26uSZS7swrJf2DTAkNXK+glTOyw6h/QtTEo0LHlu6nM
	QCZzhgdhcg42DuG9HsJO/BV6Polc+e0R4xmErRQXoOx2aYPQtGPcUQ/+ZNl6XcBM
	WxXr+i32c3g18zUid6SswRXx+e0ztmWcibUwt/PkEXng3g49uXoFsqgLVvNr9zl5
	bDEGmBC2ovVfbfo6JA+gyxAPQ81Sz0t82e5z7WqpWMiYd4eiSKxNTMslg==
X-ME-Sender: <xms:mm4vZebdFJXVQtK-g2z4TSyoBFzFPj2mKHHTCtSdjjQRdx_Y2H-aWQ>
    <xme:mm4vZRY7PYVutTs14DsnEo92ln3HykcldHBAY0r32mEpYmW9EHUKWPQ_AAPk2pMDv
    co2zVuxPljBx2UqSg>
X-ME-Received: <xmr:mm4vZY9E0EFai5ZVXbv5Y1qFyKOOZndcXx7K4lJwNd23T87_jZhIwfw3K8FtHFq-3kxR4WGMqNuvDnvUi9V5paiix6iOIYr9mwCAM0kkAEr96iVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mm4vZQoX_Z1beRodUbHYrI1VLl0vrrNIWp_TxbDSn-hLkhP2thJSSw>
    <xmx:mm4vZZqP8cz4c8ZfPmXQaH8CyZ8j9xpLV1qISGSHjII26cRuAUJ25Q>
    <xmx:mm4vZeQcvbgA7K6C0LRy81FgFettCb4ufN35px2WXYPbLylBuBOZuA>
    <xmx:m24vZYTEZbh55IqQaQdeQGlHGN8BgY5AFp-PNx53yyLpnHW5nQSJZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8f23a4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:21 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 04/11] t: convert tests to not write references via the
 filesystem
Message-ID: <c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SlQUnhtFAm0UjB/x"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--SlQUnhtFAm0UjB/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our tests manually create, update or delete references by
writing the respective new values into the filesystem directly. While
this works with the current files reference backend, this will break
once we have a second reference backend implementation in our codebase.

Refactor these tests to instead use git-update-ref(1) or our `ref-store`
test tool. The latter is required in some cases where safety checks of
git-update-ref(1) would otherwise reject a reference update.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh         | 16 +++++++---------
 t/t1450-fsck.sh               | 28 +++++++++++++++-------------
 t/t3404-rebase-interactive.sh |  2 +-
 t/t5526-fetch-submodules.sh   |  2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4d66cd7f4a1..cd24018ce99 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -9,8 +9,6 @@ test_description=3D'Test git update-ref and basic ref loggi=
ng'
 Z=3D$ZERO_OID
=20
 m=3Drefs/heads/main
-n_dir=3Drefs/heads/gu
-n=3D$n_dir/fixes
 outside=3Drefs/foo
 bare=3Dbare-repo
=20
@@ -62,10 +60,10 @@ test_expect_success "delete $m without oldvalue verific=
ation" '
 	test_must_fail git show-ref --verify -q $m
 '
=20
-test_expect_success "fail to create $n" '
-	test_when_finished "rm -f .git/$n_dir" &&
-	touch .git/$n_dir &&
-	test_must_fail git update-ref $n $A
+test_expect_success "fail to create $n due to file/directory conflict" '
+	test_when_finished "git update-ref -d refs/heads/gu" &&
+	git update-ref refs/heads/gu $A &&
+	test_must_fail git update-ref refs/heads/gu/fixes $A
 '
=20
 test_expect_success "create $m (by HEAD)" '
@@ -222,7 +220,7 @@ test_expect_success 'delete symref without dereference =
when the referred ref is
=20
 test_expect_success 'update-ref -d is not confused by self-reference' '
 	git symbolic-ref refs/heads/self refs/heads/self &&
-	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
 	test_path_is_file .git/refs/heads/self &&
 	test_must_fail git update-ref -d refs/heads/self &&
 	test_path_is_file .git/refs/heads/self
@@ -230,7 +228,7 @@ test_expect_success 'update-ref -d is not confused by s=
elf-reference' '
=20
 test_expect_success 'update-ref --no-deref -d can delete self-reference' '
 	git symbolic-ref refs/heads/self refs/heads/self &&
-	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
 	test_path_is_file .git/refs/heads/self &&
 	git update-ref --no-deref -d refs/heads/self &&
 	test_must_fail git show-ref --verify -q refs/heads/self
@@ -434,7 +432,7 @@ test_expect_success 'Query "main@{2005-05-28}" (past en=
d of history)' '
 	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
 '
=20
-rm -f .git/$m .git/logs/$m expect
+git update-ref -d $m
=20
 test_expect_success 'creating initial files' '
 	test_when_finished rm -f M &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 10a539158c4..5cce24f1006 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -115,15 +115,16 @@ test_expect_success 'zlib corrupt loose object output=
 ' '
 '
=20
 test_expect_success 'branch pointing to non-commit' '
-	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
+	tree_oid=3D$(git rev-parse --verify HEAD^{tree}) &&
+	test-tool ref-store main update-ref msg refs/heads/invalid $tree_oid $ZER=
O_OID REF_SKIP_OID_VERIFICATION &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	test_must_fail git fsck 2>out &&
 	test_i18ngrep "not a commit" out
 '
=20
 test_expect_success 'HEAD link pointing at a funny object' '
-	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
-	mv .git/HEAD .git/SAVED_HEAD &&
+	saved_head=3D$(git rev-parse --verify HEAD) &&
+	test_when_finished "git update-ref HEAD ${saved_head}" &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
@@ -131,8 +132,8 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct' '
 '
=20
 test_expect_success 'HEAD link pointing at a funny place' '
-	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
-	mv .git/HEAD .git/SAVED_HEAD &&
+	saved_head=3D$(git rev-parse --verify HEAD) &&
+	test_when_finished "git update-ref --no-deref HEAD ${saved_head}" &&
 	echo "ref: refs/funny/place" >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
@@ -140,10 +141,10 @@ test_expect_success 'HEAD link pointing at a funny pl=
ace' '
 '
=20
 test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
-	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	saved_head=3D$(git rev-parse --verify HEAD) &&
+	test_when_finished "git update-ref HEAD $saved_head" &&
 	test_when_finished "rm -rf .git/worktrees wt" &&
 	git worktree add wt &&
-	mv .git/HEAD .git/SAVED_HEAD &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail git -C wt fsck 2>out &&
@@ -161,7 +162,8 @@ test_expect_success 'other worktree HEAD link pointing =
at a funny object' '
 test_expect_success 'other worktree HEAD link pointing at missing object' '
 	test_when_finished "rm -rf .git/worktrees other" &&
 	git worktree add other &&
-	echo "Contents missing from repo" | git hash-object --stdin >.git/worktre=
es/other/HEAD &&
+	object_id=3D$(echo "Contents missing from repo" | git hash-object --stdin=
) &&
+	test-tool -C other ref-store main update-ref msg HEAD $object_id "" REF_N=
O_DEREF,REF_SKIP_OID_VERIFICATION &&
 	test_must_fail git fsck 2>out &&
 	test_i18ngrep "worktrees/other/HEAD: invalid sha1 pointer" out
 '
@@ -391,7 +393,7 @@ test_expect_success 'tag pointing to nonexistent' '
=20
 	tag=3D$(git hash-object -t tag -w --stdin <invalid-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/invalid &&
+	git update-ref refs/tags/invalid $tag &&
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
 	test_i18ngrep "broken link" out
@@ -411,7 +413,7 @@ test_expect_success 'tag pointing to something else tha=
n its type' '
=20
 	tag=3D$(git hash-object -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags
 '
@@ -428,7 +430,7 @@ test_expect_success 'tag with incorrect tag name & miss=
ing tagger' '
=20
 	tag=3D$(git hash-object --literally -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	git fsck --tags 2>out &&
=20
@@ -452,7 +454,7 @@ test_expect_success 'tag with bad tagger' '
=20
 	tag=3D$(git hash-object --literally -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	test_i18ngrep "error in tag .*: invalid author/committer" out
@@ -471,7 +473,7 @@ test_expect_success 'tag with NUL in header' '
=20
 	tag=3D$(git hash-object --literally -t tag -w --stdin <tag-NUL-header) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	test_i18ngrep "error in tag $tag.*unterminated header: NUL at offset" out
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8ea2bf13026..d2a7a91f170 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2160,7 +2160,7 @@ test_expect_success '--update-refs: check failed ref =
update' '
 	# recorded in the update-refs file. We will force-update the
 	# "second" ref, but "git branch -f" will not work because of
 	# the lock in the update-refs file.
-	git rev-parse third >.git/refs/heads/second &&
+	git update-ref refs/heads/second third &&
=20
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 26e933f93ae..7ab220fa313 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a broken r=
epository' '
 	git -C dst fetch --recurse-submodules &&
=20
 	# Break the receiving submodule
-	rm -f dst/sub/.git/HEAD &&
+	test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF msg HEAD &&
=20
 	# NOTE: without the fix the following tests will recurse forever!
 	# They should terminate with an error.
--=20
2.42.0


--SlQUnhtFAm0UjB/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbpcACgkQVbJhu7ck
PpSetxAAqTMLrRmyd7fEBKVCA4be9/EjiBmGtC3m7qeHgp7xRWKlAwosXJcJeGo9
pxsqfiTxtL3tYxlM+XDwKewBSSuXETZIF9UqdJ9q/K54U59PVCATlcdLpd/aWqk8
hTETqkYck4jyi19S2jiYmEPFoT47r9oq5LAMoMZ/Q8MtOJN3ONy/wHcjVKAYQef1
mHRO8DWFpPSWzaBZCpVmiDiPA/vw9g7BfUps7q9f+BPRVAOa+8Vwx3icDJarwf3g
YPV8UUJrr1S45/phtIsDG9caEg906LnCvbaobyndMJNkmI0wqV7V09Isp/xddUK0
9ASliQprzkXcauD7vlnWpwwt85bKPJ/JVtLiwx8MD+AyQAIzwBx0Fw4vKDtD267v
Kuvv/wQsLr8rhsaH9/qNu97QBFL5TPNKqAFbeCYJJ9E6+0HmasW7uoggcJ2h/3Ms
9hbxVxH3D1Rq3F8x30Rm6nT2+NZNTT00g5g3PVSRIMQ95zVI5WvlNHcjPYVG+wjG
Z19dNmt9zyufCEbYaKjH3hkwJkfAnNRYk6SEQZF/j8jpJyLFd1Fhfqjx1EXrXrAG
sXaCljSyqqMGzXhRFn5Fjt5x8qvqNRCyU2NLNfssQ+XB5IlhK2cU3XqnfVH2z+Mf
+vAq7j4WJlL2GJrJ5OvmH8QpRNBniuhZfP5Z81EQOa6QIpEnaMw=
=80Tz
-----END PGP SIGNATURE-----

--SlQUnhtFAm0UjB/x--
