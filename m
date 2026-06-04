Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032E2D8382
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598110; cv=pass; b=nCfHi5/asfiiMHetGifHp098tg8X8sxKcGac2Gh4sATR7dn1n/7UH7sMw4hW6XzAECiyBD9o8dqWdeeR4sAhuLMAwfqYc26mYiNSYSZwdOAtRwNCnpC6Sx7U6sAy1HDNZHE7J7K8cCDqNYqlWDh5O89+pazYTUcsFoQi3SnqEr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598110; c=relaxed/simple;
	bh=2yUN8ToOs342XjhRdKf3KIyY2TDQVW0xwmgpY8xnb9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3UL+FOLMeJ7e2pdJM+KKx70sbaBTR9uaG7o4fMFI2CtsPxUze4M0ZumudVuP9C8DjYCbPz5oMIrzrjZ9l3kNSYOTZRb8PZapQGp4l1+doKQtE5+kppdO2XZtRE82F3lTLAKp6XSb/Q7citsHkXINv/k+QXIPZctuD+OBF7TQ+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W187HEuv; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W187HEuv"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c857fba35cfso587217a12.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 11:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780598108; cv=none;
        d=google.com; s=arc-20240605;
        b=X5NgGxQ1kMia2dJJesiTxz+ywHgs0l7QXo1D5L4lCistOAwvs8yj4lbNjdIZYSv/d8
         aYmJ8ImxDCoW/9+tawobZH7HHlCI82lkv561fLHUCw9EG+ZG0Ds9HtJUXds0suOkFo4/
         CG8653ZEc7+nmaldmHi7ateoXKnMrSHDipeNyZcpLjwP+9XbwIBO+NrLDWOW906JUNqV
         XyeAPaewBaxtZ7+AbvqdHAPQ6aiITta+eb52Y6HnnEPXeqR0RYyOSzgytMbny0yTJOKg
         ShWNYqVqSDs9kt33NB4hqaXR7+B56gTVYb+Jg9bt8c48LN0rr/qN3ZY5NZ+6BcOsI+OR
         h0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ru9VB+SDXNQCTMHcc0c1YLmvjw+Z3N/V/jPB3yPbILA=;
        fh=d7CG9QQ8j7roCuntbnIInhTMQyGfkGNX+TRroUwwojM=;
        b=TB5V8LVnxB7uJm/S7T97o6WCEGAoff7u6VMKJhxOZY9S6l5/hcnWZOr7VkuM4pC81c
         R9swK8cZi29mSD6Ufgu1Yt0VnSRsfgNZCIAjgZrtTUhcRtu5McWcZsLoToXQNAc6Y5Bn
         M6w5w+4GUOz1RRPEMmoM5Q8nAADf9JLBhVcAzpLrHZX+VzCw4XXVaKDZ0XYBczIv73An
         3UUD5TCgf2xBZifcg2VJGMk1dabBRbuuyQF9B2dHb7/dyHt5rnqHmOL82xSGDe7IS/JG
         uOZ0o0++PbaYzHNbhZmBZzMBZRaVfliya3waH0O+zz3ha9kn8r4DifChO/ZWxz+bZC8O
         l/Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780598108; x=1781202908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru9VB+SDXNQCTMHcc0c1YLmvjw+Z3N/V/jPB3yPbILA=;
        b=W187HEuvv+bDzioj+fn48xikXrJhwfuQmqVApeavMvGrkOYmBY/IfF6Mx4WaaC4Hd8
         oX/a42D2+b55+kPZfAWQdsJUd56/cd+KcwvaMr+3mJAMmfD5xj7Wh1RhpWbSup2HYWFq
         xFaArI0IK9QsCrIUmJY79Op+mNVi6qGAEhX24dxCcMYMewpFidPmp2n24iScZVpQQva7
         Dk3FHwPJ8mMkVAgs5/w9WKknHRA38UhyBLyITiUkkZEYe+L14uUYlCaOSUlvOPWZj4+s
         hHGQ5kQ3nBQyJqf7kTzF5Bf3nzf6AwcCr3I7vjeQet4HQuThYXYlA3kNVh1eL46l8a/h
         w5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780598108; x=1781202908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ru9VB+SDXNQCTMHcc0c1YLmvjw+Z3N/V/jPB3yPbILA=;
        b=QIN8zDYJ14Qr7xOZhdmDXMHfhP7JsZ1eR9tzGorvMVrMbb9uNRrA0NbkqFPcs9UhX3
         ikK0F3z1aTidIY/X9xZ3SNGj3Vj/NsGcL9azJcXiEZwQlh3AwPuD2714YtsLG0YdLRmU
         4xN9t4QxoKtYZ3tjQJuAd6u0ffQ/X4/iOfmu2+EMKhC3ity7zcBgr2mZmRdPOGZvs719
         h9aggRKktuBh1TyFzL3beHuZ6PPc9ul9mT3Blzjt0oD4gATGbPZOYi5eDUK+pUG1ScwG
         t0zBnEJPRd5QktLkkjggcAzFF/FOAtOS9boAq9SaBm89ORRfh8eLvIDVdPFq+O+U15lQ
         T1Rw==
