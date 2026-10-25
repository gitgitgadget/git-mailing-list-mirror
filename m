Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910160;
	b=lI5jRarGfMbZm03O/WhzXbevEPe6qcVfk+mWVxtx2zhl7hcPnvHgWz8PUjRiHuavHgPQ
	 6+RgV1S5s6syahgWRyVE4gQ/8NzNoxir+gZ7nZljAd5+zJaVN6YaRAUfF9KXcsZY8Qliz
	 dik+RhQUtPriAovbMWCaiZ41C1I448jjxxJ6/G8MItegt/ctB26gIiPfIDtUPM+PVwIoF
	 5Lz3xDsX7I4pGtsNxSKWTkYyaSjc/lpCtydTsRqXVZT764bM81jY4382ZnAfvBEYrhBrJ
	 /k4tPZl26Su/TkQx5GZIK29GXQE2H5cx730bivLQcVKF85ZG2BVxnNvA7jrsxPv894w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bzU1QjCQnpExPBPnw3kg8bZfno7gsmWqomjOciCOlWI=;
	b=vJfM6DZBM+npmWXOgB+ZEJoKCY2H9aLeBnr2s/MlNr6QI7zgZTMEKoTzP3GJhZylBt0i
	 CbiAZ7KcWoM2f1d5nk5oLFwKuB/P1eLLaaFPT3+klBEeEX1bWkKvmmndy2bqVGG9zWxg+
	 eWcXOH6wXvc3abPdQzBFZ41nftofcxaytjGLDNocJdypdA5Mvl7tAaAhiD9HZK4Ti+/7E
	 7TcmoNNxRJvGRbOBQ7fxi7ewzSIRdqYeFa5EQMvLqZEWpOO7QZUS3WDdtby0U1RDSuP9t
	 kYLuu89cCOHGb9iiXYOrlTVjwL8LV2ROdXUlOgjB3snvKz/iKKJT3z3UafZ+UUTRndw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sQzkeQGv;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F9606A31D
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 06:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB3F9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sQzkeQGv
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-705cb6cedd5so2094051eaf.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792910158; x=1793514958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzU1QjCQnpExPBPnw3kg8bZfno7gsmWqomjOciCOlWI=;
        b=sQzkeQGvJDDAva/EAIv8jFko5mHE/ho4D5SYesIbLQeGwUik8jr2m0eqZN40UfY7jd
         2WrQY5nIiM4POZBPqlhOapCUSG7X3+YLIqv6QiEJKNbw9BI3f2nU820KrwYS1+G4uZjz
         YLwM3kTTGOJUrPeTN/OraU4KKHOt+yQ0JS+SFggjZh7b1CtVaBMnqGtKMy/gkc8zaKmC
         L16yo47tqqgY4ose45948PGMwzV2gnXnK7r1L4S/K2tB6bOT1IokXmxlG7UTqmwl0saa
         UECu704w3dgZgHSEIVgBIMaoLkPbQAqMARpvc9y4ZZx91Jmv9a4umxZPfS+18vQUIKer
         cZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910158; x=1793514958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bzU1QjCQnpExPBPnw3kg8bZfno7gsmWqomjOciCOlWI=;
        b=G/EftRtO2ZkXEJ93SUpUXQMtS7f3989AIrt9/VX+OM/4FVi+8XWQu5kn6MwZ0JXJM0
         V3Mk7Du6KjiQE6RzSPMO1V00JlKUrDhMwCqNqUOZjKsEux7UTs4zZV2G4nvT2RZsW6cF
         LLcYWbXomHflMuv+eJ1kzgpNNL6FWiKe4Viwm2VI70yzkfgJ5RGWPCHZNYWdKU1QRfkk
         W8Lle8F44+oG0eVqmdvTfiUkey+MC9hMIsjykezo6VM74CGPLGyWkoPX+Z5tAegptCIl
         IAHEQ7myoqVKw0d1S1Jhyw58qokgM3WL9pXEQvXjZhdqkBXnsz7LHTar2FXPTdaWC3Pl
         NJig==
X-Gm-Message-State: AFq9FYKSBPMOIowjOByVjjsi+G1/r39pfgX0hpcSqh7oOLw5SFEXB/rY
	dhONWWsirhTpfB7CEsZnsAmXfkM98Wk750qA9DAGmaiO6fceR+BGTF4Vf9ihRAnrn9S2UH2Ardu
	MpBaH
