Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683F69DF3
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708260172; cv=none; b=oCF8zjqEj2Mi+gaf0mTGegQupZIFvgbrWoSDZKwbgbZ62XgW7ryMqzxjU8I/R7lDwBIP5A7XMwyaN/U+3G3xMODOPFjqvo4Kw4m1m0EIWt7FNf6w4xYmgW5Nrg1U3CoFgVz5QQ1hG7i9rA/nicMiPbuNnzdQSJcHY45VPoGemL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708260172; c=relaxed/simple;
	bh=SujaSRuNe8O+QmEWHLS3aV8yrosJQkDy+iIpKS++Xt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORZhezK4iaeJyh21iQ1jAiPOM58il45wQl0qcNVQQkLULsjA6/b5FTFle1iwA0kZVB4vARfMrUfHcfm6/WcJEn2hwC93FgLPetDUar7UD4hEypOlq1GJUYHV0MjRzvdUpr7hz8j2Gysfb/uQJCElKRS77RSqcuBubhSjFSWgNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=zEM634Vi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PwCrA00w; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="zEM634Vi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwCrA00w"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 717475C0037;
	Sun, 18 Feb 2024 07:42:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 18 Feb 2024 07:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708260168; x=1708346568; bh=RkNN+Wu923kDwWOMqqZM+CaewUSby7yJ
	M/2XaUIjF3E=; b=zEM634Viwn3ZwXmSzAuzmDStfEAwAEEcavupYLZpKhC3hyXn
	AXWJXdSdCRJA9ULMAy36+B9QZwFirjMZMWGzIXLchJrBU+1wwhf+BzTBjGYB45gj
	s8GlDAiMNcO1wFDCGXkg+gc5KK3FHm6Ck1MRKVm8pT4bZck/x16OxpQrF10iC/3R
	yg9Gemw1URcZZtxQUKWw1yZNhKpGJJMxiEq2f1m4vuGJm9otZsm06ZKmvgCrHe/4
	mfnOYZslFcWch1tJo9xgjku9LQ2fcNj7TGJH6ilvohyFWzQzyaApIbBx9yX281Ar
	ROF7qwhbCwN6O5+Oz5rm2PtMcipVZBWCeR2Q/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708260168; x=
	1708346568; bh=RkNN+Wu923kDwWOMqqZM+CaewUSby7yJM/2XaUIjF3E=; b=P
	wCrA00wCkpEaBUQqHaTmdf738Orz72mVAJruwa2yUVdUk7ZmOP3TeufWNlI5ta2w
	6D2pNmcpqXMeQd9XSBcaCB9myn8fJu8iVtObL9m6l8NpLejEBNIjX5CfYST4siwc
	wnFzDIbxQT3FK7axraiTnRtZ7dNgmPN2P4VsdJYFUrD4wJ5QaqKAbD7bHNXyP4ZA
	6EITvy6q7cIUIG4e5Me0jPL/5zBKevCyH0XvoRWOUZJJWwBkToREc1KnYUBydtx0
	IWxOewRIC7u/LH2GowfMjKaPfougzEXCS8IMeSmvLGeCf8SfVFv2fQljSKOc7W5e
	bdcQ082QZJEwmK7Zho7PQ==
X-ME-Sender: <xms:SPvRZR1Od1-AwPvrInLLkHwNIkhvqQSRsBRe7J3k14moPH4WN0Nt9Wc>
    <xme:SPvRZYFsrEamjkI_oYF5Ba-qdeZRr22zNDgrG1GWKTdEtGI66xG9jTQm5zH39_aol
    RK-WJLmEVhvFeRP4Q>
X-ME-Received: <xmr:SPvRZR5xMt3r3SDnLQFpv1H2tasiOTXB7OpDFFkINc-9TbJaXSnO9UNR83d1ABz3U18lbhJ_X-cIwcyUClSiCUn0dFqI_zEDlT3Fm8aGM5J6f22s-Ejj78VR5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddvleeg
    feekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:SPvRZe2JphBieY6fGBhr4rAdy7gfK7XAplX90wtAZDKw9DTZlV-Hug>
    <xmx:SPvRZUFsk5-C9CS5NCyOW4CA_t23eRUOipLT4N7CfhhuMYz85ZWPXg>
    <xmx:SPvRZf8Z2g9FJJPqc2Xr341zvxBFNKw-FMaTB4EY6JuDItO5NA2KGw>
    <xmx:SPvRZYAgxokpX3p9fXPCyRM2ixD-STNi_UZRwba0fIy8uRoc0pce_A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Feb 2024 07:42:46 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [BUG] mv: can trigger assertion failure with three parameters (builtin/mv.c:481)
Date: Sun, 18 Feb 2024 13:42:27 +0100
Message-ID: <ce1b5ae24ed8356b9beed340fff61e96f7c1d549.1708259215.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com>
References: <d1f739fe-b28e-451f-9e01-3d2e24a0fe0d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here’s a failing test. This fails on top of `master` (3e0d3cd5c7 (Merge branch
'jx/dirstat-parseopt-help', 2024-02-15)).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

-- >8 --
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 879a6dce601..4f180903486 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -549,4 +549,16 @@ test_expect_success 'moving nested submodules' '
 	git status
 '
 
+test_expect_success '(TODO title) nonsense move' '
+	test_when_finished git reset --hard HEAD &&
+	git reset --hard HEAD &&
+	mkdir -p a &&
+	mkdir -p b &&
+	>a/a.txt &&
+	git add a/a.txt &&
+	test_must_fail git mv a/a.txt a b &&
+	git status --porcelain >actual &&
+	grep "^A[ ]*a/a.txt$" actual
+'
+
 test_done
