Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131815488
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XT7z2RDg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="USXVS0rL"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E046A2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:14:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 26C283200944;
	Mon, 30 Oct 2023 08:14:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 30 Oct 2023 08:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668083; x=1698754483; bh=Sn
	NT2KLTnZ387Hy2mBe5906+U+NjPZ+UIM4tWuUXxZg=; b=XT7z2RDgcfsIqy+MvY
	POKiXdtktDQ+D428PXtvJydokSRmDOKD67H3pO7VWfZM3vBL8uxlgE7JoQyTX85u
	3RdR9yAsIU0azCASre3Suva8wcJSd42SkFQ7wJA2y22+NkgeC1W3anqIs4/Qzlkp
	rAU0Gm+bLrTULNVtjpPOQXWO0CaOtod7H0GWj2zv5x2x3lOEe/347xii1/LB7VOb
	73VyiGyb10HLHKGPnkZW4rlDNev3BwdT8A9UEYqpgq74eAjNjkOuCYhHy9k2wR4Q
	g1IVTusdtV0slt2TrAKMz7+uECoXkZ9VbPJ3pnM/OkUMpfybX5Qto5kh2N+oS+UG
	nRtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668083; x=1698754483; bh=SnNT2KLTnZ387
	Hy2mBe5906+U+NjPZ+UIM4tWuUXxZg=; b=USXVS0rLRASEGTM/MjfRepUiR+Otr
	xaO0419eG59RFYYUgVCPVbdTm49Uznj9QmOhIF+Zask2Pqz1iKNqpS5i2zvx/q/X
	2UcjGkNKWaAz25cSXiEhVCbFONT8qSfSw2wLYZYNQxYY/r7TB6uRstb8vfuI/qa2
	pHKKNMT7x+u3/WEM7XTCdrZ80voPuUNa17kKiSkazie4Gs8KmGu5yarmsdCEhzXA
	KSRpecPsSHMbmdml24vhidI0/jgPD6Et/zV5XvewRXxxwWehgTpVVpE5XclrNolL
	ZGWbaCFHnp7quXd+fGptIq9P6QMyoHn103jiXRlSfHeki7NDd0QZu522Q==
X-ME-Sender: <xms:M54_ZXLqDXLNoL7qR0k_RIClP32YGpX7qfZFSpZWOf3jw50Xfkd0Pw>
    <xme:M54_ZbJanVVgKifDEEZsxAkvsTdTPBzis5zeGRq4tZpLnZw_dpuue61zBsWglsqaf
    oOfaj80ZoAFHLgkwQ>
X-ME-Received: <xmr:M54_Zfvh88LWr_5ZekuvlOaZjeROS_uTSUFJ3ftFr8xylD-foP-6CzrkiqNB0Db1at7iCFKaiqewRPLBZwLcHkvKhgrzri8A-iBg53NevxKjwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueejteeihfevtdekueevtdfhfedvudffvefhtedtgeeukeegheelffehkeehveej
    necuffhomhgrihhnpehpkhhsrdhimhdpghhithhlrggsrdgtohhmpdhhthhtphgurdhshh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:M54_ZQYmJmHDTWm477j1IYv9ZzamwSMMg15Ds3AJZ1rilxUFv0cYcQ>
    <xmx:M54_ZeZYMyFxAo9vSH4w_61Qo-Axv8YyBVYj0oCF8Yh6ShQ-pAxxwg>
    <xmx:M54_ZUAaqi0kVVjA3clm2wLmo59qaaFTx2bOqnNLoGHiXnvGqM6Stg>
    <xmx:M54_Zdlc3puU3zdRGh-XzLapnIi0mhG2RWqEzJwJ_0sT60MBn73z-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:14:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca649784 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:14:35 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:14:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 0/8] ci: add GitLab CI definition
Message-ID: <cover.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EalOdrbiuwdjmJE8"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--EalOdrbiuwdjmJE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of this patch series that adds GitLab CI
definitions to the Git project. Please refer to the cover letter for v1
of this series [1] for the motivation and intent -- I won't repeat it
here as it's a bit on the longer side.

