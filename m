Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91C15E8C
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HwKZeQXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LcEjOIv6"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBCDD6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:15:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 8E86C320093A;
	Mon, 30 Oct 2023 08:15:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 30 Oct 2023 08:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668118; x=1698754518; bh=ju
	aHphGLcO+NQUb6XYg+mtkW09uSuNdCY1Kf0c0RZUk=; b=HwKZeQXfZj1tSeQxbE
	3zjakhqRcnBs1XwM2FLxzFL8iKPyHE4TCWtOuQcZakjAsX+lIq/s4PCt1+4RlOEY
	GTzzYSbm7teeYNTFkwUxVpf8n5KmDfoXSFGCOZo1x93ozTn8HvHP5DXDYity8XC+
	pFNeA1zwjHTlXjXGhAbH5TNlvyrvVgnSG1Bu9aud9Y0+5Hnvb+7opXfPNHK73PjL
	Tb17x+rrlSlkoDYs2bIaYN2LPgmRLBs/GT1+37N5GqCPHi+WKU3OBRVXzXw3ltvH
	NS/tBjrMlIdoayQU2uEEwTPrB/xqgfT2oHYN3JlgDev5HpeGFKClf83q7FZ3XBp8
	pexQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668118; x=1698754518; bh=juaHphGLcO+NQ
	Ub6XYg+mtkW09uSuNdCY1Kf0c0RZUk=; b=LcEjOIv63eP43kVdlQQR650TZdCuN
	rB7lR/Dh8on9Tg1QHn6peNH6EOO6ZfkuOs25VsHrQQmPZIYfRQquZYOUaX5TiROv
	5SFB8GpUhgGgQE1LUk0wZW+kloMoXHr16mhya3uuSE+TulqthJL+gKFvQbAV2f5r
	xITqt/3p1sAn09zvAfgF0HBr5f8rGNy9inpp9zYKyGvQOq1szz0R/sHXdenklgM7
	jU056dH5v/eP+xV7CZsRQ9iqFYGiJz8P0nEqDBBCcmatgZbI5nj9pPwsHy/IUEBb
	ptFE5L0/vIT4g72QVN/poqXcri7kLOVMIkCk6isqFvqbqtbZD1r+iFIeQ==
X-ME-Sender: <xms:VZ4_ZSDo2eOkOgV4_9TjaQExuSMlbRxdDElrmkaIaFLAZbXYQbnouA>
    <xme:VZ4_Zcixys85xLaawuQ7vMxkWf61qK0bJtT1Fo3hrkOsJGhuRZve8A37-gnehQ2aP
    OCoyBbzCFB2g36psg>
X-ME-Received: <xmr:VZ4_ZVm6x-AW7t1_ezF3uASWSbUnwWijJcE0VXgPlTGoCxCEv5woO842N38a5WnTUGjs9wURSqZtEW0LYQ9LJA1_YY-ZylyNrip71sK0a9hupw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheplefgiedtffekvdetffegudeuvdfftdffheetfeelffevvdffhedvffegleeggeei
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VZ4_ZQy6ZWMBkuoTzh559pzs1NEHTTPB-LCdAP7nvd-otyTBrAHPEw>
    <xmx:VZ4_ZXTDyt5-h1CzkASColi7AW23yJ8t-88b1JfFVPWj8LYnTOQlgQ>
    <xmx:VZ4_ZbYMxk8gNgpTIAyW-bcPII-D9tFqaBVgNWAKGiqd8GTam4ixSg>
    <xmx:Vp4_ZSdLF7C0wUEG0vWEKmpITdhzrtxjyAkDabsmd88fbcJ0KRYovA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:15:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fdd663ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:15:10 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:15:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 8/8] ci: add support for GitLab CI
Message-ID: <5272d66d9f138987def342ff7661515b845318bb.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4YHkfFs/TuCMCs05"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--4YHkfFs/TuCMCs05
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
project has. More esoteric jobs like "linux-TEST-vars" that also set a
couple of environment variables do not exist in GitLab's custom CI
setup, and maintaining them to keep up with what Git does feels like
wasted time. The result is that we regularly send patch series upstream
that fail to compile or pass tests in GitHub Workflows. We would thus
like to integrate the GitLab CI configuration into the Git project to
help us send better patch series upstream and thus reduce overhead for
the maintainer.

The integration does not necessarily have to be a first-class citizen,
which would in practice only add to the fallout that pipeline failures
have for the maintainer. That being said, we are happy to maintain this
alternative CI setup for the Git project and will make test results
available as part of our own mirror of the Git project at [1].

