Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD302C6A8
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AAih1N/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdMyAdIg"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 7EBDD5C0163
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 06:45:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 15 Jan 2024 06:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705319107; x=1705405507; bh=9t6ihaJHRJ
	v70PZO360255XdUMJbkKRQ7wv5CEjjE/4=; b=AAih1N/HYIUZrz/VCuZcQPZJGW
	+pHxz8AjzxRO6/7ulWmFa8lEcKyU0fg4Lp0FSnU7VWBnt457W6wmAD9fhiA4D+m8
	mIVe6XzyRAMRqZ9cd68QGY1u85OtzCRgkr443YvU7O+fhdgrh3f//gcZZ7YneHsQ
	QjbTu101axCOrdMe8ClkGC7pc6ODWjKj/s+yb/zQs0zZrV+sxFn/bvgoQYUA8aq5
	nY/FO1MJNp1f/JrJmG+xbRnx87+T1t68d/uGve4AIG+VjiLHHGdJLP1N7MuXJ2vz
	O97d7hz6idGpMS+EZSi5xocghhZYBXSfIz/FBYYzguoUWZs1IbvuNqEKR7Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705319107; x=1705405507; bh=9t6ihaJHRJv70PZO360255XdUMJb
	kKRQ7wv5CEjjE/4=; b=EdMyAdIgUThZVGjUHxkHRymaeUHcv8TUdrqwfVkRpzHq
	7kUTB3/TDqDQZKei73Ds1r08jw/uI7mNxJc2+4tA3uoIg4XkXoKYu6F/NVq1kTsM
	u283Er1GaHSUGfUWIMq+6vX9uoVxj6refSntZ57zSgfqiDlIZOAXgkYioJCKX9Ro
	/wSeirVEiz5n9E5GYiFDeR0L0K0AWaKKXZsYETtNkWztyFPGnE+dBt1Cl8C1tszl
	Q5aZtVKXclQtgRV//xtEfpHKznL9XOC3LDTPdh3LR322F7El5C7JtnnC9neARfLl
	hczl+G/IaQo85HSvo0F5mRWK/UyAWWThRZGnaCW3pQ==
X-ME-Sender: <xms:wxqlZY1UcwRAcBQ9BEIv8rLKujWnVguCiIRx5BAdDnyd9hgWFE3SpA>
    <xme:wxqlZTHKAwNmzNvPEgqFzJ9rrYB8CXS7W0mERP8M5I7XKKnaAYxOov9MYdLP9NaAV
    JAwHJfqKZd_g7dyBg>
X-ME-Received: <xmr:wxqlZQ510Yoco8llOJdyhWy1pviSeIozZewbg2WqWbwgmaqIjDtjsyvPGuFpFNrGHTKQ8vzU2NvnfZFKRZEKATv7t45h0Vx1SxeXxUdkHcr1ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wxqlZR3XJJyx-VKr5BjYfw9b0-wq7Iv5AZ80hYGwF8D1QCBlGbjGZA>
    <xmx:wxqlZbFp80Uq-f7B4QFM--vqaRFzX4S5wHa5-1kj3X61Rhd7LjH-6w>
    <xmx:wxqlZa-iq-fIJ9tVDUTF70sEfTBePyZ67HAlgDFdfie2BCpxU4yRnQ>
    <xmx:wxqlZSyy6tXaIb4b7cVMGoHbPVzWoMDLUqRN3wGwXKZ04LaZPFIqnQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Jan 2024 06:45:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc43a556 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Jan 2024 11:42:16 +0000 (UTC)
Date: Mon, 15 Jan 2024 12:45:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/3] ci: add macOS jobs to GitLab CI
Message-ID: <d196cfd9d01fe3b52c75a1e4e0aca9f67567ab43.1705318985.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+3b1D8xF7thN9rG6"
Content-Disposition: inline
In-Reply-To: <cover.1705318985.git.ps@pks.im>


--+3b1D8xF7thN9rG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add two macOS-based jobs to GitLab CI, one for Clang and one for GCC.
This matches equivalent jobs we have for GitHub Workflows, except that
we use macOS 14 instead of macOS 13.

Note that one test marked as `test_must_fail` is surprisingly passing:

  t7815-grep-binary.sh                             (Wstat: 0 Tests: 22 Fail=
ed: 0)
    TODO passed:   12

