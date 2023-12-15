Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB86FA1
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MfOHMc/Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9LMhc7A"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5FFBA5C021F;
	Fri, 15 Dec 2023 01:04:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 15 Dec 2023 01:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702620275; x=1702706675; bh=mtdXxONsl7
	Y10mA5+Eowc+U08RtjIikhRw7H2GFjhkI=; b=MfOHMc/ZMgCVMlMSpkte+d/5aL
	0vfVGy5IwMkgz2NLYJv5vM0Xzpqn3NsbY9iS2nq5rjl5z180rK+bZV+KHxfLttFY
	VnXBq5jMvsli/9G37oMOKl1icq9M/Q3P6EKF/nG1H/UlmOnztdCNULTcjdosd2un
	Cci/fS5mWmIR6hoUSEifC2mX19bTZF5aKciMGjhLRb2tvzJKoHb4lj99/YPmXvun
	dRTN8TOvxT5cb4LVpLmO//C3Up/ZaVEYpWn8YI8P9LEfks3lFyvmcyEvyx+V208q
	7N4P4pit7YYYuItCbNqNPq1fjKdKK31U5ToDh66S95ulR54qrXVsRP9o7oeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702620275; x=1702706675; bh=mtdXxONsl7Y10mA5+Eowc+U08Rtj
	IikhRw7H2GFjhkI=; b=O9LMhc7AWtqlKo1GUlnkECfrSy6kG5QK9zYVNdLe5pDp
	mQMozK2xyhc7sGfxhIhMLi1t6xzFdv/XTL9gu8kBpyiRbsNTWDt+C6VYpj1ZKBKp
	cfJHhPCMDkfMnW1UqDipreeEtSgC+S3cdAB6bijH6UuDX6q1uc5g+RgtC9bXW9In
	/Bjbt4xxP4t69Psv6sw5YrCNWvDbiemHW1i0qvtWf6qs+g8q5R4PMSL94FZUZSrs
	wAVyvKUE9DGWr0DQvB3MysaQNivbISt21fUuOGOg0+ZIRZYNkGAAAy/Ab3Zwi0L/
	GvkkCDMg956unCaZ6bbYml6O3sUYoWgg7KylTqYYAg==
X-ME-Sender: <xms:c-x7ZX6EssKItk5v5tOb9pAqSAaj1o73WH-ydzZgqH-VnlB7CYWxKg>
    <xme:c-x7Zc65KfkDqp0HA5wNs1zYRtaHLFnjKRKnbiFX9gj4Cn9DTQCiC-rr_eOTlXOio
    lW30xuMwics6EyZdg>
X-ME-Received: <xmr:c-x7ZeeI-3gRvUVa57DhZqz7gv8-JexdBpmql5IQHz5Pb_6RestVChDZxfs5vQW1chf6NGqO24DLI-5P8Qkm1nglO1gvTv7oqxjjxyiKbeOrV4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:c-x7ZYJA8Eu1yGJS1ZhpfW2B0jgRAz_HJbxyey6Sppsz95LNTW-t9Q>
    <xmx:c-x7ZbIHXJ-limZPeExaV-hDN4T5oD7RerGcPCmRNtoRG8_9qgZDCg>
    <xmx:c-x7ZRzPF35kD_d6sTpe_FyL60C67kNzEPC-vKn55kRcFsdP4ap2Xw>
    <xmx:c-x7ZRgaKi7jB7xgDwVevIhxfTmCa__Sd_iWgab68gKdUC_5ZcBR8g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 01:04:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bdee0482 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 06:02:48 +0000 (UTC)
Date: Fri, 15 Dec 2023 07:04:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] tests: adjust whitespace in chainlint expectations
Message-ID: <8c3e1cb5eae13210070cc14f5f2a3f8c0dfc39c3.1702620230.git.ps@pks.im>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mdtm6Uf6RTrKJ/8g"
Content-Disposition: inline
In-Reply-To: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>


--Mdtm6Uf6RTrKJ/8g
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

