Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73003A3E68
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504359; cv=none; b=iVHZd0ooykAbIaYnw/CY5754e4NGc1C/p6bm4sNWxk1jZiMZPUnmb9mRkGpqN4aDkcS2jcHvGbph0K9MGjztZD0fcwtY8npR9LVshjw4NMBSKOOEzrQZWxpksI5Nvx7T5ep2oxd109ib7shP5XZB1qKCTz6tLy/qlpRXKt2Cbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504359; c=relaxed/simple;
	bh=GiB/G02wyWdbnO57+wSOgmP3BVOoxpu0wXp4B/6oEiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LJhQrq3RYsIF4Q3tSM6p8uQec2MHw89NpcI+XJs9xxIji4q+2EZvYRfaPJLP0EjlAOYAOTkHLmSil/8Lu5MWdPowFiNNNl5uOhXJm1Wjn+2hzVYkajQbz+/4V25eRPRChLSQzFDUnyagRHPJdUVjNvOoEFcwkz/+LKcAu5HSBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sP6qm6j/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP6qm6j/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7332977eec.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504356; x=1779109156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fvr80+d2HClZxiFP/SBlbkp0aQayImOuYxhlUgCJX7M=;
        b=sP6qm6j/LKh6NjelT2AmfnZXrFumZ6TFQ+CpCTBciTByid/sS8ZxHtu28yQmUFKuMq
         uRLA3jkYqMKxJjJuFlNYFfpS3+Gsp0yRrvJ5CBTvCVkgMIy6L2ztRnki2NX9pMfs0HGt
         r3tmW8TIrVU+4AOH3nVxaft0NbBCmKsscfjocrpQthYQV+EKZ6m+Q9rgJ0GZ1mWzsazM
         45YFDbd2TEqRCHzmIZHtoxDJrG91PDXgJ9Fjww8y4Ls6i/wDSKGG5Je5yyLFZh1QIlVv
         edrO1v8HpsR7NssrXtU0jng5K1guqS+xIWXV9dS0vyI4Sjo6c3kX03tuBS+CFU7+mVQ8
         3QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504356; x=1779109156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fvr80+d2HClZxiFP/SBlbkp0aQayImOuYxhlUgCJX7M=;
        b=HxjJr/uGvMlolI7YZBfkeBXSVbybM9K1bIzZZ9o6Emqdpi8a9kEUGMnBrx7KiwQWOB
         9+5HNQ6FyCz9oESkaxhNplpMtwSQZ+tWJJhUd9e+swNPe1YN5JeSyTM1u0mCGjExmzhz
         f0NvAbkSK+KAG37n9Rek53UpcTt79DwQp2NroYxDV8rRBCCFUqMZWWP/1pYhOpT2Q32m
         +ELM7CC6+G3L8I0QWHeJET03TcInICoc6CMhZCqjD8OHMd09O8nv0ZB4zY5KAQn0byN6
         Wzbpqofnxz5H2H8sL934/pLv4wLQdpJZtLcMTKSKvl2ISCTjE7f4vKCEieBRM+3OTTTD
         vKLQ==
X-Gm-Message-State: AOJu0Yw9KTUsca9RTfC2VUYilyp5ENNnDPEwK4posvHNg1Z6rozIe06g
	5C42R8we9jT24B3URpoySpNN/EFszKQPAlvW19qskLuC4DXC9yoO8mg4EqeOkA==
X-Gm-Gg: Acq92OEE6O1KDa+FN4np/xB6fPSJw4EXlAgOAGtkMUOtsEK8+8jR/Zxhxc+JTY/kXAc
	5Gjvv7qQgcThV8We0JYEockKLTKXpvIj56UTTguIAQjWH0GIBO9Tyva9960Dx9MSyb1Hr5MVjPq
	81QIuLKYQo3dzGO/p/qS8Xv3hNEyrFiPRahRfM3cEzVU3xh8nfD7+Wg/1/QaBATRuKTnwP3vxVX
	Tg0OnrNJcsd97nqptUW8rlrknMMKVUWAuYIDbSqlK0OMfuL6mAUBhHJQgpBLeNSTjTWzIxoBKxz
	TzOMZXkDN+ezSh8udMfpmxW30enK7BsY4D5vzRcARccvy86OryFKGKZ3Bck/qA2cqS+yYAy/cDd
	9eTd2edbfuEXwMAPr6HuJlA9qg7B+NrdGSl4LBwo1LbtkVIn2hy7x5MjK7nOLV02PCl/BixBdRr
	fX+N9xjDuk+5yh4mcV4MurbYIU
X-Received: by 2002:a05:7300:5727:b0:2d8:8c38:8cec with SMTP id 5a478bee46e88-2f54d698ec8mr10378943eec.2.1778504356323;
        Mon, 11 May 2026 05:59:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm13030917eec.26.2026.05.11.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:59:15 -0700 (PDT)
