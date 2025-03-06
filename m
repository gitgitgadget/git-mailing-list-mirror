Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866520E016
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273731; cv=none; b=hhdN/hkeJFPezh/R2Wxfv8ky25AtnlNcZuTviIZK6n0FAA5h0/BW7Gj442s/nWjf93o/vYF2yUyhd4O3t7VwQLF+I10FJg6L5EFcB2SYnZo3CmMhAqGWPmnUT4ycv7SmQI1fUw4aBtluIJ4tupi4Su/O/XkGurzpbNdSsJQott0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273731; c=relaxed/simple;
	bh=sIrzJj0ozy+yWL9q8qDuo7nbf7MR1gvy+JXbP2zNIUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YuTwC6laGX1HnYHLk+Qu3pJHSBt3q/T9xr4Z9ULVXeuabF1GOM0dfTkDPR/mHuummpuGQSO3H0PPHOw/ixOWbnlJvxFlmi1OH+vP8sqHrxQKYaxwDAKMvZD5j/aC2bGXLhypOeo6okxjpMFZqdRsQC23FJ6K9iCguQxloI7V5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W8bFldHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=it/RCsUf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W8bFldHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="it/RCsUf"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EA8D11400C9;
	Thu,  6 Mar 2025 10:08:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 06 Mar 2025 10:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273728;
	 x=1741360128; bh=7ZMpfbXD8DZFHMcrIdgHDhTTGGQ5/egavgo0IN9yleo=; b=
	W8bFldHcYMz8Fp4G/dfxx933+un+bUvm2Q72AwRssA4XFAhGFV0H3ERsOwz80GnA
	11P+NDitUtxUMniW74BnI5etyF05NM5zWqK/Et+FUtb5wlL4EWpvJnapRJ0t889k
	lBw9Fa5eQbyw2exyhjqqfbXKqLvioXUKT17PBhMics5YpcKlAaGCeHjyOJY5ZRau
	Dcje5gf+6ei+LZs33oN+LgI4efbz9KP2jhLoveIc2yye8pWxfwo5JPa5LhGxG7IA
	KQkDoKiClPS868cfiiO6XwsH8/5ONhgO3zo+jMyPi77cp822jHNPX6zdhiwW+pOA
	ZahpCzcJc0nf7RevLj2TGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273728; x=
	1741360128; bh=7ZMpfbXD8DZFHMcrIdgHDhTTGGQ5/egavgo0IN9yleo=; b=i
	t/RCsUffbhlo6xjnOIzM9Y64efumhhyA1KQelJzRH0Etjvku2qnH5/VMCXl++tni
	TeDggmW7D8Rx2jdz2Hite3LigEfIXu0MiziGGp1HxBVkTxnFRktS3TqInZ+XykdA
	uJAyhTkKk9kTZiHtCYkUEcpVRDWg7YWSWlakzWcaOXnieEewVWhHDK+Fc4ABFHgC
	gFWGBxEDb7X+wttGpOtjXnvEpaDJM6/FsPY1ABec4xmGXtn6ZFM4H9qy7iBGGG2c
	y+ssj2rtg6f+rWhIXmUKdviuMRqy7wQHNghHoSL0P8EPgXu6LsB0X2QC39TydjES
	WAg3NeJ7kKo1o04FRhJcQ==
X-ME-Sender: <xms:gLrJZ3IVaSDE6au5vYa_30KZX3WJoXmKRNSpjszzj3JPj6Lpz5yWjQ>
    <xme:gLrJZ7KpEB9zUijjOhySWzQBjDwErkLyqK5upD5lIDM2gtUfqY2Dv8miMEZXTeuGt
    RBENSSXEwvMNrwoUA>
X-ME-Received: <xmr:gLrJZ_uEBvZ7YkdfbZBqzAF4wDzzKtwVp724ViNqVDGKMebBxccmni2laFnhHxDnnuMdJM9dxgy_o_WHQ6I3xKw5RwPtsUJfCKwfJw_yLSS5OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gLrJZwaNhyJKtSeHK8Jn7WuDidRLcbZfWFX8MASuiTyi-uzmk3JSNw>
    <xmx:gLrJZ-YzNu4IUe24ZN_e9CrGEEp68N0cl1faw-ADFVul6QWfCla7mg>
    <xmx:gLrJZ0BZo-wtwVfl_neiEQ_IoBTyr5iyvrC0QY0LSwKpzC0Sw_wK1g>
    <xmx:gLrJZ8YRWr1yR34vwXr4MJANZqdfpRuWfSvgVMEhLrPaitnW0MfkpQ>
    <xmx:gLrJZ24EoJsyWcQHdXYJ2iAVUU-3tM8Mca_I1AFvGEH2sDQkpDUR1V5o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61a539e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:37 +0100
Subject: [PATCH v5 06/16] refs/files: batch refname availability checks for
 normal transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-6-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

