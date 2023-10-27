Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB015AF7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qm39kBDc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkxviR8O"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F11D9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:43 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 409285C020F;
	Fri, 27 Oct 2023 05:25:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 27 Oct 2023 05:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698398743; x=1698485143; bh=pb
	16G+EdN8eUSo/D4IEhoFYVVYqxLxOzwb3f0AR+YJY=; b=Qm39kBDcFpILjBLTs+
	c5XgwDF9mXf5KHtmTt3adJ588TN8q0Ja4WGm58brVYLIXm70vZ3EjsEO7j/rNTy+
	XLoma+XGKPS9tDdGNFvZ+3wP4ES6wjDgPQPCetJdI3/7EuVh9ZWWw3qJFd9zNwF/
	fcVmc9QTUa2nhH2MdyTb4E4xLMZUeaTRGw76P+/hrYilVIfF+2VOKLMLVIRhSDq0
	17E3J8ZVEJggeD1+yYa9lJhddOw/hgV2Npovqto+s1veCh+lvB5QlxrxxfGbzho0
	LZnBr2CgOOO3OvUokhjIXrSUyMkJVsWFd7VsnVLE7ta/tT5NZLSdLzWC+d6Ag0yN
	+f4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398743; x=1698485143; bh=pb16G+EdN8eUS
	o/D4IEhoFYVVYqxLxOzwb3f0AR+YJY=; b=pkxviR8ODbp26ylM+W1SaPclNiyjP
	n44G4CQhMfg4DMOWz+NV4h9R5bWFN+sTMf6fwBmXd3Yi6JPy6n3dU5m/da6PRBTG
	wezwPmwvAjho9VpS1t0yuxdJAAFKz1hxPYffapSp2w5bAYqvEgvWZ48G4+LrBA0z
	NOCv5y0LgZUWfVZUYmDhc/UQEXRJKo6lKlpjYv0+bMyXhsQQ9pyyYDZ5VNT5UcIs
	RYBxwW5twbiyupjfO9DjWa/1ZKYdn+ZhoBNMnCf86kg7QICn9/b/nCypgD6agbP9
	eTK+uLYjqoKSOP7fG+cIrdjuqtCFuk9l7hOnUnaBtyoeoUGy4DwoSqrBg==
X-ME-Sender: <xms:F4I7ZcDn_MzOuFFVeluQzR-Z78H7O-SVTPWEpoLaAc9SOm5ZLbRmYg>
    <xme:F4I7ZehI2-z-jmVHT_e8kkiGgn-2Ain-s4Qd5R2mnDdCa8nUOEws8pHxYH-4uYfUF
    d8pI4ICtd1aVzenQw>
X-ME-Received: <xmr:F4I7ZfnSHjp51aJ1VMFeugpg5n1PguU-WVi5zk7oY6pkLXF9h-I1v1_vMNB4MUVWIQqky71xVVYsX6TT8P1-WCwrliG8wNWN_TxjYRfpeZ9-CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelgfeitdffkedvteffgeduuedvffdtffehteefleffvedvffehvdffgeelgeegieen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:F4I7ZSz2GiHPVTFdU3NsvyKTbTMqGw8HExQ_fcuYAe4CTpI_GwZctQ>
    <xmx:F4I7ZRQdeqbb17P4XpeEu_w_NLXQ51cetl2LV5xbIuNo6duzuKhrOA>
    <xmx:F4I7Zdb1dD-LywoSlDlSRAKH5m1Dqbmmq_OOpN_OMQwkRviNraXk9A>
    <xmx:F4I7ZS72S_DvmzEll33EIGqlkkjbCS7LFXFIgI3eu1MVrvlCiqFX2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 05:25:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c57e576e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 09:25:32 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:25:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EhN+iIDmmd4G7Wu1"
Content-Disposition: inline
In-Reply-To: <cover.1698398590.git.ps@pks.im>


--EhN+iIDmmd4G7Wu1
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
solutions.

[1]: https://gitlab.com/gitlab-org/git

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml                    | 51 +++++++++++++++++++++++++++++++
 ci/install-docker-dependencies.sh |  9 +++++-
 ci/lib.sh                         | 49 +++++++++++++++++++++++++++++
 ci/print-test-failures.sh         |  6 ++++
 4 files changed, 114 insertions(+), 1 deletion(-)
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
index 9ffdf743903..f518df7e2cb 100755
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
 else
 	begin_group () { :; }
 	end_group () { :; }
@@ -203,6 +219,39 @@ then
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


--EhN+iIDmmd4G7Wu1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7ghQACgkQVbJhu7ck
PpSfgw//Uv+hsQKwAtYzqwcJVqERZtVSotE6AKFkbShwxOyWOTzcQc63Ux92gr8T
5BUq8ltXt5G6+YbsJBNUs46BVgGfZ4TiQUalUryaubppfLXKZ/74/I88gxiEit8I
8I6J582jGgQV/3SJ+sjmzDbZKPo/kRxyRwvbHlHGKB6qLaGKo/02TUBm4kc6En8t
5uAbTvVq+K1JqxGdR4An2sogOlT3ga3qdF/dcGcAM6qJjqqKen3FccJU57rtAU5J
RhA0zSQbmTO1j2EGVXmC0rlRAifdWVIXUl2/YDvSwB34eGC6ae077f8+lrvo30Zv
FOLENZNnUudCIdWa1JZVefQS1CUX6iocuGCX13s6yvsjPHSpue/whTDo1uGKJm40
+DQaXsXYhcv6KqkI8V/+H+hELe3ON731XFm87G0sNJ8JnosfATWguWNbk8niLYaO
mfbMexbPEMa7wWFSxzyR6NWEzXiwoK3pTF7vMAt0OkriHkW38zRiLiazxoTn2sYb
CNLPrryjMMya+tRQYcw+7NZ0xPBybjm1Z4VRLFpibdAFP911dy03CCaUS6H4tD7Z
Dfz4lvJX52BeihrIgM2YgN8eG+IX5AOkDlfo9d6hvfYyHNGflYAT1+jorHC1fV5w
sUUIMnSpFY1O1T6TIrKUrnwor3XDPAzLyDXEHOXB5uMIy4x3LGE=
=4YtO
-----END PGP SIGNATURE-----

--EhN+iIDmmd4G7Wu1--
