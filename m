Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0B40C5C5
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905754; cv=none; b=LFkMNcA4YV0wI+aARmE4Veq8VrtY3Gmnes2MucyGCroQcomNZmAIP1gBZ/6ryf/ShIvGKiUH0TDzS+BIuwkXr37WRcHMib1DYLzSPcAYF2YpDoTVnTW96TH3JQQy790eVYmmoju1MPpJLDJ9rcWOHYtRFV2YuCiBelbi20owej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905754; c=relaxed/simple;
	bh=bHoIAFxhNuZ1VfLFRFZy10bv0BzWj735HzrCe419Ws0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXqIz0AquXZlmfs7Bj6mJ3p3GEugoAle4vnoNfJKZ/jGeWeCzym76kK94JBKlgKdL5UJcUSZ6THT3sPLR24mrT8mdl3rxIj/H+5T4uVxYMppik/eJT7Evq8cBbschWZDs9k1mRGPif8vL9ItDXmLLgTW44jGNZmoP7VaMB/o//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rz6PgEXx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TRoiEIA+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rz6PgEXx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TRoiEIA+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A678EEC01C5;
	Wed,  1 Jul 2026 07:35:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 07:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905752;
	 x=1782992152; bh=D0rT54zzOTM0/QTXLdanu28RNstT3COsbGGoltk8Ix4=; b=
	rz6PgEXxY+d1gF9K9dph5Sa9O8Hfetfg+nHnTBPFn/UVjuAe3A0mDPwMu/Y2WZoj
	IqXY8Mr54QX3yphGkrV5YSBJcpF03mOyi6ebtfD1DHdhAXbXTFWX9UfJeZMfdKqb
	ZZzXuWICRDdoA8ye48P/LQaFQXegrFO3v+G5baIReQbg4f1C6WOnQYihydQoDjPO
	tyWF8PEleGuBIss72ALMx+6AGS/2jmSGAimosL7g4DHJ0PwfuSNwn6VWmFGdsYjJ
	Vi0wSzPsddZ2WmOLXJCqYIYwRpnRT0PSK5378LfSC84V7ZrxYhK7Fi0kVS19V0cb
	iz3hCIBAi8/p9zNWgX0NRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905752; x=
	1782992152; bh=D0rT54zzOTM0/QTXLdanu28RNstT3COsbGGoltk8Ix4=; b=T
	RoiEIA+ou0+YBa2L92niQwbEtzBS5exZW27cWcSZgQiIaXLtGdFmasRTLgBHQ7lp
	B21WYwEs6EaX8H259P34+2GEgYCOz3AVkoixXg33hDkkA7J3ugugAR+wXh2sCytK
	yMrBhtB4iWLXVWEUjMXt78/heA3GqQnQrwAxydv83c2RUdTK+PLCUTe4/fec70FH
	AcXKJOCigGHfB5GrgGDtaTuDVO+JXEanp8pXpF+Z+jNuZIVFjs+vn8Gvjf2G7rs1
	kX5fle/c3LPfqSb2BVAn5BtAie3oRmEFUgDBXGnY+xobHKmVYZt8ru196I6eO1zs
	EFuy0vRHJeLmNNH48nJ6A==
X-ME-Sender: <xms:mPtEaj8QMHWBuhL7Yq_T_VGtdqXAZv5pt66twMG09Tq5pOb8j--X1w>
    <xme:mPtEapD0EJTN-NDQbVN3RW-r7oQFDz-o0Zw6ri4sPlN1Pp0eTiZ784nIK1C6j_zu5
    NgV8w2WvvT1E-aHYnnxqQmGHKfDq2ok2lThcc-syukEH4FUChWdhw>
X-ME-Received: <xmr:mPtEaoRQJwKX4wGc1KAojuTpW19RE_QdGrAwEpK4RAp9W64K9ju4livW4eEqoTcQOH_kbqV7L1jvBTDwkJ7uAlXZOt0b0mNuzxqomaCEarI>
X-ME-Proxy-Cause: dmFkZTEZoO6HolNFiuzhqEVK1EXq4BbCn1tdQX7LTJIMJcT/+latCDErJzD4+CwgisT7ri
    qxkn+QB2VfpeBpgOV5q2sBGT63aEOuYhfWwjT+wgnaZ2qGTsJfaJHBVk347IlsaCNTe39N
    jrZm/FsYSWHGfvBlbmbsEFy/XtzODL8fdqiFNJeGFn2lrHVPGPL/Yr6cOMglYCr7uBXs7r
    aXJwkPam35tJtUVY8r7/VZg2IyQl/w9r8/QisqR4rjlYUkyluAeVVxaLcVOMBGocW1MGez
    Nwenq9cyAhPKHT6bW4GOhAoe1hp9EC68DfdP8WD4TQ3JQn6e5yBMnRKyOIrDWHKuIfRTW7
    1iupYE5IQBpjSPobT2ER3oCvss2EssZSH2IQ9YkMVcFICtNGSSAOk9PDzyegHAD+1bFIAk
    rKfBO0V+UVU5S+1+hy8wl2SAGZ3tj7tDnK0/YQwFpRZrWn7THARNIJ9QebjKYRszAkncvQ
    hlEm9ktC78DF9LNPiMPMEM07wQ2UPj+dyplF2IyW4NXgdy83E9jn99O53CD1Ae8wbZSln8
    OUfbylbO4LewwSbkCjtQC/uyi3nLEZBELf+NiEgaClrLsx6NfM0fcC9kyqCEt/ohXoXHQC
    5C0Or0JA0MH8KKV46HxvIowjtm9C8XOKz3X2ku1DLiL8gzmHn0cALBlGrCbg
