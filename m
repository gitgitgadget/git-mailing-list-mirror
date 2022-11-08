Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2142C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKHTIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKHTIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:08:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF81C901
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:08:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t4so9425324wmj.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDwaAuzqEsk18F/aZO+LaxvnVxNLnfZutGydxL35OC0=;
        b=fLJz/b1pa6uN4ZsJzykzbZ7qEobH0apU+a7XhlBe6Dsl+8frAcVjAU+fAzI2gcFvNt
         47nQ97weKFTCo6y5hnA8O5M4NkjxHe1wAuws8QLErTZ1dOuLI+wqki2WtifIK2qdTCVA
         VQkNVl0xuVIOJz/o56RZDrrKG4VzXq2mytMK1kog8ZLX4+bHSaGR0pzHol3WgDR8ycAy
         aBllrrFuBNA0H7xhtWc7DY884EAHk1m15tpW2TPFYaR57pNZZrP7BPsvJ5Rt7ahGJl1N
         f2WGjRVgdhP+xMxXG0QPQS1KawmqMTVPF2UVdTzs0iwpz3y4BIVq/21HGMX0rjRJHrsj
         UsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDwaAuzqEsk18F/aZO+LaxvnVxNLnfZutGydxL35OC0=;
        b=a6J5nxkLhOYHlSZMI43UveOtZyfiqeG1KekT9PD1be2NQvBQvgY3gPabCVv59Xc5/Y
         70b8ow/vSHbdj/cQqOotmnrW+wAj876P2j7fzKAbe1YDsZNZW1g+8vfByBDM2eaXqR64
         YvSfWtkkp8dBovuxBtrTOMBybd6ZClR1M2a4hjVxRs4gJwTHOGts+XHUV9sJgTJCEhSz
         i7cqmGc7BIs6RVi6HTq2knsTbfL8Nxfkyzvk/cbhfaES95UgDlRp8zOwueUyjTW0XmX3
         QlKNs/sKUoHetwS7AIbsYnATQWdmyb4jV6Jf7f2n0eG2BzboRoRQ2JpvDLqTKXtyBvb+
         uUGA==
X-Gm-Message-State: ACrzQf20WbCqttmiSCNQon4pERlOAPn7amIghaQ3BrR3eZCbneXZJyfF
        5sBLv6i9i3vagzhv7abl5Elz0r1+IHY=
X-Google-Smtp-Source: AMsMyM5iwojw0qEJLDKAmlXipCiDZp14FLcdntYc6w0shhQf+xxSDNQ/bV+R9oTd3NmnQ7Mc1WIxow==
X-Received: by 2002:a7b:c7c1:0:b0:3c7:103:f964 with SMTP id z1-20020a7bc7c1000000b003c70103f964mr38667344wmk.121.1667934514745;
        Tue, 08 Nov 2022 11:08:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b0022e66749437sm10802139wrw.93.2022.11.08.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:08:34 -0800 (PST)
Message-Id: <739c6df1dbcf1963fb426a3c25dc22fa46f7c3e0.1667934510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 19:08:30 +0000
Subject: [PATCH 4/4] chainlint: annotate original test definition rather than
 token stream
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When chainlint detects problems in a test, such as a broken &&-chain, it
prints out the test with "?!FOO?!" annotations inserted at each problem
location. However, rather than annotating the original test definition,
it instead dumps out a parsed token representation of the test. Since it
lacks comments, indentations, here-doc bodies, and so forth, this
tokenized representation can be difficult for the test author to digest
and relate back to the original test definition.

However, now that each parsed token carries positional information, the
location of a detected problem can be pinpointed precisely in the
original test definition. Therefore, take advantage of this information
to annotate the test definition itself rather than annotating the parsed
token stream, thus making it easier for a test author to relate a
problem back to the source.

Maintaining the positional meta-information associated with each
detected problem requires a slight change in how the problems are
managed internally. In particular, shell syntax such as:

    msg="total: $(cd data; wc -w *.txt) words"

requires the lexical analyzer to recursively invoke the parser in order
to detect problems within the $(...) expression inside the double-quoted
string. In this case, the recursive parse context will detect the broken
&&-chain between the `cd` and `wc` commands, returning the token stream:

    cd data ; ?!AMP?! wc -w *.txt