Note that we leave the post-processing of `chainlint.pl` output intact.
All we do here is to strip leading line numbers that it would otherwise
generate. Having these would cause a rippling effect whenever we add a
new test that sorts into the middle of existing tests and would require
us to renumerate all subsequent lines, which seems rather pointless.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile                                    | 12 ++-------
 t/chainlint/blank-line-before-esac.expect     | 12 +++------
 t/chainlint/block.expect                      |  6 ++---
 t/chainlint/chain-break-background.expect     |  4 +--
 t/chainlint/chain-break-continue.expect       |  1 -
 t/chainlint/chain-break-return-exit.expect    | 15 +++++------
 t/chainlint/chain-break-status.expect         |  5 ++--
 t/chainlint/chained-block.expect              |  1 -
 t/chainlint/chained-subshell.expect           |  5 ++--
 .../command-substitution-subsubshell.expect   |  2 +-
 t/chainlint/cuddled.expect                    |  4 ---
 t/chainlint/dqstring-line-splice.expect       |  4 +--
 t/chainlint/dqstring-no-interpolate.expect    |  7 ++---
 t/chainlint/empty-here-doc.expect             |  4 +--
 t/chainlint/exclamation.expect                |  2 +-
 t/chainlint/for-loop-abbreviated.expect       |  2 +-
 t/chainlint/function.expect                   |  6 ++---
 t/chainlint/here-doc-indent-operator.expect   |  2 --
 t/chainlint/here-doc.expect                   |  7 ++---
 t/chainlint/inline-comment.expect             |  1 -
 t/chainlint/loop-detect-failure.expect        |  1 -
 t/chainlint/loop-detect-status.expect         | 20 +++++++-------
 t/chainlint/negated-one-liner.expect          |  1 -
 t/chainlint/nested-here-doc.expect            |  3 ---
 t/chainlint/nested-loop-detect-failure.expect | 27 +++++++++----------
 t/chainlint/not-heredoc.expect                |  1 -
 t/chainlint/one-liner.expect                  |  2 --
 t/chainlint/subshell-here-doc.expect          |  6 ++---
 t/chainlint/token-pasting.expect              | 18 +++++--------
 29 files changed, 65 insertions(+), 116 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 225aaf78ed..ab620cf732 100644
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
index 48ed4eb124..7400a1df7e 100644
--- a/t/chainlint/blank-line-before-esac.expect
+++ b/t/chainlint/blank-line-before-esac.expect
@@ -1,18 +1,14 @@
-test_done ( ) {
+test_done () {
 	case "$test_failure" in
-	0 )
+	0)
 		test_at_end_hook_
-
 		exit 0 ;;
-
-	* )
+	*)
 		if test $test_external_has_tap -eq 0
 		then
 			say_color error "# failed $test_failure among $msg"
 			say "1..$test_count"
 		fi
-
 		exit 1 ;;
-
-		esac
+	esac
 }
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index a3bcea492a..569211de08 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -10,12 +10,10 @@
 	} ?!AMP?!
 	baz
 ) &&
-
 {
-	echo a ; ?!AMP?! echo b
+	echo a; ?!AMP?! echo b
 } &&
