Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC2C12B93
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xbpeTej6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOHlTbAp"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05DFC
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:02:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 42A525C0269;
	Wed,  1 Nov 2023 09:02:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 09:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843763; x=1698930163; bh=sM
	l7EUUPZ4Jc8BLwXaFM2/NCdSPhA4clsrRIt/962ws=; b=xbpeTej63h7XEo5QNc
	W0pHK3MdAB8fNEFyLvJtyMVAGTd8zdRE/1CwHEgSJ3UQWWyykuazxmSAA5zU/pT8
	kV79kcgCSSbFmgRu9n8QeRsK0c+tDUwnnKb5WkeR6nm3fITU56AqcKHq7ylzjjEq
	/1pO64GAEIVTn9+ALoaFR3qqBaAHU16fo88UjxqP8HquKQzQ4ihlcW8W7RUJT5ir
	DDn9iY09h2TP8sGdnKOnE9sM2dnNuglTuyo2LnDTjoYVXHGADz8I+HMgeHH1L7aT
	CmNJlx9BkSnlFX07GRGWwRL5STKpKbgV7VwnniP+a4+7PaB4mszoXZjFcIDbHfFB
	+k5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843763; x=1698930163; bh=sMl7EUUPZ4Jc8
	BLwXaFM2/NCdSPhA4clsrRIt/962ws=; b=BOHlTbAp+CNcgrYlU5j9FEOlDC5T8
	EBZE2gXArDJ2SOXej/EFhI0YuwKuzB+DPenquwfn3eLPwVwGV/5YoFhS8BUf4/nN
	RbgC2oIdwHEOqj7KRZVtGLSpV3c10eKiYRo82SVtLlrPKzGS5gMZz76kIxIpsFpG
	4d6dJ12Esc7UNSG0yLOShc/CPjBTC4P73icgdtlsCcFBJyJxRXw6Dm1HOItPXZC1
	8uSpGJcxqBiOp/iT7uKagAYXN4YD8K6SB/G80Am+3P+8kIGixCDcFVZ1ZhFG1Ugv
	cwLWW7N7Z50W5zbAXG79PGOsIjnKGLG4t0rxH8iKWE95NQO7W9FehvugQ==
X-ME-Sender: <xms:ckxCZRkIspHC0wIO661B657rACxDAcyb_iOECk7kMAcMRu3oyxXacA>
    <xme:ckxCZc0EFmlQzsFcjUvlxfsUUHq32oJ3_EQzMk0K9yETYAXM7qbXXZU-py1IBxjH8
    dPq2vDm9MDQIcoJgg>
X-ME-Received: <xmr:ckxCZXqRDLHbqIgEDBDhVsGt7sWQCuBPen2XLcjFFy9AIK_yXjF4qmYEcrHCwx3zdVsiwDmVhFcONeGymvU0QQjq1BDh7ZU3S8oje0mfHbMiUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveehueevvdffvdegkeeiffeuieevjeeliefffeeigedvudehudelgedujeefiedu
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhdphhhtthhpugdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:c0xCZRn5aNovTs-YuLDnd2DUyhRbUSXb5QB7y_-WkPsDi7z4iKm0Vg>
    <xmx:c0xCZf1JztvheFiFYdWqpvvQe6zzF_gUDoLt2F9lOb5k20zb6mDUHQ>
    <xmx:c0xCZQtrcQm7zSPvApLeXTZXzu-pN4_KVz0cgYldunYgY3ntB2mfkQ>
    <xmx:c0xCZaRnTXR4qOeOT6fzk8Lb3WMPQWN6AwiKgm7vOmnpaXbIGMnD4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:02:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c520733 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:30 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:02:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 0/8] ci: add support for GitLab CI
Message-ID: <cover.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CCBejo7OWC2qamkQ"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--CCBejo7OWC2qamkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my patch series that introduces support for
GitLab CI.

There are only minor changes compared to v4:

    - Patch 5: Fixed a typo in the commit message. Furthermore, I've
      dropped the note about `export VAR=3Dvalue` being a Bashism.

    - Patch 5: Fixed the accidentally-dropped "windows_nt" case.

    - Patch 5: Introduce the JOBS variable right away so that there is
      less churn in the patch that introduces GitLab CI.

    - Patch 8: Moved `DEBIAN_FRONTEND` into the "linux-*" case to make
      clear that it shouldn't impact anything else.

    - Patch 8: Dropped the paragraph about GitLab CI not being a first
      class citizen based on Junio's feedback. This setup is going to be
      actively used (at least) by us at GitLab, and thus we're also
      going to maintain it.

