Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6D47886C
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140505; cv=none; b=AEIYl6wBAycmhCuSOKvo6GDmCIwczGgWWcfqCJsg4SkBH/D4DsLGaNzviKI6Vk9RL4pH49CD5La6fMsOSA1dP4APz5bT0VLiCp1uOF06IsHwixxVDCs+0YXp7L0DwsZ/To7lkG3LmujUi78N00QkkLWzs2YMfctGG4Bb43QcKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140505; c=relaxed/simple;
	bh=gLKopDZBCpxScOZQCCHySjaKkc87nKYAK2RjSiqAlAQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=smW0v2nH0M7TiqZ+eN1Bvk0EzhDjfpHOPfmA92IXQ8jvRXv86NCof6HuWAmKcAEsadfzjCJ9Kiav6lKFCUnW82j2KRKia7LrOnPl+TqncbYs8LTc9WBicYpjbgo7HJD1nWCY3BeLdNJxFXFknidlQ4DZjfcB4fLYMyf+F+1gl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWzgBoGZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWzgBoGZ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506cb1b63d0so16782221cf.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140500; x=1772745300; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM79YludtzkQXEMggwUjpXxaxNlvU5LmAlafGw7+5Cw=;
        b=KWzgBoGZXyMEyoXrHjuyesHJ/B0OKzCWLZTdmErKSCx5ihUqJ7xq4gL5xUbpNdrPFp
         c9r2q9GQXCJYZyBLWyTlP/VZUI1EXlhpTdZkjVY2kiMX3ksd4gKW0Ga27HYbjLfCGMry
         klJQBMosOLYdI4t4l6sYXbfKraL+6MQmdoeAhaEpuRz7xroz7JYN8ncnCOwl83HR5Wnm
         eo2bARLWYciR1mdJsH3so9W0F8lByepeX/b5+vLSpI5QSe/OcD4cpwqsjSyTBqnXpTzJ
         IBzDGXx8nqptarVdqF73b2QI1vMO6LrpVai8EE9gWeipZo1cEwkn4cGEzNDO8bz58z7S
         mctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140500; x=1772745300;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IM79YludtzkQXEMggwUjpXxaxNlvU5LmAlafGw7+5Cw=;
        b=AIJpfobA66O5wjhSyot3saWR/RyhoJmtj1PUkdf7fovHDjwJxyaF3sTWVxJg4kYPBO
         eNmQsC4CpONk6Q0roU+XtGfIs02FaihNSkO8aYDrgim1L76SJj+T6qYsAVu0Nk2a0lqy
         ssYOtViYv6ksMdbjwqka5peLghHE23Hik6DLyJ+wsaaUuWvXlohIKzjgopXmXzCWnMBo
         OGGrQGUR9+ojRgLEdtfJVWyup0nKRczFmLkGGvZ+NlNwcgD1q+y20u2zYVhs4ex/t0Zd
         Jl2nNJXp/DtVZC8kDXb3ruL4vyg2ldo9i0gpVviZJGHh05yQB7eaUeFbfoOW6tRB/cAn
         XwGQ==
X-Gm-Message-State: AOJu0Yyj2CfL6k0PeUd87MgRBKM/6lwmTuKXsPO6EVc+QtLIFpHFLy7+
	AD2w1Y57jt4IsZfx3X+2Sm5Axm1yv3fJBeEI1dyuMFDlvgbZPSSu4qLIkWDsFQ==
X-Gm-Gg: ATEYQzzIG3pThHdQwK1nJVwiL2+rIL7cYwaBjg/V39rJ6fqyhKzAyjBpqPJAUb/0Weh
	MzucQLO32QjezrHVMJEbIVzNbh2R4XRzd2eKcXBF/spna9KvQriUSh3qVI/fyplOJkmNAUPALG1
	i7MzNb1+Ie4dXeUn6kJCGcVHNqW5HvMnllHDtXfMoMap6aOSoZvAFyUFI2IEja5jNju+oIZnOUv
	BkPz7rC7PDXfy5eog3+yi8hwLgeXUGgeT+JXj+My2YO5lIidBMmJOGDxRIvl81S//7LnojC4Dat
	dX1mxt1V25RT2JRT5Cc4hnhro1v2xr/cubFmpk7Yb2h98auOr8/yi0srPZFbRibytJ7XdhZ+3o+
	jvI0i6VXqNvT2ju6/4soNPG5bUVNLbuhQnAjfj++unmyQBr5Nf9KA0FQsSGiTj3reLZYPmHtW39
	UI421WUKbFaKOHy5YjRPv4S8T/xQ==
