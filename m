Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553735F197
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635355; cv=none; b=eNmsv06VpSyAymRPl2GYEsiAC2eXUY3GwNLzHt0lk2nifLYJzFGqPoOX25vrr3eZ++3MDhYSnD9NVRh/QNucDBdcWI7vM02NuvFItXRXE1/r/tle95GUoWBjSxV3tK2ZcPhauVtTvBCMswPw9Jgaw4rnIXKs/My6HbVLItQMGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635355; c=relaxed/simple;
	bh=Aieed0Ab3Y4Dhk5Bw+SRCcVyjjkjozfHkljAft8EY2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W4gXEl+jhemgEBqPSS1pl7wRlSa1rwEqf5+gRX+xN4Lv06LA/bu7A/Svfbutte0QobLKJlMGNJ1dtjxRNiQARhoGomBtPxaZWd2VG/o//iSCju3UnnAQTVSTUR9vu9K1qD0fTZcn34F8/4cGdm5U7bMIYtof3xSHvvIRpdTvwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZqKBHT6; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZqKBHT6"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30ca1b4b278so4391538eec.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782635353; x=1783240153; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=EZqKBHT6eeDV035EU+5o5+nnawB6HmUHTxXsuk9YgXPur3/wFkMKpdMXKemhQBPVnl
         eH+jKwtOtdfxVynUqD8dGEbbA8+X0fq+yDq7IaMirS4L3nUsAkuuIHmuwPvlv/UGl+H1
         3yVqfyxSy/yDD7TACujy0+BoyaAi38lAWrPAESrZZSwb/3dGNu2eLKbD1/HO6ZaXOcpu
         rr308fnsegjK/CHfOcg6yADZF1+BYwcYm8FE0pD8Wvb9/KTgpoSWcwEfxch4eCBq/rc3
         SCwby/GEoDjvTDBfd24d2x00QtGdUp3xENwBM9Od8zr0dzWBELu+C7N72JQFGen1ffdW
         p0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782635353; x=1783240153;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=GiRsDjDGv67zTe1JKr6coCtduE2Hzmkb3nXL3cR/ykdhVEc6x0rZlinofBOuvjIG00
         FEBAsdWF0nBvVCHW7F6y+zEOc3F6Q74jmjcvZwo4Vi74j3SmeQbpCH30bwQ9ljaLw71H
         ffSOfGDxnQ1FrF9yzyZsOsrNqiOqff4jxwtfZW4cEIq4nBD6xRzaZatkRm8RqWj9y5D4
         1rBwFYo054fb0ZLYBU8E8R2cQarIzFmvAF2uJb6NFTm1cK5crzkX6vMIUex/l01HYLny
         XGH0BnYH02jNagV00T45uXxVx8ptBqy77sE2/AHvbcWXLL/gVxu1QwYsDWKNU4FqJMSd
         kDnQ==
X-Gm-Message-State: AOJu0Yx0byc5MzBoT8sgUwmjHHViFa8o1a3bNmPjvWXChV+qM3yZ6O4U
	trna/ieYiKqeerSKo9Ddj6JYqhVwI6sZmD8n3LmNvmMxRr29Jm/pxYavLUU1EQ==
X-Gm-Gg: AfdE7cmJkwRjA6IDVatIjPRO3lJHoFCG7H2MlNiwY/mxVkCxyL46Hljghkb1yaXhBBQ
	FUcuUCUMj0LK2bQvb9iXgcboW9c+W3FiGkKJbqGwgKLyvMzp9dyLk3YbXHZ7jwapXTSvq198BG0
	ZhbrPy1sCVXxUzAbb94tpruNPwGmYe5tUHc6uB1vR/wNZMYLXoKJqmGgQdxWLUFrshsjBgg/YFS
	/SuUvYnfRxpfaiw1wPGB1xGGffFd1f1U0PemOyHjYE9LMHfL60PdHnKqI0z70nwKnR0fdlT6FDY
	Hj5Z3EinwJ0DkfKbBROhV2msJx6ww2dsmoLVZnLFUvIku3gSCrq2PlnQJtT3whE+ZYNhG5zKxMz
	53QpJRYpaq1V4uxY+m8FJHOO4tDxMK+hA94QRJC4YfXmv2bN1igD3sfE+Hl6buyDZI3+H70KxGw
	nierlnjFzZPycP7A==
X-Received: by 2002:a05:7301:60c:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30c84e05682mr12134527eec.10.1782635353005;
        Sun, 28 Jun 2026 01:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c6c2sm36775359eec.10.2026.06.28.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:29:12 -0700 (PDT)
Message-Id: <fea6b79e601671308ea16bd65a0b6ea5e6a4f7e8.1782635349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 08:29:06 +0000
Subject: [PATCH v6 1/4] history: extract helper for a commit's parent tree
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

