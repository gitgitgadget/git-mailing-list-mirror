Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910156;
	b=vFP1H5XZG7u7UCNwv7q8bW4J2fwxXN5t8cU2qo5jm4jxm/XMtPMJsH3O9v9pZO/dywPE
	 1TpW3vy7UuZw1Rf48WTyW7ZSvpWsxi6Y6GwXDeDUHCmi74Ot69MuokJvNxmfAP9XNs3Xo
	 uZACVw1n21CKVs+AalScj5fHQGP2IjCIE7CqdJQsC8TVsr1kwWZvy4Kf51q2abykd0oEx
	 CIrDU4WaXOsjl4sfplk5cR0sI8W4I6UhUed4Gck2YXbTE/zO34WtOR2ATO2oOCbhcY7C9
	 +O/+lsdS0pMJq2fmCoSLhMNoJpgQKfkkSrqpdR2eFxg9DMLkAI5K7OmHvUpmo2WGB5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xxpC98PiDzqqZL/N8bH/cQBmnKC+1H8kft4JaUIFLuE=;
	b=pweKV7BSMMJmS9Bbvd2D6wtmjOir6jtQr0yQ4qaRKmWi+UtLm+TP8qNcQyjZ1QjjegMH
	 U51kB2vjAbksviU5PyTaH43gkzQSGGfHyF5PJVQAnGkGMBgCrTl0O0LqUQJDB9cBDj58m
	 0j/FRk8UL7NapOOXA0XI43RiWUhSDHstmkoT/H1dWIlDtyDs9h3zzA0Gp36WPSiEfiSvT
	 AJrN2rSYAyIvrsJqsfs0zO9C5LQiowwGxpqh2t2Iz/1YUbpkzPbN9lU0RM1JsGAcqvavL
	 H4zQaVsTCkJWj9oYR7Heqgnfw15ElXfymMn3vq5FTZrS5zO3YqsqN197/Gs1pTmadNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=L7d0dJRa;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C6606A31D
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 06:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 076C6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=L7d0dJRa
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af173320f9so1238818b6e.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792910155; x=1793514955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xxpC98PiDzqqZL/N8bH/cQBmnKC+1H8kft4JaUIFLuE=;
        b=L7d0dJRakl0Kx/NEoHkIYKfoLc+UYpyqVkkqJg2Nb9Yur0kEzVggsbDkxQUrALIt/3
         1gI+YadDS6cUgj5pBkxMU+Pz8GvrxuvOnWm1VO9WSt2tUVPAjpjLMIZsTcKgmXPJNMAT
         4mDyJ6jeQbhvsm25MDK+Pey3e6XeBlansMKhqSEb2+qqLwcqy8uT1n60jzCaIyBSvv3+
         aCiix0K/Jhn6K5tYhG2hre5kDM5iAnNJIR8LqTI6dSXAqUVYXg4XLWi3cC/I1oNiMFVU
         DohT6cgpH2/Kfz0B3av/8uT/+0HrLcpLwVnkjCcDq6VSSsBSnNECa5lro+YsIXRbkorQ
         ZRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910155; x=1793514955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xxpC98PiDzqqZL/N8bH/cQBmnKC+1H8kft4JaUIFLuE=;
        b=FKt4CC60i+j2k0ECBu6uTVAwDtyH9aYewSFuaZ/dRo/bPL9UGpGXOM/lQi7wP3VIZw
         OhkVTPWyYVwBUJlXdxexP0CkeO4j21pY8edJiBDoi/jKOoxwrJ5qqM2EO8SXAb6WlKVr
         rBXP8KszqOAEMMohnZxiggb3VBHfEbUhXwuvz9fhhenitG9uHDH+giZT3fhAIw3rzRSG
         CRFq2kE45HUrrkvN7KobzLiBdvjFfGHBKQN9XZ5sRyIQ8cOapIyrL9fzWmQNGnDBd4jv
         SrSd2/ke6UG17oS3eHig3PlUcRBDRSLu3eQ1NR6Bwscs/iibYP479V/RHORFbpMRGcSh
         m7aw==
X-Gm-Message-State: AFq9FYKnXjgnzn44Tdr7fcc7FovA/ZVa+fBJI9jPKSzzKjbOvJK6h+dC
	05eH9qfNgMeG8bXlxHG99KdEAoOn0jZj6XdaG0CtL3Yqe+/IEu14a4431LB1qLrVPICudzn1/C1
	hubi8