X-Gm-Gg: AYBFou1wIgUdkOHL1Gk7RV9ncEtOOLkve6S6CvWHGQeWjxFh2Nmr1b5QEpauOe13Q4L
	gZhKAgMzuSh7jxXbxLspoTesC4cbAEyBcLtxixbZCM1+wYSVh1vtMYnXvLKRxQuR0LE4g5Jfnrq
	DHKCswtu8JM9ev90sAOvWVPh64AKsxPMG7ERmDj1DSRrRAXjpyDGUCx6/J71fe+C56KmX0cqr8E
	MCdCmldfh0sk/7fZ3T546taCrg089qMxZmAfBf69ruPsCxsu+dVv8yZEAtg5XBkRAOiYnh7MFBL
	g/aRFUNXW32qlhnGnOzQBxRaI+fa9aE8PJErr4wm3vl/SrsaP/DxWkxcaidSa8Yr2lHrOgUfy6B
	4NfPrNF3zjQph4cJttpBSrOSv7XRk5lnhipV8x+IIDckPRryZ11XZv2FoP+8/isRJWvyztyhuBm
	3aOQAp1rdAfurcN1ljsdy0cH38Czc6Jx/Mq06C/VWX2ab5S/4GnbV2QcEQhmr4Y+53xtMcGYRSV
	yalnlvL8qpq9JjQBwBX7oAStoivwNewpwxsx09mOoEX2Bcalhp6HsYzng==
X-Received: by 2002:a05:6820:c0c5:20b0:6f7:e193:8326 with SMTP id 006d021491bc7-70ba1435db3mr818278eaf.32.1792910158656;
        Sat, 24 Oct 2026 23:35:58 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-70b9df06f1asm3819925eaf.5.2026.10.24.23.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 23:35:58 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/4] t/chainlint: add --greplint to run greplint
Date: Sun, 25 Oct 2026 00:35:08 -0600
Message-ID: <20261025063508.3026136-5-tyler@tylercipriani.com>
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

Save duplicate file handling and parsing work (and gain parallel file
processing) by teaching chainlint to do the work of greplint.

Add --greplint option to chainlint.pl so that it passes tokens to
GrepLintParser::check_tokens(). This change allows chainlint.pl to do
greplint checks after chainlint has done all the hard work of file
handling and parsing.

Update Makefile with new target that invokes chainlint.pl --greplint. In
the common case, make test-lint will use the new chainlint target.
Continue to respect and set GIT_TEST_CHAIN_LINT=0.

Ensure test-chainlint/test-greplint run on the same set of test files,
which expands the set for both.

Local laptop testing shows make test-lint went from around 4.5s before
this change to less than 1s after (with -j$(nproc) where nproc == 16).

Reported-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 t/Makefile     | 30 ++++++++++++++++++++++--------
 t/chainlint.pl | 24 ++++++++++++++++++++----
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index e3249879c4..bfe861f6e0 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -56,9 +56,9 @@ UNIT_TEST_PROGRAMS += unit-tests/bin/unit-tests$(X)
 UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
 UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
 
-# `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
-# checks all tests in all scripts via a single invocation, so tell individual
-# scripts not to run the external "chainlint.pl" script themselves
+# `test-chainlint-greplint` (which is a dependency of `test-lint`, `test`, and
+# `prove`) checks all tests in all scripts via a single invocation, so tell
+# individual scripts not to run the external "chainlint.pl" script themselves
 CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
 
 all:: $(DEFAULT_TEST_TARGET)
@@ -127,6 +127,7 @@ check-chainlint:
 clean-greplint:
 	$(RM) -r '$(GREPLINTTMP_SQ)'
 
+# chainlint --jobs=1 needed: parallel workers emit output in arbitrary order
 check-greplint:
 	@mkdir -p '$(GREPLINTTMP_SQ)' && \
 	'$(PERL_PATH_SQ)' greplint-cat.pl '$(GREPLINTTMP_SQ)' $(GREPLINTTESTS) && \
@@ -134,6 +135,11 @@ check-greplint:
 		$(patsubst %,greplint/%.test,$(GREPLINTTESTS)) \
 		>'$(GREPLINTTMP_SQ)'/actual 2>&1 || true; } && \
 	diff -u '$(GREPLINTTMP_SQ)'/expect '$(GREPLINTTMP_SQ)'/actual
+	@$(CHAINLINT) --greplint --jobs=1 \
+		$(patsubst %,greplint/%.test,$(GREPLINTTESTS)) 2>&1 | \
+		sed -e '/^# chainlint: /d' -e '/^[0-9][0-9]* /d' \
+		>'$(GREPLINTTMP_SQ)'/actual-chainlint && \
+	diff -u '$(GREPLINTTMP_SQ)'/expect '$(GREPLINTTMP_SQ)'/actual-chainlint
 
 check-meson:
 	@# awk acts up when trying to match single quotes, so we use \047 instead.
@@ -154,12 +160,16 @@ check-meson:
 test-lint: test-lint-duplicates test-lint-executable \
 	test-lint-filenames
 ifneq ($(PERL_PATH),)