Changes compared to v2:

    - Patch 5: This is a new preparatory step to unify the setup of some
      environment variables. It also fixes some smallish issues, like
      e.g. the fact that some envvars were set _after_ the export.

    - Patch 6: Another new preparatory step. It makes our infra around
      certain helper functions that have the intent to interact with the
      project repository, e.g. to cache good trees. We now detect the
      case when there is no Git or when the project is not a Git repo
      and bail out gracefully.

    - Patch 7: The last new preparatory patch. Installs a bunch of
      dependencies which are required for the test runtime in the Alpine
      based job. This increases test coverage.

    - Patch 8: Several smaller improvements:
        - Added a note why we install sudo and shadow in linux-musl now.
        - Fixed an issue where the HOME directory was part of the
          project directory, and thus Git complained about newly added
          untracked files.
        - Added the "pedantic" job that does a pednatic compilation on
          Fedora.
        - Added more test time dependencies.
        - Made the "echo -e" invocation portable by using printf
          instead.

What I didn't address yet is a suggestion by Phillip, namely to unify
the logic that sets up unprivileged builds. I don't have the infra
available to test any such change that would ultimately also impact
GitHub Workflows and Azure Pipelines and thus do not feel comfortable
to refactor this. I agree with the suggestion though, so I propose to
rather handle it at a later point in time.

A test run of this patch series can be found at [2].

Thanks!

Patrick

[1]: <cover.1698305961.git.ps@pks.im>
[2]: https://gitlab.com/gitlab-org/git/-/pipelines/1054750795

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
 ci/install-docker-dependencies.sh |  22 +++-
 ci/lib.sh                         | 187 +++++++++++++++++++++---------
 ci/print-test-failures.sh         |   6 +
 t/lib-httpd.sh                    |   3 +-
 5 files changed, 215 insertions(+), 56 deletions(-)
 create mode 100644 .gitlab-ci.yml

Range-diff against v2:
1:  4eb9cfc816b =3D 1:  ef44ed5c3b1 ci: reorder definitions for grouping fu=
nctions
2:  85617ef8577 =3D 2:  77798fa7a7a ci: make grouping setup more generic
3:  57bbc50e3dc =3D 3:  4542bd38dc2 ci: group installation of Docker depend=
encies
4:  5ab11d5236d =3D 4:  5fdda7fd83f ci: split out logic to set up failed te=
st artifacts
-:  ----------- > 5:  6af0075fd87 ci: unify setup of some environment varia=
bles
-:  ----------- > 6:  78d863bf24e ci: squelch warnings when testing with un=
usable Git repo
-:  ----------- > 7:  f150d61a1ce ci: install test dependencies for linux-m=
usl
5:  37a507e9b25 ! 8:  5272d66d9f1 ci: add support for GitLab CI
    @@ Commit message
    =20
         This commit introduces the integration into our regular CI scripts=
 so
         that most of the setup continues to be shared across all of the CI
    -    solutions.
    +    solutions. Note that as the builds on GitLab CI run as unprivileged
    +    user, we need to pull in both sudo and shadow packages to our Alpi=
ne
    +    based job to set this up.
    =20
         [1]: https://gitlab.com/gitlab-org/git
    =20
    @@ .gitlab-ci.yml (new)
     +  before_script:
     +    - ./ci/install-docker-dependencies.sh
     +  script:
    -+    - useradd builder --home-dir "${CI_PROJECT_DIR}"
    ++    - useradd builder --create-home
     +    - chown -R builder "${CI_PROJECT_DIR}"
     +    - sudo --preserve-env --set-home --user=3Dbuilder ./ci/run-build-=
and-tests.sh
     +  after_script:
    @@ .gitlab-ci.yml (new)
     +      - jobname: linux-asan-ubsan
     +        image: ubuntu:latest
     +        CC: clang
    ++      - jobname: pedantic
    ++        image: fedora:latest
     +      - jobname: linux-musl
     +        image: alpine:latest
     +  artifacts:
    @@ ci/install-docker-dependencies.sh: linux32)
      	;;
      linux-musl)
     -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
    -+	apk add --update git shadow sudo build-base curl-dev openssl-dev exp=
at-dev gettext \
    - 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
    ++	apk add --update shadow sudo build-base curl-dev openssl-dev expat-d=
ev gettext \
    + 		pcre2-dev python3 musl-libintl perl-utils ncurses \
    + 		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
      	;;
     +linux-*)
     +	apt update -q &&
    -+	apt install -q -y sudo git make language-pack-is libsvn-perl apache2=
 libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev per=
