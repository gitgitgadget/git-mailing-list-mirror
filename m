Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4441AB530
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656777; cv=none; b=f7VRXTVi3/125vaoIrntGZpcv6NtDOCL4bILpog874BxHLSbOvQS8HyXGlKS07oiWzYPo/y96kJ9Ss44v9gu9A5QqgMehdH9CuVvdGrmugzkqkYqqvtGLheU8GoLa/R701z15HjoBsgyRtX8R0k4I3G01VhdhdTJQPmkvKpdgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656777; c=relaxed/simple;
	bh=nIFJ306TPKbrE7SJFsYWFN7Vy3LGf7ecR56WHere+0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ze2DAQkcNinOxmrPLuB9gDyBk2LurtQdD07lFEAwMKlU227+KacuS/J7wtInRtR6F8I7JBBBKvBeuDXvsGyV5aEWJ9Swifw11FBnhe+O0fcmEc2jNtzJPJKQ5SfGQ8phOqGHzKhBuvVUDhOayL+VWX7r54UCdAd82rouJRNVOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MkAgIRN0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeYYamZh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MkAgIRN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeYYamZh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7784F1140193;
	Thu,  3 Apr 2025 01:06:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Apr 2025 01:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656774;
	 x=1743743174; bh=j3O5wJbPmAwQgnNj/89jQqfhUIRUFZvSwTYFAiwrCdQ=; b=
	MkAgIRN0IPCOpUAYJCM7ulMgubTxko38w8woK8IU2121XxiSPTQRZU6JbUwoCtaA
	BHtBousilJhK8TFvRKwAub3mgmlzzjka1JoV7GkFMuj81/zS38VKEtGOZIXoW0fA
	EeF4WWUUN7As66Lf89NGOYTs+TyiYWh1nubGA2PlfunwlDF44VdFxYwUKQHAHxm7
	W7Et7tUFsdxlvOrgiUeazCZHcRIjJAN9BRMcbqLPdtT1giiQJ719CoV3gPbdypZo
	YBs9GNmyWADtZpEl76qWB8sJyvNNBbb4MDDN5Je7SQHUNYD40m0btjmOLuCkCTXY
	t/SUpyhNjhY5jIGQO2yLwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656774; x=
	1743743174; bh=j3O5wJbPmAwQgnNj/89jQqfhUIRUFZvSwTYFAiwrCdQ=; b=F
	eYYamZh0JZZ+KdAuSjlljFsnVaGjCbjFFKwb4GZ+DF5rYKBD5p6Fpkt2BRqL7Kx+
	InmFbm36JK1ErhifW0vXRn/4qq915CfaKM4897Kk6kSJvqX1UMa1XNTryPrWcnhM
	NrnVVlPsr2LlJd+rmLnafaeSjGorUfcfzN8mLarGDpEJZGWXWgVVb0cbJFYMjEkI
	2Z6WEtC/ywY4xqmJyCs6yE5rngLhvXPvU2Jt/5lA+OaqKR8bcdjDcg9OFzm7Zkzz
	srHwnypEnFlxcL3ubpYf+2D1l5isN6a+2sN8+3eDuh/neQjlcYAPH6b2YkxgdzKA
	67F8xG4g98sv28cn46EYg==
X-ME-Sender: <xms:RhfuZwRIBnhwcBV5fZZKND9yBW3eazajaZ8LzHtc1PFKYrAPZEjKhg>
    <xme:RhfuZ9xdBuNepwq0vHL3hOf2oGLSvP-tMjXGa3iFlXVyNfc5OCXDnLalcM8ZyB1t6
    7OqP-JsCrq3LKsSoA>
