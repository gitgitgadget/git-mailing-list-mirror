Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654D1420A5
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040512; cv=none; b=FwSTFG9s1RRl/eGR0JMivISG2TGs/vDfaJtbOWshK0boEL06ZPvccezTHBhj/yyYXLwYyQxtk8KoY+FKSPcJzRBhoohoySCjwDj7bxzEHHd3v6AbrAM9WcaR76TtdIlP5yZadjq1epnHxEr8/KjRic+oipvwNQ5fb7sx/ImQ4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040512; c=relaxed/simple;
	bh=hzRxdBrl2ByI5HBj9L44tIXXHO2fkT2SNobbwjCZPCg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RPaMdycWrvtwvzDFLnIV377nNh87MkWo3lkwM7E6ZtG7QApQ/JGy3vzSVz/ABcdQp+9w7IM9jMgNPlR5d0RhDKkIS+TzuXwbklYZxjRQWkwvBC6NT43CvORg3h3f0xD/ScXOCz7jhE5f5XQKM21fk8eXaTpZJykscp43LNNyvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXbpFj+3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXbpFj+3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a4848f0dso15120775e9.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040509; x=1709645309; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjZk1iDVFshalJ84DkUa03UuxpWms0aWmK5IcaENZJk=;
        b=PXbpFj+36IKag+hzaT48VxnNKqhAN56rgSX0gic+XnEnNunh11kHe12/+NdH/c142w
         12unyLSHi5ELOPJYuUAbw3agHsgofrMY7rmU4He3BrUsLWeh3DElaIWdOJ9qbNxBUYJX
         qbCkOiwZ1umB+ut0DajnBsTKV6KsFFtNn58AmCTSXRPaAfv7FwiNKTY2UkfAVuqLcAKk
         fblymmoG2wGhtxbZ7aa/JqaTQHvlKXFh9ZYv42jyB+2nGgadOW2we9CedRQlSv+FHvXK
         BEnFXCc+vuYReC1Abt/NcMxlkW31pazPxQ9y/j4rJvQbwTqsYyabjV0IRK7P+Gbuxz6J
         du6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040509; x=1709645309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjZk1iDVFshalJ84DkUa03UuxpWms0aWmK5IcaENZJk=;
        b=Z58EYqUTeOD75j3CrJdlbH5D/75rUgo/yM9bhM3P0clje9swrIjfOtHf1/wRFTwoTj
         RdmAekWFIwV8ybuBawaiaLVAUPup8L031I2hQ9QXSG+fyykrpOD5heC2ndes0nvhR/sY
         oWZoUY7V4HotM3DAGcbtXd69P0RvyY5XBAHdL6pbgqGnXwr5947QsQA9y64vp7dJxZ6l
         OzctnSqgPsd6qPdP1gYk+/gbpa/GI2UyrYu/GrT2ITSUVxUBZar2p4BIB9X3Fl15gSxp
         ECBReqmWKmsXXRM0j3eOO7nx0HYq13kzQHMK/a4gFtoEL0X1HP33D5pfAFPJQ0Q++dJZ
         xkHA==
X-Gm-Message-State: AOJu0YyBsJ05t2xnw+lEWuomkoIzE0k2WTBV2d71mT84/DChSpGjFpx2
	Ux0jnYNpTJXkZHbJp+z1RQz5S1IPwqZp+cFwENqDSUsNppa0Dcwry2reL6/a
X-Google-Smtp-Source: AGHT+IGBXp7yY5coT6MOF52xbWThnVIP5PVaTHAzY+aGVO879PEKMQ9agFxiwzdzHF11eK2DGAZksg==
X-Received: by 2002:adf:f305:0:b0:33d:69c1:dcc3 with SMTP id i5-20020adff305000000b0033d69c1dcc3mr6882315wro.56.1709040508964;
        Tue, 27 Feb 2024 05:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d59c6000000b0033dd4673a4asm1270472wry.71.2024.02.27.05.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:28 -0800 (PST)
