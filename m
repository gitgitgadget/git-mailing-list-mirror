Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A4101C5
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nIWyuwK9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZzphWy7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2CD895C012B;
	Fri, 15 Dec 2023 01:42:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 01:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702622571; x=1702708971; bh=9KblgTu5hZ
	qf+wEEmJYsVB36JJX8IUsT/uXDSDudT4U=; b=nIWyuwK9eb8m9QdUJ3Dyp05dN7
	Fopycze77+kWuNKjIeP8eYTQ22NSnNPfPCMzdZj4ied555Y9AezyRBECuwiaO3+R
	lxAaZGRg20QZE804MbNsiMgckAoLOWA3uYvTHlRjKNxwQeocJH6ldVwlGTJCPRPt
	PSDxrvmjwWyI+P5uppxmoduQ9sSZ2D7RtjYiiUkZHlNOvSzzMYwucjEIn3ErrT8i
	rBfGwI/XQCtzTqAZzn1NmPtKC5UWYdrLUgWrLbCO5uViK3Qu1xGrOOUYQuLwWkq+
	x3tq0m5e8F75PlFEkUb1yOJho9ZShRYX4FPiyUQ4QxAEctxSCk4YVr2URxyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702622571; x=1702708971; bh=9KblgTu5hZqf+wEEmJYsVB36JJX8
	IUsT/uXDSDudT4U=; b=rZzphWy7grPpegwQLuejEJcRecP16dO7nNKM4Sm7p7/U
	InH7zJe4DVySOb56hK0PgssV4Dajh3eprMSAS4KPMG5Jbt5QQSM+rKpTEMNFq0mb
	sF4P2FbQn2foluxb3zYsFQ5EaDh5d0luK87XB4x3+2T8xPpD+AyMoMpVaydPmm53
	2J2YehqhagY6eViQXE/1wdCrqxz59U4OF/kturn/BWJSQzIKEHJFVJVcQk1zsZAw
	SBF3ajtFz9rO+vtajwbUdunM+8RkKHfXhm96BCor4dPh6jtrQVr1g5eAW6JeupwU
	hdNkXP+PhzlUtGjhfzYJOBSmUQB1VmYltAVsSNzktA==
X-ME-Sender: <xms:a_V7Zbi9ViiVbvpYRj1Acf5mfvEOHcGGSwcOjJQWR9RNglHp0JObcg>
    <xme:a_V7ZYAz-NgA2KZ-FjnR5f9HeYWWrS2yfWyPM5erQnpte1VqiGB5ZcZ73Wx9s_G99
    CdEQ13DRjW8RjyIqw>
X-ME-Received: <xmr:a_V7ZbFFU9GYI-sc-pt5xaGeziCq_odKF4B9meaxQ2UQhLiwm5JsgZ6yKPwx4KktweFEExc1vTlbGGDHhgHJk04EhwG1iaZ2aSR96UEXTQ6vWOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtuddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:a_V7ZYQeIfO1H959jv15Zk7pqkVmtuwhog4GCxGN1UkaEFIFCK2uYA>
    <xmx:a_V7ZYxaeBzxNrrbjWnEaxREJKYf6LwwLAWxP4yCb5mTuV2nOYte0g>
    <xmx:a_V7Ze7xjqJ4Y2SHpnrOmExEfls9cNkdxtefa3I2qDfWTGr7DaeBbw>
    <xmx:a_V7ZVr2o2k33Boh0XGwk7omGtvEsJOOqX-p5JJ3DvT2Pyl7D1Ke4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 01:42:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 956c9200 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 06:41:04 +0000 (UTC)
Date: Fri, 15 Dec 2023 07:42:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4] tests: adjust whitespace in chainlint expectations
Message-ID: <fb312f559de7b99244e4c86a995250599cd9be06.1702622508.git.ps@pks.im>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6hDo4Bl7TurPkGw"
Content-Disposition: inline
In-Reply-To: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>


--p6hDo4Bl7TurPkGw
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
that we do not need any post-processing at all anymore. This allows us
to drop the `-w` flag when diffing so that we can always use diff(1)
now.

