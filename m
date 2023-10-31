Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E055199CA
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DZCIpWl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqbR5jE0"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BFBFA
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:05:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 43CB4320093C;
	Tue, 31 Oct 2023 05:05:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743113; x=1698829513; bh=Tk
	GQR18xeEb0kF3Ko4vb8pA/m9+aGFQXdCvGYUNyR78=; b=DZCIpWl1wgBQhXUELS
	Gjc3xE+OoMkfAYi50INgxEfdLBB3cRa32FKem2OGZa13r4gtxamciFlL+sf4Z8AP
	GaybNU0tCt8JgJFDtBZ8OScx9mFx4k8erpVltq16N2ra0ZyVWcvdaz9IvJ+vIxoj
	RD8GOXSLptOjiEVP8v2cb+QWsFQaUJOApfuajvdit0aMVZq/MbBbrWcENixwJOJH
	93wIOolniXXCl86ucqOM0bCWipsompdDGrr5TOgjAZpuf+HJqZLwzW2w8Zntc+hB
	YGdRRaGFR3NFIAbts2tQYkeqcG41hRF1SH2fbM2rFA+36xGOuqjIGHMOtzINtNH0
	e4Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743113; x=1698829513; bh=TkGQR18xeEb0k
	F3Ko4vb8pA/m9+aGFQXdCvGYUNyR78=; b=PqbR5jE0UaYy5dS5ec1NyU1aD2sg0
	cuAjXPbPq+ODV0v1Fli3rsEH0ftneiokuyjIHzUXKNAB30it+cB5gFOP0gNJmdqK
	H1OpMOlg6RwmV47poPw9PYOrg7IM17a86bjza1DoaFwhANvippjwMTESJFVQBMQ/
	1I2e7UM+CRUqtZSHR1CpZ+1aLuph2MSuQHlEcqAVRtiYaxz0Qp97wf5kaNtINd6D
	qJKHRRrO8HfjcqQ1+YgfwpnKczLgwHEyL3b+byKw11JHRSRNfbhoq5R3W7no3n/E
	30X4rCJpAu1Zucc9f5soBhs2E4mm65UE5XHEl17JqEgl7saMX1ExFbf7A==
X-ME-Sender: <xms:ScNAZfH_9fSKiCaC4gJlLhKt2HWDL7XiTIzf60oHIjN1SmjaZGjy6Q>
    <xme:ScNAZcWb0oie09QJK218ZpnQp7nt94UvxmMXTa6GGo2oEvpHHRAqQj41DrKv9qZUw
    cXwyz3_LZdAtvBZSQ>
X-ME-Received: <xmr:ScNAZRKpm-BabQiKYHCoWgIBXocE1QhlBPIo61-KVccgpyE4tql6WfDMhksog6xwF7WfNimQK7yUtov7jc-Sy7xXt05BZ6yURWj3rQvsqavBvZbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeelgfeitdffkedvteffgeduuedvffdtffehteefleffvedvffehvdffgeelgeeg
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ScNAZdGUqDkQWb23y6D1zbwMBwrPyLrcwjlscCLqvzS7Ko2QMoS5sQ>
    <xmx:ScNAZVXnaq1s0aViie1DrZBBReZ2jqUL8yhTgOwD29PmCfdTPLGOkg>
    <xmx:ScNAZYN5nVvN-rv4qJyx8BiaueNk3QQ8-bdW_KjPzlgTqBFlxQhHAg>
    <xmx:ScNAZYRsXHDON1D89AyatJwnTlbvmEZ8EOSS8gIywhOCTuIlUBOPaw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:05:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c5b8331 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:05:05 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:05:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 8/8] ci: add support for GitLab CI
Message-ID: <f3f2c98a0dc6042b7ed5eab9c10bee4f64858f02.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GKl5S4PKgQ62WFmd"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--GKl5S4PKgQ62WFmd
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
 ci/lib.sh                         | 50 +++++++++++++++++++++++++++--
 ci/print-test-failures.sh         |  6 ++++
 4 files changed, 119 insertions(+), 3 deletions(-)
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
index 6e845283680..48cb2e735b5 100755
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
@@ -16,11 +19,19 @@ linux32)
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
index e14b1029fad..6e3d64004ec 100755
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
@@ -208,6 +224,7 @@ then
 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
=20
 	GIT_TEST_OPTS=3D"--write-junit-xml"
+	JOBS=3D10
 elif test true =3D "$GITHUB_ACTIONS"
 then
 	CI_TYPE=3Dgithub-actions
@@ -227,14 +244,43 @@ then
 	cache_dir=3D"$HOME/none"
=20
 	GIT_TEST_OPTS=3D"--github-workflow-markup"
+	JOBS=3D10
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
 	exit 1
 fi
=20
-MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
-GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D${JOBS}"
+GIT_PROVE_OPTS=3D"--timer --jobs ${JOBS} --state=3Dfailed,slow,save"
=20
 GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
 if test windows =3D "$CI_OS_NAME"
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


--GKl5S4PKgQ62WFmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAw0YACgkQVbJhu7ck
PpRwTRAAgvjpIP1kt4P2R2KZX/qdGfW4Ri/fLUWNj8tQ5OB2Pa893HWtwdJ/tnzI
vt/L7U3IBQReNIK0vps0/LbSCKyeUG5Yn88zUmCCC/6KmmK+BIlaVJ95S3b3wo/u
QcqamMo8rR/n1bsHUImMBm+UZ3xcqy5OMLjeQXwQCLIGqpm33KSBZ4LgbypvKCKl
5iGKU/DC1b9Y4pijFGFkr/OSmvHodDZumQAB7NwEbLjlXCnTHfZa9Rf0a/+nQ08W
6bewwL7llPuqEsnVf+2/CAsW4e/WAy68+8ZBkz8l0zSMN6elaQnLY2cELLTFtcbi
2WjKBWZHyYPjuLTRiRUto+5ChLPPRvemDRdPRJKXLMi+tk69bjBcMWoyreFmhLY0
WtO33cxmbw8HS9hKXm746K2T5fil9ZAjlI3seNi8wVc3eFO/Y5ezkL4HR/1mTNcF
2gBCPuOIgClOv+IGeTgful7o7KacmkVXuCA0Eu4U+fJsy1dDdXczdIq5l7thhgaI
gCwsf+ZKyyXZouW5vCZcveaORuoVmHvGubo8d1X4+A7X3Et7f03UC1AOw0wLA686
SYAHV748CvF3d4oc4nc1vDPjpDZC/yL4pjtyJB2PR/R5CgPYEISGdB+YrN/w6U6H
ZWDr+pMc6q1k7jla2Zi8c7VyZ7xqW6nWRMttueYkOtqavXMJ+lk=
=+5X9
-----END PGP SIGNATURE-----

--GKl5S4PKgQ62WFmd--
