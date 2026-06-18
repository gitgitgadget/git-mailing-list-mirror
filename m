Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7F2F7EE2
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810232; cv=none; b=GfMImLsA3C4tVh2OWDAzJNWcdKm3Sd0t3JkstFDdbIxo6zLgK9217ibxlNeo8vUQzUcnHw2JK34OywRJ7bguHgVL+n9sTuFAc05yB2JAPaMwvB19BxjsdpqxjCWNvnsej5+lT9ro6dtilj/Yzq9vAsyG3YwyBNpTqsY4ZELHuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810232; c=relaxed/simple;
	bh=Aieed0Ab3Y4Dhk5Bw+SRCcVyjjkjozfHkljAft8EY2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jQwqAhyP52h330Gw2ubZeTJbgcZYYTrLRzcCD3bQ8BfhCArIRlnPpRBsWoXPXgwdf7GYfiJSwDI2Cy/MTw+Ps9icf8t5noGc6AAm2xvlBNEFWVTuytjdiEyLwkKYXWt4bC+JCOF6/0aUEBnpS00WUZh+ndGmNZ/f2wJeFAziVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Suh6QBr7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Suh6QBr7"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9157b895c57so117916285a.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810230; x=1782415030; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=Suh6QBr7LRoC1ZpuQxFdOT4s24/5NR14J1vhJcVy719nYbu86OBBDJzTSmeemF7y19
         zHfsIFMx9x7OLu1EE1erUKnH7LXBp0n0Wt7OJf7mqDGUsTqcG6+24b/1TTWnskQwWQ0W
         HBHMfg21a5R2J/c3keC9AjegB9n3z3rABVbVZK70MGRVgGtG2tP2f43pQh6uym53wDHi
         cNULGpKohJmZNLTrjKUdOrwMBuFTjd+4UjgMfGWdbrJpnm2EF1SsmqDqq6n9YJrHDzxF
         gnZcIvAvQPDnMTdB0tdja14h9UiHaHex5CmEBnlVkJQmTry9XjlNQbsvUShj3zPFuEDx
         Rhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810230; x=1782415030;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=f2TUTbjDdJew/TWwOjMtuVmyiIwimhTrhbdegnmUlM99LW9lncd/ZcZyF/3zFNmEZ7
         eXv0XhulvxdBI1bS6g3n5whsx5cqf4gzRR2Rp9HylbZBQMIGprk7YVyMl+wstSafhCiE
         5pkSsVrcTzayQIYStgD9XK5n1WCRbpCX1RpO9mcsSsvyqGV2aOh5vPVp3bke74Pxcwwv
         oc+yhm8jBQRWQHcdmMB3BeVHrEl14dafWKf/lyxrSfJnJqEG1f3HQZikM/aN+J4AO7Ln
         TpYQTju/IAK97KN8/FaQu2C3VLl6Ki2plHylFFxy83ndR//FftNduma8e2o4RfPPflnC
         tG+w==
X-Gm-Message-State: AOJu0YwhUJ6zCUrNW3lL4L6jxqbSpSe6BgMxamcZTG7oSgPKVt/r5VdF
	VNhpd7EgrSuKDOX5FB1kSx+S3BKKbw6hakWGWlDol5Z7oQjPC/VY8hQIdDkfRw==
X-Gm-Gg: AfdE7cn7zhAbtlb/Okk1W9/8588pAp7AsxFK6CURrWxGtUCqI2wFGK3dskDPwUK/HGp
	vJoH/0gU40uxUXnh6o9TYE6eQjZeDvuk8Jq9m+JP2cj7aR3+dJYobX6tkHuUe3t/5pzljMbSb08
	ZLK+cDt/TDIE0FMTwX3vkxUBiXV1Cdj0ZpkzvaMiO1B9VAPuyUJMogeWxUZlVAH+UVfmTy7Nnk3
	sUCjVPz8OWNV2lMkfrQ9hfLymTt58rJ32ASUHwT64YUmqoOTJF+he+MMJICKxDJKfeILHeUSC2f
	NibjKrzrhY1rT9pNRmxrtiFiFXBVlEU/beoG/1Uwk2mkCDsoBO2Zhg6EmbOtGUa545ZrWQzyhrN
	/I0KcuHs7HbrlLdWvAsnajjyHK+FfbDcSu+9W8q/PhY2M1KaPhBvfy/HDzsZEOt/NojmW4yF50h
	85A1K50yZ58lKsTRU=
X-Received: by 2002:a05:620a:4386:b0:91c:9e70:8148 with SMTP id af79cd13be357-920914990ccmr44401385a.52.1781810230056;
        Thu, 18 Jun 2026 12:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a18157fbsm1910185a.18.2026.06.18.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:17:09 -0700 (PDT)
Message-Id: <1e31474ef6ba6e19091a0e82e58637e5bbe0c305.1781810227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:17:03 +0000
Subject: [PATCH v3 1/4] history: extract helper for a commit's parent tree
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

