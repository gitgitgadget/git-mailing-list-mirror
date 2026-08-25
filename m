Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245083E8337
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693122; cv=none; b=nG4Ce53iLvQzPnnIXyc38AGHSvoPKWuwb5GTEZTIcwy9jsVCWdbAr5dBzyfex/EOnqHRmQW6YQWIoA0a5JDXGS+qBk4g5dzedbPRQSp7Kjycsi0wM+I8UvOjuijTy2nF1CK9cw9ggB2c9yimIvEWWoLpF/39+71NkQklAu3zNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693122; c=relaxed/simple;
	bh=R7SNzlLNtJiWfjOeE4Llnc1qOKpyboprkgjMwhvNM9U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fBAxpaDcY4BNKBqMzE2ljAQp6Y6alidE8uPXLc0/UFXM3aSDPB/pWh9zpfHagnsHh3P0rhHZBvNSb4eoSn70UYPPuwE0/aH4Ax1LUsTBPhIcPS0RYPSR+byVCUAKr5G+CnpsV4krJO0bSueqYF5SAz8DQc29+ZY5fFz/pb9sr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPmiuj+p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPmiuj+p"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6e954afbdso2612215ad.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787693120; x=1788297920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QyjsfSl7YBf6UJTOStBhwD6dH1t218LlIhTMrvdbozU=;
        b=WPmiuj+pDoh15O+FDAbz2s1R+klR0iPvuiYGngx8uCZc/a6WcKKEwT/+pQ5JpOSFX0
         EM5Doqwa9u8fpkudHY5aQfXvY3+djwgtPcg/ADIO7MwauoEFGP7A68XZYigBPyolf4ja
         2Oeu3NKQKw4xXlh/Le9K3p0jCGMRYo6xVeOr0wBw+nVbB0AqtiFx3rJd2aTGPSnjiTp/
         QQNmuSPtGIssHvqCMI0ZEPTs6DSQE+/8W2g7QBGifmXKiks8Cf/31Sq8HXj2A2QbAOw9
         D4TMb01kuJXjAOjP7S49VEO5tQeDkZBseTRg9jhrBbIdtTZioaQxtgigbUQJQSE2v9gx
         X28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787693120; x=1788297920;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QyjsfSl7YBf6UJTOStBhwD6dH1t218LlIhTMrvdbozU=;
        b=A5ITp5JLAqLyew6qw8tQS8EimCtYcU4QSFcNt9c7pqVp77Z5putKQqca5cX1L4cg2Q
         aYjByUMtHhdf/pDQb0FBoIhlpuB1gE8XikxLyoYKY1iywEsjkl+8K7U7S9Ys6g850deZ
         hgGTzBKvhB8gZYf8mMXtQmnuQaWpkmwm3skftr4rPqQDGxnRS+rv5HH37Vv4ntutLRVJ
         3qZuQDaq5i5bBBHZ3pN1Kksh76eEUWx9sMzzmI/r63FIcwfCEFAPJiKFh0dR5ffbb13N
         gE9j6/3BPRLvTI214Oma8/1U/MDIFAcEYyOpDfQx2Ey1xZpfbQcQasI7FVJ0rZtZ7jVA
         KLVw==
X-Gm-Message-State: AFuF++mI8TCz0/HFPH42m1WZSYmVBl8rzgfsDwOYLaruFmU7zQ2CT9pW
	oUajS78eiWbjleqLjBGIXWCi/zDICqSGvD+p6T5P4E7IUx+psltj0Sq5sxidkg==
X-Gm-Gg: AR+sD10URexIR+Zt2DcMdBpDIVKY+p7Rn6LCqsKXo73dXldN9KHXmShNMx9lJbY/qEf
	VVe+wiQ/pjFoqQZaMDhf+SmwjcPVVtoHhVSmQOC6U9yZCVWvDF6tLzT/KSWF1x1Os/4vd1HyFEQ
	xJBNSZ+O2nQrIQ/u/BY+0gyUd10J4CJCALMSiUMV/AS7pUwwWnac8GsvBx2lqHPJroN2jC24uDu
	TJYefTfeOxaGJE/Ykw2QFbdIphLV2rHvg4RSX5waB+aRLJbOCFey0hAPXuoukt1GBu7EGqkTF3M
	ugcNRhoR6Jl5Wz7v5TdRqlxL3JB2SUepb6vXl1ri6z25M+6AaMG9bMvFkga+1nUXdut6MTwIx6D
	Pxl753TvMaK94fqpMCEz5+xqcobviriz0XoUr4edpK2CFrJLAFlpxro/Yl+/RzDk1zKwTaIuT+3
	LCwLdSRWGST5Fi54hNYitVnWmGguxRTQ158Pw8eUCvkSev9okr7f394CoRgEMjxZUBVQ==
