Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639319F42F
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846702; cv=none; b=AeG3Xpq73XXkgFOZRcc9LX3Rc0Vi4ksUZCd1dYVQQDYwOIww+qS8OZTd8Wgts4HlKhYXQQrFao/maLi1lB+aA11XFKdGEbfz2npEv84QFNMX9X9Arer5nq/7E34lloFOuG543mIcYFW9bvrnhztmjnT95eCGgJJDZpA9RkMdu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846702; c=relaxed/simple;
	bh=HWN10AjLTZySC5fxubJ7SN4iW/OyPShbDnaFMtVPbBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoM1dhz9LVvmECDaUmFPx4h1KoFnpLPVpX162s0F7g7zWjo2lMWD26B4clt6DZwS5t++GgKiUTYTdUPvAB4IoEDiENKstYX194xK4e1SXauV87wUqOf/HFWWwOr3/x3rXn/9zYsjQgHMFGqZRBIFQKyTN5VOBVzYd1O46fd1Y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ekLCMSqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqpRw17J; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ekLCMSqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqpRw17J"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5CBD8114014C;
	Mon,  2 Jun 2025 02:44:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Jun 2025 02:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846699;
	 x=1748933099; bh=xGt/kjR1riYj2VWJ3mY+hR0wIGxU1j2/O0FUsyE76ak=; b=
	ekLCMSqqqWyKj+sLM89fjc6nG1S3P7DKQh1sSDNvXhOqQsv7W7z7sCdoswqQFx8v
	Br2scg7rv8WqhfLTyfvNZK9pbhvE0lXAyUTU2vDMRvWuUreRLNrPZvdqLts2zWZT
	mvVwMEo9NLPUXtNg1acaAlTlFPUpe28eGBFMJKBrymOpqcE1o2+73/+wUVmPvSGK
	puc/4s0T+/F/avmqthwZn7CQaAyT6pZVu8a7DeSl6Fx7i/RE6PnZan87ZORUSi8P
	APWnoTXRnDj24uPhHaRnT1YQGK1GWUfM/94/565NvXHBRnhDllhhegPze+BwTfxz
	I98myecyNuaRE1jYVWOI4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846699; x=
	1748933099; bh=xGt/kjR1riYj2VWJ3mY+hR0wIGxU1j2/O0FUsyE76ak=; b=V
	qpRw17J1xEfut4h4ACbPa5WjqZvfVzxtzbYEsNipvZxl5vG5nLew7Yh23wMsCj5B
	faN9KNbuPBV1fxBsbipMw87eItvjGplx50C6zP5zfNsPVxbju0q3SZjtSO52Wt9d
	ebJdbAYASIGF/40v6F9C7YZtVnFyCgl2PmORs8A5T0XcYLBrzk2dUlXCkmVAAqIW
	mYFy+hJs+ZjH+pFxUeHo5cDe6q10ctkPxvVy4Z1Y5LLcUDY8iWSlKGwmVHfYJGVN
	DxKsiSZ2c4+n2FW82FGsv10MPEl3tltEzTtJ8sjV6c/1wEqvTSGaFiLkyPp6lWcX
	ey30zPZyaiKx2Ci7xVAeA==
X-ME-Sender: <xms:a0g9aBt29igwKKN42Ao7AMqB50OqCN-YW6XY3ZABLefrXcGqMKuiPQ>
    <xme:a0g9aKen5nEW5qN98LRjjC6iCUP4VFHtzarFsLY-nHFMhb7XoI_x6p3KHlD6fwkWI
    135Zpfz4HQw-zJ57Q>
X-ME-Received: <xmr:a0g9aEzEKRHaHNnoTvkgb5Lku5VOHCdUmFXBaGaJJULMxxNMWa2Hvr1YCBG_LonD-9CUoR0JuroD4meJ79BFx1G3pJtVa8m3311C3mY5hL2fVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmsh
    grhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:a0g9aINIGPg31jC5ZPKqm8zu7a5CM6BA-A3897FAiogWHPnFvXeigA>
    <xmx:a0g9aB9WhCI7JsfKsSuotna2JhR0TO0de6x0q_EawxYJlhIjLTcnXA>
    <xmx:a0g9aIUhM1_KEezgxuc_Kva7Gui_5dfbj5nwg4OXUJTslrCU4R2uwA>
    <xmx:a0g9aCdVHChZfx-xGELlMrl-PsMHAuXj1U7ueU784LL71CgwPcxz2w>
    <xmx:a0g9aDS3iyfgSq4NK4YSHee2CJUW8jYUBRFQ0nC1IffimOGhKPqHAKtv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c313ac9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:45 +0200