Message-Id: <12d9e1c85f68703d069440c05dcc3eb3592274ed.1778504352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2109.v4.git.1778504352.gitgitgadget@gmail.com>
References: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
	<pull.2109.v4.git.1778504352.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 12:59:11 +0000
Subject: [PATCH v4 1/2] commit-reach: introduce merge_base_flags enum
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
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Replace the boolean ignore_missing_commits parameter in
paint_down_to_common() with an enum merge_base_flags, and thread
the flags through merge_bases_many(), get_merge_bases_many_0(),
and the public repo_get_merge_bases_many_dirty() API.

This makes callsites with boolean parameters easier to read and
prepares the function for additional flags in a subsequent commit.

No functional change: the single caller that used
ignore_missing_commits (repo_in_merge_bases_many) now sets
MERGE_BASE_IGNORE_MISSING_COMMITS in the flags word, and all
other callers pass 0.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/merge-base.c |  3 ++-
 commit-reach.c       | 23 +++++++++++++++--------
 commit-reach.h       |  5 +++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c7ee97fa6a..9b50b4660e 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -14,7 +14,8 @@ static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 	struct commit_list *result = NULL, *r;
 
 	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
-					    rev_nr - 1, rev + 1, &result) < 0) {
+					    rev_nr - 1, rev + 1,
+					    0, &result) < 0) {
 		commit_list_free(result);
 		return -1;
 	}
diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..766ba1156a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -54,7 +54,7 @@ static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
 				struct commit **twos,
 				timestamp_t min_generation,
-				int ignore_missing_commits,
+				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
@@ -118,7 +118,7 @@ static int paint_down_to_common(struct repository *r,
 				 * corrupt commits would already have been
 				 * dispatched with a `die()`.
 				 */
-				if (ignore_missing_commits)
+				if (mb_flags & MERGE_BASE_IGNORE_MISSING_COMMITS)
 					return 0;
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
@@ -136,6 +136,7 @@ static int paint_down_to_common(struct repository *r,
 static int merge_bases_many(struct repository *r,
 			    struct commit *one, int n,
 			    struct commit **twos,
+			    enum merge_base_flags mb_flags,
 			    struct commit_list **result)
 {
 	struct commit_list *list = NULL, **tail = result;
@@ -165,7 +166,7 @@ static int merge_bases_many(struct repository *r,
 				     oid_to_hex(&twos[i]->object.oid));
 	}
 
-	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
+	if (paint_down_to_common(r, one, n, twos, 0, mb_flags, &list)) {
 		commit_list_free(list);
 		return -1;
 	}
@@ -425,6 +426,7 @@ static int get_merge_bases_many_0(struct repository *r,
 				  size_t n,
 				  struct commit **twos,
 				  int cleanup,
+				  enum merge_base_flags mb_flags,
 				  struct commit_list **result)
 {
 	struct commit_list *list, **tail = result;
@@ -432,7 +434,7 @@ static int get_merge_bases_many_0(struct repository *r,
 	size_t cnt, i;
 	int ret;
 
-	if (merge_bases_many(r, one, n, twos, result) < 0)
+	if (merge_bases_many(r, one, n, twos, mb_flags, result) < 0)
 		return -1;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
@@ -475,16 +477,17 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit **twos,
 			      struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 1, result);
+	return get_merge_bases_many_0(r, one, n, twos, 1, 0, result);
 }
 
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one,
 				    size_t n,
 				    struct commit **twos,
+				    enum merge_base_flags mb_flags,
 				    struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 0, result);
+	return get_merge_bases_many_0(r, one, n, twos, 0, mb_flags, result);
 }
 
 int repo_get_merge_bases(struct repository *r,
@@ -492,7 +495,7 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *two,
 			 struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
+	return get_merge_bases_many_0(r, one, 1, &two, 1, 0, result);
 }
 
 /*
@@ -537,6 +540,10 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	struct commit_list *bases = NULL;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
+	enum merge_base_flags mb_flags = 0;
+
+	if (ignore_missing_commits)
+		mb_flags |= MERGE_BASE_IGNORE_MISSING_COMMITS;
 
 	if (repo_parse_commit(r, commit))
 		return ignore_missing_commits ? 0 : -1;
@@ -555,7 +562,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	if (paint_down_to_common(r, commit,
 				 nr_reference, reference,
-				 generation, ignore_missing_commits, &bases))
+				 generation, mb_flags, &bases))
 		ret = -1;
 	else if (commit->object.flags & PARENT2)
 		ret = 1;
diff --git a/commit-reach.h b/commit-reach.h
index 6012402dfc..a3f2cd80eb 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -17,10 +17,15 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit *one, size_t n,
 			      struct commit **twos,
 			      struct commit_list **result);
+enum merge_base_flags {
+	MERGE_BASE_IGNORE_MISSING_COMMITS = (1 << 0),
+};
+
 /* To be used only when object flags after this call no longer matter */
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one, size_t n,
 				    struct commit **twos,
+				    enum merge_base_flags mb_flags,
 				    struct commit_list **result);
 
 int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);
-- 
gitgitgadget