Note that we keep some of the post-processing of `chainlint.pl` output
intact to strip leading line numbers generated by the script. Having
these would cause a rippling effect whenever we add a new test that
sorts into the middle of existing tests and would require us to
renumerate all subsequent lines, which seems rather pointless.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile                                    | 14 +++--------
 t/chainlint/blank-line-before-esac.expect     |  8 +++----
 t/chainlint/blank-line.expect                 |  4 ++++
 t/chainlint/block.expect                      |  4 ++--
 t/chainlint/chain-break-background.expect     |  4 ++--
 t/chainlint/chain-break-return-exit.expect    | 14 +++++------
 t/chainlint/chain-break-status.expect         |  4 ++--
 t/chainlint/chained-subshell.expect           |  4 ++--
 .../command-substitution-subsubshell.expect   |  2 +-
 t/chainlint/dqstring-line-splice.expect       |  6 +++--
 t/chainlint/dqstring-no-interpolate.expect    |  5 ++--
 t/chainlint/empty-here-doc.expect             |  4 ++--
 t/chainlint/exclamation.expect                |  2 +-
 t/chainlint/for-loop-abbreviated.expect       |  2 +-
 t/chainlint/for-loop.expect                   |  1 +
 t/chainlint/function.expect                   |  4 ++--
 t/chainlint/here-doc.expect                   |  4 ++--
 t/chainlint/loop-detect-status.expect         | 20 ++++++++--------
 t/chainlint/nested-cuddled-subshell.expect    |  6 +++++
 t/chainlint/nested-loop-detect-failure.expect | 24 +++++++++----------
 t/chainlint/nested-subshell.expect            |  1 +
 t/chainlint/pipe.expect                       |  2 ++
 t/chainlint/subshell-here-doc.expect          |  4 ++--
 t/chainlint/subshell-one-liner.expect         |  5 ++++
 t/chainlint/t7900-subtree.expect              |  1 +
 t/chainlint/token-pasting.expect              | 14 +++++------
 t/chainlint/while-loop.expect                 |  1 +
 27 files changed, 90 insertions(+), 74 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 225aaf78ed..b7a6fefe28 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -103,20 +103,12 @@ check-chainlint:
 		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
 		for i in $(CHAINLINTTESTS); do \
 			echo "# chainlint: $$i" && \
-			sed -e '/^[ 	]*$$/d' chainlint/$$i.expect; \
+			cat chainlint/$$i.expect; \
 		done \
 	} >'$(CHAINLINTTMP_SQ)'/expect && \
 	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
-		sed -e 's/^[1-9][0-9]* //;/^[ 	]*$$/d' >'$(CHAINLINTTMP_SQ)'/actual && \
-	if test -f ../GIT-BUILD-OPTIONS; then \
-		. ../GIT-BUILD-OPTIONS; \
-	fi && \
-	if test -x ../git$$X; then \
-		DIFFW=3D"../git$$X --no-pager diff -w --no-index"; \
-	else \
-		DIFFW=3D"diff -w -u"; \
-	fi && \
-	$$DIFFW '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
+		sed -e 's/^[1-9][0-9]* //' >'$(CHAINLINTTMP_SQ)'/actual && \
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
diff --git a/t/chainlint/blank-line.expect b/t/chainlint/blank-line.expect
index f76fde1ffb..b47827d749 100644
--- a/t/chainlint/blank-line.expect
+++ b/t/chainlint/blank-line.expect
@@ -1,4 +1,8 @@
 (
+
 	nothing &&
+
 	something
+
+
 )
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
index bf9ced60d4..37eab80738 100644
--- a/t/chainlint/dqstring-line-splice.expect
+++ b/t/chainlint/dqstring-line-splice.expect
@@ -1,3 +1,5 @@
-echo 'fatal: reword option of --fixup is mutually exclusive with' '--patch=
/--interactive/--all/--include/--only' > expect &&
-test_must_fail git commit --fixup=3Dreword:HEAD~ $1 2 > actual &&
+
+echo 'fatal: reword option of --fixup is mutually exclusive with'	'--patch=
/--interactive/--all/--include/--only' >expect &&
+test_must_fail git commit --fixup=3Dreword:HEAD~ $1 2>actual &&
 test_cmp expect actual
+
diff --git a/t/chainlint/dqstring-no-interpolate.expect b/t/chainlint/dqstr=
ing-no-interpolate.expect
index 10724987a5..087eda15e4 100644
--- a/t/chainlint/dqstring-no-interpolate.expect
+++ b/t/chainlint/dqstring-no-interpolate.expect
@@ -6,6 +6,7 @@ grep "^\.git$" output.txt &&
 (
 	cd client$version &&
 	GIT_TEST_PROTOCOL_VERSION=3D$version git fetch-pack --no-progress .. $(ca=
t ../input)
-) > output &&
-	cut -d ' ' -f 2 < output | sort > actual &&
+) >output &&
+	cut -d ' ' -f 2 <output | sort >actual &&
 	test_cmp expect actual
