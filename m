Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6234D915
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718507; cv=none; b=Xi25SWa8rgIXzIMEUhgONHywU/+NJqtl3iiCmEtKUWgE6kyHkb2eZUhwm2G/d1OgmVjLD3niZY7EzoAfIXVxFlm6cLGjhzkoN+HDtI6ibpbacG7fubDOuTo93QIIU5SFe9RZBI+XaiUTE0sY4EtLvIyOSU7ynxhNsCH1XiJ8CiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718507; c=relaxed/simple;
	bh=ljIuqPZzV45ysDcb3GcTxDywucquAPRBr6dM0QX5r7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R66YA746WmAvXs5eWUDHKelDXqm1BfDn75Gpg0DLRfYnW7GeIoNdiccOmG/rZSySClG+gwwaVMZxOkZssNidkORtFuSTRoNWmr2auyBTgqS0G9C3TjseTizcMrFy/Qi1qNoiZSyhmOKKXj8tw8LXH6jwp8ySg+f44yP+agTuIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YlvAj8go; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ioru3333; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YlvAj8go";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ioru3333"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0E017A009C;
	Mon, 29 Jun 2026 03:34:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 03:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718499;
	 x=1782804899; bh=WTkMdpcQL3a+2wqXrE5Kdv0XWihe87PnsYz5DiEFa3U=; b=
	YlvAj8go3hZxNchbuDeceXdP2CLhF3a4ju2r8UO5vnWP9+Fi4pjhEi1/F8PwugBa
	7wFHDWGT4DQ+D9x7Weoe8dH5F60XfMunoswVSoHOl/MWK4p6F1tziyHK1AMpsA62
	FJOPABDSOLR3Gz1gv9uDGX0YvbyKkbptZlxDjI+cUw26a9nb7hO0gOhzEuInPic+
	xld6lEhH8/V32rN5uXQrPLm+suKQAQfRyJIEaCHeAvoXuzK/BMl8P2qmF6RgwFWO
	ek0bi0NceyzjtOE/gvcA7MO8UvdOpBZZGKSax0YjAhnn5xnGG9M077UbrvR5A22F
	Pog7P4BHqvjUU+lLegjgHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718499; x=
	1782804899; bh=WTkMdpcQL3a+2wqXrE5Kdv0XWihe87PnsYz5DiEFa3U=; b=I
	oru3333YF0WpYFktMLW3PHPsEzm6z16XYCKPtS5pRXt71I01uXNjUBSSxr7w9c1f
	8HnXab23HTt5yB9puQ8Xm/GjJWaJ+OKDNvMhTOBPZvElrlFXDHCUxORauIxhcTXE
	BNZdol4pA8m4m4NVa9ztyAsGbt/l5fMxxB/MfAOWL8LaW+HEfcTOfMspUvvm+yXQ
	5Ea+AsGNm5d90ZyCAS0oVMZgQgUwSYud528ykoVQJWT2BPNrKzhSS41wQdxins87
	xheoJ/JDm+DkZRPXq2+D0bQw9RRK5zfKueSDAbVd10C2olyGeR7wLihnLk5saVPD
	qM1bSgHWM9OLSQtwntdVQ==
X-ME-Sender: <xms:IyBCakDUgtsbwQ2GYZHNYOpc3pBWyfTWKDHrju4EuNBcoqy1eQlnxg>
    <xme:IyBCav1OUxBJdojNozFrP7SaJXrn5Izq_a5RPEWiaH8k17NQnXpbtGeu7cZTR_T0F
    ylOcnoSagWPfDvK0lEkITwONjMhAIlw9-NHe0cb1MCVaggPk7nFRA>
X-ME-Received: <xmr:IyBCau2-IWodmu7-dIXIj_efOR0IzNFVJBOlZ_cQgD3JZlsYLNx7d9MhYv0o3am0u3wQ9y0L63I58cILNZGKcIq8ODvWOvmUFuOx9vu13Cmr>
X-ME-Proxy-Cause: dmFkZTE5a4mHemBf4xev0wyCUCuqtMBNEeWviDhsJqhIeirKiFT39tEPp7pEFUmYp4RrGi
    0HqAr5KzZuKoYUr5/qWd0q/s1hw3TeNVfKYc+o3YAKxkOOsx5Ee47qxXQcJakdUc6ybiYc
    RFvb6ZQHMGFfXO+bL5SwAAYSH20HVkUu4RMkFvMLTuyQw+qfGSRaf2mIBS4LVnb9JVnihg
    6QaHm3NLhfJmenfjMRY+7A/cW4Qo3eW339AbowxYSMLr2CkF7wA22n1hYRFaUiMQN1pvVL
    29cq1XMDjabBP+a+444lkGtn8hh5sQ85B7r6O2wa6sBssTE1PD/bOeTYEMrdYYnAOVf6Yo
    pknHyuYhl+4W3PKdRYOXxmeXbooUv2a0ddq8muD9gPPuuLVgYpHaAOQZz0+MxWvyHL0JW5
    H4p846YpLzOKj+imCP6mPE/ILf1zm3+hopIBJTEBqRGYZdZJpXWnuHrO/VFoKQ7L3E4reK
    /OxCaBJPiX5yGBLso0mVHDVcNsrClZ/V4qsuQitpyG+/R+vZAfK7QKdWldghwCvFNjRrRc
    7RlzUoTZv5oEKVji/jUnU9z5lRSbKMRPqZoMYcGBMquTdHcs476hnxCEEdFTYeSamNigmS
    S9YTuxoIBroxK8X2hZFG8wq+OO+EbOIxUYDVbqx0XIK7z26touNWeBMCrswg