X-Gm-Gg: AYBFou0gGuQOJzyc1mdPfWGTQXEbi1CP4Ke07uHxSowuF2gSFYZB/8yb+6FcCHy5GBr
	tDrR+n5OD+aIo6/uG/x+5vUF7YOF4BE1fXl2oulYjz265xn6mH9a8NSY0INL8BczXTg9c69qp1V
	XFJXh1wLxSjK63xdWsLmTnASWVPKN+EcCiFf6WKNALhoLktI33JxOLxOI87aED8x9h/PVNh/TEC
	34q4Hwpu2V0deoZ2XJkVacO71iFUfWomAGbmkAPkHM9OzHEoljIQg2EJK2bTL14XSsXjclLmBzh
	8fcezsFmplze5OnPoSzrfFj3tlrOlV7XmLExbaWgzQuPMlSXb/RVxuYBAgqBtnXVBxRLQvCJBQw
	/V4gJ2OvYo3gENy6kI3PJkyb5L4dn9cwlUoV9+bfk8KWqfKfjsHkPzRpf9kvNqb2nr+VeTfSIUZ
	fUH2/md+WVUAypuLoXVsKnWhOAu+5kq2LygNhkVF5Ap6zpzHcPPigNU+WFQcFliKmUmBjOh9Cxg
	OghD2Sx3BFwAsovRnxc/HKBm0jU93R4TttNTMdgYuQ4ress+9PVub6/0A==
X-Received: by 2002:a05:6808:470c:b0:4d5:27da:a494 with SMTP id 5614622812f47-55c00347d28mr2415069b6e.46.1792910154763;
        Sat, 24 Oct 2026 23:35:54 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-55c03dc3524sm2652745b6e.0.2026.10.24.23.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 23:35:54 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/4] t/greplint: move parsing and token check to library
Date: Sun, 25 Oct 2026 00:35:07 -0600
Message-ID: <20261025063508.3026136-4-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025063508.3026136-1-tyler@tylercipriani.com>
References: <xmqqjynueq81.fsf@gitster.g>
 <20261025063508.3026136-1-tyler@tylercipriani.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move greplint.pl's parsing and token check work to a library. Modify the
greplint.pl to use the library. Break out actual checks into
check_tokens() sub.

In preparation to combine the work of chainlint and greplint into a
single parser invocation.

Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 t/greplint.pl                      | 249 +----------------------------
 t/{greplint.pl => lib-greplint.pl} |  69 ++++----
 2 files changed, 37 insertions(+), 281 deletions(-)
 copy t/{greplint.pl => lib-greplint.pl} (87%)

diff --git a/t/greplint.pl b/t/greplint.pl
index 68b6eba78d..e277647f11 100644
--- a/t/greplint.pl
+++ b/t/greplint.pl
@@ -1,257 +1,16 @@
 #!/usr/bin/env perl
 
-# Detect bare 'grep' used as a test assertion where 'test_grep'
-# should be used, and '! test_grep' where 'test_grep !' should
-# be used.
-#
-# The shared shell parser tokenizes test bodies so that 'grep'
-# inside heredocs, command substitutions like $(grep ...), and
-# quoted strings is collapsed into a single token and never seen
-# by our check.  A line-oriented approach would need to track
-# heredoc delimiters, nested $() depth, and cross-line pipe
-# state to avoid false positives on patterns like:
-#
-#   write_script foo.sh <<-\EOF
-#   grep pattern file    # data, not an assertion
-#   EOF
-#
-# The Lexer already handles these.
-
+# Detect bare 'grep' used as a test assertion
 use warnings;
 use strict;
 use File::Basename;
 do(dirname($0) . "/lib-shell-parser.pl")
 	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
+do(dirname($0) . "/lib-greplint.pl")
+	or die "$0: failed to load lib-greplint.pl: $@$!\n";
 
 my $exit_code = 0;
 
