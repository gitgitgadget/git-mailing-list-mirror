Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB8189521
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422357; cv=none; b=VrGayF2MPSbQSAZovYg4g4k+DfpV2A9nquZUHWpn91ueUUltVjdH5k1JAyucDpaVMGwR0VxmRh5I+fZDb2vrOk5OsLbmRmM9nv6XgIgv8gQx6pnUaSB0OdpRazmffEU3PqRk1fZ/NgmI+zSryR2aVYvI1gaP53JrV7l0yTyhiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422357; c=relaxed/simple;
	bh=ldtUrMemno6DYaGxJNd1d4lTu6bzZSdyz/i2l1NdJbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlsapiFfOhwe85EDZA5WhF91/1agwL1QQEbfrQmJu3OfUkV3Hi42A/SOWGCAe39lgUdbnCtd+YJZbVkOHnwErlleQGAuxduAWj8O46FaOpQTLNQ7aBSA54Ida6CftqBNs4VM5fU4A8LdCNfoOWXG5AKfr9KGtNvnoj6izhWEiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TvoAEGgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYGY48Rb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TvoAEGgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYGY48Rb"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7659E138FFCB;
	Fri, 23 Aug 2024 10:12:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Aug 2024 10:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422354; x=1724508754; bh=HFfoI+cj3M
	N+A52EBzM78o6HUx3a1PkzzTk021v3CHk=; b=TvoAEGgTGgnQI3aBTvvMYQ1Pbw
	5fWFakVNxAPL6KpD8STOzq4inLE3yqfJxehlAF4eRKZA9htMJ2V8/+i6ZhsURXj8
	EQaYznJGd6iXUB85y6vY3WmZPA3dqzNpWOq+jfwN+bHOmrdPxS0WBz9CScEin4aU
	oeEyNfWm0Hhb8Co1eH5jA0V9qeAFPg23KRWBS58VuPh+HcamyDlF5YkCQ/rqaazU
	4dTVjNePOl2HA3mKK3xjm/viDPNzO45JMjdPzKT7jFzEY9s8ByWbnOudtw/yL7bf
	ODSFprIdYviuXEyY/BpBKUVVKgGQrdE4lqYKMzIjv2ys/tkhsXvG5mKtP/ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422354; x=1724508754; bh=HFfoI+cj3MN+A52EBzM78o6HUx3a
	1PkzzTk021v3CHk=; b=gYGY48Rbq/3wMZhB5TNq9GOj7OPbu/IxgTi0y3rmQzNX
	NP+r1PGP1nmKZELTgvxtN6zzHYipGLPd+aWF00XPcvu/37lRg9a/6tewYhwDq1bI
	gYqkP3755S0G1JfOnIgGsOfqirJCZaOsLD3D7VeL6oH+0OvXt/QZhoEK136oA5Rp
	OsqJj2kr4GoxdKD1JhJpAewJc63cIl6wfMXU/9HhuBsdtQBjCVS4X2glguVpESqY
	aTAn/E4FREvCju1Wr7vioHGxCSR2M1xjrqxNR4takikC0KeN5Z4ZJNhUtsItiUCs
	VOGALQ7Xf4GrkJuHwkxTRk8/RGmNwf9mEwaub7IxTg==
X-ME-Sender: <xms:0pjIZhvC-817K4Le75a3yfsFORpTiSAJmyrcWgQ_Y6EcLy5p2OCLvg>
    <xme:0pjIZqcDcIfuSoRVbcRlgzGuAB7BH81ocMob0JQbi_wwNGZ85_1IET1g53179ZnOi
    X8OFunJUfvvqeh70w>
X-ME-Received: <xmr:0pjIZkzwTXVM62mv0mURIQd7gyK-cZ9dHT-aY7E8yit5bJw8Atozh2iauInEDShKE61PywUG47YfYWyUQJqYvXVoDKp_PL9816gNx13xOUw6fNptEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:0pjIZoMEB6vcgiPGJyMCc1FsvZMFyVU-0QhNZKnmitUsk2VR6uyzIw>
    <xmx:0pjIZh9iEh-Bozyr9tTvPvKMd3S4c_n4iDwGq4oag5YUFTJ0hF4Mlg>
    <xmx:0pjIZoU9dpYdQl98cFWDImM-1EHBbz7U8AShqFE0E7FjHlIhhzYuqA>
    <xmx:0pjIZidB18qa011c38-7d3lH-g2pLuI0wK6xOooC48NmA-eS3KMJnQ>
    <xmx:0pjIZtYty8-A8sNJ9c768SaHpNNcS-kK5SOe3Ar_nZoFQ-6x7QlBM4WA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9204415d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:11:56 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/10] reftable/stack: inline `stack_compact_range_stats()`
Message-ID: <3c0cf2bf46f4106d7c0b30c863946262639b2351.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

The only difference between `stack_compact_range_stats()` and
`stack_compact_range()` is that the former updates stats on failure,
whereas the latter doesn't. There are no callers anymore that do not
want their stats updated though, making the indirection unnecessary.

Inline the stat updates into `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index d3a95d2f1d7..891ea971b72 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1328,17 +1328,9 @@ static int stack_compact_range(struct reftable_stack *st,
 	strbuf_release(&table_name);
 	free_names(names);
 
-	return err;
-}
-
-static int stack_compact_range_stats(struct reftable_stack *st,
-				     size_t first, size_t last,
-				     struct reftable_log_expiry_config *config,
-				     unsigned int flags)
-{
-	int err = stack_compact_range(st, first, last, config, flags);
 	if (err == REFTABLE_LOCK_ERROR)
 		st->stats.failures++;
+
 	return err;
 }
 
@@ -1346,7 +1338,7 @@ int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config)
 {
 	size_t last = st->merged->readers_len ? st->merged->readers_len - 1 : 0;
-	return stack_compact_range_stats(st, 0, last, config, 0);
+	return stack_compact_range(st, 0, last, config, 0);
 }
 
 static int segment_size(struct segment *s)
@@ -1452,8 +1444,8 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 					   st->opts.auto_compaction_factor);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
-		return stack_compact_range_stats(st, seg.start, seg.end - 1,
-						 NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
+		return stack_compact_range(st, seg.start, seg.end - 1,
+					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
 
 	return 0;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

