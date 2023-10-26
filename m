Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D71CFB7
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DacffOrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffPL6p9m"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5D6CE
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:00:23 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 256913200A05
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 26 Oct 2023 04:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698307222; x=1698393622; bh=hh
	qsCkmkssUaVxhnbdy7UhmtShdrOMYWJ8lXQdQH9Uc=; b=DacffOrQtLOcUxCXAv
	nZu+KJBNbTA+aUkitY/DpJVv54HhTdbAGJbs4u26kAUzEYAot2EFlgq8EJIzkHLr
	UtouDjlFsc+0ftpadePr66DYHVcJUwICoaNCRz6ZZjRZ5jaIaFr4sbFkDJ0rlPnX
	WH8PrINV26fG1+W74o25L/zyVVJpM2kKc5pb6TiQwi/bALR4XiEx72WQ+RJ8fikg
	2o1dRCddU92yKqv7+kz9bOKU2rgvlCvExDCHaSg4RzMuIXMOfNIfq/amwy957oXi
	rPpGT4AGXw7dQ3Jsoe1wbHQBP+HXJwnOxO3JMw/2BVvdX+VqPuyiISSUQgVavmbd
	UpYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698307222; x=1698393622; bh=hhqsCkmkssUaV
	xhnbdy7UhmtShdrOMYWJ8lXQdQH9Uc=; b=ffPL6p9mjCdPOI4yDsi14g7R9Xu1E
	NcxzQi5Lqy9e+bCneFxrnhyrE4vTJ9xCXTMMWA4P/Y2lAxjU9UZzYHCNwO82I0eQ
	mskusImrLRMPRvPZhMCGOaNaaZeZIOUyWF0A2zGCCpf+JuFKEatKI5jzpJgQhdFd
	KZ3o0L6p4pepKfo9VmSaajR1yLV7nu3kiUnECa0NZIG6wVYyPDgs8d8Ew1qMX7Eg
	5h5eMWz/9hCpnpngU6gWPVDejdLOhc1TE9wcIPzwLVjmleBpNVWZ9AOsqkmlHLSz
	qAWk9V73vekAEGviSGgxL49H8HmS6myyMKA7IsFbj8VHxda63Njz5FzlQ==
X-ME-Sender: <xms:lhw6ZVrJYQUd3T2qSxg48lXdL-2TRzKiG_83FfnVHxS1Lb7t8A3QkQ>
    <xme:lhw6ZXqzdxjXsNLmQS4CUwFTVeRX__8hO1qPi-a1d1KHV-NNSjPpMC5mhAuye7X_Z
    Cpqg8cSnO4fdINahA>
X-ME-Received: <xmr:lhw6ZSNfDy5m8HIL3_k62ntAgPkgifjuZh1MtSB17CUof37ygjWYX0uQhpuuaUrnLM5zMTwvYNLHXNFE_RZk7qIPKNOfIU95JtjEgrLcSdYWzcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepjeejtdeigfegkefgjeehveevjeejveeuvd
    dtieekffevleeglefhgffgjeejfeefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:lhw6ZQ5gLL9UyTk8BL4PyIMPYpS5uyBGHT9WD91omAtN4SnjeX5KpA>
    <xmx:lhw6ZU4-XTGSfiTgTHmmXh-_SB082WpidxaAXBRLGUEA8XVSCFu4lA>
    <xmx:lhw6ZYg3fF_OTyDX_vK01X22IVP5nIfgC9CmnIZe1gx5UF77_4WgAw>
    <xmx:lhw6ZZUbTaZBLK68G3DKgjzMbBeulvj6h5SF0hA5qmzdWndEHiI1lQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d856c048 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 26 Oct 2023 08:00:13 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:00:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KTriI+80vC4YA3DG"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--KTriI+80vC4YA3DG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We already support Azure Pipelines and GitHub Workflows in the Git
project, but until now we do not have support for GitLab CI. While it is
arguably not in the interest of the Git project to maintain a ton of
different CI platforms, GitLab has recently ramped up its efforts and
tries to contribute to the Git project more regularly.

