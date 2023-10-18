Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC5FBEB
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KCShqQ4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/xOM46r"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B510C
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 2A15F3200B01;
	Wed, 18 Oct 2023 01:35:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 18 Oct 2023 01:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607331; x=1697693731; bh=Vb
	23ILmYyP5q3XHtglITRsjuo7E2pKTV2KhWfMB30mY=; b=KCShqQ4F4rkwcaEZR3
	lzveuHicxez8CEb0jRnrKS3/k04tQamTW4K2H5/ZJq6rhxyzQEDKxUuFH4BEn3v0
	pK/XFrHAexMOc2ORwNDsvZM71D5PISZiyfrF5NYP4WKIDbwoJLzb6pYlGqcnELLF
	pkyq51kuLELLzfF3h0EpBk3RpO5EIthWQRbcHfbkg/ye6CkPj7ECTQCkmA5zhBvT
	AXuTWpUDHt3xFZrzvcwO7MxOZsid1V6gSZIOz4mP0+rVA20DgNdHHIcJDoqO9TJa
	WU2bj+VmiUlBRWgP/JmGUrE7khHhusPFhHSDbJ9CjgiTtHRppQnHsgl9eUDQQy78
	rfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607331; x=1697693731; bh=Vb23ILmYyP5q3
	XHtglITRsjuo7E2pKTV2KhWfMB30mY=; b=U/xOM46rRucDJE9l2S3ZugvswVIhb
	QpskrvOjxpn4kUKDII2hAqaxp69VVH+L4kPWbczKJK0XZJvUUNGsGoxCXucgl/xQ
	5B1YD2he3gGJHUAP77n27vEdAXWjhPjFjNak0/j5dC3kzg9k+PY9bBxXHnynrCpC
	HIiMSprWnIJ8vzh1j0df3gdEM5V5vi/IBbwzirxjxe7lhCveYUVHc724WdLHSdO/
	nD9hgWTqdiXq2htAd9mlgdNSTbu9LhHvLCNICyaTDO8y4DTyPLVjCmzShUy94pp7
	ZwUHrTT+vU7vVOU4TSKKVXxLamLT7yb0LtYSLcSyJCTWRdbp22ZNOalbg==
X-ME-Sender: <xms:o24vZWW7hovroignWE2xxfC7sQMBy6DCJhhzmNx8xdQ4amGfvSvdWQ>
    <xme:o24vZSmkzBOtCyoh26LWTRmd0K3DEhdOqOi7VPey-NsCctkYuGz7BkHqFNUwniV85
    bY8F0rHiOuePB-8IA>
X-ME-Received: <xmr:o24vZaYTyyQFfC7XoVpNTw7B6RPBXU-C18NP2yQM2BQRvGoUexJKaKw3KeXl6afI8mYW-17-nwoULFCmdBoWJBU6GoyfD0jSY7cMB94ZmyQuRW9e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:o24vZdXtCXQIZ3rO4jd6TLGlRG04Z26K0ePO2-IUkWg2A6Hb3lyaLw>
    <xmx:o24vZQlmh4Zac-BnZ9gg31M84LDM1B73ExZZz6hlZVsT3_yt2PWyPg>
    <xmx:o24vZSckhUwJ_TVq36y9bn6fBvoh-XwhzEb4m5luBLiu4y6PGe5XKg>
    <xmx:o24vZXu_rPgB9Ia9VFfd33_R0YnGUbW8j1qIoPLaYlFbD8yz4Pb1NA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15e82cbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:29 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 06/11] t: convert tests to not access reflog via the
 filesystem
Message-ID: <eaac658bbfd8259ed9a3cce6ca3c8486d6682e8f.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V19GcuvGg84JzGxi"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--V19GcuvGg84JzGxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our tests reach directly into the filesystem in order to both
read or modify the reflog, which will break once we have a second
reference backend in our codebase that stores reflogs differently.