+
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
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index d65c82129a..d2237f1e38 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -6,6 +6,7 @@
 		bar
 		EOF
 	done ?!AMP?!
+
 	for i in a b c; do
 		echo $i &&
 		cat $i ?!LOOP?!
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
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/neste=
d-cuddled-subshell.expect
index 2a86885ee6..3836049cc4 100644
--- a/t/chainlint/nested-cuddled-subshell.expect
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -2,18 +2,24 @@
 	(cd foo &&
 		bar
 	) &&
+
 	(cd foo &&
 		bar
 	) ?!AMP?!
+
 	(
 		cd foo &&
 		bar) &&
+
 	(
 		cd foo &&
 		bar) ?!AMP?!
+
 	(cd foo &&
 		bar) &&
+
 	(cd foo &&
 		bar) ?!AMP?!
+
 	foobar
 )
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
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshe=
ll.expect
index 02e0a9f1bb..73ff28546a 100644
--- a/t/chainlint/nested-subshell.expect
+++ b/t/chainlint/nested-subshell.expect
@@ -4,6 +4,7 @@
 		echo a &&
 		echo b
 	) >file &&
+
 	cd foo &&
 	(
 		echo a ?!AMP?!
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
index 2cfc028297..811971b1a3 100644
--- a/t/chainlint/pipe.expect
+++ b/t/chainlint/pipe.expect
@@ -2,7 +2,9 @@
 	foo |
 	bar |
 	baz &&
+
 	fish |
 	cow ?!AMP?!
+
 	sunder
 )
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
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-o=
ne-liner.expect
index b7015361bf..8f694990e8 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -2,13 +2,18 @@
 	(foo && bar) &&
 	(foo && bar) |
 	(foo && bar) >baz &&
+
 	(foo; ?!AMP?! bar) &&
 	(foo; ?!AMP?! bar) |
 	(foo; ?!AMP?! bar) >baz &&
+
 	(foo || exit 1) &&
 	(foo || exit 1) |
 	(foo || exit 1) >baz &&
+
 	(foo && bar) ?!AMP?!
+
 	(foo && bar; ?!AMP?! baz) ?!AMP?!
+
 	foobar
 )
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.e=
xpect
index 71b3b3bc20..02f3129232 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -15,6 +15,7 @@ main-sub4" &&
 $chkms
 TXT
 ) &&
+
 	subfiles=3D$(git ls-files) &&
 	check_equal "$subfiles" "$chkms
 $chks"
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
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index 1f5eaea0fd..06c1567f48 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -6,6 +6,7 @@
 		bar
 		EOF
 	done ?!AMP?!
+
 	while true; do
 		echo foo &&
 		cat bar ?!LOOP?!
--=20
2.43.GIT


--p6hDo4Bl7TurPkGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV79WYACgkQVbJhu7ck
PpQWcg//QcNv7naJEotyLvTQ1nKevx1yrLEIkvJfpVSnn1J4DQu3RgrMJzQk7nUL
C87Gx4mZyqdhjSnMIBWZuZJNleCGNPlRlLOvdrLsu9JiVZ2WIEsCHdmreS/In2S3
OuJZjOXAFyf/CvkoOZdyMkp8FwOuCFy1YXs3ogmVTZ7/Gwwf3wZrDL/2xfTPYfRn
FOX5wzKvUAzM9ji4fjX4EAmDJwD2f6iK48KAyV3JoIbDUmXi0S3A3s9qqkUqHaNh
m/XppokSLRa+aUtzz5GgMU37vdFXeAT7nhjlbtxdPl2MYWvy0rhGZnN1UJz4Szo4
aaU7RX9hgMN5O+mcYdaDczLvtw/0RvZDtDNKGqwXOhLcZDlBuZ/yWhRhI1e35xsi
A6NLBM3srTdWA0NzfRtFTbWlPFOW0n6Gan3lbCwuP0ObnDqJLofzEAK6sFhChj7a
0WwLhDBGjAil38z07SFmrUK72aBMfrOJA+Ni+JgzKo9Zy5CjhclEgSQ6Lyht21mi
MWuMVg1AgnKWqvSPmb/YGSuDwkRrTLj8UFY0NgJsF+PdtrXFZE8pJFkEPTn1bpMV
MgZbEFA8vQx0XCzYaTzVxH+Qz6P3XmwuMpIL3SQOtNEIyxKsdQwnMPkqhQtgmYAZ
F5bZATsHqCTsoX9DI/yjKblBPKzIOiDuoJfNJ1JGLvrt+jh46fY=
=bdfF
-----END PGP SIGNATURE-----

--p6hDo4Bl7TurPkGw--
