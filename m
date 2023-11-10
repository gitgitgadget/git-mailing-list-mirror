Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B00134A0
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pOXbJICv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JR6X0RR5"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0226304
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:01:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id BA6E43200A23;
	Fri, 10 Nov 2023 05:01:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 10 Nov 2023 05:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699610478; x=1699696878; bh=Es
	kPxpgrVZXQQtQ//2KPu4zLi4hcig++T5tD+AE4FQA=; b=pOXbJICvUx0KyLtF/O
	DEqv6TyF4TMhXbdGOZNa6j24oGMNZamFJ5m7hrAc9dYT66NAFxDsWaPiE1wKYGDW
	RjGQAOmR+WVgkT2Tgi5yBAY+LUJcmavrOwzBMMQQw7BReYId/01scFpk0kAMvrJV
	bs0Zu51CS+Kh/Ut/qiJMdnMtmf/R680T/wedBvky4ZiNssPhESEbJpe9z5RP+uos
	59BTh5jHCTFiTpJuDkmvmS0xF1qjF15GTSaqHaPQjvr8eRNxDow+FvmljvK/rKdA
	ObmUGsPjDZRfWorgB7FNRtyy58jpt+Eq+fPXyZJfyt6RDYGLh0TBxE2HzTxS3MKL
	JAoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699610478; x=1699696878; bh=EskPxpgrVZXQQ
	tQ//2KPu4zLi4hcig++T5tD+AE4FQA=; b=JR6X0RR5XFd81Egmp6L0GuG84ji6R
	7vEUSClnmCSsKn8vE6888sW6tZZwTPTU1gKwBJvRcRlkv+Q9YuLJHv914h+d1KL9
	Hf4PjIQZfT9TEBJdDhbamkTeTnG0OaC/9Xm1A+/dcmZIHBE2hAfiTyuwq/eov+ML
	0Joua+SUzIJEPtYmUOI7oNbAfutGTnufkI/tErn4JAcZYuFDZRktn15uhwatj/7h
	CCFTn7UhTRVZwhRJeP0Sjd5fzrbN7CVFI9CVAdkcYKc5qd3IabKkPeibia85uQ0V
	cc3PSpIsffbPeSFIRIN3nwB+yQJ6eCLTR7+Vkncb9udpBpD1nzj3ajcjQ==
X-ME-Sender: <xms:bv9NZeKkFJ4tHidCUwFOJ04k1vV0XF2ks6XhzMDmihLA6WtRgdiWyA>
    <xme:bv9NZWJcOx_CN1AZUnk-dPuBs_ZoZ5o-ed9R50hYQH-HUbUSSu4-4BnYi7xyvrs-9
    g4Ydlv-AfE0HhjerA>
X-ME-Received: <xmr:bv9NZeu5_r6UDXlyWgbd51ki03tY1XWRtmHMStUCdi6L8pDxQ29G2AnhnyWQ7rjKodbqxI9Tg1v1ckRttYmJXk-mefmkQO0KZv0TMr3tWIeRfwOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bv9NZTa3BaFXyKil_LyyV9swI18a27bzEdU9GBrcCkX-0_NuYdfyAw>
    <xmx:bv9NZVZKFahGFE8E4tsq1RYLT6ofz4uDrPkL2d4eN6cVnZS1VrXq3Q>
    <xmx:bv9NZfCGCE75Bv6KGrLh8uFjCRgIno-ngZaOb3YyNzU3Nhqw9805ZQ>
    <xmx:bv9NZUwzrG4UhEMuYozMuR_VcIm7_otBvXdJWl0To03bZF0PP2ZUOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:01:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d803de4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:00:47 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:01:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] global: convert trivial usages of `test <expr> -a/-o
 <expr>`
Message-ID: <2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h/hQTnoEAt13qkpl"
Content-Disposition: inline
In-Reply-To: <cover.1699609940.git.ps@pks.im>


--h/hQTnoEAt13qkpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our coding guidelines say to not use `test` with `-a` and `-o` because
it can easily lead to bugs. Convert trivial cases where we still use
these to instead instead concatenate multiple invocations of `test` via
`&&` and `||`, respectively.

While not all of the converted instances can cause ambiguity, it is
worth getting rid of all of them regardless:

    - It becomes easier to reason about the code as we do not have to
      argue why one use of `-a`/`-o` is okay while another one isn't.

    - We don't encourage people to use these expressions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN                | 2 +-
 configure.ac                   | 2 +-
 contrib/subtree/git-subtree.sh | 4 ++--
 t/perf/perf-lib.sh             | 2 +-
 t/perf/run                     | 9 +++++----
 t/valgrind/valgrind.sh         | 2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e54492f8271..7246ab7c78c 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,7 +11,7 @@ LF=3D'
 if test -f version
 then
 	VN=3D$(cat version) || VN=3D"$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git &&
+elif { test -d "${GIT_DIR:-.git}" || test -f .git; } &&
 	VN=3D$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