X-ME-Proxy: <xmx:mPtEagv_833wHK72lqbpLdXZq90HnyUNNXQh9nKhBYdxmOi_fbUv7A>
    <xmx:mPtEak3wM44sPiXdyDLE4qYDC_3DtbxBUKB918xFSbEm4jT7oUeeEQ>
    <xmx:mPtEahWDzIHr1cpY0-sipINVk2woJySzKTv4-ZJi05ZHs5CpedZfJg>
    <xmx:mPtEavKJePpW9sTYaNEOZjxnsv6w9RLJRmgtSzq5H4qXg7bhPfejxw>
    <xmx:mPtEahb7H5GoqXbr75jszNMKUHkn-OYjWpO2E6zgE_AAwogJhzTJ0Es0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a090a6c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:32 +0200
Subject: [PATCH v8 05/11] reset: introduce dry-run mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-5-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

In a subsequent commit we'll add another caller to `reset_working_tree()`
that wants to perform a dry-run check of whether it would be possible to
update the index and working tree when moving to a new commit. Introduce
a new flag that lets the caller perform this operation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 44 +++++++++++++++++++++++++++++++++-----------
 reset.h |  6 ++++++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/reset.c b/reset.c
index 4ca7f23a25..99f2c1b012 100644
--- a/reset.c
+++ b/reset.c
@@ -93,11 +93,14 @@ int reset_working_tree(struct repository *r,
 	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
 	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
 	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
+	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
+	struct index_state scratch_index = INDEX_STATE_INIT(r);
+	struct index_state *istate;
 	const char *action;
 	int ret = 0, nr = 0;
 
@@ -110,7 +113,7 @@ int reset_working_tree(struct repository *r,
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
-	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
 	}
@@ -125,16 +128,36 @@ int reset_working_tree(struct repository *r,
 	if (!oid)
 		oid = &head_oid;
 
-	if (refs_only)
-		return update_refs(r, opts, oid, head);
+	if (refs_only) {
+		if (!dry_run)
+			return update_refs(r, opts, oid, head);
+		return 0;
+	}
+
+	if (dry_run) {
+		if (read_index_from(&scratch_index, r->index_file, r->gitdir) < 0 ||
+		    index_state_unmerged_to_stage0(&scratch_index) < 0) {
+			ret = error(_("could not read index"));
+			goto leave_reset_head;
+		}
+
+		istate = &scratch_index;
+	} else {
+		if (repo_read_index_unmerged(r) < 0) {
+			ret = error(_("could not read index"));
+			goto leave_reset_head;
+		}
+		istate = r->index;
+	}
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = r->index;
-	unpack_tree_opts.dst_index = r->index;
+	unpack_tree_opts.src_index = istate;
+	unpack_tree_opts.dst_index = istate;
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
+	unpack_tree_opts.update = !dry_run;
+	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	unpack_tree_opts.skip_cache_tree_update = 1;
@@ -142,11 +165,6 @@ int reset_working_tree(struct repository *r,
 	if (reset_hard)
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 
-	if (repo_read_index_unmerged(r) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
 			    oid_to_hex(&head_oid));
@@ -163,6 +181,9 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
+	if (dry_run)
+		goto leave_reset_head;
+
 	tree = repo_parse_tree_indirect(r, oid);
 	if (!tree) {
 		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
@@ -182,6 +203,7 @@ int reset_working_tree(struct repository *r,
 leave_reset_head:
 	rollback_lock_file(&lock);
 	clear_unpack_trees_porcelain(&unpack_tree_opts);
+	release_index(&scratch_index);
 	while (nr)
 		free((void *)desc[--nr].buffer);
 	return ret;
diff --git a/reset.h b/reset.h
index 2e5826de99..898e4a1e95 100644
--- a/reset.h
+++ b/reset.h
@@ -21,6 +21,12 @@ enum reset_working_tree_flags {
 
 	/* Update ORIG_HEAD as well as HEAD */
 	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
+
+	/*
+	 * Perform a dry-run by performing the operation without updating
+	 * any user-visible state.
+	 */
+	RESET_WORKING_TREE_DRY_RUN = (1 << 5),
 };
 
 struct reset_working_tree_options {

-- 
2.55.0.795.g602f6c329a.dirty

