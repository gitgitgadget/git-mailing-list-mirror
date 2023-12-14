Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CO8HkR7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZROz1/D6"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832BA120
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:30:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C05C93200A40;
	Thu, 14 Dec 2023 03:30:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Dec 2023 03:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702542634; x=1702629034; bh=dnrWRkKXt2
	nVUxg0uON1UoDJF2xLPLF+c1+qPPrDxgM=; b=CO8HkR7h0HYFJ/pahXxSosVs3s
	x3PF2bW8R7vlQxnQAhvvBnId3VRAgCW+1lNQiXsKgZ5vk3JU6KNQr70BYOVpDVrT
	QI2iK3ZJvy2ChoR1kRDtCM8ot/Std874E9upo9CE41EDMfPLZdSmWEub8daTIe9b
	4+AV2b3m18rFlcg/c3YdEFZjpgYNCaCrSSvWDEsgy/oDdOmijVUnaE/jdpsJqoQy
	1i/XjC8gCknE6J6KDGkf03QazAlOKzpjB4PuBhIXiObpNhNFULuaf0SUo2O4aVvf
	4eimhCHfr4b2XSwQ9QUBzK+EyVkE0CQxu4FydDduK/BOCJWUTjxKbmRcwqWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702542634; x=1702629034; bh=dnrWRkKXt2nVUxg0uON1UoDJF2xL
	PLF+c1+qPPrDxgM=; b=ZROz1/D6IgZc1/ClSYYG4bwHhkU5q7rfBtZScJsAX4Cb
	slADLmCldJXz03X3RuFx6aJoQeG1IJduJjBvN48hMPTP/m1kGvmyrUwqTGTbQngc
	HhWPhVZIz+jtDVc+AZrYpm9CWJHiwRxHOj0qRhcQIGlVydxg29CbttWGYU8+hXE8
	g6kfEvDGDpKp2da1IpKGnP26gvFTV1N00aMQiJVIOrc3E9AXZbGGYYXs40jSC43B
	PhKjTXzqDXucZsIRJNjHVIQ/fnyiwxq7D1wojd+xw8oBnfFtPX+ctdLSCz3jIPLm
	fnEekJ5javbez89Xu2AfC+YWoRNLYyxyIgH0xTF1YA==
X-ME-Sender: <xms:Kr16ZV4h_L2cmBd_ueIWaVs6LoRgW6qop7m1A0Et7vsu558kjAQXLQ>
    <xme:Kr16ZS7F8viZTpH8KgM9zIZXEOViqz5n5RYO3s2J7GEB9NcpSk8lWEhe4CyHTlS_1
    RWhdqNk8zBty-YxkA>
X-ME-Received: <xmr:Kr16ZcegTb7UCpV0f-Y-jvt9V8sGH8jPMEQpNX7mtzcjzfYX1uqq_Bob7WvybKy3BMemL5Nkt14GDQKshnyI-DiuKwhgo0s6suRdyWS8mooYnjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Kr16ZeKq19Mz2nFOlj7J0xIF6p2QDdXhUDra8yJWR4Phe0aF1KozZQ>
    <xmx:Kr16ZZKS9rabLBz1y8tQrT7NOTcBYuAxXunhnpr0wzGzDvF_RQusgQ>
    <xmx:Kr16ZXwwKqrFGqB9Cs-21rg3LkAIAJpaKVgwldeOBFaiZGh0iVobpg>
    <xmx:Kr16ZXhw8G2YmPfd7zEl0-T5AttGTTgH1894OZWZxYNmxDTRIREfyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 03:30:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ca79b8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 08:28:48 +0000 (UTC)
Date: Thu, 14 Dec 2023 09:30:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] tests: adjust whitespace in chainlint expectations
Message-ID: <aec86a15c69aa276eee4875fad208ee2fc57635a.1702542564.git.ps@pks.im>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ley1KOd5qUgWfBeO"
Content-Disposition: inline
In-Reply-To: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>


--Ley1KOd5qUgWfBeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "check-chainlint" target runs automatically when running tests and
performs self-checks to verify that the chainlinter itself produces the
expected output. Originally, the chainlinter was implemented via sed,
but the infrastructure has been rewritten in fb41727b7e (t: retire
unused chainlint.sed, 2022-09-01) to use a Perl script instead.

The rewrite caused some slight whitespace changes in the output that are
ultimately not of much importance. In order to be able to assert that
the actual chainlinter errors match our expectations we thus have to
ignore whitespace characters when diffing them. As the `-w` flag is not
in POSIX we try to use `git diff -w --no-index` before we fall back to
`diff -w -u`.

