Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A92D7DD7
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338106; cv=none; b=MjSjPTyMmWhcvB+lxqoIotN8SleYe3j9CwfeYnoYPfFeXlT29ryFkSvEblJr6cgSRC7QCmtQUR54WqNtoBrGGhJQ3NDfDQNbOE9wz10grKkbTW0bFcTvI1rmHqIm71tPqxRr58TK3f2vxDL70qO6H6E7U2A+Y8CiK7TwITYPPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338106; c=relaxed/simple;
	bh=Aieed0Ab3Y4Dhk5Bw+SRCcVyjjkjozfHkljAft8EY2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=troYIpFl4BW9rrZaZVzsxMLy0JVjKIqbvN+IXfNXEgGpFgmAHMQskiFrJ1utU2ne3oFJ1Hsy+X344D7sO6crzOcDzD8K96c5HNMaSx4nbJRl88DzpJ7ljKIt5jOF3RiHFYqt893Torl1wk3k6Xqj0JNe1j1KsTwI7wmfewvRkvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr+jePc1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr+jePc1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8db35680d0cso2749156d6.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338105; x=1782942905; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=Tr+jePc1JRz8wyKhuGsCmVqWYHHHwIPJuWuAIqWSURXKfRrlItH/p4E/abPmYeK3Vr
         xsawsI6bfhOZLMczFC8FUhlvRTmx5D7r+e5lGMSsjLVQMSY3TWqX81/sBimxYrlJ5+2M
         9D+ta8L/aIDxYF2jh8fBeDqqBHpZ5iTmRVi7MYOCrtC4cwQ6bUY3576lJq3i0aD6vCIv
         gkZuAlKlRXc4VFZWPNuah4N4CLiQPcgc+E9CpYClxwynDUGGDUzZ9QcyrI1iYFrX+LpX
         16sVS765aPc7t/GLnfbVcR2m4BI79+XjvBjoWxZR/zo6eTXDXmZiZ8vlaz03kSwoNgRw
         CNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338105; x=1782942905;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=i2XpPYOb808zh9r4T0kDxuBy/mOXE/eFZDOmWs61soVwAu0MeWDFFQFli6m/ETayGR
         tT1zQ+fF3tuPIUbjCxWuWUdggtkrKQC/qYW4Z2XEcvH6gD6CxRoPseJzWkyQn2CAmFjQ
         iEB0aRcMSXuCgtWR4JWIvuPSUmNcQeqXDKJ9JaI+eUUfsf3FXRCtuBsLgyb0B0X95RXp
         bR5kBoYHpogSr5jTk+WOmyH5NGknjGL+nT7ZsAu+ggMzbv7wPlWj1TWbvYbez1T88FRx
         GDPmmyFvdr+yZg1Y2tUOIRPwQwNcDbGuDCPb4Tpb//k7n4jf+J5X+IOIKA/VGPyjNTxi
         8L1Q==
X-Gm-Message-State: AOJu0YzGwYAL/TgnxNeJaUBKVKynNmRAp2ugJ0iSNwnUlPRBotLnkj3J
	vOhU2iYaSVzVwJFYH5cJ+Wtq68p3iFcXbL4G+MSMj6JR831IXldcDgw1/Y6whGsu
X-Gm-Gg: AfdE7cl9MQBZsEerPCbHm01YVEl3koeSTLVsSS3duUF8pEVZ4TWsgtb1MfmI5OHZfMq
	5SmQ67LheqFpEEAwpeLwTRbBZUUNlf//Cp+6XNw7lqUBBQveoiSliQrEzepOlYjq84Hu6H9PZ6B
	SX/vlUwXa2SMz1wNIG8AE7lPRtQP6fIKI/tF33LR14R+6+phQWDZEErxcmcAoy5DyXjpFj9dN9W
	uM6RZY/2vDk5tVTX1uEf756nWENipwsplOU0U++6gsOWKb7IGuIgTWYw7oN3x1SARPd4SwIjZkN
	z5kU+ZiLJBzNJZ/J+ErWSqSWtrRw9Fh8glzg34eWNHt6TJFFUs86qR8TBvwhF98ThvZb4EuXDf7
	eJRfRzk/gsBX7QISHRN0pwnvUEdwOQgOZ/TO0dWlxtN3Rn7nKMTiRbQt3B2ql2hH51zrByFGmyf
	VxjEPFFm9x0qr7Zxpf4elypSBmhw==
X-Received: by 2002:ad4:4ba6:0:b0:8dd:54c8:c841 with SMTP id 6a1803df08f44-8e3b6c23f58mr103512876d6.25.1782338104447;
        Wed, 24 Jun 2026 14:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.191.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdd8e2sm166547106d6.27.2026.06.24.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:03 -0700 (PDT)
Message-Id: <0f1ae9b05abff4777edc5090c30f5cbd7af16a2e.1782338102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:54:59 +0000
Subject: [PATCH v5 1/4] history: extract helper for a commit's parent tree
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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
index 091465a59e..f95f26e684 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -157,6 +157,25 @@ out:
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
@@ -164,21 +183,11 @@ static int commit_tree_with_edited_message(struct repository *repo,
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
@@ -444,18 +453,10 @@ static int commit_became_empty(struct repository *repo,
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
@@ -799,16 +800,9 @@ static int split_commit(struct repository *repo,
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