X-Received: by 2002:a17:902:cf4c:b0:2d6:f9e2:af7f with SMTP id d9443c01a7336-2d707a3485fmr25487745ad.1.1787693120331;
        Tue, 25 Aug 2026 14:25:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.158.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283da08e23sm1672841eec.29.2026.08.25.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:25:19 -0700 (PDT)
Message-Id: <f7856e7a5b7b996be9380eb78d24c92b682a1fae.1787693117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:25:16 +0000
Subject: [PATCH 1/2] branch: move stacked branch helpers
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

Move the stacked branch helpers earlier so delete_branches() can use
them without a forward declaration.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 104 +++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..87f0aa4051 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -203,6 +203,58 @@ enum delete_branch_flags {
 	DELETE_BRANCH_DRY_RUN = (1 << 4),
 };
 
+struct stacked_branch_data {
+	struct strset *deletable_branch_names;
+	struct strset *protected_branch_names;
+};
+
+static int collect_stacked_branch_base(const struct reference *ref,
+				       void *cb_data)
+{
+	struct stacked_branch_data *data = cb_data;
+	const char *branch_name;
+	struct branch *branch;
+	const char *upstream_refname;
+	const char *upstream_branch_name;
+
+	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
+		BUG("expected local branch ref, got '%s'", ref->name);
+	if (strset_contains(data->deletable_branch_names, branch_name))
+		return 0;
+
+	branch = branch_get(branch_name);
+	upstream_refname = branch_get_upstream(branch, NULL);
+	if (!upstream_refname ||
+	    !skip_prefix(upstream_refname, "refs/heads/",
+			 &upstream_branch_name) ||
+	    !strset_contains(data->deletable_branch_names,
+			    upstream_branch_name))
+		return 0;
+
+	strset_add(data->protected_branch_names, upstream_branch_name);
+	return 0;
+}
+
+static void protect_stacked_branch_bases(struct ref_store *refs,
+					 struct strset *deletable_branch_names,
+					 struct strset *protected_branch_names)
+{
+	struct stacked_branch_data data = {
+		.deletable_branch_names = deletable_branch_names,
+		.protected_branch_names = protected_branch_names,
+	};
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/heads/",
+	};
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	refs_for_each_ref_ext(refs, collect_stacked_branch_base, &data, &opts);
+
+	strset_for_each_entry(protected_branch_names, &iter, entry)
+		strset_remove(deletable_branch_names, entry->key);
+}
+
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
 			       int kinds, unsigned int flags)
@@ -718,58 +770,6 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
-struct stacked_branch_data {
-	struct strset *deletable_branch_names;
-	struct strset *protected_branch_names;
-};
-
-static int collect_stacked_branch_base(const struct reference *ref,
-				       void *cb_data)
-{
-	struct stacked_branch_data *data = cb_data;
-	const char *branch_name;
-	struct branch *branch;
-	const char *upstream_refname;
-	const char *upstream_branch_name;
-
-	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
-		BUG("expected local branch ref, got '%s'", ref->name);
-	if (strset_contains(data->deletable_branch_names, branch_name))
-		return 0;
-
-	branch = branch_get(branch_name);
-	upstream_refname = branch_get_upstream(branch, NULL);
-	if (!upstream_refname ||
-	    !skip_prefix(upstream_refname, "refs/heads/",
-			 &upstream_branch_name) ||
-	    !strset_contains(data->deletable_branch_names,
-			    upstream_branch_name))
-		return 0;
-
-	strset_add(data->protected_branch_names, upstream_branch_name);
-	return 0;
-}
-
-static void protect_stacked_branch_bases(struct ref_store *refs,
-					 struct strset *deletable_branch_names,
-					 struct strset *protected_branch_names)
-{
-	struct stacked_branch_data data = {
-		.deletable_branch_names = deletable_branch_names,
-		.protected_branch_names = protected_branch_names,
-	};
-	struct refs_for_each_ref_options opts = {
-		.prefix = "refs/heads/",
-	};
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
-
-	refs_for_each_ref_ext(refs, collect_stacked_branch_base, &data, &opts);
-
-	strset_for_each_entry(protected_branch_names, &iter, entry)
-		strset_remove(deletable_branch_names, entry->key);
-}
-
 static void clear_deleted_upstreams(struct strset *protected_branch_names,
 				    struct strset *deletable_branch_names)
 {
-- 
gitgitgadget

