Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A2111B0
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O+b3FTQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sWtJU0rC"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC477131
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:47:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id BE7C83200925;
	Thu,  2 Nov 2023 04:47:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 02 Nov 2023 04:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914837; x=1699001237; bh=oa
	AtxWjQVh4Y/u+Cwt5KAfFpbX3q7H9kJwWhFHthAxs=; b=O+b3FTQ8Q28eLO2J3w
	iTKPfAjhZePmUwvX6BwHXOVnnJR4yM8JfQQXk5r9O2GpAYReUo0D9P3bg9MPRID3
	WYUsxPLN+hvpXpz8Ip/IyWfkE7zvLrHluW8/GeTT7Bs6/K0DIT6aF4VnGn/pLalb
	hUrnMVkWSaZ6TP7oxSK/Kw/AFpVMXNWTaItuUOzBEi9LdJEJVarbjkq+Pa3w/5XO
	rPl1mUsU6zdWctm3QrHcbsJ+ptZKH0fcNxbIMgIIHsgwEL4TYI0a59eRaG7yOnyE
	MUlsh5VM/zMYR6Zgm02dYhGc51poVy1N6neSOE1Rjv1madTI4GnPvOJD5StZoC6w
	tISA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914837; x=1699001237; bh=oaAtxWjQVh4Y/
	u+Cwt5KAfFpbX3q7H9kJwWhFHthAxs=; b=sWtJU0rC9k5vm2kELt4DT4jJmJzTn
	Mb8/ID0UD42MYOcXz7Yl/Tf8QRR+I8SP3t+vqs9LY/cV8meEMSvILbOsRbeOfny8
	Lm8XC4m+jKB61+In0YVoJpwi78X3LU7RMkQ4c0NFl+9JkiLO/OAt3E/IGVkg83gP
	xICFnqt9xmC63JWAOEH2bu+KLyFSlhw6PboFMMItp2j8zi8twJ+wLj2Y+qxkWfD7
	Q6s50jols2JYftv2Qco5LcwDmOlaSY/zhFc7GQALCHqcywoHtMCKmLlRLOBCnNAX
	ncnioDWIGWh90vJ7kGe0LVUBn4aDbejLeQVUFB+262bSDK20w3fyMOKSQ==
X-ME-Sender: <xms:FWJDZR3sur7zovKzFJBkSbXW-UuVkiofHgT5hL351qqT8boj6H_zAg>
    <xme:FWJDZYGyaj5dAJ2kaMX_kxZJNyy7ncUwxmq27ySS3wJquQYJwHup_lXm1W5tSJd5c
    TO9pGvP9OJn-S1xjA>
X-ME-Received: <xmr:FWJDZR4_GtS5JB9l9oveTLy62zd-pkId7kmMT_-ZxAwyCdmsJUwW6TwZaP9ZG0biNHMGlEv-oRE3w3S0O3MLlp0i7Ozb4tpLKiLuTHGcbSPablI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FWJDZe0_bVy6iw2ee01kpQFELg-eGINK5Y-M_fUexqRecZglkpSfrw>
    <xmx:FWJDZUHqsjK5vAKT0IyyNkTicxkhA2DFncq0-nblUzw_QPAHwAekMw>
    <xmx:FWJDZf-_diePTZOkES-9FDUguMhlpozNtEcQN7kXDbqGmJRx5Xv29A>
    <xmx:FWJDZYCGEd4KyzmeWXk2gUqWgCpXE536wqw1BZ_XiWxscF2J4LJCyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:47:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f42b1eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:47:04 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:47:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 9/9] t: mark several tests that assume the files backend
 with REFFILES
Message-ID: <9fc039a1764f58d5919d9559e726d0d52ca839d6.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="04uJbO0Q6MvqJqe+"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--04uJbO0Q6MvqJqe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the REFFILES prerequisite to several tests that assume we're using
the files backend. There are various reasons why we cannot easily
convert those tests to be backend-independent, where the most common
one is that we have no way to write corrupt references into the refdb
via our tooling. We may at a later point in time grow the tooling to
make this possible, but for now we just mark these tests as requiring
the files backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh            |  8 ++++----
 t/t1450-fsck.sh                  |  6 +++---
 t/t2011-checkout-invalid-head.sh | 16 ++++++++--------
 t/t3200-branch.sh                |  8 ++++----
 t/t3400-rebase.sh                |  2 +-
 t/t5605-clone-local.sh           |  2 +-
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b7d1e5deede..70a760ba378 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -236,7 +236,7 @@ test_expect_success 'update-ref --no-deref -d can delet=
e self-reference' '
 	test_must_fail git show-ref --verify -q refs/heads/self
 '
