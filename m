Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43638E8B9
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249438; cv=none; b=m8FQela3m794Fo/bE3WqxuzJNODUZkFfkbxbD7snDSWYdBu9iDYn5B/MmvGrLmJV+H+MfQtXJUGosM/XEFbt151dtm+JK3Waemm9eMaFqln8U6xakk8pI0POfK6OKrvPwd1pqAvPbKearyxDSeiykWFY7ph+hMO5gAaMwBPjse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249438; c=relaxed/simple;
	bh=N/7TUrm6vOe+kNW/w55de34FWofa1fGLe4BX7byRVGM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k0FR0nocCSgMmRQFRoR5b2N/nNBUb9bAEO0xyowiyzzr6ELtL29homoCRusXG4leKeTbwkhbkVxW1QgIFj/JiiZ9ZW68bSP9l1XcvZEdwYEYK0RCGOSfx3mn6PwjGUsAGj/6RsqlipdAFqumoyBGaxfxbUF+s/NYqmEQUPlIg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfkMLtpx; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfkMLtpx"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-45eb2e6402aso73645fac.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249436; x=1787854236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=NfkMLtpxeSYt8pD0FDtzaxUX6dLypLtu5w3476mC0DL5TCTqoaq3w/jqwij4qNS+ja
         PJTqUc0o1qgafxzI2caxVx1NEAyb3jU5lMOTcSvX0PQPrhq3f76ee9gpfJhrzVZIvy3y
         O1XVEGeZyEo20ooW/tLEFQNtx3ZJ+p5qybvCNRJP3lW2P/nzqJLVY3Ht4aqJZ/1giMpz
         BpnTEE8sLErkdWTqy4yMDPkDrreq4jfiD86+VPe8Ze5uFZR1CGAqpZweUS26/zPjLAeS
         oeNZZ084lZdIuiT/0kdpDRUrVW3TV+4t8imDVxchzh2wA0kr7jT+mm7kIdSNp8DZN47X
         302w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249436; x=1787854236;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=muWP6kZPhgxpWSJJxVEmWoQz2K2cDdqSKJEfFqaeLhwyX0RFcpoNPkv7/8YqLC8/pB
         yZTa3J/fF+LHipaWdp+2MoVkM8o+0bFC+1BsL8W1cW6Wp1lxEO4nsUb3Rq8sNDkuLeS+
         GQ8tsac9cHnZCUdGB4AsCW4+ttl7MWyfLw+Q1D2xFxI8JJKOCCbTj1Zb6WMLZlGV7x1v
         ldkYypOvtdHI0EIrR0GCVPJG2yFwMlrykWtZyvdea8Kn32w7uA4jd5D1UOP8W96neF4U
         1t4WhQp4YhyVu9JlE8GzncRiE3hTYG85tPZj0xU8oz46R/Hzc7fn3g6t2otQzlTaPt4I
         k8Zg==
X-Gm-Message-State: AOJu0YwJ5QnFp5SBIRYPxzFJZdaK2N4m/Dy1uR40bpVifMpcnYh9BKOt
	CUmohraWdcDyXJvkL6gynoBV/Dj0wF68O0ReFkTbxzlU0KXOPUpg65BVj/hqiA==
X-Gm-Gg: AR+sD137yzSLw+dhStRU9rpt3KYfUcNKnGZ94sVuAEITnnmQ0Ao5yj46YKcrK37ntCN
	LKu3wPIA/Mi/+aADxvF41jhtYjFRT6rNAM3vaox9gUie1qR5ccHsUtobOwvei7J2D/MsggA04jp
	4D7tzNNhoWIJJWpuXn/G81RNaSuCs/QQPfPFvwQYfZSEtcQ3v3+Zb+tXVijJhxArZd097geZ5ZN
	hUlpbN9a0Q/9xX+D0firvy49+Uf0+vazoFf9VpNgnMIaTGRzAwz5lZL/zhPUbPBsSHP6hbM6oh0
	OyW0IEBXLrrpX7DE74ufinhH9dIFYzAAFdpm+t07DMqjVs7vnKfeB7iL6u1g3SOvzEo3CSe7Ere
	KUGlxaNz8LTM31g8f+6Cim9csj0SAlwdt+DcMByZWzd636dBlHev/Sg/HK9w+lDfsSu7RaaDnNz
	NVTipWxe52xc7koUJxwY9FISN2st6QWxoQ8rDZUVrEOlQnJBtS967XV0UaOhqgHf4e
