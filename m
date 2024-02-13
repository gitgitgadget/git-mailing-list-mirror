Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01B23747
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813724; cv=none; b=iGwEW6RcTz8NmGs7MufIkI07nzP7G4Hx1IuXxoubzirBP9ZaKL+bOhGAiKOAcyTRYnXfYexkMm5RIRhZGdPR06ZLoReZtiobPkgWJUj9WtyNhtO+7Okpj6T1Nb5XS6QdyP/gAqqNs5XfwHCdNsHQK9Zdqz/GOdnWxfzvBdvZ0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813724; c=relaxed/simple;
	bh=D4ngLwOzAbYmiCqMYRi4ETGueghrqBs77BO+RgXN7Lw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pyUvooLb5tXwBenWVkjqzP7te9h97CULhWYGzPK7eWtOWB6UhM3vbdG8F4Upayq6hm8J0haWk1rJq3vaWdC5BddV9mG9pbE1OUIB7xx4Bo7zDv2R96kqzN+vcq/OnF937aKyxCRbCyuDqcLcEEzCJfm/CWSkxsw16FI6odcBU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldThvLpj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldThvLpj"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511972043c3so737463e87.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813719; x=1708418519; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLtERfHWGfDVQgYN0hsMKkK4fu+29ltz7NypP7JpjbA=;
        b=ldThvLpjErNjXUECV5Nuxap/hrCw5fT/lOXzl4PyfbYyL5w1/bFpV1mmr/yDk4saVp
         7LmLqxA5JAbcOBnVIoUcEbwB2GlHY9su3XOWD2ckRMp01uJgQ0sGG+ZSZTeFBtRDIXMf
         Kbve1gZEAPBWjoru0ANs8bDOIKcfZq316QwynxXI74CTFb5bL2rK/GWDb2Abw0Ey/zwt
         jo2ibnfGMHrX3RrorJVxmCdItsMuW/EFGnIntAL3VRjsiArz4FJT3VDcUaCI2zqcVBI5
         II6Q652cDR4yFY14ebbVe7Knp94itHWmnw9XMWUqciEEx00pWMSRK/QgT2OJWDeHyKM4
         Oodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813719; x=1708418519;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLtERfHWGfDVQgYN0hsMKkK4fu+29ltz7NypP7JpjbA=;
        b=InJdHWrRfv8LmuPBkrxjnSIsxg9Gk/FcGc4m5x3kNMpQLOvch4ZDWOZCM6Hd+AvDvf
         /ALPyss3pXO6UO2B/Kh8BTcqQuSymzvgLA0eEJYzamoYPY4PdrIuzT0pGREF8nm7uluw
         1U4n1VPxWa/d8y/ADBMrDDNKnMUc5oa9EpIfKu1esWLWRGx1+smeQfiBRvG/g4zPu003
         MJ08I0LdaObG7F9H4To6LQb/A/01tF3BCYvG1ls1kt9gUR2fL7iSZsqAfUst/Nv5EKSH
         W1uHDoYB9aCe2mAknb1Gj9A+lAxQUjdn4/njWuFRDOrp6GeH7SSfZlqyZW7r17I7mIaF
         YN6g==
X-Gm-Message-State: AOJu0Yx0kQDERN4EGbeRETmGn9Q5A+UdOzGMbVvq/oDHs2Lyco3wSNsX
	n08Y59jDIgyOeWKPRC6NisI1PbQuT24UWb3Z4NdD2TnznbZlv5tcCNKxzluH
X-Google-Smtp-Source: AGHT+IHDpbX9za/QhZIidbous859UTeUF2vE9zrSvSbgYAqiU++40rmVq8r9DNzHt0zTsEhsaJ6RRA==
X-Received: by 2002:a05:6512:31d4:b0:510:ee2c:e9c4 with SMTP id j20-20020a05651231d400b00510ee2ce9c4mr8253747lfe.17.1707813719367;
        Tue, 13 Feb 2024 00:41:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b00410504b582csm11060312wmo.11.2024.02.13.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:58 -0800 (PST)
Message-ID: <55757c3a35d73c7fd81ec7fb19bb4ba6093e325b.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:46 +0000
Subject: [PATCH 10/12] repo_get_merge_bases_many(): pass on errors from
 `merge_bases_many()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases_many()` function is aware of
that, too.

Naturally, there are a lot of callers that need to be adjusted now, too.

