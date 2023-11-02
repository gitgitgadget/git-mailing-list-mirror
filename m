Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2329620F9
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ox/Tb16w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVqj3cqd"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B15128
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:46:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id ABA35320099D;
	Thu,  2 Nov 2023 04:46:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Nov 2023 04:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914802; x=1699001202; bh=K4
	djg2KEyEOnH8i2G709uf/CF+NS0itJfHaktnj4vAk=; b=ox/Tb16wMuVOjjug2e
	XH/w7kW9s+PDwZwL3TTpI/hYdWFf3tIKncBXhyRqR5Q4/4/TcPny9g5EkmpQJQh8
	VbDL/X7xoOiQR7Lt8CZK0wqVnRooMFgHTXJQQC15G92B8LSdKyl8DsNhdeTwlQP6
	3C6Qy0+G2nFia1uBRK7a/BsEeOwYwoDtdqUq6IJ6PGPw4UcoZh23qZ/4KSv91ETC
	KWiSfceLfL3Jv+vO8EDNJp02Ep3eguyGhXwyLBnFBVPA6fU00OGRGnVXKpsvL5RA
	L5FQ37hx3aMKskP2fEzYln2lE5rX2jcKTzUttg71L0DT38ljwgZkdZDwczQF3pUf
	e2QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914802; x=1699001202; bh=K4djg2KEyEOnH
	8i2G709uf/CF+NS0itJfHaktnj4vAk=; b=UVqj3cqdJoji7SGW5zB7p46HIwLRu
	odoEw/GZzlCXVYSLY2Vhy1fQrpoLdq5fAjShu7zxCWOgW8UYKVh1v2aGw/5K5oMF
	cyRSahTyOq13/caO0VlrkJCEzrT+dUbZqXaW67Si21warjTxDn+xcmJgZRrmyVTX
	PV9Kgy1al0Uc3MMxMk/2ucfGneoSH7S7LEQ0L4mMWe38kWdylkEmEpXJMxgTJMYg
	Mj2UKpuILF/fzPKFUSiI3YA/xZNESaTPV6ZilVlIRo5dw8gKFLb5ud7J8Izn3faD
	eQCewp2zGWPvwtvxywKjtOoBDzjo9w23SOGCyWzS6I+la1h2xgBe5m2QA==
X-ME-Sender: <xms:8WFDZS2CoVqgmlFz0v7Dd4iCPtb5wLom8yxEumbJyC5vkZeLMMApEQ>
    <xme:8WFDZVH3KgGt8vNuSYzrlEgAryRraXXJrPfrCrrOeWAwLnSCltINU1OKngjq9TAiV
    F4X-SVLKtoesnou3A>
X-ME-Received: <xmr:8WFDZa5rik10WRTK9MqLh_rkvMFNj3AZ776OkYXFHQeduFKiwDFfRrLf203CyRZhSTkStTjjrgpM91p5HekGIGAkvfi1RIhv5-07QVhEhKKC8Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:8WFDZT2Z-c0NsAI1B_2HRrojvbnoDsJUx1Q-P3S3ESigpRdIfDeG6Q>
    <xmx:8WFDZVHRclmWYsjzSfO8vDC9khVXE1sZuOqu9bmKGg56RCFGiOvDew>
    <xmx:8WFDZc-BhPNGRl3QPMiz6n1rpcDeeEefWDCVfvVSDN_hYI6QuzMkTg>
    <xmx:8mFDZVCyR-oWpYtq-0Wyx4XmhLHwoWwk63nuFKwritDn-uMmwTKAyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:46:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d96922e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:27 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:46:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/9] t: reduce direct disk access to data structures
Message-ID: <cover.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s71bw3otiADkXs8A"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>


--s71bw3otiADkXs8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that aims to reduce access
to on-disk data structures in favor of using plumbing tools where
possible.

There are no changes compared to v2 except for a rebase on top of
0497e6c611 (t: use git-show-ref(1) to check for ref existence,
2023-10-31), which has been merged to "next" now and conflicts with this
patch series.

Patrick