-test-lint: test-lint-shell-syntax test-greplint
+test-lint: test-lint-shell-syntax
 else
 GIT_TEST_CHAIN_LINT = 0
 endif
 ifneq ($(GIT_TEST_CHAIN_LINT),0)
-test-lint: test-chainlint
+test-lint: test-chainlint-greplint
+else
+ifneq ($(PERL_PATH),)
+test-lint: test-greplint
+endif
 endif
 
 test-lint-duplicates:
@@ -176,7 +186,7 @@ test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
 
 test-greplint:
-	@'$(PERL_PATH_SQ)' greplint.pl $(T) $(THELPERS) $(TPERF)
+	@'$(PERL_PATH_SQ)' greplint.pl $(T) $(THELPERS) $(TPERF) $(TINTEROP)
 
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
@@ -186,8 +196,11 @@ test-lint-filenames:
 		test -z "$$bad" || { \
 		echo >&2 "non-portable file name(s): $$bad"; exit 1; }
 
+test-chainlint-greplint:
+	@$(CHAINLINT) --greplint $(T) $(THELPERS) $(TPERF) $(TINTEROP)
+
 test-chainlint:
-	@$(CHAINLINT) $(T) $(TLIBS) $(TPERF) $(TINTEROP)
+	@$(CHAINLINT) $(T) $(THELPERS) $(TPERF) $(TINTEROP)
 
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
@@ -204,7 +217,8 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint \
-	check-greplint clean-greplint test-greplint $(UNIT_TESTS)
+	check-greplint clean-greplint test-greplint \
+	test-chainlint-greplint $(UNIT_TESTS)
 
 .PHONY: libgit-sys-test libgit-rs-test
 libgit-sys-test:
diff --git a/t/chainlint.pl b/t/chainlint.pl
index cededf15ee..dda3617add 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -22,10 +22,13 @@
 my $jobs = -1;
 my $show_stats;
 my $emit_all;
+my $greplint;
 
 use File::Basename;
 do(dirname($0) . "/lib-shell-parser.pl")
 	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
+do(dirname($0) . "/lib-greplint.pl")
+	or die "$0: failed to load lib-greplint.pl: $@$!\n";
 
 # TestParser is a subclass of ShellParser which, beyond parsing shell script
 # code, is also imbued with semantic knowledge of test construction, and checks
@@ -147,9 +150,9 @@ sub format_problem {
 sub check_test {
 	my $self = shift @_;
 	my $title = ScriptParser::unwrap(shift @_);
-	my $body = shift @_;
-	my $lineno = $body->[3];
-	$body = ScriptParser::unwrap($body);
+	my $body_token = shift @_;
+	my $lineno = $body_token->[3];
+	my $body = ScriptParser::unwrap($body_token);
 	if ($body eq '-') {
 		my $herebody = shift @_;
 		$body = $herebody->{content};
@@ -160,6 +163,12 @@ sub check_test {
 	my @tokens = $parser->parse();
 	my $problems = $parser->{problems};
 	$self->{nerrs} += @$problems;
+	if ($greplint) {
+		my @grep_errors = GrepLintParser::check_tokens($self->{file},
+			$self->{raw_lines}, $body_token, $lineno, \@tokens);
+		push(@{$self->{greplint}}, @grep_errors);
+		$self->{nerrs} += @grep_errors;
+	}
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
 	my ($erropen, $errclose) = -t 1 ? ("$c->{rev}$c->{red}", $c->{reset}) : ('?!', '?!');
@@ -296,15 +305,21 @@ sub check_script {
 			$emit->("?!ERR?! $path: $!\n");
 			next;
 		}
-		my $s = do { local $/; <$fh> };
+		my @raw_lines = <$fh>;
 		close($fh);
+		my $s = join('', @raw_lines);
 		my $parser = ChainlintParser->new(\$s);
+		$parser->{file} = $path;
+		$parser->{raw_lines} = \@raw_lines;
+		$parser->{greplint} = [];
 		1 while $parser->parse_cmd();
 		if (@{$parser->{output}}) {
 			my $c = fd_colors(1);
 			my $s = join('', @{$parser->{output}});
 			$emit->("$c->{bold}$c->{blue}# chainlint: $path$c->{reset}\n" . $s);
 		}
+		$emit->(join('', map { "$_\n" } @{$parser->{greplint}}))
+			if @{$parser->{greplint}};
 		$ntests += $parser->{ntests};
 		$nerrs += $parser->{nerrs};
 	}
@@ -323,6 +338,7 @@ sub exit_code {
 Getopt::Long::Configure(qw{bundling});
 GetOptions(
 	"emit-all!" => \$emit_all,
+	"greplint!" => \$greplint,
 	"jobs|j=i" => \$jobs,
 	"stats|show-stats!" => \$show_stats) or die("option error\n");
 $jobs = ncores() if $jobs < 1;
-- 
2.47.3

