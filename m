Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B493AF668
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314131; cv=none; b=gfLH1g+AR1kjjWVWIBTAo9T6A9WnM14g01UQ2kOxfAORKaUZtggydtasIKFNJkSiNk0qaPHXy8PUGqm1ih8T4p3GFI6br1RDnNjUBZ+9WFAVEsgXus+xyIA2j3NjBHoaaFlWLw+3PjsC9dzrGF3YGdQ5Sl9vNC0U3EFe6F3Fyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314131; c=relaxed/simple;
	bh=k3v4xd1xggNiARxWFwoZhQY4liK9xxX+qE2ufUUuwAQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P9/4I580pSAaZdQGQSBbZRlMiDr52dcPY2ODUOm/GyQwS4OAjOGTNg2GaxWLKIxthNk8lK5wLyIAlqM0cf01oJNYdWntCphlurYYfBDPtqXJte0Z7vF09fSYI4SDey2tZPeUhZyRULUEd4InocLAZJC3Wmjyhbg9sCTZ+iBGB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBIN30Qc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBIN30Qc"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0cea8883so16601711cf.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783314127; x=1783918927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0zzUJ0s+DLoVRq4Ejn/unLXe2jdCo4LRzzr76xjHFQ=;
        b=UBIN30QcDmV0/WX7oMLVGmOdnJRWWX1mY5zPdHIffd/UQRG8vfmRe7rAqcbZbRc7Q7
         xp03NuZTDDqAv+YnGntG8T7IW201Y2Rej49pZXMemuLf1Vzao0EIYs4RYSxXILg3oVb2
         SlfmljaOAvzcINcoJ5sqr+EQxqC2UXXNLI3/4cLhIb6MKXy2sNKWauzGgI2kDRMiH45S
         ZJLi3Un8bLFWuprrHMKdR8LM2qcjGg9WBXkv1RVVHqQg8BGO3aSmTczim0Z3zz0VzTdy
         QwOSTDuYcSdNfYZwtsr1WddBMTMyep716XPLXOD0BSTXHpBqaUgho91ghR2uId/c6WM1
         P8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783314127; x=1783918927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0zzUJ0s+DLoVRq4Ejn/unLXe2jdCo4LRzzr76xjHFQ=;
        b=JyRTn4CSvcpUm3wywgybyY8723ES+RAqET8uR4G4plxd4xTP3UryknEang/hbfxMWz
         fLvrtpdfl1pqalgIJyzzflXFyOE45MNllbQv6VBu4rCYbVU8Sj/r1wdr73s1kh5CPPAz
         KbwuP0ZT6BrFmqO+Fq1iDolBPNMRIuwsC8Wv+ZV83wQhHYoCSOq92P7DE93L+Pu3uBYE
         Nsxj+jfoCGCHx4wmuBwA7AR42f8m9fGRPa11tGsQp2354o7T1TnSKxANrKxVcD8aA7us
         FXTR9Rva0lfMLWqg95EPCjC5Qlfd0fsg7g8BXyO0rbt6/47w3iMPKJiPV8M/SgpUJkAv
         mMSQ==
X-Gm-Message-State: AOJu0YzoOHeDi2Vw7+Gl9qbgYGilTAxl9mWF6Gd9uJSvXj7Ly/f4cbmn
	WwH+yJK4H7m1ezv9FigJrCa5tQpilLADLe0e6coWSH/Fn0J4daA2JPBxThbTZPzD
X-Gm-Gg: AfdE7cm/V9VcKTMLC+n7emp0Dee24Wwy9Ie1WauX8blPJN88lxqD0wUC9BQ6KohU2fh
	lNYnWXw8CPYjsbYMkf2wm/IcFjbftk6+g1BfliiE6bSd/D6mN5hRFrn9OfLpQl2xl2Izdw4a6kH
	KuA6P5TX9kKyXVruY1M09uRHC2HeSrYJfbGp2yyp3XTHhAAZoNOukJ5VR4eeT9jJfCre4yP/07i
	/72RHieWa5ZByrSZQlV+8LYrLb9uZmuv5JMgQeX0/wqSA3GWG65k2898oLL04f47t1UgA9aMo7n
	TaWzVEsDlSsoGYxzahDRFd0z5QxTeK+2fFA8ILB6A9qwlh5+6K/2Z1eGYk0Dzbm2kfmXE2Hi4g9
	KSMDhVO7+17nJ44HA3ujB4ErHbx1NdSSanUiNUcCy1HozSK2t2xtnHY90l0S97gpUFZFAD46YzI
	8G7EJ0/M65DvYutQ==
X-Received: by 2002:a05:622a:14d:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c3c2f82b3mr163791481cf.27.1783314126572;
        Sun, 05 Jul 2026 22:02:06 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2cf18sm88042441cf.14.2026.07.05.22.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 22:02:05 -0700 (PDT)
Message-Id: <8f3ebe6426639e1b7158ea96c30d01a3ca012811.1783314119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
References: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
	<pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 05:01:55 +0000
Subject: [PATCH v4 3/6] t: extract chainlint's parser into shared module
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
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Move chainlint.pl's Lexer, ShellParser, and ScriptParser into a
shared module (lib-shell-parser.pl) so other lint tools can reuse
the same shell parsing infrastructure.  A subsequent commit adds
greplint.pl, which needs the same tokenizer to correctly identify
command boundaries.

