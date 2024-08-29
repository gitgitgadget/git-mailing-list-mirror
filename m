Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1A18DF69
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923108; cv=none; b=ZwCuhEpYRI30rXxoNrIJ8SjNkE8gZ4rFeKz5AE7Qxri9KrDwooovmBe7Xtckf0DgbzhFJCbcvuYf8Q2+zORpSWSpWjBZyzMNV67Hcu/6YGvqcwSPDOpgkrQONKuButxySBFchS2cli7jp8/HAa+ydSYD8Zg/XhnTd386c/722XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923108; c=relaxed/simple;
	bh=OsWSHMA060MNGrRbAboakSF+SwU21MS2bs7kDEE6wbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbxMWau2Kk3vcjOf12EZQ4OYEeuz7C7GIOn471DJlilqVfJOJ92QVqYMIObYsGPVu6n0huqRh51Pe2mzlbd7xEdWnZ6kcDUTLnlqduVXRVInRI0DwMV4661XZ+W1/R1SCaDK+6SmYkZCJVZROeO8wKyOdT7+QHcDgeNUqVDr6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=otK2sKUz; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="otK2sKUz"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id jbGiswlxTYUSUjbGqsPmjZ; Thu, 29 Aug 2024 09:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1724923008;
	bh=OsWSHMA060MNGrRbAboakSF+SwU21MS2bs7kDEE6wbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otK2sKUzZSX6MDbF9KWUEd5ZjQV0kYaVncZsNly+uZh+ne2t09BhUYyV7vPrxr8JT
	 n/xwGkqbsWs7855uQHcJ51BYpu36Q2SgH1Z4anbb5w9q504CmvGO2JG45JuN3g8fId
	 cTr7UUOlLXa89ZDSW0/5QmLRdvYnrOBi+fXOtyyVJ2gb9mrSXeu1h3Jpxtxj3qBnlk
	 AfwX9BsWo+Mj2s4G08/Agga4Vs072NgW2HzZWOQCSwywHe7OYLvneROpJtgE5zUH4i
	 CH6eZoLYlI3q8Sbn5xye8GDrtB9HrfimERUPZB1t1KIfaAlKa9v0XD1jUyLVHwITbu
	 eaZ4TIj79kxag==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=A99qPbWG c=1 sm=1 tr=0 ts=66d03c80
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=s9VqqHmRr9jRBFScTFUA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] chainlint: make error messages self-explanatory
Date: Thu, 29 Aug 2024 05:16:24 -0400
Message-ID: <20240829091625.41297-2-ericsunshine@charter.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829091625.41297-1-ericsunshine@charter.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBNFnaK9tSUHwZOmrThQ3IhI5taYzIZuaCk3WO3qPam704d3d+Lk++w36d7hhnLCvFM1u+JIluNsN0EUgGdvHlSENEm3YbDdrtZeaDmDJkuqj+IILrkF
 3Gijq+NsRBbetOy3371tLfFFslHdcM6vNkNyvQhD0BJS8aWUvEUBovbll7qosQS/0Hyxst+9eJK9yDPV4exibCVRKo11z3ntxccSlFah+i6MZb6Frza3sG/E
 P76rD+h2SYp1SxJQWSi/SFA5hq0UEDQ/JV/R9jJFBng=

From: Eric Sunshine <sunshine@sunshineco.com>

The annotations emitted by chainlint to indicate detected problems are
overly terse, so much so that developers new to the project -- those who
should most benefit from the linting -- may find them baffling. For
instance, although the author of chainlint and seasoned Git developers
may understand that "?!AMP?!" is an abbreviation of "ampersand" and
indicates a break in the &&-chain, this may not be obvious to newcomers.

Similarly, although the annotation "?!LOOP?!" is understood by project
regulars to indicate a missing `|| return 1` (or `|| exit 1` in a
subshell), newcomers may find it more than a little perplexing. The
"?!LOOP?!" case is particularly serious since it is likely that some
newcomers are unaware that shell loops do not terminate automatically
upon error, and it is more difficult for a newcomer to figure out how to
correct the problem by examining surrounding code since `|| return 1`
appears in test scrips relatively infrequently (compared, for instance,
with &&-chaining).

