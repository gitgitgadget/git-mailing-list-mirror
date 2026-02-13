Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECA3161A3
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973982; cv=none; b=e7RmEGdfAGxS9l70VfQZIthcb+aovvyBU8QpEaY68MDqyMMQ32oNULUIGZy0zSWHB3YSOk2Sc1vW0N/L1dHBaoyq0LrX8zaE6Q2RzK0tcjMK+7N2WRv6RDxcl2XfDGtWq9qsFfDJxKLPT/Dzc8klIWcsq2FMv7ykUPyy+owtCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973982; c=relaxed/simple;
	bh=13dNhh3Kk/S1eOdnQ7mBgiL+VJwf7FzlkqPkSX514JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3IJoTIGRzCa23+azOvvcULA24Co/in0q27OCZBEwj8oFkKXi3W0yDMewniks8TKtaByx6v5vQ9OC/8WkNagSqMNu5/lHR5w4Yqg/CQxpb8rlZ33xHz1cNA7y/BxfGuxmTbi1q8BLDRlNnDrFOkYgfxRqitsZ8kMpdFVrrwLF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UTeyEedG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qB+qZ4cx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UTeyEedG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qB+qZ4cx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 319DC140008E;
	Fri, 13 Feb 2026 04:13:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Feb 2026 04:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770973980;
	 x=1771060380; bh=deh3epuz58yf1W5YaI8OipNDj5QLBPc/zHkZN3+oRBc=; b=
	UTeyEedGvva40Xfc0fEuDkhvg1tXM8JNEHX2EroOi8Lp3hFp7yAalPxhCIFbJQo8
	99owJ1YgOz744TjWlsEb/Kd8IcsQVEwJKSa+nQOHtJ0CYHCPXfOlqd34/H6ZXfhj
	QNu6ldOXpKnMm79HswtQ/3bYz5Lp0jPoLnd9rzvKX8oZfq54SJfaCdwsUbu/UJyx
	ZyStxgoVoxPDD23z4pEkS+d1eD5Nt8XPaSc0K8N3Hevxw7ghx6AMTYKNn8meAdaN
	vxafJ10iXIqTBTMHAINa1+ZlDI3I10Llhw4zPnqKgVT/D/nWfeG2arNyXmVAj+F3
	d2EtEXgz91coho8Ca2PkaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770973980; x=
	1771060380; bh=deh3epuz58yf1W5YaI8OipNDj5QLBPc/zHkZN3+oRBc=; b=q
	B+qZ4cx/dz7Z6QT/Kq7ghlT+01x2Lgo8HhHuwV2hgsdC2KT9dMS6Sh7i2feW38iK
	9Iugvj1uL/99Atke2oVyIwCC70+NjI/o9V7WQ02KcDzNT2dFOgtd+MNTsi7gNpMO
	QO7tjrKfRABLvh8upQseUBTPx5PhR0tpTbHUoML2E8trWBT2HK02vIbLLbF05Z9H
	T/yQQu413EX1TM5x6rxR4btNAVvRRu+ll2o+ew3xNxvBUR0gvgCRiNFE+U0/hKX/
	0mjBB9PPDO7HmzxDEbntk28/pTlOnLZB4hncBsfkN6QeN2DAckUq6IgZPZQgrSrt
	hG/306IQwXISzOGFZ44lA==
X-ME-Sender: <xms:HOuOacExq2A4BNcw164nj-CIewHHatwMUQFjNccywivqh-r77ZnSEA>
    <xme:HOuOacyMVeXqfyfYe_PpTXyk9vjLhut4eR6bAW25lBbZuxFL5mS3PtqZIZif-yHyR
    XKcXltza44jYugdrCUVOdVFmQvNLYIIcG1qCz_QGmx9oX7Tgxl5XA>
X-ME-Received: <xmr:HOuOaThDempJSd0VLDeZ3Jsu5byv_hRNSTGye5ffCAMtabGHmewumf-zzvsonvJt-LvP8PVKdIacHH1Rz1UZkr_15ukm35C1qv1PkB7W7-29>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:HOuOaXxy3Z5DPpj7m4d40O8zXM2qN5ef_n3wb2_jhAPbaTvZ4CCFVg>
    <xmx:HOuOaWKi1hU6sfIgEXqgu9nTBdIgjBwPVds1Fhhztux7hXCi9l7Wrg>
    <xmx:HOuOaeSwMNtZJGRnhNoS_1ZWzAoCTnOO35vBxgDcqFYtBk1JonoH8A>
    <xmx:HOuOaeoyq0rITCzjTWevcmSVRqR4_NuZJZK1vHEvwRtA9ZCDZS9Tsg>
    <xmx:HOuOaQyu2gBvoU5ul_6i0sqHrOHHo1LRTo7ki1LzPHEDiR4A_AEBlWje>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 04:12:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd1768a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 09:12:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Feb 2026 10:12:47 +0100
Subject: [PATCH v2 1/5] builtin/history: perform revwalk checks before
 asking for user input
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-b4-pks-history-dry-run-v2-1-756ac376e9e5@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.3

When setting up the revision walk in git-history(1) we also perform some
verifications whether the request actually looks sane. Unfortunately,
these verifications come _after_ we have already asked the user for the
commit message of the commit that is to be rewritten. So in case any of
the verifications fails, the user will have lost their modifications.