X-ME-Received: <xmr:RhfuZ932OahzsvsZDWoMVRgXICv7kd3gaXAsUKRWe4jldBpv8IaI7KuuboSyTVBrOsU3qQhDdUnslc0oCVzQ8zjg5BUVIJwn4ekQ--vNblsHYNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RhfuZ0AWGDNzxO2KZHNza2WEbvYVn0I2xJoIGSwf9V0tAiLawx26jw>
    <xmx:RhfuZ5i9gqTSpxtHi16FPqCO3Gdce69Wlz59RSN5v7R5cccu5lN90Q>
    <xmx:RhfuZwrmB5sG6_RUxP_M6Zvggh83QEorp_Az4OwI4sh1Q8__JVpqUA>
    <xmx:RhfuZ8h_30pljziWddRRLt6m__33ZjW5VcdMn6AdnJsoJZcIiZMOVA>
    <xmx:RhfuZ_ksQzkmlObwn6oysltrNFn77hHEAmoemqJiG0ZKayoxJly7ydr7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 443b09cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:09 +0200
Subject: [PATCH v4 18/20] t0210: refactor trace2 scrubbing to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-18-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The output generated by our trace2 mechanism contains several fields
that are dependent on the environment they're being run in, which makes
it somewhat harder to test it. As a countermeasure we scrub the output
and strip out any fields that contain such information.

The logic to do so is implemented in Perl, but it can be trivially
ported to instead use sed(1). Refactor the code accordingly so that we
can drop the PERL_TEST_HELPERS prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0210-trace2-normal.sh  | 61 +++++++++++++++++++++++++++++++++--------------
 t/t0210/scrub_normal.perl | 54 -----------------------------------------
 2 files changed, 43 insertions(+), 72 deletions(-)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index ba4c0442b85..96c68f65df2 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -4,12 +4,6 @@ test_description='test trace2 facility (normal target)'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping trace2 tests; Perl not available'
-	test_done
-fi
-
 # Turn off any inherited trace2 settings for this test.
 sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
 sane_unset GIT_TRACE2_BRIEF
@@ -59,10 +53,41 @@ GIT_TRACE2_BRIEF=1 && export GIT_TRACE2_BRIEF
 #
 # Implicit return from cmd_<verb> function propagates <code>.
 
+scrub_normal () {
+	# Scrub the variable fields from the normal trace2 output to make
+	# testing easier:
+	#
+	#   1. Various messages include an elapsed time in the middle of the
+	#      message. Replace the time with a placeholder to simplify our
+	#      HEREDOC in the test script.
+	#
+	#   2. We expect:
+	#
+	#        start <argv0> [<argv1> [<argv2> [...]]]
+	#
+	#      where argv0 might be a relative or absolute path, with or
+	#      without quotes, and platform dependent. Replace argv0 with a
+	#      token for HEREDOC matching in the test script.
+	#
+	#   3. Likewise, the 'cmd_path' message breaks out argv[0].
+	#
+	#      This line is only emitted when RUNTIME_PREFIX is defined,
+	#      so just omit it for testing purposes.
+	#
+	#   4. 'cmd_ancestry' is not implemented everywhere, so for portability's
+	#      sake, skip it when parsing normal.
+	sed \
+		-e 's/elapsed:[0-9]*\.[0-9][0-9]*\([eE][-+]\{0,1\}[0-9][0-9]*\)\{0,1\}/elapsed:_TIME_/g' \
+		-e "s/^start '[^']*' \(.*\)/start _EXE_ \1/" \
+		-e 's/^start [^ ][^ ]* \(.*\)/start _EXE_ \1/' \
+		-e '/^cmd_path/d' \
+		-e '/^cmd_ancestry/d'
+}
+
 test_expect_success 'normal stream, return code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
 	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
@@ -76,7 +101,7 @@ test_expect_success 'normal stream, return code 0' '
 test_expect_success 'normal stream, return code 1' '
 	test_when_finished "rm trace.normal actual expect" &&
 	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 001return 1 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 1
@@ -91,7 +116,7 @@ test_expect_success 'automatic filename' '
 	test_when_finished "rm -r traces actual expect" &&
 	mkdir traces &&
 	GIT_TRACE2="$(pwd)/traces" test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&
+	scrub_normal <"$(ls traces/*)" >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
@@ -109,7 +134,7 @@ test_expect_success 'automatic filename' '
 test_expect_success 'normal stream, exit code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
 	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 002exit 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 002exit 0