Address these shortcomings by emitting human-consumable messages which
both explain the problem and give a strong hint about how to correct it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                                | 26 ++++++++++++++-----
 t/chainlint/arithmetic-expansion.expect       |  2 +-
 t/chainlint/block.expect                      |  8 +++---
 t/chainlint/broken-chain.expect               |  2 +-
 t/chainlint/case.expect                       |  4 +--
 t/chainlint/chain-break-false.expect          |  2 +-
 t/chainlint/chained-block.expect              |  2 +-
 t/chainlint/chained-subshell.expect           |  4 +--
 t/chainlint/command-substitution.expect       |  2 +-
 t/chainlint/complex-if-in-cuddled-loop.expect |  2 +-
 t/chainlint/cuddled.expect                    |  4 +--
 t/chainlint/for-loop.expect                   |  8 +++---
 t/chainlint/function.expect                   |  4 +--
 t/chainlint/here-doc-body-indent.expect       |  2 +-
 t/chainlint/here-doc-body-pathological.expect |  4 +--
 t/chainlint/here-doc-body.expect              |  4 +--
 t/chainlint/here-doc-double.expect            |  2 +-
 t/chainlint/here-doc-indent-operator.expect   |  2 +-
 .../here-doc-multi-line-command-subst.expect  |  2 +-
 t/chainlint/here-doc-multi-line-string.expect |  2 +-
 t/chainlint/if-condition-split.expect         |  2 +-
 t/chainlint/if-in-loop.expect                 |  4 +--
 t/chainlint/if-then-else.expect               |  4 +--
 t/chainlint/inline-comment.expect             |  2 +-
 t/chainlint/loop-detect-failure.expect        |  2 +-
 t/chainlint/loop-in-if.expect                 |  8 +++---
 t/chainlint/multi-line-string.expect          |  2 +-
 t/chainlint/negated-one-liner.expect          |  4 +--
 t/chainlint/nested-cuddled-subshell.expect    |  6 ++---
 t/chainlint/nested-here-doc.expect            |  2 +-
 t/chainlint/nested-loop-detect-failure.expect |  6 ++---
 t/chainlint/nested-subshell-comment.expect    |  2 +-
 t/chainlint/nested-subshell.expect            |  2 +-
 t/chainlint/not-heredoc.expect                |  2 +-
 t/chainlint/one-liner-for-loop.expect         |  2 +-
 t/chainlint/one-liner.expect                  |  6 ++---
 t/chainlint/pipe.expect                       |  2 +-
 t/chainlint/semicolon.expect                  | 12 ++++-----
 t/chainlint/subshell-here-doc.expect          |  2 +-
 t/chainlint/subshell-one-liner.expect         | 10 +++----
 t/chainlint/token-pasting.expect              |  8 +++---
 t/chainlint/unclosed-here-doc-indent.expect   |  2 +-
 t/chainlint/unclosed-here-doc.expect          |  2 +-
 t/chainlint/while-loop.expect                 |  8 +++---
 44 files changed, 102 insertions(+), 88 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 5361f23b1d..d79f183dfd 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -9,7 +9,7 @@
 # Input arguments are pathnames of shell scripts containing test definitions,
 # or globs referencing a collection of scripts. For each problem discovered,
 # the pathname of the script containing the test is printed along with the test
-# name and the test body with a `?!FOO?!` annotation at the location of each
+# name and the test body with a `?!ERR?!` annotation at the location of each
 # detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
 # &&-chain. Returns zero if no problems are discovered, otherwise non-zero.
 
@@ -181,7 +181,7 @@ sub swallow_heredocs {
 			$self->{lineno} += () = $body =~ /\n/sg;
 			next;
 		}
-		push(@{$self->{parser}->{problems}}, ['UNCLOSED-HEREDOC', $tag]);
+		push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
 		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
 		my $body = substr($$b, $start, pos($$b) - $start);
 		$self->{lineno} += () = $body =~ /\n/sg;
@@ -238,6 +238,7 @@ sub new {
 		stop => [],
 		output => [],
 		heredocs => {},
+		insubshell => 0,
 	} => $class;
 	$self->{lexer} = Lexer->new($self, $s);
 	return $self;