l-modules liberror-perl libauthen-sasl-perl libemail-valid-perl libio-socke=
t-ssl-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}}
    ++	apt install -q -y sudo git make language-pack-is libsvn-perl apache2=
 libssl-dev \
    ++		libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev \
    ++		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
    ++		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC=
_PACKAGE:-${CC:-gcc}} \
    ++		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
     +	;;
      pedantic)
      	dnf -yq update >/dev/null &&
    @@ ci/lib.sh: then
     +then
     +	begin_group () {
     +		need_to_end_group=3Dt
    -+		echo -e "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e=
[0K$1"
    ++		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[=
0K$1\n"
     +		trap "end_group '$1'" EXIT
     +		set -x
     +	}
    @@ ci/lib.sh: then
     +		test -n "$need_to_end_group" || return 0
     +		set +x
     +		need_to_end_group=3D
    -+		echo -e "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0=
K"
    ++		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K=
\n"
     +		trap - EXIT
     +	}
      else
      	begin_group () { :; }
      	end_group () { :; }
     @@ ci/lib.sh: then
    - 	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
    - 	test windows !=3D "$CI_OS_NAME" ||
    - 	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    + 	cache_dir=3D"$HOME/none"
    +=20
    + 	GIT_TEST_OPTS=3D"--github-workflow-markup"
     +elif test true =3D "$GITLAB_CI"
     +then
     +	CI_TYPE=3Dgitlab-ci
    @@ ci/lib.sh: then
     +	case "$CI_JOB_IMAGE" in
     +	macos-*)
     +		CI_OS_NAME=3Dosx;;
    -+	alpine:*|ubuntu:*)
    ++	alpine:*|fedora:*|ubuntu:*)
     +		CI_OS_NAME=3Dlinux;;
     +	*)
     +		echo "Could not identify OS image" >&2
    @@ ci/lib.sh: then
     +	cache_dir=3D"$HOME/none"
     +
     +	runs_on_pool=3D$(echo "$CI_JOB_IMAGE" | tr : -)
    -+
    -+	export GIT_PROVE_OPTS=3D"--timer --jobs $(nproc)"
    -+	export GIT_TEST_OPTS=3D"--verbose-log -x"
    -+	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$(nproc)"
    -+	test windows !=3D "$CI_OS_NAME" ||
    -+	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
      else
      	echo "Could not identify CI type" >&2
      	env >&2
--=20
2.42.0


--EalOdrbiuwdjmJE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/nikACgkQVbJhu7ck
PpSBRBAAkbUsra57qNJKaej/dJutw7DRY40bD9ZgMZp9QPy2iJC2PdxhHSXbJT3A
expd31q6WuOHV5VxbPL5k8jhdvSIaCAjoG51MeEQex2B0ocP2OObw3Ic3TipUwh8
vlLNtJriUwUIB7Mr1SjDIR4VMWJ+auuBu8ZnZH5MtZsJYUSteOs3nRfj+1efHg6l
7r2ZtInC7+gXmVsqNcwzY0uhh0adWIlli/112x3fgV6omMtVC5YNLW+zS/jaYh9l
WeQow0AZPKdA65nrCnWjZsqKRsB1YDpcizoD+Bq/s6fq1iJKuFPU0MQeqiWmXTiR
WXe+5SCEhe3eWhFlzl/XQ5EPD8nXlusg0N3ekS0VqWvYSxiLuC44VfhsH4xIYI+o
4Pqs37iCAoxGXh+BF91Vu5cU+w3WpCaGmY3brXj73k/ltDNRYI78RcN+0Y3T9+QG
vkG/WI9TYx4uaGtF+oBpQfixLl27cq7Onkh/T3o2sF2gmgUYZRm9rkfLTdRvv+/h
aFCQx+q5FPzqg1RFIcAed/BPsjbH1bhhT6BDZ7pWWYwVaPBl/0/Of8mP/xd/W+Pz
9KfT4JPo8h8YHAgovecuLfumz5/BLZVn4RN2KfuXWDjrW/cjuH5sNcT2x7bwhAXh
npmqtz2o+hnEw0nZNqfVyJBiZ5qZgZBaldFJNqIpKDpFL3DIoqY=
=SI2M
-----END PGP SIGNATURE-----

--EalOdrbiuwdjmJE8--
