Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7D36402A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113398; cv=none; b=e/NEt1XwEJICM6y17PdqCN71L8detkABxmZ6nsWpvuI1RPX+GLjowp71AU+xkEQS5fO2j5BmSRK7T9jjmLJVhPxqKv3fH2qWXNrdG1GyS+K4h/tqPgbTCU7L6GZMLE6UKyC3FKlj06QLbX4ufBXcOvRM3FHvZ2fmtpQrLZ0bWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113398; c=relaxed/simple;
	bh=gxwY3F5PGniZPgfmYkIbeul/qavCwA/qdn7Dcsfy3gM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E5t62MacNEnY9yWRNFqcW6kOCDEhUF/3cD02W802yE1R16s0zalM3Eyb/3b1ldjJhVrV5wxiBtnya1evuYqJ+ZgLYKxUDjkQXWoQDOwG053F4fCkh0RKsuhwy9Yv9bz2MQbagyQYrqgfpQ/oLeqkm/cUQmdhxXXNJxlkwc9CWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Or/KlV7O; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or/KlV7O"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30c23abc62eso1671273eec.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113396; x=1782718196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVbknJc43cmJcNCmIFbjtWgd+wWdw6OLvTIoBRv8HDo=;
        b=Or/KlV7OemgVKFQf6QrpcAOTZMZZPe3uqWOjd0jQQUNqeK0Ej1GvYfb/bCMndOTQAQ
         8mP2BR21FtR8rG5e7hca7nA6JIr1yVgh9yRMj4TGzgDpyLTa96P2GLvuAQrqAyGI0nj6
         YX6GTLYypqeTGWW84SJnroVdcpF1x88+EFm9hRSkGTct414U0Rmvs6cVv/w1N4cHgmdY
         BrKNsE+UBQz6pfMysJYkUZ/LBgXoBgV82mUc23zF556tnfUSNuRLbZLyGOlC5+XF6e4w
         KI994V2EJeetMH84X7YQxUNC+eG7Yi4JCMDZJmoIFSCaQcCWTVkazB6PZ+VAZQuKCVWL
         TQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113396; x=1782718196;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVbknJc43cmJcNCmIFbjtWgd+wWdw6OLvTIoBRv8HDo=;
        b=FtXa1GVUUmtfH/Ac7JcrgAPq5Okoj/eyCmL0RQxQVOwe480EeAFLA2STPoYY6RWe43
         itbkvCjNu9bYGSDNeSftWN38ggkPyCc3SJfTxA6WSACd1knPw1siZIHKMJIfxPeDSXDt
         B7vnbaP7VH3HYBlTtoZEqhsdd2Qrh9dfDzdQRb/vEEET16OrIGHuweudxrwDiJVc2xth
         AiT3pWMDnfwxICEjCjZyzL2PI2uhwM02Iza49X2Gq+BzLBJtoR5hZPOXRTYBOTcMidOK
         bBAXTeuGi8NOWVmduhej0JBWsmxCxIR68PefIX6zUgqas5KUxClyTMXt9ml219345GCv
         AczQ==
X-Gm-Message-State: AOJu0YxW9qDP7rzqYkIrzxD9lZf1xEputvDqLzcFbiES/crVPALs1Lek
	ITKGU+v3dJtPvBPBWE0v7s8ZevLktrjsRc9zUe48WC7HLM1H3CNt4GvvwJ0ioA==
X-Gm-Gg: AfdE7cljmNdC37m03hfSCgx9ck19Ap4t+8QjOwnIGqIfKV5NObPl1xCZRBHA7vAabeB
	jLrNCbbo5VM+fUBsyPlbdX7lkog8tHTOYSi83EDZ0c2Bs+T+B0nIzaibWD40U5+X4VC2s805W9Y
	NUq4DNd2ekelDvXcaOqa9Kq+Y+Fvs7FmqTDImfZv474xFEb6BKn5pO0VouqAlhnQO6Vn4ORZ2L+
	rEcB3WxJznHiPDkutjFGIvhbNOgspwh1u547IMQ8ly2M4xkCttPgOh8BpbLLRb4ubt6ZXUjlhuC
	WSlSOpoxRyBty6qGw0IB3lOo3cG4opkRG1T90DqiDzasiTufm6HDtuJ0gx0LQi3JKOR2lLVXGfh
	OQHQFcV5KcTf4DA2oOnA/zwWTVRRMyNtRtgO925xp5mtuw8yveLk3R02UUoZ+4Gc+RowMZznb0Z
	H/EGpmRSTM2Qd6hS2YkQ==
X-Received: by 2002:a05:7300:6422:b0:2be:1f58:32a3 with SMTP id 5a478bee46e88-30c0716e2d1mr10755933eec.29.1782113396124;
        Mon, 22 Jun 2026 00:29:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c44ec51b9sm2011934eec.29.2026.06.22.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:29:55 -0700 (PDT)
Message-Id: <80518f5d11bf0594aee907870e8f72d90f695aea.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:45 +0000
Subject: [PATCH v17 4/7] branch: prepare delete_branches for a bulk caller
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
 builtin/branch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4c569d056a..01c1f64c73 100644
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
@@ -193,6 +196,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -241,6 +245,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
 	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
+	bool no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -268,7 +273,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	force = flags & DELETE_BRANCH_FORCE;
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
-- 
gitgitgadget