@@ -296,8 +297,11 @@ sub parse_group {
 
 sub parse_subshell {
 	my $self = shift @_;
-	return ($self->parse(qr/^\)$/),
-		$self->expect(')'));
+	$self->{insubshell}++;
+	my @tokens = ($self->parse(qr/^\)$/),
+		      $self->expect(')'));
+	$self->{insubshell}--;
+	return @tokens;
 }
 
 sub parse_case_pattern {
@@ -528,7 +532,7 @@ sub parse_loop_body {
 	return @tokens if ends_with(\@tokens, [qr/^\|\|$/, "\n", qr/^echo$/, qr/^.+$/]);
 	# flag missing "return/exit" handling explicit failure in loop body
 	my $n = find_non_nl(\@tokens);
-	push(@{$self->{problems}}, ['LOOP', $tokens[$n]]);
+	push(@{$self->{problems}}, [$self->{insubshell} ? 'LOOPEXIT' : 'LOOPRETURN', $tokens[$n]]);
 	return @tokens;
 }
 
@@ -619,6 +623,15 @@ sub unwrap {
 	return $s
 }
 
+sub format_problem {
+	local $_ = shift;
+	/^AMP$/ && return "missing '&&'";
+	/^LOOPRETURN$/ && return "missing '|| return 1'";
+	/^LOOPEXIT$/ && return "missing '|| exit 1'";
+	/^HEREDOC$/ && return 'unclosed heredoc';
+	die("unrecognized problem type '$_'\n");
+}
+
 sub check_test {
 	my $self = shift @_;
 	my $title = unwrap(shift @_);
@@ -641,7 +654,8 @@ sub check_test {
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
 		my ($label, $token) = @$_;
 		my $pos = $token->[2];
-		$checked .= substr($body, $start, $pos - $start) . " ?!$label?! ";
+		my $err = format_problem($label, $token);
+		$checked .= substr($body, $start, $pos - $start) . " ?!ERR $err?! ";
 		$start = $pos;
 	}
 	$checked .= substr($body, $start);
diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
index 338ecd5861..2efd65dcbd 100644
--- a/t/chainlint/arithmetic-expansion.expect
+++ b/t/chainlint/arithmetic-expansion.expect
@@ -4,6 +4,6 @@
 5 	baz
 6 ) &&
 7 (
-8 	bar=$((42 + 1)) ?!AMP?!
+8 	bar=$((42 + 1)) ?!ERR missing '&&'?!
 9 	baz
 10 )
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index b62e3d58c3..28410b33ef 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -1,20 +1,20 @@
 2 (
 3 	foo &&
 4 	{
-5 		echo a ?!AMP?!
+5 		echo a ?!ERR missing '&&'?!
 6 		echo b
 7 	} &&
 8 	bar &&
 9 	{
 10 		echo c
-11 	} ?!AMP?!
+11 	} ?!ERR missing '&&'?!
 12 	baz
 13 ) &&
 14 
 15 {
-16 	echo a; ?!AMP?! echo b
+16 	echo a; ?!ERR missing '&&'?! echo b
 17 } &&
-18 { echo a; ?!AMP?! echo b; } &&
+18 { echo a; ?!ERR missing '&&'?! echo b; } &&
 19 
 20 {
 21 	echo "${var}9" &&
diff --git a/t/chainlint/broken-chain.expect b/t/chainlint/broken-chain.expect
index 9a1838736f..2a209df0a7 100644
--- a/t/chainlint/broken-chain.expect
+++ b/t/chainlint/broken-chain.expect
@@ -1,6 +1,6 @@
 2 (
 3 	foo &&
-4 	bar ?!AMP?!
+4 	bar ?!ERR missing '&&'?!
 5 	baz &&
 6 	wop
 7 )
diff --git a/t/chainlint/case.expect b/t/chainlint/case.expect
index c04c61ff36..d00b67b766 100644
--- a/t/chainlint/case.expect
+++ b/t/chainlint/case.expect
@@ -9,11 +9,11 @@
 10 	case "$x" in
 11 	x) foo ;;
 12 	*) bar ;;
-13 	esac ?!AMP?!
+13 	esac ?!ERR missing '&&'?!
 14 	foobar
 15 ) &&
 16 (
 17 	case "$x" in 1) true;; esac &&
-18 	case "$y" in 2) false;; esac ?!AMP?!
+18 	case "$y" in 2) false;; esac ?!ERR missing '&&'?!
 19 	foobar
 20 )
diff --git a/t/chainlint/chain-break-false.expect b/t/chainlint/chain-break-false.expect
index 4f815f8e14..bfccc0d90f 100644
--- a/t/chainlint/chain-break-false.expect
+++ b/t/chainlint/chain-break-false.expect
@@ -4,6 +4,6 @@
 5 	echo failed!
 6 	false
 7 else
-8 	echo it went okay ?!AMP?!
+8 	echo it went okay ?!ERR missing '&&'?!
 9 	congratulate user
 10 fi