Subject: [PATCH v4 05/10] t/test-lib: don't print shell traces to stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-5-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

We have several flags like "--verbose", "--verbose-only" or "-x" that
cause us to generate shell traces. The generated tracing output is split
up in these cases so that the test's stdout is printed to file
descriptor 3 whereas its stderr is printed to file descriptor 4.
Depending on which options have been given, we then end up either:

  - Redirecting both file descriptors to a file.

  - Redirecting them to stdout and stderr, respectively.

  - Closing them in case we're running in none-verbose mode.

The second case causes problems though when passing output to a TAP
parser. We print the test's stdout to the console's stdout, and that
results in broken TAP output.

Fix the issue by instead redirecting the test's stdout to the shell's
stderr. This makes it impossible to discern stdout from stderr, but
going by my own experience I never came across a usecase where I would
have needed this distinction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0000-basic.sh | 35 +++++++++++++++++++----------------
 t/test-lib.sh    |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 35c5c2b4f9b..16b785f3b91 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -219,41 +219,44 @@ test_expect_success 'subtest: --verbose option' '
 	test_expect_success "failing test" false
 	test_done
 	EOF
-	mv t1234-verbose/out t1234-verbose/out+ &&
-	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
-	check_sub_test_lib_test t1234-verbose <<-\EOF
-	> expecting success of 1234.1 '\''passing test'\'': true
+	mv t1234-verbose/err t1234-verbose/err+ &&
+	grep -v "^Initialized empty" t1234-verbose/err+ >t1234-verbose/err &&
+	check_sub_test_lib_test_err t1234-verbose \
+		<<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
+	> ok 2 - test with output
+	> not ok 3 - failing test
+	> #	false
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF_OUT
+	> expecting success of 1234.1 '\''passing test'\'': true
 	> Z
 	> expecting success of 1234.2 '\''test with output'\'': echo foo
 	> foo
-	> ok 2 - test with output
 	> Z
 	> expecting success of 1234.3 '\''failing test'\'': false
-	> not ok 3 - failing test
-	> #	false
 	> Z
-	> # failed 1 among 3 test(s)
-	> 1..3
-	EOF
+	EOF_ERR
 '
 
 test_expect_success 'subtest: --verbose-only option' '
 	run_sub_test_lib_test_err \
 		t1234-verbose \
 		--verbose-only=2 &&
-	check_sub_test_lib_test t1234-verbose <<-\EOF
+	check_sub_test_lib_test_err t1234-verbose <<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
-	> Z
-	> expecting success of 1234.2 '\''test with output'\'': echo foo
-	> foo
 	> ok 2 - test with output
-	> Z
 	> not ok 3 - failing test
 	> #	false
 	> # failed 1 among 3 test(s)
 	> 1..3
-	EOF
+	EOF_OUT
+	> Z
+	> expecting success of 1234.2 '\''test with output'\'': echo foo
+	> foo
+	> Z
+	EOF_ERR
 '
 
 test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index af722d383d9..6ce8570226c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -707,7 +707,7 @@ then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
 elif test "$verbose" = "t"
 then
-	exec 4>&2 3>&1
+	exec 4>&2 3>&2
 else
 	exec 4>/dev/null 3>/dev/null
 fi
@@ -949,7 +949,7 @@ maybe_setup_verbose () {
 	test -z "$verbose_only" && return
 	if match_pattern_list $test_count "$verbose_only"
 	then
-		exec 4>&2 3>&1
+		exec 4>&2 3>&2
 		# Emit a delimiting blank line when going from
 		# non-verbose to verbose.  Within verbose mode the
 		# delimiter is printed by test_expect_*.  The choice

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

