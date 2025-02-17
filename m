Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AED233D97
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807437; cv=none; b=aTke3LxN6fxENeXHDOl83N2WyzjvCE5HPFwnNvgBW9irj2y0MZVGB2iVIzRUo8Lrwq5hI//aO5eovl4hh2mAC4TAL8/EZIIMkE+HQhqwpRRhUwpFNmsZvL1s4ctx7JkC6j9vdbTICRQc9B2JrbQeh8pV31ItDjUs2uzqfmOoh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807437; c=relaxed/simple;
	bh=nqPR6QxpLyDrwNhnblazDYbUp0phAk08xfA5JD/X+Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ra7Oq4o07JGRXgPerTyXs/gxkqpJCd1JZ1uYPC2vb28AV5oJhPD3gq8Ut+cP9NgYpea1eAG9cA287m4qQLA3ce5nk1L9EhaF6amDhr3ydQxFUCxXYSd6dkTSE8gyJXsR1V7XznqS2BIWochgHVn7txpWPapFOeF3tAZd3tTdl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zcd7CbCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rnSXWCuK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zcd7CbCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rnSXWCuK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E088E25400EE;
	Mon, 17 Feb 2025 10:50:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 17 Feb 2025 10:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807434;
	 x=1739893834; bh=aWrY+mzuczK8DdPfwl3S9rUds8JICIR0qkSs77G5/LI=; b=
	Zcd7CbCQiHWJUlt82MZGHEKR7MLwX3S+ClBCePRQIo6X7tPWzGSykZxv+imY5xQG
	CdLrVkBJS3f2Ru606ayU0nnvLersTyG7hPwgpEKG9OilMPI1h5pBHzS8Dh5Z55jE
	M06/n6VRaYLJN3mg2WOb9hLknxAspeUVonwvrh6uks++aCjQiNXrCR7h9XBMzUJP
	E1+TJumcJGBlPV3rrx7qC39a4Yt9bdytvdPSNQy5o2wZjp0L7MZLOEpHY7hXweUa
	AWQfPMkTWf9H5L+HxyF2D8Y151oT5iFa/v1sut1IQyn1bZokwrFRhWmFVmOPRpl2
	cNWL2LvkCRfeozPVkAFJhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807434; x=
	1739893834; bh=aWrY+mzuczK8DdPfwl3S9rUds8JICIR0qkSs77G5/LI=; b=r
	nSXWCuKmfr4qunXuCZkdhHcXBDWpJ+bmC2AoD5e6gldTIJbbRQbEeRsBeR10idzB
	bcN96ZZigBkPSG3+m8VDO1u+3NpkFE4jPDkJbw/3X3nyPiyrl7rigS9iYAAiNPj+
	dMwj/IUGGyNNJGLck7XyPmPCXQNejFEjDSrghJOlgJds9tuUetsOIRdZgciJyCnv
	07ggZyg1IjGGQo5ywgP5FNvdj/DXRgNvE55yCB2S+251zzuGSbvI1c2B3pPVO127
	AcLqAgkdm9gLdT4Wop1VQlv133MNtb1jDEGUVjCM/RcUZeCLOXAkI/q8xtIu8fjG
	h47svB8MrPYDZxULFsNcg==
X-ME-Sender: <xms:ylqzZ3IjTgBI4obU9Z7D40-7BEA4g2RnYacfYNckkr0nP8ups0CFcw>
    <xme:ylqzZ7KfKyYVoHYZzysF2InuNjAKjHI2auCKj8FE2N4Rf_DPPAEWK8EhhClLC1tfl
    vZsSpAddzzYdp1Ddw>
X-ME-Received: <xmr:ylqzZ_tChf0O3uVQoQgkFRoY--I9aMuMfh3v2QRgnWIB8IWXS4bg20j0KPzjwIIqy7pW6gHDE5uxn-57W-AEojuG3fRU6aZ3DqSRdmnP6-zRKiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrgh
X-ME-Proxy: <xmx:ylqzZwZzMlo_-Bo5pR1Xa4DzCUly4FdhoKev3A3FBNmauDHXiqIzEg>
    <xmx:ylqzZ-YhnjRsmmy9LNEJlktWa_CockpiRp1_mDCSTBf9HQVXxxvbQQ>
    <xmx:ylqzZ0Cvt67GLxxvf9ljX24a06k8HhOf3cgRk6AH4qiosOYaIQDKag>
    <xmx:ylqzZ8avRu0eKh1eU1aOZGQDOtEiYNbQjG8-DjcwZMPcduf9zIv54Q>
    <xmx:ylqzZzNJMyvN8dTGak08KMEMpK92j6Y2fd9VExKPIyRARDQJ2-Gq-mAU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f2d2ae2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:23 +0100
Subject: [PATCH 09/14] refs/iterator: implement seeking for merged
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-9-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking on merged iterators. The implementation is rather
straight forward, with the only exception that we must not deallocate
the underlying iterators once they have been exhausted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/iterator.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index 757b105261a..63608ef9907 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
 struct merge_ref_iterator {
 	struct ref_iterator base;
 
-	struct ref_iterator *iter0, *iter1;
+	struct ref_iterator *iter0, *iter0_owned;
+	struct ref_iterator *iter1, *iter1_owned;
 
 	ref_iterator_select_fn *select;
 	void *cb_data;
@@ -160,13 +161,11 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	if (!iter->current) {
 		/* Initialize: advance both iterators to their first entries */
 		if ((ok = ref_iterator_advance(iter->iter0)) != ITER_OK) {
-			ref_iterator_free(iter->iter0);
 			iter->iter0 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
 		}
 		if ((ok = ref_iterator_advance(iter->iter1)) != ITER_OK) {
-			ref_iterator_free(iter->iter1);
 			iter->iter1 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -177,7 +176,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		 * entry:
 		 */
 		if ((ok = ref_iterator_advance(*iter->current)) != ITER_OK) {
-			ref_iterator_free(*iter->current);
 			*iter->current = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -206,7 +204,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (selection & ITER_SKIP_SECONDARY) {
 			if ((ok = ref_iterator_advance(*secondary)) != ITER_OK) {
-				ref_iterator_free(*secondary);
 				*secondary = NULL;
 				if (ok == ITER_ERROR)
 					goto error;
@@ -226,6 +223,28 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_ERROR;
 }
 
+static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct merge_ref_iterator *iter =
+		(struct merge_ref_iterator *)ref_iterator;
+	int ret;
+
+	iter->current = NULL;
+	iter->iter0 = iter->iter0_owned;
+	iter->iter1 = iter->iter1_owned;
+
+	ret = ref_iterator_seek(iter->iter0, prefix);
+	if (ret < 0)
+		return ret;
+
+	ret = ref_iterator_seek(iter->iter1, prefix);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -242,12 +261,13 @@ static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
-	ref_iterator_free(iter->iter0);
-	ref_iterator_free(iter->iter1);
+	ref_iterator_free(iter->iter0_owned);
+	ref_iterator_free(iter->iter1_owned);
 }
 
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
+	.seek = merge_ref_iterator_seek,
 	.peel = merge_ref_iterator_peel,
 	.release = merge_ref_iterator_release,
 };
@@ -268,8 +288,8 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 */
 
 	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
-	iter->iter0 = iter0;
-	iter->iter1 = iter1;
+	iter->iter0 = iter->iter0_owned = iter0;
+	iter->iter1 = iter->iter1_owned = iter1;
 	iter->select = select;
 	iter->cb_data = cb_data;
 	iter->current = NULL;

-- 
2.48.1.666.gff9fcf71b7.dirty