-{ echo a ; ?!AMP?! echo b ; } &&
-
+{ echo a; ?!AMP?! echo b; } &&
 {
 	echo "${var}9" &&
 	echo "done"
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
diff --git a/t/chainlint/chain-break-continue.expect b/t/chainlint/chain-br=
eak-continue.expect
index 47a3457710..fa00c9fdda 100644
--- a/t/chainlint/chain-break-continue.expect
+++ b/t/chainlint/chain-break-continue.expect
@@ -4,7 +4,6 @@ do
 	test "$path" =3D "foobar/non-note.txt" && continue
 	test "$path" =3D "deadbeef" && continue
 	test "$path" =3D "de/adbeef" && continue
-
 	if test $(expr length "$path") -ne $hexsz
 	then
 		return 1
diff --git a/t/chainlint/chain-break-return-exit.expect b/t/chainlint/chain=
-break-return-exit.expect
index 1732d221c3..bedc0711e4 100644
--- a/t/chainlint/chain-break-return-exit.expect
+++ b/t/chainlint/chain-break-return-exit.expect
@@ -1,18 +1,17 @@
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
-
 for i in 1 2 3 4 ; do
 	git checkout main -b $i || return $?
 	test_commit $i $i $i tag$i || return $?
diff --git a/t/chainlint/chain-break-status.expect b/t/chainlint/chain-brea=
k-status.expect
index f4bada9463..53b3f42e7a 100644
--- a/t/chainlint/chain-break-status.expect
+++ b/t/chainlint/chain-break-status.expect
@@ -1,7 +1,6 @@
-OUT=3D$(( ( large_git ; echo $? 1 >& 3 ) | : ) 3 >& 1) &&
+OUT=3D$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
 test_match_signal 13 "$OUT" &&
-
-{ test-tool sigchain > actual ; ret=3D$? ; } &&
+{ test-tool sigchain >actual; ret=3D$?; } &&
 {
 	test_match_signal 15 "$ret" ||
 	test "$ret" =3D 3
diff --git a/t/chainlint/chained-block.expect b/t/chainlint/chained-block.e=
xpect
index 574cdceb07..2416e0fc80 100644
--- a/t/chainlint/chained-block.expect
+++ b/t/chainlint/chained-block.expect
@@ -2,7 +2,6 @@ echo nobody home && {
 	test the doohicky ?!AMP?!
 	right now
 } &&
-
 GIT_EXTERNAL_DIFF=3Decho git diff | {
 	read path oldfile oldhex oldmode newfile newhex newmode &&
 	test "z$oh" =3D "z$oldhex"
diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subs=
hell.expect
index af0369d328..2a44845759 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -3,8 +3,7 @@ mkdir sub && (
 	foo the bar ?!AMP?!
 	nuff said
 ) &&
-
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
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index c3e0be4047..9558362917 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -1,17 +1,13 @@
 (cd foo &&
 	bar
 ) &&
-
 (cd foo ?!AMP?!
 	bar
 ) &&
-
 (
 	cd foo &&
 	bar) &&
-
 (cd foo &&
 	bar) &&
-
 (cd foo ?!AMP?!
 	bar)
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
index 10724987a5..bd60121b47 100644
--- a/t/chainlint/dqstring-no-interpolate.expect
+++ b/t/chainlint/dqstring-no-interpolate.expect
@@ -1,11 +1,8 @@
 grep "^ ! [rejected][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" out &&
-
 grep "^\.git$" output.txt &&
-
-
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
index a14388e6b9..826b2ccc95 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -1,11 +1,9 @@
-sha1_file ( ) {
+sha1_file() {
 	echo "$*" | sed "s#..#.git/objects/&/#"
 } &&
-
-remove_object ( ) {
+remove_object() {
 	file=3D$(sha1_file "$*") &&
 	test -e "$file" ?!AMP?!
 	rm -f "$file"
 } ?!AMP?!
-
 sha1_file arg && remove_object arg
diff --git a/t/chainlint/here-doc-indent-operator.expect b/t/chainlint/here=
-doc-indent-operator.expect
index f92a7ce999..bbaad024d2 100644
--- a/t/chainlint/here-doc-indent-operator.expect
+++ b/t/chainlint/here-doc-indent-operator.expect
@@ -3,9 +3,7 @@ header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 num_commits: $1
 chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexe=
s bloom_data
 EOF
-
 cat >expect << -EOF ?!AMP?!
 this is not indented
 -EOF
-
 cleanup
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 1df3f78282..9e612ac8b1 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -1,22 +1,19 @@
 boodle wobba \
-	gorgo snoot \
-	wafta snurb <<EOF &&
+       gorgo snoot \
+       wafta snurb <<EOF &&
 quoth the raven,
 nevermore...
 EOF
-
 cat <<-Arbitrary_Tag_42 >foo &&
 snoz
 boz
 woz
 Arbitrary_Tag_42
-
 cat <<"zump" >boo &&
 snoz
 boz
 woz
 zump
-
 horticulture <<\EOF
 gomez
 morticia
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment=
=2Eexpect
index 6bad218530..c7fc411f91 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -3,6 +3,5 @@
 	barfoo ?!AMP?! # wrong position for &&
 	flibble "not a # comment"
 ) &&
-
 (cd foo &&
 	flibble "not a # comment")
diff --git a/t/chainlint/loop-detect-failure.expect b/t/chainlint/loop-dete=
ct-failure.expect
index a66025c39d..7a1a1ff0bf 100644
--- a/t/chainlint/loop-detect-failure.expect
+++ b/t/chainlint/loop-detect-failure.expect
@@ -5,7 +5,6 @@ do
 	git -C r1 add file.$n &&
 	git -C r1 commit -m "$n" || return 1
 done &&
-
 git init r2 &&
 for n in 1000 10000
 do
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
diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one=
-liner.expect
index ad4c2d949e..7ae60eb770 100644
--- a/t/chainlint/negated-one-liner.expect
+++ b/t/chainlint/negated-one-liner.expect
@@ -1,5 +1,4 @@
 ! (foo && bar) &&
 ! (foo && bar) >baz &&
-
 ! (foo; ?!AMP?! bar) &&
 ! (foo; ?!AMP?! bar) >baz
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-d=
oc.expect
index 29b3832a98..93eeded9f4 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -6,7 +6,6 @@ fub <<EOF
 EOF
 formp
 ARBITRARY
-
 (
 	cat <<-\INPUT_END &&
 	fish are mice
@@ -17,7 +16,6 @@ ARBITRARY
 	EOF
 	toink
 	INPUT_END
-
 	cat <<-\EOT ?!AMP?!
 	text goes here
 	data <<EOF
@@ -25,6 +23,5 @@ ARBITRARY
 	EOF
 	more test here
 	EOT
-
 	foobar
 )
diff --git a/t/chainlint/nested-loop-detect-failure.expect b/t/chainlint/ne=
sted-loop-detect-failure.expect
index 4793a0e8e1..211fdb7479 100644
--- a/t/chainlint/nested-loop-detect-failure.expect
+++ b/t/chainlint/nested-loop-detect-failure.expect
@@ -1,31 +1,28 @@
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
-
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
-
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
-
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
diff --git a/t/chainlint/not-heredoc.expect b/t/chainlint/not-heredoc.expect
index 2e9bb135fe..47311f4c2d 100644
--- a/t/chainlint/not-heredoc.expect
+++ b/t/chainlint/not-heredoc.expect
@@ -3,7 +3,6 @@ echo ourside &&
 echo "=3D=3D=3D=3D=3D=3D=3D" &&
 echo theirside &&
 echo ">>>>>>> theirs" &&
-
 (
 	echo "<<<<<<< ours" &&
 	echo ourside &&
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index 57a7a444c1..cdb45231f1 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -1,9 +1,7 @@
 (foo && bar) &&
 (foo && bar) |
 (foo && bar) >baz &&
-
 (foo; ?!AMP?! bar) &&
 (foo; ?!AMP?! bar) |
 (foo; ?!AMP?! bar) >baz &&
-
 (foo "bar; baz")
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-he=
re-doc.expect
index 52789278d1..fa7cb0288a 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -1,15 +1,13 @@
 (
 	echo wobba \
-		gorgo snoot \
-		wafta snurb <<-EOF &&
+	       gorgo snoot \
+	       wafta snurb <<-EOF &&
 	quoth the raven,
 	nevermore...
 	EOF
-
 	cat <<EOF >bip ?!AMP?!
 	fish fly high
 EOF
-
 	echo <<-\EOF >bop
 	gomez
 	morticia
diff --git a/t/chainlint/token-pasting.expect b/t/chainlint/token-pasting.e=
xpect
index 342360bcd0..cda7d54037 100644
--- a/t/chainlint/token-pasting.expect
+++ b/t/chainlint/token-pasting.expect
@@ -1,26 +1,22 @@
 git config filter.rot13.smudge ./rot13.sh &&
 git config filter.rot13.clean ./rot13.sh &&
-
 {
     echo "*.t filter=3Drot13" ?!AMP?!
     echo "*.i ident"
-} > .gitattributes &&
-
+} >.gitattributes &&
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
-
-echo "content-test2" > test2.o &&
-echo "content-test3 - filename with special characters" > "test3 'sq',$x=
=3D.o" ?!AMP?!
-
+echo "content-test2" >test2.o &&
+echo "content-test3 - filename with special characters" >"test3 'sq',$x=3D=
=2Eo" ?!AMP?!
 downstream_url_for_sed=3D$(
 	printf "%sn" "$downstream_url" |
 	sed -e 's/\/\\/g' -e 's/[[/.*^$]/\&/g'
--=20
2.43.GIT


--Mdtm6Uf6RTrKJ/8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV77G0ACgkQVbJhu7ck
PpTRJw//d+EexlIL4JXffqmE5bYW6QbXbmOfxUyj9Mr2Jkcl6dAEj/aH7KQuZMVk
TMvRcQqV+QBFLTWqlO+S3ucQzgRafjiEhSUEttqG7t5NOmhI10mdjUPKj8XNF8O/
hRA6t8OGjQQFiamFfOr/GdTR9+drTXjxTTseqKS7qTDazMVSbozqD1iTkbHmiTif
KK8X572Pg+8Q4LzHjZ6BBy+dQnOWZNCd07dO9wmKfR9gNJlhkoF+bfATftlNXzDu
XRNW8ERvC8JkAh3gB/CzlIY7LW/qK0P50sJQIPd45vNQEb0TxcrZbvxfk0pjj1v8
fSCj7RVf6eknzW5x1icNg1q9w1QBxLtTOsu5H4ACvNd4zYWm+Q1Pllv18vHRSgq2
ctYe5BW+Podqp9GGOZn3POWS6XVcJwKsEc9rj8Mw3g49QPypsWXOZzEnaoel5a5u
HsfpqTTVLDIzuiCckkz3+bWCpLkRcfpvUqfwBzBhxZ63Kb43ouF+9GwLBM6y9tvn
ckVRK5kIlGoJfosQl+eRSOKLMNk27KnP9qmUSfTceepu8Yxkyw0IOwmYhrpzH3l/
FJwX9Kn1BaJc5v/yqfJxV1aubWlUM78UA6caK1y/0ERe7c6spPbiwKskGvuxT/ep
M9IfQUGXF+2E2sHhj7P7YYFxzYtcEShV9QWMskDOjO+pIOGad7I=
=qfeN
-----END PGP SIGNATURE-----

--Mdtm6Uf6RTrKJ/8g--