To accomodate for cases where the host system has no Git installation we
use the locally-compiled version of Git. This can result in problems
though when the Git project's repository is using extensions that the
locally-compiled version of Git doesn't understand. It will refuse to
run and thus cause the checks to fail.

Instead of improving the detection logic, fix our ".expect" files so
that we do not need any post-processing anymore. This allows us to drop
the `-w` flag when diffing so that we can always use diff(1) now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile                                    | 10 +-------
 t/chainlint/blank-line-before-esac.expect     |  8 +++----
 t/chainlint/block.expect                      |  4 ++--
 t/chainlint/chain-break-background.expect     |  4 ++--
 t/chainlint/chain-break-return-exit.expect    | 14 +++++------
 t/chainlint/chain-break-status.expect         |  4 ++--
 t/chainlint/chained-subshell.expect           |  4 ++--
 .../command-substitution-subsubshell.expect   |  2 +-
 t/chainlint/dqstring-line-splice.expect       |  4 ++--
 t/chainlint/dqstring-no-interpolate.expect    |  4 ++--
 t/chainlint/empty-here-doc.expect             |  4 ++--
 t/chainlint/exclamation.expect                |  2 +-
 t/chainlint/for-loop-abbreviated.expect       |  2 +-
 t/chainlint/function.expect                   |  4 ++--
 t/chainlint/here-doc.expect                   |  4 ++--
 t/chainlint/loop-detect-status.expect         | 20 ++++++++--------
 t/chainlint/nested-loop-detect-failure.expect | 24 +++++++++----------
 t/chainlint/subshell-here-doc.expect          |  4 ++--
 t/chainlint/token-pasting.expect              | 14 +++++------
 19 files changed, 64 insertions(+), 72 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 225aaf78ed..3a5d81b7fe 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -108,15 +108,7 @@ check-chainlint:
 	} >'$(CHAINLINTTMP_SQ)'/expect && \
 	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
 		sed -e 's/^[1-9][0-9]* //;/^[ 	]*$$/d' >'$(CHAINLINTTMP_SQ)'/actual && \
-	if test -f ../GIT-BUILD-OPTIONS; then \
-		. ../GIT-BUILD-OPTIONS; \
-	fi && \
-	if test -x ../git$$X; then \
-		DIFFW=3D"../git$$X --no-pager diff -w --no-index"; \
-	else \
-		DIFFW=3D"diff -w -u"; \
-	fi && \
-	$$DIFFW '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
+	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
=20
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-synta=
x \
 	test-lint-filenames
diff --git a/t/chainlint/blank-line-before-esac.expect b/t/chainlint/blank-=
line-before-esac.expect
index 48ed4eb124..056e03003d 100644
--- a/t/chainlint/blank-line-before-esac.expect
+++ b/t/chainlint/blank-line-before-esac.expect
@@ -1,11 +1,11 @@
-test_done ( ) {
+test_done () {
 	case "$test_failure" in
-	0 )
+	0)
 		test_at_end_hook_
=20
 		exit 0 ;;
=20
-	* )
+	*)
 		if test $test_external_has_tap -eq 0
 		then
 			say_color error "# failed $test_failure among $msg"
@@ -14,5 +14,5 @@ test_done ( ) {
=20
 		exit 1 ;;
=20
-		esac
+	esac
 }
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index a3bcea492a..1c87326364 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -12,9 +12,9 @@
 ) &&
=20
 {
-	echo a ; ?!AMP?! echo b
+	echo a; ?!AMP?! echo b
 } &&
-{ echo a ; ?!AMP?! echo b ; } &&
+{ echo a; ?!AMP?! echo b; } &&
=20
 {
 	echo "${var}9" &&
diff --git a/t/chainlint/chain-break-background.expect b/t/chainlint/chain-=
break-background.expect
index 28f9114f42..20d0bb5333 100644
--- a/t/chainlint/chain-break-background.expect
+++ b/t/chainlint/chain-break-background.expect
@@ -1,9 +1,9 @@
 JGIT_DAEMON_PID=3D &&
 git init --bare empty.git &&
-> empty.git/git-daemon-export-ok &&
+>empty.git/git-daemon-export-ok &&
 mkfifo jgit_daemon_output &&
 {
-	jgit daemon --port=3D"$JGIT_DAEMON_PORT" . > jgit_daemon_output &
+	jgit daemon --port=3D"$JGIT_DAEMON_PORT" . >jgit_daemon_output &
 	JGIT_DAEMON_PID=3D$!
 } &&
 test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_=
PORT/empty.git
diff --git a/t/chainlint/chain-break-return-exit.expect b/t/chainlint/chain=
-break-return-exit.expect
index 1732d221c3..4cd18e2edf 100644
--- a/t/chainlint/chain-break-return-exit.expect
+++ b/t/chainlint/chain-break-return-exit.expect
@@ -1,16 +1,16 @@
 case "$(git ls-files)" in
-one ) echo pass one ;;
-* ) echo bad one ; return 1 ;;
+one) echo pass one ;;
+*) echo bad one; return 1 ;;
 esac &&
 (
 	case "$(git ls-files)" in
-	two ) echo pass two ;;
-	* ) echo bad two ; exit 1 ;;
-esac
+	two) echo pass two ;;
+	*) echo bad two; exit 1 ;;
+	esac
 ) &&
 case "$(git ls-files)" in
