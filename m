Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BF388886
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601823; cv=pass; b=BasXJ2YZUPHmatZRyW/zyB3U7IjpF6BnFmGGykLPckXFhNkf99fqFLtDdrutMo5RpdIDMXtRoeUik0DIQgtxFmy1MndpIXUajPsaFmSrTyk8RoYPERAz0bkHu345AskVi49eLvaoqWjL4UxnuT2OKReYlBY7SF0lSJEAc77vK30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601823; c=relaxed/simple;
	bh=LlDsm29/ik19EAb1wDrKU3tuaGN/pdAwgd0vCu7mm7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxctF2CoaQjJM1WgaK9+3HHMNCObPc8X39dbNdSofAcqbcy4KpiFW4jPmHwp/Xb2qGDWMZw26uOpPPkGaJKmzOCJvBh/Pov2rLBwhShMXnsbnvCgRxYdrJZ48N/X2ZJ7l+TT+HeRoLQArAXhxnsApwF4JcbNsN6xRFTj2HzdLmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjHi50jX; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjHi50jX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b5737bb2so872428a34.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 12:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780601820; cv=none;
        d=google.com; s=arc-20240605;
        b=NPa/86lu8TvRa3jmYv/z9wcJa1kIJAx7GcWPbnmtSNe9GCOdkLkWwGeWD19IaFzQsg
         o+F0hE7waeEPm5vGjIEpyPSsEP1gIIAav6kamTgavuuezPR5WOGJqGtgDe24GWXxWT7R
         yiC05E8w5ch2YInbXKnw5M+m7Sd+/wvziaGYYvaMECp5dH5c8CFQd76xieskqqbmpVtk
         aH5A0f9/+oOjYYtHP3TXlnMiBSq+FwoKIYJCeajTvKJBTmfTW4EBxpSxkDJtgUYFzUe0
         NTAuwbFOUFvCN26cO4mvZ1lM0CP9tDJGQLG6/JzGD2A2XklOODN4T7oCosdIorYV7c+b
         HHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t3/Y6MfbzYC7CJD3LVVjP0HSgO4Wouyp/CHrljVzKHk=;
        fh=ls5HW7T0TfSoOBObTs3z0/IV7DN3b+wpK05Z9w8WyH4=;
        b=U8/YpDa4FMzF1MTquTc5ixHb9GXbM33WTvspT5jtz6BecM+XREV4IFZThIoicbSSrD
         7CymCEe7mJaijeBeDGkZ8e1b8tbOQjo6W0coOj0+LbJHEupcl7ff7unknmkqCM82V4Rc
         071X9q1hyspGpd4hIDu1cyVnjwBOBTqOXNrL3EJJo0YD0sRO7mAJJ2Bq8EIyWp8xk5ao
         4wQuRX9MitQxADDYVw7RYvXhGINdUzjafSK06vOJ+uwo3uMoVymVuP2vJmpGXu/GM2Nk
         avmURPHYx6o+jYyWcb5Ve9ilqjhdwKL469ugMlr6XN+qqXAzH8bwqoE5RJVANwm+3uMw
         H6KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780601820; x=1781206620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3/Y6MfbzYC7CJD3LVVjP0HSgO4Wouyp/CHrljVzKHk=;
        b=bjHi50jXLGuBHtwOpcVeVhDGDGoGLY1tiisYWUeee5P0Km/dp9U8DPH7ZXFLkxxr3R
         g77fnbg4PaPVJ4e+NTrFk8igqZetET6P92AfOlV8Hm56b/xnNoCLTd1dvAd/G9ADdd5w
         Fk3a09hvCQKBX2hhtDa+Ck1kcGFtFnwI92hCdaYSRk+bneBJu/vx9b1Gpry0NdsN3jTq
         of2GuNXF2H7aBVdDEtWM1MOfJ2m6yPsh9RdWQqK7MFbRjSDnl3d2vcASFXCKFhRIWeBI
         Cqk+J+GtpnVDIMXn93t9YkJCWX2mDTISB1CzNpFsWPd6dwlKoiin2wodNnzJCulaD3to
         qiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601820; x=1781206620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3/Y6MfbzYC7CJD3LVVjP0HSgO4Wouyp/CHrljVzKHk=;
        b=miJ8qdlVoxVrCm4h5oHaOvj04KTOIfTBAH9Z3rtpRyiOL24o3ATufzkYMGMzwQpNKL
         KPRQUOL8tM8WeXomLJIKxKPNgihoWzcVSnVi8J0+uF/T93gWFq6RKQInbrZgQOtLBWWS
         5bCEzstpogT9qSgDx1J8D3aWsx0XnQtn48lMdch68pCsAvhUeK6cgsNDoEAOfuWJy+/E
         lYrA4RHoqB9542J4uz9KIrxaht493TyCQqnXRZ9sSqlk1eCqUWkTYoMb232taX1ZbAuj
         a7iwkXhIK2O4hDiFtQRsFfsDrynDzOyYSHMdnpJvIgGEe/Se7ug10KkwQwWHteakUnI/
         Vkkw==
