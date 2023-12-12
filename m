Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dhF8CEYG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1p55NtK"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424DED1
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:00:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D8E2D3200AA4
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Dec 2023 02:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364442; x=1702450842; bh=F/HCHhAK7N
	1YxeaxXQnbjhcOGas9lQ48XYVxe9K6Spc=; b=dhF8CEYG2lKGljSItF/12UWUXD
	RhzG6wCOeNv+rz9NWZ5d1TE/eix7ijIynLiN0xYMndnm1LOlkBA5nbe01IaFitOO
	xJwzrZeWNvlaGuBK2221PufYYFa3PW8xWFU4oBXSPX09UN9jQKZr7qJP42Uanz06
	rRLOaIPTyy7LuamyvV0C3XzwgBuW9LYFSt/+xQer3HVoabufKtmuEAqYabIEeMPh
	zCbLs7aK5ce/pGjGu7vbHKzMuPDl6E6HCuWATYuAkanb0KvT7Cvk4sPnkk8NvMM4
	ByqHJXLOK9+1tlKO6McnA9dKaaQSC6sbfoQZpNvbPdULkrIsvLDbxISgAMGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364442; x=1702450842; bh=F/HCHhAK7N1YxeaxXQnbjhcOGas9
	lQ48XYVxe9K6Spc=; b=n1p55NtKhUpLNPwf4AMuJRMalfIRg1alMf50NrW+1UdN
	hELg1o7rShSfwkL/HAvEelE943UB/kPSk7wz7xerntpqUbadY62U9ew3L5i11s8s
	qSnGiomPbwnykDBhtiffl/J0Me0+OpmVzYRO4wxqrrIKdLU6v06XD9EOaRa1Al39
	EenL+ZFGRdTHMqFnIGzx0Il4DfLMFwpJwcwm+sWEuX6hsz0+VH36cWKWuqZFznRf
	C6qCnu1hvLsFPPusgYExQllVX4zj2uEmuJu/E2AD0of6BJEGvkWSRV4QdyfGhTBq
	yRtQXrDyqzQpv1MSBjuXi2Fm0WRwA3rpBzdumAu//A==
X-ME-Sender: <xms:GQV4Zdku_2qRd4cLmDFdWtbGpp7BR96QTeaief8TkteMj45XUvf8aw>
    <xme:GQV4ZY0EwHh5PCfE8zmBmd5Fk6c7_jNgjsjY3Fjfns1pHfDpjCXyW9GVw03F2scad
    15tzkWGfYkv75pn6w>
X-ME-Received: <xmr:GQV4ZTr2NF1oBUlEBm3rWex89FjWgBe07cqTeLFi-_Qvfh2HbFXhfAoR9HCdYh-snHntjsCToxfnlvksUX8sflNTWiQay5AQTrRs-2eH4LTiENo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvhfekhfetgffgfeejfeetffetieevtd
    etfeeiteetjeeljeekudegtefgtedvgfenucffohhmrghinhephhhtthhpqdhfvghttghh
    qdguuhhmsgdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GgV4ZdleINPKDJQAIaii9ab7eBhvjYt3Q_QTlnLJecwbONaTjJFQBA>
    <xmx:GgV4Zb0cT9TDUkApbVETYk18ueNkK_w2HrYD-3k-Ya5P9ueukQsLqg>
    <xmx:GgV4Zcumo17nrhTjhPgzmzAZhFdVxeXRSVG-jnIuZFwA4Mb0xlA3SA>
    <xmx:GgV4ZQhcuX6OUnORfnwm6vh3721D9_Hgs6UhnrZT4AoZOueZ0RXI8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07c4895d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:00 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:00:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 0/7] clone: fix init of refdb with wrong object format
Message-ID: <cover.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T1Esajs2S77ftWa7"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--T1Esajs2S77ftWa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series to make git-clone(1)
initialize the reference database with the correct hash format. This is
a preparatory step for the reftable backend, which encodes the hash
format on-disk and thus requires us to get the hash format right at the
time of initialization.

Changes compared to v1:

  - Patch 1: Extend the comment explaining why we always create the
    "refs/" directory.

  - Patch 3: Explain better why the patch is required in the first
    place.

  - Patch 4: Fix a typo.

  - Patch 7: Adapt a failing test to now assert the new behaviour.

Thanks for your reviews!

Patrick

