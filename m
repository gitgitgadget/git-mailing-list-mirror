Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B1257AE4
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734814; cv=none; b=mY3kOsKdPmlb1OKHbpuFE9aLittrRWWK55ASy1f+ZhiHxmqULpNS6I/5IzgnEz21VtgBanut2keyQAn3ew5uDYv5US3oHF0OPhRFrbNtqZOt1oDs95R/a+N9MAq2vH5c8+n0fhZonP211aeRUqaDdC7lnVHNJnGmJZFtZv/aK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734814; c=relaxed/simple;
	bh=mP6fk8aKFSoqxEXEs9waycswf6AJoZOO+L2Xxc9WFHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKTtpCMWLMgPPK+v1DgQhMwPMrsMv5reQ/l99eGLa1y9L5HI/k8xf4SQzZnl/36eLm7tLCmlfQkoceDGit6T7mmxODoOL9shsS4ijxRRdjlDpivQVx5Fcfon42uuwRdZljQMF86RlTnXJXbcyH36EOJXKJu2iWBLAYPBq2niAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z+OrzgkM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ia2QQe4o; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z+OrzgkM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ia2QQe4o"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C85181382788;
	Fri, 28 Feb 2025 04:26:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 04:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734811;
	 x=1740821211; bh=2LLfmEej7ZMeMXgIDpcL6SvY++nHn/VNu7Uj9JPRNdw=; b=
	Z+OrzgkMjYDPhGtoI/ra/f1x/n/PyoivFQYUDIrxDSOd9hRXLmYxy1+R68rkH1mp
	dmaLGXsIcA7bDihzfv8u5khfDDGRiEifl2WUVXJVSUNMTvIpX+9UhJpEQN/vrb5+
	XUqx/IehVI9/1RKvqYV9twisr+bLEgBEXi+Cnbr8jyMrenGEx76CA0Q2BNQMJP0L
	CiKtUQ5NhwsQ5c0AyebcMtuI71R7lfUFD6ss6ydjyluUr6fd3NWRSMz31Tkj9evo
	Dxi49VeghbSL9omLDIT0+uyyg7YlgwKqXRkJVCx8RlIAlbhShPCDU+OZ4G2Q5zhF
	UapV452l0ijCSSHz1HvXcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734811; x=
	1740821211; bh=2LLfmEej7ZMeMXgIDpcL6SvY++nHn/VNu7Uj9JPRNdw=; b=i
	a2QQe4ovZMsor32cymk/gtnlIkRF74HLWs6O4UjK+oyItB6015FXis3L87tVvtRz
	I5OBpeNV/wBMzScnUWjxB5gF3TXJpuT8LiYSpYzfrimnt+DVnbyztlM5j1DRhP6Y
	GqOqK5gzUrxiW18f7uCoXsLjDeEX4vConBTDQFwHYM+Lsawe0aKfLsPsrv1AEyYX
	KfS0W5fzLXsCbyQ0sHWy+J1O51x4XI0aZdEtUrzYL9WVcLy5acZAVi863qUjR5WL
	KXu2IuNlgaqKMnKjqD6E1EKucX2auLw59KNopCbHd6gaVKEy3q3hPgfpb0sFDdBn
	t2VZBh3uo78ZEjAslTz9g==
X-ME-Sender: <xms:W4HBZ1yTj_1ihq3xI5z6SW6WeUeIUVnd9UfZBZTdPl9SMnpVzfRuiQ>
    <xme:W4HBZ1SCTN30g1jT-XYfYhA3ALOKv397gxD9x0uGF1A7CCUl08jbETHf93JHN_emP
    ZkfaNCKmY1qRTux7A>
X-ME-Received: <xmr:W4HBZ_VNe-th8tl8hjdrY07tarCdDOywnkTCYhCRXS8X7xz_BmBgz3Ua5Sy5S1OjsQzlqTp6rQvam1KXwv_IYGojr5Ju6N-vCNgWUjLYdRQemDyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:W4HBZ3i7SaSd7Lb8ya2M4YFw0xEChrwFN-xma0CFcB7DU8EV9VwcKw>
    <xmx:W4HBZ3BmtlB9motZgiNmHGR6efh-bIUfF2zK_DPpZPwjxZDMGiUQ3Q>
    <xmx:W4HBZwLa2E2zWFMJr78apIg0zah72_aFNvseY7KW3JgZwv8iU68zRw>
    <xmx:W4HBZ2AwqCFqq8ZXKxaAhUXvmxAmZu-RFBB9QNyyTZqnxSltvNEbZg>
    <xmx:W4HBZ5BJ60m8ZdvIM2AfQx2-JqQxfIL4HkKst4FFW6tl6SZZB3OOIJIP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5829e21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:43 +0100
