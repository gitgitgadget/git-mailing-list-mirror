Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B4185E7E
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412198; cv=none; b=VnkWMpQ0jcvbUQg88R2EvBGletatQsJagKM/A4nAYIToKvCnUpADFB9lEIYdWVep5UHOA4VtZ6sbDwCem3RgnP7MOiRyvljZhfjbuq+d/UrRlgpe+it0r+4QIvotY9s310beB3gDm0EkPWMBXtFbUyHigGcAp5xfJxtAqdUQ+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412198; c=relaxed/simple;
	bh=TFfNkbYDVJxfPTrj8v6tFtPvUjpRt7Zyk9Mih8HHgXw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KILpeNiWRIQw+8ujhDUvYoxtuTGEdQc1Inh1d30I0gN8uuC6h9eljo6dvJDtwu170V2wiNmUPQctcEQGiMw2RV1ny5CYhvmgWC6Tey7SkzhrNSE0W6KZWpxmVkFnResEmDYqt02aBRW1/vesDnDYlr3HxpMctGwr1zR5dAeyH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MABWh4ij; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MABWh4ij"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so51052611fa.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412195; x=1720016995; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icp2y/t/djF1Zsvl1v8rCgl2PpfJnBbqITG5R4+I9HU=;
        b=MABWh4ijO4OhoNDuFxlvgidYwHALZrqNMo40Ueuub8OQXek7GRtBv11HsIWRDEPRFc
         cS5SRtmjEWEKNp3IBJasgQsGK1CUgWtlUn6780ZKWjOOuETfZTNf66IfOoVKUsNJtoXF
         Uz7WSY1ptwFCUS70PNIQhSN6glsS0X1hQ32QLLcafnkURQK/Jb0XaBtSfi9cWvXouZ7g
         oX9KBa48cf1kUCQUJlHW9WDpKAimEYxESUkxSt02ANvBaaDyu1IJbA6RnZkAwL3AhEUy
         CsN1WOxGlmMChZJZJmKafBB0/E9wPgrGGqnuTk1Tz166vOjrCTIjmUHdpTqlYTiSW4HS
         o93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412195; x=1720016995;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icp2y/t/djF1Zsvl1v8rCgl2PpfJnBbqITG5R4+I9HU=;
        b=r/lLed2at3Fsb2R1bN+W58jMgXeteiKVuzZz/oeke0yMX05h6hDDjCcUmOzAqPjcwO
         ytfP6cOgX9a0n4c+/Jj0nGCBpJAHHvueXHsdvCpkR/HW78nZDImlKzX/lD738wAQybpn
         nThHIsKwFICgOcff3pbzXFU03NdwUkUDknwJb1x4rc6lkVTABEz3TP0ci/qw+6obUaYZ
         8GsVhtdxel/deyr4FnRU/cKNTOlkDGjH2FSJf34C9eRB4edg0Rk93NuN5aVMPVqkJN5N
         5ntxhOARw64RW7Sir0eLR0OkaIOBfYG21SPc6xxV9lcfvFz3uVgXfxj9oMGSZT+GGSPU
         IJiA==
X-Gm-Message-State: AOJu0YxKibd8irS6JjvrLL/rnj242qLs9Ou5GV7h/YQQSF5WRDdglts8
	p4NanG86FU9IXkvTxC4LsWbWU6tMs6TliyaFyI+brXTmeSMtO+A0EmNygA==
X-Google-Smtp-Source: AGHT+IGfPlQbZzvSdAohm4RX9WTvGbtoEnQkSTvegknAKmZkDMfOcXa6eJzIKiWDi5D5xmZTm6qJ4A==
X-Received: by 2002:a19:4312:0:b0:52b:e800:25d8 with SMTP id 2adb3069b0e04-52ce183559fmr6251321e87.25.1719412194389;
        Wed, 26 Jun 2024 07:29:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c2c1sm28135885e9.7.2024.06.26.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:29:54 -0700 (PDT)
Message-Id: <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:29:47 +0000
Subject: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry logic
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The clear_skip_worktree_from_present_files() method was introduced in
af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files present
in worktree, 2022-01-14) to help cases where sparse-checkout is enabled
but some paths outside of the sparse-checkout also exist on disk.  This
operation can be slow as it needs to check path existence in a way not
stored in the index, so caching was introduced in d79d299352 (Accelerate
clear_skip_worktree_from_present_files() by caching, 2022-01-14).

If users are having trouble with the performance of this operation and
don't care about paths outside of the sparse-checkout, they can disable
them using the sparse.expectFilesOutsideOfPatterns config option
introduced in ecc7c8841d (repo_read_index: add config to expect files
outside sparse patterns, 2022-02-25).

This check is particularly confusing in the presence of a sparse index,
as a sparse tree entry corresponding to an existing directory must first
be expanded to a full index before examining the paths within. This is
currently implemented using a 'goto' and a boolean variable to ensure we
restart only once.

