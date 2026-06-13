Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF4384254
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323589; cv=none; b=EqLInws0ZEQwOMMEHBvKgd8PhDpymQcZjFGn3VJrA1jOL+SsuYQKKEoSXV9CWaONFCn2/LQvgQuyWdK2jOwbjbJXwaXiO7JaoXLyrDy12CMJhpWAzswPvt2rYDpX7zDlYuehhdSRcMk3zDIAKO0BbOYicBA9Ze4vflk/NZL/yCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323589; c=relaxed/simple;
	bh=ACH1DFr+f1a2ZR8ch2rZoQZJTolTkFoOYKzhydM9/eY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nw2IAqgFDOe8ud+qJaEh3V+Tu2XUSZzAuFaTuVb6Fr/HfabmctaUKjCASg/VTJgkQkD+yJizBcJP1jyMyk9u9iMw6+ZVXF1yMswc+McC98xT7JtIJBwN9ph+MedaHYQc4m1D24XoRrwFwkVRYxiyxquD7oggc7JfXJsCA6IHxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVkmnHgs; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVkmnHgs"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137335bc3caso2002534c88.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781323586; x=1781928386; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlVJKKNJfK2uwfIZc0bHUaZ0YbP2VMiGEB0eJ28mob4=;
        b=LVkmnHgsU0tprvKw83gh3/TDg6cQLafy+XspLZ2eiaABxc8gA9Thsl0zzAXTQ1RPPM
         5Xvf9Pmd4EIWs1XBkpZTJ8T9gcNmxDNRXYajScJx8SWXqDW5eyqH67oW8wDavXVZyLG1
         MeZONWuXxKrqbRaarRw35iP3wy3h6dCvKdJdv1oA51i5HFE/+lxVfYFTk4CW1S2kt/as
         zH+E7j8FTXla1ZJN+kPK0klL8nCOLveVI/gj4mZV/DXpU093BPYOMgvMa1kzo/+sYyyT
         /f9x1cWyOEsZtYk2Ae+B9cD/XN1+XCqVX/8Us38q5W1rGbnLtUmCCaU2YORDM1GifOXc
         LN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323586; x=1781928386;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JlVJKKNJfK2uwfIZc0bHUaZ0YbP2VMiGEB0eJ28mob4=;
        b=ha7BoA0DDKhdUtMyZ38W1PWKsy6HAtzz1fz+cttymNKpli83viFC7xQHjuxSYx2SZu
         c2qeTCPov0YuGUM/5aI6tBipijh4Ia80xfz4KOP/FRo/21KJR35b/uRwXzR7aJuiTjli
         fJspjc9iFWJS6UiJ6BPYiVpLxpxwN4p2VkVx81movp6HAYxYcoEMw76i/kKFKoSwdLxe
         zkCPlFQcDlpXPmGdDbrN1r+4yUxSxJ7pvd78P+5PSxLkE26CCBu12uKR1UQd8aBqgEd6
         +t2nZDDwSq/zYaOdqZvtGY8SmQPtWqA0mwezPYrtaxnGlgshc6P5qjG5Jqkyz0juR5OQ
         M/lA==
X-Gm-Message-State: AOJu0YwiD9UCAzD89qTsIQcACg2Bapt7w/eaK2d3/M/ocJXvxUXa5vdd
	qTrICUR/SPzEvqJX+qfwU0R24cY9N0t2zlfmqKNpu9j2Y+TL4+GCBH/LKXSRJw==
X-Gm-Gg: Acq92OEQ9p9NF+sV65MGReAws04hB3DZV5Xut9LLGB0H5JRSRnHOjYzoLl/ARlJvD5B
	4DM0lISEXkRYkHys4hOTwrAp5IMTp9swhVHYjYG0aD9s8OtScV/GHvUEMI5j1TDt+f6V+u8FNuW
	PKfjfJZzQNRmNfS5K/J1fdvq8tZmqG4J9bDm0E3uG/Nch7sl1K+S9AbuZynrvUr2xNA50I5ufOw
	qh80IK0qjxAc8zwCO6pay+wAj7BybQ2cA0BetUUZXtDaiHmD22Kg5ti5XiYlCM4k5IqTTthkVtp
	xEoSp6oaZwLI8TcSvsLkGuXIihi1WP6Nm1D553uWGL/smwL6+dctf7PWJTPsxSRukRzmgFkKoUc
	wa+zRFcMzy7X0iBD3E4eILpn86G4lx/sO9t6MwGZu5nvfmvZYeQs1TKJoyN4HDwnF/qRLq+D5lu
	HNIA9Je866ENjvDrsrDIVfSc+J
X-Received: by 2002:a05:7301:1e8a:b0:2d8:71c2:255d with SMTP id 5a478bee46e88-3081ff71b6amr3412260eec.14.1781323585406;
        Fri, 12 Jun 2026 21:06:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e489536sm6282026eec.2.2026.06.12.21.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 21:06:24 -0700 (PDT)
Message-Id: <460461b5fe8b5399c9d0b7a6dcb36ed897bc6c3e.1781323575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 04:06:12 +0000
Subject: [PATCH v2 3/6] t: extract chainlint's parser into shared module
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
index f0598e3934..cededf15ee 100755
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
-# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
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
index 0000000000..edbfee0839
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
+# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
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

