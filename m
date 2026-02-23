Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7A28853E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856478; cv=none; b=qOL1ZuzxDke3u5kekbhNksYH2uqvg2QiEkDzVo64QNj4gEzbMiaBUJo9Om5p9a7JhFpSTP+lsYplY5zlFHxeZN+p8PNqu/ICtZzepUJSnF93+B8oj51NpNLPw0vNR2GBJVPTX04hB105B0ITYeAKGe7I78hwZ1GyuMQR25T5GS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856478; c=relaxed/simple;
	bh=7bx2v4e6RPXfmbbAPY5QCvFqSG+0DW69/a2Ht6ZKnjs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JTGNpaMdkeD0c95XgitKvD0VfmFLBf+6QeYa5wFfYPXkR2fXqCHv8ci9qOIb+jHkZHqEIVcDatAu1jQUOe8jnOx5sLoiwZgtEqoIaNkbYNilxizZIdMUBXYElZUtlCCAlnfDrkIbcxzGZpLk5LTKd1gDeF2nWKM4ZlBROqGXplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku+p+lzh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku+p+lzh"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a3400f30so33555651cf.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856475; x=1772461275; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjluXTqmBa8AdSwvdn27q9HFFxB5bjD/3wfeVCTNVlU=;
        b=ku+p+lzhNHn9Cl8wg9gRZk6Fl9CwA5ceXpNiL/+uCmXQfGYEmDv0C9DPU3DKG0Ccj0
         i/amI/i4h7MsHLh8oUPxCoh/UioF4RFCvXXfl+0yG7b0bW/NBrfRAPUULH/oJ8Ywfsh1
         W71jMKy0XbHOj+/e5BQgsilvHHT5tQ3kCCz73hwdtxRixeNkSOBggZDh1tdemYVkTuYq
         YW0oQQuAAyjb8T4pbc+xROvvTzpVwZq0Fc9tarm/1nd1N36PqvfaRz10wlVQdTPfyLPH
         NYlodomqbuwFdO3izSphP9K9Gn6joNv10GvSK4iCq1XI+3kGeR2U9mwaFMBKgE0u1SsV
         y6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856475; x=1772461275;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjluXTqmBa8AdSwvdn27q9HFFxB5bjD/3wfeVCTNVlU=;
        b=fN1nmEZKvzhmMJwbOTqJxqgGNtWp/j+0exyhnxREhb7WBs2n8/QfKxJF+0tDbW7nRm
         boVn00I0TL+qzw9fLynaKQf+pL6BjmMygLkKIEzH66yYCAmWrtvFqjZCi3cO1rt2LvP1
         Nd7j/Gj4f06wfZSFEZ41fzJraHAmps6OhhzWdUE35dLJ68XclK3gFwqVWdJpyXk+R8Ew
         pvxC/fqFnI2JHzywRCiupaq+c6to71sM2vIPybLmeq7M8VTjeMOG9UMfOHjRH9h0ajU/
         WSy83uR7EKIFa0sEuIzat26SplcSv9/23GBzRQpjrbRVKoc8nrVgwF5ok3uIjjjykOYr
         55Hg==
X-Gm-Message-State: AOJu0Ywcv1kZwHv2l9/jOKhajGeAcJe6DlHVcshHqGvmWMyDlxRK44MP
	Jwcg2YhnlH4+pW41Y3LDCShQdMPn3mhv0w9+s5MTDmQSPlTHuSTzjg/bs+y1mw==
X-Gm-Gg: AZuq6aLUfZSpS813hT33lKN/OiBg5/uOVwxkqQ+a/jsMxOz+22qBxTFPI6CwB7TKf0S
	E3wngubZKKHZpYeHncrGeHAXZElea9e9HyrCMIl0+NaT4S+D+/0tunvRaO4LTE5n4dBFhINi+c1
	kz/g2LYOYriYF+AVr5HvxZX/+Ng29GoBpXRiZh3ZtXnlBVJOqJP9NRXuKRUJZax++wNYm87wOzx
	zFrAK601xPa/WxKYru+U0YkCjHPInLwUL6pFgL9n7x1of834DtHFOWukyOIwiBQQpj4vt8QTT+F
	oM0ttXVLhLQZiA4qUN9ml7tFPY+OundtYNQBHhA28eji4e2gRvDiuCHuJSy/wJfy2riut1031vB
	tmZo96pSlXQgtNvgewlip9rFv4RUkWkaLrJKwtiHk98BrPXSXOoXRMrBF4m+KKkxAk5dPu8sVXM
	+OZh3fosWWdXqHnOagcRlgmGQ=
