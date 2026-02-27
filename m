Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC25453489
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220650; cv=none; b=p+lKaGVV+LXy1XXYXQfTlNXamqt9MmY+wL+/bsGRckvF8ThzXtGRr8p4N8GaG0uzH3/+bcFjKcNPGo/fRxVVAYCCFzvurNKaqyXujqw355OLfMhH25JYh/MCUSxJl1jWxBbFRdIU/wQiYV67O3kCa33jqoqahUNFA8/nyeJky9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220650; c=relaxed/simple;
	bh=7bx2v4e6RPXfmbbAPY5QCvFqSG+0DW69/a2Ht6ZKnjs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ktvvYmX9pAd4pg7KduP2PHL3qEKbmXkwpQMaoG1owdwqkStjqSB88+zF6WE3ORNt7XUUolAtX49rm46nHWfbEwqZYPOQKyx63ElK0ze53FexhXITbIxaA/iJaOCCPSAcT4u5MuXiMLDRnI/CLxZn3o+4wZiHY1baVGsMULNcCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK0eAKZc; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK0eAKZc"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3030442eec.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220648; x=1772825448; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjluXTqmBa8AdSwvdn27q9HFFxB5bjD/3wfeVCTNVlU=;
        b=FK0eAKZcdz1bf2vRDpMPTNv5ykb+a9Tqy6l3FCd2+Zx7Lpy6vLPXfHSvsuEpOGfKmN
         tpCPqUFqIcPbPPjM4miBVQ3R/Hi1KrNI9iWtnATCra44MppHaQ/J8WBdEhjYouUZ3rK6
         mAH1oEJKK6AysTbtn+amiCG2QEvd/hWbeKCFcCFU4aWRazf61O0xeOVUUA8Qo3/hXv02
         tL4hvvqM9JYY2pSaWocS8DdFVsZu2mfoys3HswkV3Jb0b9Bmh3VIwpnsnfRe63U5+bGz
         lQiVLQCa/e1eTbhSBy3deA4S1vMxzOpwfFU7ruwIV646CdHYD+wL18z55QALrNWilnFq
         3FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220648; x=1772825448;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjluXTqmBa8AdSwvdn27q9HFFxB5bjD/3wfeVCTNVlU=;
        b=PesA9JZTlGF+NrneeR3oYboz1VrpCL52syCBNhEy5ko+6i3NhE8y9lYE3ki9dFWV/t
         nMKzKw7xChwf66vrFclMgchPdhVdKj30GTWVBJNdpFw1t1Fl/g/QZIc5LJDjG1aksWfD
         69RF5GbiAEQ9n8nUesXIc95kMDzSCOkCrcK6CaGYw3d4n6Krv6azXmt/7JYqprbhYO22
         +tGdImsCWq6CbFWHXVzd2B9v1SWzx5LO4fDJ87Dqh/yMxcD2TGAbZ0Xt3B2U7TIsE/ao
         iJW19DYIzuqBlMrR/lBswE+UXPT54VYhmKO6W/YuuvrClavJCfLKrIGE2azyEHNT2oLh
         0XUg==
X-Gm-Message-State: AOJu0YzGMm8i1ATMnknv4OX+/bri28XR1eZYLTFZeVqWSqtpSHWvjNen
	/Oqcr9MpFh08Y9PE0/EsCaVpRgeAYEiMKo8JmlSy6GW0+DtynfaJ8pTOWSsnhQ==
X-Gm-Gg: ATEYQzy2Q+xaq3NJaM4XS2rWT8wdTbSJeY1S/kEXU1hixDkSls/7u4BrkgZhtXAxsml
	0tlY7f0EwKWOYF9neV4flvTr3JfAayD1UOlvEg35uFe9GKQhsKznsD6QV9O8N+ELXblHiQO1ZIL
	FKi+Erbwqk7F2Rsxvs9ZcmlnJrcdbR6sLK3IvfG/idY7zTJz2GLh5zztlJ7KWTjythfMkwCrX6k
	5MgrRNJtEGePtXyMr7Wchq4n5U5Y9bqoasxaBi7bxMWml9ui63Gfc1VAEK/8Aa1n86saxxFEWy4
	O9rWJAs3VMMb6i/lKu+2sh1/UuqvxYUd8aTYhwshuA1sdq2RylgIRoNLKIucxOXgCGzwbFn6Oaa
	h3so0LvowDq7ZTSDPk0eBLvQ2KvAkDeEt81qtX36REzVj0/cByY5X6BmJC/tY8ipanw/P6gocfs
	SByCUX5QaQuEejDRdldDt7qxdK6/U=
X-Received: by 2002:a05:7300:3b24:b0:2bd:b7b8:c361 with SMTP id 5a478bee46e88-2bde1eabb9cmr1396000eec.35.1772220647646;
        Fri, 27 Feb 2026 11:30:47 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f81be1sm4239250eec.33.2026.02.27.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:47 -0800 (PST)
Message-Id: <504d9cf7a0dbd663ea88c75217e1564504a60937.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:33 +0000
Subject: [PATCH v5 04/11] repo: add structure max object size metrics
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
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