diff --git a/configure.ac b/configure.ac
index 276593cd9dd..d1a96da14eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -94,7 +94,7 @@ AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
 [AC_ARG_WITH([$1],
  [AS_HELP_STRING([--with-$1=3DVALUE], $3)],
  if test -n "$withval"; then
-  if test "$withval" =3D "yes" -o "$withval" =3D "no"; then
+  if test "$withval" =3D "yes" || test "$withval" =3D "no"; then
     AC_MSG_WARN([You likely do not want either 'yes' or 'no' as]
 		     [a value for $1 ($2).  Maybe you do...?])
   fi
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e0c5d3b0de6..43b5fec7320 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -489,13 +489,13 @@ find_existing_splits () {
 			;;
 		END)
 			debug "Main is: '$main'"
-			if test -z "$main" -a -n "$sub"
+			if test -z "$main" && test -n "$sub"
 			then
 				# squash commits refer to a subtree
 				debug "  Squash: $sq from $sub"
 				cache_set "$sq" "$sub"
 			fi
-			if test -n "$main" -a -n "$sub"
+			if test -n "$main" && test -n "$sub"
 			then
 				debug "  Prior: $main -> $sub"
 				cache_set $main $sub
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e7786775a90..b952e5024b4 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -31,7 +31,7 @@ unset GIT_CONFIG_NOSYSTEM
 GIT_CONFIG_SYSTEM=3D"$TEST_DIRECTORY/perf/config"
 export GIT_CONFIG_SYSTEM
=20
-if test -n "$GIT_TEST_INSTALLED" -a -z "$PERF_SET_GIT_TEST_INSTALLED"
+if test -n "$GIT_TEST_INSTALLED" && test -z "$PERF_SET_GIT_TEST_INSTALLED"
 then
 	error "Do not use GIT_TEST_INSTALLED with the perf tests.
=20
diff --git a/t/perf/run b/t/perf/run
index 34115edec35..486ead21980 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -91,10 +91,10 @@ set_git_test_installed () {
 run_dirs_helper () {
 	mydir=3D${1%/}
 	shift
-	while test $# -gt 0 -a "$1" !=3D -- -a ! -f "$1"; do
+	while test $# -gt 0 && test "$1" !=3D -- && test ! -f "$1"; do
 		shift
 	done
-	if test $# -gt 0 -a "$1" =3D --; then
+	if test $# -gt 0 && test "$1" =3D --; then
 		shift
 	fi
=20
@@ -124,7 +124,7 @@ run_dirs_helper () {
 }
=20
 run_dirs () {
-	while test $# -gt 0 -a "$1" !=3D -- -a ! -f "$1"; do
+	while test $# -gt 0 && test "$1" !=3D -- && test ! -f "$1"; do
 		run_dirs_helper "$@"
 		shift
 	done
@@ -180,7 +180,8 @@ run_subsection () {
 	GIT_PERF_AGGREGATING_LATER=3Dt
 	export GIT_PERF_AGGREGATING_LATER
=20
-	if test $# =3D 0 -o "$1" =3D -- -o -f "$1"; then
+	if test $# =3D 0 || test "$1" =3D -- || test -f "$1"
+	then
 		set -- . "$@"
 	fi
=20
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 669ebaf68be..9fbf90cee7c 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -23,7 +23,7 @@ memcheck)
 	VALGRIND_MAJOR=3D$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
 	VALGRIND_MINOR=3D$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
 	test 3 -gt "$VALGRIND_MAJOR" ||
-	test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
+	( test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR" ) ||
 	TOOL_OPTIONS=3D"$TOOL_OPTIONS --track-origins=3Dyes"
 	;;
 *)
--=20
2.42.0


--h/hQTnoEAt13qkpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN/2oACgkQVbJhu7ck
PpRe+hAAm42R+25haZ9mXUKqNqmJjoBUCFQ773oPRTBCi+GwdrLALGhq/V7O+tpd
Qqwea5EVPegeNlroNE86IhwybgsEG4KFJ9g8cL/ld/21/z40WUCCgg0MeslKP2nK
RkHEHYat2HPEezGd8/ECbUBVmmeoEsBwS4/N80MrnxsioxBbif5b18STkhrJuG3h
3ssMV99sCjbW1k1cBp3DeEeBrFg53D4lwLS8hx8xzQDphteLvtGYP36/iOC/Jvgs
wI/QryAxmxjBIL5g9dkBvdqrv5QTv57belEIXmNxSot/QEZ5I2VNwacWtRshNS0v
iOMRtFDjZk3HrMIDAF7F/x17D0fw30AXVZN/m6NsXxeyAZCmFwyJKZO93Yz9oN9I
oGRJB1M2RA0o5ev3BFQAk7DS74hQKY4xv/DevKtvocxPXj8N3yUHzW9XUFk1OdhC
ThXk9zemxZJiawuKJOWnyaDGnJGzuiDUee1gKYxGuzGnO54oJKc3YSk+dvOSSyOU
k9cjPOQmKE/MRS7Cgc7dNtf8bnPwsdBM9OKldg9NjdMQgsZv3ON3An2woasj3cXU
eUvixmkJkC4I8JH2LnjztNJ7zRHSfLU/EjO2fnvBzei8jCl8dRaD2r7B4RzLSpcC
eakbno0HXhNUKPxZ8oVgEXkCmZEN49EYKkaMULMyLv6hviyAK2s=
=Xmkc
-----END PGP SIGNATURE-----

--h/hQTnoEAt13qkpl--