X-ME-Proxy: <xmx:IyBCasBXk5njAtxbOddLKVc0a2N5Pofx5ffMc3_fLqYEJFH8PGy9Qg>
    <xmx:IyBCal5Tmzcx5qbNLFyuiP0bNKXe7E7g8fSElSoweo4EMR8-brDfCw>
    <xmx:IyBCalL3fpd4LEqdU2WcHSUFA46jzDyVMrXTpMwjuP0iwVfSynvcvA>
    <xmx:IyBCauvVHpqe0bZqv3dXiIyg6p5t_7SJAsOKeEiozmmtJPYHna8pIg>
    <xmx:IyBCauf5Nifx2h3Kg03LZRjR790vysGTLx0QA3utm71cC5XGh_LpyOCy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4447782 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:36 +0200
Subject: [PATCH v7 10/11] builtin/history: split handling of ref updates
 into two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-10-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

The function `handle_reference_updates()` is used by git-history(1) to
update all references that refer to commits that have been rewritten. As
such, it performs two steps:

  - It gathers the references that need to be updated in the first
    place.

  - It prepares and commits the reference transaction.

In a subsequent commit we'll want to handle those two steps separately.
Prepare for this by splitting up the function into two.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c | 100 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb204..22b9fcb4a4 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -333,21 +333,17 @@ static int handle_ref_update(struct ref_transaction *transaction,
 				      NULL, NULL, 0, reflog_msg, err);
 }
 
-static int handle_reference_updates(struct rev_info *revs,
-				    enum ref_action action,
-				    struct commit *original,
-				    struct commit *rewritten,
-				    const char *reflog_msg,
-				    int dry_run,
-				    enum replay_empty_commit_action empty)
+static int compute_pending_ref_updates(struct rev_info *revs,
+				       enum ref_action action,
+				       struct commit *original,
+				       struct commit *rewritten,
+				       enum replay_empty_commit_action empty,
+				       struct replay_result *result)
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = {
 		.empty = empty,
 	};
-	struct replay_result result = { 0 };
-	struct ref_transaction *transaction = NULL;
-	struct strbuf err = STRBUF_INIT;
 	char hex[GIT_MAX_HEXSZ + 1];
 	bool detached_head;
 	int head_flags = 0;
@@ -359,34 +355,13 @@ static int handle_reference_updates(struct rev_info *revs,
 
 	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
 
-	ret = replay_revisions(revs, &opts, &result);
+	ret = replay_revisions(revs, &opts, result);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (action != REF_ACTION_BRANCHES && action != REF_ACTION_HEAD)
 		BUG("unsupported ref action %d", action);
 
-	if (!dry_run) {
-		transaction = ref_store_transaction_begin(get_main_ref_store(revs->repo), 0, &err);
-		if (!transaction) {
-			ret = error(_("failed to begin ref transaction: %s"), err.buf);
-			goto out;
-		}
-	}
-
-	for (size_t i = 0; i < result.updates_nr; i++) {
-		ret = handle_ref_update(transaction,
-					result.updates[i].refname,
-					&result.updates[i].new_oid,
-					&result.updates[i].old_oid,
-					reflog_msg, &err);
-		if (ret) {
-			ret = error(_("failed to update ref '%s': %s"),
-				    result.updates[i].refname, err.buf);
-			goto out;
-		}
-	}
-
 	/*
 	 * `replay_revisions()` only updates references that are
 	 * ancestors of `rewritten`, so we need to manually
@@ -414,14 +389,41 @@ static int handle_reference_updates(struct rev_info *revs,
 		    !detached_head)
 			continue;
 
+		replay_result_queue_update(result, decoration->name,
+					   &original->object.oid,
+					   &rewritten->object.oid);
+	}
+
+	return 0;
+}
+
+static int apply_pending_ref_updates(struct repository *repo,
+				     const struct replay_result *result,
+				     const char *reflog_msg,
+				     int dry_run)
+{
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	if (!dry_run) {
+		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
+							  0, &err);
+		if (!transaction) {
+			ret = error(_("failed to begin ref transaction: %s"), err.buf);
+			goto out;
+		}
+	}
+
+	for (size_t i = 0; i < result->updates_nr; i++) {
 		ret = handle_ref_update(transaction,
-					decoration->name,
-					&rewritten->object.oid,
-					&original->object.oid,
+					result->updates[i].refname,
+					&result->updates[i].new_oid,
+					&result->updates[i].old_oid,
 					reflog_msg, &err);
 		if (ret) {
 			ret = error(_("failed to update ref '%s': %s"),
-				    decoration->name, err.buf);
+				    result->updates[i].refname, err.buf);
 			goto out;
 		}
 	}
@@ -435,11 +437,33 @@ static int handle_reference_updates(struct rev_info *revs,
 
 out:
 	ref_transaction_free(transaction);
-	replay_result_release(&result);
 	strbuf_release(&err);
 	return ret;
 }
 
+static int handle_reference_updates(struct rev_info *revs,
+				    enum ref_action action,
+				    struct commit *original,
+				    struct commit *rewritten,
+				    const char *reflog_msg,
+				    int dry_run,
+				    enum replay_empty_commit_action empty)
+{
+	struct replay_result result = { 0 };
+	int ret;
+
+	ret = compute_pending_ref_updates(revs, action, original, rewritten,
+					  empty, &result);
+	if (ret)
+		goto out;
+
+	ret = apply_pending_ref_updates(revs->repo, &result, reflog_msg, dry_run);
+
+out:
+	replay_result_release(&result);
+	return ret;
+}
+
 static int commit_became_empty(struct repository *repo,
 			       struct commit *original,
 			       struct tree *result)

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