@@ -123,7 +148,7 @@ test_expect_success 'normal stream, exit code 0' '
 test_expect_success 'normal stream, exit code 1' '
 	test_when_finished "rm trace.normal actual expect" &&
 	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 002exit 1 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 002exit 1
@@ -141,7 +166,7 @@ test_expect_success 'normal stream, exit code 1' '
 test_expect_success 'normal stream, error event' '
 	test_when_finished "rm trace.normal actual expect" &&
 	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 003error "hello world" "this is a test" &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
@@ -161,7 +186,7 @@ test_expect_success 'normal stream, error event' '
 test_expect_success 'BUG messages are written to trace2' '
 	test_when_finished "rm trace.normal actual expect" &&
 	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 007bug
@@ -185,7 +210,7 @@ test_expect_success 'bug messages with BUG_if_bug() are written to trace2' '
 	sed "s/^.*: //" <err >actual &&
 	test_cmp expect actual &&
 
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 008bug
@@ -211,7 +236,7 @@ test_expect_success 'bug messages without explicit BUG_if_bug() are written to t
 	sed "s/^.*: //" <err >actual &&
 	test_cmp expect actual &&
 
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 009bug_BUG
@@ -236,7 +261,7 @@ test_expect_success 'bug messages followed by BUG() are written to trace2' '
 	sed "s/^.*: //" <err >actual &&
 	test_cmp expect actual &&
 
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 010bug_BUG
@@ -268,7 +293,7 @@ test_expect_success 'using global config, normal stream, return code 0' '
 	test_config_global trace2.normalBrief 1 &&
 	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
 	test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
@@ -286,7 +311,7 @@ test_expect_success 'using global config with include' '
 	mv "$(pwd)/.gitconfig" "$(pwd)/real.gitconfig" &&
 	test_config_global include.path "$(pwd)/real.gitconfig" &&
 	test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
diff --git a/t/t0210/scrub_normal.perl b/t/t0210/scrub_normal.perl
deleted file mode 100644
index 7cc4de392a0..00000000000
--- a/t/t0210/scrub_normal.perl
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/usr/bin/perl
-#
-# Scrub the variable fields from the normal trace2 output to
-# make testing easier.
-
-use strict;
-use warnings;
-
-my $float = '[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?';
-
-# This code assumes that the trace2 data was written with bare
-# turned on (which omits the "<clock> <file>:<line>" prefix.
-
-while (<>) {
-    # Various messages include an elapsed time in the middle
-    # of the message.  Replace the time with a placeholder to
-    # simplify our HEREDOC in the test script.
-    s/elapsed:$float/elapsed:_TIME_/g;
-
-    my $line = $_;
-
-    # we expect:
-    #    start <argv0> [<argv1> [<argv2> [...]]]
-    #
-    # where argv0 might be a relative or absolute path, with
-    # or without quotes, and platform dependent.  Replace argv0
-    # with a token for HEREDOC matching in the test script.
-
-    if ($line =~ m/^start/) {
-	$line =~ /^start\s+(.*)/;
-	my $argv = $1;
-	$argv =~ m/(\'[^\']*\'|[^ ]+)\s+(.*)/;
-	my $argv_0 = $1;
-	my $argv_rest = $2;
-
-	print "start _EXE_ $argv_rest\n";
-    }
-    elsif ($line =~ m/^cmd_path/) {
-	# Likewise, the 'cmd_path' message breaks out argv[0].
-	#
-	# This line is only emitted when RUNTIME_PREFIX is defined,
-	# so just omit it for testing purposes.
-	# print "cmd_path _EXE_\n";
-    }
-    elsif ($line =~ m/^cmd_ancestry/) {
-	# 'cmd_ancestry' is not implemented everywhere, so for portability's
-	# sake, skip it when parsing normal.
-	#
-	# print "$line";
-    }
-    else {
-	print "$line";
-    }
-}

-- 
2.49.0.604.gff1f9ca942.dirty

