Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88712FA0D4
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938641; cv=none; b=IlGfsVHSPFHKEi982VV9gVp14GRA2aKh7ufcpZ3rabX5W3POl+xU4J5BwVcAM47kc1OtCoKSTg+HSuBZQdnz7kGYXQwn9DzsWTFZTmcY0S0qWdBn4pIJ7kx2qAaGgV5o09atjr1MFC2XOtFwU1JLvSbPu+nJLTjLg4S5O6jm4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938641; c=relaxed/simple;
	bh=vcvMa8wtVyOzYndKQnu2aBcSj2IYsQVvvDCNZ7zSknE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATVgUnrjEv9d0+lbCa/XzanaGBXV3+V3uP7h1XbosmnGT6wOQDe5GTjzT7FvFHcqEVPwT8JSl5T1P8hgr6rPl1SWWu9IYE2qa9ytdVZ5dvIt73BQ4KrOcRVG8DA+Sh67Zt3d5WYYRYd3iDfSJ66hz3SUqNtLzPnIXCmZIOpdb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oqljE1hX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1/EB5Dx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oqljE1hX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1/EB5Dx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9C707A05B5;
	Wed,  8 Oct 2025 11:50:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 11:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938638;
	 x=1760025038; bh=aBZuE8v0KBFOKn07bqyCKbI+69hKgFvVUZFidmmAP0Q=; b=
	oqljE1hXT/BNzwc8pJKZ1aEf2H/6nSid1yEMioN8N7JlaophEd2PU9qzKGRX0F9I
	w/ynG2goM0J5rQf8ZoYy3gLzL+niABH420L2sZTWhoH9ZYWcQqtGf13x9c6w5vBp
	d9oQUiCV+hlvPzR45j9rWD4rEV8RxUl46/jRLO0itYc+kMJ9OFRuFaYuRlG/vlaH
	+j8JRDVdZi9QAecljDk8Wbcs0Tr61ahoG82gCGRJOQq23jM08WOVmWfVOaWRMT+A
	M4tXHeiPKLIVr8Q3Qjro6O2l7NUhWj1DL6uwFfZ7FDZToSXnuh55ixS+XIy4xX4L
	dnG+CNKzBtU45AL8wUWFfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938638; x=
	1760025038; bh=aBZuE8v0KBFOKn07bqyCKbI+69hKgFvVUZFidmmAP0Q=; b=r
	1/EB5DxdVRCV8bwJTWV1ggP+DwJSS54Y+hkqfZkjq6tUNqGNCRAAzJ4nTjbn3cyn
	lkQSO3dDCLgygFPzcqRfmNSWvW4upyt2XEhnVBfPk1oC7EBVHco5Qjr6paVuIcrT
	sfGcpWpgf1fIYupJoDJhTWYGH/tpDJ+IIJrwBMAi7x2AyXqmkmb5Q+DAh5ddxSp6
	Ic6DvV6rsbvTNkxa+PHZfk+U5BrctPRYy3YXxwb97LYVa4+lWvRBLL47KnB4X3HT
	BKaux7kR3YQi39/B5obCDirOy1L/bg2g0FtGTckUUYPCjjbB7b5I04K/8W4S6fod
	arYa+BIaAb3dRTb6L6H+g==
X-ME-Sender: <xms:TojmaP_fXjHFyRM5iRcUzQ-UQMxGfRouuoc52XU8pZFEDSwI5jNZ-g>
    <xme:TojmaPa6KdstE5lqxCfgd9M7yaNiDjfd0jBYfv2tMnf-Hn37qjZiiPc3A7JQTUB4g
    -gzs_84_WqFjpxMeQPMXWX1UtfzbeLkwLITJ2HVf0vhVXBGB0F_P8o>
X-ME-Received: <xmr:TojmaG35SMYEC1VvwUv8Bk_7Yuq30KZeXvarOqYdSF26_e-Ve-6ff4dHiiJwKSmwkT5wFFhCitlLj1IdmEkLQ9iEsO763rN5OemX9IcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TojmaCaRk1c2aLIR10IX0hzPCeoYKJOEu5A0s1D6915Xmkn3Qp9mkg>
    <xmx:TojmaGLAugcZCvdE767Qb-RTaiN6Z7XQKvDsPzA9FukgZwy87r_YBQ>
    <xmx:TojmaJEU5PjgEKngMtlrLKpd6-b2sKEtJY9Sb6RyJzBZo-z0ElLQIw>
    <xmx:TojmaFt-S6UhZVhwX_71hHG_TaLzUCSdQgMcBN367yIZz60N_E6N2Q>
    <xmx:TojmaD7bs10bB4z2OhXPS62JEnVtfPedLgX7ONf5PJWh1QqcV7j_vIze>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a056701 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:19 +0200
Subject: [PATCH v2 04/14] refs: refactor reference status flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-4-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The reference flags encode information like whether or not a reference
is a symbolic reference or whether it may be broken. This information is
stored in a `int flags` bitfield, which is in conflict with our modern
best practices; we tend to use an unsigned integer to store flags.

Change the type of the field to be `unsigned`. While at it, refactor the
individual flags to be part of an `enum` instead of using preprocessor
defines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/refs.h b/refs.h
index 68d235438c..4f0a685714 100644
--- a/refs.h
+++ b/refs.h
@@ -333,27 +333,28 @@ struct ref_transaction;
  * stored in ref_iterator::flags. Other bits are for internal use
  * only:
  */
+enum reference_status {
+	/* Reference is a symbolic reference. */
+	REF_ISSYMREF = (1 << 0),
 
-/* Reference is a symbolic reference. */
-#define REF_ISSYMREF 0x01
+	/* Reference is a packed reference. */
+	REF_ISPACKED = (1 << 1),
 
-/* Reference is a packed reference. */
-#define REF_ISPACKED 0x02
-
-/*
- * Reference cannot be resolved to an object name: dangling symbolic
- * reference (directly or indirectly), corrupt reference file,
- * reference exists but name is bad, or symbolic reference refers to
- * ill-formatted reference name.
- */
-#define REF_ISBROKEN 0x04
+	/*
+	 * Reference cannot be resolved to an object name: dangling symbolic
+	 * reference (directly or indirectly), corrupt reference file,
+	 * reference exists but name is bad, or symbolic reference refers to
+	 * ill-formatted reference name.
+	 */
+	REF_ISBROKEN = (1 << 2),
 
-/*
- * Reference name is not well formed.
- *
- * See git-check-ref-format(1) for the definition of well formed ref names.
- */
-#define REF_BAD_NAME 0x08
+	/*
+	 * Reference name is not well formed.
+	 *
+	 * See git-check-ref-format(1) for the definition of well formed ref names.
+	 */
+	REF_BAD_NAME = (1 << 3),
+};
 
 /* A reference passed to `for_each_ref()`-style callbacks. */
 struct reference {
@@ -370,8 +371,8 @@ struct reference {
 	 */
 	const struct object_id *oid;
 
-	/* A bitfield of `REF_` flags. */
-	int flags;
+	/* A bitfield of `enum reference_status` flags. */
+	unsigned flags;
 };
 
 /*

-- 
2.51.0.764.g787ff6f08a.dirty