diff --git a/t/chainlint/chained-block.expect b/t/chainlint/chained-block.expect
index a546b714a6..293d9eac42 100644
--- a/t/chainlint/chained-block.expect
+++ b/t/chainlint/chained-block.expect
@@ -1,5 +1,5 @@
 2 echo nobody home && {
-3 	test the doohicky ?!AMP?!
+3 	test the doohicky ?!ERR missing '&&'?!
 4 	right now
 5 } &&
 6 
diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subshell.expect
index f78b268291..2f5de4fead 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -1,10 +1,10 @@
 2 mkdir sub && (
 3 	cd sub &&
-4 	foo the bar ?!AMP?!
+4 	foo the bar ?!ERR missing '&&'?!
 5 	nuff said
 6 ) &&
 7 
 8 cut "-d " -f actual | (read s1 s2 s3 &&
-9 test -f $s1 ?!AMP?!
+9 test -f $s1 ?!ERR missing '&&'?!
 10 test $(cat $s2) = tree2path1 &&
 11 test $(cat $s3) = tree3path1)
diff --git a/t/chainlint/command-substitution.expect b/t/chainlint/command-substitution.expect
index 5e31b36db6..511c918cb5 100644
--- a/t/chainlint/command-substitution.expect
+++ b/t/chainlint/command-substitution.expect
@@ -4,6 +4,6 @@
 5 	baz
 6 ) &&
 7 (
-8 	bar=$(gobble blocks) ?!AMP?!
+8 	bar=$(gobble blocks) ?!ERR missing '&&'?!
 9 	baz
 10 )
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
index 3a740103db..eb855378a1 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.expect
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -4,6 +4,6 @@
 5      :
 6    else
 7      echo >file
-8    fi ?!LOOP?!
+8    fi ?!ERR missing '|| exit 1'?!
 9  done) &&
 10 test ! -f file
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index b06d638311..65825c6879 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -2,7 +2,7 @@
 3 	bar
 4 ) &&
 5 
