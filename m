Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA845F546
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840124; cv=none; b=JJMoVyPg97Mq0SEhHYi3kDHV+H6Cfmqq5vUuZStqL27l6KvBis5voewHT+fFfSRipwPpu/HMWJm9tpEfg3Mq71FwpnJQvpCzfLYKoZmbT84xwQCOi1qcOCTtz1oEZ21raWr45BFnig3/nB+/KVWmINPv2uZMVh6yIyfJIlOiK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840124; c=relaxed/simple;
	bh=Xi8aL4o8tWDMVTdhTYXVFTWzWPcLH2OghyjiiWyC6d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDFFUq3jbXrMEoyhA3KAodmjZqLl7Xq6zkJYb0EI8TWzbCMUDT7F2ZDFHNaC/fTsGOdt//vgy24DimqRTk+Mk3dB2lXnUD04c9yoYd8Q8DAHWoZ/S4AGB4o1Ez67zup03IWLJHqzKviDTsk/roleqXXslAno4hdzvk8eyGoyfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZI7VeXXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+vYbjSw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZI7VeXXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+vYbjSw"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 12FB511400B2;
	Tue, 13 Feb 2024 11:02:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Feb 2024 11:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707840121; x=1707926521; bh=jAZbN6k15rE2ju9M4LHBG9at9wlohmWE
	cnVGLBt/QTU=; b=ZI7VeXXy2ZDvpiSW/1TqXxvsZqbs7CQ0QdrERTYkhJtqZVdr
	5yi406BPpdRY5GlU727IEkZTbgBt1ULpJdqY/l+sjsxYIr81EFr+ZJUgXrbZbuqF
	9cOw9Hi3iWWIx4/MhWDohMtPJpFP821X1gRlYnGcZlN/ywHiHRVPaVTkzT/ukgDx
	lh+Vta+s/Md79gOey5/eQbtAI0+yaDlKga00KcZ+kurMhW8QrfyBNAfPUGZhOtwU
	f1kQk6GZCvv4y2cAhH+wB33SUS0NykN2IsM0bGhZUsAEqMuSGMqQO+US3GycxvBg
	s6FI3nQkMrkOtctzbg/n67JksakQ26DwS27uJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707840121; x=
	1707926521; bh=jAZbN6k15rE2ju9M4LHBG9at9wlohmWEcnVGLBt/QTU=; b=C
	+vYbjSwpB49lb1CawJvmPADdorCD7Agg4OSzRPkRDheqeZ4xRZvc3r8XuZsZq9HM
	vhkN6WEar+UYU3ZPz4ptszpYkMw3qoR3ehnl92zzQ8c6All5LBu8c8Orb/qZxKSL
	rG/ZI2etmrAUq6w7mcafqSHu4Le6/04XV4Xbk/+Qa6DiCjU6HuHV8FViA2gsTPuF
	+obKTeS5AvpCzyvBkiBXCtRoRVIa0KlGwzYzA/bfl/znGelheGvgr6/5LnA4MnKQ
	mWd/BhW5mZQUGAHGkqEUfE7mYTULr3NKVL9XqHp+5mtJL44k/E56xqTdkJWlB+Oc
	qHZGTxdckUv/8gFJwKOtA==
X-ME-Sender: <xms:eJLLZaudCqAhJzJo3sZgU8O0ITOGXGCXFwQ0OkHM5Mtmv0M6wc46KVY>
    <xme:eJLLZfffxpkH3rrSdp9R8tczgTQfUkfllvoRiJ1a-7CgVE4NvvFZy69V5sJg_vdfL
    yKGnJxlbiLGzlv7ZA>