-dir/two"$LF"one ) echo pass both ;;
-* ) echo bad ; return 1 ;;
+dir/two"$LF"one) echo pass both ;;
+*) echo bad; return 1 ;;
 esac &&
=20
 for i in 1 2 3 4 ; do
diff --git a/t/chainlint/chain-break-status.expect b/t/chainlint/chain-brea=
k-status.expect
index f4bada9463..e6b3b2193e 100644
--- a/t/chainlint/chain-break-status.expect
+++ b/t/chainlint/chain-break-status.expect
@@ -1,7 +1,7 @@
-OUT=3D$(( ( large_git ; echo $? 1 >& 3 ) | : ) 3 >& 1) &&
+OUT=3D$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
 test_match_signal 13 "$OUT" &&
=20
-{ test-tool sigchain > actual ; ret=3D$? ; } &&
+{ test-tool sigchain >actual; ret=3D$?; } &&
 {
 	test_match_signal 15 "$ret" ||
 	test "$ret" =3D 3
diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subs=
hell.expect
index af0369d328..83810ea7ec 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -4,7 +4,7 @@ mkdir sub && (
 	nuff said
 ) &&
=20
-cut "-d " -f actual | ( read s1 s2 s3 &&
+cut "-d " -f actual | (read s1 s2 s3 &&
 test -f $s1 ?!AMP?!
 test $(cat $s2) =3D tree2path1 &&
-test $(cat $s3) =3D tree3path1 )
+test $(cat $s3) =3D tree3path1)
diff --git a/t/chainlint/command-substitution-subsubshell.expect b/t/chainl=
int/command-substitution-subsubshell.expect
index ab2f79e845..ec42f2c30c 100644
--- a/t/chainlint/command-substitution-subsubshell.expect
+++ b/t/chainlint/command-substitution-subsubshell.expect
@@ -1,2 +1,2 @@
-OUT=3D$(( ( large_git 1 >& 3 ) | : ) 3 >& 1) &&
+OUT=3D$( ((large_git 1>&3) | :) 3>&1 ) &&
 test_match_signal 13 "$OUT"
diff --git a/t/chainlint/dqstring-line-splice.expect b/t/chainlint/dqstring=
-line-splice.expect
index bf9ced60d4..f8fa3bc969 100644
--- a/t/chainlint/dqstring-line-splice.expect
+++ b/t/chainlint/dqstring-line-splice.expect
@@ -1,3 +1,3 @@
-echo 'fatal: reword option of --fixup is mutually exclusive with' '--patch=
/--interactive/--all/--include/--only' > expect &&
-test_must_fail git commit --fixup=3Dreword:HEAD~ $1 2 > actual &&
+echo 'fatal: reword option of --fixup is mutually exclusive with'	'--patch=
/--interactive/--all/--include/--only' >expect &&
+test_must_fail git commit --fixup=3Dreword:HEAD~ $1 2>actual &&
 test_cmp expect actual
diff --git a/t/chainlint/dqstring-no-interpolate.expect b/t/chainlint/dqstr=
ing-no-interpolate.expect
index 10724987a5..2c1851a3c3 100644
--- a/t/chainlint/dqstring-no-interpolate.expect
+++ b/t/chainlint/dqstring-no-interpolate.expect
@@ -6,6 +6,6 @@ grep "^\.git$" output.txt &&
 (
 	cd client$version &&
 	GIT_TEST_PROTOCOL_VERSION=3D$version git fetch-pack --no-progress .. $(ca=
t ../input)
-) > output &&
-	cut -d ' ' -f 2 < output | sort > actual &&
+) >output &&
+	cut -d ' ' -f 2 <output | sort >actual &&
 	test_cmp expect actual
