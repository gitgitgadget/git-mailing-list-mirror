Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C0225AF
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813720; cv=none; b=kio7HFiQdbe/neMzSveyWa+ASLfYb1IILapZUKnZmmGOtJbjTKnCi0efF5+yojou0NJCUa6RTY2Y1FFQFq+LZo77QYUMc1E5Wyw1s6bFYb4wW7IImXrIO0gTOZu3hzRhB7Fwf6ZyHNYn/0qrGup5vntdspgTkLFP+9OhyEhwDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813720; c=relaxed/simple;
	bh=38f4SvXMAXAAp49D4JyECLnhScsTxR8aI+Ev4bA03UE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k1pNEsNp9Si+tQ8Q3Dafnoae6TgCvIWYWpPf0IGOJBecAFJYFCNftr3vyI+mpP9gdKqXMJNluo8p+gVWGwEvvftsYgzBghf++9cQPx3YEGzqJEzhSqqgXuzYWu5qzm7Q4jyfWEyepsaDFICFEcf+qruvSxIX3jSkeoc+EIjZKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtzJ5WtI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtzJ5WtI"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51182ece518so2900034e87.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813716; x=1708418516; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DxeN9rSU8m3tFIc0CnmTjy51tks/aFaDfRedgvv/R0=;
        b=XtzJ5WtIk/ItVQQQrYO6NNcIbJ/mzwt46y9ynotiE9yF3Geaa6oCLV5ix2/iFJect8
         O9QgiDD6aGSmSAqdpPyCPUhbiq2CpWTVrgq3fw0hWJPrQcAhSQjSQSpDkr+KHumUYk5A
         khli/Fd7Xd1kKaEpp+h8yAYK+0VyG/8mlxPCG7iBknYRSNBgkQR9A+DOB5MVqFcdeESb
         D+BhKslqsc0ZS1g5d3U1oznZfL+Zt4RSXz9xajmcnvIom67U2LGHTMk/E3mEvOk6kIDY
         Ej7oKOcxY9xSWt2KNYF2yI5BSdPBjNISVUmdL21gCeluvY9V5W8Tw0bZwrEnxsjI7RMt
         53Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813716; x=1708418516;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DxeN9rSU8m3tFIc0CnmTjy51tks/aFaDfRedgvv/R0=;
        b=UVNF4MyXZVIIM6LB+NEP60v/DWxL9Dgm5Jo7SnzYtEuPcGeQlXAL40S087Tzml88Tj
         o1hXWI85o6C6gv+Gpg2uFKQSJsndPlhOa5DeUj3FEa8vSNOIORooK1xG5R8dceOoUmue
         hC5cqBDXOI8tlX50qmh1MtLYD2G4ImhaTMsduZ4QB5xirZPGljD+kKeapk7vggfHUM9m
         NzGgbCQ993IJkAiEnkS+lWQ8umBOib6FJPoHzN619aJuvEZ+aAzr1HUAPiMqen7tKAGC
         Z+X+hNXiose68Am716kuOer5++afFCVWcc8ibdF1JAjeQoVC6dr26a9gtcQ/4F7EcEku
         AqTw==
X-Gm-Message-State: AOJu0YzJNMiGy3H/T2XhrMRjX0Lawe51H0PrciCiIBuSH6Ss9RjoOoKS
	aJ8y2xPi3H2RCGfr3zHu2vnDCs5Asby0bB9r6AdqrldZMryEApRUhFzUjtRQ
X-Google-Smtp-Source: AGHT+IFjP9vB8VfT8vTTHMFblHLXK9UXiOicB2dZ3Mz7U4Y/VHMwV/uEPzyBqGosFWouYegfIX1Ryg==
X-Received: by 2002:ac2:5b0d:0:b0:510:526:182b with SMTP id v13-20020ac25b0d000000b005100526182bmr6330757lfn.67.1707813716121;
        Tue, 13 Feb 2024 00:41:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b00410504b582csm11060142wmo.11.2024.02.13.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:55 -0800 (PST)
Message-ID: <03734cc09dab415f05c5524b2a1e3492fefad8c2.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:43 +0000
Subject: [PATCH 07/12] get_merge_bases_many_0(): pass on errors from
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

The `merge_bases_many()` function was just taught to indicate
parsing errors, and now the `get_merge_bases_many_0()` function is aware
of that, too.

Next step: adjust the callers of `get_merge_bases_many_0()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 57 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index c9969da8c6c..359853275a9 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -399,37 +399,38 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return remove_redundant_no_gen(r, array, cnt);
 }
 
-static struct commit_list *get_merge_bases_many_0(struct repository *r,
-						  struct commit *one,
-						  int n,
-						  struct commit **twos,
-						  int cleanup)
+static int get_merge_bases_many_0(struct repository *r,
+				  struct commit *one,
+				  int n,
+				  struct commit **twos,
+				  int cleanup,
+				  struct commit_list **result)
 {
 	struct commit_list *list;
 	struct commit **rslt;
-	struct commit_list *result = NULL;
 	int cnt, i;
 
-	if (merge_bases_many(r, one, n, twos, &result) < 0)
-		return NULL;
+	if (merge_bases_many(r, one, n, twos, result) < 0)
+		return -1;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
-			return result;
+			return 0;
 	}
-	if (!result || !result->next) {
+	if (!*result || !(*result)->next) {
 		if (cleanup) {
 			clear_commit_marks(one, all_flags);
 			clear_commit_marks_many(n, twos, all_flags);
 		}
-		return result;
+		return 0;
 	}
 
 	/* There are more than one */
-	cnt = commit_list_count(result);
+	cnt = commit_list_count(*result);
 	CALLOC_ARRAY(rslt, cnt);
-	for (list = result, i = 0; list; list = list->next)
+	for (list = *result, i = 0; list; list = list->next)
 		rslt[i++] = list->item;
-	free_commit_list(result);
+	free_commit_list(*result);
+	*result = NULL;
 
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
@@ -437,13 +438,12 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	cnt = remove_redundant(r, rslt, cnt);
 	if (cnt < 0) {
 		free(rslt);
-		return NULL;
+		return -1;
 	}
-	result = NULL;
 	for (i = 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], &result);
+		commit_list_insert_by_date(rslt[i], result);
 	free(rslt);
-	return result;
+	return 0;
 }
 
 struct commit_list *repo_get_merge_bases_many(struct repository *r,
@@ -451,7 +451,12 @@ struct commit_list *repo_get_merge_bases_many(struct repository *r,
 					      int n,
 					      struct commit **twos)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 1);
+	struct commit_list *result = NULL;
+	if (get_merge_bases_many_0(r, one, n, twos, 1, &result) < 0) {
+		free_commit_list(result);
+		return NULL;
+	}
+	return result;
 }
 
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
@@ -459,14 +464,24 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    int n,
 						    struct commit **twos)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 0);
+	struct commit_list *result = NULL;
+	if (get_merge_bases_many_0(r, one, n, twos, 0, &result) < 0) {
+		free_commit_list(result);
+		return NULL;
+	}
+	return result;
 }
 
 struct commit_list *repo_get_merge_bases(struct repository *r,
 					 struct commit *one,
 					 struct commit *two)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1);
+	struct commit_list *result = NULL;
+	if (get_merge_bases_many_0(r, one, 1, &two, 1, &result) < 0) {
+		free_commit_list(result);
+		return NULL;
+	}
+	return result;
 }
 
 /*
-- 
gitgitgadget

