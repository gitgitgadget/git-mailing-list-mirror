Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C31DE3CF
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332177; cv=none; b=QYNAHOkNfQpfvjmY3s9F2SeNQCTZQSkDMMiMYDpNjEjrlQRPDxfKn5L9d0U8h/iU/VKDLgxzqjA14x16hCum6NfbyBgR6cUp+bGrPWXvJtqfMqClxo04qgndF5slSGJbMOpYFONa70WWh81icVl1Dzd+6SKxZzIvm6XyGP924Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332177; c=relaxed/simple;
	bh=v2oPXqCUSaDw0dUhszVT7zPZn/cDFezpWlCpatxfmBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg3S+7+pYeIdxC9WVf/RFxhLlp2q7Pak2SCYN92B1dn8FrhlcH3sPKzbX42GSe9arhDk3SH1pWh2bU6VnqmkuHs+eLI8tOAhVf8JiC14PyXif1y/PjqY3oa/G/gZ7k2Z5ZSrgwzW8MRkr17jD/JtXVCcCWcT6TTDCUsky2azQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=C8qcJ72a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aw/hUkql; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="C8qcJ72a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aw/hUkql"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AB6A31380368;
	Mon,  7 Oct 2024 16:16:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Oct 2024 16:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728332174; x=
	1728418574; bh=jC2O0LbeSTPcOj63eqniDkv6VS6eOP/ySgf9kZsmz60=; b=C
	8qcJ72aOFiYUUG52ghNnH9VCaXjHVF4lzr3QiB5/D5U7WsAkaQJ962J4FuR/eWPX
	wrBoeSwF/nOVxoOgPRBBFcmpvfkKtr7x/iG1h95NH3SoshkDL5bON7tvMj+9tnxh
	Q/PmwBFqhq8s2mR7RBT3yMX5NjQCB6QzgMrB6/biRRHXLxCWpD2amUITorAFFa7k
	CIQsCtPD0ZmCsH5QlSKHnx7oRFjPUmkabJusgK3oArsTvrKY1C9QoXTAXIHrcbRq
	4S+hJbP8xb9MpwUpI8RdYH/pRRyEH0Z/4PaxlJMVfX96e8RmqQPhQfDiiwLE+A7Z
	4N1syEBenblPbpCXAuVTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728332174; x=
	1728418574; bh=jC2O0LbeSTPcOj63eqniDkv6VS6eOP/ySgf9kZsmz60=; b=a
	w/hUkqlydg7TFdJhsDuSAs44ZIKfYwlVVNSOMlSUhGckVyOOXjOUrRvbJyONKTOs
	Mm6euhOcHGEH3k2EiJtzcq34yZRls88DsNfEIqDUMhvQbg3kT+rQjIg98vYe779d
	83uwj7CeWoEKc7bxUIZ2QYj63lODFgYfLi7gVjfqAMeeJ53r6ShjzIwSe/FppTei
	tz5WA61BaxPRUKtlAQ3aTyeu1I5X+2+Mbi12cRymaU8hO/QwgS+rN1KH1Wlh1aJ5
	kCQnTXKGIMmIu6KjaS9la7q143gDXex7L+2cJ4pZmcPg6QYdZ48LP4R6Sc4uKKe7
	XxhxqQSxjc+SryZeelwlg==
X-ME-Sender: <xms:jkEEZ0XOM0GZz7UKZmKQ46kLdRLCINabFuJQCDD4bAc7oHkvkNjrvXU>
    <xme:jkEEZ4nt8pNb3pYmyZ5gWVH-9nHn43iTeqnX-84lsHcOhMql7Qa4oDZPYTDz5-37E
    KE_p34bxSo88H3Blw>
X-ME-Received: <xmr:jkEEZ4aRhP-D4PfhYQBtuYDWOmZ5UQzsDlvJd2bCTxG7nrA9ZsJdNpV9za0SCS5AeQT0jT6Ab8V203BRx36Rz_guoaLkOfkKpAUFitowiYlw9MDJEi9bwyz5OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefhffetiedtgeejieeh
    tdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:jkEEZzXGm4aPgJbGvTl5rvCLegLKrCKIL9afKUjDSE-Sp1B0vxMfFA>
    <xmx:jkEEZ-nGhi_CTFHD2KPLqQ0ECwG65ePl3IQ6INXa77G81RA8SqXrxA>
    <xmx:jkEEZ4ejykAfn2IWVXLUNjctb9A0Ma3ln9Hr3OWEoEiqNz5ZLOGszg>
    <xmx:jkEEZwF8ROqHySEdOTVuVO73fyPEQD-iufoEyqHbnWZ2mV09NAD0GA>
    <xmx:jkEEZwhT25YQrsxjz08t4Ex1gm-3FTNPSeJLnChBcYIe6K3ZMkKmFZi4>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 16:16:13 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 1/3] object-name: fix whitespace
Date: Mon,  7 Oct 2024 22:15:17 +0200
Message-ID: <689eb69554480343b9f6db15ee6bef2c505717ad.1728331771.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728331771.git.code@khaugsbakk.name>
References: <cover.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 689eb69554480343b9f6db15ee6bef2c505717ad
Content-Transfer-Encoding: 8bit

Fix double newlines according to `clang format`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 object-name.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index c892fbe80aa..42e3ba4a77a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -482,7 +482,6 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		strbuf_addf(sb, _("%s blob"), hash);
 	}
 
-
 out:
 	/*
 	 * TRANSLATORS: This is line item of ambiguous object output
@@ -1965,7 +1964,6 @@ static void diagnose_invalid_index_path(struct repository *r,
 	strbuf_release(&fullname);
 }
 
-
 static char *resolve_relative_path(struct repository *r, const char *rel)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
-- 
2.46.1.641.g54e7913fcb6