diff --git a/t/chainlint/empty-here-doc.expect b/t/chainlint/empty-here-doc=
=2Eexpect
index e8733c97c6..8507721192 100644
--- a/t/chainlint/empty-here-doc.expect
+++ b/t/chainlint/empty-here-doc.expect
@@ -1,4 +1,4 @@
-git ls-tree $tree path > current &&
-cat > expected <<\EOF &&
+git ls-tree $tree path >current &&
+cat >expected <<\EOF &&
 EOF
 test_output
diff --git a/t/chainlint/exclamation.expect b/t/chainlint/exclamation.expect
index 2d961a58c6..765a35bb4c 100644
--- a/t/chainlint/exclamation.expect
+++ b/t/chainlint/exclamation.expect
@@ -1,4 +1,4 @@
-if ! condition ; then echo nope ; else yep ; fi &&
+if ! condition; then echo nope; else yep; fi &&
 test_prerequisite !MINGW &&
 mail uucp!address &&
 echo !whatever!
diff --git a/t/chainlint/for-loop-abbreviated.expect b/t/chainlint/for-loop=
-abbreviated.expect
index a21007a63f..02c0d15cca 100644
--- a/t/chainlint/for-loop-abbreviated.expect
+++ b/t/chainlint/for-loop-abbreviated.expect
@@ -1,5 +1,5 @@
 for it
 do