Patrick Steinhardt (7):
  setup: extract function to create the refdb
  setup: allow skipping creation of the refdb
  remote-curl: rediscover repository when fetching refs
  builtin/clone: fix bundle URIs with mismatching object formats
  builtin/clone: set up sparse checkout later
  builtin/clone: skip reading HEAD when retrieving remote
  builtin/clone: create the refdb with the correct object format

 builtin/clone.c             |  65 ++++++++++----------
 remote-curl.c               |   7 ++-
 remote.c                    |  26 ++++----
 remote.h                    |   1 +
 setup.c                     | 114 ++++++++++++++++++++++--------------
 setup.h                     |   6 +-
 t/t5550-http-fetch-dumb.sh  |   4 +-
 t/t5558-clone-bundle-uri.sh |  18 ++++++
 8 files changed, 150 insertions(+), 91 deletions(-)

Range-diff against v1:
1:  b69c57d272 ! 1:  2f34daa082 setup: extract function to create the refdb
    @@ Commit message
         calling `init_db()`. Extract the logic into a standalone function =
so
         that it becomes easier to do this refactoring.
    =20
    +    While at it, expand the comment that explains why we always create=
 the
    +    "refs/" directory.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## setup.c ##
    @@ setup.c: void initialize_repository_version(int hash_algo, int reini=
t)
     +	int reinit =3D is_reinit();
     +
     +	/*
    -+	 * We need to create a "refs" dir in any case so that older
    -+	 * versions of git can tell that this is a repository.
    ++	 * We need to create a "refs" dir in any case so that older versions=
 of
    ++	 * Git can tell that this is a repository. This serves two main purp=
oses:
    ++	 *
    ++	 * - Clients will know to stop walking the parent-directory chain wh=
en
    ++	 *   detecting the Git repository. Otherwise they may end up detecti=
ng
    ++	 *   a Git repository in a parent directory instead.
    ++	 *
    ++	 * - Instead of failing to detect a repository with unknown reference
    ++	 *   format altogether, old clients will print an error saying that
    ++	 *   they do not understand the reference format extension.
     +	 */
     +	safe_create_dir(git_path("refs"), 1);
     +	adjust_shared_perm(git_path("refs"));
2:  090c52423e =3D 2:  40005ac1f1 setup: allow skipping creation of the ref=
db
3:  a1b86a0cbb ! 3:  374a1c514b remote-curl: rediscover repository when fet=
ching refs
    @@ Metadata
      ## Commit message ##
         remote-curl: rediscover repository when fetching refs
    =20
    -    We're about to change git-clone(1) so that we set up the reference
    -    database at a later point. This change will cause git-remote-curl(=
1) to
    -    not detect the repository anymore due to "HEAD" not having been cr=
eated
    -    yet at the time it spawns, and thus causes it to error out once it=
 is
    -    asked to fetch the references.
    +    The reftable format encodes the hash function used by the reposito=
ry
    +    inside of its tables. The reftable backend thus needs to be initia=
lized
    +    with the correct hash function right from the start, or otherwise =
we may
    +    end up writing tables with the wrong hash function. But git-clone(=
1)
    +    initializes the reference database before learning about the hash
    +    function used by the remote repository, which has never been a pro=
blem
    +    with the reffiles backend.
    +
    +    To fix this, we'll have to change git-clone(1) to be more careful =
and
    +    only create the reference backend once it learned about the remote=
 hash
    +    function. This creates a problem for git-remote-curl(1), which wil=
l then
    +    be spawned at a time where the repository is not yet fully-initial=
ized.
    +    Consequentially, git-remote-curl(1) will fail to detect the reposi=
tory,
    +    which eventually causes it to error out once it is asked to fetch =
remote
    +    objects.
    =20
         We can address this issue by trying to re-discover the Git reposit=
ory in
         case none was detected at startup time. With this change, the clon=
e will
    @@ Commit message
              repository
    =20
           4. git-clone(1) creates the reference database as it has now lea=
rned
    -         about the object format.
    +         about the hash function.
    =20
           5. git-clone(1) asks git-remote-curl(1) to fetch the remote pack=
file.
              The latter notices that it doesn't have a repository availabl=
e, but
4:  c7a9d6ef74 ! 4:  3bef564b57 builtin/clone: fix bundle URIs with mismatc=
hing object formats
    @@ Commit message
         is indeed not necessarily the case for the hash algorithm right no=
w. So
         in practice it is the right thing to detect the remote's object fo=
rmat
         before downloading bundle URIs anyway, and not doing so causes clo=
nes
    -    with bundle URIS to fail when the local default object format does=
 not
    +    with bundle URIs to fail when the local default object format does=
 not
         match the remote repository's format.
    =20
         Unfortunately though, this creates a new issue: downloading bundle=