Next stop: `repo_get_merge_bases_dirty()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c              |  7 ++++---
 builtin/log.c         | 13 +++++++------
 commit-reach.c        | 16 ++++++----------
 commit-reach.h        |  7 ++++---
 commit.c              |  7 ++++---
 t/helper/test-reach.c |  9 ++++++---
 6 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1be8e0a2711..2018466d69f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -851,10 +851,11 @@ static void handle_skipped_merge_base(const struct object_id *mb)
 static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
 	enum bisect_error res = BISECT_OK;
-	struct commit_list *result;
+	struct commit_list *result = NULL;
 
-	result = repo_get_merge_bases_many(the_repository, rev[0], rev_nr - 1,
-					   rev + 1);
+	if (repo_get_merge_bases_many(the_repository, rev[0], rev_nr - 1,
+				      rev + 1, &result) < 0)
+		exit(128);
 
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
diff --git a/builtin/log.c b/builtin/log.c
index befafd6ae04..c75790a7cec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1656,7 +1656,7 @@ static struct commit *get_base_commit(const char *base_commit,
 		struct branch *curr_branch = branch_get(NULL);
 		const char *upstream = branch_get_upstream(curr_branch, NULL);
 		if (upstream) {
-			struct commit_list *base_list;
+			struct commit_list *base_list = NULL;
 			struct commit *commit;
 			struct object_id oid;
 
@@ -1667,11 +1667,12 @@ static struct commit *get_base_commit(const char *base_commit,
 					return NULL;
 			}
 			commit = lookup_commit_or_die(&oid, "upstream base");
-			base_list = repo_get_merge_bases_many(the_repository,
-							      commit, total,
-							      list);
-			/* There should be one and only one merge base. */
-			if (!base_list || base_list->next) {
+			if (repo_get_merge_bases_many(the_repository,
+						      commit, total,
+						      list,
+						      &base_list) < 0 ||
+			    /* There should be one and only one merge base. */
+			    !base_list || base_list->next) {
 				if (die_on_failure) {
 					die(_("could not find exact merge base"));
 				} else {
diff --git a/commit-reach.c b/commit-reach.c
index 1b618eb9cd1..f0006ab6422 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -451,17 +451,13 @@ static int get_merge_bases_many_0(struct repository *r,
 	return 0;
 }
 
-struct commit_list *repo_get_merge_bases_many(struct repository *r,
-					      struct commit *one,
-					      int n,
-					      struct commit **twos)
+int repo_get_merge_bases_many(struct repository *r,
+			      struct commit *one,
+			      int n,
+			      struct commit **twos,
+			      struct commit_list **result)
 {
-	struct commit_list *result = NULL;
-	if (get_merge_bases_many_0(r, one, n, twos, 1, &result) < 0) {
-		free_commit_list(result);
-		return NULL;
-	}
-	return result;
+	return get_merge_bases_many_0(r, one, n, twos, 1, result);
 }
 
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
diff --git a/commit-reach.h b/commit-reach.h
index 4690b6ecd0c..458043f4d58 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -13,9 +13,10 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *rev1,
 			 struct commit *rev2,
 			 struct commit_list **result);
-struct commit_list *repo_get_merge_bases_many(struct repository *r,
-					      struct commit *one, int n,
-					      struct commit **twos);
+int repo_get_merge_bases_many(struct repository *r,
+			      struct commit *one, int n,
+			      struct commit **twos,
+			      struct commit_list **result);
 /* To be used only when object flags after this call no longer matter */
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    struct commit *one, int n,
diff --git a/commit.c b/commit.c
index 8405d7c3fce..00add5d81c6 100644
--- a/commit.c
+++ b/commit.c
@@ -1054,7 +1054,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 {
 	struct object_id oid;
 	struct rev_collect revs;
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	int i;
 	struct commit *ret = NULL;
 	char *full_refname;
@@ -1079,8 +1079,9 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
 
-	bases = repo_get_merge_bases_many(the_repository, commit, revs.nr,
-					  revs.commit);
+	if (repo_get_merge_bases_many(the_repository, commit, revs.nr,
+				      revs.commit, &bases) < 0)
+		exit(128);
 
 	/*
 	 * There should be one and only one merge base, when we found
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index aa816e168ea..84ee9da8681 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -117,9 +117,12 @@ int cmd__reach(int ac, const char **av)
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-		struct commit_list *list = repo_get_merge_bases_many(the_repository,
-								     A, X_nr,
-								     X_array);
+		struct commit_list *list = NULL;
+		if (repo_get_merge_bases_many(the_repository,
+					      A, X_nr,
+					      X_array,
+					      &list) < 0)
+			exit(128);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
-- 
gitgitgadget