X-Received: by 2002:a05:622a:120d:b0:4ee:26ef:7f4c with SMTP id d75a77b69052e-5075275b595mr5943971cf.17.1772140500425;
        Thu, 26 Feb 2026 13:15:00 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744990e15sm26843931cf.10.2026.02.26.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:59 -0800 (PST)
Message-Id: <1bc100d6cab3b77badb5d79fb8133e22a35bd96e.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:47 +0000
Subject: [PATCH v4 10/10] repo: reduce repetition in structure keyvalue output
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Refactor structure_keyvalue_print() to use small helpers for
single-key and per-object-type metrics.

This makes the output section easier to review and reduces
copy/paste risk while keeping output keys unchanged.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 156 ++++++++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 80 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index cb70171412..ecd9d3aee5 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -821,6 +821,27 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static void print_keyvalue_size(const char *key, size_t value,
+				      char key_delim, char value_delim)
+{
+	printf("%s%c%" PRIuMAX "%c", key, key_delim, (uintmax_t)value,
+	       value_delim);
+}
+
+static void print_object_values(const struct object_values *values,
+				const char *metric,
+				char key_delim, char value_delim)
+{
+	printf("objects.commits.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->commits, value_delim);
+	printf("objects.trees.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->trees, value_delim);
+	printf("objects.blobs.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->blobs, value_delim);
+	printf("objects.tags.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->tags, value_delim);
+}
+
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
@@ -831,86 +852,61 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
 	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
 
-	printf("references.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)references_count_total, value_delim);
-
-	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.branches, value_delim);
-	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.tags, value_delim);
-	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.remotes, value_delim);
-	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.others, value_delim);
-
-	printf("objects.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)object_count_total, value_delim);
-
-	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
-	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.trees, value_delim);
-	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.blobs, value_delim);
-	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
-
-	printf("objects.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)inflated_size_total, value_delim);
-
-	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
-	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
-	printf("objects.blobs.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
-	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
-
-	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)max_inflated_size, value_delim);
-	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
-	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
-	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
-	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
-
-	printf("objects.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)disk_size_total, value_delim);
-
-	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)max_disk_size, value_delim);
-	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
-	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
-	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
-	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
-
-	printf("objects.commits.max_parent_count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_commit_parent_count, value_delim);
-	printf("objects.trees.max_entry_count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_tree_entry_count, value_delim);
-	printf("objects.blobs.max_path_length%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_blob_path_length, value_delim);
-	printf("objects.blobs.max_path_depth%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_blob_path_depth, value_delim);
-	printf("objects.tags.max_chain_depth%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_tag_chain_depth, value_delim);
-
-	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
-	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
-	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
-	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+	print_keyvalue_size("references.count", references_count_total,
+			   key_delim, value_delim);
+
+	print_keyvalue_size("references.branches.count", stats->refs.branches,
+			   key_delim, value_delim);
+	print_keyvalue_size("references.tags.count", stats->refs.tags,
+			   key_delim, value_delim);
+	print_keyvalue_size("references.remotes.count", stats->refs.remotes,
+			   key_delim, value_delim);
+	print_keyvalue_size("references.others.count", stats->refs.others,
+			   key_delim, value_delim);
+
+	print_keyvalue_size("objects.count", object_count_total,
+			   key_delim, value_delim);
+
+	print_object_values(&stats->objects.type_counts, "count",
+			    key_delim, value_delim);
+
+	print_keyvalue_size("objects.inflated_size", inflated_size_total,
+			   key_delim, value_delim);
+
+	print_object_values(&stats->objects.inflated_sizes, "inflated_size",
+			    key_delim, value_delim);
+
+	print_keyvalue_size("objects.max_inflated_size", max_inflated_size,
+			   key_delim, value_delim);
+	print_object_values(&stats->objects.max_inflated_sizes,
+			    "max_inflated_size", key_delim, value_delim);
+
+	print_keyvalue_size("objects.disk_size", disk_size_total,
+			   key_delim, value_delim);
+
+	print_keyvalue_size("objects.max_disk_size", max_disk_size,
+			   key_delim, value_delim);
+	print_object_values(&stats->objects.max_disk_sizes, "max_disk_size",
+			    key_delim, value_delim);
+
+	print_keyvalue_size("objects.commits.max_parent_count",
+			   stats->objects.max_commit_parent_count,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.trees.max_entry_count",
+			   stats->objects.max_tree_entry_count,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.blobs.max_path_length",
+			   stats->objects.max_blob_path_length,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.blobs.max_path_depth",
+			   stats->objects.max_blob_path_depth,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.tags.max_chain_depth",
+			   stats->objects.max_tag_chain_depth,
+			   key_delim, value_delim);
+
+	print_object_values(&stats->objects.disk_sizes, "disk_size",
+			    key_delim, value_delim);
 
 	fflush(stdout);
 }
-- 
gitgitgadget
