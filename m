Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C101E3DC0
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502955; cv=none; b=kkWuma1KiA4YqMw3Z5KNmq7oeydsqEvWk8tmPP1bIKtIGyaEkA6ckEy/p1HmzA0x+KvC64plDykZoz4aZKmLcUCelSXPGSoRKZwosdMGea+Ub6Pp2+RjW7+HdEuSKNdDAHV6cqA158eFRREfGpGJPMfzPyW1r7hwpN+QKS2kTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502955; c=relaxed/simple;
	bh=hcoeNWjAQzGT17gahS/yQSLjHK/OmG3PPhIXdKHmpZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ7mTjz9MJD56lXAmBd1BwAHNrefF1xj8n7YrhYDbQfynEQOWtMrjD+yaR+i+kiRMwkBSOYiUuNqKKdZHlYkyQ2CXyiA+I+IjhlRTMt8xLqU13s3MlwgXdHr4ZyocYfF6R7izMndkq1OVaempwW4iylMj6AWFW4/d9B4T2N88HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ijsevSHX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9RgFmFF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ijsevSHX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9RgFmFF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43D8F114022F;
	Mon, 21 Oct 2024 05:29:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 21 Oct 2024 05:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502953; x=1729589353; bh=wNu1S4W8az
	AR0pIdonZe+ztpXP0zj8p5X3TWbUA54D0=; b=ijsevSHXzogdCOhTl1f0D6PRFs
	JSkXPVnsSn9IFXlpT/qfUphvBVcOEcqgMCU+y6mwUXEqp4gHSEqbWmq3/SgJAd7+
	jaY3wWH8dlX2O1PtG9KZvXw5AlYxIizGdce3pHs65TUPVvByeWeb2dikd55/W4IO
	+CCm5XbdCPASTfINcHndZjI2cakq+FS9ptxKK2uCK2vo+tunyemrIXTzUL0VRBdy
	+wvI2dOGxM9pbrqjENZZwuxwLTS4uy7Yg16h4iLvoxUby/LuM9s52kq4esrsWkoN
	cK6hVyWGUog8BeqozjJ0jl54JPG3qYy/P0WrAHZmakE7AOeR/nZKztjrCsrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502953; x=1729589353; bh=wNu1S4W8azAR0pIdonZe+ztpXP0z
	j8p5X3TWbUA54D0=; b=l9RgFmFFZO9YvlGw41BayBJYyzwyqnb9CQPkjAG2cvl7
	+T7iTt9y8bxBE5vtc5ThXxW400Z3rmdsicyrlFZ4E8ma78IZgMCQ5DkO5ooKs5if
	Klju5I0G9dNgyh4DK4eO/XJK8CVrb9oGoVmkhESTOg/ocfCqwBbTLvdzaOPZDUP2
	V6JpP/ynJcgZYiXCFyPnsiGVlcr4TT4pHYu9s5BKiEyPRRu5Urb5cH6TGGeRZiIi
	q36lK7g7j1JeDipNGMsM+QFO3PwjEL1XZkYTR8QcEzsrFg8eSRghgwDIT/e+mCxo
	BFRTLWSWn8JAsyQx1ZGDSsub/2MqcNtRJMMZf+uELg==
X-ME-Sender: <xms:6R4WZwGwzx-Ba3FQJGybpDMoBavsp54Tz-ReBiuLm_7PZoWGSTQBhQ>
    <xme:6R4WZ5XycIqgUIpdsfHBDhEhTgpKDWwJ-ZnaIvT-b_DhGBdFuB_6Lp0DPRdjv2ab7
    TSnsV4YimVwH7eyYQ>
X-ME-Received: <xmr:6R4WZ6J_xTrbh9NyhTO95K7Dko11TJcx1b8bJPVb_0AzM-6CHR6MIGK4AdvZo7-ceWFQ45S_1IxvXGaF0z2ZhkyuBlWPe4hhGLPglhZZIbt6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6R4WZyFQ_uBJliDHkp0XwtCZL5Y9zQKN_yo28TeO70E4DxyUr_jr2g>
    <xmx:6R4WZ2WI9QCOP3t7AMILktq91oezDQnrfw7-ltObn0MNrXOffMNZdw>
    <xmx:6R4WZ1NtGNWTe70_k607o-JE9CpDkK0YKhg_wz_UcmdzFefIv4nf7g>
    <xmx:6R4WZ92vwOI1pngVlrl4lmM8FgemftKL2v-q-fkX7QwKtUH3xp-GUw>
    <xmx:6R4WZ0x98-rK2R9kRChp2iXY6EsnhEGbY46yW3XGP5rmNccBBCFloErx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:29:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cef469a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:45 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:29:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 22/22] list-objects-filter-options: work around reported
 leak on error