Extract the function to set up the revision walk and call it before we
ask for user input to fix this.

Adapt one of the tests that is expected to fail because of this check
to use false(1) as editor. If the editor had been executed by Git, it
would fail with the error message "Aborting commit as launching the
editor failed."

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c         | 69 +++++++++++++++++++++++++++++------------------
 t/t3451-history-reword.sh |  2 +-
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 8dcb9a6046..1de51372ea 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -177,30 +177,15 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
-static int handle_reference_updates(enum ref_action action,
-				    struct repository *repo,
-				    struct commit *original,
-				    struct commit *rewritten,
-				    const char *reflog_msg)
+static int setup_revwalk(struct repository *repo,
+			 enum ref_action action,
+			 struct commit *original,
+			 struct rev_info *revs)
 {
-	const struct name_decoration *decoration;
-	struct replay_revisions_options opts = { 0 };
-	struct replay_result result = { 0 };
-	struct ref_transaction *transaction = NULL;
 	struct strvec args = STRVEC_INIT;
-	struct strbuf err = STRBUF_INIT;
-	struct commit *head = NULL;
-	struct rev_info revs;
-	char hex[GIT_MAX_HEXSZ + 1];
-	bool detached_head;
-	int head_flags = 0;
 	int ret;
 
-	refs_read_ref_full(get_main_ref_store(repo), "HEAD",
-			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
-	detached_head = !(head_flags & REF_ISSYMREF);
-
-	repo_init_revisions(repo, &revs, NULL);
+	repo_init_revisions(repo, revs, NULL);
 	strvec_push(&args, "ignored");
 	strvec_push(&args, "--reverse");
 	strvec_push(&args, "--topo-order");
@@ -224,6 +209,7 @@ static int handle_reference_updates(enum ref_action action,
 	 */
 	if (action == REF_ACTION_HEAD) {
 		struct commit_list *from_list = NULL;
+		struct commit *head;
 
 		head = lookup_commit_reference_by_name("HEAD");
 		if (!head) {
@@ -250,20 +236,47 @@ static int handle_reference_updates(enum ref_action action,
 		strvec_push(&args, "HEAD");
 	}
 
-	setup_revisions_from_strvec(&args, &revs, NULL);
+	setup_revisions_from_strvec(&args, revs, NULL);
 	if (args.nr != 1)
 		BUG("revisions were set up with invalid argument");
 
+	ret = 0;
+
+out:
+	strvec_clear(&args);
+	return ret;
+}
+
+static int handle_reference_updates(struct rev_info *revs,
+				    enum ref_action action,
+				    struct commit *original,
+				    struct commit *rewritten,
+				    const char *reflog_msg)
+{
+	const struct name_decoration *decoration;
+	struct replay_revisions_options opts = { 0 };
+	struct replay_result result = { 0 };
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
+	char hex[GIT_MAX_HEXSZ + 1];
+	bool detached_head;
+	int head_flags = 0;
+	int ret;
+
+	refs_read_ref_full(get_main_ref_store(revs->repo), "HEAD",
+			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
+	detached_head = !(head_flags & REF_ISSYMREF);
+
 	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
 
-	ret = replay_revisions(&revs, &opts, &result);
+	ret = replay_revisions(revs, &opts, &result);
 	if (ret)
 		goto out;
 
 	switch (action) {
 	case REF_ACTION_BRANCHES:
 	case REF_ACTION_HEAD:
-		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
+		transaction = ref_store_transaction_begin(get_main_ref_store(revs->repo), 0, &err);
 		if (!transaction) {
 			ret = error(_("failed to begin ref transaction: %s"), err.buf);
 			goto out;
@@ -343,9 +356,7 @@ static int handle_reference_updates(enum ref_action action,
 out:
 	ref_transaction_free(transaction);
 	replay_result_release(&result);
-	release_revisions(&revs);
 	strbuf_release(&err);
-	strvec_clear(&args);
 	return ret;
 }
 
@@ -367,6 +378,7 @@ static int cmd_history_reword(int argc,
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct commit *original, *rewritten;
+	struct rev_info revs;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
@@ -385,6 +397,10 @@ static int cmd_history_reword(int argc,
 		goto out;
 	}
 
+	ret = setup_revwalk(repo, action, original, &revs);
+	if (ret)
+		goto out;
+
 	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
@@ -393,7 +409,7 @@ static int cmd_history_reword(int argc,
 
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
-	ret = handle_reference_updates(action, repo, original, rewritten,
+	ret = handle_reference_updates(&revs, action, original, rewritten,
 				       reflog_msg.buf);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
@@ -404,6 +420,7 @@ static int cmd_history_reword(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	release_revisions(&revs);
 	return ret;
 }
 
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 3594421b68..6775ed62f9 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -263,7 +263,7 @@ test_expect_success '--ref-action=head updates only HEAD' '
 
 		# When told to update HEAD, only, the command will refuse to
 		# rewrite commits that are not an ancestor of HEAD.
-		test_must_fail git history reword --ref-action=head theirs 2>err &&
+		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
 		test_grep "rewritten commit must be an ancestor of HEAD" err &&
 
 		reword_with_message --ref-action=head base >updates <<-\EOF &&

-- 
2.53.0.352.gd1286b26eb.dirty

