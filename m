Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C59184521
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540448; cv=none; b=EBvXhz3JC2Xzwu+J8DHEcbCH0Hsj8RTWkcJqYcekNnlkn2KhRoJn4G1+z5ociR/pRgSrs1TYGSzLP80+ejDNpG7fraTqa+gN/FIAmOXUlqnu7kKVMIOkJvobfGSKjyTziq4xhQH8QReQO0/Xc1bslXC5TCPrqk/upTlPNNu6z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540448; c=relaxed/simple;
	bh=Y8w+L/kVPeGpJYAoD7+TQpwCcWhYaTKygaRpBCibwr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxW8UCYi6P8g6Ru8zJ6jU1Wa/D6J7aA9flCmPmeS2g9UNOULhXOxC2C4LqYeqqexuKYSOAo02+AljiU63e4m94CJnU5bEnHlTk5BD4ePUnB3SBxxu2Y8TVSC3493yEyM7FiBHM4VyIAp4neDV4QbOldkepAHzs2wsHJC1biRlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZwHJ1t6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJ/NUtSH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZwHJ1t6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJ/NUtSH"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7629011519E2;
	Tue, 13 Aug 2024 05:14:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 05:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540446; x=1723626846; bh=qIIew3FqMY
	ULj44Kxta8S0flgiz169fjtM7TNReBSE8=; b=ZwHJ1t6nVdA3VV0u6UgVcHQxFN
	bIkS+oZuf+b9Dri/AfBdrnvvhGcMrk7a71hZz3N2GSObXWAtRhYUCDeGnLBL3XXc
	H82viSTO/1zp8+wnhU9TvcYxaX5BLP4Xn7izrFpAliaJOA78gzO8p77eB+Y/gU3a
	mQJos9BE+aCr+fk3OTIU/8U0H8Jq2xXsLJ3mS17ZSo1MBcDs1HndD1qXBnlAKAj4
	GCXHepdsiBq3gvp3lbqeIOSsk6z9zL7SoBBD4R51sIBiCGSdK4TxG3rnKKuw3BnL
	PjPRNZS7gH0kPwFS1iNb3qBEFnurLuyokNlis69vG/8nbPIFCKxUfVXKYs3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540446; x=1723626846; bh=qIIew3FqMYULj44Kxta8S0flgiz1
	69fjtM7TNReBSE8=; b=eJ/NUtSHDJSoUPWlAYQYs1u56iBQF11oVJUGFctMgV0A
	V2S0eIvoH//xC+Xioyy9kGr5r7kIoibo4M4Qp8Q+AURLgtcuk8U7PHHfKgN+JuCt
	Vsa/D9OyY0oAPrD/ywHZUy3kLgqwx0G06ajGJ5MZZR4ddj9GV4mpOW9oUwN0KJab
	m4nFu83Mv634wqtoc67mDbp7cerxcEaepy+jZS78iWx+ir/8UatmWW/cbpNpL/1a
	QWuxBj3NQpJHHhxJnjcHYc2N25aOPxNMwAxJFCzfwj5KfgMqNIR8EvBIbSYkGgxs
	YnoJtKiRP+PQJyUzF+r0L/AUaX22Op33ddjt1ewY8w==
X-ME-Sender: <xms:3iO7ZnXz9ZCM_m8fWtXDuPsTGXpSRgS7c5TdDu1_G2QN21DadFweRQ>
    <xme:3iO7ZvniRd8XXGe0hdFPtSJqmtPlk0lZVZKySyHERPmJtyV65ifirlFvNO_Zap3Cj
    V9Ss8hBXexHr4eD1A>
X-ME-Received: <xmr:3iO7Zjaymf0-mb4lT3EwSOuJbRSvRMDc9SQR2KOg3MVPQCYCUd7yAr0Xlp2or8L7R2E1MQzgNvDYjzoUvTuEuzPvigP0J-42r-ZdakAxE2w0hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3iO7ZiXROHMI-xO7KloZg26hA-OKyhnSAo8bdzrtP7a__1ckl4Y2Fw>
    <xmx:3iO7ZhkPeDtoKDdZUc1d8DVvA3nZA2hpkSYmck8a7UYDDYxuMFDE6Q>
    <xmx:3iO7Zvd_oUmu_coXqAuLkUdUEkcXi3r3e8K3DTr6kAr8u4FIFJaLbQ>
    <xmx:3iO7ZrH3DA9YX5Cz1l0hs6Y364wqXmodZe0xEgy7Ws_URPOITjO8yw>
    <xmx:3iO7ZnhNp5mGlqf-gS196bRQXaA708d9yqkJOO7tRGDlNUKtIshluMEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f93f7f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:49 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/20] config: pass repo to
 `git_config_get_expiry_in_days()`
Message-ID: <111f77e653a2f67e4f315ba553d65155bbc75066.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

Refactor `git_config_get_expiry_in_days()` to accept a `struct
repository` such that we can get rid of the implicit dependency on
`the_repository`. Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 5 +++--
 config.h | 3 ++-
 rerere.c | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 4138dc50ce..33d9af29c8 100644
--- a/config.c
+++ b/config.c
@@ -2779,13 +2779,14 @@ int repo_config_get_expiry(struct repository *r, const char *key, const char **o
 	return ret;
 }
 
-int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestamp_t now)
+int repo_config_get_expiry_in_days(struct repository *r, const char *key,
+				   timestamp_t *expiry, timestamp_t now)
 {
 	const char *expiry_string;
 	intmax_t days;
 	timestamp_t when;
 
-	if (git_config_get_string_tmp(key, &expiry_string))
+	if (repo_config_get_string_tmp(r, key, &expiry_string))
 		return 1; /* no such thing */
 
 	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
diff --git a/config.h b/config.h
index 7674617a1d..3a5016afea 100644
--- a/config.h
+++ b/config.h
@@ -718,7 +718,8 @@ int repo_config_get_max_percent_split_change(struct repository *r);
 int repo_config_get_expiry(struct repository *r, const char *key, const char **output);
 
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
-int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
+int repo_config_get_expiry_in_days(struct repository *r, const char *key,
+				   timestamp_t *, timestamp_t now);
 
 /**
  * First prints the error message specified by the caller in `err` and then
diff --git a/rerere.c b/rerere.c
index 3a3888cce2..578a4fe378 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1203,8 +1203,10 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	if (setup_rerere(r, rr, 0) < 0)
 		return;
 
-	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
-	git_config_get_expiry_in_days("gc.rerereunresolved", &cutoff_noresolve, now);
+	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
+				       &cutoff_resolve, now);
+	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
+				       &cutoff_noresolve, now);
 	git_config(git_default_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
-- 
2.46.0.46.g406f326d27.dirty