X-ME-Received: <xmr:eJLLZVye-ccUCAQ7BbLJ9UYWDqgvWFdmaS46AdIEhA7cgylQyG6tUHZ0xybIVG0VkKP3Wisvf7YI5DSv4Glno2oKPQ1WU7MGVeRB21L2gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddvleeg
    feekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:eJLLZVOBQnMb3Abik_bs2WXbL27wgf7P4zfLezimuT2swEWYKdt3RQ>
    <xmx:eJLLZa9mSUJYIjnb4Pv2A6KwqvD4RDJ1McRhwH5LYm-1JKXDQ9yadQ>
    <xmx:eJLLZdWOvBe5mxTOgF8lfnWsfZ2R7ezCWn_OA8BqQOTzpXNQxG80fQ>
    <xmx:eZLLZazD1vRRTmjZzxTlTQqxm7Hes3KAZF70D2HzBWAs6Ge2K5HhKg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 11:01:58 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Tiago Pascoal <tiago@pascoal.net>,
	Chris Torek <chris.torek@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v3 0/2] column: disallow negative padding
Date: Tue, 13 Feb 2024 17:01:19 +0100
Message-ID: <cover.1707839454.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix bug in git-column(1): a user can pass a negative `padding` which
causes issues inside the memory allocator.

§ Changes in v3

Incorporate Ruben’s suggestion about guarding against negative padding
with `BUG` in `column.c` (not `builtin/column.c`). This then supersedes
Junio’s extra conditional checks since they are no longer needed. The
series gets split into two patches.

Cc: Tiago Pascoal <tiago@pascoal.net>
Cc: Chris Torek <chris.torek@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Rubén Justo <rjusto@gmail.com>

Kristoffer Haugsbakk (2):
  column: disallow negative padding
  column: guard against negative padding

 builtin/column.c  |  2 ++
 column.c          |  4 ++++
 t/t9002-column.sh | 11 +++++++++++
 3 files changed, 17 insertions(+)

Range-diff against v2:
1:  1c959378cf4 ! 1:  4cac42ca6f8 column: disallow negative padding
    @@ Commit message
         A negative padding does not make sense and can cause errors in the
         memory allocator since it’s interpreted as an unsigned integer.
     
    -    Disallow negative padding. Also guard against negative padding in
    -    `column.c` where it is conditionally used.
    -
         Reported-by: Tiago Pascoal <tiago@pascoal.net>
    -    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    -
    - ## Notes (series) ##
    -    v2:
    -    • Incorporate Junio’s changes (guard against negative padding in
    -      `column.c`)
    -    • Tweak commit message based on Junio’s analysis
    -    • Use gettext for error message
    -      • However I noticed that the “translation string” from `fast-import`
    -        isn’t a translation string. So let’s invent a new one and use a
    -        parameter so that it can be used elsewhere.
    -    • Make a test
    -
      ## builtin/column.c ##
     @@ builtin/column.c: int cmd_column(int argc, const char **argv, const char *prefix)
      	memset(&copts, 0, sizeof(copts));
    @@ builtin/column.c: int cmd_column(int argc, const char **argv, const char *prefix
      		usage_with_options(builtin_column_usage, options);
      	if (real_command || command) {
     
    - ## column.c ##
    -@@ column.c: void print_columns(const struct string_list *list, unsigned int colopts,
    - 	memset(&nopts, 0, sizeof(nopts));
    - 	nopts.indent = opts && opts->indent ? opts->indent : "";
    - 	nopts.nl = opts && opts->nl ? opts->nl : "\n";
    --	nopts.padding = opts ? opts->padding : 1;
    -+	nopts.padding = (opts && 0 <= opts->padding) ? opts->padding : 1;
    - 	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
    - 	if (!column_active(colopts)) {
    - 		display_plain(list, "", "\n");
    -@@ column.c: int run_column_filter(int colopts, const struct column_options *opts)
    - 		strvec_pushf(argv, "--width=%d", opts->width);
    - 	if (opts && opts->indent)
    - 		strvec_pushf(argv, "--indent=%s", opts->indent);
    --	if (opts && opts->padding)
    -+	if (opts && 0 <= opts->padding)
    - 		strvec_pushf(argv, "--padding=%d", opts->padding);
    - 
    - 	fflush(stdout);
    -
      ## t/t9002-column.sh ##
     @@ t/t9002-column.sh: EOF
      	test_cmp expected actual
-:  ----------- > 2:  9355fc98e3d column: guard against negative padding
-- 
2.43.0

