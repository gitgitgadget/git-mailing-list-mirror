Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667A40F8F6
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542055; cv=none; b=GUkob6sma3qhNhx/AYsCH6Ed3fQ/Bj4aBrckA1gRy8cqnDrwcHM1ZBmyVT+zyvAJCEDTuFORaYomQHYq1VuIU3Wpo2uOhwUIculeevFjDneEFX6XDqwQBnZs4J/ZTctHt8WKbbk/wdOhAGWost+rz+kDs6aFVa3LNFjyrktsx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542055; c=relaxed/simple;
	bh=R722YYMFCNumLlRbEZd8gEj3tzLydkg6rygOUVW/jyc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lOU+5WnFAVKtOLi8Nr9jLJfn/iHbnlOe+enu1wzgqgm7XZUF3Rximz4QTIRe5bEJpY/frotlW52dTVQLfwfa8sg0aaJn7uX5XIoA09QqNwlV6FP4nvNQTKxZ2VBb8dGAflQ3kt1yLB3yFZAPvnZwTwAZGoMuFAqsU7pgSbYXOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/OKROLb; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/OKROLb"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3078e0dcd67so3811220eec.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542053; x=1782146853; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFF88vgzgWTjwLRD7PrCaWM6puVWHCydg6dfHxEVo2g=;
        b=s/OKROLbpZulJjmZNLSnvjHBvAU+u0DB9tzILWJm+cLfwTeLt4xtN4FoC/tVjgGKWX
         SrYYssg/Otl/w/Dw93noPt+vnBnRqjPtCbcCD0WOdGgpbRRzeM15/nYA+EhHuI4z0D5K
         eQUO7AlnS9agZ3UKIFz+ITpqk2F2aiW9ClzxgiNsyBeBRyMoCHWgxZxZNuOaEem3zlhs
         iapzRxhCWLV9oyW5Vdp8h+Kk2908cx/WjXDP0YgzpPEWOnSDOeTxSD2+rTAyB04Ul12a
         G8D4mtiS40EjoiRZN4T8CPyQYO04ZU6POop6f//MElNu+jVcuenD7vGkiZXASf3TQOd7
         vFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542053; x=1782146853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFF88vgzgWTjwLRD7PrCaWM6puVWHCydg6dfHxEVo2g=;
        b=aLzCsoQp4yKBDgAVig63eT9oxSN+hRkPMrx62RDZx0e2PZyUT3RaXfdHP+Srq/DmVT
         HhF0vl/CADB6g5fwD+/UXjf+ptV4viffRCH2u2e9UKzFNCvl6PM1Id0C28FzSWTXDDf0
         vksf2Iu8uGBJXugUQ6zYzCjAq7nN/JW6gmREWR/f7TrsQdtgHE0en4wSa8Qydbj8CgCJ
         3wWGskmI5VygWRXmTOkwy+3EIRESQkGb8MNgcXICDAmRkXVHjh9WLjCRUhgI/Q7TgHGI
         mf2+QAHacDXY/ricQ6ksRZY6mdnxZPcNmuIsGGz0XENHdzKu1elIJj0BN1eim1HUHSPp
         IiIA==
X-Gm-Message-State: AOJu0Yy1wRUwPYZGkUWwwhP23hyRb6YeghbOEj1wOTx8RLbzfkN3N3Mo
	yYtcq2p83rmqGtgVY4QpNeddrYyjXyjqOmZlT8O//9jMuLnp487fnntuc+NlFQ==
X-Gm-Gg: Acq92OHhfGvhz6Zx67FGmw9xbVFPkeEQc1ISM4DZGESts8ghe2TmL1z5pQLB9QbbQK5
	bLz8/dmnpdmEAtS9YsZ/4AOJQ8CjiAja7pO6gXBMve0bzKW1ORmRBn5d679aNMNAXJjORxBhs1j
	4xYwkWnSgthaygvPHPWhvLRGsqPtPhwmM23eabSRxhf+ywlt4GF6t2wgceeKiyNDq7jpgzG1EmQ
	0CN8gFwgC0v8ZWppLNK5xQWs9fhSWmNqz+P6B1B68NIQWNM0wFixisDXgDp9TezYh4/647LhqEE
	zl+c1W7X3FrKyA9Yg8DWmiT3VgWi5ga1hSxli2DZMv3hesafID9rNC9jvK1yQhVyVn0bakJNfq4
	kl3SCFCa2PZgHTEae9VzDY99ZIEEt3WiyqVJI/FpnSNacJSF5VQKAOaLkxfo1+HD1hm+a8ARP22
	Obyu5Az6pYXq0PYC3nMXqUV6Ak
X-Received: by 2002:a05:7301:169a:b0:304:cc9c:35ae with SMTP id 5a478bee46e88-3093532e192mr6430918eec.4.1781542053252;
        Mon, 15 Jun 2026 09:47:33 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm17081969eec.7.2026.06.15.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:32 -0700 (PDT)
Message-Id: <6c3534901ae4946de85b719be8e9fd9bf16b3dd0.1781542042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:19 +0000
Subject: [PATCH v15 4/7] branch: prepare delete_branches for a bulk caller
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Teach delete_branches() two new modes for the upcoming
--delete-merged: one that asks only whether a branch is merged into
its upstream, without falling back to HEAD when there is no
upstream, and one that rehearses the deletions without removing any
ref. Existing callers keep their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c569d056a..1d3f28e4cb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,10 +168,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -193,6 +196,8 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
+	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -241,6 +246,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
+	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -268,7 +275,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	force = flags & DELETE_BRANCH_FORCE;
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -339,13 +346,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
-- 
gitgitgadget

