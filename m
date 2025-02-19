Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89D1EB1A6
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971431; cv=none; b=IYaovQUY7YxtTWkvvXPaHXQse0g3CtAQ9ObM0yjKjI3XFPhige9IfPmWEiNh3BC5p1AvOPXbiyNwFruYd5M8q09t8fGFF9vlkBTn0ESOzG1jERdlQ8Q2HINtgX0/I4BXkgknD3VuYQiMyE9TjZteKVOVl16+8qdfKn9H1w9Rsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971431; c=relaxed/simple;
	bh=RYtM36qTxXDv9o6q8CUusHcZQEJCgBqFdlG2vwf6Jrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfzonY8INkC9OxHHqMccHc7Tr+Y1/eYnb9Sr9Yjqjd6QZJ5+/jUvbZO6APGQw6B9RJzS/MYLz6B6pL89IGI+M7dwtCEDA10O8++bgD7dTeogwj5TZDK1oLQ7PLB6eaVzh1CWHoBC7hVMoSmm7tg9wixoJROJH0RlH0wu6Fm6H+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jgw2E4Z5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zYrU+x+r; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jgw2E4Z5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zYrU+x+r"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6486D25401B1;
	Wed, 19 Feb 2025 08:23:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 08:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971428;
	 x=1740057828; bh=t+SY9pF1ClRZpPLxShkLO4sKAg5qoA2bxdUu4RHbr1E=; b=
	Jgw2E4Z5J/rSJBr9mgmk1ExqzD66xc2OTlbRvjDssmChkm8qmn8FZFLzEqBLlRoO
	+9WaXPjcrQ/zPCCf4rNkhh7s+hCbZN4M0JmiakhmUXsqp59P18W1VQsu28PE2aDc
	MLq4r1aRoIF0FoZU+Ja7epsKBWkNOgG1h1QAfepfBphouNSumAHN8IzJhi1qotQp
	EH7jMwLITn/OleBc8cvH5+LJjSc4THb7xNKeMyMOaB1QrtrS9Fegd3uvRbmA0W5Q
	ZxL0wqhu5SpK8ByYve+d8Kfo9wplkzEkhA/80qlUTBF3VMs7ehgYGXpPfBNXfzw9
	ob1oJCoDrQMwGDcqEqUs7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971428; x=
	1740057828; bh=t+SY9pF1ClRZpPLxShkLO4sKAg5qoA2bxdUu4RHbr1E=; b=z
	YrU+x+rIPRidY9iFzfYn2ekACj8uMW5zaqL+m5nd3GLCIrSPak2ma05TSSPrItXI
	8vWLJG9dLJeHoqMej1XKTZmlKB4S8+fLbZ/ehyP4g10UyMH1QZPoTl3HOqO5bEG+
	Bzyhco7m0QntC3K12u0p9yfpTUAVEjraIKaPz4+AKqcZ5/M8KfLyWNW+ass0pu/H
	BgCG9YNre2Hm7yiOuyBlAeo+fYN7FAf8tnUSARHin+FGq8hcqoVbCXlPshOafVh9
	LfDr5DejM47Ke53Y83NPYRn8E/O8pCFWPP02Qsby5PcuWIefjFLmVDA/64lHEFcl
	bWrKAIG3usYh69iP6ROaQ==
X-ME-Sender: <xms:Y9u1ZygwMAvWUulXMav4hcfRhUBu_7-WX8hG-jyghnZ0pbkxfO7ydQ>
    <xme:Y9u1ZzCNnmtOqDRtLEImq_Ln-PxihY-n0bxp_JUf2QfROYaL_uTSSsAQ7Q1DMR4a6
    TW7ufdL9a6WjwHH5g>
X-ME-Received: <xmr:Y9u1Z6GV-wTopzFC02Q4wxxKRFFVdNTEXXnqThFWLPX6f3vhBs2Sq5xb7cexfXnGiYz76vh-5nw1T6m5FOTGM56K0VHqjpN_4KnFA0U4auRDdEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrg
    hmihhlhidrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:ZNu1Z7TH3PpXMiLYI52dDlISgKf9K9yeWgwwUbsQdSbG3CndYYsLVg>
    <xmx:ZNu1Z_yDoJnIdFgiVi9xHqCI3VfnLQRhjD3hIq-QJFWtZt1NEta-YQ>
    <xmx:ZNu1Z542I1VFjnFcbX4YFY4Go8o51CS4ZuQOkhpZ8L1dh3xwwalEgA>
    <xmx:ZNu1Z8zGVbPpbimX9ESdv03qSYUtM1EbvIGmP1rPAGmruOotEhAbDw>
    <xmx:ZNu1Z2zDhXxw9kuAkZ_jo2u242kYo8MbPMHUS0WcwEsnYATMeP2ojZsW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8cc64a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:37 +0100
