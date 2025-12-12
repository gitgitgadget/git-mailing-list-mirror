Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12B2877FC
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579013; cv=none; b=OgIuUWnL/zQ9HoEg6muh402cYoPHxo6/k57X1uqXIbQHpvFZV7uvsZjJ8Rk9vKuyaAHk+4StBGTozzD4ZMws8MeXJDs+sPTiii2/ii5WVp7LGVUTJRNO6jNMwmPSagEA5q3Yj5f/Z7vRjNSNgt3IWx/UVyZlnIXhKM0ddBcz3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579013; c=relaxed/simple;
	bh=fxdRF0i1f/4Kp0/k0SdtxwOagz2Mqwmkkn1pnd2xdGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5ov+Mv+ENy7hmstffud1+gHkid+T2Y1pLBast/wtPwjaijyxdflLCZh39EvDG0A49zLSGLLH9zGtGY7S/Jqg9u1grX3ORBLXtnMfOewUzSj9jNwoT0d4ecRrg1Z9hkeykpIBLNeMh0YChaA6KnRHJlhLpRFpiaBHbr8MUYZbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Jm1N+k; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Jm1N+k"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3ece54945d9so647117fac.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579009; x=1766183809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=g1Jm1N+kGi7BlhIPk8FebioXJu5R8k4PzAon5tP13NPs5rVZ+w7eeHMA0VY4ypVEWe
         atLOZmCAj0643Z5rrJcUvnQZnCPIHtpptzo+p0TsdafuWLqe8F0jg2u4SPREo4lpRwxZ
         QgXuAG5zNbA2zXELUBpFcqYus2cerxV4SyZUUSr4P7S92t7MvaAXJW2zycc856yhe4rY
         f+G8e8Ie9dqO0uK5hX+iJ4jrubfNh1N3J6/gDqTY4AUKV5QxSt0zefU0B3j8w/+O/QVi
         a33dneoRLRbtju88T8xoP2rKfzJ2O00KmNnuqeOUmw9wXcOBOai3jqtn6CvAb3765hyF
         R6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579009; x=1766183809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=wMUmY1ZYYV3Kgh52O7IzIBurs/je/SEWQt43ZvI8lC/BoXgNJHv+IjkGo8fxjYhHED
         nNDLUt81qyIov1T4OQlV3u0cmvnfzHLa7pIHZZ/pXW/2Jnn9H92RPYhtv6zauQZu9hJT
         +HxOEYZ959ba/RnL9q9Yd0FKgtF4sQk5WccIPjNj9FRcWElVeNowt6gNdoTMFkqpIaPJ
         BJMkIqpasAZME0Zy74DodD0ZbE0KgViFiWAh9KziYE6OWmVVP1EShopwv7RsJPTTHMhH
         nbvYsymI7ry9sRytbc5bpdmsHzO1t+Kq6W/zuJwWUy8UkIeac9zHB+QHM+ls1oA8IKTe
         p48Q==
X-Gm-Message-State: AOJu0Yy4Ck/9pGZcUWEJHMmY7rIfyKrbfGyjxHeM9XYl2EUULJ2UjRgR
	u/wXvRrrhVCiUu63CHPF6pRa54mUZb2UkCUcOtR0EoAGdefwoD7gDYKtErFbNQ==
X-Gm-Gg: AY/fxX7JrpVuTEgG4u23nigWEtCuAbRznJoJtdy1Hi2l+zZ9zuKMmtO5Kb8rjVMn0Km
	Ab01meHA4AXwm2DhQdJZkBn3X6dE90xhOzgymLw3Nv/7riFuBEwybT7p6ksaB6V+IkYZhuif5Gf
	cXdtgOr8IW3k6plQi41LpAHhIZoBhX7D/qW5JpEN14l35oJ83lTQKaDK84wmEcJgjWYkFC2Sm1Y
	LARvEksNicjKv13jMwwkHO2eCdrDd8RQzSStgv6WFmTyMHuXu+7iYLyOhUDPAShH7FeUmEmBRtx
	yHKqCOO00XYtnI2dRAwX3UTfVW+9jDKD/pUl+/YUaDJkj417ElHdUE69XresShVCK9bDZ1cGu2B
	3qkly7VfK8qyRtAB8gVid5nU1kWcR8xIojGBuAxfsc2N2/lYvwcNcvbBASZWkPgDwDf1tJgDgJZ
	HSwy9ZRJmwqhpsKxFqaD4=