This seems to boil down to an unexpected difference in how regcomp(1)
works when matching NUL bytes. Cross-checking with the respective GitHub
job shows though that this is not an issue unique to the GitLab CI job
as it passes in the same way there.

Further note that we do not include the equivalent for the "osx-gcc" job
that we use with GitHub Workflows. This is because the runner for macOS
on GitLab is running on Apple M1 machines and thus uses the "arm64"
architecture. GCC does not support this platform yet.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 26 +++++++++++++++++++++++++-
 ci/lib.sh      |  9 ++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 793243421c..9748970798 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -7,7 +7,7 @@ workflow:
     - if: $CI_COMMIT_TAG
     - if: $CI_COMMIT_REF_PROTECTED =3D=3D "true"
=20
-test:
+test:linux:
   image: $image
   before_script:
     - ./ci/install-docker-dependencies.sh
@@ -52,6 +52,30 @@ test:
       - t/failed-test-artifacts
     when: on_failure
=20
+test:osx:
+  image: $image
+  tags:
+    - saas-macos-medium-m1
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/run-build-and-tests.sh
+  after_script:
+    - |
+      if test "$CI_JOB_STATUS" !=3D 'success'
+      then
+        ./ci/print-test-failures.sh
+      fi
+  parallel:
+    matrix:
+      - jobname: osx-clang
+        image: macos-13-xcode-14
+        CC: clang
+  artifacts:
+    paths:
+      - t/failed-test-artifacts
+    when: on_failure
+
 static-analysis:
   image: ubuntu:22.04
   variables:
diff --git a/ci/lib.sh b/ci/lib.sh
index f631206a44..d5dd2f2697 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -252,7 +252,14 @@ then
 	CI_COMMIT=3D"$CI_COMMIT_SHA"
 	case "$CI_JOB_IMAGE" in
 	macos-*)
-		CI_OS_NAME=3Dosx;;
+		# GitLab CI has Python installed via multiple package managers,
+		# most notably via asdf and Homebrew. Ensure that our builds
+		# pick up the Homebrew one by prepending it to our PATH as the
+		# asdf one breaks tests.
+		export PATH=3D"$(brew --prefix)/bin:$PATH"
+
+		CI_OS_NAME=3Dosx
+		;;
 	alpine:*|fedora:*|ubuntu:*)
 		CI_OS_NAME=3Dlinux;;
 	*)
--=20
2.43.GIT


--+3b1D8xF7thN9rG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlGsAACgkQVbJhu7ck
PpSd/A//W6eGLPhwhua8T4LHXOpsXdRpui3X122eXciEOpcvTLNanZafXgrOnWIE
n0KsraK+qyj+MZOQ5uHMCbodcYynNk/35arZ5mWi9nrIIH3z+2kvlJVzBVNbb38S
kOqn6hzVnzWzhGMCWhCIor6W8+irBKF7HoFJN7crMxuA2NDlKBXVtBtJJaBJTFvy
Es+n52vYoxL7OFGon0/23snuRU6uilZ8m63I96AFs5cTN2N88DHWwd6hz0vHD7Ba
g93Fx1PrIr5lSavNWSvmShDp9jMxMxBT/XghSCIoWxWb+WsgdtvkeYAfiB5QlSMX
EyKhqyr10kft080H4r7fjuUgLm1haGSXtuWjkYEqKUNTPcE/MOO9Cn3SH4ZlRNqH
7r3B2c9BUPk8DIylaB1vev5WCsfCB6FtheTOyoN8kork6Cjcme7Uqif7rd1fc8u0
FnEbK8eXxM5b9IPiD83fYB1LuGq052AjmV8+UbRXhQleFbwfI4BH9LN2YaurLCkS
jBW01kXRfNXWK6Ju0van8Z5msfN+TPpxruFH4zb4cRSiVJng5lSvMSAhFtNkmcs2
2kwJwH8b8cQG5dcJrVLniv57aDvbn8GTqqzf8qX+tYE1zbCmUJz8vrLljaGlUAcG
TtA9iGnTGchE0F/1lwNDEIfBgv1PJQsASg0oYXuAfgB9qNDysq0=
=xAdP
-----END PGP SIGNATURE-----

--+3b1D8xF7thN9rG6--