X-Forwarded-Encrypted: i=1; AFNElJ+N4G4yZ50jMAvVXWP0BE1edfHRRdETskhlnlzOEY2WVlKffLCOv8mHsrKlTpiqfdXMoLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21fL1cw3C5xvqC6KzutZtqnT9S4Yq+FbbwFdhTCLReXqIdGr0
	oy6mavs6OpOsmplWfG7LRtMLAjhlxYP/s84TAQz6/jwiZPX8DWh3DV1cLPTMafqm0ZYeQz2jP61
	lQ8UbjQMUrc+HlBSb8A6fEMtE7CFKCWCDtEmI
X-Gm-Gg: Acq92OGs0Ly5ZQ2KidgKM3vI85uzVH6ZgtVXh7ZNeas18Iz0XQbSbiN96iunMA5+nHI
	mjUrSlw/FTBYL+5us/T3W54HHyg9yr2EJ6caVjYiLbalxTuPvzg2KLOrESVMz5JRhzLZu0GCYEu
	veO/lkz+34sElI/Oh53YbEEFNqvWfgX4qNiQnvzlrTT6B3zErztX1SO0SG2iRED5w1HqFmrJ47k
	YObY5k1ccLWb2GIgm/hombdMlGzZuX3cd/iUUWs2/vAQPWJoJnldJQsKn7chH8cgdAu5IHGZ33A
	122DMp0VC61SjzHqKEVSmPDeL8Pv4spjlbRVKUR7LJFcnUcZ1CU=
X-Received: by 2002:a05:6820:4b90:b0:69d:9e7c:cb59 with SMTP id
 006d021491bc7-69e68c0437cmr294967eaf.37.1780601820201; Thu, 04 Jun 2026
 12:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
 <c1b90101ef5c38a21fc901bd7387acf83eb96806.1780559158.git.gitgitgadget@gmail.com>
 <CALnO6CCjr5xMk=GLHSgf=KQpKJ1FnpimQCYu+BqyufWrRFkh8A@mail.gmail.com>