X-Gm-Message-State: AOJu0YySU67vybBfuQdBjKAQD5H5wjXJuVBdfcYGRBh3jRtvtw/xLb6f
	OzSZyr1jq96VhS7BngZU9PdKBn7tlViiSy+jaSK+UhkkneeUNm59jw35U1fx8/WkUG/3jw/CpZt
	NJ9oCnLjRYJvBeglCPlcX47VgwkNx/uI=
X-Gm-Gg: Acq92OHeObAfuyYeBf87Ljv0nEkXBybNALaCzjQCTULOTq1iHqbgvdE8CFZYV7DUxZW
	MjhhA6WAIOF7ibpAU7/zPVjp/ksCI0CPdmTq35zza83bZJtBE6EivkN1j2xsTKNwCiFTPG2EUDA
	38KAgXbV9nlZK8pemTf7wiGmTAWdTBdr2w89b3Fr0fKkmnGD/SvnpmgiPfERWKrd/NNJE8bLe+X
	8f41nm65EwrfdyddBAirEPfbvVV+Gaab4bPc+i0hEryCJgz35YPa4ph90k5hHsu6uNGNySPOhv6
	FUcEsurDs5bGCJNAm9jMwExQQJh6/0zIoB4FnTU2oeLCCF2nFnFpv/g+b8hXtuw/J0mYM1N96Ty
	GQ28VT4BMurzf9V8=
X-Received: by 2002:a05:6a20:158c:b0:398:9662:10ff with SMTP id
 adf61e73a8af0-3b4cccfde44mr317235637.4.1780598107699; Thu, 04 Jun 2026
 11:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com> <c1b90101ef5c38a21fc901bd7387acf83eb96806.1780559158.git.gitgitgadget@gmail.com>
In-Reply-To: <c1b90101ef5c38a21fc901bd7387acf83eb96806.1780559158.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 4 Jun 2026 14:34:56 -0400
X-Gm-Features: AVHnY4JotKwAJVulicxKw2xmUMocVXMg3wEzO45ydWX4RKis9ft1nx227gl-WRQ
Message-ID: <CALnO6CCjr5xMk=GLHSgf=KQpKJ1FnpimQCYu+BqyufWrRFkh8A@mail.gmail.com>
Subject: Re: [PATCH 4/6] t: add lint-style.pl with test_grep negation rule
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Michael Montalbo <mmontalbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

This sounds like a neat effort!

One drive-by comment=E2=80=A6