Refactor these tests to either use git-reflog(1) or the ref-store test
helper. Note that the refactoring to use git-reflog(1) also requires us
to adapt our expectations in some cases where we previously verified the
exact on-disk log entries. This seems like an acceptable tradeoff though
to ensure that different backends have the same user-visible behaviour
as any user would typically use git-reflog(1) anyway to access the logs.
Any backend-specific verification of the written on-disk format should
be implemented in a separate, backend-specific test.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 17 +++++++++++------
 t/t3200-branch.sh     | 24 ++++++++++++------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 5f505e2f353..b1d2c014132 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -90,7 +90,8 @@ test_expect_success "deleting current branch adds message=
 to HEAD's log" '
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-$m -d $m &&
 	test_must_fail git show-ref --verify -q $m &&
-	grep "delete-$m$" .git/logs/HEAD
+	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
+	grep "delete-$m$" actual
 '
=20
 test_expect_success "deleting by HEAD adds message to HEAD's log" '
@@ -99,7 +100,8 @@ test_expect_success "deleting by HEAD adds message to HE=
AD's log" '
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-by-head -d HEAD &&
 	test_must_fail git show-ref --verify -q $m &&
-	grep "delete-by-head$" .git/logs/HEAD
+	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
+	grep "delete-by-head$" actual
 '
=20
 test_expect_success 'update-ref does not create reflogs by default' '
@@ -130,7 +132,7 @@ test_expect_success 'creates no reflog in bare reposito=
ry' '
=20
 test_expect_success 'core.logAllRefUpdates=3Dtrue creates reflog in bare r=
epository' '
 	test_when_finished "git -C $bare config --unset core.logAllRefUpdates && \
-		rm $bare/logs/$m" &&
+		test-tool ref-store main delete-reflog $m" &&
 	git -C $bare config core.logAllRefUpdates true &&
 	git -C $bare update-ref $m $bareB &&
 	git -C $bare rev-parse $bareB >expect &&
@@ -263,7 +265,10 @@ test_expect_success "(not) changed .git/$m" '
 	! test $B =3D $(git show-ref -s --verify $m)
 '
=20
-rm -f .git/logs/refs/heads/main
+test_expect_success "clean up reflog" '
+	test-tool ref-store main delete-reflog $m
+'
+
 test_expect_success "create $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
@@ -316,7 +321,7 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 111715=
0260 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success "verifying $m's log (logged by touch)" '
-	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expec=
t" &&
+	test_when_finished "git update-ref -d $m && git reflog expire --expire=3D=
all --all && rm -rf actual expect" &&
 	test-tool ref-store main for-each-reflog-ent $m >actual &&
 	test_cmp actual expect
 '
@@ -346,7 +351,7 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 111715=
0380 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
 test_expect_success "verifying $m's log (logged by config)" '
-	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expec=
t" &&
+	test_when_finished "git update-ref -d $m && git reflog expire --expire=3D=
all --all && rm -rf actual expect" &&
 	test-tool ref-store main for-each-reflog-ent $m >actual &&
 	test_cmp actual expect
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 874520e3f10..933aa9eebbd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -76,14 +76,14 @@ test_expect_success 'git branch HEAD should fail' '
 '
=20
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from main
+$HEAD refs/heads/d/e/f@{0}: branch: Created from main
 EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a bran=
ch and a log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git -c core.logallrefupdates=3Dfalse branch --create-reflog d/e/f &&
 	test_ref_exists refs/heads/d/e/f &&
-	test_path_is_file .git/logs/refs/heads/d/e/f &&
-	test_cmp expect .git/logs/refs/heads/d/e/f
+	git reflog show --no-abbrev-commit refs/heads/d/e/f >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'git branch -d d/e/f should delete a branch and a log'=
 '
@@ -203,10 +203,9 @@ test_expect_success 'git branch -M baz bam should succ=
eed when baz is checked ou
 	test $(git rev-parse --abbrev-ref HEAD) =3D bam
 '
