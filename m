Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941D3D8129
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559169; cv=none; b=m7KLBURJp0xpbUjppVmJ1jVP9jeeAvWAi6B9e0zMxOcYsvMSUTckmzd7HAfN/GqWAAeIyWE/eOo4UvBEs5VccrT9IZAlwTuIQnAgAb27aG103xyW7PMHGQcF/DBnBjGfF9r8UzGU0Vn412ODgXIsKx8GpAIqDF79UKMkySTtF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559169; c=relaxed/simple;
	bh=cXfM4NendZKMAYpYYbPXAdf/SnVaXFfTsehddi4h/ck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QieUpOnkb/rzx0jhCWy2ciUtL43HqDZIwJ+BRtvY9eYzoa8N63KtTPyIsRL2supl+IR8GpWFwEKmWDFnD+3jMy/vBke/z8D7h3pzTAfF/Svhl/eazQ/3namqxnZqnWqBzFGh9PljjrbgW285VcVfJ6msatBwYjVwf7cpkeU/z7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVRo9Gew; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVRo9Gew"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176fc0cc72so4912421cf.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559166; x=1781163966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JStXVfCK1dW8wVZf95W0d8QUybx1wSemWdcBZy2I5w=;
        b=IVRo9Gew//1sWKuiFnYN8INecr1YcNswL2ryhjFZt2MNKGDU553QYeSLw8SBBp78dC
         4NblEzEuN7V4NFP6p+LiQvbah5U4v1O6WyPKZQtTABP0uPGCR8OLqkNkpWDwVp31GlYa
         rH/leNqY8oZYLleSfrSbV4CcqATEA7PJPe3YKPQFwa5NGMV47Sy+ro4lcpTB9jyE9jhJ
         rIGlPx6iEqGxz/6UlspwyPkM/PukGEj62DW038phZ5rW0i18/XVvR+HYUDYBXq5qWFHz
         bxQiW6+Az0qfg4MxrFGzJG5u7hoetIMNQ2wlF/KSs8h7BC4Fg6TtMgsf7m9/OFQ1N2+r
         cBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559166; x=1781163966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JStXVfCK1dW8wVZf95W0d8QUybx1wSemWdcBZy2I5w=;
        b=sEqvBtbrNIOCBffgtDrRs4qZSx6ei/tgeJVSNvhuQ9fwKcxqFerD5NI3Fvx1LVVv5d
         RHGAxkgB3LoVidk+s/fkYJWzLUELbcqf3Zmbmx6yMDrzuY5jDoZ1XGTSq7NFHzsLxLj0
         m6SVH31m3tIkfZaQQfipRl4kQuFfWbrWm/Ozrs8cf+KuXTF2lbRpLAz/U950dMXHCuKO
         Hp+gtQGxdzHEStGrHDffoKjpmgaj7GU3AzdtF8v5SPXn8vwx2XmhFYD9fHSsp5X0VB3d
         YX5KAcFIvfyNVccr/5CJ4NppWljCcAQpNEOviWTAchlM/TsOgSHYcGPOgm/gErYNFGwN
         2PQA==
X-Gm-Message-State: AOJu0YyR6DcGqYRTky6//rFZc5p6cokFFovhzK2+K2zFoZ/CXBx3D0y6
	VqrxiMu2zy5sF3QILRrSpQxIdgHRwuBV1O3yb/ZYdzKDk6O4vMJLkD4Rz+bQD9uS
X-Gm-Gg: Acq92OFSUHRFlYkPBcSZTR9Trp4MquVK5p7JsLoRyD8cAfROCd3ez3HCzP/kZ3sBZhI
	klzHOsL2oJMbYyLgvHwZdYc3/pFHll0iS5HbyFaUbSRE5CfmDMAcWZkTgZcdRfz8S/DLlq1pzlz
	Mj1KSS5G5LfLSHgItqgrqWgCBXjueatUGfWs/zKOyGR8FVDNlJdegPKhrBIry9np2CcPCpP65sE
	Kk/iDWSnDHACg++1tcgzOUc4IrM2wpg0862AEesBy//PszigQkhC7vQBjHmPccAjGybMER9lcbv
	FMd3v0YInBMWJq7W1CBSYO1RQEz6J6lerbP9NqQuVKS8EhD3y1bobwZ5RZja+aYe1+LiC7W6C+t
	TH7n51qo54pnsC9UnTPcJRMVUHE1jSfGORNX0H+tw8mjPcu/joDIOBoLl+vT1mbMEwnRgNZ+2g+
	iscNOpDiD3wJqbLc1N9SXLK1egG+CYtF8P1SwJ