s may
5:  703ff77eea =3D 5:  917f15055f builtin/clone: set up sparse checkout lat=
er
6:  6c919fb19c =3D 6:  f3485a2708 builtin/clone: skip reading HEAD when ret=
rieving remote
7:  eb5530e6a8 ! 7:  f062b11550 builtin/clone: create the refdb with the co=
rrect object format
    @@ Commit message
         upcoming reftable backend when cloning repositories with the SHA256
         object format.
    =20
    +    This change breaks a test in "t5550-http-fetch-dumb.sh" when cloni=
ng an
    +    empty repository with `GIT_TEST_DEFAULT_HASH=3Dsha256`. The test e=
xpects
    +    the resulting hash format of the empty cloned repository to match =
the
    +    default hash, but now we always end up with a sha1 repository. The
    +    problem is that for dumb HTTP fetches, we have no easy way to figu=
re out
    +    the remote's hash function except for deriving it based on the hash
    +    length of refs in `info/refs`. But as the remote repository is emp=
ty we
    +    cannot rely on this detection mechanism.
    +
    +    Before the change in this commit we already initialized the reposi=
tory
    +    with the default hash function and then left it as-is. With this p=
atch
    +    we always use the hash function detected via the remote, where we =
fall
    +    back to "sha1" in case we cannot detect it.
    +
    +    Neither the old nor the new behaviour are correct as we second-gue=
ss the
    +    remote hash function in both cases. But given that this is a rather
    +    unlikely edge case (we use the dumb HTTP protocol, the remote repo=
sitory
    +    uses SHA256 and the remote repository is empty), let's simply adap=
t the
    +    test to assert the new behaviour. If we want to properly address t=
his
    +    edge case in the future we will have to extend the dumb HTTP proto=
col so
    +    that we can properly detect the hash function for empty repositori=
es.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/clone.c ##
    @@ setup.h: int init_db(const char *git_dir, const char *real_git_dir,
     =20
      /*
       * NOTE NOTE NOTE!!
    +
    + ## t/t5550-http-fetch-dumb.sh ##
    +@@ t/t5550-http-fetch-dumb.sh: test_expect_success 'create empty remot=
e repository' '
    + 	setup_post_update_server_info_hook "$HTTPD_DOCUMENT_ROOT_PATH/empty.=
git"
    + '
    +=20
    +-test_expect_success 'empty dumb HTTP repository has default hash algo=
rithm' '
    ++test_expect_success 'empty dumb HTTP repository falls back to SHA1' '
    + 	test_when_finished "rm -fr clone-empty" &&
    + 	git clone $HTTPD_URL/dumb/empty.git clone-empty &&
    + 	git -C clone-empty rev-parse --show-object-format >empty-format &&
    +-	test "$(cat empty-format)" =3D "$(test_oid algo)"
    ++	test "$(cat empty-format)" =3D sha1
    + '
    +=20
    + setup_askpass_helper

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
--=20
2.43.GIT


--T1Esajs2S77ftWa7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BRQACgkQVbJhu7ck
PpTxkg//WPcJUeAwtd68TqP8NovSO0ZYQjBHxOgUNz1uP7+enohM2Oem701SIx1c
RJgYV+piJWH2G1AWIS5GFNXwhaZ4FJ+3YcbGtB14DhJ2fff+0+B6DOxQh7BoPoVB
twNQb/4sshKyPkFh5pb8YTmMsNi3w/opmYvijSu0CPq/+KFWaBMSdWL/TIGJEfGP
hp0BqXV4n4rg0ccoGB4YyZhNtU2Tvt1JmICp0K9xqphmas4AIa7FCr4vLYGtyrgD
lXHmVFMgZxd9Zg9lNodEtLwAN+IlIBfMLJTi987w3DfptOB24gL3iatYZJuWgk9a
y2J4UTa8HxsF6ik56HcCb4oTKBauKSPWKFMJv+E3BNKKQfvFjIhWmVLMQHIGb3KB
5V/uvi1RECLP+Inw1pdoTh91l4dbovhfoP/HeYzDdavFvBVsDSlyzxG0Wv8O/Nna
tEGA0oMS0PPEfNJL+lu3peTnUFOL6hwp5xQH12qLVZhVOTWPt1cFGsoYOLJI0mFb
sZechXwZ0KYTy4M+n4dRiCbR2H5pE2rjf45UhMapyZJh+DgFEa1NoPlxfPjMmk0R
YZw70Rbh97nz+Z9zHzJFi2Ujkqc12Rl7v35WSDmvMDKZ9sE2VzrOfbxBH4zO2OJD
vecHQdVHVMlGmNto4P2WpXef//vF+YoHyPTMkNbAFEERDzU4uGM=
=AeHh
-----END PGP SIGNATURE-----

--T1Esajs2S77ftWa7--