Patrick Steinhardt (9):
  t: allow skipping expected object ID in `ref-store update-ref`
  t: convert tests to not write references via the filesystem
  t: convert tests to not access symrefs via the filesystem
  t: convert tests to not access reflog via the filesystem
  t1450: convert tests to remove worktrees via git-worktree(1)
  t4207: delete replace references via git-update-ref(1)
  t7300: assert exact states of repo
  t7900: assert the absence of refs via git-for-each-ref(1)
  t: mark several tests that assume the files backend with REFFILES

 t/helper/test-ref-store.c          | 11 ++++---
 t/t1400-update-ref.sh              | 50 ++++++++++++++++--------------
 t/t1430-bad-ref-name.sh            | 12 +++----
 t/t1450-fsck.sh                    | 44 +++++++++++++-------------
 t/t2011-checkout-invalid-head.sh   | 16 +++++-----
 t/t3200-branch.sh                  | 41 ++++++++++++------------
 t/t3400-rebase.sh                  |  2 +-
 t/t3404-rebase-interactive.sh      |  2 +-
 t/t4013-diff-various.sh            |  2 +-
 t/t4202-log.sh                     |  2 +-
 t/t4207-log-decoration-colors.sh   | 10 ++++--
 t/t5526-fetch-submodules.sh        |  2 +-
 t/t5605-clone-local.sh             |  4 +--
 t/t5702-protocol-v2.sh             | 24 ++++++++++----
 t/t7300-clean.sh                   | 23 ++++++++------
 t/t7900-maintenance.sh             |  3 +-
 t/t9133-git-svn-nested-git-repo.sh |  2 +-
 17 files changed, 142 insertions(+), 108 deletions(-)

Range-diff against v2:
 1:  c868198f8c1 =3D  1:  3caf9e3f28f t: allow skipping expected object ID =
in `ref-store update-ref`
 2:  4c0939d868e =3D  2:  1884b7006cf t: convert tests to not write referen=
ces via the filesystem
 3:  048583ed2c3 !  3:  d6307177132 t: convert tests to not access symrefs =
via the filesystem
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref -d can dele=
te broken na
     -	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/main &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    + 	test_ref_exists refs/heads/broken...symref &&
      	git update-ref --no-deref -d refs/heads/broken...symref >output 2>er=
ror &&
    - 	test_path_is_missing .git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref=
 -d can delete symref with broken name
      '
     =20
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref =
-d can delet
     -	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/main &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    + 	test_ref_exists refs/heads/broken...symref &&
      	git branch -d broken...symref >output 2>error &&
    - 	test_path_is_missing .git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete =
symref with broken name' '
      '
     =20
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'branch -d can delete s=
ymref with b
     -	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...sym=
ref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/idonotexist &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    + 	test_ref_exists refs/heads/broken...symref &&
      	git update-ref --no-deref -d refs/heads/broken...symref >output 2>er=
ror &&
    - 	test_path_is_missing .git/refs/heads/broken...symref &&
     @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref=
 -d can delete dangling symref with br
      '
     =20
    @@ t/t1430-bad-ref-name.sh: test_expect_success 'update-ref --no-deref =
-d can delet
     -	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...sym=
ref &&
     +	test-tool ref-store main create-symref refs/heads/broken...symref re=
fs/heads/idonotexist &&
      	test_when_finished "test-tool ref-store main delete-refs REF_NO_DERE=
F msg refs/heads/broken...symref" &&
    + 	test_ref_exists refs/heads/broken...symref &&
      	git branch -d broken...symref >output 2>error &&
    - 	test_path_is_missing .git/refs/heads/broken...symref &&
    =20
      ## t/t1450-fsck.sh ##
     @@ t/t1450-fsck.sh: test_expect_success 'HEAD link pointing at a funny=
 object' '
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M should leave o=
rphaned HEAD
     +		git symbolic-ref HEAD >expect &&
     +		echo refs/heads/lonely >actual &&
     +		test_cmp expect actual &&
    - 		test_path_is_missing .git/refs/head/lonely &&
    + 		test_ref_missing refs/head/lonely &&
      		git branch -M main mistress &&
     -		grep lonely .git/HEAD
     +		git symbolic-ref HEAD >expect &&
    @@ t/t3200-branch.sh: test_expect_success 'deleting a symref' '
     +	git symbolic-ref --no-recurse refs/heads/dangling-symref &&
      	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
      	git branch -d dangling-symref >actual &&
    - 	test_path_is_missing .git/refs/heads/dangling-symref &&
    + 	test_ref_missing refs/heads/dangling-symref &&
    =20
      ## t/t4013-diff-various.sh ##
     @@ t/t4013-diff-various.sh: test_expect_success 'log -S requires an ar=
gument' '
 4:  5e7937e7904 !  4:  fdf67689227 t: convert tests to not access reflog v=