-6 (cd foo ?!AMP?!
+6 (cd foo ?!ERR missing '&&'?!
 7 	bar
 8 ) &&
 9 
@@ -13,5 +13,5 @@
 14 (cd foo &&
 15 	bar) &&
 16 
-17 (cd foo ?!AMP?!
+17 (cd foo ?!ERR missing '&&'?!
 18 	bar)
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index 908aeedf96..df6fc1a35f 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -1,14 +1,14 @@
 2 (
 3 	for i in a b c
 4 	do
-5 		echo $i ?!AMP?!
-6 		cat <<-\EOF ?!LOOP?!
+5 		echo $i ?!ERR missing '&&'?!
+6 		cat <<-\EOF ?!ERR missing '|| exit 1'?!
 7 		bar
 8 		EOF
-9 	done ?!AMP?!
+9 	done ?!ERR missing '&&'?!
 10 
 11 	for i in a b c; do
 12 		echo $i &&
-13 		cat $i ?!LOOP?!
+13 		cat $i ?!ERR missing '|| exit 1'?!
 14 	done
 15 )
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
index c226246b25..7a15be745b 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -4,8 +4,8 @@
 5 
 6 remove_object() {
 7 	file=$(sha1_file "$*") &&
-8 	test -e "$file" ?!AMP?!
+8 	test -e "$file" ?!ERR missing '&&'?!
 9 	rm -f "$file"
-10 } ?!AMP?!
+10 } ?!ERR missing '&&'?!
 11 
 12 sha1_file arg && remove_object arg
diff --git a/t/chainlint/here-doc-body-indent.expect b/t/chainlint/here-doc-body-indent.expect
index 4323acc93d..1d7298c8ad 100644
--- a/t/chainlint/here-doc-body-indent.expect
+++ b/t/chainlint/here-doc-body-indent.expect
@@ -1,2 +1,2 @@
-2 	echo "we should find this" ?!AMP?!
+2 	echo "we should find this" ?!ERR missing '&&'?!
 3 	echo "even though our heredoc has its indent stripped"
diff --git a/t/chainlint/here-doc-body-pathological.expect b/t/chainlint/here-doc-body-pathological.expect
index a93a1fa3aa..828f232616 100644
--- a/t/chainlint/here-doc-body-pathological.expect
+++ b/t/chainlint/here-doc-body-pathological.expect
@@ -1,7 +1,7 @@
-2 	echo "outer here-doc does not allow indented end-tag" ?!AMP?!
+2 	echo "outer here-doc does not allow indented end-tag" ?!ERR missing '&&'?!
 3 	cat >file <<-\EOF &&
 4 	but this inner here-doc
 5 	does allow indented EOF
 6 	EOF
-7 	echo "missing chain after" ?!AMP?!
+7 	echo "missing chain after" ?!ERR missing '&&'?!
 8 	echo "but this line is OK because it's the end"
diff --git a/t/chainlint/here-doc-body.expect b/t/chainlint/here-doc-body.expect
index ddf1c412af..79b9603c1e 100644
--- a/t/chainlint/here-doc-body.expect
+++ b/t/chainlint/here-doc-body.expect
@@ -1,7 +1,7 @@
-2 	echo "missing chain before" ?!AMP?!
+2 	echo "missing chain before" ?!ERR missing '&&'?!
 3 	cat >file <<-\EOF &&
 4 	inside inner here-doc
 5 	these are not shell commands
 6 	EOF
-7 	echo "missing chain after" ?!AMP?!
+7 	echo "missing chain after" ?!ERR missing '&&'?!
 8 	echo "but this line is OK because it's the end"
diff --git a/t/chainlint/here-doc-double.expect b/t/chainlint/here-doc-double.expect
index 20dba4b452..9cb1a1a5e3 100644
--- a/t/chainlint/here-doc-double.expect
+++ b/t/chainlint/here-doc-double.expect
@@ -1,2 +1,2 @@
-8 	echo "actual test commands" ?!AMP?!
+8 	echo "actual test commands" ?!ERR missing '&&'?!
 9 	echo "that should be checked"
diff --git a/t/chainlint/here-doc-indent-operator.expect b/t/chainlint/here-doc-indent-operator.expect
index 277a11202d..2d61e5f49d 100644
--- a/t/chainlint/here-doc-indent-operator.expect
+++ b/t/chainlint/here-doc-indent-operator.expect
@@ -4,7 +4,7 @@
 5 chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
 6 EOF
 7 
-8 cat >expect << -EOF ?!AMP?!
+8 cat >expect << -EOF ?!ERR missing '&&'?!
 9 this is not indented
 10 -EOF
 11 
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index 41b55f6437..881e4d2098 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -3,6 +3,6 @@
 4 		fossil
 5 		vegetable
 6 		END
-7 		wiffle) ?!AMP?!
+7 		wiffle) ?!ERR missing '&&'?!
 8 	echo $x
 9 )
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index c71828589e..06c791e0a4 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,6 +1,6 @@
 2 (
 3 	cat <<-\TXT && echo "multi-line
-4 	string" ?!AMP?!
+4 	string" ?!ERR missing '&&'?!
 5 	fizzle
 6 	TXT
 7 	bap
diff --git a/t/chainlint/if-condition-split.expect b/t/chainlint/if-condition-split.expect
index 9daf3d294a..5688d93a4f 100644
--- a/t/chainlint/if-condition-split.expect
+++ b/t/chainlint/if-condition-split.expect
@@ -2,6 +2,6 @@
 3    marcia ||
 4    kevin
 5 then
-6 	echo "nomads" ?!AMP?!
+6 	echo "nomads" ?!ERR missing '&&'?!
 7 	echo "for sure"
 8 fi
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
index ff8c60dbdb..253b461f87 100644
--- a/t/chainlint/if-in-loop.expect
+++ b/t/chainlint/if-in-loop.expect
@@ -5,8 +5,8 @@
 6 		then
 7 			echo "err"
 8 			exit 1
-9 		fi ?!AMP?!
+9 		fi ?!ERR missing '&&'?!
 10 		foo
-11 	done ?!AMP?!
+11 	done ?!ERR missing '&&'?!
 12 	bar
 13 )
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index 965d7e41a2..1b3162759f 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -1,7 +1,7 @@
 2 (
 3 	if test -n ""
 4 	then
-5 		echo very ?!AMP?!
+5 		echo very ?!ERR missing '&&'?!
 6 		echo empty
 7 	elif test -z ""
 8 	then
@@ -11,7 +11,7 @@
 12 		cat <<-\EOF
 13 		bar
 14 		EOF
-15 	fi ?!AMP?!
+15 	fi ?!ERR missing '&&'?!
 16 	echo poodle
 17 ) &&
 18 (
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index 0285c0b22c..fedc059a0c 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -1,6 +1,6 @@
 2 (
 3 	foobar && # comment 1
-4 	barfoo ?!AMP?! # wrong position for &&
+4 	barfoo ?!ERR missing '&&'?! # wrong position for &&
 5 	flibble "not a # comment"
 6 ) &&
 7 
diff --git a/t/chainlint/loop-detect-failure.expect b/t/chainlint/loop-detect-failure.expect
index 40c06f0d53..2d46f6d2eb 100644
--- a/t/chainlint/loop-detect-failure.expect
+++ b/t/chainlint/loop-detect-failure.expect
@@ -11,5 +11,5 @@
 12 do
 13 	printf "%"$n"s" X > r2/large.$n &&
 14 	git -C r2 add large.$n &&
-15 	git -C r2 commit -m "$n" ?!LOOP?!
+15 	git -C r2 commit -m "$n" ?!ERR missing '|| return 1'?!
 16 done
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
index 4e8c67c914..8936d7ff2d 100644
--- a/t/chainlint/loop-in-if.expect
+++ b/t/chainlint/loop-in-if.expect
@@ -3,10 +3,10 @@
 4 	then
 5 		while true
 6 		do
-7 			echo "pop" ?!AMP?!
-8 			echo "glup" ?!LOOP?!
-9 		done ?!AMP?!
+7 			echo "pop" ?!ERR missing '&&'?!
+8 			echo "glup" ?!ERR missing '|| exit 1'?!
+9 		done ?!ERR missing '&&'?!
 10 		foo
-11 	fi ?!AMP?!
+11 	fi ?!ERR missing '&&'?!
 12 	bar
 13 )
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index 62c54e3a5e..3c3a1de75c 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -3,7 +3,7 @@
 4 		line 2
 5 		line 3" &&
 6 	y="line 1
