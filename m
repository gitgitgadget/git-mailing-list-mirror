Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CE746A
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sxC1Ifki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GL5P7AmC"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05712D
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:46:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 5FCC132009C9;
	Thu,  2 Nov 2023 04:46:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Nov 2023 04:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914808; x=1699001208; bh=lK
	g2yZKUim7JpqSldd4p0FoS7okqDg0fR10hD4Xd7bs=; b=sxC1Ifki9iu0QrHSgJ
	ZIVuFT6H0J8Fj+1eCdPdUGMkDT4kHrSQ/gZPimunO+seDBLiIoUDm8djSSdvZ1EI
	VCp0nSKDNeak1yVUo+j4PgU7qw7ZGMFXzqRBWJXZqE5wtHsBSEmOT2hfWKcfVSHW
	yF0QzriDUeLifERiWjBG4xTnTorh1cpQoL+YUMc4oH3X80XcWo5ALJNS3j7CtDXF
	D8mZGAXFdQW8VThwufPNprhhbS/xUKqPbZx8TOJyKBm5ekV5luTWMlJ9d41lO/HQ
	Ow17xkxq+UHx7vu/pH+bmpbo6ggejpTO+meb01A3VKTGTUtokoDp5CUR5T+mb5/U
	3xzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914808; x=1699001208; bh=lKg2yZKUim7Jp
	qSldd4p0FoS7okqDg0fR10hD4Xd7bs=; b=GL5P7AmCz7E01mhomKwNLdh6DV3ry
	P9dU4mXLkM1xmVA4Hl2iTYEMwdqXAdbWdZP1gKYouF74y0fCd8jc9Jby6VIbmSDq
	y9Y/ETW5wpWkSpWmuDs2+jadAFkAg/zdRTknC1EnKT24LtsVnQG/2IZPu2DbZl9J
	st5H1CT9FSSEyAIRmMBByBq3btbj+15nX1MtmTpwsGbcHf0V82Prv3dFCK4oislh
	js31sMK038vca1Br252GXKn4U49zZgF2m1ZjkF4VYUO6dLUSt6Y8AujDCw6rW5SM
	/1NOqeOPxoU8TvMdOlkFe3HY5ut1t6Uh1+2Op283jpPrGmidlsEeMVWDw==
X-ME-Sender: <xms:-GFDZcjNwAYkhAjuObDuAER7K9uh2_XukNv8HVexzlDXM61B5iwHng>
    <xme:-GFDZVBqT4U7CJeyqtW6OKAI_ubiKB-Nh0JTW1Ni5xaG8MZBUjOIxzSKEdw79rrMA
    Mz91L6Pxpl-JHixOg>
X-ME-Received: <xmr:-GFDZUF8dHWGXWukzhsoULaPNUi087pThwlYaAmvlyyvMQaqOO6xa5b92lhY0ACiqN9HWP5a9msQXRqkUaORUK4mmnBjE-JXl3dpag-79H6Iy1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:-GFDZdS5CtngGjbo-USG9gEnHEEuEzvrPC9iIWikTHe7OwJM8lYNaQ>
    <xmx:-GFDZZxbOXApZNWGeI9uWTZS16sCcPghcazhwLnCowYZDBE9kuJ7Fg>
    <xmx:-GFDZb7FcI08NzE2YxZO3VJ3tYQTpzMdwnisH7fCLFlpzXOMlVpA9Q>
    <xmx:-GFDZR_leMLdbPIB7XwZxjy_hd2ktKfIqOY2XdVhErDSd_IJvdUH0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:46:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d659484d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:35 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:46:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/9] t: convert tests to not write references via the
 filesystem
Message-ID: <1884b7006cf72404a69b05ccf4668d75497148a1.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IWo3ShDZN94spLBx"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--IWo3ShDZN94spLBx
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

While at it, refactor some of the tests to schedule the cleanup command
via `test_when_finished` before modifying the repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh         | 17 ++++++++---------
 t/t1450-fsck.sh               | 26 +++++++++++++-------------
 t/t3404-rebase-interactive.sh |  2 +-
 t/t5526-fetch-submodules.sh   |  2 +-
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4d66cd7f4a1..91cc6dff724 100755
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
@@ -221,16 +219,16 @@ test_expect_success 'delete symref without dereferenc=
e when the referred ref is
 '
=20
 test_expect_success 'update-ref -d is not confused by self-reference' '
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
 	git symbolic-ref refs/heads/self refs/heads/self &&
-	test_when_finished "rm -f .git/refs/heads/self" &&
 	test_path_is_file .git/refs/heads/self &&
 	test_must_fail git update-ref -d refs/heads/self &&
 	test_path_is_file .git/refs/heads/self
 '
=20
 test_expect_success 'update-ref --no-deref -d can delete self-reference' '
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF ref=
s/heads/self" &&
 	git symbolic-ref refs/heads/self refs/heads/self &&
-	test_when_finished "rm -f .git/refs/heads/self" &&
 	test_path_is_file .git/refs/heads/self &&
 	git update-ref --no-deref -d refs/heads/self &&
 	test_must_fail git show-ref --verify -q refs/heads/self
@@ -434,7 +432,8 @@ test_expect_success 'Query "main@{2005-05-28}" (past en=
d of history)' '
 	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
 '