However, the parent parse context will see everything inside the
double-quotes as a single string token:

    "total: $(cd data ; ?!AMP?! wc -w *.txt) words"

losing whatever positional information was attached to the ";" token
where the problem was detected.

One way to preserve the positional information of a detected problem in
a recursive parse context within a string would be to attach the
positional information to the annotation textually; for instance:

    "total: $(cd data ; ?!AMP:21:22?! wc -w *.txt) words"

and then extract the positional information when annotating the original
test definition.

However, a cleaner and much simpler approach is to maintain the list of
detected problems separately rather than embedding the problems as
annotations directly in the parsed token stream. Not only does this
ensure that positional information within recursive parse contexts is
not lost, but it keeps the token stream free from non-token pollution,
which may simplify implementation of validations added in the future
since they won't have to handle non-token "?!FOO!?" items specially.

Finally, the chainlint self-test "expect" files need a few mechanical
adjustments now that the original test definitions are emitted rather
than the parsed token stream. In particular, the following items missing
from the historic parsed-token output are now preserved verbatim:

    * indentation (and whitespace, in general)

    * comments

    * here-doc bodies

    * here-doc tag quoting (i.e. "\EOF")

    * line-splices (i.e. "\" at the end of a line)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                                | 31 ++++++++++++++-----
 t/chainlint/block-comment.expect              |  2 ++
 t/chainlint/case-comment.expect               |  3 ++
 t/chainlint/close-subshell.expect             |  3 +-
 t/chainlint/comment.expect                    |  4 +++
 t/chainlint/double-here-doc.expect            | 14 +++++++--
 t/chainlint/empty-here-doc.expect             |  3 +-
 t/chainlint/for-loop.expect                   |  4 ++-
 t/chainlint/here-doc-close-subshell.expect    |  4 ++-
 t/chainlint/here-doc-indent-operator.expect   | 10 ++++--
 .../here-doc-multi-line-command-subst.expect  |  5 ++-
 t/chainlint/here-doc-multi-line-string.expect |  4 ++-
 t/chainlint/here-doc.expect                   | 24 ++++++++++++--
 t/chainlint/if-then-else.expect               |  4 ++-
 t/chainlint/incomplete-line.expect            | 10 ++++--
 t/chainlint/inline-comment.expect             |  4 +--
 t/chainlint/loop-detect-status.expect         |  2 +-
 t/chainlint/nested-here-doc.expect            | 27 ++++++++++++++--
 t/chainlint/nested-subshell-comment.expect    |  2 ++
 t/chainlint/subshell-here-doc.expect          | 28 ++++++++++++++---
 t/chainlint/t7900-subtree.expect              |  4 +++
 t/chainlint/while-loop.expect                 |  4 ++-
 22 files changed, 163 insertions(+), 33 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 59aa79babc2..7972c5bbe6f 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -459,6 +459,13 @@ package TestParser;
 
 use base 'ShellParser';
 
+sub new {
+	my $class = shift @_;
+	my $self = $class->SUPER::new(@_);
+	$self->{problems} = [];
+	return $self;
+}
+
 sub find_non_nl {
 	my $tokens = shift @_;
 	my $n = shift @_;
@@ -498,7 +505,7 @@ sub parse_loop_body {
 	return @tokens if ends_with(\@tokens, [qr/^\|\|$/, "\n", qr/^echo$/, qr/^.+$/]);
 	# flag missing "return/exit" handling explicit failure in loop body
 	my $n = find_non_nl(\@tokens);
-	splice(@tokens, $n + 1, 0, ['?!LOOP?!', $tokens[$n]->[1], $tokens[$n]->[2]]);
+	push(@{$self->{problems}}, ['LOOP', $tokens[$n]]);
 	return @tokens;
 }
 
@@ -511,6 +518,7 @@ my @safe_endings = (
 
 sub accumulate {
 	my ($self, $tokens, $cmd) = @_;
+	my $problems = $self->{problems};
 
 	# no previous command to check for missing "&&"
 	goto DONE unless @$tokens;
@@ -531,13 +539,13 @@ sub accumulate {
 	# failure explicitly), then okay for all preceding commands to be
 	# missing "&&"
 	if ($$cmd[0]->[0] =~ /^(?:false|return|exit)$/) {
-		@$tokens = grep {$_->[0] !~ /^\?!AMP\?!$/} @$tokens;
+		@$problems = grep {$_->[0] ne 'AMP'} @$problems;
 		goto DONE;
 	}
 
 	# flag missing "&&" at end of previous command
 	my $n = find_non_nl($tokens);
-	splice(@$tokens, $n + 1, 0, ['?!AMP?!', $$tokens[$n]->[1], $$tokens[$n]->[2]]) unless $n < 0;
+	push(@$problems, ['AMP', $tokens->[$n]]) unless $n < 0;
 
 DONE:
 	$self->SUPER::accumulate($tokens, $cmd);
@@ -594,12 +602,21 @@ sub check_test {
 	$self->{ntests}++;
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
-	return unless $emit_all || grep {$_->[0] =~ /\?![^?]+\?!/} @tokens;
+	my $problems = $parser->{problems};
+	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
-	my $checked = join(' ', map {$_->[0]} @tokens);
+	my $start = 0;
+	my $checked = '';
+	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
+		my ($label, $token) = @$_;
+		my $pos = $token->[2];
+		$checked .= substr($body, $start, $pos - $start) . " ?!$label?! ";
+		$start = $pos;
+	}
+	$checked .= substr($body, $start);
 	$checked =~ s/^\n//;
-	$checked =~ s/^ //mg;
-	$checked =~ s/ $//mg;
+	$checked =~ s/(\s) \?!/$1?!/mg;
+	$checked =~ s/\?! (\s)/?!$1/mg;
 	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
diff --git a/t/chainlint/block-comment.expect b/t/chainlint/block-comment.expect
index d10b2eeaf27..df2beea8887 100644
--- a/t/chainlint/block-comment.expect
+++ b/t/chainlint/block-comment.expect
@@ -1,6 +1,8 @@
 (
 	{
+		# show a
 		echo a &&
+		# show b
 		echo b
 	}
 )
diff --git a/t/chainlint/case-comment.expect b/t/chainlint/case-comment.expect
index 1e4b054bda0..641c157b98c 100644
--- a/t/chainlint/case-comment.expect
+++ b/t/chainlint/case-comment.expect
@@ -1,7 +1,10 @@
 (
 	case "$x" in
+	# found foo
 	x) foo ;;
+	# found other
 	*)
+		# treat it as bar
 		bar
 		;;
 	esac
diff --git a/t/chainlint/close-subshell.expect b/t/chainlint/close-subshell.expect
index 0f87db9ae68..2192a2870a1 100644
--- a/t/chainlint/close-subshell.expect
+++ b/t/chainlint/close-subshell.expect
@@ -15,7 +15,8 @@
 ) | wuzzle &&
 (
 	bop
-) | fazz 	fozz &&
+) | fazz \
+	fozz &&
 (
 	bup
 ) |
diff --git a/t/chainlint/comment.expect b/t/chainlint/comment.expect
index f76fde1ffba..a68f1f9d7c2 100644
--- a/t/chainlint/comment.expect
+++ b/t/chainlint/comment.expect
@@ -1,4 +1,8 @@
 (
+	# comment 1
 	nothing &&
+	# comment 2
 	something
+	# comment 3
+	# comment 4
 )
diff --git a/t/chainlint/double-here-doc.expect b/t/chainlint/double-here-doc.expect
index 75477bb1add..cd584a43573 100644
--- a/t/chainlint/double-here-doc.expect
+++ b/t/chainlint/double-here-doc.expect
@@ -1,2 +1,12 @@
-run_sub_test_lib_test_err run-inv-range-start "--run invalid range start" --run="a-5" <<-EOF &&
-check_sub_test_lib_test_err run-inv-range-start <<-EOF_OUT 3 <<-EOF_ERR
+run_sub_test_lib_test_err run-inv-range-start \
+	"--run invalid range start" \
+	--run="a-5" <<-\EOF &&
+test_expect_success "passing test #1" "true"
+test_done
+EOF
+check_sub_test_lib_test_err run-inv-range-start \
+	<<-\EOF_OUT 3<<-EOF_ERR
+> FATAL: Unexpected exit with code 1
+EOF_OUT
+> error: --run: invalid non-numeric in range start: ${SQ}a-5${SQ}
+EOF_ERR
diff --git a/t/chainlint/empty-here-doc.expect b/t/chainlint/empty-here-doc.expect
index f42f2d41ba8..e8733c97c64 100644
--- a/t/chainlint/empty-here-doc.expect
+++ b/t/chainlint/empty-here-doc.expect
@@ -1,3 +1,4 @@
 git ls-tree $tree path > current &&
-cat > expected <<EOF &&
+cat > expected <<\EOF &&
+EOF
 test_output
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index a5810c9bddd..d65c82129a6 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -2,7 +2,9 @@
 	for i in a b c
 	do
 		echo $i ?!AMP?!
-		cat <<-EOF ?!LOOP?!
+		cat <<-\EOF ?!LOOP?!
+		bar
+		EOF
 	done ?!AMP?!
 	for i in a b c; do
 		echo $i &&
diff --git a/t/chainlint/here-doc-close-subshell.expect b/t/chainlint/here-doc-close-subshell.expect
index 2af9ced71cc..7d9c2b56070 100644
--- a/t/chainlint/here-doc-close-subshell.expect
+++ b/t/chainlint/here-doc-close-subshell.expect
@@ -1,2 +1,4 @@
 (
-	cat <<-INPUT)
+	cat <<-\INPUT)
+	fizz
+	INPUT
diff --git a/t/chainlint/here-doc-indent-operator.expect b/t/chainlint/here-doc-indent-operator.expect
index fb6cf7285d0..f92a7ce9992 100644
--- a/t/chainlint/here-doc-indent-operator.expect
+++ b/t/chainlint/here-doc-indent-operator.expect
@@ -1,5 +1,11 @@
-cat > expect <<-EOF &&
+cat >expect <<- EOF &&
+header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
+num_commits: $1
+chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
+EOF
 
-cat > expect <<-EOF ?!AMP?!
+cat >expect << -EOF ?!AMP?!
+this is not indented
+-EOF
 
 cleanup
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index f8b3aa73c4f..b7364c82c89 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -1,5 +1,8 @@
 (
-	x=$(bobble <<-END &&
+	x=$(bobble <<-\END &&
+		fossil
+		vegetable
+		END
 		wiffle) ?!AMP?!
 	echo $x
 )
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index be64b26869a..6c13bdcbfb5 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,5 +1,7 @@
 (
-	cat <<-TXT && echo "multi-line
+	cat <<-\TXT && echo "multi-line
 	string" ?!AMP?!
+	fizzle
+	TXT
 	bap
 )
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 110059ba584..1df3f782821 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -1,7 +1,25 @@
-boodle wobba        gorgo snoot        wafta snurb <<EOF &&
+boodle wobba \
+	gorgo snoot \
+	wafta snurb <<EOF &&
+quoth the raven,
+nevermore...
+EOF
 
 cat <<-Arbitrary_Tag_42 >foo &&
+snoz
+boz
+woz
+Arbitrary_Tag_42
 
-cat <<zump >boo &&
+cat <<"zump" >boo &&
+snoz
+boz
+woz
+zump
 
-horticulture <<EOF
+horticulture <<\EOF
+gomez
+morticia
+wednesday
+pugsly
+EOF
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index 44d86c35976..cbaaf857d47 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -8,7 +8,9 @@
 		echo foo
 	else
 		echo foo &&
-		cat <<-EOF
+		cat <<-\EOF
+		bar
+		EOF
 	fi ?!AMP?!
 	echo poodle
 ) &&
diff --git a/t/chainlint/incomplete-line.expect b/t/chainlint/incomplete-line.expect
index ffac8f90185..134d3a14f5c 100644
--- a/t/chainlint/incomplete-line.expect
+++ b/t/chainlint/incomplete-line.expect
@@ -1,4 +1,10 @@
-line 1 line 2 line 3 line 4 &&
+line 1 \
+line 2 \
+line 3 \
+line 4 &&
 (
-	line 5 	line 6 	line 7 	line 8
+	line 5 \
+	line 6 \
+	line 7 \
+	line 8
 )
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index dd0dace077f..6bad2185300 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -1,6 +1,6 @@
 (
-	foobar &&
-	barfoo ?!AMP?!
+	foobar && # comment 1
+	barfoo ?!AMP?! # wrong position for &&
 	flibble "not a # comment"
 ) &&
 
diff --git a/t/chainlint/loop-detect-status.expect b/t/chainlint/loop-detect-status.expect
index 0ad23bb35e4..24da9e86d59 100644
--- a/t/chainlint/loop-detect-status.expect
+++ b/t/chainlint/loop-detect-status.expect
@@ -2,7 +2,7 @@
 do
 	printf "Generating blob $i/$blobcount\r" >& 2 &&
 	printf "blob\nmark :$i\ndata $blobsize\n" &&
-
+	#test-tool genrandom $i $blobsize &&
 	printf "%-${blobsize}s" $i &&
 	echo "M 100644 :$i $i" >> commit &&
 	i=$(($i+1)) ||
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index e3bef63f754..29b3832a986 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -1,7 +1,30 @@
 cat <<ARBITRARY >foop &&
+naddle
+fub <<EOF
+	nozzle
+	noodle
+EOF
+formp
+ARBITRARY
 
 (
-	cat <<-INPUT_END &&
-	cat <<-EOT ?!AMP?!
+	cat <<-\INPUT_END &&
+	fish are mice
+	but geese go slow
+	data <<EOF
+		perl is lerp
+		and nothing else
+	EOF
+	toink
+	INPUT_END
+
+	cat <<-\EOT ?!AMP?!
+	text goes here
+	data <<EOF
+		data goes here
+	EOF
+	more test here
+	EOT
+
 	foobar
 )
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index be4b27a305b..9138cf386d3 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -2,6 +2,8 @@
 	foo &&
 	(
 		bar &&
+		# bottles wobble while fiddles gobble
+		# minor numbers of cows (or do they?)
 		baz &&
 		snaff
 	) ?!AMP?!
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 029d129299a..52789278d13 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -1,10 +1,30 @@
 (
-	echo wobba 	       gorgo snoot 	       wafta snurb <<-EOF &&
+	echo wobba \
+		gorgo snoot \
+		wafta snurb <<-EOF &&
+	quoth the raven,
+	nevermore...
+	EOF
+
 	cat <<EOF >bip ?!AMP?!
-	echo <<-EOF >bop
+	fish fly high
+EOF
+
+	echo <<-\EOF >bop
+	gomez
+	morticia
+	wednesday
+	pugsly
+	EOF
 ) &&
 (
-	cat <<-ARBITRARY >bup &&
-	cat <<-ARBITRARY3 >bup3 &&
+	cat <<-\ARBITRARY >bup &&
+	glink
+	FIZZ
+	ARBITRARY
+	cat <<-"ARBITRARY3" >bup3 &&
+	glink
+	FIZZ
+	ARBITRARY3
 	meep
 )
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
index 69167da2f27..71b3b3bc20e 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -4,12 +4,16 @@ sub2
 sub3
 sub4" &&
 	chks_sub=$(cat <<TXT | sed "s,^,sub dir/,"
+$chks
+TXT
 ) &&
 	chkms="main-sub1
 main-sub2
 main-sub3
 main-sub4" &&
 	chkms_sub=$(cat <<TXT | sed "s,^,sub dir/,"
+$chkms
+TXT
 ) &&
 	subfiles=$(git ls-files) &&
 	check_equal "$subfiles" "$chkms
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index f272aa21fee..1f5eaea0fd5 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -2,7 +2,9 @@
 	while true
 	do
 		echo foo ?!AMP?!
-		cat <<-EOF ?!LOOP?!
+		cat <<-\EOF ?!LOOP?!
+		bar
+		EOF
 	done ?!AMP?!
 	while true; do
 		echo foo &&
-- 
gitgitgadget