X-Received: by 2002:a05:622a:4286:b0:50d:5a11:1b5 with SMTP id d75a77b69052e-51778643d27mr105114321cf.17.1780559166519;
        Thu, 04 Jun 2026 00:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775d9efa1sm44813881cf.20.2026.06.04.00.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:46:06 -0700 (PDT)
Message-Id: <c1b90101ef5c38a21fc901bd7387acf83eb96806.1780559158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 07:45:56 +0000
Subject: [PATCH 4/6] t: add lint-style.pl with test_grep negation rule
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add a mechanical lint checker for test scripts, similar in spirit to
check-non-portable-shell.pl but focused on test conventions rather
than portability.

The tool defines LintParser, a subclass of ScriptParser (from the
shared lib-shell-parser.pl module).  ScriptParser's
parse_cmd() finds test_expect_success blocks and calls check_test()
for each body; LintParser overrides check_test() to run lint rules
on the parsed commands.  A "# lint-ok" comment suppresses all
checks for intentional style violations.

The first rule detects '! test_grep' and replaces it with
'test_grep !'.  Shell-level negation suppresses the diagnostic
output that test_grep prints on failure; the built-in negation
preserves it.

Three violations inside test bodies are converted via --fix.  One
additional violation in a helper function outside test_expect_success
(t7900's test_geometric_repack_needed) is converted manually, since
the parser only processes test bodies.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/.gitattributes                           |   2 +
 t/Makefile                                 |  32 +++-
 t/lint-style.pl                            | 200 +++++++++++++++++++++
 t/lint-style/heredoc.expect                |   3 +
 t/lint-style/heredoc.test                  |  14 ++
 t/lint-style/test-grep-negation-fix.expect |   4 +
 t/lint-style/test-grep-negation-fix.test   |   4 +
 t/lint-style/test-grep-negation.expect     |   3 +
 t/lint-style/test-grep-negation.test       |   4 +
 t/t0031-lockfile-pid.sh                    |   2 +-
 t/t5300-pack-object.sh                     |   2 +-
 t/t5319-multi-pack-index.sh                |   2 +-
 t/t7900-maintenance.sh                     |   2 +-
 13 files changed, 268 insertions(+), 6 deletions(-)
 create mode 100755 t/lint-style.pl
 create mode 100644 t/lint-style/heredoc.expect
 create mode 100644 t/lint-style/heredoc.test
 create mode 100644 t/lint-style/test-grep-negation-fix.expect
 create mode 100644 t/lint-style/test-grep-negation-fix.test
 create mode 100644 t/lint-style/test-grep-negation.expect
 create mode 100644 t/lint-style/test-grep-negation.test

diff --git a/t/.gitattributes b/t/.gitattributes
index 7664c6e027..aea6889d03 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,5 +1,7 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
 /chainlint/*.expect eol=lf -whitespace
+/lint-style/*.expect eol=lf -whitespace
+/lint-style/*.test eol=lf -whitespace
 /t0110/url-* binary
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
diff --git a/t/Makefile b/t/Makefile
index 25f923fed9..3a5fa4ce37 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -46,6 +46,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
+LINT_STYLE_TESTS = $(sort $(wildcard lint-style/*.test))
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
 UNIT_TEST_PROGRAMS += unit-tests/bin/unit-tests$(X)
@@ -139,7 +140,7 @@ check-meson:
 test-lint: test-lint-duplicates test-lint-executable \
 	test-lint-filenames
 ifneq ($(PERL_PATH),)
-test-lint: test-lint-shell-syntax check-shell-parser
+test-lint: test-lint-shell-syntax test-lint-style check-lint-style check-shell-parser
 else
 GIT_TEST_CHAIN_LINT = 0
 endif
@@ -162,6 +163,32 @@ test-lint-shell-syntax:
 
 check-shell-parser:
 	@'$(PERL_PATH_SQ)' check-shell-parser.pl
+
+test-lint-style:
+	@'$(PERL_PATH_SQ)' lint-style.pl $(T) $(THELPERS) $(TPERF)
+
+check-lint-style:
+	@rc=0; for t in $(LINT_STYLE_TESTS); do \
+		base=$${t%.test}; \
+		case $$base in \
+		*-fix) \
+			cp "$$t" "$$t.tmp" && \
+			'$(PERL_PATH_SQ)' lint-style.pl --fix "$$t.tmp" >/dev/null 2>&1; \
+			fix_rc=$$?; \
+			if test $$fix_rc != 0; then \
+				echo "FAIL: $$t (--fix exit code $$fix_rc)"; rc=1; \
+			elif ! diff -u "$$base.expect" "$$t.tmp"; then \
+				echo "FAIL: $$t (--fix output)"; rc=1; \
+			fi; \
+			rm -f "$$t.tmp" ;; \
+		*) \
+			if ! '$(PERL_PATH_SQ)' lint-style.pl "$$t" 2>&1 | \
+				diff -u "$$base.expect" -; then \
+				echo "FAIL: $$t"; rc=1; \
+			fi ;; \
+		esac; \
+	done; test $$rc = 0
+
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
 	@# non-ASCII characters (which are quoted within double-quotes)
@@ -188,7 +215,8 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint \
-	check-shell-parser $(UNIT_TESTS)
+	check-shell-parser \
+	check-lint-style test-lint-style $(UNIT_TESTS)
 
 .PHONY: libgit-sys-test libgit-rs-test
 libgit-sys-test:
diff --git a/t/lint-style.pl b/t/lint-style.pl
new file mode 100755
index 0000000000..9268577f9b
--- /dev/null
+++ b/t/lint-style.pl
@@ -0,0 +1,200 @@
+#!/usr/bin/perl
+
+# Check test scripts for style violations that can be detected
+# mechanically, such as using bare 'grep' where test_grep should
+# be used.  Use --fix to automatically apply suggested replacements.
+#
+# Detection uses parsed tokens from the shared shell parser for
+# correct handling of heredocs, $(...), pipes, and quoting.
+# Fixes modify the original file text to preserve formatting.
+
+use strict;
+use warnings;
+use File::Basename;
+# Force LF output so check-lint-style's diff against the
+# pre-committed .expect files works on Windows.
+binmode(STDOUT, ':unix');
+binmode(STDERR, ':unix');
+
+my $fix_mode = 0;
+if (@ARGV && $ARGV[0] eq '--fix') {
+	$fix_mode = 1;
+	shift @ARGV;
+}
+
+# Load the shared shell parser (Lexer, ShellParser, ScriptParser).
+my $_lib = dirname($0) . "/lib-shell-parser.pl";
+$_lib = "./$_lib" unless $_lib =~ m{^/};
+do $_lib or die "$0: failed to load $_lib: $@$!\n";
+
+# LintParser is a subclass of ScriptParser which runs lint rules
+# on each test body.  Per-file state (file name, raw lines, dirty
+# flag) is stored on the instance before calling parse().
+#
+# Subroutines defined below (parse_commands, check_test_grep_negation,
+# etc.) are in package main and called with the main:: prefix.
+# File-scoped lexicals ($fix_mode, $has_fixable, etc.) are visible
+# across packages since 'package' does not introduce a new scope.
+package LintParser;
+our @ISA = ('ScriptParser');
+
+package main;
+
+my $exit_code = 0;
+my $has_fixable = 0;
+
+sub err {
+	my ($file, $lineno, $line, $msg, %opts) = @_;
+	$line =~ s/^\s+//;
+	$line =~ s/\s+$//;
+	$line =~ s/\s+/ /g;
+	my $prefix = ($fix_mode && $opts{fixable}) ? 'fixed' : 'error';
+	print "$file:$lineno: $prefix: $msg: $line\n";
+	$exit_code = 1 unless $fix_mode && $opts{fixable};
+}
+
+# Report a lint violation found by a rule.  In --fix mode, apply
+# the regex substitution on the raw line and report success.
+# Otherwise just report.  Returns 1 if the line was modified.
+sub report_violation {
+	my ($file, $cmd, $line_ref, $match, $fix, $from) = @_;
+	my $lineno = $cmd->{lineno};
+	my $display = join(' ', @{$cmd->{tokens}});
+	$has_fixable++;  # count for the "--fix" hint
+	if ($fix_mode) {
+		if ($$line_ref =~ s/$match/$fix/) {
+			err $file, $lineno, $display,
+				"replace '$from' with '$fix'",
+				fixable => 1;
+			return 1;
+		}
+		err $file, $lineno, $display,
+			"replace '$from' with '$fix' (could not auto-fix)";
+	} else {
+		err $file, $lineno, $display,
+			"replace '$from' with '$fix'";
+	}
+	return 0;
+}
+
+# Split a token stream into commands at &&, ||, ;;, and \n.
+sub parse_commands {
+	my ($content) = @_;
+	my $parser = ShellParser->new(\$content);
+	my @all_tokens = $parser->parse();
+
+	my @commands;
+	my @current;
+	my $lineno = 1;
+
+	for (my $ti = 0; $ti < @all_tokens; $ti++) {
+		my $text = $all_tokens[$ti]->[0];
+		if ($text =~ /^(?:&&|\|\||;;|\n)$/) {
+			if (@current) {
+				push @commands, {
+					tokens => [@current],
+					lineno => $lineno,
+				};
+				@current = ();
+			}
+		} else {
+			$lineno = $all_tokens[$ti]->[3]
+				if !@current && defined $all_tokens[$ti]->[3];
+			push @current, $text;
+		}
+	}
+	if (@current) {
+		push @commands, {
+			tokens => [@current],
+			lineno => $lineno,
+		};
+	}
+	return @commands;
+}
+
+# --- Rule: '! test_grep' should be 'test_grep !' ---
+# Shell-level negation suppresses test_grep's diagnostic output
+# on failure.  Built-in negation preserves it.
+sub check_test_grep_negation {
+	my ($cmd, $file, $line_ref) = @_;
+	my @tokens = @{$cmd->{tokens}};
+	return unless @tokens >= 2 && $tokens[0] eq '!' && $tokens[1] eq 'test_grep';
+
+	return report_violation($file, $cmd, $line_ref,
+		qr/!\s*test_grep/, 'test_grep !', '! test_grep');
+}
+
+# Map parsed commands back to raw file lines for --fix.
+# Detection uses parsed tokens (correct handling of quoting,
+# heredocs, pipes) but fixes must modify the original text
+# to preserve formatting.
+package LintParser;
+
+sub check_test {
+	# Called by ScriptParser::parse_cmd for each test_expect_success
+	# or test_expect_failure block.
+	my $self = shift @_;
+	my $title = ScriptParser::unwrap(shift @_);
+
+	# Two test body formats:
+	#   Quoted:  test_expect_success 'title' '..body..'
+	#   Heredoc: test_expect_success 'title' - <<\EOF
+	#              ..body..
+	#            EOF
+	# For quoted, the body token is the quoted string.
+	# For heredoc, the body token is '-' and the actual
+	# code arrives as the next argument from the Lexer.
+	my $body_token = shift @_;
+	my $lineno_base = $body_token->[3] || 1;
+	my $body = ScriptParser::unwrap($body_token);
+
+	if ($body eq '-') {
+		my $herebody = shift @_;
+		if ($herebody) {
+			$body = $herebody->{content};
+			$lineno_base = $herebody->{start_line} || 1;
+		}
+	}
+	return unless $body;
+
+	# Map each command back to its file line number.
+	# $lineno_base is where the body starts in the file;
+	# $cmd->{lineno} is relative to the body (starting at 1).
+	my $raw_lines = $self->{raw_lines};
+	for my $cmd (main::parse_commands($body)) {
+		my $ln = ($cmd->{lineno} || 0) + $lineno_base - 1;
+		$cmd->{lineno} = $ln;
+		next unless $ln >= 1 && $ln <= @$raw_lines;
+		next if $raw_lines->[$ln - 1] =~ /#.*lint-ok/;
+
+		if (main::check_test_grep_negation($cmd, $self->{file}, \$raw_lines->[$ln - 1])) {
+			$self->{dirty} = 1;
+		}
+	}
+}
+
+package main;
+
+for my $file (@ARGV) {
+	# :unix:crlf strips \r on Windows (same as chainlint.pl)
+	open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
+	my @raw_lines = <$fh>;
+	close $fh;
+
+	my $parser = LintParser->new(\join('', @raw_lines));
+	$parser->{file} = $file;
+	$parser->{raw_lines} = \@raw_lines;
+	$parser->{dirty} = 0;
+	$parser->parse();
+
+	if ($fix_mode && $parser->{dirty}) {
+		open(my $out, '>', $file) or die "$0: $file: $!\n";
+		print $out @{$parser->{raw_lines}};
+		close $out;
+	}
+}
+
+if ($has_fixable && !$fix_mode) {
+	print "hint: run with --fix to apply the suggested replacements.\n";
+}
+exit $exit_code;
diff --git a/t/lint-style/heredoc.expect b/t/lint-style/heredoc.expect
new file mode 100644
index 0000000000..7ff6d4a52d
--- /dev/null
+++ b/t/lint-style/heredoc.expect
@@ -0,0 +1,3 @@
+lint-style/heredoc.test:8: error: replace '! test_grep' with 'test_grep !': ! test_grep "after-heredoc-is-caught" actual
+lint-style/heredoc.test:13: error: replace '! test_grep' with 'test_grep !': ! test_grep "not-inside-sed-heredoc" actual
+hint: run with --fix to apply the suggested replacements.
diff --git a/t/lint-style/heredoc.test b/t/lint-style/heredoc.test
new file mode 100644
index 0000000000..4c05831cfb
--- /dev/null
+++ b/t/lint-style/heredoc.test
@@ -0,0 +1,14 @@
+test_expect_success 'greps inside heredocs are skipped' '
+	cat <<-EOF &&
+	grep "inside-strip-tabs" file
+	EOF
+	cat <<-\EOF &&
+	grep "inside-no-expand" file
+	EOF
+	! test_grep "after-heredoc-is-caught" actual
+'
+
+test_expect_success 'sed with << does not start a heredoc' '
+	sed "s/<< foo/bar/" file &&
+	! test_grep "not-inside-sed-heredoc" actual
+'
diff --git a/t/lint-style/test-grep-negation-fix.expect b/t/lint-style/test-grep-negation-fix.expect
new file mode 100644
index 0000000000..28ecde1073
--- /dev/null
+++ b/t/lint-style/test-grep-negation-fix.expect
@@ -0,0 +1,4 @@
+test_expect_success 'negated test_grep' '
+	test_grep ! "pattern" actual &&
+	test_grep ! -i "insensitive" actual
+'
diff --git a/t/lint-style/test-grep-negation-fix.test b/t/lint-style/test-grep-negation-fix.test
new file mode 100644
index 0000000000..571c150031
--- /dev/null
+++ b/t/lint-style/test-grep-negation-fix.test
@@ -0,0 +1,4 @@
+test_expect_success 'negated test_grep' '
+	! test_grep "pattern" actual &&
+	! test_grep -i "insensitive" actual
+'
diff --git a/t/lint-style/test-grep-negation.expect b/t/lint-style/test-grep-negation.expect
new file mode 100644
index 0000000000..1fa9e124aa
--- /dev/null
+++ b/t/lint-style/test-grep-negation.expect
@@ -0,0 +1,3 @@
+lint-style/test-grep-negation.test:2: error: replace '! test_grep' with 'test_grep !': ! test_grep "pattern" actual
+lint-style/test-grep-negation.test:3: error: replace '! test_grep' with 'test_grep !': ! test_grep -i "insensitive" actual
+hint: run with --fix to apply the suggested replacements.
diff --git a/t/lint-style/test-grep-negation.test b/t/lint-style/test-grep-negation.test
new file mode 100644
index 0000000000..571c150031
--- /dev/null
+++ b/t/lint-style/test-grep-negation.test
@@ -0,0 +1,4 @@
+test_expect_success 'negated test_grep' '
+	! test_grep "pattern" actual &&
+	! test_grep -i "insensitive" actual
+'
diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
index 8ef87addf5..e9e2f04049 100755
--- a/t/t0031-lockfile-pid.sh
+++ b/t/t0031-lockfile-pid.sh
@@ -29,7 +29,7 @@ test_expect_success 'PID info not shown by default' '
 		test_must_fail git add . 2>err &&
 		# Should not crash, just show normal error without PID
 		test_grep "Unable to create" err &&
-		! test_grep "is held by process" err
+		test_grep ! "is held by process" err
 	)
 '
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 73445782e7..3179b4963e 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -720,7 +720,7 @@ test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
 
 	# --stdout option silently removes --write-bitmap-index
 	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
-	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
+	test_grep ! "currently, --write-bitmap-index requires --name-hash-version=1" err
 '
 
 test_expect_success '--path-walk pack everything' '
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index fa0d4046f7..9154d9795f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1175,7 +1175,7 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 
 test_expect_success 'usage shown without sub-command' '
 	test_expect_code 129 git multi-pack-index 2>err &&
-	! test_grep "unrecognized subcommand" err
+	test_grep ! "unrecognized subcommand" err
 '
 
 test_expect_success 'complains when run outside of a repository' '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..9db4a76f67 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -664,7 +664,7 @@ test_geometric_repack_needed () {
 	true)
 		test_grep "\[\"git\",\"repack\"," trace2.txt;;
 	false)
-		! test_grep "\[\"git\",\"repack\"," trace2.txt;;
+		test_grep ! "\[\"git\",\"repack\"," trace2.txt;;
 	*)
 		BUG "invalid parameter: $NEEDED";;
 	esac
-- 
gitgitgadget

