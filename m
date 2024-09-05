Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C37199E8C
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530981; cv=none; b=Z2n2OTY+Vhgg6v87NkFrlY50D0GEVE1B/UQkvADO3kJkIseIIrv0YKExTxTksfJsTMzmP2wGdcEBRiCXViGXkC0lWySom8NzpYdWBUuQVDplhzxFfjTRQtvB29jMBt6amUnP0DUm8udb26eLNSRWhj9ydl9QZ+Jy1iy9jzWtfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530981; c=relaxed/simple;
	bh=7r09tD4qMGzpy8PCSDkBIgsA6FB6B9+FSmPT2/vxRtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9i/IHWpGusYF/fH6wv9gTUNzD+CkvBchYygHF7uoie9bj4bANIUUc4AELbxE5QNvBkuwqjhdFrG8oZOk+g5KuNBDbME/DNjVqK5wF7htaXhsJ98EIUve0SYHBqpzCrvojlqwrkvbqDEBc16itLrhPJUgoIbLpxaYpMvG7DwpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yymfqb33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFDGGAZu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yymfqb33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFDGGAZu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B57CE11400DB;
	Thu,  5 Sep 2024 06:09:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 06:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530979; x=1725617379; bh=qmmRH7YJtK
	bQzbOt3DlvUpBeo6T0bXWs3IieHCAb4dA=; b=Yymfqb33xNRMpfLl6bLFODq9se
	jJN/8WCA4Pl1cKLy+KJSJTNA8FZTBUKgCKjKb2dZeYNeLx20ax+sq50kkX3lVSCM
	R02atni64mBPXjWVCvAgvXcCkeFXGHkuh7Sqkj0M2XHKnG1y6NCUGFmmmYMc/kJo
	HOOZmgEQEuvP+/P4mxlMSz/fKks8jidkp17DMS7q3hbwUTry395cZGRhUCON6T+B
	Xt4isRvq/mmZOq3iJicX1HpnGnieszJA3rME3DNjH+dy/JcRxMcH6FXKxFfLMuWv
	j/Eemc9Yi9prOWupbvR/4t1ATYgz0pdn18Ce5po2/HCtQlIquwBxHyRRplBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530979; x=1725617379; bh=qmmRH7YJtKbQzbOt3DlvUpBeo6T0
	bXWs3IieHCAb4dA=; b=UFDGGAZuLwmkTQvCHzSJR8zGXepNFeNp3pmBV2ADgP9b
	1Gn+9xcCDInUhbXm8+JmhwsX1rZNrl9Rmpz1pUeAPM59aoDTK8ezeic9oLmtGa4T
	ao7X4MZjmyXshYROrCwiOjRDgHf7W76MR99v9zJdP1mC4rRSn/uOBdH3fdL/sVgj
	iv9gsfjHkYXsfUMOdAvq4Iq3ExCy1HC6dRQ+C/wNZsx35X2OEYbvgRPwzb+lPaQX
	HKUbcBm3HQvE6LQtUsfSdswxeMXRjNhGa6sFmttDy7X5sJ/U04gxZ19D2QjnUdtC
	H+WpV+hrCzYWHAfzhme6whH/qkq/K+ECAU7z4VENVw==
X-ME-Sender: <xms:Y4PZZiwGFwJ3m36AR-4PSN0F2VNIZxe6EEBlhgyuNN_kJHsQK5XELQ>
    <xme:Y4PZZuRE37MvR6pnac_IqRCb9XcY-0PNK2zrMMYfWvwqe1CBthxHHj0b8WS9b90vW
    CBir0J6vyIpNkRvGA>
X-ME-Received: <xmr:Y4PZZkWFhV9d6IQhTeqUnGjAusJbJKrntyoKuzAU1lCw76X68MNSSNjy2WMYVFiVeTA8SNca08qI8T99LHIDwXd3NegOB9Pl4J_LMRlieghRrt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Y4PZZogoFZjXWDEFd2DcLok6pUR6rTf73e6XT40_wOPTB3O3Wox0Og>
    <xmx:Y4PZZkA2EE0Z_Le6v8k7g--6eM_lUz5UtLzGBw3w5R1ZQlcEjg89OA>
    <xmx:Y4PZZpI1i2R-BfvGSlEnkwz1Vokw8XkgZAoxjYNGAmWBPsMIinVf1g>
    <xmx:Y4PZZrCMnFJ7wGHQcZYkdg3fGEo9_SAwF0oiZRg5SdQzGWDnsHzLfQ>
    <xmx:Y4PZZm1OQq1DOYjroaqEVXelz4YXj_4uPpdgoyC2XxdyPDTY5uS8RFet>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca18b1db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:27 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 20/22] match-trees: fix leaking prefixes in `shift_tree()`
Message-ID: <bbb8ab2022968c4f195d21d307da754f561aaa98.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

In `shift_tree()` we allocate two empty strings that we end up
passing to `match_trees()`. If that function finds a better match it
will update these pointers to point to a newly allocated strings,
freeing the old strings. We never free the final results though, neither
the ones we have allocated ourselves, nor the one that `match_trees()`
might've returned to us.

Fix the resulting memory leaks by creating a common exit path where we
free them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 match-trees.c            | 10 +++++++---
 t/t6409-merge-subtree.sh |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index f17c74d483f..147b03abf18 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -294,18 +294,22 @@ void shift_tree(struct repository *r,
 		unsigned short mode;
 
 		if (!*del_prefix)
-			return;
+			goto out;
 
 		if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
-		return;
+		goto out;
 	}
 
 	if (!*add_prefix)
-		return;
+		goto out;
 
 	splice_tree(hash1, add_prefix, hash2, shifted);
+
+out:
+	free(add_prefix);
+	free(del_prefix);
 }
 
 /*
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index e9ba6f1690d..528615b981f 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -5,6 +5,7 @@ test_description='subtree merge strategy'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.519.g2e7b89e038.dirty

