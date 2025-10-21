Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C633890B
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056191; cv=none; b=oQOjBZY7waf2AaL9mTk4k0NU7b8Aw/mHx8QPwe6aO5yxhBD244cfwUbCaZ+gsuJ6Eq28WTh9mIFf8CibE5j1buH2RWNDMEQzqqjQQ0vxDTm6O1iVCpEdNMnexoRoD9Zy92OxpMlO1saZQdIPs4FeFJ9fUd8g+9zh+pPpyP4WgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056191; c=relaxed/simple;
	bh=cYO1K53N8yshfejuuffOOHNDIMlJW5nlJQiF8aszbFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bt4kF2nd//mDSxKp/1DZflTsm3/a3dfBKqT3U1OfAtMFADc/JZks8Kx/zNw2qVFZ0EzR9dYzWrszg/vF1wv6NKr1LTSEDx4AbOqofuhIClq933jvTzoYJnOOgyoJe4tGOP/j4Gg4Qezl84Pu5wEyftXu1QKY9j17mLJhz9MhJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hfpqJ50w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQPjYxJM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hfpqJ50w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQPjYxJM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1007214000C5;
	Tue, 21 Oct 2025 10:16:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 10:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056189;
	 x=1761142589; bh=VPmZ3mjU7Wv8I71eH+t49AaLAA+VkMcq0CYN/3DB6Sg=; b=
	hfpqJ50wRKapzwdsPq8MKtNIDU2kSRGea0Qk+pwyIzZ5Ya60OdEXG9zTq4UsOS1A
	OQa3q8fjLTq9OFwMxSRW3jlhweCJnS84sF4EB88IIIQNQN9jd7CMnRVAGp/KQ9Zi
	k3OJJSRFc+Ev+B+GBIXHsKJW6skRmfRM8mFc4bs5P5hg7+Xmfd7i7DahR0FlT69x
	8w/lZA99Ay1sk9AxIxrm3qGIeQynp38xrhvYYkpr8qdCl+pg4hGWVYYTLDycnTlx
	2IJfXNATett8zkj8iYKSAnLRFdVLBKF8vf9kcZhdlG/DpVErq4Afftx9oj6L4lTI
	b3nchGzlNbQBwlFlPhDUdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056189; x=
	1761142589; bh=VPmZ3mjU7Wv8I71eH+t49AaLAA+VkMcq0CYN/3DB6Sg=; b=n
	QPjYxJMnUfjvUsYP5DmVV7/3myUKv7u4hUhXMyjBz+NHiweAoyjNzk+Z8NqRAyLJ
	QhyBIgCEvtyg17tOoN8NOZdmlKaDYg+8XUGIZVo9ewMAM5gsSoWGLZbYcyQicRDz
	PqLfmZaP16x8+h6t8zXsmCzYwwwVyN2r4ry8mhUfSe/lcdm4d+2YFY0xRVDSmCU3
	y0QwOIkaqamOaorF+hjup/dG3p69bTMS4/uzYTeaO3mrrtsuEBdS0TEFxOHSw+bf
	UdNc+/YjOPTLMRarpNofMvUJYZcxfc+6e50TTqvK+qkUr6JO0ubiVq6KSVuyw9un
	6OQ5biO5H198HqEY9w71A==
X-ME-Sender: <xms:vJX3aPqbO46kh_tZggZ42wRj1LfJz3ncRH6QF-DZxILqzlGCCJgf8g>
    <xme:vJX3aGjaGTt-lhNTkNgd8clrY8AP4nWRNi7YNQwVmw4L-ge3j5i8xq7w6NUJI3oW2
    L7greio9p9iqvFLolWZdqzXe9Q7smr1jtjKmIWvtPP6H-LYdw15AQ>
X-ME-Received: <xmr:vJX3aL8jqPk15dAGFlNcfMVTLCtk9mijlC26JeOlWr6NFrVvz1rNi6wOKlr9xyhZ5YRhwxcyoy1jSuCHkvsCjLCKd8t9cMYWiDCuudOEP_IdFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hr
X-ME-Proxy: <xmx:vJX3aCUCSXQSChcr_bsvMx-uQRipq8zivgnbtWFozx5iLGs5XQu-Ag>
    <xmx:vJX3aPDdwDzBI2quVjgGVaC-r5TH1vmkMDHsWHjaqM9RC0jvIcR71Q>
    <xmx:vJX3aHEby6dQY7q_7AMuwuX0t0P6F2tDoR1e9AoddPFMJMDT5uugDg>
    <xmx:vJX3aA4cGq5esAQiBdQURHOmrggC80Rgv3CEZQHY51XtuKxXPMgIHQ>
    <xmx:vZX3aOM8f7HmSKHceLFJ76zJiZdORNVK1-s721HfKdmy-B9WoIr-md9U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d983969 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:59 +0200
Subject: [PATCH v5 11/12] cache-tree: allow writing in-memory index as tree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-11-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `write_in_core_index_as_tree()` takes a repository and
writes its index into a tree object. What this function cannot do though
is to take an _arbitrary_ in-memory index.

Introduce a new `struct index_state` parameter so that the caller can
pass a different index than the one belonging to the repository. This
will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 3 ++-
 cache-tree.c       | 5 ++---
 cache-tree.h       | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d230b1f8995..0b90f398feb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -902,7 +902,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
+			work = write_in_core_index_as_tree(the_repository,
+							   the_repository->index);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/cache-tree.c b/cache-tree.c
index 2aba47060e9..b67d0d703d2 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -699,11 +699,11 @@ static int write_index_as_tree_internal(struct object_id *oid,
 	return 0;
 }
 
-struct tree* write_in_core_index_as_tree(struct repository *repo) {
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state) {
 	struct object_id o;
 	int was_valid, ret;
 
-	struct index_state *index_state	= repo->index;
 	was_valid = index_state->cache_tree &&
 		    cache_tree_fully_valid(index_state->cache_tree);
 
@@ -723,7 +723,6 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	return lookup_tree(repo, &index_state->cache_tree->oid);
 }
 
-
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid;
diff --git a/cache-tree.h b/cache-tree.h
index b82c4963e7c..f8bddae5235 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -47,7 +47,8 @@ int cache_tree_verify(struct repository *, struct index_state *);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-struct tree* write_in_core_index_as_tree(struct repository *repo);
+struct tree *write_in_core_index_as_tree(struct repository *repo,
+					 struct index_state *index_state);
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 

-- 
2.51.1.851.g4ebd6896fd.dirty