-7 		line2" ?!AMP?!
+7 		line2" ?!ERR missing '&&'?!
 8 	foobar
 9 ) &&
 10 (
diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one-liner.expect
index a6ce52a1da..12bd65264a 100644
--- a/t/chainlint/negated-one-liner.expect
+++ b/t/chainlint/negated-one-liner.expect
@@ -1,5 +1,5 @@
 2 ! (foo && bar) &&
 3 ! (foo && bar) >baz &&
 4 
-5 ! (foo; ?!AMP?! bar) &&
-6 ! (foo; ?!AMP?! bar) >baz
+5 ! (foo; ?!ERR missing '&&'?! bar) &&
+6 ! (foo; ?!ERR missing '&&'?! bar) >baz
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/nested-cuddled-subshell.expect
index 0191c9c294..3e947ea5e1 100644
--- a/t/chainlint/nested-cuddled-subshell.expect
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -5,7 +5,7 @@
 6 
 7 	(cd foo &&
 8 		bar
-9 	) ?!AMP?!
+9 	) ?!ERR missing '&&'?!
 10 
 11 	(
 12 		cd foo &&
@@ -13,13 +13,13 @@
 14 
 15 	(
 16 		cd foo &&
-17 		bar) ?!AMP?!
+17 		bar) ?!ERR missing '&&'?!
 18 
 19 	(cd foo &&
 20 		bar) &&
 21 
 22 	(cd foo &&
-23 		bar) ?!AMP?!
+23 		bar) ?!ERR missing '&&'?!
 24 
 25 	foobar
 26 )
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index 70d9b68dc9..107e5afb01 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -18,7 +18,7 @@
 19 	toink
 20 	INPUT_END
 21 
-22 	cat <<-\EOT ?!AMP?!
+22 	cat <<-\EOT ?!ERR missing '&&'?!
 23 	text goes here
 24 	data <<EOF
 25 		data goes here
diff --git a/t/chainlint/nested-loop-detect-failure.expect b/t/chainlint/nested-loop-detect-failure.expect
index c13c4d2f90..26557b05a1 100644
--- a/t/chainlint/nested-loop-detect-failure.expect
+++ b/t/chainlint/nested-loop-detect-failure.expect
@@ -2,8 +2,8 @@
 3 do
 4 	for j in 0 1 2 3 4 5 6 7 8 9;
 5 	do
-6 		echo "$i$j" >"path$i$j" ?!LOOP?!
-7 	done ?!LOOP?!
+6 		echo "$i$j" >"path$i$j" ?!ERR missing '|| return 1'?!
+7 	done ?!ERR missing '|| return 1'?!
 8 done &&
 9 
 10 for i in 0 1 2 3 4 5 6 7 8 9;
@@ -18,7 +18,7 @@
 19 do
 20 	for j in 0 1 2 3 4 5 6 7 8 9;
 21 	do
