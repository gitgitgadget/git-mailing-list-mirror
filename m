Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786B12B90
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bUdsu7+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLgrnniB"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609EA6
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:03:18 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id BFA8A5C01B9;
	Wed,  1 Nov 2023 09:03:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 09:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843797; x=1698930197; bh=Jw
	W21xk7NABA7qUL+dA6c4kuCd7iKQsRfmVBpLSfZC0=; b=bUdsu7+T1/m7aO2QNo
	dSDWkAirikgvHYPPWMhOsd3B7mXovaOqQzGlcw99gIdMG2nur3lz/3+eHAtZOW7D
	gtpp2tqK4GHydYlXjZ1e5RffRg/DdzgvFzo91u82CjOQTPEXYDyx14lu8gc2sTZr
	MRsaOGN3bIZP0I8W+E/E5H3wcEwrlmSU6Nlcv7PRA2UrK71++C6BQMpxLmgHq9Vr
	i7Z2oLpbI568QIZBLxuSwUxsJgaEsAdllZWQc5eMM5TYZJIlxCSn7eGd1+V5zon1
	AN7hujpwIF80meCiK/rBFE0NE/CmOxDJ3Sdj4R0iVvpUhYKfS3Y6lXl+Wgt96QfG
	KiYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843797; x=1698930197; bh=JwW21xk7NABA7
	qUL+dA6c4kuCd7iKQsRfmVBpLSfZC0=; b=LLgrnniBBwKeuoUl92hQp3HOoKTGj
	hXRngwv0OVgvk2iQKBzs1B6gBCEe10A6dt+z+SWtqg36B2EA1ga66OE5bV2riVW3
	W4woUJ3zPXvXNQwPqUdfA+uUegX2gPfW0/FYlsVXR0c3XVfImiyWbuFkprahYXZm
	WMvVqlX6xwUDzJ4ibKZWX5Fyc6nz4B1DR+0dR56kwn1Dshb4HgF0bDd/XbY41k8G
	Ptg5ei5h5rTxB4sVhrTH17SlnN1vSJRZCf2ycTglxMaTIsMjZfp6ojcsff9Z7ftV
	RRENT8Eg/zNt94wB8Fi5G1gU6cbVN6X/32s7l3brtRLRawF9nJZxMZS7w==
X-ME-Sender: <xms:lUxCZe77gxIgSiJwfnVL3YSEDua0mjXkctiAofRzAUKFOjKjAh4dsQ>
    <xme:lUxCZX406GG0SYFKO3KUodunItOCRGFkcF58JZWbIyLpjtKyNjjGZ0yUmk_lM4VnE
    qY9UNRQExKwVYvggg>
X-ME-Received: <xmr:lUxCZdflj-5PrEHJLxAlQMDOrVZxLezi4B7olRlSbQ2xoMXa2Sj0mXuc--vGPq4TPWpXpcUL_8flK4eI1kau_WXICI13mOv-K-GZhQZoVda0zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheplefgiedtffekvdetffegudeuvdfftdffheetfeelffevvdffhedvffegleeggeei
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lUxCZbJy23QJrMQHUXtNOe1mrzXoekciGzB00ja97pL-jJQltSIUnQ>
    <xmx:lUxCZSKG1z7PUSRlL9-EIqvuOx_khkgk8rnWsHyGWLT874mCzCi0TQ>
    <xmx:lUxCZcxEhQjKvOgCsndbdMltZ-_jv6GZfffwn_-xNlGoScpF2L7rOw>
    <xmx:lUxCZXEdVLsdwJaxsFsUVi57nruxZulXSgGhn0pon69p2MkILHXZMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:03:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b19a96e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:03:05 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:03:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 8/8] ci: add support for GitLab CI
Message-ID: <5784d03a6f102cac88f7a857e57987968e82a809.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lLDk8aWvuZYRHjZP"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--lLDk8aWvuZYRHjZP
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
the maintainer. Results of these pipeline runs will be made available
(at least) in GitLab's mirror of the Git project at [1].

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
 ci/lib.sh                         | 44 +++++++++++++++++++++++++
 ci/print-test-failures.sh         |  6 ++++
 4 files changed, 115 insertions(+), 1 deletion(-)
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
index 6e845283680..48c43f0f907 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -16,11 +16,22 @@ linux32)
 	'
 	;;
 linux-musl)
-	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
 	;;
+linux-*)
+	# Required so that apt doesn't wait for user input on certain packages.
+	export DEBIAN_FRONTEND=3Dnoninteractive
+
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
index f0a2f80f094..2718ce8776c 100755
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
@@ -229,6 +245,34 @@ then
=20
 	GIT_TEST_OPTS=3D"--github-workflow-markup"
 	JOBS=3D10
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
+	JOBS=3D$(nproc)
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


--lLDk8aWvuZYRHjZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTJAACgkQVbJhu7ck
PpQ1pw//T4w7AlEMn8r1BK6/dL+ms72uWsHcOBRKPyHkZyS8BM81gIT5bxmShvXA
DDUOEf7EZejZy8hgZO6KI5k19FL7GtWl7zU2pFrTW5ft63hu+zZ0z4wBVLGMFSLn
t6V1nqxw5L9GW/YT7DndYjVYPE6VSGtXNnKuHVuGl2gV2W9fr6ndlFsmsBClq4tU
HEyZ6WQau+OUp5k/dG/hvMg6iI1xpNTkMQhHajGf/o/l29znjVNNh8akuH2PmRaU
7gTJK9GfVZaxETrxjaNTYacrYmC3s6n9Rxkisl+R/xK3fqq9yNfOJMEYiQtHKvvn
ToAZi23ybXADkxKnHxjeDQ1QGYi43V3q7yAKoaB5QdRqlaiJuiEGfOV1apwdzObk
ZS8n8KCwqbjE6kHo6vDnoEEjAMHhfiwAz+O5pL4/EpOb7E/JAhQMDLvWXzhlheUy
VAJWN4Nr+JxjJYeeMbgUXrh40yWfrtL03BIMqn4bYd6i9ZO+mGDbHs/NUaJn1w1o
YDov7IxXqVvao9xe/WCdzpJAaU4cBqnxPlP+0EI/KwTi5tm6JC36dMAyCos0A9g0
3tP4xKSD88VtFl7BUZaEAihfuwGeg/K2DmJxEmfQEATC/Xj462MvSRx2pU2FtCqD
EhjfUCsMeNjJGtmDv5xfhHOWsl+KRv+3dbMy6aNVh4T13YBMWgk=
=d1HC
-----END PGP SIGNATURE-----

--lLDk8aWvuZYRHjZP--
