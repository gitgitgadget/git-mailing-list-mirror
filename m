Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38510A17
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mz0GI6i4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nogiAF0L"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82B2737
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:59 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 78CED5C035F;
	Thu,  9 Nov 2023 03:05:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 09 Nov 2023 03:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517158; x=1699603558; bh=IU
	7oo2sZBBCPRAJLyeHkYzqC6FjaNGNEsXhQpRSAPx8=; b=Mz0GI6i4fNUX1/12lu
	+kRm6MjEk0KW7abt44/PTS1WzAOMFRtcPYZh0d8KMycaYkSakqXCqJ6Z+m96hsHa
	XAt4xaSbmSDT/CsGGwpDavkz92P/XTvu7AJ4G6hENzBQ2X5BLpyUSPxO2VmBIQCm
	T0WWoue9HBeD+mRPIo/h5mPxNZJfDDK+ezw/xGCchxwe0Boev7gJzY7na7WvPwSi
	Q08e+pBCtLhCf6f3a/oSZr8ul9lFvYOXL3UElKh6r3BFXjBb3gDt67lrU/2P9wHZ
	LRGdCAIDNpyROn4deNaSv39tsuE2OVhez8dU7M/lNdJdaCpzHzCdl/9uW8QfhMvk
	5Qrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517158; x=1699603558; bh=IU7oo2sZBBCPR
	AJLyeHkYzqC6FjaNGNEsXhQpRSAPx8=; b=nogiAF0LkhGV8qFe/iOa8/ZkFvpZ8
	uJSfxln5kpNT1s/Vy5QWdlGME+aeaJkDE2m5KO3eCSlY16Rg8DD/bMecIlcHbrtP
	AKQeEsDZWJWAB+OEmb2LyroPf2AO2qbzHv8q9RC8dgk71bqW5RE+Kyh+uFI3YaLv
	R4amubBEARV0FDC3a09p5SskUOL8pCju/4uTbFZzjI3cJUdiecerxezsy94/5bFc
	W5gXvzbpsqiBbEm+uoSkUPyt7SJAFxQ6AfgC2TxHupo+s8rltGnd90d0VZP1wzjz
	fqU+D48su9BcIX4+DFgXf3hXTETovt9o7DGRekaLNbJT1cvcRpkWtRz8Q==
X-ME-Sender: <xms:5pJMZXdBr3eUHe7R8ajExgIniWBrTUX97VZJwPcBKnDWp-4qyjfs8w>
    <xme:5pJMZdPlGT4YbEeiOmRJp11-c67FAsJRvKC76PVnleaFO_Seb_q7te0Eh58NGqZDe
    Y_QPm_HDP0qwOPIDg>
X-ME-Received: <xmr:5pJMZQjFZoVuXoMRcV0m6ZbUqCNLlmoVGRDPoNZtuSmdbohEuhrgU4UdkWNmwEReW5kX3NyygeW7M9K420igeT1_PySUckb_YNYQy0dyixb9JnEj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeelgfeitdffkedvteffgeduuedvffdtffehteefleffvedvffehvdffgeelgeeg
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5pJMZY-ACvo6uYcc2bclJCA_pryEZdcpwb1wfapzmng2nykZ6nrO-A>
    <xmx:5pJMZTv7EKh-Oc2OlNwNDK7Tiw2PoIiGih3r5UlDpsLeJ2Ptm8oBRQ>
    <xmx:5pJMZXGWPBYDvfm1va_T9-dVN4UOJorWsHtmMVIwRY-OnnquF44ENw>
    <xmx:5pJMZZU8VsXscWIWuJKlTTx9lI2YgK3KMPSCteD-hHhX_2Fhph_9UA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e99ff401 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:29 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 8/8] ci: add support for GitLab CI
Message-ID: <c05ff28cc2cbba88088e46caa5d5ba40e583b576.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QVyNm03ugOjJCaeD"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--QVyNm03ugOjJCaeD
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
 ci/lib.sh                         | 45 ++++++++++++++++++++++++++
 ci/print-test-failures.sh         |  6 ++++
 4 files changed, 116 insertions(+), 1 deletion(-)
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
index 04997102308..643e75d0577 100755
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
@@ -229,6 +245,35 @@ then
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
+		return 1
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


--QVyNm03ugOjJCaeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMkuEACgkQVbJhu7ck
PpSqWA//a+uqNkkXcf2/qjTMif58L2ad1XqDKxitMXnbo5CBAI5WvTsl5PJrl1cL
yfHmnEO8MqofQZFMfF7roxKpuYzwHzfEWZSa4Y54VYrG6uHGVWtwH/LqctwBV1V1
/k3ueq5BFiXRwluQ0IFnEP2iO3CDvFEd+/chBbSGzXlcApl83S7rS4RF+Eat3nsC
1TTzjp9padzp3rhJssYpEIJngzCTJbzCWP93rcRNa9bfo1eddQrustXqKwVxg1p6
2vMbNOoEpo3bhJ19pB4hrg/818lBOujOwr1iEUTnabxr5mpEMpJ8/4QQjrmdzQ0O
2Tdcfuw+/9dIyl/BLdgvYZTMkbGUuwTHyEkFNuZB/hNr+ssYimdFyG72cKv+nbQn
z/aXaB7JQ7YFV3Pt03NSpACu7JLIaH+BYvTX1sSy0aZWU/8xBocyQonC6OxcjBou
4eKWeT4vcq9WuEWFpj1Tbgcbhf68U+5R6eTgTIBDg2jRpe+sNxE+V1AMrvsHbrWq
mgUfRUOi2h4E+mCxEBB8SsWYp5P4abvKPwSBhuqlWzD3JC44WCZe1EjY2xlpbtRG
6PHH6OCvZ6xdEF3S/95rEHk92hRQl34Hl7Z08NHd2rBfwbV8fKEU8GFj8yDJnqnV
HL+/IHPvT6yHNU591sKaV7CVdkcdlHgnrKziU83XyQJaxmEuTyk=
=sYzU
-----END PGP SIGNATURE-----

--QVyNm03ugOjJCaeD--