X-Received: by 2002:a05:6870:b88:b0:455:9a0a:f40f with SMTP id 586e51a60fabf-462f67af0b7mr16729517fac.12.1787249435992;
        Thu, 20 Aug 2026 11:10:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.251.200])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a54fc4esm2232278fac.3.2026.08.20.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:10:35 -0700 (PDT)
Message-Id: <19c5e311a34978345223b3c589fdd9810c4eb207.1787249432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 18:10:25 +0000
Subject: [PATCH v14 1/8] history: extract helper for a commit's parent tree
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Three places resolve the tree of a commit's first parent, falling back
to the empty tree for a root commit, each repeating the same parse and
oidcpy dance. Extract a first_parent_tree_oid() helper and route the
existing callers through it.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c | 58 +++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 000155ad9c..c22715d848 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -164,6 +164,25 @@ out:
 	return ret;
 }
 
+static int first_parent_tree_oid(struct repository *repo,
+				 struct commit *commit,
+				 struct object_id *out)
+{
+	struct commit *parent = commit->parents ? commit->parents->item : NULL;
+
+	if (!parent) {
+		oidcpy(out, repo->hash_algo->empty_tree);
+		return 0;
+	}
+
+	if (repo_parse_commit(repo, parent))
+		return error(_("unable to parse parent commit %s"),
+			     oid_to_hex(&parent->object.oid));
+
+	oidcpy(out, &repo_get_commit_tree(repo, parent)->object.oid);
+	return 0;
+}
+
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
@@ -171,21 +190,11 @@ static int commit_tree_with_edited_message(struct repository *repo,
 {
 	struct object_id parent_tree_oid;
 	const struct object_id *tree_oid;
-	struct commit *parent;
 
 	tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	parent = original->parents ? original->parents->item : NULL;
-	if (parent) {
-		if (repo_parse_commit(repo, parent)) {
-			return error(_("unable to parse parent commit %s"),
-				     oid_to_hex(&parent->object.oid));
-		}
-
-		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
-	}
+	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
+		return -1;
 
 	return commit_tree_ext(repo, action, original, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
@@ -475,18 +484,10 @@ static int commit_became_empty(struct repository *repo,
 			       struct commit *original,
 			       struct tree *result)
 {
-	struct commit *parent = original->parents ? original->parents->item : NULL;
 	struct object_id parent_tree_oid;
 
-	if (parent) {
-		if (repo_parse_commit(repo, parent))
-			return error(_("unable to parse parent of %s"),
-				     oid_to_hex(&original->object.oid));
-
-		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
-	}
+	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
+		return -1;
 
 	return oideq(&result->object.oid, &parent_tree_oid);
 }
@@ -830,16 +831,9 @@ static int split_commit(struct repository *repo,
 	struct tree *split_tree;
 	int ret;
 
-	if (original->parents) {
-		if (repo_parse_commit(repo, original->parents->item)) {
-			ret = error(_("unable to parse parent commit %s"),
-				    oid_to_hex(&original->parents->item->object.oid));
-			goto out;
-		}
-
-		parent_tree_oid = *get_commit_tree_oid(original->parents->item);
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0) {
+		ret = -1;
+		goto out;
 	}
 	original_commit_tree_oid = get_commit_tree_oid(original);
 
-- 
gitgitgadget

