Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A02C87B
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aa9gLN2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9JSQ/hI"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1559109
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6A6F93200A8E;
	Tue, 24 Oct 2023 10:05:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 10:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156309; x=1698242709; bh=Ct
	5ovSwmRzrF1V2weXagCPeBCyJ9Npkg4Kqs9W+gekE=; b=Aa9gLN2eLZ8RpRRzY+
	ziri2OX/G7JhFNDft3CsIWUQN/Z6XX7qobeyMCZWVYqxDvvlVU4GcYlizSn6mynP
	pxu3iMRvuWhQ/RWwmClxwp2p4onisWWxdh02TuMEItAfWKpm1PsuC/8OHTRBG3W/
	yNQ2NHQNNx5gI6IIao/m8U1lXbM/4qBQnG159Ik8F7qelW7MVExhPs0f8pZ++K/h
	+thz/W/9xXQUVTDYb6qstdZSoJwtw1GGzxyXSbCJBLUwZc6p1gRXDvVgYV5t2tSP
	7yMxdMUlwwgWfCB7P/L9SQPOgf48YqvRwcHd0CP1JFFqtFfVhGKD46MiLO4RQgyN
	l53A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156309; x=1698242709; bh=Ct5ovSwmRzrF1
	V2weXagCPeBCyJ9Npkg4Kqs9W+gekE=; b=d9JSQ/hIefx/Dx0dcRIl/VvDcPuIZ
	SUqZhpf6UR9JTTNp82gCrIaEj6TsEy1kp6P+F6F5iY/Sc10LeLRA0d+lmHv1HYxZ
	lK92UNqesjqOGM81FC+HUmXLND976hTIa/RTk03pctIUGRXNIFrpbZ954MUYcXOq
	CUWxttoLG0zhipFv4j2OXYuHmuoEQUH9EB8azj6i/BkU0isYPL+EbZttKWqFj9nw
	PWJ2025zRY9NLC8v0etX/bpLUY8uq3ATXF7PAFt3SdTHpIGpy4ZI9tVgegBwll+g
	vTKKS1R/tArq7KCMoDcD+3wCcLPkuB1A9i9p1gsiy38HBDLAqJ6/QMLUQ==
X-ME-Sender: <xms:Fc83ZawifzDVurZomz-PgWdLyW_gOqNq3ttHzXpWVrWqWLirJ5rYTQ>
    <xme:Fc83ZWRnzkVocwVFdzBi4f3Hlua73YIirw7JHZkARRKwgPWBbRiPCnFB4KRTdFJy7
    OyHTFRnGQpZO5BqRQ>
X-ME-Received: <xmr:Fc83ZcU1VikWq2LVW1LzDmmmcO0GnQvlWr9e8gK8nwSmCwijr288_rgc_HDHYa_O42-oSRv5Ie9ZrlsklIUUPvKjTSYbhzwWVeV5rmh7c8BdOp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Fc83ZQhPg7o3Cd2Vdx5Y4q5FqDrPOdZc8zoH9HCyjHQ7C0w6fO1yKw>
    <xmx:Fc83ZcCajWow45S17tGVNZS_SMPvv-dsiw3GtsCqJXYc5UQy5IXE0Q>
    <xmx:Fc83ZRIAOkE-8p-dsNyXX1rh-46an_y9nFp1DU1siYoHzjZi9YLh0g>
    <xmx:Fc83ZfOVx4R_usJXHSJSGAM9aZG1sIIaVj9OGEaU2ZQssZ2ehyTYWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 149f8dd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:05:03 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] t: convert tests to not access reflog via the
 filesystem
Message-ID: <5e7937e790411a5fe8f3182328ca5a43529f499a.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pP2IVrxcxEptiGYb"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--pP2IVrxcxEptiGYb
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
index 51a8d0bba98..b7d1e5deede 100755
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
index 7d9393f190d..a38601dbbb7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -73,14 +73,14 @@ test_expect_success 'git branch HEAD should fail' '
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
 	test_path_is_file .git/refs/heads/d/e/f &&
-	test_path_is_file .git/logs/refs/heads/d/e/f &&
-	test_cmp expect .git/logs/refs/heads/d/e/f
+	git reflog show --no-abbrev-commit refs/heads/d/e/f >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'git branch -d d/e/f should delete a branch and a log'=
 '
@@ -200,10 +200,9 @@ test_expect_success 'git branch -M baz bam should succ=
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
@@ -225,7 +224,7 @@ test_expect_success 'git branch -M should leave orphane=
d HEAD alone' '
 test_expect_success 'resulting reflog can be shown by log -g' '
 	oid=3D$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
-	HEAD@{0} $oid $msg
+	HEAD@{0} $oid Branch: renamed refs/heads/baz to refs/heads/bam
 	HEAD@{2} $oid checkout: moving from foo to baz
 	EOF
 	git log -g --format=3D"%gd %H %gs" -2 HEAD >actual &&
@@ -699,7 +698,8 @@ test_expect_success 'git branch -C c1 c2 should succeed=
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
@@ -1140,14 +1140,14 @@ test_expect_success '--set-upstream-to notices an e=
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
 	test_path_is_file .git/refs/heads/g/h/i &&
-	test_path_is_file .git/logs/refs/heads/g/h/i &&
-	test_cmp expect .git/logs/refs/heads/g/h/i
+	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'checkout -b makes reflog by default' '
--=20
2.42.0


--pP2IVrxcxEptiGYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zxEACgkQVbJhu7ck
PpQ1mQ//WbhHwTNRyvljR0rx3A3htSTstPz2uHoHXmATGnmYF8rpKAoylgmtTYHQ
5+87XiK9yQMZP8sfdCPEsQEKwSM2ErpHTRNg1BPvFDQ0zMnqirbz3aIDUd9IVcC9
JXtME//GzoM/t5g7csOqSYKKMxx20pun7yd0knl6jwgKrADJgDSWnjuV4tgZs3pS
QgZmpmbR8ygSEz00HIBxmjrY2xjdwgdJYexGujMi0IumRI2fhAEcdZA4KHOpRb/G
vH7jVWtS3oP231OlSBS0Ts105ZClI2/Gr+J3jmxMWcMWQg0ZMzmW1PrMOiwkcarR
1JlymhBjPyY93QLoBxRBbbDBSPgJEFZ5yygCs9M545AmCzhKKfAAlzn/q2OLRGvO
Vf41A1mLO5raRxWTe2hpgbouI4Co9mBRBi6SVaZ4A/uu1144emNNS/OP8F5rnPMP
12TvY3D4815ysSebQuUIDuP69DQqODVXHq7OUCSFRKCI43FAKapMvvKvKy44xbHD
QYLkFdLGEuQsl4uj+d+7is5+xFNpS17Ay1PdcknEhmxJKpP45MCDgZkjnVKbwoB0
PzerLI2vsso2nuVirm/4objEHz0xIJ8AdomWKUGvsfPFmP2Teol34dgWeVgqg+pI
uiW3jptiR/gq19HtjFnSlfF9NgKHjUoM6R0satfa2JOhAE8ziqw=
=YNKf
-----END PGP SIGNATURE-----

--pP2IVrxcxEptiGYb--