This commit introduces the integration into our regular CI scripts so
that most of the setup continues to be shared across all of the CI
solutions. Note that as the builds on GitLab CI run as unprivileged
user, we need to pull in both sudo and shadow packages to our Alpine
based job to set this up.

[1]: https://gitlab.com/gitlab-org/git

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml                    | 53 +++++++++++++++++++++++++++++++
 ci/install-docker-dependencies.sh | 13 +++++++-
 ci/lib.sh                         | 43 +++++++++++++++++++++++++
 ci/print-test-failures.sh         |  6 ++++
 4 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 00000000000..cd98bcb18aa
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,53 @@
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
+    - useradd builder --create-home
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
+      - jobname: pedantic
+        image: fedora:latest
+      - jobname: linux-musl
+        image: alpine:latest
+  artifacts:
+    paths:
+      - t/failed-test-artifacts
+    when: on_failure
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 05dde5c5d40..5e28adf55b6 100755
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
@@ -16,10 +19,18 @@ linux32)
 	'
 	;;
 linux-musl)
-	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
 	;;
+linux-*)
+	apt update -q &&
+	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 libs=
sl-dev \
+		libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev \
+		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
+		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACK=
AGE:-${CC:-gcc}} \
+		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
+	;;
 pedantic)
 	dnf -yq update >/dev/null &&
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
diff --git a/ci/lib.sh b/ci/lib.sh
index c13b6527cac..d836fad7dd6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -14,6 +14,22 @@ then
 		need_to_end_group=3D
 		echo '::endgroup::' >&2
 	}
+elif test true =3D "$GITLAB_CI"
+then
+	begin_group () {
+		need_to_end_group=3Dt
+		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K$1\=
n"
+		trap "end_group '$1'" EXIT
+		set -x
+	}
+
+	end_group () {
+		test -n "$need_to_end_group" || return 0
+		set +x
+		need_to_end_group=3D
+		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
+		trap - EXIT
+	}
 else
 	begin_group () { :; }
 	end_group () { :; }
@@ -227,6 +243,33 @@ then
 	cache_dir=3D"$HOME/none"
=20
 	GIT_TEST_OPTS=3D"--github-workflow-markup"
+elif test true =3D "$GITLAB_CI"
+then
+	CI_TYPE=3Dgitlab-ci
+	CI_BRANCH=3D"$CI_COMMIT_REF_NAME"
+	CI_COMMIT=3D"$CI_COMMIT_SHA"
+	case "$CI_JOB_IMAGE" in
+	macos-*)
+		CI_OS_NAME=3Dosx;;
+	alpine:*|fedora:*|ubuntu:*)
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


--4YHkfFs/TuCMCs05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/nlEACgkQVbJhu7ck
PpS+gQ//UGoZpfJuvSvaSv4AobO9Tjr17B3uuVfiTkKLire+veI0+W9X4mfN5FB0
GaRqNW+hnozcd2bMpRRkApOvFB81tnNTC1wDwO724uE0S2uoV1K1PD0OOOGAQGub
Tvbsuv9+XA0+HdXU4vqlgiU1vyUZxDcU2POP526Pdx2nJBN6iA8SHeRgDzUwnoYY
43E4U44hnfvI6PY6N5SPGeyyk22OsT2H9GJb9ln1JTXjoNA2T6vSBD7OyJ7wLD50
QaQhzMZKNX8di43tcZY/Ars0Hrhi9elITv6CJ4kF5hRFi3ys3eQ5KoAkF2Jk1ksb
meCmCZLL+vxayy8psZI29gAGpMvmRmyBdGL6HfpcecbKbnLM3HriNf53JBzZl3PD
K3rPSeLo94clMt5YBKNXd2ocdEAbPXu8BeeZ/c2oslg889ApFIDrI6DNuZ3kt0hV
1HYMBmZq7Sk3fxOV/6j8JRXXnWLw9ZHyAWlF4YLyuQKWXuaTtdpbNgW2R+XS1w1A
0N3sM5fsb60Rl6+6c62uFp169zC4Qxca9qAl6enlez3RzaM7GMduo4t5bKZTAyZ+
wz30ivyHyRb1YoMAaDwFGMEYkvC7d4DuuywQpMdl1JsJtzBC0laRwSV2Rig5VBrR
3KB0EUQnRXzDHqfgq8Oc6O62UQTXoTP/3yLF/AWaRSLSU1huk3M=
=uKtl
-----END PGP SIGNATURE-----

--4YHkfFs/TuCMCs05--