Message-ID: <b75376e3725bb22d0253792f586671975fa44cc0.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

This one is a little bit more curious. In t6112, we have a test that
exercises the `git rev-list --filter` option with invalid filters. We
execute git-rev-list(1) via `test_must_fail`, which means that we check
for leaks even though Git exits with an error code. This causes the
following leak:

    Direct leak of 27 byte(s) in 1 object(s) allocated from:
        #0 0x5555555e6946 in realloc.part.0 lsan_interceptors.cpp.o
        #1 0x5555558fb4b6 in xrealloc wrapper.c:137:8
        #2 0x5555558b6e06 in strbuf_grow strbuf.c:112:2
        #3 0x5555558b7550 in strbuf_add strbuf.c:311:2
        #4 0x5555557c1a88 in strbuf_addstr strbuf.h:310:2
        #5 0x5555557c1d4c in parse_list_objects_filter list-objects-filter-options.c:261:3
        #6 0x555555885ead in handle_revision_pseudo_opt revision.c:2899:3
        #7 0x555555884e20 in setup_revisions revision.c:3014:11
        #8 0x5555556c4b42 in cmd_rev_list builtin/rev-list.c:588:9
        #9 0x5555555ec5e3 in run_builtin git.c:483:11
        #10 0x5555555eb1e4 in handle_builtin git.c:749:13
        #11 0x5555555ec001 in run_argv git.c:819:4
        #12 0x5555555eaf94 in cmd_main git.c:954:19
        #13 0x5555556fd569 in main common-main.c:64:11
        #14 0x7ffff7ca714d in __libc_start_call_main (.../lib/libc.so.6+0x2a14d)
        #15 0x7ffff7ca7208 in __libc_start_main@GLIBC_2.2.5 (.../libc.so.6+0x2a208)
        #16 0x5555555ad064 in _start (git+0x59064)

This leak is valid, as we call `die()` and do not clean up the memory at
all. But what's curious is that this is the only leak reported, because
we don't clean up any other allocated memory, either, and I have no idea
why the leak sanitizer treats this buffer specially.

In any case, we can work around the leak by shuffling things around a
bit. Instead of calling `gently_parse_list_objects_filter()` and dying
after we have modified the filter spec, we simply do so beforehand. Like
this we don't allocate the buffer in the error case, which makes the
reported leak go away.

It's not pretty, but it manages to make t6112 leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter-options.c       | 17 +++++++----------
 t/t6112-rev-list-filters-objects.sh |  1 +
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 00611107d20..fa72e81e4ad 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -252,16 +252,14 @@ void parse_list_objects_filter(
 	const char *arg)
 {
 	struct strbuf errbuf = STRBUF_INIT;
-	int parse_error;
 
 	if (!filter_options->filter_spec.buf)
 		BUG("filter_options not properly initialized");
 
 	if (!filter_options->choice) {
+		if (gently_parse_list_objects_filter(filter_options, arg, &errbuf))
+			die("%s", errbuf.buf);
 		strbuf_addstr(&filter_options->filter_spec, arg);
-
-		parse_error = gently_parse_list_objects_filter(
-			filter_options, arg, &errbuf);
 	} else {
 		struct list_objects_filter_options *sub;
 
@@ -271,18 +269,17 @@ void parse_list_objects_filter(
 		 */
 		transform_to_combine_type(filter_options);
 
-		strbuf_addch(&filter_options->filter_spec, '+');
-		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 		sub = &filter_options->sub[filter_options->sub_nr - 1];
 
 		list_objects_filter_init(sub);
-		parse_error = gently_parse_list_objects_filter(sub, arg,
-							       &errbuf);
+		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
+			die("%s", errbuf.buf);
+
+		strbuf_addch(&filter_options->filter_spec, '+');
+		filter_spec_append_urlencode(filter_options, arg);
 	}
-	if (parse_error)
-		die("%s", errbuf.buf);
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0387f35a326..71e38491fa8 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -5,6 +5,7 @@ test_description='git rev-list using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test the blob:none filter.
-- 
2.47.0.72.gef8ce8f3d4.dirty