Message-ID: <a963058d2ba51bc205d247e9e93c9941377aa4ae.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:15 +0000
Subject: [PATCH v3 09/11] get_octopus_merge_bases(): pass on errors from
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases()` function (which is also
surfaced via the `get_merge_bases()` macro) is aware of that, too.

Naturally, the callers need to be adjusted now, too.

Next step: adjust `repo_get_merge_bases_many()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-base.c |  8 ++++++--
 builtin/merge.c      |  6 +++++-
 builtin/pull.c       |  5 +++--
 commit-reach.c       | 20 +++++++++++---------
 commit-reach.h       |  2 +-
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0308fd73289..2edffc5487e 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -77,13 +77,17 @@ static int handle_independent(int count, const char **args)
 static int handle_octopus(int count, const char **args, int show_all)
 {
 	struct commit_list *revs = NULL;
-	struct commit_list *result, *rev;
+	struct commit_list *result = NULL, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = get_octopus_merge_bases(revs);
+	if (get_octopus_merge_bases(revs, &result) < 0) {
+		free_commit_list(revs);
+		free_commit_list(result);
+		return 128;
+	}
 	free_commit_list(revs);
 	reduce_heads_replace(&result);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index ac9d58adc29..94c5b693972 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1526,7 +1526,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	} else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
-		common = get_octopus_merge_bases(list);
+		if (get_octopus_merge_bases(list, &common) < 0) {
+			free(list);
+			ret = 2;
+			goto done;
+		}
 		free(list);
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index e6f2942c0c5..0c5a55f2f4d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -820,7 +820,7 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 		const struct object_id *merge_head,
 		const struct object_id *fork_point)
 {
-	struct commit_list *revs = NULL, *result;
+	struct commit_list *revs = NULL, *result = NULL;
 
 	commit_list_insert(lookup_commit_reference(the_repository, curr_head),
 			   &revs);
@@ -830,7 +830,8 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 		commit_list_insert(lookup_commit_reference(the_repository, fork_point),
 				   &revs);
 
-	result = get_octopus_merge_bases(revs);
+	if (get_octopus_merge_bases(revs, &result) < 0)
+		exit(128);
 	free_commit_list(revs);
 	reduce_heads_replace(&result);
 
diff --git a/commit-reach.c b/commit-reach.c
index 10e625ff51b..fa21a8f2f6b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -176,24 +176,26 @@ static int merge_bases_many(struct repository *r,
 	return 0;
 }
 
-struct commit_list *get_octopus_merge_bases(struct commit_list *in)
+int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
 {
-	struct commit_list *i, *j, *k, *ret = NULL;
+	struct commit_list *i, *j, *k;
 
 	if (!in)
-		return ret;
+		return 0;
 
-	commit_list_insert(in->item, &ret);
+	commit_list_insert(in->item, result);
 
 	for (i = in->next; i; i = i->next) {
 		struct commit_list *new_commits = NULL, *end = NULL;
 
-		for (j = ret; j; j = j->next) {
+		for (j = *result; j; j = j->next) {
 			struct commit_list *bases = NULL;
 			if (repo_get_merge_bases(the_repository, i->item,
 						 j->item, &bases) < 0) {
 				free_commit_list(bases);
-				return NULL;
+				free_commit_list(*result);
+				*result = NULL;
+				return -1;
 			}
 			if (!new_commits)
 				new_commits = bases;
@@ -202,10 +204,10 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 			for (k = bases; k; k = k->next)
 				end = k;
 		}
-		free_commit_list(ret);
-		ret = new_commits;
+		free_commit_list(*result);
+		*result = new_commits;
 	}
-	return ret;
+	return 0;
 }
 
 static int remove_redundant_no_gen(struct repository *r,
diff --git a/commit-reach.h b/commit-reach.h
index 2c6fcdd34f6..4690b6ecd0c 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -21,7 +21,7 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    struct commit *one, int n,
 						    struct commit **twos);
 
-struct commit_list *get_octopus_merge_bases(struct commit_list *in);
+int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);
 
 int repo_is_descendant_of(struct repository *r,
 			  struct commit *commit,
-- 
gitgitgadget

