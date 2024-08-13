Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC0189533
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541538; cv=none; b=olFSR/TsfucfMAZn1D8bvIGq1MpA4wpDChUBqpFDL7yV7CIMs2BMdqC01YwG4jLU0lMEskGCnUHIP0TPRa8wnjg5X7XbKbZWAFJSzBC7zyZ6/DzPx7fPy6br1/fLdZjWJ70cC5N3mC//73uQqZZNG1p6kk9B2VNpDzBDKAJdIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541538; c=relaxed/simple;
	bh=bvWcGfcSixWsFSNcgd9tHk8PRZAxdnx8ad846E7MxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg4vFqwKZt9peL/9d6dKpK5QP577ZKpL3o2KJV0HSKgv6xQVjWi/9ZcRR6/hTD8mlkPZBMqj9mOkP++fzbBAejUva1eLnjJLCUKrca/BA8qgSMqTvVD3JumU+geUCQZ2RL6EOYexvkKUoxJzreQWJeTSFTxEBLY3paePgsnJGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lAkAS1lX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Go5y9JHS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lAkAS1lX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Go5y9JHS"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA56D138FD93;
	Tue, 13 Aug 2024 05:32:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541536; x=1723627936; bh=1wPwXeOjBn
	5/xJdtr8fUs0WTFnPMLFaLxNRBCAIJRNk=; b=lAkAS1lXYI8hJEovYMQXEvg3Ti
	uPOlD/iLaoz26t+PahA3QFtndIb/9Tl0PUjuM+RpXQanBwicB/cY3AGG14jv0B74
	xbYdmBPel3Gx3YczY3dXid6a/Z+ejkWJHmTDBSvl91rgBvXetJBucbxjFQD/xW7+
	lWMf03BroXihu4YVntySlpcYMOmaKoCHwXCDE6xz14EiXISkPAH40raUCmvewScD
	Zyj9IOh9ButmHmRxtlwtD77B/Vxu3yoaZsGsUEjTE/nFJt5FG9v+FqmNQfdTdPJa
	cwHAR/elXU1GXrpdnaqyJWQoUY+LRbEOhCaVMpcYTBEoXsr3f/7tKlsEolfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541536; x=1723627936; bh=1wPwXeOjBn5/xJdtr8fUs0WTFnPM
	LFaLxNRBCAIJRNk=; b=Go5y9JHSE2f7oQJ/op0lw96eqM1LDRhqgsAewppn65em
	JD79IAM2CqIMeM3UT4UUlHuaoVnpEQCVA7td0EVGSJECFb8v/O9Gh5mr3iRiBzl7
	7bc9rNqXNtcWRK6LxeUn+6p6AHQFzUyMSze8iF8by/0vsgFUHU6DEbVfZ9z/h0g3
	vAEMDatFqqa8L7zCB1RKOz90WC9jdQoiDbYVtgWSK77bUX1HJozpAVcUE/N/fO51
	+NbrtAB7Ki8UpDgQJOqVLGutURRszvrPdqoSuErBczubME8Xiu91AZFf1eHSBHcO
	Fc1o3jTaeBsIqEujF327U8knnInhMrtokC+o8iVQXA==
X-ME-Sender: <xms:ICi7ZsuTf672zV1L8shw-r1UF8tBJYpmsXkLzLLKjH35E1CEaqMGJg>
    <xme:ICi7ZpdrNHxLdBTE3D_4BFwKEbJ-mJg6o5zLToDIARoHsclWG-2fQZJNyt08_zoUW
    0QaJVJNIvMfMCfocg>
X-ME-Received: <xmr:ICi7ZnzRjxMe92XmvplsKD2eHTKvgOB9s6VbjCkXCo_8cZQ5vTwVzOXxOv3yWt8zbpUSSEt_CA7uke4WBgkdxzfgeG1Fjw2zjtIqbfMoQn6lXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ICi7ZvMFpXUjO8iD_Uv9u9eDo2Mzno-oil8Hn2I9tu6REwzpKOCy_Q>
    <xmx:ICi7Zs-e48wQz3Z2D58hjnPWZuacFN0TyUEEgkZSRh-lzUfE9iVzIg>
    <xmx:ICi7ZnU0UyeYgPTSlL4MqNVQTKHIuuHiGbVJEvcORSj1qFu6clkRNQ>
    <xmx:ICi7ZlcFCMT1BexT5Cu9pMAzFoz2hz_byo_POnsy20KJVzWlInhvnw>
    <xmx:ICi7ZsyB9RDiXbZxYcUJF9pdpH9ffNlTARpiIedtHWOYxdqS0kP8VJ6F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:32:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15321e83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:58 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:32:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 21/22] diff: free state populated via options
Message-ID: <d5cb4ad580c7370a4ee48d2f5075a1764972c353.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

The `objfind` and `anchors` members of `struct diff_options` are
populated via option parsing, but are never freed in `diff_free()`. Fix
this to plug those memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                   | 10 ++++++++++
 t/t4064-diff-oidfind.sh  |  2 ++
 t/t4065-diff-anchored.sh |  1 +
 t/t4069-remerge-diff.sh  |  1 +
 4 files changed, 14 insertions(+)

diff --git a/diff.c b/diff.c
index 9251c47b72..4035a9374d 100644
--- a/diff.c
+++ b/diff.c
@@ -6717,6 +6717,16 @@ void diff_free(struct diff_options *options)
 	if (options->no_free)
 		return;
 
+	if (options->objfind) {
+		oidset_clear(options->objfind);
+		FREE_AND_NULL(options->objfind);
+	}
+
+	for (size_t i = 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	FREE_AND_NULL(options->anchors);
+	options->anchors_nr = options->anchors_alloc = 0;
+
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 6d8c8986fc..846f285f77 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test finding specific blobs in the revision walking'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index b3f510f040..647537c12e 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -2,6 +2,7 @@
 
 test_description='anchored diff algorithm'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '--anchored' '
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe..888714bbd3 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,6 +2,7 @@
 
 test_description='remerge-diff handling'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
-- 
2.46.0.46.g406f326d27.dirty

