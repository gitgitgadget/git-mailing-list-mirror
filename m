Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956121A263D
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140614; cv=none; b=gC1sRo7xy3sgesaPxdtGq9mDPSduXolb74ioZVZW2CUerjCNKx4vJSIcsGoKlGfKUHWNFIvt3WKiczWKARctN1A6T5l9n1F6pca22wQ2Svji7eVziFTqYo0Q2XfYZE34Da4DG2BwfJ20ICmcPxTK0UJl0Hy8WuHRXq4JVXRv7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140614; c=relaxed/simple;
	bh=88SbeCqApX45rQ3RZAh/I5IrE3IvTJaLrEYIUacKOqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq7uhU++OsVhYRZhnqwz5qOgEhqd/GSyO9xU4FR9ciCQTJrwc7xMIad/zIj93UF8g2DlDjrKHR4IjixQneKQICX4lj+HUY1faFP8AG0to2rsaZv5Gfswv6OMd5UswHUSmeig1cs2iPaw1NW3CxbfaMhzYhtSY+jaOwRyvNIwGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jc1a86vF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oH2IMKCo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jc1a86vF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oH2IMKCo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1DFE11405E4;
	Thu, 12 Sep 2024 07:30:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Sep 2024 07:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140611; x=1726227011; bh=MTGTmJQn5Q
	X6DO1eRUTtpUG/N4CjXwh+4KeeFekBdhE=; b=jc1a86vF/6p27HF78citG5g9uq
	Vkt5YpjCEsAyN2MobOOZplqmwUq+1Lex7LLS/ucrVRM/2Snt+wZZgg6/9UNqUJbA
	+UVLh6BqEvGD39rEZZyNyd9aIJE08dZ1Bya6VQqA+FGSTd0zZORlLw/rN9tDStUD
	zMKmYgQINU2NG3hMIqIz4x9svpIoRLYV2rR3+yMb7CzQa6VP7aBhzG1oM5a1FpIp
	mo3vVFeM/IunDqPBaSNa1KO3o+b+45LT+soP4dxYdTGWRa3F7w+AfHTlUVBYxxSs
	krJoZAaEkMC+ekCa3xhzeaxAUOnWZHy+AfNWrDtHglAALtdRat7ZS2Pzcmkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140611; x=1726227011; bh=MTGTmJQn5QX6DO1eRUTtpUG/N4Cj
	Xwh+4KeeFekBdhE=; b=oH2IMKCojlEANfobqyYwcvMP/ojdacJCyZcnalzUQk2w
	mXZbplK0q7qVFdM2a65WYtj2OqB9/YdASuXA0XBkzR2hqsvpvF4X8Md1XMUOYhua
	egtS5nsYJa68eRn7C7d6XgmVkCrp/9viOjQejJJg6Ejt84X/dRcyqdZTEUQR/Say
	RUD69DL7ueGl+7R01b1dDmtuULR9ZD0N3seDOcGLpp9NF0QAtqy0ac/nkM7FxuVa
	s3PVaR1uofO7nTSNO2RzeVt7Ds35DFhv2bdfIFzvTe4z+3ayrL46/UyFl+XgcqHu
	6nEpeLLq390g6Mn9YVZG0aXvOpupMoNp4eizJZbkQA==
X-ME-Sender: <xms:w9DiZvwLrSqs0FjpfaMmR96Lagc1bkl189EkvXfU4mr5BJfyXCNVFQ>
    <xme:w9DiZnSeuIATjUNo5rYQI9m1TzZSb_pitArhC6l8WMuQNq9OzaLey7Oi8E8mXcCOf
    I18Y_9xVvTnJnhM4g>
X-ME-Received: <xmr:w9DiZpUHSE_icqnpaPwQQqFhhU2fXa1V0-_akZ75vA2cjgXPft7ZUc4voLJuGwZnTSr8K_VvjsLXrUUW26G-Qryy2mZkHGl70jWZ49I35V5y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:w9DiZpiEuvA7cEBfwxieoJ-Hhw9MsyRTHqwdsvMQkzL7fmp0gmQhUg>
    <xmx:w9DiZhDJ7lrYc5vopkbsNUombf00ZaLCsSSbZ_m3zJblWQbB9HMCpw>
    <xmx:w9DiZiKY9vu8djXDg4hENiPulFp4zSdmpoLHbXB7HfJTZ5_h-PmNDQ>
    <xmx:w9DiZgDkogIoV2YoN8PKPTnp6UGXfa4Rh5akIOJmTwY_YSO5EiTocg>
    <xmx:w9DiZk5SRtqW1sbMBGKkc_uBi1_VCVXJpRf__89HQXGF7hxo1-Luw4Z9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c764d33c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:30:01 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 16/21] branch: stop modifying `log_all_ref_updates`
 variable
Message-ID: <b5f3bf5cd25817fdba8f47a415462af6c07fc2b9.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

In "branch.c" we modify the global `log_all_ref_updates` variable to
force creation of a reflog entry. Modifying global state like this is
discouraged, as it may have all kinds of consequences in other places of
our codebase.

Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag
instead. Setting this flag has a stronger meaning than setting the
config to `LOG_REFS_NORMAL`:

  - `LOG_REFS_NORMAL` will ask us to only create reflog entries for
    preexisting reflogs or branches, remote refs, note refs and HEAD.

  - `REF_FORCE_CREATE_REFLOG` will unconditionally create a reflog and
    is thus equivalent to `LOG_REFS_ALWAYS`.

But as we are in `create_branch()` and thus do not have to worry about
arbitrary references, but only about branches, `LOG_REFS_NORMAL` and
`LOG_REFS_ALWAYS` are indeed equivalent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index c887ea21514..08fa4094d2b 100644
--- a/branch.c
+++ b/branch.c
@@ -601,6 +601,7 @@ void create_branch(struct repository *r,
 	int forcing = 0;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int flags = 0;
 	char *msg;
 
 	if (track == BRANCH_TRACK_OVERRIDE)
@@ -619,7 +620,7 @@ void create_branch(struct repository *r,
 		goto cleanup;
 
 	if (reflog)
-		log_all_ref_updates = LOG_REFS_NORMAL;
+		flags |= REF_FORCE_CREATE_REFLOG;
 
 	if (forcing)
 		msg = xstrfmt("branch: Reset to %s", start_name);
@@ -630,7 +631,7 @@ void create_branch(struct repository *r,
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
-					NULL, NULL, 0, msg, &err) ||
+					NULL, NULL, flags, msg, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
-- 
2.46.0.551.gc5ee8f2d1c.dirty

