Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EC5F547
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840126; cv=none; b=HfjS5Mx7sqiyaSuet39Z5LaCuT0BclC8gQhOUZkeUCDetJzRMQ+VOVIvAypZHy2puE+smUauZtswsOSDA4iJ5I8XtIuJEYnFnRGI1CJZgct9FDpHATgk4ZmNIt4mdMOGa6zHjozojg/sZPwV6FTtIP0IX8SLyxB/qnMl4y5JL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840126; c=relaxed/simple;
	bh=s+nXSf0HqOPzvWmykAMqvMprok3R5W6LYbexLVO41JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IU4D8/YR2s7Cg0Sp4O9swZs0lYWi+WV0VlJvcPtJpIxZoSBWIcWUF/lNJmz6FTL47+JwfiKdwIxiz/C5bhQtxGVHMTuiaKmvEj4RvAyEumJeuFaO/CeDX5qwE2PEcYlhRfbEEOJLuq82Qts1ATh5dKQ2jvskeBbcpWVjmMTEm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=LZAUu5DX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q8iozXUY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="LZAUu5DX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q8iozXUY"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8EF8611400C0;
	Tue, 13 Feb 2024 11:02:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Feb 2024 11:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707840123; x=1707926523; bh=dOzsJ8Wh+9lusbFV6e/lBsIiD4U3nOZc
	Nr/k4V87WHE=; b=LZAUu5DXp64ACvh3QGTdm9tV0JuOUp90BeF0SpqWoOtSuOgg
	694j/zMPUTJN+dZm1Gz6z8rik+G7P0gy72tiY/R4pI2auosYvKZGy2O3/E7jFF12
	+AN+DP8vSoJgNJyUDAC08joWAcPB9Uu265u5g0SMp0z3VKY+eNRiMyF1LjUN+43T
	JtYWac3PUxPZSOwXRhjLuIGjdCFkwPoHOb9fk/46G/FeATiUJZ3Bvt8JnFv9RTEE
	gan6+t+4soXx5hZdJHF8q7kCQ72ddHOCQ0ViQnit0FwCrUaDgvgLEBHED8MiDzsC
	qQnEBBi9cDKtWuU8II2xkK0GLYZ0o+ba8Vlzgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707840123; x=
	1707926523; bh=dOzsJ8Wh+9lusbFV6e/lBsIiD4U3nOZcNr/k4V87WHE=; b=q
	8iozXUY7CY5iquEnaKNzZQsu83HiiiTGm7yow1TJB6FW5nn4VFqq5FzdfNPc7ATK
	2u4YGEVm5Xr/hPHV+HM4GCfUMRlckXNjQMrdu6QBP4FuyHT1mU7RScGEPrsXxZuD
	54+JRIL2lDP2FjSmOkCgdmWO2VXdnFLFZ7HUFAES0dK72FXx0ojBQzW6Jo5t2H5F
	SDi6o/xIG+A1B/CIBU3IdVbXGOmaZjoOz1gXUgwD1RkmsgzDLMf9J209H7xo8hMN
	kL3FawWG8z+d2XGxuV52rC07K2zPj5LPBBbKsLA/GffgL+Uk/CwYY2OGneXWC534
	CvQTz8p+ld/Tl8WBQm5oQ==
X-ME-Sender: <xms:e5LLZXJJfiMMbiyXiQJxnIGlGFZeiW_FnhltW6qoLdAnj8IwShwC_m4>
    <xme:e5LLZbLNz2v0Vg4wlVBrLuwRZpyVEbq8VQh3SmTdouvK2bkPOF7UzQkney_Ttft1O
    TxcZ5GWdMULNv_d5Q>
X-ME-Received: <xmr:e5LLZfvYwI2Vp0AW9eOATufw8prnkoJ0xKbIwCj8dhOAYyLApCGysDEAXhr7LXUBKx0qlk7vHOn9K7S_MM-VKN84cyOUMgIDgFesVN2o5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddvleeg
    feekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:e5LLZQZRVZRObGGb9NCjwCraFFCBY_G_hlMr_SGwLFHSriOwvGD3PA>
    <xmx:e5LLZean6vDfh2BbamR3GDVVv1dIRoEjztGQG29GkzfZXzBrh9JTRg>
    <xmx:e5LLZUC9sCNZuxZ1f_Im35Eky-1euGwie_1x3qvab4DG45C08Z8jnQ>
    <xmx:e5LLZeGKO19BJQTRSn2f7VQXvsA9pT_j6rqKPegamc_rrHccPRVmWw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 11:02:02 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Tiago Pascoal <tiago@pascoal.net>
Subject: [PATCH v3 1/2] column: disallow negative padding
Date: Tue, 13 Feb 2024 17:01:20 +0100
Message-ID: <4cac42ca6f8ade5e0200b9f16f1627f0796411d1.1707839454.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707839454.git.code@khaugsbakk.name>
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name> <cover.1707839454.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A negative padding does not make sense and can cause errors in the
memory allocator since it’s interpreted as an unsigned integer.

Reported-by: Tiago Pascoal <tiago@pascoal.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/column.c  |  2 ++
 t/t9002-column.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/column.c b/builtin/column.c
index e80218f81f9..10ff7e01668 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -45,6 +45,8 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 	memset(&copts, 0, sizeof(copts));
 	copts.padding = 1;
 	argc = parse_options(argc, argv, prefix, options, builtin_column_usage, 0);
+	if (copts.padding < 0)
+		die(_("%s must be non-negative"), "--padding");
 	if (argc)
 		usage_with_options(builtin_column_usage, options);
 	if (real_command || command) {
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 348cc406582..d5b98e615bc 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -196,4 +196,15 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'padding must be non-negative' '
+	cat >input <<\EOF &&
+1 2 3 4 5 6
+EOF
+	cat >expected <<\EOF &&
+fatal: --padding must be non-negative
+EOF
+	test_must_fail git column --mode=column --padding=-1 <input >actual 2>&1 &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.43.0