X-Google-Smtp-Source: AGHT+IHGpelQ+td3101Ljwt3aEmUN9mv9/aJnHxQllOkFGRF8P9Edlc1M7iYlvJAnCAIR8GESLwMaw==
X-Received: by 2002:a05:6870:204e:b0:3ec:4b3a:286a with SMTP id 586e51a60fabf-3f5f8a71d6amr1967209fac.17.1765579009255;
        Fri, 12 Dec 2025 14:36:49 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:48 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/7] builtin/repo: group per-type object values into struct
Date: Fri, 12 Dec 2025 16:36:38 -0600
Message-ID: <20251212223644.3090879-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `object_stats` structure stores object counts by type. In a
subsequent commit, additional per-type object measurements will also be
stored. Group per-type object values into a new struct to allow better
reuse.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 2a653bd3ea..a69699857a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -202,13 +202,17 @@ struct ref_stats {
 	size_t others;
 };
 
-struct object_stats {
+struct object_values {
 	size_t tags;
 	size_t commits;
 	size_t trees;
 	size_t blobs;
 };
 
+struct object_stats {
+	struct object_values type_counts;
+};
+
 struct repo_structure {
 	struct ref_stats refs;
 	struct object_stats objects;
@@ -281,9 +285,9 @@ static inline size_t get_total_reference_count(struct ref_stats *stats)
 	return stats->branches + stats->remotes + stats->tags + stats->others;
 }
 
-static inline size_t get_total_object_count(struct object_stats *stats)
+static inline size_t get_total_object_values(struct object_values *values)
 {
-	return stats->tags + stats->commits + stats->trees + stats->blobs;
+	return values->tags + values->commits + values->trees + values->blobs;
 }
 
 static void stats_table_setup_structure(struct stats_table *table,
@@ -302,14 +306,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
 
-	object_total = get_total_object_count(objects);
+	object_total = get_total_object_values(&objects->type_counts);
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Reachable objects"));
 	stats_table_count_addf(table, object_total, "  * %s", _("Count"));
-	stats_table_count_addf(table, objects->commits, "    * %s", _("Commits"));
-	stats_table_count_addf(table, objects->trees, "    * %s", _("Trees"));
-	stats_table_count_addf(table, objects->blobs, "    * %s", _("Blobs"));
-	stats_table_count_addf(table, objects->tags, "    * %s", _("Tags"));
+	stats_table_count_addf(table, objects->type_counts.commits,
+			       "    * %s", _("Commits"));
+	stats_table_count_addf(table, objects->type_counts.trees,
+			       "    * %s", _("Trees"));
+	stats_table_count_addf(table, objects->type_counts.blobs,
+			       "    * %s", _("Blobs"));
+	stats_table_count_addf(table, objects->type_counts.tags,
+			       "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -389,13 +397,13 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	       (uintmax_t)stats->refs.others, value_delim);
 
 	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.commits, value_delim);
+	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
 	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.trees, value_delim);
+	       (uintmax_t)stats->objects.type_counts.trees, value_delim);
 	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.blobs, value_delim);
+	       (uintmax_t)stats->objects.type_counts.blobs, value_delim);
 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.tags, value_delim);
+	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
 
 	fflush(stdout);
 }
@@ -473,22 +481,22 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 
 	switch (type) {
 	case OBJ_TAG:
-		stats->tags += oids->nr;
+		stats->type_counts.tags += oids->nr;
 		break;
 	case OBJ_COMMIT:
-		stats->commits += oids->nr;
+		stats->type_counts.commits += oids->nr;
 		break;
 	case OBJ_TREE:
-		stats->trees += oids->nr;
+		stats->type_counts.trees += oids->nr;
 		break;
 	case OBJ_BLOB:
-		stats->blobs += oids->nr;
+		stats->type_counts.blobs += oids->nr;
 		break;
 	default:
 		BUG("invalid object type");
 	}
 
-	object_count = get_total_object_count(stats);
+	object_count = get_total_object_values(&stats->type_counts);
 	display_progress(data->progress, object_count);
 
 	return 0;
-- 
2.52.0.209.ge85ae279b0