In-Reply-To: <CALnO6CCjr5xMk=GLHSgf=KQpKJ1FnpimQCYu+BqyufWrRFkh8A@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 4 Jun 2026 12:36:49 -0700
X-Gm-Features: AVHnY4IJbbyRRkQn1fUpuv10R-q7wrmtVUaTJSwIGjksursxjrEq_vVVuOqAeSo
Message-ID: <CAC2QwmKGkrMVPzYsZLtVrE3H+H7uYxhyX2wh2vgNVbR3sxGv2Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] t: add lint-style.pl with test_grep negation rule
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 11:35=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> Hi Michael,
>
> This sounds like a neat effort!
>
> One drive-by comment=E2=80=A6
>
> On Thu, Jun 4, 2026 at 3:46=E2=80=AFAM Michael Montalbo via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Michael Montalbo <mmontalbo@gmail.com>
> >
> > Add a mechanical lint checker for test scripts, similar in spirit to
> > check-non-portable-shell.pl but focused on test conventions rather
> > than portability.
> >
> > The tool defines LintParser, a subclass of ScriptParser (from the
> > shared lib-shell-parser.pl module).  ScriptParser's
> > parse_cmd() finds test_expect_success blocks and calls check_test()
> > for each body; LintParser overrides check_test() to run lint rules
> > on the parsed commands.  A "# lint-ok" comment suppresses all
> > checks for intentional style violations.
> >
> > The first rule detects '! test_grep' and replaces it with
> > 'test_grep !'.  Shell-level negation suppresses the diagnostic
> > output that test_grep prints on failure; the built-in negation
> > preserves it.
> >
> > Three violations inside test bodies are converted via --fix.  One
> > additional violation in a helper function outside test_expect_success
> > (t7900's test_geometric_repack_needed) is converted manually, since
> > the parser only processes test bodies.
> >
> > Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> > ---
> >  t/.gitattributes                           |   2 +
> >  t/Makefile                                 |  32 +++-
> >  t/lint-style.pl                            | 200 +++++++++++++++++++++
> >  t/lint-style/heredoc.expect                |   3 +
> >  t/lint-style/heredoc.test                  |  14 ++
> >  t/lint-style/test-grep-negation-fix.expect |   4 +
> >  t/lint-style/test-grep-negation-fix.test   |   4 +
> >  t/lint-style/test-grep-negation.expect     |   3 +
> >  t/lint-style/test-grep-negation.test       |   4 +
> >  t/t0031-lockfile-pid.sh                    |   2 +-
> >  t/t5300-pack-object.sh                     |   2 +-
> >  t/t5319-multi-pack-index.sh                |   2 +-
> >  t/t7900-maintenance.sh                     |   2 +-
> >  13 files changed, 268 insertions(+), 6 deletions(-)
> >  create mode 100755 t/lint-style.pl
> >  create mode 100644 t/lint-style/heredoc.expect
> >  create mode 100644 t/lint-style/heredoc.test
> >  create mode 100644 t/lint-style/test-grep-negation-fix.expect
> >  create mode 100644 t/lint-style/test-grep-negation-fix.test
> >  create mode 100644 t/lint-style/test-grep-negation.expect
> >  create mode 100644 t/lint-style/test-grep-negation.test
> >
> > diff --git a/t/.gitattributes b/t/.gitattributes
> > index 7664c6e027..aea6889d03 100644
> > --- a/t/.gitattributes
> > +++ b/t/.gitattributes
> > @@ -1,5 +1,7 @@
> >  t[0-9][0-9][0-9][0-9]/* -whitespace
> >  /chainlint/*.expect eol=3Dlf -whitespace
> > +/lint-style/*.expect eol=3Dlf -whitespace
> > +/lint-style/*.test eol=3Dlf -whitespace
> >  /t0110/url-* binary
> >  /t3206/* eol=3Dlf
> >  /t3900/*.txt eol=3Dlf
> > diff --git a/t/Makefile b/t/Makefile
> > index 25f923fed9..3a5fa4ce37 100644
> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -46,6 +46,7 @@ TPERF =3D $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9=
]-*.sh))
> >  TINTEROP =3D $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
> >  CHAINLINTTESTS =3D $(sort $(patsubst chainlint/%.test,%,$(wildcard cha=
inlint/*.test)))
> >  CHAINLINT =3D '$(PERL_PATH_SQ)' chainlint.pl
> > +LINT_STYLE_TESTS =3D $(sort $(wildcard lint-style/*.test))
> >  UNIT_TEST_SOURCES =3D $(wildcard unit-tests/t-*.c)
> >  UNIT_TEST_PROGRAMS =3D $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),=
$(UNIT_TEST_SOURCES))
> >  UNIT_TEST_PROGRAMS +=3D unit-tests/bin/unit-tests$(X)
> > @@ -139,7 +140,7 @@ check-meson:
> >  test-lint: test-lint-duplicates test-lint-executable \
> >         test-lint-filenames
> >  ifneq ($(PERL_PATH),)
> > -test-lint: test-lint-shell-syntax check-shell-parser
> > +test-lint: test-lint-shell-syntax test-lint-style check-lint-style che=
ck-shell-parser
> >  else
> >  GIT_TEST_CHAIN_LINT =3D 0
> >  endif
> > @@ -162,6 +163,32 @@ test-lint-shell-syntax:
> >
> >  check-shell-parser:
> >         @'$(PERL_PATH_SQ)' check-shell-parser.pl
> > +
> > +test-lint-style:
> > +       @'$(PERL_PATH_SQ)' lint-style.pl $(T) $(THELPERS) $(TPERF)
> > +
> > +check-lint-style:
> > +       @rc=3D0; for t in $(LINT_STYLE_TESTS); do \
> > +               base=3D$${t%.test}; \
> > +               case $$base in \
> > +               *-fix) \
> > +                       cp "$$t" "$$t.tmp" && \
> > +                       '$(PERL_PATH_SQ)' lint-style.pl --fix "$$t.tmp"=
 >/dev/null 2>&1; \
> > +                       fix_rc=3D$$?; \
> > +                       if test $$fix_rc !=3D 0; then \
> > +                               echo "FAIL: $$t (--fix exit code $$fix_=
rc)"; rc=3D1; \
> > +                       elif ! diff -u "$$base.expect" "$$t.tmp"; then =
\
> > +                               echo "FAIL: $$t (--fix output)"; rc=3D1=
; \
> > +                       fi; \
> > +                       rm -f "$$t.tmp" ;; \
> > +               *) \
> > +                       if ! '$(PERL_PATH_SQ)' lint-style.pl "$$t" 2>&1=
 | \
> > +                               diff -u "$$base.expect" -; then \
> > +                               echo "FAIL: $$t"; rc=3D1; \
> > +                       fi ;; \
> > +               esac; \
> > +       done; test $$rc =3D 0
> > +
>
> =E2=80=A6I wonder if it would be easier to maintain this recipe as a sepa=
rate
> shell script and have make give LINT_STYLE_TESTS and PERL_PATH (w/o
> SQ? idk) to the script. That's a lot of inline code otherwise!
>

Yeah that's a good call out, will fix in a follow-up. Thank you for
taking a look!

> >  test-lint-filenames:
> >         @# We do *not* pass a glob to ls-files but use grep instead, to=
 catch
> >         @# non-ASCII characters (which are quoted within double-quotes)
> > @@ -188,7 +215,8 @@ perf:
> >
> >  .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
> >         check-chainlint clean-chainlint test-chainlint \
> > -       check-shell-parser $(UNIT_TESTS)
> > +       check-shell-parser \
> > +       check-lint-style test-lint-style $(UNIT_TESTS)
> >
> >  .PHONY: libgit-sys-test libgit-rs-test
> >  libgit-sys-test:
> > diff --git a/t/lint-style.pl b/t/lint-style.pl
> > new file mode 100755
> > index 0000000000..9268577f9b
> > --- /dev/null
> > +++ b/t/lint-style.pl
> > @@ -0,0 +1,200 @@
> > +#!/usr/bin/perl
> > +
> > +# Check test scripts for style violations that can be detected
> > +# mechanically, such as using bare 'grep' where test_grep should
> > +# be used.  Use --fix to automatically apply suggested replacements.
> > +#
> > +# Detection uses parsed tokens from the shared shell parser for
> > +# correct handling of heredocs, $(...), pipes, and quoting.
> > +# Fixes modify the original file text to preserve formatting.
> > +
> > +use strict;
> > +use warnings;
> > +use File::Basename;
> > +# Force LF output so check-lint-style's diff against the
> > +# pre-committed .expect files works on Windows.
> > +binmode(STDOUT, ':unix');
> > +binmode(STDERR, ':unix');
> > +
> > +my $fix_mode =3D 0;
> > +if (@ARGV && $ARGV[0] eq '--fix') {
> > +       $fix_mode =3D 1;
> > +       shift @ARGV;
> > +}
> > +
> > +# Load the shared shell parser (Lexer, ShellParser, ScriptParser).
> > +my $_lib =3D dirname($0) . "/lib-shell-parser.pl";
> > +$_lib =3D "./$_lib" unless $_lib =3D~ m{^/};
> > +do $_lib or die "$0: failed to load $_lib: $@$!\n";
> > +
> > +# LintParser is a subclass of ScriptParser which runs lint rules
> > +# on each test body.  Per-file state (file name, raw lines, dirty
> > +# flag) is stored on the instance before calling parse().
> > +#
> > +# Subroutines defined below (parse_commands, check_test_grep_negation,
> > +# etc.) are in package main and called with the main:: prefix.
> > +# File-scoped lexicals ($fix_mode, $has_fixable, etc.) are visible
> > +# across packages since 'package' does not introduce a new scope.
> > +package LintParser;
> > +our @ISA =3D ('ScriptParser');
> > +
> > +package main;
> > +
> > +my $exit_code =3D 0;
> > +my $has_fixable =3D 0;
> > +
> > +sub err {
> > +       my ($file, $lineno, $line, $msg, %opts) =3D @_;
> > +       $line =3D~ s/^\s+//;
> > +       $line =3D~ s/\s+$//;
> > +       $line =3D~ s/\s+/ /g;
> > +       my $prefix =3D ($fix_mode && $opts{fixable}) ? 'fixed' : 'error=
';
> > +       print "$file:$lineno: $prefix: $msg: $line\n";
> > +       $exit_code =3D 1 unless $fix_mode && $opts{fixable};
> > +}
> > +
> > +# Report a lint violation found by a rule.  In --fix mode, apply
> > +# the regex substitution on the raw line and report success.
> > +# Otherwise just report.  Returns 1 if the line was modified.
> > +sub report_violation {
> > +       my ($file, $cmd, $line_ref, $match, $fix, $from) =3D @_;
> > +       my $lineno =3D $cmd->{lineno};
> > +       my $display =3D join(' ', @{$cmd->{tokens}});
> > +       $has_fixable++;  # count for the "--fix" hint
> > +       if ($fix_mode) {
> > +               if ($$line_ref =3D~ s/$match/$fix/) {
> > +                       err $file, $lineno, $display,
> > +                               "replace '$from' with '$fix'",
> > +                               fixable =3D> 1;
> > +                       return 1;
> > +               }
> > +               err $file, $lineno, $display,
> > +                       "replace '$from' with '$fix' (could not auto-fi=
x)";
> > +       } else {
> > +               err $file, $lineno, $display,
> > +                       "replace '$from' with '$fix'";
> > +       }
> > +       return 0;
> > +}
> > +
> > +# Split a token stream into commands at &&, ||, ;;, and \n.
> > +sub parse_commands {
> > +       my ($content) =3D @_;
> > +       my $parser =3D ShellParser->new(\$content);
> > +       my @all_tokens =3D $parser->parse();
> > +
> > +       my @commands;
> > +       my @current;
> > +       my $lineno =3D 1;
> > +
> > +       for (my $ti =3D 0; $ti < @all_tokens; $ti++) {
> > +               my $text =3D $all_tokens[$ti]->[0];
> > +               if ($text =3D~ /^(?:&&|\|\||;;|\n)$/) {
> > +                       if (@current) {
> > +                               push @commands, {
> > +                                       tokens =3D> [@current],
> > +                                       lineno =3D> $lineno,
> > +                               };
> > +                               @current =3D ();
> > +                       }
> > +               } else {
> > +                       $lineno =3D $all_tokens[$ti]->[3]
> > +                               if !@current && defined $all_tokens[$ti=
]->[3];
> > +                       push @current, $text;
> > +               }
> > +       }
> > +       if (@current) {
> > +               push @commands, {
> > +                       tokens =3D> [@current],
> > +                       lineno =3D> $lineno,
> > +               };
> > +       }
> > +       return @commands;
> > +}
> > +
> > +# --- Rule: '! test_grep' should be 'test_grep !' ---
> > +# Shell-level negation suppresses test_grep's diagnostic output
> > +# on failure.  Built-in negation preserves it.
> > +sub check_test_grep_negation {
> > +       my ($cmd, $file, $line_ref) =3D @_;
> > +       my @tokens =3D @{$cmd->{tokens}};
> > +       return unless @tokens >=3D 2 && $tokens[0] eq '!' && $tokens[1]=
 eq 'test_grep';
> > +
> > +       return report_violation($file, $cmd, $line_ref,
> > +               qr/!\s*test_grep/, 'test_grep !', '! test_grep');
> > +}
> > +
> > +# Map parsed commands back to raw file lines for --fix.
> > +# Detection uses parsed tokens (correct handling of quoting,
> > +# heredocs, pipes) but fixes must modify the original text
> > +# to preserve formatting.
> > +package LintParser;
> > +
> > +sub check_test {
> > +       # Called by ScriptParser::parse_cmd for each test_expect_succes=
s
> > +       # or test_expect_failure block.
> > +       my $self =3D shift @_;
> > +       my $title =3D ScriptParser::unwrap(shift @_);
> > +
> > +       # Two test body formats:
> > +       #   Quoted:  test_expect_success 'title' '..body..'
> > +       #   Heredoc: test_expect_success 'title' - <<\EOF
> > +       #              ..body..
> > +       #            EOF
> > +       # For quoted, the body token is the quoted string.
> > +       # For heredoc, the body token is '-' and the actual
> > +       # code arrives as the next argument from the Lexer.
> > +       my $body_token =3D shift @_;
> > +       my $lineno_base =3D $body_token->[3] || 1;
> > +       my $body =3D ScriptParser::unwrap($body_token);
> > +
> > +       if ($body eq '-') {
> > +               my $herebody =3D shift @_;
> > +               if ($herebody) {
> > +                       $body =3D $herebody->{content};
> > +                       $lineno_base =3D $herebody->{start_line} || 1;
> > +               }
> > +       }
> > +       return unless $body;
> > +
> > +       # Map each command back to its file line number.
> > +       # $lineno_base is where the body starts in the file;
> > +       # $cmd->{lineno} is relative to the body (starting at 1).
> > +       my $raw_lines =3D $self->{raw_lines};
> > +       for my $cmd (main::parse_commands($body)) {
> > +               my $ln =3D ($cmd->{lineno} || 0) + $lineno_base - 1;
> > +               $cmd->{lineno} =3D $ln;
> > +               next unless $ln >=3D 1 && $ln <=3D @$raw_lines;
> > +               next if $raw_lines->[$ln - 1] =3D~ /#.*lint-ok/;
> > +
> > +               if (main::check_test_grep_negation($cmd, $self->{file},=
 \$raw_lines->[$ln - 1])) {
> > +                       $self->{dirty} =3D 1;
> > +               }
> > +       }
> > +}
> > +
> > +package main;
> > +
> > +for my $file (@ARGV) {
> > +       # :unix:crlf strips \r on Windows (same as chainlint.pl)
> > +       open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
> > +       my @raw_lines =3D <$fh>;
> > +       close $fh;
> > +
> > +       my $parser =3D LintParser->new(\join('', @raw_lines));
> > +       $parser->{file} =3D $file;
> > +       $parser->{raw_lines} =3D \@raw_lines;
> > +       $parser->{dirty} =3D 0;
> > +       $parser->parse();
> > +
> > +       if ($fix_mode && $parser->{dirty}) {
> > +               open(my $out, '>', $file) or die "$0: $file: $!\n";
> > +               print $out @{$parser->{raw_lines}};
> > +               close $out;
> > +       }
> > +}
> > +
> > +if ($has_fixable && !$fix_mode) {
> > +       print "hint: run with --fix to apply the suggested replacements=
.\n";
> > +}
> > +exit $exit_code;
> > diff --git a/t/lint-style/heredoc.expect b/t/lint-style/heredoc.expect
> > new file mode 100644
> > index 0000000000..7ff6d4a52d
> > --- /dev/null
> > +++ b/t/lint-style/heredoc.expect
> > @@ -0,0 +1,3 @@
> > +lint-style/heredoc.test:8: error: replace '! test_grep' with 'test_gre=
p !': ! test_grep "after-heredoc-is-caught" actual
> > +lint-style/heredoc.test:13: error: replace '! test_grep' with 'test_gr=
ep !': ! test_grep "not-inside-sed-heredoc" actual
> > +hint: run with --fix to apply the suggested replacements.
> > diff --git a/t/lint-style/heredoc.test b/t/lint-style/heredoc.test
> > new file mode 100644
> > index 0000000000..4c05831cfb
> > --- /dev/null
> > +++ b/t/lint-style/heredoc.test
> > @@ -0,0 +1,14 @@
> > +test_expect_success 'greps inside heredocs are skipped' '
> > +       cat <<-EOF &&
> > +       grep "inside-strip-tabs" file
> > +       EOF
> > +       cat <<-\EOF &&
> > +       grep "inside-no-expand" file
> > +       EOF
> > +       ! test_grep "after-heredoc-is-caught" actual
> > +'
> > +
> > +test_expect_success 'sed with << does not start a heredoc' '
> > +       sed "s/<< foo/bar/" file &&
> > +       ! test_grep "not-inside-sed-heredoc" actual
> > +'
> > diff --git a/t/lint-style/test-grep-negation-fix.expect b/t/lint-style/=
test-grep-negation-fix.expect
> > new file mode 100644
> > index 0000000000..28ecde1073
> > --- /dev/null
> > +++ b/t/lint-style/test-grep-negation-fix.expect
> > @@ -0,0 +1,4 @@
> > +test_expect_success 'negated test_grep' '
> > +       test_grep ! "pattern" actual &&
> > +       test_grep ! -i "insensitive" actual
> > +'
> > diff --git a/t/lint-style/test-grep-negation-fix.test b/t/lint-style/te=
st-grep-negation-fix.test
> > new file mode 100644
> > index 0000000000..571c150031
> > --- /dev/null
> > +++ b/t/lint-style/test-grep-negation-fix.test
> > @@ -0,0 +1,4 @@
> > +test_expect_success 'negated test_grep' '
> > +       ! test_grep "pattern" actual &&
> > +       ! test_grep -i "insensitive" actual
> > +'
> > diff --git a/t/lint-style/test-grep-negation.expect b/t/lint-style/test=
-grep-negation.expect
> > new file mode 100644
> > index 0000000000..1fa9e124aa
> > --- /dev/null
> > +++ b/t/lint-style/test-grep-negation.expect
> > @@ -0,0 +1,3 @@
> > +lint-style/test-grep-negation.test:2: error: replace '! test_grep' wit=
h 'test_grep !': ! test_grep "pattern" actual
> > +lint-style/test-grep-negation.test:3: error: replace '! test_grep' wit=
h 'test_grep !': ! test_grep -i "insensitive" actual
> > +hint: run with --fix to apply the suggested replacements.
> > diff --git a/t/lint-style/test-grep-negation.test b/t/lint-style/test-g=
rep-negation.test
> > new file mode 100644
> > index 0000000000..571c150031
> > --- /dev/null
> > +++ b/t/lint-style/test-grep-negation.test
> > @@ -0,0 +1,4 @@
> > +test_expect_success 'negated test_grep' '
> > +       ! test_grep "pattern" actual &&
> > +       ! test_grep -i "insensitive" actual
> > +'
> > diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
> > index 8ef87addf5..e9e2f04049 100755
> > --- a/t/t0031-lockfile-pid.sh
> > +++ b/t/t0031-lockfile-pid.sh
> > @@ -29,7 +29,7 @@ test_expect_success 'PID info not shown by default' '
> >                 test_must_fail git add . 2>err &&
> >                 # Should not crash, just show normal error without PID
> >                 test_grep "Unable to create" err &&
> > -               ! test_grep "is held by process" err
> > +               test_grep ! "is held by process" err
> >         )
> >  '
> >
> > diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> > index 73445782e7..3179b4963e 100755
> > --- a/t/t5300-pack-object.sh
> > +++ b/t/t5300-pack-object.sh
> > @@ -720,7 +720,7 @@ test_expect_success '--name-hash-version=3D2 and --=
write-bitmap-index are incompat
> >
> >         # --stdout option silently removes --write-bitmap-index
> >         git pack-objects --stdout --all --name-hash-version=3D2 --write=
-bitmap-index >out 2>err &&
> > -       ! test_grep "currently, --write-bitmap-index requires --name-ha=
sh-version=3D1" err
> > +       test_grep ! "currently, --write-bitmap-index requires --name-ha=
sh-version=3D1" err
> >  '
> >
> >  test_expect_success '--path-walk pack everything' '
> > diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> > index fa0d4046f7..9154d9795f 100755
> > --- a/t/t5319-multi-pack-index.sh
> > +++ b/t/t5319-multi-pack-index.sh
> > @@ -1175,7 +1175,7 @@ test_expect_success 'load reverse index when miss=
ing .idx, .pack' '
> >
> >  test_expect_success 'usage shown without sub-command' '
> >         test_expect_code 129 git multi-pack-index 2>err &&
> > -       ! test_grep "unrecognized subcommand" err
> > +       test_grep ! "unrecognized subcommand" err
> >  '
> >
> >  test_expect_success 'complains when run outside of a repository' '
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index d7f82e1bec..9db4a76f67 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -664,7 +664,7 @@ test_geometric_repack_needed () {
> >         true)
> >                 test_grep "\[\"git\",\"repack\"," trace2.txt;;
> >         false)
> > -               ! test_grep "\[\"git\",\"repack\"," trace2.txt;;
> > +               test_grep ! "\[\"git\",\"repack\"," trace2.txt;;
> >         *)
> >                 BUG "invalid parameter: $NEEDED";;
> >         esac
> > --
> > gitgitgadget
> >
>
>
> --
> D. Ben Knoble