-22 		echo "$i$j" >"path$i$j" ?!LOOP?!
+22 		echo "$i$j" >"path$i$j" ?!ERR missing '|| return 1'?!
 23 	done || return 1
 24 done &&
 25 
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index f89a8d03a8..c6891919c0 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -6,6 +6,6 @@
 7 		# minor numbers of cows (or do they?)
 8 		baz &&
 9 		snaff
-10 	) ?!AMP?!
+10 	) ?!ERR missing '&&'?!
 11 	fuzzy
 12 )
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshell.expect
index 811e8a7912..b98d723edf 100644
--- a/t/chainlint/nested-subshell.expect
+++ b/t/chainlint/nested-subshell.expect
@@ -7,7 +7,7 @@
 8 
 9 	cd foo &&
 10 	(
-11 		echo a ?!AMP?!
+11 		echo a ?!ERR missing '&&'?!
 12 		echo b
 13 	) >file
 14 )
diff --git a/t/chainlint/not-heredoc.expect b/t/chainlint/not-heredoc.expect
index 611b7b75cb..9910621103 100644
--- a/t/chainlint/not-heredoc.expect
+++ b/t/chainlint/not-heredoc.expect
@@ -9,6 +9,6 @@
 10 	echo ourside &&
 11 	echo "=======" &&
 12 	echo theirside &&
-13 	echo ">>>>>>> theirs" ?!AMP?!
+13 	echo ">>>>>>> theirs" ?!ERR missing '&&'?!
 14 	poodle
 15 ) >merged
diff --git a/t/chainlint/one-liner-for-loop.expect b/t/chainlint/one-liner-for-loop.expect
index 49dcf065ef..2eb2d5fcaf 100644
--- a/t/chainlint/one-liner-for-loop.expect
+++ b/t/chainlint/one-liner-for-loop.expect
@@ -3,7 +3,7 @@
 4 	cd dir-rename-and-content &&
 5 	test_write_lines 1 2 3 4 5 >foo &&
 6 	mkdir olddir &&
-7 	for i in a b c; do echo $i >olddir/$i; ?!LOOP?! done ?!AMP?!
+7 	for i in a b c; do echo $i >olddir/$i; ?!ERR missing '|| exit 1'?! done ?!ERR missing '&&'?!
 8 	git add foo olddir &&
 9 	git commit -m "original" &&
 10 )
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index 9861811283..2c5826e6c4 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -2,8 +2,8 @@
 3 (foo && bar) |
 4 (foo && bar) >baz &&
 5 
-6 (foo; ?!AMP?! bar) &&
-7 (foo; ?!AMP?! bar) |
-8 (foo; ?!AMP?! bar) >baz &&
+6 (foo; ?!ERR missing '&&'?! bar) &&
+7 (foo; ?!ERR missing '&&'?! bar) |
+8 (foo; ?!ERR missing '&&'?! bar) >baz &&
 9 
 10 (foo "bar; baz")
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
index 1bbe5a2ce1..a198d5bdb2 100644
--- a/t/chainlint/pipe.expect
+++ b/t/chainlint/pipe.expect
@@ -4,7 +4,7 @@
 5 	baz &&
 6 
 7 	fish |
-8 	cow ?!AMP?!
+8 	cow ?!ERR missing '&&'?!
 9 
 10 	sunder
 11 )
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index 866438310c..e22920bf2c 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,19 +1,19 @@
 2 (
-3 	cat foo ; ?!AMP?! echo bar ?!AMP?!
-4 	cat foo ; ?!AMP?! echo bar
+3 	cat foo ; ?!ERR missing '&&'?! echo bar ?!ERR missing '&&'?!
+4 	cat foo ; ?!ERR missing '&&'?! echo bar
 5 ) &&
 6 (
-7 	cat foo ; ?!AMP?! echo bar &&
-8 	cat foo ; ?!AMP?! echo bar
+7 	cat foo ; ?!ERR missing '&&'?! echo bar &&
+8 	cat foo ; ?!ERR missing '&&'?! echo bar
 9 ) &&
 10 (
 11 	echo "foo; bar" &&
-12 	cat foo; ?!AMP?! echo bar
+12 	cat foo; ?!ERR missing '&&'?! echo bar
 13 ) &&
 14 (
 15 	foo;
 16 ) &&
 17 (cd foo &&
 18 	for i in a b c; do
-19 		echo; ?!LOOP?!
+19 		echo; ?!ERR missing '|| exit 1'?!
 20 	done)
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 5647500c82..953d8084e5 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -6,7 +6,7 @@
 7 	nevermore...
 8 	EOF
 9 