-# GrepLintParser inherits ScriptParser's ability to find
-# test_expect_success/failure blocks and call check_test()
-# on each body.  We override check_test() to walk the token
-# stream looking for bare grep assertions.
-package GrepLintParser;
-
-our @ISA = ('ScriptParser');
-
-# After these tokens, the next token is a command word.
-# For example, in 'echo foo && grep bar file', the 'grep'
-# after '&&' is at command position and should be flagged.
-my %cmd_start = map { $_ => 1 } qw(&& || ; ;; do then else elif), "\n", '{', '(';
-
-# Tokens indicating grep's output is piped or redirected.
-my %filter_op = map { $_ => 1 } qw(| > >> <);
-
-# A token is at "command word" position if the shell would
-# interpret it as a program name rather than an argument.
-# Only 'grep' at command position is an assertion we should
-# flag; 'grep' as an argument ('test_must_fail grep') or
-# value ('for cmd in grep sed') is not.
-sub is_command_word {
-	my ($tokens, $pos) = @_;
-	return 1 if $pos == 0;
-	for (my $j = $pos - 1; $j >= 0; $j--) {
-		my $t = $tokens->[$j]->[0];
-		# After a separator or pipe, a new command starts.
-		return 1 if $cmd_start{$t} || $t eq '|';
-		# After '}' or ')', what follows is a separator or
-		# redirect on the compound command, not a new command.
-		return 0 if $t eq '}' || $t eq ')';
-		# '!' is a prefix that does not consume command
-		# position; keep scanning to find what precedes it.
-		next if $t eq '!';
-		# Any other word means we are past the command word.
-		return 0;
-	}
-	return 1;
-}
-
-# lint_ok() reports whether a bare grep carries a trailing
-# '# lint-ok' comment telling this linter to skip it.
-#
-# In practice this is needed for just one case: a grep acting
-# as a data filter whose output is consumed by a redirect or
-# pipe on an enclosing compound command (such as a subshell or
-# brace group) rather than by grep's own pipeline, e.g.
-#
-#	( grep ... && # lint-ok
-#	  sed ... ) >out
-#
-#	{ grep ... || : # lint-ok
-#	} >out
-#
-# is_filter() only scans grep's own pipeline: it stops at the
-# separator before the compound command closes and never sees
-# the outer redirect, so it would flag such a grep as an
-# assertion.  A grep that really is an assertion is better
-# written as test_grep (or a guarded test_grep when the file's
-# presence is conditional) than annotated with lint-ok.
-sub lint_ok {
-	my ($raw_lines, $ln) = @_;
-	if ($ln < 1 || $ln > @$raw_lines) {
-		warn "lint_ok: line number $ln out of range (1.." .
-		    scalar(@$raw_lines) . ")\n";
-		return 0;
-	}
-	return $raw_lines->[$ln - 1] =~ /lint-ok/;
-}
-
-# Grep is a filter (not an assertion) if it receives piped
-# input or sends its output to a pipe or redirect.  Check
-# both directions from grep's position in the token stream.
-sub is_filter {
-	my ($tokens, $pos) = @_;
-	# Backward: is grep receiving piped input?
-	# Newlines don't break pipes ('cmd |\n grep' is one
-	# pipeline), so skip past them.
-	for (my $j = $pos - 1; $j >= 0; $j--) {
-		my $t = $tokens->[$j]->[0];
-		return 1 if $t eq '|';
-		next if $t eq "\n";
-		last if $cmd_start{$t} || $t eq '}' || $t eq ')';
-	}
-	# Forward: is grep piping or redirecting output?
-	# Unlike the backward scan, we do not skip newlines here:
-	# a bare newline is a command boundary, and redirects or
-	# pipes must appear on the same line as grep (or after a
-	# line continuation, which the Lexer consumes).
-	for (my $j = $pos + 1; $j < @$tokens; $j++) {
-		my $t = $tokens->[$j]->[0];
-		return 0 if $cmd_start{$t};
-		return 1 if $filter_op{$t};
-	}
-	return 0;
-}
-
-# Map a body-relative line number to a file line number.
-# For double-quoted bodies, backslash-continuation lines
-# (\<newline>) are consumed by the Lexer without appearing
-# in the body text, so the inner parser sees fewer lines
-# than the source file has.  We walk the source lines to
-# count continuations and adjust accordingly.
-sub body_to_file_line {
-	my ($body_lineno, $body_token, $raw_lines, $body_start) = @_;
-	my $body_text = $body_token->[0];
-	my $body_end_line = $body_token->[4];
-	unless ($body_start && $body_start >= 1) {
-		warn "body_start is not a positive integer\n";
-		return $body_lineno;
-	}
-	my $file_lineno = $body_lineno + $body_start - 1;
-	# Only double-quoted bodies have line splices.
-	return $file_lineno unless $body_text =~ /^"/;
-	my $adj = 0;
-	my $lines_seen = 0;
-	unless ($body_end_line && $body_end_line >= $body_start) {
-		warn "body_end_line is not set for double-quoted body\n";
-		return $file_lineno;
-	}
-	my $end = $body_end_line;
-	if ($end > @$raw_lines) {
-		warn "body_end_line ($end) exceeds file length (" .
-		    scalar(@$raw_lines) . ")\n";
-		return $file_lineno;
-	}
-	my $src_ln = $body_start;
-	while ($src_ln <= $end && $lines_seen < $body_lineno) {
-		my $line = $raw_lines->[$src_ln - 1];
-		# Odd trailing backslashes = continuation (\<nl>).
-		# Even = escaped backslashes (\\), not a continuation.
-		if ($line =~ /(\\*)$/ && length($1) % 2 == 1) {
-			$adj++;
-		} else {
-			$lines_seen++;
-		}
-		$src_ln++;
-	}
-	if ($lines_seen < $body_lineno) {
-		warn "body_lineno ($body_lineno) not found within body range " .
-		    "($body_start..$end)\n";
-	}
-	return $file_lineno + $adj;
-}
-
-# ScriptParser calls this for each test body found in the script.
-sub check_test {
-	my $self = shift @_;
-	my $title = ScriptParser::unwrap(shift @_);
-	my $body_token = shift @_;
-	my $body_start = $body_token->[3];
-	my $body = ScriptParser::unwrap($body_token);
-	# Handle heredoc-style test bodies:
-	#   test_expect_success 'title' - <<\EOF
-	#   grep pattern file
-	#   EOF
-	# The '-' signals that the body follows as a heredoc.
-	if ($body eq '-') {
-		my $herebody = shift @_;
-		if ($herebody) {
-			$body = $herebody->{content};
-			$body_start = $herebody->{start_line};
-		}
-	}
-	return unless $body;
-	# We can never match a bare "grep" if there isn't one in the first
-	# place. So we can skip all of the parsing effort. Technically you
-	# can have:
-	#
-	#   gr\
-	#   ep
-	#
-	# but that is sufficiently insane that I think we can ignore it.
-	return unless $body =~ /grep/;
-
-	my $raw_lines = $self->{raw_lines};
-
-	# The outer parser gives us the body as an opaque string.
-	# Parse it to get individual tokens with command boundaries.
-	my $parser = ShellParser->new(\$body);
-	my @tokens = $parser->parse();
-
-	my $file = $self->{file};
-
-	for (my $i = 0; $i < @tokens; $i++) {
-		my $text = $tokens[$i]->[0];
-		next unless is_command_word(\@tokens, $i);
-
-		my $token_lineno = $tokens[$i]->[3];
-		unless (defined($token_lineno) && $token_lineno >= 1) {
-			warn "token has no line number\n";
-			next;
-		}
-		my $file_lineno = body_to_file_line(
-			$token_lineno,
-			$body_token, $raw_lines, $body_start);
-
-		# '!' negates the exit code without consuming command
-		# position.  '! test_grep' is an anti-pattern because
-		# test_grep only prints diagnostics on grep failure,
-		# and '!' inverts after that decision is already made.
-		if ($text eq '!') {
-			if ($i + 1 < @tokens &&
-			    $tokens[$i + 1]->[0] eq 'test_grep' &&
-			    !lint_ok($raw_lines, $file_lineno)) {
-				print "$file:$file_lineno: error: ",
-				    'use "test_grep !" instead of ',
-				    '"! test_grep"', "\n";
-				$exit_code = 1;
-			}
-			next;
-		}
-
-		# Bare grep as a command (not a filter) is a test
-		# assertion that should use test_grep for better
-		# failure diagnostics.
-		if ($text eq 'grep' &&
-		    !is_filter(\@tokens, $i) &&
-		    !lint_ok($raw_lines, $file_lineno)) {
-			print "$file:$file_lineno: error: ",
-			    "bare grep outside pipeline ",
-			    "(use test_grep)\n";
-			$exit_code = 1;
-		}
-	}
-}
-
 package main;
 
 for my $file (@ARGV) {
@@ -263,5 +22,7 @@ package main;
 	$parser->{file} = $file;
 	$parser->{raw_lines} = \@raw_lines;
 	$parser->parse();
+	print "$_\n" for @{$parser->{output}};
+	$exit_code ||= $parser->{nerrs} > 0;
 }
 exit $exit_code;