ScriptParser's check_test() becomes a no-op in the shared module.
chainlint.pl defines ChainlintParser (extending ScriptParser)
with the &&-chain check_test() implementation.

No functional change: chainlint produces the same output and
check-chainlint self-tests pass.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/chainlint.pl        | 529 +----------------------------------------
 t/lib-shell-parser.pl | 531 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 543 insertions(+), 517 deletions(-)
 create mode 100644 t/lib-shell-parser.pl

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 2d07a99700..cededf15ee 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -23,458 +23,9 @@ my $jobs = -1;
 my $show_stats;
 my $emit_all;
 
-# Lexer tokenizes POSIX shell scripts. It is roughly modeled after section 2.3
-# "Token Recognition" of POSIX chapter 2 "Shell Command Language". Although
-# similar to lexical analyzers for other languages, this one differs in a few
-# substantial ways due to quirks of the shell command language.
-#
-# For instance, in many languages, newline is just whitespace like space or
-# TAB, but in shell a newline is a command separator, thus a distinct lexical
-# token. A newline is significant and returned as a distinct token even at the
-# end of a shell comment.
-#
-# In other languages, `1+2` would typically be scanned as three tokens
-# (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
-# `1 + 2`, which embeds whitespace, is scanned as three token in shell, as well.
-# In shell, several characters with special meaning lose that meaning when not
-# surrounded by whitespace. For instance, the negation operator `!` is special
-# when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
-# just a plain character in the longer token "foo!uucp". In many other
-# languages, `"string"/foo:'string'` might be scanned as five tokens ("string",
-# `/`, `foo`, `:`, and 'string'), but in shell, it is just a single token.
-#
-# The lexical analyzer for the shell command language is also somewhat unusual
-# in that it recursively invokes the parser to handle the body of `$(...)`
-# expressions which can contain arbitrary shell code. Such expressions may be
-# encountered both inside and outside of double-quoted strings.
-#
-# The lexical analyzer is responsible for consuming shell here-doc bodies which
-# extend from the line following a `<<TAG` operator until a line consisting
-# solely of `TAG`. Here-doc consumption begins when a newline is encountered.
-# It is legal for multiple here-doc `<<TAG` operators to be present on a single
-# line, in which case their bodies must be present one following the next, and
-# are consumed in the (left-to-right) order the `<<TAG` operators appear on the
-# line. A special complication is that the bodies of all here-docs must be
-# consumed when the newline is encountered even if the parse context depth has
-# changed. For instance, in `cat <<A && x=$(cat <<B &&\n`, bodies of here-docs
-# "A" and "B" must be consumed even though "A" was introduced outside the
-# recursive parse context in which "B" was introduced and in which the newline
-# is encountered.
-package Lexer;
-
-sub new {
-	my ($class, $parser, $s) = @_;
-	bless {
-		parser => $parser,
-		buff => $s,
-		lineno => 1,
-		heretags => []
-	} => $class;
-}
-
-sub scan_heredoc_tag {
-	my $self = shift @_;
-	${$self->{buff}} =~ /\G(-?)/gc;
-	my $indented = $1;
-	my $token = $self->scan_token();
-	return "<<$indented" unless $token;
-	my $tag = $token->[0];
-	$tag =~ s/['"\\]//g;
-	$$token[0] = $indented ? "\t$tag" : "$tag";
-	push(@{$self->{heretags}}, $token);
-	return "<<$indented$tag";
-}
-
-sub scan_op {
-	my ($self, $c) = @_;
-	my $b = $self->{buff};
-	return $c unless $$b =~ /\G(.)/sgc;
-	my $cc = $c . $1;
-	return scan_heredoc_tag($self) if $cc eq '<<';
-	return $cc if $cc =~ /^(?:&&|\|\||>>|;;|<&|>&|<>|>\|)$/;
-	pos($$b)--;
-	return $c;
-}
-
-sub scan_sqstring {
-	my $self = shift @_;
-	${$self->{buff}} =~ /\G([^']*'|.*\z)/sgc;
-	my $s = $1;
-	$self->{lineno} += () = $s =~ /\n/sg;
-	return "'" . $s;
-}
-
-sub scan_dqstring {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	my $s = '"';
-	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
-		# handle special characters
-		last unless $$b =~ /\G(.)/sgc;
-		my $c = $1;
-		$s .= '"', last if $c eq '"';
-		$s .= '$' . $self->scan_dollar(), next if $c eq '$';
-		if ($c eq '\\') {
-			$s .= '\\', last unless $$b =~ /\G(.)/sgc;
-			$c = $1;
-			$self->{lineno}++, next if $c eq "\n"; # line splice
-			# backslash escapes only $, `, ", \ in dq-string
-			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
-			$s .= $c;
-			next;
-		}
-		die("internal error scanning dq-string '$c'\n");
-	}
-	$self->{lineno} += () = $s =~ /\n/sg;
-	return $s;
-}
-
-sub scan_balanced {
-	my ($self, $c1, $c2) = @_;
-	my $b = $self->{buff};
-	my $depth = 1;
-	my $s = $c1;
-	while ($$b =~ /\G([^\Q$c1$c2\E]*(?:[\Q$c1$c2\E]|\z))/gc) {
-		$s .= $1;
-		$depth++, next if $s =~ /\Q$c1\E$/;
-		$depth--;
-		last if $depth == 0;
-	}
-	$self->{lineno} += () = $s =~ /\n/sg;
-	return $s;
-}
-
-sub scan_subst {
-	my $self = shift @_;
-	my @tokens = $self->{parser}->parse(qr/^\)$/);
-	$self->{parser}->next_token(); # closing ")"
-	return @tokens;
-}
-
-sub scan_dollar {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	return $self->scan_balanced('(', ')') if $$b =~ /\G\((?=\()/gc; # $((...))
-	return '(' . join(' ', map {$_->[0]} $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
-	return $self->scan_balanced('{', '}') if $$b =~ /\G\{/gc; # ${...}
-	return $1 if $$b =~ /\G(\w+)/gc; # $var
-	return $1 if $$b =~ /\G([@*#?$!0-9-])/gc; # $*, $1, $$, etc.
-	return '';
-}
-
-sub swallow_heredocs {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	my $tags = $self->{heretags};
-	while (my $tag = shift @$tags) {
-		my $start = pos($$b);
-		my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
-		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
-		if (pos($$b) > $start) {
-			my $body = substr($$b, $start, pos($$b) - $start);
-			$self->{parser}->{heredocs}->{$$tag[0]} = {
-				content => substr($body, 0, length($body) - length($&)),
-				start_line => $self->{lineno},
-		        };
-			$self->{lineno} += () = $body =~ /\n/sg;
-			next;
-		}
-		push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
-		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
-		my $body = substr($$b, $start, pos($$b) - $start);
-		$self->{lineno} += () = $body =~ /\n/sg;
-		last;
-	}
-}
-
-sub scan_token {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	my $token = '';
-	my ($start, $startln);
-RESTART:
-	$startln = $self->{lineno};
-	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
-	$start = pos($$b) || 0;
-	$self->{lineno}++, return ["\n", $start, pos($$b), $startln, $startln] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
-	while (1) {
-		# slurp up non-special characters
-		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
-		# handle special characters
-		last unless $$b =~ /\G(.)/sgc;
-		my $c = $1;
-		pos($$b)--, last if $c =~ /^[ \t]$/; # whitespace ends token
-		pos($$b)--, last if length($token) && $c =~ /^[;&|<>(){}\n]$/;
-		$token .= $self->scan_sqstring(), next if $c eq "'";
-		$token .= $self->scan_dqstring(), next if $c eq '"';
-		$token .= $c . $self->scan_dollar(), next if $c eq '$';
-		$self->{lineno}++, $self->swallow_heredocs(), $token = $c, last if $c eq "\n";
-		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
-		$token = $c, last if $c =~ /^[(){}]$/;
-		if ($c eq '\\') {
-			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
-			$c = $1;
-			$self->{lineno}++, next if $c eq "\n" && length($token); # line splice
-			$self->{lineno}++, goto RESTART if $c eq "\n"; # line splice
-			$token .= '\\' . $c;
-			next;
-		}
-		die("internal error scanning character '$c'\n");
-	}
-	return length($token) ? [$token, $start, pos($$b), $startln, $self->{lineno}] : undef;
-}
-
-# ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
-# is a recursive descent parser very roughly modeled after section 2.10 "Shell
-# Grammar" of POSIX chapter 2 "Shell Command Language".
-package ShellParser;
-
-sub new {
-	my ($class, $s) = @_;
-	my $self = bless {
-		buff => [],
-		stop => [],
-		output => [],
-		heredocs => {},
-		insubshell => 0,
-	} => $class;
-	$self->{lexer} = Lexer->new($self, $s);
-	return $self;
-}
-
-sub next_token {
-	my $self = shift @_;
-	return pop(@{$self->{buff}}) if @{$self->{buff}};
-	return $self->{lexer}->scan_token();
-}
-
-sub untoken {
-	my $self = shift @_;
-	push(@{$self->{buff}}, @_);
-}
-
-sub peek {
-	my $self = shift @_;
-	my $token = $self->next_token();
-	return undef unless defined($token);
-	$self->untoken($token);
-	return $token;
-}
-
-sub stop_at {
-	my ($self, $token) = @_;
-	return 1 unless defined($token);
-	my $stop = ${$self->{stop}}[-1] if @{$self->{stop}};
-	return defined($stop) && $token->[0] =~ $stop;
-}
-
-sub expect {
-	my ($self, $expect) = @_;
-	my $token = $self->next_token();
-	return $token if defined($token) && $token->[0] eq $expect;
-	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token->[0] : "<end-of-input>") . "'\n");
-	$self->untoken($token) if defined($token);
-	return ();
-}
-
-sub optional_newlines {
-	my $self = shift @_;
-	my @tokens;
-	while (my $token = $self->peek()) {
-		last unless $token->[0] eq "\n";
-		push(@tokens, $self->next_token());
-	}
-	return @tokens;
-}
-
-sub parse_group {
-	my $self = shift @_;
-	return ($self->parse(qr/^}$/),
-		$self->expect('}'));
-}
-
-sub parse_subshell {
-	my $self = shift @_;
-	$self->{insubshell}++;
-	my @tokens = ($self->parse(qr/^\)$/),
-		      $self->expect(')'));
-	$self->{insubshell}--;
-	return @tokens;
-}
-
-sub parse_case_pattern {
-	my $self = shift @_;
-	my @tokens;
-	while (defined(my $token = $self->next_token())) {
-		push(@tokens, $token);
-		last if $token->[0] eq ')';
-	}
-	return @tokens;
-}
-
-sub parse_case {
-	my $self = shift @_;
-	my @tokens;
-	push(@tokens,
-	     $self->next_token(), # subject
-	     $self->optional_newlines(),
-	     $self->expect('in'),
-	     $self->optional_newlines());
-	while (1) {
-		my $token = $self->peek();
-		last unless defined($token) && $token->[0] ne 'esac';
-		push(@tokens,
-		     $self->parse_case_pattern(),
-		     $self->optional_newlines(),
-		     $self->parse(qr/^(?:;;|esac)$/)); # item body
-		$token = $self->peek();
-		last unless defined($token) && $token->[0] ne 'esac';
-		push(@tokens,
-		     $self->expect(';;'),
-		     $self->optional_newlines());
-	}
-	push(@tokens, $self->expect('esac'));
-	return @tokens;
-}
-
-sub parse_for {
-	my $self = shift @_;
-	my @tokens;
-	push(@tokens,
-	     $self->next_token(), # variable
-	     $self->optional_newlines());
-	my $token = $self->peek();
-	if (defined($token) && $token->[0] eq 'in') {
-		push(@tokens,
-		     $self->expect('in'),
-		     $self->optional_newlines());
-	}
-	push(@tokens,
-	     $self->parse(qr/^do$/), # items
-	     $self->expect('do'),
-	     $self->optional_newlines(),
-	     $self->parse_loop_body(),
-	     $self->expect('done'));
-	return @tokens;
-}
-
-sub parse_if {
-	my $self = shift @_;
-	my @tokens;
-	while (1) {
-		push(@tokens,
-		     $self->parse(qr/^then$/), # if/elif condition
-		     $self->expect('then'),
-		     $self->optional_newlines(),
-		     $self->parse(qr/^(?:elif|else|fi)$/)); # if/elif body
-		my $token = $self->peek();
-		last unless defined($token) && $token->[0] eq 'elif';
-		push(@tokens, $self->expect('elif'));
-	}
-	my $token = $self->peek();
-	if (defined($token) && $token->[0] eq 'else') {
-		push(@tokens,
-		     $self->expect('else'),
-		     $self->optional_newlines(),
-		     $self->parse(qr/^fi$/)); # else body
-	}
-	push(@tokens, $self->expect('fi'));
-	return @tokens;
-}
-
-sub parse_loop_body {
-	my $self = shift @_;
-	return $self->parse(qr/^done$/);
-}
-
-sub parse_loop {
-	my $self = shift @_;
-	return ($self->parse(qr/^do$/), # condition
-		$self->expect('do'),
-		$self->optional_newlines(),
-		$self->parse_loop_body(),
-		$self->expect('done'));
-}
-
-sub parse_func {
-	my $self = shift @_;
-	return ($self->expect('('),
-		$self->expect(')'),
-		$self->optional_newlines(),
-		$self->parse_cmd()); # body
-}
-
-sub parse_bash_array_assignment {
-	my $self = shift @_;
-	my @tokens = $self->expect('(');
-	while (defined(my $token = $self->next_token())) {
-		push(@tokens, $token);
-		last if $token->[0] eq ')';
-	}
-	return @tokens;
-}
-
-my %compound = (
-	'{' => \&parse_group,
-	'(' => \&parse_subshell,
-	'case' => \&parse_case,
-	'for' => \&parse_for,
-	'if' => \&parse_if,
-	'until' => \&parse_loop,
-	'while' => \&parse_loop);
-
-sub parse_cmd {
-	my $self = shift @_;
-	my $cmd = $self->next_token();
-	return () unless defined($cmd);
-	return $cmd if $cmd->[0] eq "\n";
-
-	my $token;
-	my @tokens = $cmd;
-	if ($cmd->[0] eq '!') {
-		push(@tokens, $self->parse_cmd());
-		return @tokens;
-	} elsif (my $f = $compound{$cmd->[0]}) {
-		push(@tokens, $self->$f());
-	} elsif (defined($token = $self->peek()) && $token->[0] eq '(') {
-		if ($cmd->[0] !~ /\w=$/) {
-			push(@tokens, $self->parse_func());
-			return @tokens;
-		}
-		my @array = $self->parse_bash_array_assignment();
-		$tokens[-1]->[0] .= join(' ', map {$_->[0]} @array);
-		$tokens[-1]->[2] = $array[$#array][2] if @array;
-	}
-
-	while (defined(my $token = $self->next_token())) {
-		$self->untoken($token), last if $self->stop_at($token);
-		push(@tokens, $token);
-		last if $token->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
-	}
-	push(@tokens, $self->next_token()) if $tokens[-1]->[0] ne "\n" && defined($token = $self->peek()) && $token->[0] eq "\n";
-	return @tokens;
-}
-
-sub accumulate {
-	my ($self, $tokens, $cmd) = @_;
-	push(@$tokens, @$cmd);
-}
-
-sub parse {
-	my ($self, $stop) = @_;
-	push(@{$self->{stop}}, $stop);
-	goto DONE if $self->stop_at($self->peek());
-	my @tokens;
-	while (my @cmd = $self->parse_cmd()) {
-		$self->accumulate(\@tokens, \@cmd);
-		last if $self->stop_at($self->peek());
-	}
-DONE:
-	pop(@{$self->{stop}});
-	return @tokens;
-}
+use File::Basename;
+do(dirname($0) . "/lib-shell-parser.pl")
+	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
 
 # TestParser is a subclass of ShellParser which, beyond parsing shell script
 # code, is also imbued with semantic knowledge of test construction, and checks
@@ -482,9 +33,10 @@ DONE:
 # the tests themselves or in behaviors being exercised by the tests. As such,
 # TestParser is only called upon to parse test bodies, not the top-level
 # scripts in which the tests are defined.
+
 package TestParser;
 
-use base 'ShellParser';
+our @ISA = ('ShellParser');
 
 sub new {
 	my $class = shift @_;
@@ -578,51 +130,10 @@ DONE:
 	$self->SUPER::accumulate($tokens, $cmd);
 }
 
-# ScriptParser is a subclass of ShellParser which identifies individual test
-# definitions within test scripts, and passes each test body through TestParser
-# to identify possible problems. ShellParser detects test definitions not only
-# at the top-level of test scripts but also within compound commands such as
-# loops and function definitions.
-package ScriptParser;
-
-use base 'ShellParser';
-
-sub new {
-	my $class = shift @_;
-	my $self = $class->SUPER::new(@_);
-	$self->{ntests} = 0;
-	$self->{nerrs} = 0;
-	return $self;
-}
+# ChainlintParser extends ScriptParser with &&-chain checking
+package ChainlintParser;
 
-# extract the raw content of a token, which may be a single string or a
-# composition of multiple strings and non-string character runs; for instance,
-# `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
-sub unwrap {
-	my $token = (@_ ? shift @_ : $_)->[0];
-	# simple case: 'sqstring' or "dqstring"
-	return $token if $token =~ s/^'([^']*)'$/$1/;
-	return $token if $token =~ s/^"([^"]*)"$/$1/;
-
-	# composite case
-	my ($s, $q, $escaped);
-	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $token =~ /\G([^\\'"]*)/gc;
-		# handle special characters
-		last unless $token =~ /\G(.)/sgc;
-		my $c = $1;
-		$q = undef, next if defined($q) && $c eq $q;
-		$q = $c, next if !defined($q) && $c =~ /^['"]$/;
-		if ($c eq '\\') {
-			last unless $token =~ /\G(.)/sgc;
-			$c = $1;
-			$s .= '\\' if $c eq "\n"; # preserve line splice
-		}
-		$s .= $c;
-	}
-	return $s
-}
+our @ISA = ('ScriptParser');
 
 sub format_problem {
 	local $_ = shift;
@@ -635,10 +146,10 @@ sub format_problem {
 
 sub check_test {
 	my $self = shift @_;
-	my $title = unwrap(shift @_);
+	my $title = ScriptParser::unwrap(shift @_);
 	my $body = shift @_;
 	my $lineno = $body->[3];
-	$body = unwrap($body);
+	$body = ScriptParser::unwrap($body);
 	if ($body eq '-') {
 		my $herebody = shift @_;
 		$body = $herebody->{content};
@@ -673,24 +184,8 @@ sub check_test {
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
 }
 
-sub parse_cmd {
-	my $self = shift @_;
-	my @tokens = $self->SUPER::parse_cmd();
-	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
-	my $n = $#tokens;
-	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
-	my $herebody;
-	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
-		$herebody = $self->{heredocs}->{$1};
-		$n--;
-	}
-	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
-	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
-	return @tokens;
-}
-
 # main contains high-level functionality for processing command-line switches,
-# feeding input test scripts to ScriptParser, and reporting results.
+# feeding input test scripts to ChainlintParser, and reporting results.
 package main;
 
 my $getnow = sub { return time(); };
@@ -803,7 +298,7 @@ sub check_script {
 		}
 		my $s = do { local $/; <$fh> };
 		close($fh);
-		my $parser = ScriptParser->new(\$s);
+		my $parser = ChainlintParser->new(\$s);
 		1 while $parser->parse_cmd();
 		if (@{$parser->{output}}) {
 			my $c = fd_colors(1);
diff --git a/t/lib-shell-parser.pl b/t/lib-shell-parser.pl
new file mode 100644
index 0000000000..5c435c5d05
--- /dev/null
+++ b/t/lib-shell-parser.pl
@@ -0,0 +1,531 @@
+# Copyright (c) 2021-2022 Eric Sunshine <sunshine@sunshineco.com>
+#
+# Shared shell script parser for test lint tools. Provides Lexer,
+# ShellParser, and ScriptParser. Subclass ScriptParser and override
+# check_test() to implement lint checks.
+
+use strict;
+use warnings;
+
+# Lexer tokenizes POSIX shell scripts. It is roughly modeled after section 2.3
+# "Token Recognition" of POSIX chapter 2 "Shell Command Language". Although
+# similar to lexical analyzers for other languages, this one differs in a few
+# substantial ways due to quirks of the shell command language.
+#
+# For instance, in many languages, newline is just whitespace like space or
+# TAB, but in shell a newline is a command separator, thus a distinct lexical
+# token. A newline is significant and returned as a distinct token even at the
+# end of a shell comment.
+#
+# In other languages, `1+2` would typically be scanned as three tokens
+# (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
+# `1 + 2`, which embeds whitespace, is scanned as three token in shell, as well.
+# In shell, several characters with special meaning lose that meaning when not
+# surrounded by whitespace. For instance, the negation operator `!` is special
+# when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
+# just a plain character in the longer token "foo!uucp". In many other
+# languages, `"string"/foo:'string'` might be scanned as five tokens ("string",
+# `/`, `foo`, `:`, and 'string'), but in shell, it is just a single token.
+#
+# The lexical analyzer for the shell command language is also somewhat unusual
+# in that it recursively invokes the parser to handle the body of `$(...)`
+# expressions which can contain arbitrary shell code. Such expressions may be
+# encountered both inside and outside of double-quoted strings.
+#
+# The lexical analyzer is responsible for consuming shell here-doc bodies which
+# extend from the line following a `<<TAG` operator until a line consisting
+# solely of `TAG`. Here-doc consumption begins when a newline is encountered.
+# It is legal for multiple here-doc `<<TAG` operators to be present on a single
+# line, in which case their bodies must be present one following the next, and
+# are consumed in the (left-to-right) order the `<<TAG` operators appear on the
+# line. A special complication is that the bodies of all here-docs must be
+# consumed when the newline is encountered even if the parse context depth has
+# changed. For instance, in `cat <<A && x=$(cat <<B &&\n`, bodies of here-docs
+# "A" and "B" must be consumed even though "A" was introduced outside the
+# recursive parse context in which "B" was introduced and in which the newline
+# is encountered.
+package Lexer;
+
+sub new {
+	my ($class, $parser, $s) = @_;
+	bless {
+		parser => $parser,
+		buff => $s,
+		lineno => 1,
+		heretags => []
+	} => $class;
+}
+
+sub scan_heredoc_tag {
+	my $self = shift @_;
+	${$self->{buff}} =~ /\G(-?)/gc;
+	my $indented = $1;
+	my $token = $self->scan_token();
+	return "<<$indented" unless $token;
+	my $tag = $token->[0];
+	$tag =~ s/['"\\]//g;
+	$$token[0] = $indented ? "\t$tag" : "$tag";
+	push(@{$self->{heretags}}, $token);
+	return "<<$indented$tag";
+}
+
+sub scan_op {
+	my ($self, $c) = @_;
+	my $b = $self->{buff};
+	return $c unless $$b =~ /\G(.)/sgc;
+	my $cc = $c . $1;
+	return scan_heredoc_tag($self) if $cc eq '<<';
+	return $cc if $cc =~ /^(?:&&|\|\||>>|;;|<&|>&|<>|>\|)$/;
+	pos($$b)--;
+	return $c;
+}
+
+sub scan_sqstring {
+	my $self = shift @_;
+	${$self->{buff}} =~ /\G([^']*'|.*\z)/sgc;
+	my $s = $1;
+	$self->{lineno} += () = $s =~ /\n/sg;
+	return "'" . $s;
+}
+
+sub scan_dqstring {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $s = '"';
+	while (1) {
+		# slurp up non-special characters
+		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
+		# handle special characters
+		last unless $$b =~ /\G(.)/sgc;
+		my $c = $1;
+		$s .= '"', last if $c eq '"';
+		$s .= '$' . $self->scan_dollar(), next if $c eq '$';
+		if ($c eq '\\') {
+			$s .= '\\', last unless $$b =~ /\G(.)/sgc;
+			$c = $1;
+			$self->{lineno}++, next if $c eq "\n"; # line splice
+			# backslash escapes only $, `, ", \ in dq-string
+			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
+			$s .= $c;
+			next;
+		}
+		die("internal error scanning dq-string '$c'\n");
+	}
+	$self->{lineno} += () = $s =~ /\n/sg;
+	return $s;
+}
+
+sub scan_balanced {
+	my ($self, $c1, $c2) = @_;
+	my $b = $self->{buff};
+	my $depth = 1;
+	my $s = $c1;
+	while ($$b =~ /\G([^\Q$c1$c2\E]*(?:[\Q$c1$c2\E]|\z))/gc) {
+		$s .= $1;
+		$depth++, next if $s =~ /\Q$c1\E$/;
+		$depth--;
+		last if $depth == 0;
+	}
+	$self->{lineno} += () = $s =~ /\n/sg;
+	return $s;
+}
+
+sub scan_subst {
+	my $self = shift @_;
+	my @tokens = $self->{parser}->parse(qr/^\)$/);
+	$self->{parser}->next_token(); # closing ")"
+	return @tokens;
+}
+
+sub scan_dollar {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	return $self->scan_balanced('(', ')') if $$b =~ /\G\((?=\()/gc; # $((...))
+	return '(' . join(' ', map {$_->[0]} $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
+	return $self->scan_balanced('{', '}') if $$b =~ /\G\{/gc; # ${...}
+	return $1 if $$b =~ /\G(\w+)/gc; # $var
+	return $1 if $$b =~ /\G([@*#?$!0-9-])/gc; # $*, $1, $$, etc.
+	return '';
+}
+
+sub swallow_heredocs {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $tags = $self->{heretags};
+	while (my $tag = shift @$tags) {
+		my $start = pos($$b);
+		my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
+		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
+		if (pos($$b) > $start) {
+			my $body = substr($$b, $start, pos($$b) - $start);
+			$self->{parser}->{heredocs}->{$$tag[0]} = {
+				content => substr($body, 0, length($body) - length($&)),
+				start_line => $self->{lineno},
+		        };
+			$self->{lineno} += () = $body =~ /\n/sg;
+			next;
+		}
+		push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
+		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
+		my $body = substr($$b, $start, pos($$b) - $start);
+		$self->{lineno} += () = $body =~ /\n/sg;
+		last;
+	}
+}
+
+sub scan_token {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $token = '';
+	my ($start, $startln);
+RESTART:
+	$startln = $self->{lineno};
+	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
+	$start = pos($$b) || 0;
+	$self->{lineno}++, return ["\n", $start, pos($$b), $startln, $startln] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
+	while (1) {
+		# slurp up non-special characters
+		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
+		# handle special characters
+		last unless $$b =~ /\G(.)/sgc;
+		my $c = $1;
+		pos($$b)--, last if $c =~ /^[ \t]$/; # whitespace ends token
+		pos($$b)--, last if length($token) && $c =~ /^[;&|<>(){}\n]$/;
+		$token .= $self->scan_sqstring(), next if $c eq "'";
+		$token .= $self->scan_dqstring(), next if $c eq '"';
+		$token .= $c . $self->scan_dollar(), next if $c eq '$';
+		$self->{lineno}++, $self->swallow_heredocs(), $token = $c, last if $c eq "\n";
+		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
+		$token = $c, last if $c =~ /^[(){}]$/;
+		if ($c eq '\\') {
+			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
+			$c = $1;
+			$self->{lineno}++, next if $c eq "\n" && length($token); # line splice
+			$self->{lineno}++, goto RESTART if $c eq "\n"; # line splice
+			$token .= '\\' . $c;
+			next;
+		}
+		die("internal error scanning character '$c'\n");
+	}
+	return length($token) ? [$token, $start, pos($$b), $startln, $self->{lineno}] : undef;
+}
+
+# ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
+# is a recursive descent parser very roughly modeled after section 2.10 "Shell
+# Grammar" of POSIX chapter 2 "Shell Command Language".
+
+package ShellParser;
+
+sub new {
+	my ($class, $s) = @_;
+	my $self = bless {
+		buff => [],
+		stop => [],
+		output => [],
+		heredocs => {},
+		insubshell => 0,
+	} => $class;
+	$self->{lexer} = Lexer->new($self, $s);
+	return $self;
+}
+
+sub next_token {
+	my $self = shift @_;
+	return pop(@{$self->{buff}}) if @{$self->{buff}};
+	return $self->{lexer}->scan_token();
+}
+
+sub untoken {
+	my $self = shift @_;
+	push(@{$self->{buff}}, @_);
+}
+
+sub peek {
+	my $self = shift @_;
+	my $token = $self->next_token();
+	return undef unless defined($token);
+	$self->untoken($token);
+	return $token;
+}
+
+sub stop_at {
+	my ($self, $token) = @_;
+	return 1 unless defined($token);
+	my $stop = ${$self->{stop}}[-1] if @{$self->{stop}};
+	return defined($stop) && $token->[0] =~ $stop;
+}
+
+sub expect {
+	my ($self, $expect) = @_;
+	my $token = $self->next_token();
+	return $token if defined($token) && $token->[0] eq $expect;
+	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token->[0] : "<end-of-input>") . "'\n");
+	$self->untoken($token) if defined($token);
+	return ();
+}
+
+sub optional_newlines {
+	my $self = shift @_;
+	my @tokens;
+	while (my $token = $self->peek()) {
+		last unless $token->[0] eq "\n";
+		push(@tokens, $self->next_token());
+	}
+	return @tokens;
+}
+
+sub parse_group {
+	my $self = shift @_;
+	return ($self->parse(qr/^}$/),
+		$self->expect('}'));
+}
+
+sub parse_subshell {
+	my $self = shift @_;
+	$self->{insubshell}++;
+	my @tokens = ($self->parse(qr/^\)$/),
+		      $self->expect(')'));
+	$self->{insubshell}--;
+	return @tokens;
+}
+
+sub parse_case_pattern {
+	my $self = shift @_;
+	my @tokens;
+	while (defined(my $token = $self->next_token())) {
+		push(@tokens, $token);
+		last if $token->[0] eq ')';
+	}
+	return @tokens;
+}
+
+sub parse_case {
+	my $self = shift @_;
+	my @tokens;
+	push(@tokens,
+	     $self->next_token(), # subject
+	     $self->optional_newlines(),
+	     $self->expect('in'),
+	     $self->optional_newlines());
+	while (1) {
+		my $token = $self->peek();
+		last unless defined($token) && $token->[0] ne 'esac';
+		push(@tokens,
+		     $self->parse_case_pattern(),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^(?:;;|esac)$/)); # item body
+		$token = $self->peek();
+		last unless defined($token) && $token->[0] ne 'esac';
+		push(@tokens,
+		     $self->expect(';;'),
+		     $self->optional_newlines());
+	}
+	push(@tokens, $self->expect('esac'));
+	return @tokens;
+}
+
+sub parse_for {
+	my $self = shift @_;
+	my @tokens;
+	push(@tokens,
+	     $self->next_token(), # variable
+	     $self->optional_newlines());
+	my $token = $self->peek();
+	if (defined($token) && $token->[0] eq 'in') {
+		push(@tokens,
+		     $self->expect('in'),
+		     $self->optional_newlines());
+	}
+	push(@tokens,
+	     $self->parse(qr/^do$/), # items
+	     $self->expect('do'),
+	     $self->optional_newlines(),
+	     $self->parse_loop_body(),
+	     $self->expect('done'));
+	return @tokens;
+}
+
+sub parse_if {
+	my $self = shift @_;
+	my @tokens;
+	while (1) {
+		push(@tokens,
+		     $self->parse(qr/^then$/), # if/elif condition
+		     $self->expect('then'),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^(?:elif|else|fi)$/)); # if/elif body
+		my $token = $self->peek();
+		last unless defined($token) && $token->[0] eq 'elif';
+		push(@tokens, $self->expect('elif'));
+	}
+	my $token = $self->peek();
+	if (defined($token) && $token->[0] eq 'else') {
+		push(@tokens,
+		     $self->expect('else'),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^fi$/)); # else body
+	}
+	push(@tokens, $self->expect('fi'));
+	return @tokens;
+}
+
+sub parse_loop_body {
+	my $self = shift @_;
+	return $self->parse(qr/^done$/);
+}
+
+sub parse_loop {
+	my $self = shift @_;
+	return ($self->parse(qr/^do$/), # condition
+		$self->expect('do'),
+		$self->optional_newlines(),
+		$self->parse_loop_body(),
+		$self->expect('done'));
+}
+
+sub parse_func {
+	my $self = shift @_;
+	return ($self->expect('('),
+		$self->expect(')'),
+		$self->optional_newlines(),
+		$self->parse_cmd()); # body
+}
+
+sub parse_bash_array_assignment {
+	my $self = shift @_;
+	my @tokens = $self->expect('(');
+	while (defined(my $token = $self->next_token())) {
+		push(@tokens, $token);
+		last if $token->[0] eq ')';
+	}
+	return @tokens;
+}
+
+my %compound = (
+	'{' => \&parse_group,
+	'(' => \&parse_subshell,
+	'case' => \&parse_case,
+	'for' => \&parse_for,
+	'if' => \&parse_if,
+	'until' => \&parse_loop,
+	'while' => \&parse_loop);
+
+sub parse_cmd {
+	my $self = shift @_;
+	my $cmd = $self->next_token();
+	return () unless defined($cmd);
+	return $cmd if $cmd->[0] eq "\n";
+
+	my $token;
+	my @tokens = $cmd;
+	if ($cmd->[0] eq '!') {
+		push(@tokens, $self->parse_cmd());
+		return @tokens;
+	} elsif (my $f = $compound{$cmd->[0]}) {
+		push(@tokens, $self->$f());
+	} elsif (defined($token = $self->peek()) && $token->[0] eq '(') {
+		if ($cmd->[0] !~ /\w=$/) {
+			push(@tokens, $self->parse_func());
+			return @tokens;
+		}
+		my @array = $self->parse_bash_array_assignment();
+		$tokens[-1]->[0] .= join(' ', map {$_->[0]} @array);
+		$tokens[-1]->[2] = $array[$#array][2] if @array;
+	}
+
+	while (defined(my $token = $self->next_token())) {
+		$self->untoken($token), last if $self->stop_at($token);
+		push(@tokens, $token);
+		last if $token->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	}
+	push(@tokens, $self->next_token()) if $tokens[-1]->[0] ne "\n" && defined($token = $self->peek()) && $token->[0] eq "\n";
+	return @tokens;
+}
+
+sub accumulate {
+	my ($self, $tokens, $cmd) = @_;
+	push(@$tokens, @$cmd);
+}
+
+sub parse {
+	my ($self, $stop) = @_;
+	push(@{$self->{stop}}, $stop);
+	goto DONE if $self->stop_at($self->peek());
+	my @tokens;
+	while (my @cmd = $self->parse_cmd()) {
+		$self->accumulate(\@tokens, \@cmd);
+		last if $self->stop_at($self->peek());
+	}
+DONE:
+	pop(@{$self->{stop}});
+	return @tokens;
+}
+
+# ScriptParser is a subclass of ShellParser which identifies individual test
+# definitions within test scripts and passes each test body to check_test().
+# ScriptParser detects test definitions not only at the top-level of test
+# scripts but also within compound commands such as loops and function
+# definitions.
+
+package ScriptParser;
+
+our @ISA = ('ShellParser');
+
+sub new {
+	my $class = shift @_;
+	my $self = $class->SUPER::new(@_);
+	$self->{ntests} = 0;
+	$self->{nerrs} = 0;
+	return $self;
+}
+
+# extract the raw content of a token, which may be a single string or a
+# composition of multiple strings and non-string character runs; for instance,
+# `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
+sub unwrap {
+	my $token = (@_ ? shift @_ : $_)->[0];
+	# simple case: 'sqstring' or "dqstring"
+	return $token if $token =~ s/^'([^']*)'$/$1/;
+	return $token if $token =~ s/^"([^"]*)"$/$1/;
+
+	# composite case
+	my ($s, $q, $escaped);
+	while (1) {
+		# slurp up non-special characters
+		$s .= $1 if $token =~ /\G([^\\'"]*)/gc;
+		# handle special characters
+		last unless $token =~ /\G(.)/sgc;
+		my $c = $1;
+		$q = undef, next if defined($q) && $c eq $q;
+		$q = $c, next if !defined($q) && $c =~ /^['"]$/;
+		if ($c eq '\\') {
+			last unless $token =~ /\G(.)/sgc;
+			$c = $1;
+			$s .= '\\' if $c eq "\n"; # preserve line splice
+		}
+		$s .= $c;
+	}
+	return $s
+}
+
+sub check_test {
+	# no-op; subclass and override to implement lint checks
+}
+
+sub parse_cmd {
+	my $self = shift @_;
+	my @tokens = $self->SUPER::parse_cmd();
+	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
+	my $n = $#tokens;
+	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	my $herebody;
+	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
+		$herebody = $self->{heredocs}->{$1};
+		$n--;
+	}
+	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
+	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
+	return @tokens;
+}
+
+1;
-- 
gitgitgadget