Subject: [PATCH v4 06/16] refs/files: batch refname availability checks for
 normal transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-6-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Same as the "reftable" backend that we have adapted in the preceding
commit to use batched refname availability checks we can also do so for
the "files" backend. Things are a bit more intricate here though, as we
call `refs_verify_refname_available()` in a set of different contexts:

  1. `lock_raw_ref()` when it hits either EEXISTS or EISDIR when creating
     a new reference, mostly to create a nice, user-readable error
     message. This is nothing we have to care about too much, as we only
     hit this code path at most once when we hit a conflict.

  2. `lock_raw_ref()` when it _could_ create the lockfile to check
     whether it is conflicting with any packed refs. In the general case,
     this code path will be hit once for every (successful) reference
     update.

  3. `lock_ref_oid_basic()`, but it is only executed when copying or
     renaming references or when expiring reflogs. It will thus not be
     called in contexts where we have many references queued up.

  4. `refs_refname_ref_available()`, but again only when copying or
     renaming references. It is thus not interesting due to the same
     reason as the previous case.

  5. `files_transaction_finish_initial()`, which is only executed when
     creating a new repository or migrating references.

So out of these, only (2) and (5) are viable candidates to use the
batched checks.

Adapt `lock_raw_ref()` accordingly by queueing up reference names that
need to be checked for availability and then checking them after we have
processed all updates. This check is done before we (optionally) lock
the `packed-refs` file, which is somewhat flawed because it means that
the `packed-refs` could still change after the availability check and
thus create an undetected conflict. But unconditionally locking the file
would change semantics that users are likely to rely on, so we keep the
current locking sequence intact, even if it's suboptmial.

The refactoring of `files_transaction_finish_initial()` will be done in
the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29f08dced40..6ce79cf0791 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -678,6 +678,7 @@ static void unlock_ref(struct ref_lock *lock)
  */
 static int lock_raw_ref(struct files_ref_store *refs,
 			const char *refname, int mustexist,
+			struct string_list *refnames_to_check,
 			const struct string_list *extras,
 			struct ref_lock **lock_p,
 			struct strbuf *referent,
@@ -855,16 +856,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		}
 
 		/*
-		 * If the ref did not exist and we are creating it,
-		 * make sure there is no existing packed ref that
-		 * conflicts with refname:
+		 * If the ref did not exist and we are creating it, we have to
+		 * make sure there is no existing packed ref that conflicts
+		 * with refname. This check is deferred so that we can batch it.
 		 */
-		if (refs_verify_refname_available(
-				    refs->packed_ref_store, refname,
-				    extras, NULL, 0, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto error_return;
-		}
+		string_list_insert(refnames_to_check, refname);
 	}
 
 	ret = 0;
@@ -2569,6 +2565,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct ref_update *update,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
+			       struct string_list *refnames_to_check,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
@@ -2597,7 +2594,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		lock->count++;
 	} else {
 		ret = lock_raw_ref(refs, update->refname, mustexist,
-				   affected_refnames,
+				   refnames_to_check, affected_refnames,
 				   &lock, &referent,
 				   &update->type, err);
 		if (ret) {
@@ -2811,6 +2808,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
@@ -2898,7 +2896,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		ret = lock_ref_for_update(refs, update, transaction,
-					  head_ref, &affected_refnames, err);
+					  head_ref, &refnames_to_check,
+					  &affected_refnames, err);
 		if (ret)
 			goto cleanup;
 
@@ -2930,6 +2929,26 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	/*
+	 * Verify that none of the loose reference that we're about to write
+	 * conflict with any existing packed references. Ideally, we'd do this
+	 * check after the packed-refs are locked so that the file cannot
+	 * change underneath our feet. But introducing such a lock now would
+	 * probably do more harm than good as users rely on there not being a
+	 * global lock with the "files" backend.
+	 *
+	 * Another alternative would be to do the check after the (optional)
+	 * lock, but that would extend the time we spend in the globally-locked
+	 * state.
+	 *
+	 * So instead, we accept the race for now.
+	 */
+	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
+					   &affected_refnames, NULL, 0, err)) {
+		ret = TRANSACTION_NAME_CONFLICT;
+		goto cleanup;
+	}
+
 	if (packed_transaction) {
 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
@@ -2972,6 +2991,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 cleanup:
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&refnames_to_check, 0);
 
 	if (ret)
 		files_transaction_cleanup(refs, transaction);

-- 
2.49.0.rc0.375.gae4b89d849.dirty