=20
-rm -f .git/$m .git/logs/$m expect
+rm -f expect
+git update-ref -d $m
=20
 test_expect_success 'creating initial files' '
 	test_when_finished rm -f M &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 10a539158c4..f55b539b083 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -15,6 +15,7 @@ test_expect_success setup '
 	git config --unset i18n.commitencoding &&
 	git checkout HEAD^0 &&
 	test_commit B fileB two &&
+	orig_head=3D$(git rev-parse HEAD) &&
 	git tag -d A B &&
 	git reflog expire --expire=3Dnow --all
 '
@@ -115,15 +116,15 @@ test_expect_success 'zlib corrupt loose object output=
 ' '
 '
=20
 test_expect_success 'branch pointing to non-commit' '
-	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
+	tree_oid=3D$(git rev-parse --verify HEAD^{tree}) &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
+	test-tool ref-store main update-ref msg refs/heads/invalid $tree_oid $ZER=
O_OID REF_SKIP_OID_VERIFICATION &&
 	test_must_fail git fsck 2>out &&
 	test_i18ngrep "not a commit" out
 '
=20
 test_expect_success 'HEAD link pointing at a funny object' '
-	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
-	mv .git/HEAD .git/SAVED_HEAD &&
+	test_when_finished "git update-ref HEAD $orig_head" &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
@@ -131,8 +132,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct' '
 '
=20
 test_expect_success 'HEAD link pointing at a funny place' '
-	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
-	mv .git/HEAD .git/SAVED_HEAD &&
+	test_when_finished "git update-ref --no-deref HEAD $orig_head" &&
 	echo "ref: refs/funny/place" >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
@@ -140,10 +140,9 @@ test_expect_success 'HEAD link pointing at a funny pla=
ce' '
 '
=20
 test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
-	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	test_when_finished "git update-ref HEAD $orig_head" &&
 	test_when_finished "rm -rf .git/worktrees wt" &&
 	git worktree add wt &&
-	mv .git/HEAD .git/SAVED_HEAD &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail git -C wt fsck 2>out &&
@@ -161,7 +160,8 @@ test_expect_success 'other worktree HEAD link pointing =
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
@@ -391,7 +391,7 @@ test_expect_success 'tag pointing to nonexistent' '
=20
 	tag=3D$(git hash-object -t tag -w --stdin <invalid-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/invalid &&
+	git update-ref refs/tags/invalid $tag &&
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
 	test_i18ngrep "broken link" out
@@ -411,7 +411,7 @@ test_expect_success 'tag pointing to something else tha=
n its type' '
=20
 	tag=3D$(git hash-object -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags
 '
@@ -428,7 +428,7 @@ test_expect_success 'tag with incorrect tag name & miss=
ing tagger' '
=20
 	tag=3D$(git hash-object --literally -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	git fsck --tags 2>out &&
=20
@@ -452,7 +452,7 @@ test_expect_success 'tag with bad tagger' '
=20
 	tag=3D$(git hash-object --literally -t tag -w --stdin <wrong-tag) &&
 	test_when_finished "remove_object $tag" &&
-	echo $tag >.git/refs/tags/wrong &&
+	git update-ref refs/tags/wrong $tag &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	test_i18ngrep "error in tag .*: invalid author/committer" out
@@ -471,7 +471,7 @@ test_expect_success 'tag with NUL in header' '
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


--IWo3ShDZN94spLBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYfQACgkQVbJhu7ck
PpTinA/+PZbHNVbXA+YQ6tJDgfE/+KgC69zSV77Yx6pIGoyv956joFjVWPco+HAP
hE+hp6p+s/r6kdCk4+nnV7Wnt4/Vk1sUIS8P2aQZ07u8wBL/0zwYQUU9HzoMotiR
qKPpjBNUpY6a7IN2yKqMdu9RREBXDgvpDIg333wH/N1LciE5uoKtT/cqaJIg59h+
EEyDlU7aj29i96PB7UqkXea2P31c6yAA5nDFvbww3aAD5DR1aK+HiYeRrWAtSe8i
h2fjcSJe2yXdFsfDA2i8C7oJsjb7TiDRCVO9zk0MHGs9468gUUH1FIi6QK479Zem
txT7lrJhlEjcuxePmrlKREYsICrGIki8sNLmWHSJzI3mI2n+9vd4BUKhCFd7/Gqk
gYLUFh+wMYepY1dgVSMR23POs94YmIY1vCJkS9V71MO35GZK9KuNmVVn0Cuei8oh
/93hGNdyS2gKGw/v3JgRxgMpmSNYPNmgcCB7juL6rGPsvSvZZSynr5LRt75e9QAU
02a1faKv0+JZOqC6J7st+oDmHahjs7pSC/X8uozUbsXMZMZUgHEpr6ZzhGWvwmNW
0sTw+pH1kBDeXkPsEXd0YfnKLUOeHx9539mCM5gelYqHJlNr10DYKzx8MALkg6j2
48QkJe+SPPGRX6VTPEQbr7BqmERPg/0PXkSt4UOWL3ueKKD3aSw=
=9zN4
-----END PGP SIGNATURE-----

--IWo3ShDZN94spLBx--