Part of a problem we hit at GitLab rather frequently is that our own,
custom CI setup we have is so different to the setup that the Git
project has. More esoteric jobs like "linux-TEST-vars" that also sets a
couple of environment variables do not exist in GitLab's custom CI
setup, and maintaining them to keep up with what Git does feels like
wasted time. The result is that we regularly send patch series upstream
that would otherwise fail to compile or pass tests in GitHub Workflows.
We would thus like to integrate the GitLab CI configuration into the Git
project to help us ensure to send better patch series upstream and thus
reduce overhead for the maintainer.

The integration does not necessarily have to be a first-class citizen,
which would in practice only add to the fallout that pipeline failures
have for the maintainer. That being said, we are happy to maintain this
alternative CI setup for the Git project and will make test results
available as part of our own mirror of the Git project at [1].

This commit introduces the integration into our regular CI scripts so
that most of the setup continues to be shared across all of the CI
solutions.

[1]: https://gitlab.com/gitlab-org/git

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml                    | 51 +++++++++++++++++++++++
 ci/install-docker-dependencies.sh |  9 +++-
 ci/lib.sh                         | 69 +++++++++++++++++++++++++++++++
 ci/print-test-failures.sh         |  6 +++
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 00000000000..43d3a961fa0
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,51 @@
+default:
+  timeout: 2h
+
+workflow:
+  rules:
+    - if: $CI_PIPELINE_SOURCE =3D=3D "merge_request_event"
+    - if: $CI_COMMIT_TAG
+    - if: $CI_COMMIT_REF_PROTECTED =3D=3D "true"
+
+test:
+  image: $image
+  before_script:
+    - ./ci/install-docker-dependencies.sh
+  script:
+    - useradd builder --home-dir "${CI_PROJECT_DIR}"
+    - chown -R builder "${CI_PROJECT_DIR}"
+    - sudo --preserve-env --set-home --user=3Dbuilder ./ci/run-build-and-t=
ests.sh
+  after_script:
+    - |
+      if test "$CI_JOB_STATUS" !=3D 'success'
+      then
+        sudo --preserve-env --set-home --user=3Dbuilder ./ci/print-test-fa=
ilures.sh
+      fi
+  parallel:
+    matrix:
+      - jobname: linux-sha256
+        image: ubuntu:latest
+        CC: clang
+      - jobname: linux-gcc
+        image: ubuntu:20.04
+        CC: gcc
+        CC_PACKAGE: gcc-8
+      - jobname: linux-TEST-vars
+        image: ubuntu:20.04
+        CC: gcc
+        CC_PACKAGE: gcc-8
+      - jobname: linux-gcc-default
+        image: ubuntu:latest
+        CC: gcc
+      - jobname: linux-leaks
+        image: ubuntu:latest
+        CC: gcc
+      - jobname: linux-asan-ubsan
+        image: ubuntu:latest
+        CC: clang
+      - jobname: linux-musl
+        image: alpine:latest
+  artifacts:
+    paths:
+      - t/failed-test-artifacts
+    when: on_failure
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index d0bc19d3bb3..1cd92db1876 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -7,6 +7,9 @@
=20
 begin_group "Install dependencies"
=20
+# Required so that apt doesn't wait for user input on certain packages.
+export DEBIAN_FRONTEND=3Dnoninteractive
+
 case "$jobname" in
 linux32)
 	linux32 --32bit i386 sh -c '
@@ -16,9 +19,13 @@ linux32)
 	'
 	;;
 linux-musl)
-	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+	apk add --update git shadow sudo build-base curl-dev openssl-dev expat-de=
v gettext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
 	;;
+linux-*)
+	apt update -q &&
+	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 libs=
sl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev perl-mod=
ules liberror-perl libauthen-sasl-perl libemail-valid-perl libio-socket-ssl=
-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}}
+	;;
 pedantic)
 	dnf -yq update >/dev/null &&
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
diff --git a/ci/lib.sh b/ci/lib.sh
index 33005854520..102e9d04a1f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -15,6 +15,42 @@ then
 		echo '::endgroup::' >&2
 	}