Subject: [PATCH v2 10/16] refs/iterator: provide infrastructure to re-seek
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-10-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Reftable iterators need to be scrapped after they have either been
exhausted or aren't useful to the caller anymore, and it is explicitly
not possible to reuse them for iterations. But enabling for reuse of
iterators may allow us to tune them by reusing internal state of an
iterator. The reftable iterators for example can already be reused
internally, but we're not able to expose this to any users outside of
the reftable backend.

Introduce a new `.seek` function in the ref iterator vtable that allows
callers to re-seek an iterator. It is expected to be functionally the
same as calling `refs_ref_iterator_begin()` with a different (or the
same) prefix.

Implement the callback for trivial cases. The other iterators will be
implemented in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/debug.c         | 11 +++++++++++
 refs/iterator.c      | 24 ++++++++++++++++++++++++
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/refs/debug.c b/refs/debug.c
index a9786da4ba1..5390fa9c187 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -169,6 +169,16 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return res;
 }
 
+static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->seek(diter->iter, prefix);
+	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
+	return res;
+}
+
 static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -189,6 +199,7 @@ static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
+	.seek = debug_ref_iterator_seek,
 	.peel = debug_ref_iterator_peel,
 	.release = debug_ref_iterator_release,
 };
diff --git a/refs/iterator.c b/refs/iterator.c
index aaeff270437..757b105261a 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -15,6 +15,12 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix)
+{
+	return ref_iterator->vtable->seek(ref_iterator, prefix);
+}
+
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
 		      struct object_id *peeled)
 {
@@ -50,6 +56,12 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 	return ITER_DONE;
 }
 
+static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				   const char *prefix UNUSED)
+{
+	return 0;
+}
+
 static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				   struct object_id *peeled UNUSED)
 {
@@ -62,6 +74,7 @@ static void empty_ref_iterator_release(struct ref_iterator *ref_iterator UNUSED)
 
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
 	.advance = empty_ref_iterator_advance,
+	.seek = empty_ref_iterator_seek,
 	.peel = empty_ref_iterator_peel,
 	.release = empty_ref_iterator_release,
 };
@@ -368,6 +381,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				    const char *prefix)
+{
+	struct prefix_ref_iterator *iter =
+		(struct prefix_ref_iterator *)ref_iterator;
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				    struct object_id *peeled)
 {
@@ -387,6 +410,7 @@ static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
 	.advance = prefix_ref_iterator_advance,
+	.seek = prefix_ref_iterator_seek,
 	.peel = prefix_ref_iterator_peel,
 	.release = prefix_ref_iterator_release,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 74e2c03cef1..3f6d43110b7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -327,6 +327,21 @@ struct ref_iterator {
  */
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
+/*
+ * Seek the iterator to the first reference with the given prefix.
+ * The prefix is matched as a literal string, without regard for path
+ * separators. If prefix is NULL or the empty string, seek the iterator to the
+ * first reference again.
+ *
+ * This function is expected to behave as if a new ref iterator with the same
+ * prefix had been created, but allows reuse of iterators and thus may allow
+ * the backend to optimize.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix);
+
 /*
  * If possible, peel the reference currently being viewed by the
  * iterator. Return 0 on success.
@@ -445,6 +460,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
+/*
+ * Seek the iterator to the first reference matching the given prefix. Should
+ * behave the same as if a new iterator was created with the same prefix.
+ */
+typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
+				 const char *prefix);
+
 /*
  * Peels the current ref, returning 0 for success or -1 for failure.
  */
@@ -459,6 +481,7 @@ typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);
 
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
+	ref_iterator_seek_fn *seek;
 	ref_iterator_peel_fn *peel;
 	ref_iterator_release_fn *release;
 };

-- 
2.48.1.683.gf705b3209c.dirty

