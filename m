Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4CA107BB
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lBfTPNUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovKbNuNZ"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B22699
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 02:53:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 560145C0366;
	Thu,  9 Nov 2023 05:53:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Nov 2023 05:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699527214; x=1699613614; bh=cm
	rm92hyAPDltxCycxbyaumo8wApdbG86eiiCvkWNOU=; b=lBfTPNUqzV2haY87bI
	Zw2Nefu1F5Mk8Ovh/wOHge/976BfhK6SAwYmMdvoulRU60XCcaENC6UA/65l7GQZ
	6IpZjSRAwLWSwwAWiInbXGvyWVQh/n7ms1ZP1Iz2AKtBTwfl0eiuNI7XMY7OI1kb
	Cx3Mxb0SQJ30eiRizXUXKkzON1Ev5C6mi+TbL6bvlB6KQuYdaCsi31svC4J761Ud
	ZBSexJVICxA2OcfKNinAsqE9vrSuIxb3qfnnDt/Co+J5hesFUxvpb0weA3Pt8Ire
	fjzaqtW1BwUKBhyYDdddvSg744sm5XOHoOqHWtTxmcXUTX4vWwqlOqt/496B4byA
	KOUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699527214; x=1699613614; bh=cmrm92hyAPDlt
	xCycxbyaumo8wApdbG86eiiCvkWNOU=; b=ovKbNuNZuiXvJpmQ2NHu9rMKxzLVs
	D1QYfqsn57kbEmrWYzAG7JW2XU34VAAQUg45+rANnsE3cT8n/3rFw6uo2Zh5PvDr
	q4SR1ScDuCiQTWs6kTaFCkQI3/AfjgK6OKToqi+8kq94pXpLdB8zGjYDhzm+HbaX
	X42TcgTtYe1eTBEYZTwtzVCnt2bLmFtBhESHsR6TtOCS4MMy8J3Nx+DLtpV0C9zg
	byn3KGuH0bpPBr0QHWLnqTcJBxrNlijbB7UJigC+d53ZtkUUxJejGeQnA6ykFKZH
	Cg+xgUFNZ88fnwixQiyjX5LhWJZvBTGGFQ1liSG9h+n4Sspboy8b7ANRw==
X-ME-Sender: <xms:LrpMZfv9g5_RrJfMNMyKhQMILloeRmEurRAGHBE1AEQ1cR9fcBJWSA>
    <xme:LrpMZQfCvJYh-jv6EfDgxT9LFSva9818u43zGpP3ejlSUhDcHrXhHxZx-g9sphIUS
    DCLH8RZRNmlaqb7uA>
X-ME-Received: <xmr:LrpMZSw_hawghR825ft5qlnToaKbPUbBypVsv8rtOAsg6FVBShX6s8xA51Eqil4w4GlWgSIYIF0sBz3lwyKkyF-t-NNDEvP98uMiDAoimVhZZyDB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LrpMZePZ8NRvjDcEgkd4UatDjD3UPJ_XnO5ao2kKXExAyyKjcMi2-w>
    <xmx:LrpMZf971gFMgPzyCEnEoGTbOZ1WrzrZiOs8WNVix22YlQKB-59q6g>
    <xmx:LrpMZeWBtG1mKPqobaQCp9xY2oQkbUNeE0l1mS3tm2YW4yMvxdBHgg>
    <xmx:LrpMZZkehqDVqBlomQZ41fz1-wiYR2fZNI9QmBLVkmpErTKtJjcDSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 05:53:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a8f35e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 10:53:05 +0000 (UTC)
Date: Thu, 9 Nov 2023 11:53:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] global: convert trivial usages of `test <expr> -a/-o
 <expr>`
Message-ID: <c5e627eb3fef0df162da56723093a03bfd2321fb.1699526999.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0Eozp/TEn+yxkkF"
Content-Disposition: inline
In-Reply-To: <cover.1699526999.git.ps@pks.im>


--W0Eozp/TEn+yxkkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our coding guidelines say to not use `test` with `-a` and `-o` because
it can easily lead to bugs. Convert trivial cases where we still use
these to instead instead concatenate multiple invocations of `test` via
`&&` and `||`, respectively.

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
index e54492f8271..e4d31cbbd6a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,7 +11,7 @@ LF=3D'
 if test -f version
 then
 	VN=3D$(cat version) || VN=3D"$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git &&
+elif ( test -d ${GIT_DIR:-.git} || test -f .git ) &&
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


--W0Eozp/TEn+yxkkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMuioACgkQVbJhu7ck
PpQJ2w/8DU8Q39V4xvRtkQ35EMD8UdauIoVwTfOeyskRSDqiCulfSZZBvasrfKUu
vp/t0tVRI96Y9UVI70fp7LmSVDQ5d03GVbYsPbOCP+uz+6Dz5JJwnhV8q8ye5kbu
AsJLTcB3l7Hug66jZp85Uq4kg2qQ36Yi1hUmGHK/vMYhKCVOXjhLrXpk2tXbRyDN
ccl2WdLYMwPaZWKqg4i7HPyed6EVg4rRQlzquFVDV0nvPGZZtBgn56eGqlDK/9dH
xNC/+jNksaem3vY+RDLYdpVBwRP8jjocr3EW3MNgfvuwTBxXEH+PGJSJpJ4HxUDV
DSW1NsALPC5vUDhLSMf17JUCYcPaxlzw+Vfk5Hbcbl1rUWBgOyzWrCz7G02sDvxT
aZh6LWnvBr2BaACZPx3EN4X8x7rj4CSGmqb5NPGH+hQmQgZgz0sqY6nEn7xeru07
+/69X7ZWTyvxl6c3E0sTbEbilFavDJgzWL/bLt5QgCXO16iWZ146a9SjM8y3wCKo
rFuTq9luavffNU5R+hrnu4Hrq1VoH80TI/YcOQVjV8N/rFPP02xtGxu6sfeAiDuF
e6pCZ4I/8DdTgihf3pZnwhW1l3jq4Ixp4nllaT47uLSFleh/B3n0q8S2HZKccbIs
iD+XzL8ZlURN5gRL/5BCSq3D3ibLpL4hPNa4q/0eaj5bYkm2KA0=
=Hn6m
-----END PGP SIGNATURE-----

--W0Eozp/TEn+yxkkF--