=20
+	group () {
+		set +x
+
+		group=3D"$1"
+		shift
+		begin_group "$group"
+
+		# work around `dash` not supporting `set -o pipefail`
+		(
+			"$@" 2>&1
+			echo $? >exit.status
+		) |
+		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 f=
ile=3D\2,line=3D\3::\1/'
+		res=3D$(cat exit.status)
+		rm exit.status
+
+		end_group "$group"
+		return $res
+	}
+elif test true =3D "$GITLAB_CI"
+then
+	begin_group () {
+		need_to_end_group=3Dt
+		echo -e "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K$1"
+		trap "end_group '$1'" EXIT
+		set -x
+	}
+
+	end_group () {
+		test -n "$need_to_end_group" || return 0
+		set +x
+		need_to_end_group=3D
+		echo -e "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K"
+		trap - EXIT
+	}
+
 	group () {
 		set +x
=20
@@ -209,6 +245,39 @@ then
 	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
 	test windows !=3D "$CI_OS_NAME" ||
 	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+elif test true =3D "$GITLAB_CI"
+then
+	CI_TYPE=3Dgitlab-ci
+	CI_BRANCH=3D"$CI_COMMIT_REF_NAME"
+	CI_COMMIT=3D"$CI_COMMIT_SHA"
+	case "$CI_JOB_IMAGE" in
+	macos-*)
+		CI_OS_NAME=3Dosx;;
+	alpine:*|ubuntu:*)
+		CI_OS_NAME=3Dlinux;;
+	*)
+		echo "Could not identify OS image" >&2
+		env >&2
+		exit 1
+		;;
+	esac
+	CI_REPO_SLUG=3D"$CI_PROJECT_PATH"
+	CI_JOB_ID=3D"$CI_JOB_ID"
+	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
+	DONT_SKIP_TAGS=3Dt
+	handle_failed_tests () {
+		create_failed_test_artifacts
+	}
+
+	cache_dir=3D"$HOME/none"
+
+	runs_on_pool=3D$(echo "$CI_JOB_IMAGE" | tr : -)
+
+	export GIT_PROVE_OPTS=3D"--timer --jobs $(nproc)"
+	export GIT_TEST_OPTS=3D"--verbose-log -x"
+	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$(nproc)"
+	test windows !=3D "$CI_OS_NAME" ||
+	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 57277eefcd0..c33ad4e3a22 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -51,6 +51,12 @@ do
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			continue
 			;;
+		gitlab-ci)
+			mkdir -p failed-test-artifacts
+			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
+			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+			continue
+			;;
 		*)
 			echo "Unhandled CI type: $CI_TYPE" >&2
 			exit 1
--=20
2.42.0


--KTriI+80vC4YA3DG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6HJMACgkQVbJhu7ck
PpTbNQ//TF5sF7/BANZ/P1pecyy0KTjdwN+gPnCkf4iydsAYJ/pA0zBBLkHzOwb+
mYN2Xz0+A9KBQDAPuCeQApIRotSIi18+dDlvpFtYLrL2G45BBucJeYRQjcqQunBL
5sWDe5SnuOWXh4SgNVnmXdDgGO/XOYG+gVIchHkiZmJqNdqAxpK9nh7h2oIsm7KN
+UhgecK1m2c3hQ3i012+LPCe7cN2INGW9kRVNUf8G0ukTExTzx9IGHqBwkSwo0NT
PXFSkkBFfshVH/QA/t6XBP4sxBDDOGyu9yZPq2h5/Gmsga3OITgFA2B4MrlmmbO/
WmI4UKUbKRnE5mYJAdEovB88xk4hcfsl625sr9FNVf3gxkXwHreLcFg/9xdF/ntH
K2SvkRM7coI4crRQfBu2dQom5kIqLTJKw3mJBdb8CKvQfvpBDpJh2l7ZF8CEL4FY
uACImCsefheXPK7yzGmiUYvf38Yvl+C8uGxeWDF83YvpY3MoJU1b15sGQiQ0zXuI
oPYtN8uPVq7KH07+ZptoZ5sFTnhRZodvwA29fQGCarjfHK4prqZ7kNhuA+6nuy0M
uriHfZfvqC8KIBgyvctQ+yCt6vdl62XlS/5rqGiFmIQYdbT5BuGeMpJm92F0yeCl
14MZtyH0doCFaLG1b0JuJCG/nRohZB8HlVZg9/mjV3YG44WQ3nQ=
=serX
-----END PGP SIGNATURE-----

--KTriI+80vC4YA3DG--