=20
-test_expect_success 'update-ref --no-deref -d can delete reference to bad =
ref' '
+test_expect_success REFFILES 'update-ref --no-deref -d can delete referenc=
e to bad ref' '
 	>.git/refs/heads/bad &&
 	test_when_finished "rm -f .git/refs/heads/bad" &&
 	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
@@ -288,7 +288,7 @@ test_expect_success "set $m (logged by touch)" '
 	test $A =3D $(git show-ref -s --verify $m)
 '
=20
-test_expect_success 'empty directory removal' '
+test_expect_success REFFILES 'empty directory removal' '
 	git branch d1/d2/r1 HEAD &&
 	git branch d1/r2 HEAD &&
 	test_path_is_file .git/refs/heads/d1/d2/r1 &&
@@ -300,7 +300,7 @@ test_expect_success 'empty directory removal' '
 	test_path_is_file .git/logs/refs/heads/d1/r2
 '
=20
-test_expect_success 'symref empty directory removal' '
+test_expect_success REFFILES 'symref empty directory removal' '
 	git branch e1/e2/r1 HEAD &&
 	git branch e1/r2 HEAD &&
 	git checkout e1/e2/r1 &&
@@ -1639,7 +1639,7 @@ test_expect_success PIPE 'transaction flushes status =
updates' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'directory not created deleting packed ref' '
+test_expect_success REFFILES 'directory not created deleting packed ref' '
 	git branch d1/d2/r1 HEAD &&
 	git pack-refs --all &&
 	test_path_is_missing .git/refs/heads/d1/d2 &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a6af550867c..50b15bd7fc0 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -123,7 +123,7 @@ test_expect_success 'branch pointing to non-commit' '
 	test_i18ngrep "not a commit" out
 '
=20
-test_expect_success 'HEAD link pointing at a funny object' '
+test_expect_success REFFILES 'HEAD link pointing at a funny object' '
 	test_when_finished "git update-ref HEAD $orig_head" &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
@@ -139,7 +139,7 @@ test_expect_success 'HEAD link pointing at a funny plac=
e' '
 	test_i18ngrep "HEAD points to something strange" out
 '
=20
-test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
+test_expect_success REFFILES 'HEAD link pointing at a funny object (from d=
ifferent wt)' '
 	test_when_finished "git update-ref HEAD $orig_head" &&
 	test_when_finished "git worktree remove -f wt" &&
 	git worktree add wt &&
@@ -149,7 +149,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct (from different wt)' '
 	test_i18ngrep "main-worktree/HEAD: detached HEAD points" out
 '
=20
-test_expect_success 'other worktree HEAD link pointing at a funny object' '
+test_expect_success REFFILES 'other worktree HEAD link pointing at a funny=
 object' '
 	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-he=
ad.sh
index d9997e7b6b4..3c8135831b8 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -18,18 +18,18 @@ test_expect_success 'checkout should not start branch f=
rom a tree' '
 	test_must_fail git checkout -b newbranch main^{tree}
 '
=20
-test_expect_success 'checkout main from invalid HEAD' '
+test_expect_success REFFILES 'checkout main from invalid HEAD' '
 	echo $ZERO_OID >.git/HEAD &&
 	git checkout main --
 '
=20
-test_expect_success 'checkout notices failure to lock HEAD' '
+test_expect_success REFFILES 'checkout notices failure to lock HEAD' '
 	test_when_finished "rm -f .git/HEAD.lock" &&
 	>.git/HEAD.lock &&
 	test_must_fail git checkout -b other
 '
=20
-test_expect_success 'create ref directory/file conflict scenario' '
+test_expect_success REFFILES 'create ref directory/file conflict scenario'=
 '
 	git update-ref refs/heads/outer/inner main &&
=20
 	# do not rely on symbolic-ref to get a known state,
@@ -39,26 +39,26 @@ test_expect_success 'create ref directory/file conflict=
 scenario' '
 	}
 '
=20
-test_expect_success 'checkout away from d/f HEAD (unpacked, to branch)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to br=
anch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success 'checkout away from d/f HEAD (unpacked, to detached)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to de=
tached)' '
 	reset_to_df &&
 	git checkout --detach main
 '
=20
-test_expect_success 'pack refs' '
+test_expect_success REFFILES 'pack refs' '
 	git pack-refs --all --prune
 '
=20
-test_expect_success 'checkout away from d/f HEAD (packed, to branch)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to bran=
ch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success 'checkout away from d/f HEAD (packed, to detached)' '
+test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to deta=
ched)' '
 	reset_to_df &&
 	git checkout --detach main
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 933aa9eebbd..606c50fe66c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -28,7 +28,7 @@ test_expect_success 'git branch --help should not have cr=
eated a bogus branch' '
 	test_ref_missing refs/heads/--help
 '
