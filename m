Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802941EEE6
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832217; cv=none; b=tHkrFGQhHx46/8iXKSUuoDCS3wIwxuzun7MsBJj1JMafkyzNcmTH5BDuYV8E9uNZ3Ubr5gbFskX2WIY6Gw0EKWbxhXAFkKUPbnCNIvV0XT7q94qIxD6+XcpgE4gNANUgtXqwjgbcTBfBZdXAbItEHfGAjh/uwdibpU1Y9U5oVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832217; c=relaxed/simple;
	bh=fxdRF0i1f/4Kp0/k0SdtxwOagz2Mqwmkkn1pnd2xdGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8OZzG0dLeIckqgx+i58sxlBvaSYLck42GRnv9mkLyKNBQnEW7OKdZeIbbeSLlsaQiYczlFVQngDn9P4LXKngj8s8N5ejLetsgfBWdhRinSMju7HNH/B5YMdssxTnsMPgwiHZvMAJ0T6wcf4eha5+d8/2qFyR/IOUDnO6UYbC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9k8UkKk; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9k8UkKk"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3f0c93ecf42so2467336fac.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832214; x=1766437014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=K9k8UkKkTdvPSktW1R6gqBsESBnN9F3IIvy+eat/QDAtxAkDmMw/bnFbGBR6rlJM7m
         94h3vYy1ejV+lI1AhMqSfh7uGS/8wT23KB7BQmBjFVUu2mNwL5cIWnkg/739JshcixsJ
         ldGFAcx0tVQdpVJvreMjZ2H4AC/ut1yuK/ozTH/s76KyMNhs1cV9qD3II3Q0Lv6HZ4Up
         Qsgys26LInVJhiG4V7SDgHvSTYUqMG7LT88tLq4UKD+BmfVb5TBQWvAOTPv2nGEOOO4b
         DogFPi5G+vTwSYRb+ckeGY7R7ZbSSLEni4ku8aLmyqwUDs5NPPaEOLgl+WmaMkJ7BZaF
         QE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832214; x=1766437014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=tPzrF288JUndKEML7Y07JtPbSROyXqEGUcnfvoJ9JrjfupyHswfhpRZCzC9pGLbgEo
         IoHqE9W0t73DsbaKtQSKxdQEnWj0Aiyd75OYupXjhnUgXxfjikf02OQTfMV4unvU6zFD
         uAtKVN3yum3f+Aal6NYA20bhVAosA3x9kDXOz/sK/gX9A6kEnEBsDy8k474VlY0piW0z
         pc4ztkuUECiq8P4Bzf4JyTPLxNtmCodik80ufie74fASCsLpm4lIEaAnDtZtnknM2L/p
         lHbmOXtufUbjELHNU/p1glqF5G1RrwJaP5RO2AhSEbgEf0Mne9klMWezryYG83JBykSF
         pc3g==
X-Gm-Message-State: AOJu0YwBjJpmiPnKQG4GoXaiYKAs3BCN9j2ZiUkd8bwZZQn/SZMrde+u
	HM6qBwMueWCxLNg79lTKt2GY3ZZi02wbxzrQTFw5y85RV/gbCOhn0dOu9bGtQA==
X-Gm-Gg: AY/fxX5wfhKVn/7JXkHC2JelpZdQoe3uk/oMfiyooBq5dO2ALdzrTS08C/X8vMB1cLw
	xNGgZCTWVbu+FC32Vt53lTcaKA4TrIRMSBeojLexKNgozlUgkvgfGdXTVVhrSpX25oz/Rc3ryCt
	US2yHjb05vZMumOiR3wO/cMdwBkxiM/A46OXvkDbJKlgxXR0L7ZwezgvmehExyJMbNxdfPGAN8d
	dqZw++GDm3UuAyNVbj2+1HLQpDfdFKc707umZHkRIU+/p2WfOeYX31W7bOR2ND7GqmSwJjD5slD
	PBQbMdRjcPxAicGvGNwl9yXtSV0m8dYv5lzKf4qtB75bpc1JdgSeZ1qPv+98aBeP79htGDrM0D+
	qasbxF8aGtFQoh3i6qNjbBcdXdE+v46+H01a5LSxQGU5vJNhMZHB8LwtU/NyyVYznMdDIKQxWLm
	MuOWYNDlH/XAybYOnAvR4=
X-Google-Smtp-Source: AGHT+IFotQo/mOC8Ko9ma3XPKWyEK6Vryxq6VKJA1fTgFgfWTQbEc5hOewhVjNavnctnTx5pDw+aZA==
X-Received: by 2002:a05:6820:4d0a:b0:659:9a49:8edc with SMTP id 006d021491bc7-65b45187cddmr4496106eaf.16.1765832214055;
        Mon, 15 Dec 2025 12:56:54 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:53 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/7] builtin/repo: group per-type object values into struct
Date: Mon, 15 Dec 2025 14:56:33 -0600
Message-ID: <20251215205639.2700270-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
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