After both Junio's and Victoria's feedback I've kept `.gitlab-ci.yml` in
its canonical location.

The pipeline for this version can be found at [1].

Thanks for all the discussion and feedback so far!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/pipelines/1057566736

Patrick Steinhardt (8):
  ci: reorder definitions for grouping functions
  ci: make grouping setup more generic
  ci: group installation of Docker dependencies
  ci: split out logic to set up failed test artifacts
  ci: unify setup of some environment variables
  ci: squelch warnings when testing with unusable Git repo
  ci: install test dependencies for linux-musl
  ci: add support for GitLab CI

 .gitlab-ci.yml                    |  53 +++++++++
 ci/install-docker-dependencies.sh |  23 +++-
 ci/lib.sh                         | 191 +++++++++++++++++++++---------
 ci/print-test-failures.sh         |   6 +
 t/lib-httpd.sh                    |  17 ++-
 5 files changed, 234 insertions(+), 56 deletions(-)
 create mode 100644 .gitlab-ci.yml

Range-diff against v4:
1:  8595fe5016a =3D 1:  0ba396f2a33 ci: reorder definitions for grouping fu=
nctions
2:  7358a943392 =3D 2:  821cfcd6125 ci: make grouping setup more generic
3:  6d842592c6f =3D 3:  6e5bcf143c8 ci: group installation of Docker depend=
encies
4:  e15651b3f5d =3D 4:  2182acf5bfc ci: split out logic to set up failed te=
st artifacts
5:  a64799b6e25 ! 5:  6078aea246d ci: unify setup of some environment varia=
bles
    @@ Metadata
      ## Commit message ##
         ci: unify setup of some environment variables
    =20
    -    Both GitHub Actions and Azue Pipelines set up the environment vari=
ables
    +    Both GitHub Actions and Azure Pipelines set up the environment var=
iables
         GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values=
 are
         actually the same, the setup is completely duplicate. With the upc=
oming
         support for GitLab CI this duplication would only extend even furt=
her.
    @@ Commit message
               `--no-bin-wrappers`. Interestingly though, we did so _after_
               already having exported the respective environment variables.
    =20
    -        - We stop using `export VAR=3Dvalue` syntax, which is a Bashis=
m. It's
    -          not quite worth it as we still use this syntax all over the =
place,
    -          but it doesn't hurt readability either.
    -
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## ci/lib.sh ##
    @@ ci/lib.sh: then
     -	test windows_nt !=3D "$CI_OS_NAME" ||
     -	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
     +	GIT_TEST_OPTS=3D"--write-junit-xml"
    ++	JOBS=3D10
      elif test true =3D "$GITHUB_ACTIONS"
      then
      	CI_TYPE=3Dgithub-actions
    @@ ci/lib.sh: then
     -	test windows !=3D "$CI_OS_NAME" ||
     -	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
     +	GIT_TEST_OPTS=3D"--github-workflow-markup"
    ++	JOBS=3D10
      else
      	echo "Could not identify CI type" >&2
      	env >&2
      	exit 1
      fi
     =20
    -+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
    -+GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
    ++MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$JOBS"
    ++GIT_PROVE_OPTS=3D"--timer --jobs $JOBS --state=3Dfailed,slow,save"
     +
     +GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
    -+if test windows =3D "$CI_OS_NAME"
    -+then
    ++case "$CI_OS_NAME" in
    ++windows|windows_nt)
     +	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
    -+fi
    ++	;;
    ++esac
     +
     +export GIT_TEST_OPTS
     +export GIT_PROVE_OPTS
6:  f7d2a8666fe =3D 6:  d69bde92f2f ci: squelch warnings when testing with =
unusable Git repo
7:  9b43b0d90e3 =3D 7:  b911c005bae ci: install test dependencies for linux=
-musl
8:  f3f2c98a0dc ! 8:  5784d03a6f1 ci: add support for GitLab CI
    @@ Commit message
         that fail to compile or pass tests in GitHub Workflows. We would t=
hus
         like to integrate the GitLab CI configuration into the Git project=
 to
         help us send better patch series upstream and thus reduce overhead=
 for
    -    the maintainer.
    -
    -    The integration does not necessarily have to be a first-class citi=
zen,
    -    which would in practice only add to the fallout that pipeline fail=