diff --git a/t/greplint.pl b/t/lib-greplint.pl
similarity index 87%
copy from t/greplint.pl
copy to t/lib-greplint.pl
index 68b6eba78d..16b85b8d3b 100644
--- a/t/greplint.pl
+++ b/t/lib-greplint.pl
@@ -1,5 +1,3 @@
-#!/usr/bin/env perl
-
 # Detect bare 'grep' used as a test assertion where 'test_grep'
 # should be used, and '! test_grep' where 'test_grep !' should
 # be used.
@@ -19,16 +17,13 @@
 
 use warnings;
 use strict;
-use File::Basename;
-do(dirname($0) . "/lib-shell-parser.pl")
-	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
-
-my $exit_code = 0;
 
 # GrepLintParser inherits ScriptParser's ability to find
 # test_expect_success/failure blocks and call check_test()
 # on each body.  We override check_test() to walk the token
-# stream looking for bare grep assertions.
+# stream looking for bare grep assertions vs. test_grep.
+#
+# Requires lib-shell-parser.pl to be loaded.
 package GrepLintParser;
 
 our @ISA = ('ScriptParser');
@@ -207,13 +202,25 @@ sub check_test {
 	my $parser = ShellParser->new(\$body);
 	my @tokens = $parser->parse();
 
-	my $file = $self->{file};
+	my @errors = check_tokens(
+		$self->{file}, $raw_lines,
+		$body_token, $body_start, \@tokens);
 
-	for (my $i = 0; $i < @tokens; $i++) {
-		my $text = $tokens[$i]->[0];
-		next unless is_command_word(\@tokens, $i);
+	push(@{$self->{output}}, @errors);
+	$self->{nerrs} += @errors;
+}
 
-		my $token_lineno = $tokens[$i]->[3];
+# check_tokens() walks a parsed test body and returns a list of
+# error messages.
+sub check_tokens {
+	my ($file, $raw_lines, $body_token, $body_start, $tokens) = @_;
+	my @errors;
+
+	for (my $i = 0; $i < @$tokens; $i++) {
+		my $text = $tokens->[$i]->[0];
+		next unless is_command_word($tokens, $i);
+
+		my $token_lineno = $tokens->[$i]->[3];
 		unless (defined($token_lineno) && $token_lineno >= 1) {
 			warn "token has no line number\n";
 			next;
@@ -227,13 +234,12 @@ sub check_test {
 		# test_grep only prints diagnostics on grep failure,
 		# and '!' inverts after that decision is already made.
 		if ($text eq '!') {
-			if ($i + 1 < @tokens &&
-			    $tokens[$i + 1]->[0] eq 'test_grep' &&
+			if ($i + 1 < @$tokens &&
+			    $tokens->[$i + 1]->[0] eq 'test_grep' &&
 			    !lint_ok($raw_lines, $file_lineno)) {
-				print "$file:$file_lineno: error: ",
-				    'use "test_grep !" instead of ',
-				    '"! test_grep"', "\n";
-				$exit_code = 1;
+				push(@errors, "$file:$file_lineno: error: " .
+				    'use "test_grep !" instead of ' .
+				    '"! test_grep"');
 			}
 			next;
 		}
@@ -242,26 +248,15 @@ sub check_test {
 		# assertion that should use test_grep for better
 		# failure diagnostics.
 		if ($text eq 'grep' &&
-		    !is_filter(\@tokens, $i) &&
+		    !is_filter($tokens, $i) &&
 		    !lint_ok($raw_lines, $file_lineno)) {
-			print "$file:$file_lineno: error: ",
-			    "bare grep outside pipeline ",
-			    "(use test_grep)\n";
-			$exit_code = 1;
+			push(@errors, "$file:$file_lineno: error: " .
+			    "bare grep outside pipeline " .
+			    "(use test_grep)");
 		}
 	}
+
+	return @errors;
 }
 
-package main;
-
-for my $file (@ARGV) {
-	open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
-	my @raw_lines = <$fh>;
-	close $fh;
-	my $s = join('', @raw_lines);
-	my $parser = GrepLintParser->new(\$s);
-	$parser->{file} = $file;
-	$parser->{raw_lines} = \@raw_lines;
-	$parser->parse();
-}
-exit $exit_code;
+1;
-- 
2.47.3

