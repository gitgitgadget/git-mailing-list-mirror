Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAE13D51D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618345; cv=none; b=CTmnU/HZfI26S33lfIviJXU6m8xA6pAGZZqR4eaHN3nsF4ZaU8RnPlH0wQWQjgRhdDP3VC3hzwaASQLwb74Pdn4Y3OXNGgS8FVog9T0JFoH1elKb/cLJguBgM7aUbmC7sK9PLlx1IJ+YZ0rBZpoP9BfJgQjh4aB4FBGuB3J6WU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618345; c=relaxed/simple;
	bh=bRWVYqnjVu+N5NHbN8oxZtS1NQshG1QSH2y1ChqmUVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku9Nxzqz4G9nGUqCO5vQaylDQNtbB25UVru/Xd94qflv+P9nXU9dfVDaltA7mkyb3VULclddtHBhmJznwjBPBuD3Rk+GrzIRuARA83Ze0OEEle4yCbitlRbGrhHO571R4I81CiJV6XSEnREk8MpJjVfjnnWN6nRdeSWGJBsbdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GygaFzw5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rzL4Gz6q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GygaFzw5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rzL4Gz6q"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 50B5A114EA13;
	Wed, 14 Aug 2024 02:52:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 02:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618343; x=1723704743; bh=fY3QklG+5J
	9bg7jitVmt2MFrjB4EdA04boCX2CSDFj0=; b=GygaFzw5p8Nj3d87e403aTK7ch
	Mw5+Mm0A3AwDBgfmbLSxItB5q/Gx8Ykh3wedBe85L6IyAB7i7PHBD2IMJ4MgOjGA
	KcYn/k1/0Df87gFTh0o0MpTVW+oMkQRprS4ihkG0uVv+nCY35CiGPtxsdAmBvM/S
	QknmGN/4K9KLYfM5tXznqOp/Pjza/jrjKpwaIBM/AclGwkDzS+Y505fNWZNuRsty
	Zc81oGiLBDFxrs6/UZRgsywwcSNF2aXlZgAyfE8AIo7XdixTdwx60+WIxCnwbev4
	4YPAzkGJoVIeEfSSV165JQqBBkEKq8wcdFQXwM7AGoBNtLPO8/HoYQP7nXJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618343; x=1723704743; bh=fY3QklG+5J9bg7jitVmt2MFrjB4E
	dA04boCX2CSDFj0=; b=rzL4Gz6qlDeeauMXlbuoNdaWcTvWcgae6KeEEHHMF6Nr
	2KY8TpwSYXGuDosbpo0WOzv05h4reNGPkojXhSxoYsf1N5gRrwgH93+C1gtq9uUO
	hGr8HQ22leQyMe2bQoAMatjeVEjtxFHwudCo05q0cBs3q5Wnov/NS1q6YRZBGY16
	zPiarKX1+Cqv6cAZlPdIAPPEagEJsLjxzx7Sq3a5Ei1AKTx2B4t7iYvKedBK2oGC
	3ibkKpP+YpdFl3maOo0LVIVkJhSVfuvqNr35BQGkBUhi1yjlwovxJTJl3E8RBnTQ
	1Dw6mBuEScpWLlQHLnAU88p0rFSUNQ2sBg/EYsnt9w==
X-ME-Sender: <xms:J1S8ZvrAemy5-tAAnbmEGPGEu5XMjUUMu_-6Pc31ZED7sJZks1TY2g>
    <xme:J1S8ZpriEnS5PDmjXBavnfbvPeRGs9DfTEGjC4kl3FMuPaB0Xt6hUxNzMVXWMqqvu
    bMb4MUoIeBVoOJ04g>
X-ME-Received: <xmr:J1S8ZsMv-cwnpbJRZRqXEfba3TytTOJi2tklIrZJy2yYEc-5mveSWIaFdnh8qk6sTEsaA9QwVIFhoue5Adae5mMXrxoYBIhwAQJA5E5Byrzsuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurd
    hiohdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:J1S8Zi70qY3gFfM_TCtBPfzYm1ekwBa14nzSghzhh7a1SZwGd9cEWw>
    <xmx:J1S8Zu4Paj3cqD4A0ez2GxoDkafxP3uCkSMTzX-GiZXiSdQKO5_Hmg>
    <xmx:J1S8Zqg4xwQlaJROjZ0eD_1MkAFyqeBjbD0oen6lVRDb48tEgEHBfA>
    <xmx:J1S8Zg6hN2PdTeWAR_VjMzWgLeQNfb1jR5tyWT85SwVHmq4IC4If_g>
    <xmx:J1S8ZrtYYl0av3YfgUu06MlKJd6EliKkauONtyp-FifVq-fbFkeHl_6x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67465741 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:03 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 10/22] builtin/notes: fix leaking `struct notes_tree` when
 merging notes
Message-ID: <0af1bab5a1432eb636dc0fa7b538fa39661cb34d.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

We allocate a `struct notes_tree` in `merge_commit()` which we then
initialize via `init_notes()`. It's not really necessary to allocate the
structure though given that we never pass ownership to the caller.
Furthermore, the allocation leads to a memory leak because despite its
name, `free_notes()` doesn't free the `notes_tree` but only clears it.

Fix this issue by converting the code to use an on-stack variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/notes.c                       | 9 ++++-----
 t/t3310-notes-merge-manual-resolve.sh | 1 +
 t/t3311-notes-merge-fanout.sh         | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..81cbaeec6b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -807,7 +807,7 @@ static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg = STRBUF_INIT;
 	struct object_id oid, parent_oid;
-	struct notes_tree *t;
+	struct notes_tree t = {0};
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
 	void *local_ref_to_free;
@@ -830,8 +830,7 @@ static int merge_commit(struct notes_merge_options *o)
 	else
 		oidclr(&parent_oid, the_repository->hash_algo);
 
-	CALLOC_ARRAY(t, 1);
-	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+	init_notes(&t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
 		refs_resolve_refdup(get_main_ref_store(the_repository),
@@ -839,7 +838,7 @@ static int merge_commit(struct notes_merge_options *o)
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
 
-	if (notes_merge_commit(o, t, partial, &oid))
+	if (notes_merge_commit(o, &t, partial, &oid))
 		die(_("failed to finalize notes merge"));
 
 	/* Reuse existing commit message in reflog message */
@@ -853,7 +852,7 @@ static int merge_commit(struct notes_merge_options *o)
 			is_null_oid(&parent_oid) ? NULL : &parent_oid,
 			0, UPDATE_REFS_DIE_ON_ERR);
 
-	free_notes(t);
+	free_notes(&t);
 	strbuf_release(&msg);
 	ret = merge_abort(o);
 	free(local_ref_to_free);
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 597df5ebc0..04866b89be 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -5,6 +5,7 @@
 
 test_description='Test notes merging with manual conflict resolution'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Set up a notes merge scenario with different kinds of conflicts
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 5b675417e9..ce4144db0f 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -5,6 +5,7 @@
 
 test_description='Test notes merging at various fanout levels'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 verify_notes () {
-- 
2.46.0.46.g406f326d27.dirty