Even with that caching, it was noticed that this could take a long time
to execute. 89aaab11a3 (index: add trace2 region for clear skip
worktree, 2022-11-03) introduced trace2 regions to measure this time.
Further, the way the loop repeats itself was slightly confusing and
prone to breakage, so a BUG() statement was added in 8c7abdc596 (index:
raise a bug if the index is materialised more than once, 2022-11-03) to
be sure that the second run of the loop does not hit any sparse trees.

One thing that can be confusing about the current setup is that the
trace2 regions nest and it is not clear that a second loop is running
after a sparse index is expanded. Here is an example of what the regions
look like in a typical case:

| region_enter | ... | label:clear_skip_worktree_from_present_files
| region_enter | ... | ..label:update
| region_leave | ... | ..label:update
| region_enter | ... | ..label:ensure_full_index
| region_enter | ... | ....label:update
| region_leave | ... | ....label:update
| region_leave | ... | ..label:ensure_full_index
| data         | ... | ..sparse_path_count:1
| data         | ... | ..sparse_path_count_full:269538
| region_leave | ... | label:clear_skip_worktree_from_present_files

One thing that is particularly difficult to understand about these
regions is that most of the time is spent between the close of the
ensure_full_index region and the reporting of the end data. This is
because of the restart of the loop being within the same region as the
first iteration of the loop.

This change refactors the method into two separate methods that are
traced separately. This will be more important later when we change
other features of the methods, but for now the only functional change is
the difference in the structure of the trace regions.

After this change, the same telemetry section is split into three
distinct chunks:

| region_enter | ... | label:clear_skip_worktree_from_present_files_sparse
| data         | ... | ..sparse_path_count:1
| region_leave | ... | label:clear_skip_worktree_from_present_files_sparse
| region_enter | ... | label:update
| region_leave | ... | label:update
| region_enter | ... | label:ensure_full_index
| region_enter | ... | ..label:update
| region_leave | ... | ..label:update
| region_leave | ... | label:ensure_full_index
| region_enter | ... | label:clear_skip_worktree_from_present_files_full
| data         | ... | ..full_path_count:269538
| region_leave | ... | label:clear_skip_worktree_from_present_files_full

Here, we see the sparse loop terminating early with its first sparse
path being a sparse directory containing a file. Then, that loop's
region terminates before ensure_full_index begins (in this case, the
cache-tree must also be computed). Then, _after_ the index is expanded,
the full loop begins with its own region.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 77 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e48e40cae71..e0457c87fff 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -486,49 +486,78 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 	return 0;
 }
 
-void clear_skip_worktree_from_present_files(struct index_state *istate)
+static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)
 {
 	const char *last_dirname = NULL;
 	size_t dir_len = 0;
 	int dir_found = 1;
 
-	int i;
-	int path_count[2] = {0, 0};
-	int restarted = 0;
+	int path_count = 0;
+	int to_restart = 0;
 
-	if (!core_apply_sparse_checkout ||
-	    sparse_expect_files_outside_of_patterns)
-		return;
-
-	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files_sparse",
 			    istate->repo);
-restart:
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
 		if (ce_skip_worktree(ce)) {
-			path_count[restarted]++;
+			path_count++;
 			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
 				if (S_ISSPARSEDIR(ce->ce_mode)) {
-					if (restarted)
-						BUG("ensure-full-index did not fully flatten?");
-					ensure_full_index(istate);
-					restarted = 1;
-					goto restart;
+					to_restart = 1;
+					break;
 				}
 				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			}
 		}
 	}
 
-	if (path_count[0])
-		trace2_data_intmax("index", istate->repo,
-				   "sparse_path_count", path_count[0]);
-	if (restarted)
-		trace2_data_intmax("index", istate->repo,
-				   "sparse_path_count_full", path_count[1]);
-	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
+	trace2_data_intmax("index", istate->repo,
+			   "sparse_path_count", path_count);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files_sparse",
+			    istate->repo);
+	return to_restart;
+}
+
+static void clear_skip_worktree_from_present_files_full(struct index_state *istate)
+{
+	const char *last_dirname = NULL;
+	size_t dir_len = 0;
+	int dir_found = 1;
+
+	int path_count = 0;
+
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files_full",
 			    istate->repo);
+	for (int i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			BUG("ensure-full-index did not fully flatten?");
+
+		if (ce_skip_worktree(ce)) {
+			path_count++;
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found))
+				ce->ce_flags &= ~CE_SKIP_WORKTREE;
+		}
+	}
+
+	trace2_data_intmax("index", istate->repo,
+			   "full_path_count", path_count);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files_full",
+			    istate->repo);
+}
+
+void clear_skip_worktree_from_present_files(struct index_state *istate)
+{
+	if (!core_apply_sparse_checkout ||
+	    sparse_expect_files_outside_of_patterns)
+		return;
+
+	if (clear_skip_worktree_from_present_files_sparse(istate)) {
+		ensure_full_index(istate);
+		clear_skip_worktree_from_present_files_full(istate);
+	}
 }
 
 /*
-- 
gitgitgadget

