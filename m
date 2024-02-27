Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0E13DB90
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040509; cv=none; b=hij2W6BhkEbqxfaW/owHRSoUnYlWK1iVMipu4NblFaARyFq/oK+xxaDXNVhmXXDxeg9T/qH4eEhXHNo5ac0dXn7mZ9p9buxkBMlRKz62WvCkPERZDF3rptLd2YChWFGW4zw91svyDSJRUAof9io0usehGZ1cYlx9s3uqOWGmfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040509; c=relaxed/simple;
	bh=+pZqO4z9dzPxkYeO95GzM11oRgZZU6Hu7Qf1EyX5XlA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F3uBKLZjS5MC96VQbUamwjlO7CPnBqi1AKW13lXXd5Aj52jPGwVDe2nvn11PWseXTohSypOB8hN3oqaCedlYLmTf5xWzyxtzV04bZoNXSIZtZUWj72f7FDZ5mxzDN+q0PcS80SMp88gEj1gCiZKQLXUPZS4Y+8/JVV0h0tcGzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiBMZi/6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiBMZi/6"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d27184197cso52184901fa.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040506; x=1709645306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN1V+1j8c+E3JD8Ld0NDPVa4IYGtQUvIiMGNp6/rDak=;
        b=iiBMZi/61PDs/wFe2ViI/R9Nf/KMvkMUg4DlMt9eRLqULzJV2DiXPm5eBZXyi8+Lqu
         dMhZqW4bQN1h+s5HthiAAGq0EIV2IZaOtpwXUJp2/DjXp9uxwbpb7SfihfWKgBbqroV9
         xChDL+TlPYASqp9HvFyVTdg5D/Fgmcb8A5myeVG2gBYFGqeX79lKMhSdVxamfWZJTuP/
         lj2FPg6wqFw5WfD3/u+x8YhGyIQ5luIr0q+5AzntMp1xqvqZmVRrlt3wOb/dptofGpKJ
         QCZq00O0GnoVVdgt8YjAyF1QJV7ty96rJPXfKMscGmqwTPM6D4SrqDELp7euYAzFhkVN
         5ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040506; x=1709645306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN1V+1j8c+E3JD8Ld0NDPVa4IYGtQUvIiMGNp6/rDak=;
        b=Td0yil5y49jf5nIzIoHfojrv7rF6FakxXcpiL6FUu2Qek1oTLO3+dC78E9zmqUSJfW
         zneDa7zzZmONPfskjExmPQj31xUSIReWvL3mgMJ71VO/6f1bfpwJNhUNXKWAo2cA+Tgw
         SA62yFbxpwDOozYiX+fok9KoMq9ox43JQIzv5l5QIb6EWgGPX3dTvt4TH2YefOd2PdxN
         zHePE02IyxEypfFx2UsoANroOMZ2ce0N3/SR5FYk2C/TWeQUF9kzwMeEqa//ku4Yzc8P
         6rZmMq+SCC3S2dDcc7SemMWRSxtVLJG96ytK7OuIvibhPwGUz9KGqee2ggvgb3gfEpPf
         dctA==
X-Gm-Message-State: AOJu0YyPtEsaBIMihz/UXMVs/l6BMzBHnlmSo9tA1GYDbb1/rpx4Pp4y
	PmEuVftyniuJP+w1tlYI+d3liP8kFzoDO6QzrUOZga6F3MfHnDLXqS/grFUC
X-Google-Smtp-Source: AGHT+IFbb2uyBBvYtUgYnexXDTM71joph8pZUipP01HqgUdAZ9jLrRhEK13SMkSiUneWwkwrF6KLGw==
X-Received: by 2002:a2e:b88a:0:b0:2d2:a3c4:4f with SMTP id r10-20020a2eb88a000000b002d2a3c4004fmr981153ljp.35.1709040505612;
        Tue, 27 Feb 2024 05:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b00410df4bf22esm15124634wmm.38.2024.02.27.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:25 -0800 (PST)
Message-ID: <85332b58c37717b5b8b6c826a2a3388dce3b0daa.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:11 +0000
Subject: [PATCH v3 05/11] commit-reach: start reporting errors in
 `paint_down_to_common()`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