-	path=3D$(expr "$it" : ( [^:]*) ) &&
+	path=3D$(expr "$it" : ([^:]*)) &&
 	git update-index --add "$path" || exit
 done
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
index a14388e6b9..dd7c997a3c 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -1,8 +1,8 @@
-sha1_file ( ) {
+sha1_file() {
 	echo "$*" | sed "s#..#.git/objects/&/#"
 } &&
=20
-remove_object ( ) {
+remove_object() {
 	file=3D$(sha1_file "$*") &&
 	test -e "$file" ?!AMP?!
 	rm -f "$file"
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 1df3f78282..91b961242a 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -1,6 +1,6 @@
 boodle wobba \
-	gorgo snoot \
-	wafta snurb <<EOF &&
+       gorgo snoot \
+       wafta snurb <<EOF &&
 quoth the raven,
 nevermore...
 EOF
diff --git a/t/chainlint/loop-detect-status.expect b/t/chainlint/loop-detec=
t-status.expect
index 24da9e86d5..7ce3a34806 100644
--- a/t/chainlint/loop-detect-status.expect
+++ b/t/chainlint/loop-detect-status.expect
@@ -1,18 +1,18 @@
-( while test $i -le $blobcount
-do
-	printf "Generating blob $i/$blobcount\r" >& 2 &&
+(while test $i -le $blobcount
+ do
+	printf "Generating blob $i/$blobcount\r" >&2 &&
 	printf "blob\nmark :$i\ndata $blobsize\n" &&
 	#test-tool genrandom $i $blobsize &&
 	printf "%-${blobsize}s" $i &&
 	echo "M 100644 :$i $i" >> commit &&
 	i=3D$(($i+1)) ||
 	echo $? > exit-status
-done &&
-echo "commit refs/heads/main" &&
-echo "author A U Thor <author@email.com> 123456789 +0000" &&
-echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
-echo "data 5" &&
-echo ">2gb" &&
-cat commit ) |
+ done &&
+ echo "commit refs/heads/main" &&
+ echo "author A U Thor <author@email.com> 123456789 +0000" &&
+ echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
+ echo "data 5" &&
+ echo ">2gb" &&
+ cat commit) |
 git fast-import --big-file-threshold=3D2 &&
 test ! -f exit-status
diff --git a/t/chainlint/nested-loop-detect-failure.expect b/t/chainlint/ne=
sted-loop-detect-failure.expect
index 4793a0e8e1..3461df40e5 100644
--- a/t/chainlint/nested-loop-detect-failure.expect
+++ b/t/chainlint/nested-loop-detect-failure.expect
@@ -1,31 +1,31 @@
-for i in 0 1 2 3 4 5 6 7 8 9 ;
+for i in 0 1 2 3 4 5 6 7 8 9;
 do
-	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	for j in 0 1 2 3 4 5 6 7 8 9;
 	do
-		echo "$i$j" > "path$i$j" ?!LOOP?!
+		echo "$i$j" >"path$i$j" ?!LOOP?!
 	done ?!LOOP?!
 done &&
=20
-for i in 0 1 2 3 4 5 6 7 8 9 ;
+for i in 0 1 2 3 4 5 6 7 8 9;
 do
-	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	for j in 0 1 2 3 4 5 6 7 8 9;
 	do
-		echo "$i$j" > "path$i$j" || return 1
+		echo "$i$j" >"path$i$j" || return 1
 	done
 done &&
=20
-for i in 0 1 2 3 4 5 6 7 8 9 ;
+for i in 0 1 2 3 4 5 6 7 8 9;
 do
-	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	for j in 0 1 2 3 4 5 6 7 8 9;
 	do
-		echo "$i$j" > "path$i$j" ?!LOOP?!
+		echo "$i$j" >"path$i$j" ?!LOOP?!
 	done || return 1
 done &&
=20
-for i in 0 1 2 3 4 5 6 7 8 9 ;
+for i in 0 1 2 3 4 5 6 7 8 9;
 do
-	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	for j in 0 1 2 3 4 5 6 7 8 9;
 	do
-		echo "$i$j" > "path$i$j" || return 1
+		echo "$i$j" >"path$i$j" || return 1
 	done || return 1
 done
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-he=
re-doc.expect
index 52789278d1..75d6f607e2 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -1,7 +1,7 @@
 (
 	echo wobba \
-		gorgo snoot \
-		wafta snurb <<-EOF &&
+	       gorgo snoot \
+	       wafta snurb <<-EOF &&
 	quoth the raven,
 	nevermore...
 	EOF
diff --git a/t/chainlint/token-pasting.expect b/t/chainlint/token-pasting.e=
xpect
index 342360bcd0..6a387917a7 100644
--- a/t/chainlint/token-pasting.expect
+++ b/t/chainlint/token-pasting.expect
@@ -4,22 +4,22 @@ git config filter.rot13.clean ./rot13.sh &&
 {
     echo "*.t filter=3Drot13" ?!AMP?!
     echo "*.i ident"
-} > .gitattributes &&
+} >.gitattributes &&
=20
 {
     echo a b c d e f g h i j k l m ?!AMP?!
     echo n o p q r s t u v w x y z ?!AMP?!
     echo '$Id$'
-} > test &&
-cat test > test.t &&
-cat test > test.o &&
-cat test > test.i &&
+} >test &&
+cat test >test.t &&
+cat test >test.o &&
+cat test >test.i &&
 git add test test.t test.i &&
 rm -f test test.t test.i &&
 git checkout -- test test.t test.i &&
=20
-echo "content-test2" > test2.o &&
-echo "content-test3 - filename with special characters" > "test3 'sq',$x=
=3D.o" ?!AMP?!
+echo "content-test2" >test2.o &&
+echo "content-test3 - filename with special characters" >"test3 'sq',$x=3D=
=2Eo" ?!AMP?!
=20
 downstream_url_for_sed=3D$(
 	printf "%sn" "$downstream_url" |
--=20
2.43.GIT


--Ley1KOd5qUgWfBeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV6vSQACgkQVbJhu7ck
PpS7SQ//fCkb8HjnFP+jLuTaupWwdugc6NPLdY1zbphkj1tp2UCxsx5dA46UfPK3
KS2MnhDTkH3VBnWM15B1dmQUWw9z0gMVWGvcFqz8JefpsAEWDNSRs3wgKwhHEm0t
r9Inwr3bQh431xvlFUezVvhwlm4b0YPhpRI+I2NOT4RUBo9kcK7JrBSXsIm1iEN/
Vc7hsR9pM+1+Iud9IuRcI06p16oCSYwEpGXC/6SZmeus1zbPEFsKrOWxqkzRuEVS
dYTavhvQQ1OZV7pQClxq5WqteXfwxcqM0o8CQtNDjVXc7iBuMzTohfLdyyMbut5S
dC/5peHx4XGOB8T/tuAwi3SEZGBEB13XFyogFtCpIyul3GLsE5tS45w0O82tAEfc
POSpQD7y1ktWIxjVt9H85zSNyNrnk9PgrhDHUwLFUNZsSumjFyjiTI7lAsHU53Sp
QJ3e+7Gmvz9ySdBlV+wielFswDnFiT1J954lb8TPcKzm9f6xFdMyvW9bAJsLS+bp
TZyMz4wrSwjSke/Gs0zVbQ38wgRNzVLmV3RmGf1ZbhU7krQXStTWlsGIIAvgflgF
nrGFGR2lp9vcXX965ESIO6t8M8uxFz39Dh94NpqcnCKeQmgNGtupJeJw8pEgz9WV
Bd4J0f3onIbDPyjr22KxJ82YOFMqdTHZDbd484/1K/2p9ZpYwNg=
=WOSH
-----END PGP SIGNATURE-----

--Ley1KOd5qUgWfBeO--