=20
-test_expect_success 'git branch -M baz bam should add entries to .git/logs=
/HEAD' '
-	msg=3D"Branch: renamed refs/heads/baz to refs/heads/bam" &&
-	grep " $ZERO_OID.*$msg$" .git/logs/HEAD &&
-	grep "^$ZERO_OID.*$msg$" .git/logs/HEAD
+test_expect_success 'git branch -M baz bam should add entries to HEAD refl=
og' '
+	git reflog show HEAD >actual &&
+	grep "HEAD@{0}: Branch: renamed refs/heads/baz to refs/heads/bam" actual
 '
=20
 test_expect_success 'git branch -M should leave orphaned HEAD alone' '
@@ -228,7 +227,7 @@ test_expect_success 'git branch -M should leave orphane=
d HEAD alone' '
 test_expect_success 'resulting reflog can be shown by log -g' '
 	oid=3D$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-	HEAD@{0} $oid $msg
+	HEAD@{0} $oid Branch: renamed refs/heads/baz to refs/heads/bam
 	HEAD@{2} $oid checkout: moving from foo to baz
 	EOF
 	git log -g --format=3D"%gd %H %gs" -2 HEAD >actual &&
@@ -702,7 +701,8 @@ test_expect_success 'git branch -C c1 c2 should succeed=
 when c1 is checked out'
=20
 test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
 	msg=3D"Branch: copied refs/heads/c1 to refs/heads/c2" &&
-	! grep "$msg$" .git/logs/HEAD
+	git reflog HEAD >actual &&
+	! grep "$msg$" actual
 '
=20
 test_expect_success 'git branch -C main should work when main is checked o=
ut' '
@@ -1143,14 +1143,14 @@ test_expect_success '--set-upstream-to notices an e=
rror to set branch as own ups
=20
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from main
+$HEAD refs/heads/g/h/i@{0}: branch: Created from main
 EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a=
 log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git checkout -b g/h/i -l main &&
 	test_ref_exists refs/heads/g/h/i &&
-	test_path_is_file .git/logs/refs/heads/g/h/i &&
-	test_cmp expect .git/logs/refs/heads/g/h/i
+	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'checkout -b makes reflog by default' '
--=20
2.42.0


--V19GcuvGg84JzGxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbqAACgkQVbJhu7ck
PpSH8Q//aOKJVMJAmb3AvuKOJkMyRa4nxrHjDM2EFZLNzhTx8uokFNXvg5nkwLQJ
26Rb9x+PWvcFqzkOAd9WEdfTCixCBP0NxzPQtu+xFigTvhXkO5+RLjYuvpAc0ZyW
kHPZx/tsWyRYbb9YO6tCkYWUBF53TBOH5SMEOl2/bGj3nqH5Y2IDhyh0ifvdCPFF
1jX+xKDstD3C27GhUjlEo6BMYVGCQrAD+2jXgpp4iJXEPV6NLRtUz0Wxh+/XcJrz
T+C0x2v/WOtRoaXOXIRkZtwrFyJG3NH/gSuRQ4tiSMwG0Hp5n+o93RIRvuF95820
WMK7ajLobFlZl2Y+S510LvPRB1TqtseN2/IkPWRIvuErHO5H307lMkrvdY8eNT0V
a/L9IVIS574NKsmqmakAX8/aE9M/TO/K2khkcZPnuUoQiYFExiCpHV17SKiUMn4q
8zPwXLn7VYLYSV2CBP4CNFqxdkIiygjKphaQ0IXEXgNJkxvEt9gAD6Qtz9FHzaP5
oza7VFjt/itTPS9dBmtYSdo+WviBpAYjb3p7d6ClCNPOSuWKfS6t/NDtcXqN5mHe
IiIbb9Z5l8yDq29FvXCbMOg4ue+VkSSNO4yEg2fsABDV8tIozbny4Q11m1YqFlsJ
IoAzDDESDyjte/ji7GD2miAziIZWvNqGGfbII2wtXr/aiOztQgE=
=KOHR
-----END PGP SIGNATURE-----

--V19GcuvGg84JzGxi--