X-Received: by 2002:ac8:7f88:0:b0:4ff:7eaf:6fa1 with SMTP id d75a77b69052e-5070bf6c19bmr128375131cf.11.1771856475441;
        Mon, 23 Feb 2026 06:21:15 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50c920sm70687411cf.7.2026.02.23.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:14 -0800 (PST)
Message-Id: <504d9cf7a0dbd663ea88c75217e1564504a60937.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:04 +0000
Subject: [PATCH v2 4/9] repo: add structure max object size metrics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Extend git repo structure with maximum inflated and on-disk object
sizes, both per type and overall max values.

This complements existing totals by highlighting outliers that
often drive repository bloat analysis.

The implementation updates object counting to track per-type maxima
while walking reachable objects.

It exposes those values in both table and keyvalue formats for
scripts and human output.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index e5078e5459..a2fc3fd8cc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -426,7 +426,9 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values max_inflated_sizes;
 	struct object_values disk_sizes;
+	struct object_values max_disk_sizes;
 };
 
 struct repo_structure {
@@ -529,6 +531,20 @@ static inline size_t get_total_object_values(struct object_values *values)
 	return values->tags + values->commits + values->trees + values->blobs;
 }
 
+static inline size_t get_max_object_value(struct object_values *values)
+{
+	size_t max = values->commits;
+
+	if (values->trees > max)
+		max = values->trees;
+	if (values->blobs > max)
+		max = values->blobs;
+	if (values->tags > max)
+		max = values->tags;
+
+	return max;
+}
+
 static void stats_table_setup_structure(struct stats_table *table,
 					struct repo_structure *stats)
 {
@@ -583,6 +599,26 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	stats_table_size_addf(table, objects->max_inflated_sizes.commits,
+			      "  * %s", _("Largest commit"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.trees,
+			      "  * %s", _("Largest tree"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.blobs,
+			      "  * %s", _("Largest blob"));
+	stats_table_size_addf(table, objects->max_inflated_sizes.tags,
+			      "  * %s", _("Largest tag"));
+
+	stats_table_size_addf(table, get_max_object_value(&objects->max_disk_sizes),
+			      "  * %s", _("Largest disk size"));
+	stats_table_size_addf(table, objects->max_disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->max_disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->max_disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->max_disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -661,6 +697,9 @@ static void stats_table_clear(struct stats_table *table)
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
+	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
+	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
+
 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->refs.branches, value_delim);
 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
@@ -688,6 +727,28 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)max_inflated_size, value_delim);
+	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
+	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
+	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
+	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
+
+	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)max_disk_size, value_delim);
+	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
+	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
+	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
+	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
+
 	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
 	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
@@ -772,6 +833,8 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	struct object_stats *stats = data->stats;
 	size_t inflated_total = 0;
 	size_t disk_total = 0;
+	size_t max_inflated = 0;
+	size_t max_disk = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
@@ -786,31 +849,53 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
 						  OBJECT_INFO_QUICK) < 0)
 			continue;
+		if (disk < 0)
+			continue;
 
 		inflated_total += inflated;
-		disk_total += disk;
+		disk_total += (size_t)disk;
+		if (inflated > max_inflated)
+			max_inflated = inflated;
+		if ((size_t)disk > max_disk)
+			max_disk = (size_t)disk;
 	}
 
 	switch (type) {
 	case OBJ_TAG:
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.tags)
+			stats->max_inflated_sizes.tags = max_inflated;
 		stats->disk_sizes.tags += disk_total;
+		if (max_disk > stats->max_disk_sizes.tags)
+			stats->max_disk_sizes.tags = max_disk;
 		break;
 	case OBJ_COMMIT:
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.commits)
+			stats->max_inflated_sizes.commits = max_inflated;
 		stats->disk_sizes.commits += disk_total;
+		if (max_disk > stats->max_disk_sizes.commits)
+			stats->max_disk_sizes.commits = max_disk;
 		break;
 	case OBJ_TREE:
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.trees)
+			stats->max_inflated_sizes.trees = max_inflated;
 		stats->disk_sizes.trees += disk_total;
+		if (max_disk > stats->max_disk_sizes.trees)
+			stats->max_disk_sizes.trees = max_disk;
 		break;
 	case OBJ_BLOB:
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
+		if (max_inflated > stats->max_inflated_sizes.blobs)
+			stats->max_inflated_sizes.blobs = max_inflated;
 		stats->disk_sizes.blobs += disk_total;
+		if (max_disk > stats->max_disk_sizes.blobs)
+			stats->max_disk_sizes.blobs = max_disk;
 		break;
 	default:
 		BUG("invalid object type");
-- 
gitgitgadget

