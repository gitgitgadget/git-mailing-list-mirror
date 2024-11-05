Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E71D130F
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797945; cv=none; b=dpcoFrova+UA7tCXAvNBnwdLwCkKo85SmqsauMx/JhjslA7nxh1NBr4+4LObYfeQHR/crLir3mmZNFmNTQySjWHCgRd/ujcyX43T/Q2gT9owKfuL6Kv3mfSLT1mUUmBHnQ5XPx7LpetY7FT4emvP5xEcvetWcmDbrXqfbFxxN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797945; c=relaxed/simple;
	bh=MwuG9Y++PqKsmpjR180M01ALjXhKt5oEu3IuTRxhoSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOfLkqjh8WyPXa9gH+KcZDZkQjpJeazJbH0WUI/AwOTA734eA5Bw4LuN7xlT7SumU/3eZ52NvTH+w8Ix/2gfUm8cBDyVh4kZDqgoy8UvsXqqs4f2YniYxHcTebqUU8qpLC4qiKCZfZB+DwOXDfs2mx5jd9ekFrtqxbbjfNn0Tnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q6s3ooOk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OicCy2NG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q6s3ooOk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OicCy2NG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EC81254012F;
	Tue,  5 Nov 2024 04:12:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 05 Nov 2024 04:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797943; x=1730884343; bh=17eAGAH/p4
	ssliP6ERB4/x+Rr8CXigRxrcdDbXEB390=; b=q6s3ooOkORFkH0yQmwPsCtrKVw
	v1v5rPOiKv9Ea2FW175l+jCE3lFzcKm91GFUMOQ4sbZIsLvrVB9xifOAMIy38cEI
	oRISN9JCR/PSY0n77JzI7RzhJlAoPX2+VfViuBb/pb/1Ogz/ieHWgo2uVwWZ6Ks1
	qh4yMhNQ7bT7yltTgG+NSiceUpZtvR2K1Fc2W9XwwkA1a4O7wNFuQcRN8pvfhgeK
	SXKMR1MMpybckTmHmgdaxA5UwySgC36IObE/wQXyLoE3vnBOyN5J7fUEE4W9NcHt
	KkgCAPLECJnOQ7R9Ims0HpR7d0jO5LS50NepiAmx6kgQEYf7sFSRFv2dZuMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797943; x=1730884343; bh=17eAGAH/p4ssliP6ERB4/x+Rr8CXigRxrcd
	DbXEB390=; b=OicCy2NG/zvMRgH9dYbmvlWfor0SF7NznGQNcxli4GhGSLVzBwG
	TXdKQgAooV7bjPosmQxesBC40krxvzH33MmIdj7GmOkgq5CA0pj8yQBprdFbX/XN
	JeJbgpj51ZCDHH3fLeNLlgFv+DxyHuQURYcWy7bI8oArPYuvPw5nGknOMC/CzJbm
	Q7tvyZiAsWfpjUgMhhdRL5Zr9FFIu0RLJe22XNewWDF42gFSi0vRRf+exo+6lthG
	nVQ4d8V0NAbNNBbVf3cKRwERH+pwEfSmsS8KyNHiKFiErPkizeTk9y+NDRyxEVCg
	pyR36pEofqrMwp7DkH5MBvp6THPn2z9vXTQ==
X-ME-Sender: <xms:duEpZx3oNq2c2JDYJC-QKt3l2IpD5VkxZMQ1fztg7OwP9bFP5MqrVA>
    <xme:duEpZ4H-nH2GIxoia4cHWFhjbAUnAWP1Kvyoi2_JLY2xllfrtqjX7QEiYsqapQHnK
    njrN7VnInjOBKvvDQ>
X-ME-Received: <xmr:duEpZx6bzPwQOYaUWDqjYzj5Y7vL9fB_2xE21fY3I-RoSgbwpbH_JVWjOXz3SegriU6JwefDDmzdZx2InfBSpCqkSXykrKol1petJkKer65HDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:d-EpZ-1rBr8QqPZZ4tUQOP27eoIPHp-Zun2I5zmxS0VM27q3Oxka0g>
    <xmx:d-EpZ0Gmclsgugdiud8ZXu-CKf4wlFO08jJAn8R9Yv0v9LTjLXLw3A>
    <xmx:d-EpZ__LARS5ZAFT_jSVXeHNaZPm_3gcpG7uP7ps5t_zBKI7H-6mDQ>
    <xmx:d-EpZxmHvMVIF6z7NPXlTsI14v0y1Pd0ug49Y8OF2ACx9HDVqZdlAg>
    <xmx:d-EpZ5TaOSJd9zvRhP3e4op1DOtfnJnQMjefF72CcT8Q2smMF4wdH7U5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ca2b9d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:12:00 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] reftable/stack: add mechanism to notify callers on
 reload
Message-ID: <71ad6c80b0218cb61394fcaea8618ce888c505ab.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730792627.git.ps@pks.im>

Reftable stacks are reloaded in two cases:

  - When calling `reftable_stack_reload()`, if the stat-cache tells us
    that the stack has been modified.

  - When committing a reftable addition.

While callers can figure out the second case, they do not have a
mechanism to figure out whether `reftable_stack_reload()` led to an
actual reload of the on-disk data. All they can do is thus to assume
that data is always being reloaded in that case.

Improve the situation by introducing a new `on_reload()` callback to the
reftable options. If provided, the function will be invoked every time
the stack has indeed been reloaded. This allows callers to invalidate
data that depends on the current stack data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h | 9 +++++++++
 reftable/stack.c           | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index c85ef5a5bd..5f9afa620b 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -68,6 +68,15 @@ struct reftable_write_options {
 	 * fsync(3P) when unset.
 	 */
 	int (*fsync)(int fd);
+
+	/*
+	 * Callback function to execute whenever the stack is being reloaded.
+	 * This can be used e.g. to discard cached information that relies on
+	 * the old stack's data. The payload data will be passed as argument to
+	 * the callback.
+	 */
+	void (*on_reload)(void *payload);
+	void *on_reload_payload;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index d97b64a40d..5384ca9de0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -548,6 +548,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 	free_names(names);
 	free_names(names_after);
+
+	if (st->opts.on_reload)
+		st->opts.on_reload(st->opts.on_reload_payload);
+
 	return err;
 }
 
-- 
2.47.0.229.g8f8d6eee53.dirty