ures
    -    have for the maintainer. That being said, we are happy to maintain=
 this
    -    alternative CI setup for the Git project and will make test results
    -    available as part of our own mirror of the Git project at [1].
    +    the maintainer. Results of these pipeline runs will be made availa=
ble
    +    (at least) in GitLab's mirror of the Git project at [1].
    =20
         This commit introduces the integration into our regular CI scripts=
 so
         that most of the setup continues to be shared across all of the CI
    @@ .gitlab-ci.yml (new)
     +    when: on_failure
    =20
      ## ci/install-docker-dependencies.sh ##
    -@@
    -=20
    - begin_group "Install dependencies"
    -=20
    -+# Required so that apt doesn't wait for user input on certain package=
s.
    -+export DEBIAN_FRONTEND=3Dnoninteractive
    -+
    - case "$jobname" in
    - linux32)
    - 	linux32 --32bit i386 sh -c '
     @@ ci/install-docker-dependencies.sh: linux32)
      	'
      	;;
    @@ ci/install-docker-dependencies.sh: linux32)
      		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
      	;;
     +linux-*)
    ++	# Required so that apt doesn't wait for user input on certain packag=
es.
    ++	export DEBIAN_FRONTEND=3Dnoninteractive
    ++
     +	apt update -q &&
     +	apt install -q -y sudo git make language-pack-is libsvn-perl apache2=
 libssl-dev \
     +		libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev \
    @@ ci/lib.sh: then
      	begin_group () { :; }
      	end_group () { :; }
     @@ ci/lib.sh: then
    - 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
    -=20
    - 	GIT_TEST_OPTS=3D"--write-junit-xml"
    -+	JOBS=3D10
    - elif test true =3D "$GITHUB_ACTIONS"
    - then
    - 	CI_TYPE=3Dgithub-actions
    -@@ ci/lib.sh: then
    - 	cache_dir=3D"$HOME/none"
     =20
      	GIT_TEST_OPTS=3D"--github-workflow-markup"
    -+	JOBS=3D10
    + 	JOBS=3D10
     +elif test true =3D "$GITLAB_CI"
     +then
     +	CI_TYPE=3Dgitlab-ci
    @@ ci/lib.sh: then
      else
      	echo "Could not identify CI type" >&2
      	env >&2
    - 	exit 1
    - fi
    -=20
    --MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
    --GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
    -+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D${JOBS}"
    -+GIT_PROVE_OPTS=3D"--timer --jobs ${JOBS} --state=3Dfailed,slow,save"
    -=20
    - GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
    - if test windows =3D "$CI_OS_NAME"
    =20
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: do

base-commit: 692be87cbba55e8488f805d236f2ad50483bd7d5
--=20
2.42.0


--CCBejo7OWC2qamkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTG0ACgkQVbJhu7ck
PpQVKg//SUuIFQm1XloWo/LS/fagRqEXPCU0C76VX5B61f8DdGww/FWbf72DiZlf
usVf2q9Aoxwcux/6h0qBK2bZmSUHB4esbXlnsAOLuiT1PA2D8vzIlPzT2FU732au
wacF01xIEQ3oZYIriu5+57lp0PCKuF3ej8keX07SmgIm3dqwyTRgzdgZfwUl9z/G
hZBbYR+AnHfj6fnMtSlz+jxnaD1qWmyd/cJ0w1ZbkR31VaeL2ux8iI7gChot3pm8
U04aBpTle8IuYzPIw6Z9YIdxVQVMn41beXpzGMTdg+550kNp2kjFO2EqBQei9nIu
v2pfjn8mMyROUicJNBDL7jGsWCNusRnPExONKz9wyYmErnKIaB4qadYI0ymvFddS
PZmUFlRQ64z2xsmkmxiI2vAYn6PTm10UEGAOIL8Z/jmk0qG84dpvo8OkAqtPV7+8
BzPsFOoyPGLKOcNfuf0cz8WIkY3J0TJf+pxGgfXTnUgeFWXP+fm4K/QLI2nbkeHt
3XBlTdzhdWPIFKElmFFO8mqVSagwYWXsyfqfddmM2IJ3iNN67Ea2+m6glz/XXPhi
QVpPCwYnN7Gc7T/bvzRhEnU8khy4hKcIB/bBWZ/Bqoc24GoLmkp79GTwW94nO9rn
iISYJU5+ztqL9s5na/aozEGmkI7eR8nTRALtCNNusJv4u/jSHS8=
=8LeU
-----END PGP SIGNATURE-----

--CCBejo7OWC2qamkQ--
