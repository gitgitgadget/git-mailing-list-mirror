Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4403E275F
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503252; cv=none; b=jNcLHjod5E5/Sjp9p7P6AxTFWlICZVyrz405AzzvCS50vvEZfUvB69POA8XUOVoh2aieaf4EYi5zU/54kr2mU1K1ssU1sGQcPAZo+HbSr79WTJ3sN8ER7gk9+JMVID4UMfSEROldrwZU/5UYwBTGd1ZbwjQPC84ANfWPcYu3N3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503252; c=relaxed/simple;
	bh=+3qTmpihtXs1aYMSw7/lJZ3eoI8LDNvVxz+oHKBwILw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNVn7M2TLK5w+VE+JQHZJPyHrebUfq6NwNB+njqaFRf4GYmTdQMtc2SYpMqFVYPJCLn9HbzCSZYnNFwR9dOonw9LpV3s2mR608rinnzDD2ZJgmtJKL4BP3DI9Tq1tJ+K9FRQezZeOzdcSfGoKDs6aV9QniyfCanJPAd6xrIJixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O2vNT4zD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQGGxJHm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O2vNT4zD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQGGxJHm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F35947A0031;
	Wed,  3 Jun 2026 12:14:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 12:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503250;
	 x=1780589650; bh=SUHf5v4lx4smls+chxXdU2WHw+Ap2Jx5HECZk8RZKaQ=; b=
	O2vNT4zDdxHf3tQb7xVlYcKqb6UiH8JeEpkQL4mgdYVmDDWGkS9jlZSGgF+bfX91
	Oe6LIXQWOW1ZjUUlt3t3NATpSCVnm6qml/QJHL4v/MfF5UF7EDxjKlxHW5IueFo1
	S8DEjPJMEwz6WaSKfjFW5jKhuUdY7OLZWsB713rePHjcxyHj6sm/xYfy8m53O3JK
	muqgMYOPXPuIi/gsd4yHxTqSCYJtcX44JKWW2medAMtG1mIZZxBBdvpX+M+HyUyE
	tmDlazVPjBudM8wnXn6Cs4GF5rtwU8MpSMJBoToFG7hX3EBiY9RIeakpwnkXr44r
	2uZ0S5cJEqb7lHavrbEoug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503250; x=
	1780589650; bh=SUHf5v4lx4smls+chxXdU2WHw+Ap2Jx5HECZk8RZKaQ=; b=W
	QGGxJHmo4Ym6z7E91AbftGMfkFUgd7CH5QnAlg6QS7Z8TiFSisXkksNbAmcKSaN0
	dkmF5gqaT70W17MjgJ/DEtcEqtJJflJf9/nvNKbMEy6Mu8rIDRC4xGDeR/Bt5Eyc
	deY/mCei4trOZn6/OELzHHeYiawZNdP7VtcElXWs5QHUzRqrLjjhGbUErVZOzTrV
	Bk8hEHj3awF8JD8VqsPs1R2jyEMt5VNAi24AGvcmfZdMp6r0IuSpbzgv6wVrMcpY
	on8HCHxPpTMJOgV8OnCEKM58kRULsc3HaEJH2Euv3dSEO7AI4aguPEKF1B6LFi0J
	KxxPtLI68+sLUzbrUZGWA==
X-ME-Sender: <xms:0lIgal7AQJgiKSbh_3RkSjwuHYlUAma0P6O2K5t_2KlBt1jsjDuWmQ>
    <xme:0lIgaqVT4Iwag0lAFg5V1rIGfsCUF2mxo29NgGhU83vWI0xPTceoJwW8VZ7LD81yV
    S43VDqSmwkiXVrTV69tbGguDFZlv68ayi-LNYU4HBu5T2SQQ0cQxFo>
X-ME-Received: <xmr:0lIgap3jQ-0b3AMumacNSdkmRIYNDIsyztLylrIr2LY4x7TldosI4tswsc8nl6gOjKQazogA6OxHoXvBpyzi6Xuz_izFijcTXeFpGYMlCylk>
X-ME-Proxy-Cause: dmFkZTGdlIonfplKpFXa/+DN5l0Fb2humCV2KDAOVEKyP+YPvmRBKflqZmkwAq9rePEQEk
    tFWbGVHfEKLtOw94e3kwwUvfEq/biapgD0LFxEGjNoceagFbAdw8S44lP98A4A6KSEBzBI
    FK/Zaf4iM+7r9UuVe4A2HKmR8OR4YocvA/6wxorfK7uRUU2fV0yzyhSTCXmRlDtYfcUpDj
    W3y4seHxmmHClyvMTnpX7w52yD4rY/DK178Gw1HIPAoq8c0YVNdlYew0Ju9pKEwEpdY7jk
    aRnqh9h1yCWlfj/W0CqUM74g6F8iUs+FEHBRjFPLTPipkR6XYgqphPOg5F7L6g8vVu+vuA
    w48w0bJSC5QbuVr+xMdkNaGvwVXm1vl/9KyIZWIrVC6EdKoSZH8DjlVvWLNYleGq44ZYFa
    kyiyTgNZ8aDa8cvoLsXr7cWOLeh9jSwcYDgpxtNUklcuFehUsfrjKopJuAQTXXx2rA6mwE
    KbmvocmsTaqRYHpy0fM4CX3kaesAvlARRNu2KBHlPYKca39RXU5NJUUJVpKxS/k4Ttaxs9
    T+3OCJvMGORu61c9+6UmLnMpYTrEHe/Ffe7pOVYFjdkq9u2O2vpzCTFXeyDb+K4I5CdvjR
    hIH0FAFVCUA8Y0ZyHUx7yh1+8B38spHOP3OWjNQI5Ae2NzZ16Fvh/dpDr1GA