If a commit cannot be parsed, it is currently ignored when looking for
merge bases. That's undesirable as the operation can pretend success in
a corrupt repository, even though the command should fail with an error
message.

Let's start at the bottom of the stack by teaching the
`paint_down_to_common()` function to return an `int`: if negative, it
indicates fatal error, if 0 success.

This requires a couple of callers to be adjusted accordingly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 66 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 7112b10eeea..9148a7dcbc0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -50,14 +50,14 @@ static int queue_has_nonstale(struct prio_queue *queue)
 }
 
 /* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct repository *r,
-						struct commit *one, int n,
-						struct commit **twos,
-						timestamp_t min_generation,
-						int ignore_missing_commits)
+static int paint_down_to_common(struct repository *r,
+				struct commit *one, int n,
+				struct commit **twos,
+				timestamp_t min_generation,
+				int ignore_missing_commits,
+				struct commit_list **result)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
-	struct commit_list *result = NULL;
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 
@@ -66,8 +66,8 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 
 	one->object.flags |= PARENT1;
 	if (!n) {
-		commit_list_append(one, &result);
-		return result;
+		commit_list_append(one, result);
+		return 0;
 	}
 	prio_queue_put(&queue, one);
 
@@ -95,7 +95,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
-				commit_list_insert_by_date(commit, &result);
+				commit_list_insert_by_date(commit, result);
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -108,7 +108,8 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 				continue;
 			if (repo_parse_commit(r, p)) {
 				clear_prio_queue(&queue);
-				free_commit_list(result);
+				free_commit_list(*result);
+				*result = NULL;
 				/*
 				 * At this stage, we know that the commit is
 				 * missing: `repo_parse_commit()` uses
@@ -116,7 +117,10 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 				 * corrupt commits would already have been
 				 * dispatched with a `die()`.
 				 */
-				return NULL;
+				if (ignore_missing_commits)
+					return 0;
+				return error(_("could not parse commit %s"),
+					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -124,7 +128,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	}
 
 	clear_prio_queue(&queue);
-	return result;
+	return 0;
 }
 
 static struct commit_list *merge_bases_many(struct repository *r,
@@ -151,7 +155,10 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0, 0);
+	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
+		free_commit_list(list);
+		return NULL;
+	}
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -205,7 +212,7 @@ static int remove_redundant_no_gen(struct repository *r,
 	for (i = 0; i < cnt; i++)
 		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
-		struct commit_list *common;
+		struct commit_list *common = NULL;
 		timestamp_t min_generation = commit_graph_generation(array[i]);
 
 		if (redundant[i])
@@ -221,8 +228,16 @@ static int remove_redundant_no_gen(struct repository *r,
 			if (curr_generation < min_generation)
 				min_generation = curr_generation;
 		}
-		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation, 0);
+		if (paint_down_to_common(r, array[i], filled,
+					 work, min_generation, 0, &common)) {
+			clear_commit_marks(array[i], all_flags);
+			clear_commit_marks_many(filled, work, all_flags);
+			free_commit_list(common);
+			free(work);
+			free(redundant);
+			free(filled_index);
+			return -1;
+		}
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -422,6 +437,10 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	clear_commit_marks_many(n, twos, all_flags);
 
 	cnt = remove_redundant(r, rslt, cnt);
+	if (cnt < 0) {
+		free(rslt);
+		return NULL;
+	}
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -491,7 +510,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 			     int nr_reference, struct commit **reference,
 			     int ignore_missing_commits)
 {
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
@@ -510,10 +529,11 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	if (generation > max_generation)
 		return ret;
 
-	bases = paint_down_to_common(r, commit,
-				     nr_reference, reference,
-				     generation, ignore_missing_commits);
-	if (commit->object.flags & PARENT2)
+	if (paint_down_to_common(r, commit,
+				 nr_reference, reference,
+				 generation, ignore_missing_commits, &bases))
+		ret = -1;
+	else if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
 	clear_commit_marks_many(nr_reference, reference, all_flags);
@@ -566,6 +586,10 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 		}
 	}
 	num_head = remove_redundant(the_repository, array, num_head);
+	if (num_head < 0) {
+		free(array);
+		return NULL;
+	}
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
gitgitgadget