-10 	cat <<EOF >bip ?!AMP?!
+10 	cat <<EOF >bip ?!ERR missing '&&'?!
 11 	fish fly high
 12 EOF
 13 
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index 214316c6a0..f82296db66 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -3,17 +3,17 @@
 4 	(foo && bar) |
 5 	(foo && bar) >baz &&
 6 
-7 	(foo; ?!AMP?! bar) &&
-8 	(foo; ?!AMP?! bar) |
-9 	(foo; ?!AMP?! bar) >baz &&
+7 	(foo; ?!ERR missing '&&'?! bar) &&
+8 	(foo; ?!ERR missing '&&'?! bar) |
+9 	(foo; ?!ERR missing '&&'?! bar) >baz &&
 10 
 11 	(foo || exit 1) &&
 12 	(foo || exit 1) |
 13 	(foo || exit 1) >baz &&
 14 
-15 	(foo && bar) ?!AMP?!
+15 	(foo && bar) ?!ERR missing '&&'?!
 16 
-17 	(foo && bar; ?!AMP?! baz) ?!AMP?!
+17 	(foo && bar; ?!ERR missing '&&'?! baz) ?!ERR missing '&&'?!
 18 
 19 	foobar
 20 )
diff --git a/t/chainlint/token-pasting.expect b/t/chainlint/token-pasting.expect
index 64f3235d26..aa64cf75f3 100644
--- a/t/chainlint/token-pasting.expect
+++ b/t/chainlint/token-pasting.expect
@@ -2,13 +2,13 @@
 3 git config filter.rot13.clean ./rot13.sh &&
 4 
 5 {
-6     echo "*.t filter=rot13" ?!AMP?!
+6     echo "*.t filter=rot13" ?!ERR missing '&&'?!
 7     echo "*.i ident"
 8 } >.gitattributes &&
 9 
 10 {
-11     echo a b c d e f g h i j k l m ?!AMP?!
-12     echo n o p q r s t u v w x y z ?!AMP?!
+11     echo a b c d e f g h i j k l m ?!ERR missing '&&'?!
+12     echo n o p q r s t u v w x y z ?!ERR missing '&&'?!
 13     echo '$Id$'
 14 } >test &&
 15 cat test >test.t &&
@@ -19,7 +19,7 @@
 20 git checkout -- test test.t test.i &&
 21 
 22 echo "content-test2" >test2.o &&
-23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!AMP?!
+23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!ERR missing '&&'?!
 24 
 25 downstream_url_for_sed=$(
 26 	printf "%sn" "$downstream_url" |
diff --git a/t/chainlint/unclosed-here-doc-indent.expect b/t/chainlint/unclosed-here-doc-indent.expect
index f78e23cb63..d5b9ab52ee 100644
--- a/t/chainlint/unclosed-here-doc-indent.expect
+++ b/t/chainlint/unclosed-here-doc-indent.expect
@@ -1,4 +1,4 @@
 2 command_which_is_run &&
-3 cat >expect <<-\EOF ?!UNCLOSED-HEREDOC?! &&
+3 cat >expect <<-\EOF ?!ERR unclosed heredoc?! &&
 4 we forget to end the here-doc
 5 command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.expect b/t/chainlint/unclosed-here-doc.expect
index 51304672cf..8f6d260544 100644
--- a/t/chainlint/unclosed-here-doc.expect
+++ b/t/chainlint/unclosed-here-doc.expect
@@ -1,5 +1,5 @@
 2 command_which_is_run &&
-3 cat >expect <<\EOF ?!UNCLOSED-HEREDOC?! &&
+3 cat >expect <<\EOF ?!ERR unclosed heredoc?! &&
 4 	we try to end the here-doc below,
 5 	but the indentation throws us off
 6 	since the operator is not "<<-".
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index 5ffabd5a93..1cfd17b3c2 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -1,14 +1,14 @@
 2 (
 3 	while true
 4 	do
-5 		echo foo ?!AMP?!
-6 		cat <<-\EOF ?!LOOP?!
+5 		echo foo ?!ERR missing '&&'?!
+6 		cat <<-\EOF ?!ERR missing '|| exit 1'?!
 7 		bar
 8 		EOF
-9 	done ?!AMP?!
+9 	done ?!ERR missing '&&'?!
 10 
 11 	while true; do
 12 		echo foo &&
-13 		cat bar ?!LOOP?!
+13 		cat bar ?!ERR missing '|| exit 1'?!
 14 	done
 15 )
-- 
2.46.0