X-ME-Proxy: <xmx:0lIgan177edM-wcd_1QZAYXIX3Ja4KTjBBzmsMHNgH20khPZB2Iz4A>
    <xmx:0lIgas9drcQRaBPUomko2flVmcU9jtTxTV3ZnyVQjIRszRgV2n0hAA>
    <xmx:0lIgak1sfocRAtNnEMT15Bb22812kMDq5qs3qOjo9CUS2WYa8nwaQw>
    <xmx:0lIgap9U8FDnnT_RjU8OKwt5nNW5r18sjWO-u0-lKDUF0RAjvfSw4Q>
    <xmx:0lIgaiUemFbEqr1xObWoDi7kVYompkm9fw3FBIO6OZwNOiD28kvOOmyp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6967f908 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:01 +0200
Subject: [PATCH v2 2/9] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-2-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In "reset.c" we still have references to `the_repository`, even though
the only entry point into the file already receives a repository as
parameter.

Update all uses of `the_repository` to instead use the passed-in repo
and drop `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/reset.c b/reset.c
index 46e30e6394..3b3cb74dab 100644
--- a/reset.c
+++ b/reset.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "cache-tree.h"
 #include "gettext.h"
@@ -13,7 +11,8 @@
 #include "unpack-trees.h"
 #include "hook.h"
 
-static int update_refs(const struct reset_head_opts *opts,
+static int update_refs(struct repository *repo,
+		       const struct reset_head_opts *opts,
 		       const struct object_id *oid,
 		       const struct object_id *head)
 {
@@ -42,19 +41,19 @@ static int update_refs(const struct reset_head_opts *opts,
 	prefix_len = msg.len;
 
 	if (update_orig_head) {
-		if (!repo_get_oid(the_repository, "ORIG_HEAD", &oid_old_orig))
+		if (!repo_get_oid(repo, "ORIG_HEAD", &oid_old_orig))
 			old_orig = &oid_old_orig;
 		if (head) {
 			if (!reflog_orig_head) {
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head = msg.buf;
 			}
-			refs_update_ref(get_main_ref_store(the_repository),
+			refs_update_ref(get_main_ref_store(repo),
 					reflog_orig_head, "ORIG_HEAD",
 					orig_head ? orig_head : head,
 					old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
-			refs_delete_ref(get_main_ref_store(the_repository),
+			refs_delete_ref(get_main_ref_store(repo),
 					NULL, "ORIG_HEAD", old_orig, 0);
 	}
 
@@ -64,23 +63,23 @@ static int update_refs(const struct reset_head_opts *opts,
 		reflog_head = msg.buf;
 	}
 	if (!switch_to_branch)
-		ret = refs_update_ref(get_main_ref_store(the_repository),
+		ret = refs_update_ref(get_main_ref_store(repo),
 				      reflog_head, "HEAD", oid, head,
 				      detach_head ? REF_NO_DEREF : 0,
 				      UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = refs_update_ref(get_main_ref_store(the_repository),
+		ret = refs_update_ref(get_main_ref_store(repo),
 				      reflog_branch ? reflog_branch : reflog_head,
 				      switch_to_branch, oid, NULL, 0,
 				      UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
-			ret = refs_update_symref(get_main_ref_store(the_repository),
+			ret = refs_update_symref(get_main_ref_store(repo),
 						 "HEAD", switch_to_branch,
 						 reflog_head);
 	}
 	if (!ret && run_hook)
-		run_hooks_l(the_repository, "post-checkout",
-			    oid_to_hex(head ? head : null_oid(the_hash_algo)),
+		run_hooks_l(repo, "post-checkout",
+			    oid_to_hex(head ? head : null_oid(repo->hash_algo)),
 			    oid_to_hex(oid), "1", NULL);
 	strbuf_release(&msg);
 	return ret;
@@ -126,7 +125,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		oid = &head_oid;
 
 	if (refs_only)
-		return update_refs(opts, oid, head);
+		return update_refs(r, opts, oid, head);
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
@@ -163,7 +162,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	tree = repo_parse_tree_indirect(the_repository, oid);
+	tree = repo_parse_tree_indirect(r, oid);
 	if (!tree) {
 		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
 		goto leave_reset_head;
@@ -177,7 +176,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	}
 
 	if (oid != &head_oid || update_orig_head || switch_to_branch)
-		ret = update_refs(opts, oid, head);
+		ret = update_refs(r, opts, oid, head);
 
 leave_reset_head:
 	rollback_lock_file(&lock);

-- 
2.54.0.1064.gd145956f57.dirty