On Thu, Jun 4, 2026 at 3:46=E2=80=AFAM Michael Montalbo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Michael Montalbo <mmontalbo@gmail.com>
>
> Add a mechanical lint checker for test scripts, similar in spirit to
> check-non-portable-shell.pl but focused on test conventions rather
> than portability.
>
> The tool defines LintParser, a subclass of ScriptParser (from the
> shared lib-shell-parser.pl module).  ScriptParser's
> parse_cmd() finds test_expect_success blocks and calls check_test()
> for each body; LintParser overrides check_test() to run lint rules
> on the parsed commands.  A "# lint-ok" comment suppresses all
> checks for intentional style violations.
>
> The first rule detects '! test_grep' and replaces it with
> 'test_grep !'.  Shell-level negation suppresses the diagnostic
> output that test_grep prints on failure; the built-in negation
> preserves it.
>
> Three violations inside test bodies are converted via --fix.  One
> additional violation in a helper function outside test_expect_success
> (t7900's test_geometric_repack_needed) is converted manually, since
> the parser only processes test bodies.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  t/.gitattributes                           |   2 +
>  t/Makefile                                 |  32 +++-
>  t/lint-style.pl                            | 200 +++++++++++++++++++++
>  t/lint-style/heredoc.expect                |   3 +
>  t/lint-style/heredoc.test                  |  14 ++
>  t/lint-style/test-grep-negation-fix.expect |   4 +
>  t/lint-style/test-grep-negation-fix.test   |   4 +
>  t/lint-style/test-grep-negation.expect     |   3 +
>  t/lint-style/test-grep-negation.test       |   4 +
>  t/t0031-lockfile-pid.sh                    |   2 +-
>  t/t5300-pack-object.sh                     |   2 +-
>  t/t5319-multi-pack-index.sh                |   2 +-
>  t/t7900-maintenance.sh                     |   2 +-
>  13 files changed, 268 insertions(+), 6 deletions(-)
>  create mode 100755 t/lint-style.pl
>  create mode 100644 t/lint-style/heredoc.expect
>  create mode 100644 t/lint-style/heredoc.test
>  create mode 100644 t/lint-style/test-grep-negation-fix.expect
>  create mode 100644 t/lint-style/test-grep-negation-fix.test
>  create mode 100644 t/lint-style/test-grep-negation.expect
>  create mode 100644 t/lint-style/test-grep-negation.test
>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index 7664c6e027..aea6889d03 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -1,5 +1,7 @@
>  t[0-9][0-9][0-9][0-9]/* -whitespace
>  /chainlint/*.expect eol=3Dlf -whitespace
> +/lint-style/*.expect eol=3Dlf -whitespace
> +/lint-style/*.test eol=3Dlf -whitespace
>  /t0110/url-* binary
>  /t3206/* eol=3Dlf
>  /t3900/*.txt eol=3Dlf
> diff --git a/t/Makefile b/t/Makefile
> index 25f923fed9..3a5fa4ce37 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -46,6 +46,7 @@ TPERF =3D $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-=
*.sh))
>  TINTEROP =3D $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
>  CHAINLINTTESTS =3D $(sort $(patsubst chainlint/%.test,%,$(wildcard chain=
lint/*.test)))
>  CHAINLINT =3D '$(PERL_PATH_SQ)' chainlint.pl
> +LINT_STYLE_TESTS =3D $(sort $(wildcard lint-style/*.test))
>  UNIT_TEST_SOURCES =3D $(wildcard unit-tests/t-*.c)
>  UNIT_TEST_PROGRAMS =3D $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(=
UNIT_TEST_SOURCES))
>  UNIT_TEST_PROGRAMS +=3D unit-tests/bin/unit-tests$(X)
> @@ -139,7 +140,7 @@ check-meson:
>  test-lint: test-lint-duplicates test-lint-executable \
>         test-lint-filenames
>  ifneq ($(PERL_PATH),)
> -test-lint: test-lint-shell-syntax check-shell-parser
> +test-lint: test-lint-shell-syntax test-lint-style check-lint-style check=
-shell-parser
>  else
>  GIT_TEST_CHAIN_LINT =3D 0
>  endif
> @@ -162,6 +163,32 @@ test-lint-shell-syntax:
>
>  check-shell-parser:
>         @'$(PERL_PATH_SQ)' check-shell-parser.pl
> +
> +test-lint-style:
> +       @'$(PERL_PATH_SQ)' lint-style.pl $(T) $(THELPERS) $(TPERF)
> +
> +check-lint-style:
> +       @rc=3D0; for t in $(LINT_STYLE_TESTS); do \
> +               base=3D$${t%.test}; \
> +               case $$base in \
> +               *-fix) \
> +                       cp "$$t" "$$t.tmp" && \
> +                       '$(PERL_PATH_SQ)' lint-style.pl --fix "$$t.tmp" >=
/dev/null 2>&1; \
> +                       fix_rc=3D$$?; \
> +                       if test $$fix_rc !=3D 0; then \
> +                               echo "FAIL: $$t (--fix exit code $$fix_rc=
)"; rc=3D1; \
> +                       elif ! diff -u "$$base.expect" "$$t.tmp"; then \
> +                               echo "FAIL: $$t (--fix output)"; rc=3D1; =
\
> +                       fi; \
> +                       rm -f "$$t.tmp" ;; \
> +               *) \
> +                       if ! '$(PERL_PATH_SQ)' lint-style.pl "$$t" 2>&1 |=
 \
> +                               diff -u "$$base.expect" -; then \
> +                               echo "FAIL: $$t"; rc=3D1; \
> +                       fi ;; \
> +               esac; \
> +       done; test $$rc =3D 0
> +

=E2=80=A6I wonder if it would be easier to maintain this recipe as a separa=
te
shell script and have make give LINT_STYLE_TESTS and PERL_PATH (w/o
SQ? idk) to the script. That's a lot of inline code otherwise!

>  test-lint-filenames:
>         @# We do *not* pass a glob to ls-files but use grep instead, to c=
atch
>         @# non-ASCII characters (which are quoted within double-quotes)
> @@ -188,7 +215,8 @@ perf:
>
>  .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
>         check-chainlint clean-chainlint test-chainlint \
> -       check-shell-parser $(UNIT_TESTS)
> +       check-shell-parser \
> +       check-lint-style test-lint-style $(UNIT_TESTS)
>
>  .PHONY: libgit-sys-test libgit-rs-test
>  libgit-sys-test:
> diff --git a/t/lint-style.pl b/t/lint-style.pl
> new file mode 100755
> index 0000000000..9268577f9b
> --- /dev/null
> +++ b/t/lint-style.pl
> @@ -0,0 +1,200 @@
> +#!/usr/bin/perl
> +
> +# Check test scripts for style violations that can be detected
> +# mechanically, such as using bare 'grep' where test_grep should
> +# be used.  Use --fix to automatically apply suggested replacements.
> +#
> +# Detection uses parsed tokens from the shared shell parser for
> +# correct handling of heredocs, $(...), pipes, and quoting.
> +# Fixes modify the original file text to preserve formatting.
> +
> +use strict;
> +use warnings;
> +use File::Basename;
> +# Force LF output so check-lint-style's diff against the
> +# pre-committed .expect files works on Windows.
> +binmode(STDOUT, ':unix');
> +binmode(STDERR, ':unix');
> +
> +my $fix_mode =3D 0;
> +if (@ARGV && $ARGV[0] eq '--fix') {
> +       $fix_mode =3D 1;
> +       shift @ARGV;
> +}
> +
> +# Load the shared shell parser (Lexer, ShellParser, ScriptParser).
> +my $_lib =3D dirname($0) . "/lib-shell-parser.pl";
> +$_lib =3D "./$_lib" unless $_lib =3D~ m{^/};
> +do $_lib or die "$0: failed to load $_lib: $@$!\n";
> +
> +# LintParser is a subclass of ScriptParser which runs lint rules
> +# on each test body.  Per-file state (file name, raw lines, dirty
> +# flag) is stored on the instance before calling parse().
> +#
> +# Subroutines defined below (parse_commands, check_test_grep_negation,
> +# etc.) are in package main and called with the main:: prefix.
> +# File-scoped lexicals ($fix_mode, $has_fixable, etc.) are visible
> +# across packages since 'package' does not introduce a new scope.
> +package LintParser;
> +our @ISA =3D ('ScriptParser');
> +
> +package main;
> +
> +my $exit_code =3D 0;
> +my $has_fixable =3D 0;
> +
> +sub err {
> +       my ($file, $lineno, $line, $msg, %opts) =3D @_;
> +       $line =3D~ s/^\s+//;
> +       $line =3D~ s/\s+$//;
> +       $line =3D~ s/\s+/ /g;
> +       my $prefix =3D ($fix_mode && $opts{fixable}) ? 'fixed' : 'error';
> +       print "$file:$lineno: $prefix: $msg: $line\n";
> +       $exit_code =3D 1 unless $fix_mode && $opts{fixable};
> +}
> +
> +# Report a lint violation found by a rule.  In --fix mode, apply
> +# the regex substitution on the raw line and report success.
> +# Otherwise just report.  Returns 1 if the line was modified.
> +sub report_violation {
> +       my ($file, $cmd, $line_ref, $match, $fix, $from) =3D @_;
> +       my $lineno =3D $cmd->{lineno};
> +       my $display =3D join(' ', @{$cmd->{tokens}});
> +       $has_fixable++;  # count for the "--fix" hint
> +       if ($fix_mode) {
> +               if ($$line_ref =3D~ s/$match/$fix/) {
> +                       err $file, $lineno, $display,
> +                               "replace '$from' with '$fix'",
> +                               fixable =3D> 1;
> +                       return 1;
> +               }
> +               err $file, $lineno, $display,
> +                       "replace '$from' with '$fix' (could not auto-fix)=
";
> +       } else {
> +               err $file, $lineno, $display,
> +                       "replace '$from' with '$fix'";
> +       }
> +       return 0;
> +}
> +
> +# Split a token stream into commands at &&, ||, ;;, and \n.
> +sub parse_commands {
> +       my ($content) =3D @_;
> +       my $parser =3D ShellParser->new(\$content);
> +       my @all_tokens =3D $parser->parse();
> +
> +       my @commands;
> +       my @current;
> +       my $lineno =3D 1;
> +
> +       for (my $ti =3D 0; $ti < @all_tokens; $ti++) {
> +               my $text =3D $all_tokens[$ti]->[0];
> +               if ($text =3D~ /^(?:&&|\|\||;;|\n)$/) {
> +                       if (@current) {
> +                               push @commands, {
> +                                       tokens =3D> [@current],
> +                                       lineno =3D> $lineno,
> +                               };
> +                               @current =3D ();
> +                       }
> +               } else {
> +                       $lineno =3D $all_tokens[$ti]->[3]
> +                               if !@current && defined $all_tokens[$ti]-=
>[3];
> +                       push @current, $text;
> +               }
> +       }
> +       if (@current) {
> +               push @commands, {
> +                       tokens =3D> [@current],
> +                       lineno =3D> $lineno,
> +               };
> +       }
> +       return @commands;
> +}
> +
> +# --- Rule: '! test_grep' should be 'test_grep !' ---
> +# Shell-level negation suppresses test_grep's diagnostic output
> +# on failure.  Built-in negation preserves it.
> +sub check_test_grep_negation {
> +       my ($cmd, $file, $line_ref) =3D @_;
> +       my @tokens =3D @{$cmd->{tokens}};
> +       return unless @tokens >=3D 2 && $tokens[0] eq '!' && $tokens[1] e=
q 'test_grep';
> +
> +       return report_violation($file, $cmd, $line_ref,
> +               qr/!\s*test_grep/, 'test_grep !', '! test_grep');
> +}
> +
> +# Map parsed commands back to raw file lines for --fix.
> +# Detection uses parsed tokens (correct handling of quoting,
> +# heredocs, pipes) but fixes must modify the original text
> +# to preserve formatting.
> +package LintParser;
> +
> +sub check_test {
> +       # Called by ScriptParser::parse_cmd for each test_expect_success
> +       # or test_expect_failure block.
> +       my $self =3D shift @_;
> +       my $title =3D ScriptParser::unwrap(shift @_);
> +
> +       # Two test body formats:
> +       #   Quoted:  test_expect_success 'title' '..body..'
> +       #   Heredoc: test_expect_success 'title' - <<\EOF
> +       #              ..body..
> +       #            EOF
> +       # For quoted, the body token is the quoted string.
> +       # For heredoc, the body token is '-' and the actual
> +       # code arrives as the next argument from the Lexer.
> +       my $body_token =3D shift @_;
> +       my $lineno_base =3D $body_token->[3] || 1;
> +       my $body =3D ScriptParser::unwrap($body_token);
> +
> +       if ($body eq '-') {
> +               my $herebody =3D shift @_;
> +               if ($herebody) {
> +                       $body =3D $herebody->{content};
> +                       $lineno_base =3D $herebody->{start_line} || 1;
> +               }
> +       }
> +       return unless $body;
> +
> +       # Map each command back to its file line number.
> +       # $lineno_base is where the body starts in the file;
> +       # $cmd->{lineno} is relative to the body (starting at 1).
> +       my $raw_lines =3D $self->{raw_lines};
> +       for my $cmd (main::parse_commands($body)) {
> +               my $ln =3D ($cmd->{lineno} || 0) + $lineno_base - 1;
> +               $cmd->{lineno} =3D $ln;
> +               next unless $ln >=3D 1 && $ln <=3D @$raw_lines;
> +               next if $raw_lines->[$ln - 1] =3D~ /#.*lint-ok/;
> +
> +               if (main::check_test_grep_negation($cmd, $self->{file}, \=
$raw_lines->[$ln - 1])) {
> +                       $self->{dirty} =3D 1;
> +               }
> +       }
> +}
> +
> +package main;
> +
> +for my $file (@ARGV) {
> +       # :unix:crlf strips \r on Windows (same as chainlint.pl)
> +       open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
> +       my @raw_lines =3D <$fh>;
> +       close $fh;
> +
> +       my $parser =3D LintParser->new(\join('', @raw_lines));
> +       $parser->{file} =3D $file;
> +       $parser->{raw_lines} =3D \@raw_lines;
> +       $parser->{dirty} =3D 0;
> +       $parser->parse();
> +
> +       if ($fix_mode && $parser->{dirty}) {
> +               open(my $out, '>', $file) or die "$0: $file: $!\n";
> +               print $out @{$parser->{raw_lines}};
> +               close $out;
> +       }
> +}
> +
> +if ($has_fixable && !$fix_mode) {
> +       print "hint: run with --fix to apply the suggested replacements.\=
n";
> +}
> +exit $exit_code;
> diff --git a/t/lint-style/heredoc.expect b/t/lint-style/heredoc.expect
> new file mode 100644
> index 0000000000..7ff6d4a52d
> --- /dev/null
> +++ b/t/lint-style/heredoc.expect
> @@ -0,0 +1,3 @@
> +lint-style/heredoc.test:8: error: replace '! test_grep' with 'test_grep =
!': ! test_grep "after-heredoc-is-caught" actual
> +lint-style/heredoc.test:13: error: replace '! test_grep' with 'test_grep=
 !': ! test_grep "not-inside-sed-heredoc" actual
> +hint: run with --fix to apply the suggested replacements.
> diff --git a/t/lint-style/heredoc.test b/t/lint-style/heredoc.test
> new file mode 100644
> index 0000000000..4c05831cfb
> --- /dev/null
> +++ b/t/lint-style/heredoc.test
> @@ -0,0 +1,14 @@
> +test_expect_success 'greps inside heredocs are skipped' '
> +       cat <<-EOF &&
> +       grep "inside-strip-tabs" file
> +       EOF
> +       cat <<-\EOF &&
> +       grep "inside-no-expand" file
> +       EOF
> +       ! test_grep "after-heredoc-is-caught" actual
> +'
> +
> +test_expect_success 'sed with << does not start a heredoc' '
> +       sed "s/<< foo/bar/" file &&
> +       ! test_grep "not-inside-sed-heredoc" actual
> +'
> diff --git a/t/lint-style/test-grep-negation-fix.expect b/t/lint-style/te=
st-grep-negation-fix.expect
> new file mode 100644
> index 0000000000..28ecde1073
> --- /dev/null
> +++ b/t/lint-style/test-grep-negation-fix.expect
> @@ -0,0 +1,4 @@
> +test_expect_success 'negated test_grep' '
> +       test_grep ! "pattern" actual &&
> +       test_grep ! -i "insensitive" actual
> +'
> diff --git a/t/lint-style/test-grep-negation-fix.test b/t/lint-style/test=
-grep-negation-fix.test
> new file mode 100644
> index 0000000000..571c150031
> --- /dev/null
> +++ b/t/lint-style/test-grep-negation-fix.test
> @@ -0,0 +1,4 @@
> +test_expect_success 'negated test_grep' '
> +       ! test_grep "pattern" actual &&
> +       ! test_grep -i "insensitive" actual
> +'
> diff --git a/t/lint-style/test-grep-negation.expect b/t/lint-style/test-g=
rep-negation.expect
> new file mode 100644
> index 0000000000..1fa9e124aa
> --- /dev/null
> +++ b/t/lint-style/test-grep-negation.expect
> @@ -0,0 +1,3 @@
> +lint-style/test-grep-negation.test:2: error: replace '! test_grep' with =
'test_grep !': ! test_grep "pattern" actual
> +lint-style/test-grep-negation.test:3: error: replace '! test_grep' with =
'test_grep !': ! test_grep -i "insensitive" actual
> +hint: run with --fix to apply the suggested replacements.
> diff --git a/t/lint-style/test-grep-negation.test b/t/lint-style/test-gre=
p-negation.test
> new file mode 100644
> index 0000000000..571c150031
> --- /dev/null
> +++ b/t/lint-style/test-grep-negation.test
> @@ -0,0 +1,4 @@
> +test_expect_success 'negated test_grep' '
> +       ! test_grep "pattern" actual &&
> +       ! test_grep -i "insensitive" actual
> +'
> diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
> index 8ef87addf5..e9e2f04049 100755
> --- a/t/t0031-lockfile-pid.sh
> +++ b/t/t0031-lockfile-pid.sh
> @@ -29,7 +29,7 @@ test_expect_success 'PID info not shown by default' '
>                 test_must_fail git add . 2>err &&
>                 # Should not crash, just show normal error without PID
>                 test_grep "Unable to create" err &&
> -               ! test_grep "is held by process" err
> +               test_grep ! "is held by process" err
>         )
>  '
>
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 73445782e7..3179b4963e 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -720,7 +720,7 @@ test_expect_success '--name-hash-version=3D2 and --wr=
ite-bitmap-index are incompat
>
>         # --stdout option silently removes --write-bitmap-index
>         git pack-objects --stdout --all --name-hash-version=3D2 --write-b=
itmap-index >out 2>err &&
> -       ! test_grep "currently, --write-bitmap-index requires --name-hash=
-version=3D1" err
> +       test_grep ! "currently, --write-bitmap-index requires --name-hash=
-version=3D1" err
>  '
>
>  test_expect_success '--path-walk pack everything' '
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index fa0d4046f7..9154d9795f 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -1175,7 +1175,7 @@ test_expect_success 'load reverse index when missin=
g .idx, .pack' '
>
>  test_expect_success 'usage shown without sub-command' '
>         test_expect_code 129 git multi-pack-index 2>err &&
> -       ! test_grep "unrecognized subcommand" err
> +       test_grep ! "unrecognized subcommand" err
>  '
>
>  test_expect_success 'complains when run outside of a repository' '
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d7f82e1bec..9db4a76f67 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -664,7 +664,7 @@ test_geometric_repack_needed () {
>         true)
>                 test_grep "\[\"git\",\"repack\"," trace2.txt;;
>         false)
> -               ! test_grep "\[\"git\",\"repack\"," trace2.txt;;
> +               test_grep ! "\[\"git\",\"repack\"," trace2.txt;;
>         *)
>                 BUG "invalid parameter: $NEEDED";;
>         esac
> --
> gitgitgadget
>


--=20
D. Ben Knoble