ia the filesystem
    @@ t/t3200-branch.sh: test_expect_success 'git branch HEAD should fail'=
 '
      test_expect_success 'git branch --create-reflog d/e/f should create a=
 branch and a log' '
      	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
      	git -c core.logallrefupdates=3Dfalse branch --create-reflog d/e/f &&
    - 	test_path_is_file .git/refs/heads/d/e/f &&
    + 	test_ref_exists refs/heads/d/e/f &&
     -	test_path_is_file .git/logs/refs/heads/d/e/f &&
     -	test_cmp expect .git/logs/refs/heads/d/e/f
     +	git reflog show --no-abbrev-commit refs/heads/d/e/f >actual &&
    @@ t/t3200-branch.sh: test_expect_success '--set-upstream-to notices an=
 error to se
      test_expect_success 'git checkout -b g/h/i -l should create a branch =
and a log' '
      	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
      	git checkout -b g/h/i -l main &&
    - 	test_path_is_file .git/refs/heads/g/h/i &&
    + 	test_ref_exists refs/heads/g/h/i &&
     -	test_path_is_file .git/logs/refs/heads/g/h/i &&
     -	test_cmp expect .git/logs/refs/heads/g/h/i
     +	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
 5:  089565a358e =3D  5:  a5d55b68828 t1450: convert tests to remove worktr=
ees via git-worktree(1)
 6:  cb738888ed7 =3D  6:  3213d45b537 t4207: delete replace references via =
git-update-ref(1)
 7:  e730e011de4 =3D  7:  36e79f266c2 t7300: assert exact states of repo
 8:  a1bdea52397 =3D  8:  4af0dc00165 t7900: assert the absence of refs via=
 git-for-each-ref(1)
 9:  497e43ae5c3 !  9:  9fc039a1764 t: mark several tests that assume the f=
iles backend with REFFILES
    @@ t/t2011-checkout-invalid-head.sh: test_expect_success 'create ref di=
rectory/file
    =20
      ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'git branch --help should no=
t have created a bogus branch' '
    - 	test_path_is_missing .git/refs/heads/--help
    + 	test_ref_missing refs/heads/--help
      '
     =20
     -test_expect_success 'branch -h in broken repository' '
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should=
 succeed whe
      	git worktree add -f bazdir2 baz &&
      	touch .git/worktrees/bazdir1/HEAD.lock &&
     @@ t/t3200-branch.sh: test_expect_success 'renaming a symref is not al=
lowed' '
    - 	test_path_is_missing .git/refs/heads/new-topic
    + 	test_ref_missing refs/heads/new-topic
      '
     =20
     -test_expect_success SYMLINKS 'git branch -m u v should fail when the =
reflog for u is a symlink' '

base-commit: 0497e6c61172faabf412e013f2fc30a05054a46d
--=20
2.42.0


--s71bw3otiADkXs8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYecACgkQVbJhu7ck
PpQkEQ/7BQtfkIrgfR5kiylOF9SsQNpTXIHUsJznVAVwtyQuw2rx+NO/ggYSVEbj
iTS/POYYWuqxZI5PQB5I2YJLNK50pUyJXCHPWOn6KjzJwtfumGLyONe4OOACvwxA
t1IotYlIIOidRqnE+eR7g9A8N1K+wc1FHI+gJp27IS2xtMCo2cn/anzUAxQtAJAQ
rZQbMxYgweRxKgT2gRpEkmaPDxKXHbRooWD1K8zqt6ng1nzHnnch3YDM7fBR/jd+
HLhDYD6BJyag2kRodV2l419MhSbG+G2XCCpPlEnUqcWHQNnJcwGVtc9+ZdEI2pdo
deGbrXMxCcdtv3ZgTsO5Q9C8Id+VN6QGJFBhIDEECtb4EPtgYBw7yCtWwPa4nBuQ
I5lEd07TWASR4ct+Rs6kCDzGUrizra/WMbfxMI1BoLwZyvYie+IgMfK7jzYCVAHe
xpxmMZ9iXAD4GZXR1THrXMs5AJMiFd/NLKJyVOpSe6BQ7F9l5Fqv2hdRPPJSaKn3
qBbMqRinpRcBhFn8jCCMoqDDElaSdHAl8OhFH9Cg7HiLkgFQ6SsJUuUzfniDSaIB
xl3JVd/UA19gGtSX4FmfhhLZ9+0gYXXcArYCz4vmG+iIPMClmv+4Juc2cltmu+v8
hSdLIkfd2JmK5TndNYK4IZO9oKzhEQmDng7fKvf/sgfQZWVwhFk=
=518W
-----END PGP SIGNATURE-----

--s71bw3otiADkXs8A--
