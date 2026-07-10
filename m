Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D03D649F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674405; cv=none; b=jfIgKvNldGGI5Ze2Mh6AQeD8UjzhigpdC8GPkhMS//iQavEo4cGJCzrIY11o5nRxo6TGL+CZ8I/3yYHzHDFGPQvacUKSTY8IxhI+fXQZcfBaGvJkBo+0CI5hVsfr+usyrgYia4lCN70rBj2FEZTweZ41GU8S+L/iM5bUNldguzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674405; c=relaxed/simple;
	bh=LgcZcASSmdDaWX/9Fl3YtCMi6FXzbJphsS1lXcE4Mr8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fIbsDKcyEJV5KhQIh/iCi6NC6/3Oaw4fS+InattDu9GMvZHBpVQX0QAHngl8AJCrkjmh9GVqMUh7qrjXqev5vMXIqxkKdMN4YT40AWxK1L8RFzlgiPvZdM9AvyYghzui9hCxjSTwXfEqZec8FHf/4HqMfnuwo34mLNEhHXPQTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCvoWm8S; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCvoWm8S"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b554044fso659020a34.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674403; x=1784279203; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R/Drl4QmOGkoWQT0CmGfdmq/g5W/9fiTTPJZ6xzDKVY=;
        b=PCvoWm8SpIcHvTBzIPW+p4/LEXF1s3vEtZ3u6I8q8mFZl8p2rlczUGIFwVlrsBlofM
         0M+6LcG6UjPpMhHRJZSHhx0tk57AzBFzr9c0WFwbKUUExGTekspJFMxca5qOdqPYJGWm
         vyB3lP6NMNcYieg+N7OxRgUmgb8NBfqnoN9KdOFTmvzOygqiDE68+n/4VepTTtaAqiNx
         4tmXBr6XJBYCoCqyIybCaNP/rlaVk08ot5rcnZ2iw2ogFjmENY7n+HcflXMWMSSbqJ1n
         nG5LgrjKdkxoipAprJgQIzMlIaUUIVQ/+2GmpBZhTVHPvb2q6j5tSl6ZupRgg9VlPQ87
         rXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674403; x=1784279203;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/Drl4QmOGkoWQT0CmGfdmq/g5W/9fiTTPJZ6xzDKVY=;
        b=o9iCA7gfYu7Wd0vWGeJwQz3Asj3uYjMxlR/JnT/f8VczK3vCzVlSYIOTx8ql9YoLyl
         Hs97RlS987xn7cn+TwBupuwUhaW552cdJEiXl+x1yXQhExyDt5eeazY9NiuUXZos/1NR
         +EFJFdXJLiPZe7UQJZ2U0rZPR1HC4iXAz7tWxmxvXKIGe7JtKz8FtJJ3ePMrySvAUMLf
         1Vh04ITosNXiz3pVcu+4YnzsDsbfn3UcuXhjqSq3JKQR5shnh5KSqSdowXkdX9EoM76e
         luR2ELx2ofqOhItX1ZcY/MlOUgnoR0dzFm0+neCaIqSTI4L81BlCh2aVc396l+PySRq1
         dySA==
X-Gm-Message-State: AOJu0YwNgYDtFlYJ318o8i8PzqZ7j2C6NL9PaCGr3ydowezI1bsMve80
	XnywyWTsKnucYP0qbYl5Z7lLoT2v2SQoMCeKAWdeBl7EC59aNACX8eGzU4ZXUw==
X-Gm-Gg: AfdE7cnSD5jGVKsG2JyuXzQMAsRigmo/HHGi1E/vuty8yKxao36vZJdBJzTBMoxrNZ6
	kOBXpMQb6ims52v3lnrgYgi6YYkzJBNmooKTVlQcoC+KQD1tADFi3pzApHgi8d3u5AzzLu4apHg
	8gc923PtHPIwZIC9j7lPaSqX89u06ef1MJ5NrjGYcwXphufFJgk5Agxp6NZ3OTwIOobg2LuVWOn
	8ddzPKGQIOPbEO+1vFGkBls54IdfV2X8f/nOcytkq4X5Q5C9bhlnSdOKKmI2ZrHqrFrsVivNhyH
	ihtuyaYMhpmOfLD1hsMXsx6G4mp0z4pla7MFyazp4RdFPikjnRA1jMr0FkBoGVQwDmE74+5S/FE
	tuSh0G8Sg8zCBV5pWPTe9C9Mbl8kRrfPmT9+71fr5WLxDXOGLdy2iNJPBaM5SE2/EKRyQU5wgX+
	5PzYuK7G4ik17si9U=
X-Received: by 2002:a05:6830:82a8:b0:7e9:c8e3:4473 with SMTP id 46e09a7af769-7ebd02a39famr8749774a34.16.1783674402963;
        Fri, 10 Jul 2026 02:06:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.20.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4519d89f7desm3548559fac.7.2026.07.10.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:06:41 -0700 (PDT)
Message-Id: <ba77752282e400de0af7082d54d861596e78fa93.1783674396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
	<pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 09:06:32 +0000
Subject: [PATCH v8 1/5] history: extract helper for a commit's parent tree
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
index fd83de8265..9f516687fe 100644
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