=20
-test_expect_success 'branch -h in broken repository' '
+test_expect_success REFFILES 'branch -h in broken repository' '
 	mkdir broken &&
 	(
 		cd broken &&
@@ -245,7 +245,7 @@ test_expect_success 'git branch -M baz bam should succe=
ed when baz is checked ou
 	git worktree prune
 '
=20
-test_expect_success 'git branch -M fails if updating any linked working tr=
ee fails' '
+test_expect_success REFFILES 'git branch -M fails if updating any linked w=
orking tree fails' '
 	git worktree add -b baz bazdir1 &&
 	git worktree add -f bazdir2 baz &&
 	touch .git/worktrees/bazdir1/HEAD.lock &&
@@ -836,14 +836,14 @@ test_expect_success 'renaming a symref is not allowed=
' '
 	test_ref_missing refs/heads/new-topic
 '
=20
-test_expect_success SYMLINKS 'git branch -m u v should fail when the reflo=
g for u is a symlink' '
+test_expect_success SYMLINKS,REFFILES 'git branch -m u v should fail when =
the reflog for u is a symlink' '
 	git branch --create-reflog u &&
 	mv .git/logs/refs/heads/u real-u &&
 	ln -s real-u .git/logs/refs/heads/u &&
 	test_must_fail git branch -m u v
 '
=20
-test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
+test_expect_success SYMLINKS,REFFILES 'git branch -m with symlinked .git/r=
efs' '
 	test_when_finished "rm -rf subdir" &&
 	git init --bare subdir &&
=20
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d3df19a51f8..435943a0891 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -424,7 +424,7 @@ test_expect_success 'refuse to switch to branch checked=
 out elsewhere' '
 	test_i18ngrep "already used by worktree at" err
 '
=20
-test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a sym=
link' '
+test_expect_success REFFILES,MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs=
 is a symlink' '
 	git checkout main &&
 	mv .git/logs actual_logs &&
 	cmd //c "mklink /D .git\logs ..\actual_logs" &&
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index bedd29d0550..a3055869bc7 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -157,7 +157,7 @@ test_expect_success 'cloning locally respects "-u" for =
fetching refs' '
 	test_must_fail git clone --bare -u false a should_not_work.git
 '
=20
-test_expect_success 'local clone from repo with corrupt refs fails gracefu=
lly' '
+test_expect_success REFFILES 'local clone from repo with corrupt refs fail=
s gracefully' '
 	git init corrupt &&
 	test_commit -C corrupt one &&
 	echo a >corrupt/.git/refs/heads/topic &&
--=20
2.42.0


--04uJbO0Q6MvqJqe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYhEACgkQVbJhu7ck
PpQU5RAApXHbzT+U9i9xAbo6Zu87kVrikMLmlDWOiv5N8QaROOQ1nqYpCG5tzmdA
ua1IXV/jQaM6YLcMK4HgXztKDgXYGUY3g6R4ftVm6wE1j5ePJ8frU5YCceoj2oBH
uInHk2B/9aPbEFnFrQEAzx3bTd+m69EQTGME3mpqmIDwP8PmYMEIA3Lh4Fks9Dvi
M56sbfhLxFNN3sbVklTlisS069msGwwJUBqoQpIwgCMIngOqzRFqcLNPh9qWtWOr
XgJBZOGlA964EhobrPTkhLDM0TL1v2dQ2Ertfh9mDly8PdxRoW6A+mDGRy2Bb2ru
2OO8nxtXvzEIoZEnXGBb/3Q7asFHWCsj7L6oc+jtYg/e9OBPtQTK3A1IpblJIb5g
dhBnTPtuEtoB+6n9qy3KKzCpv3LOOT/IKvqqbXT0g+HUXsTTS8huY8OEZhC7uwXR
etOxugp5YljY/gJsBmZpPME7v9OySU3ChOruLZqfmfyFy0vHmQVhyCV8uDhceE7E
9ggpQ4ePaFXrNOo8Cx9+Qu29VQFEPTpVt6GWC3lb2TGcVyxrAV5UZgh9tqhUDkvP
VwZOKWGHfQGT43kV0sHJGXi7BGgGIlGXqL6MlE59Q0ipmNpvJZ9oBA2Xr+MyLn5b
JKQtJd8GyqNgVnktJrFLqD4cSB+MXdhwIkfD2Lc+elGyRuU+xls=
=mH8h
-----END PGP SIGNATURE-----

--04uJbO0Q6MvqJqe+--
