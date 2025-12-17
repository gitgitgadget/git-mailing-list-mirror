Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40253370FA
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994052; cv=none; b=eW0nDFm+NmYMnRwwQR6DDBX/EMcGHM0L+k62iJNBAbBxqLPmmOiV6Z+j9f42nCB28eq848XhcdkHsCpL8VUImXNzV+mVaDulvP3Ct4BSF48mVIBo550dDe7fHtvgrWLNLh4sbckjT3s6TJwLF+SrpUnhZtz1/lBN6HY6YhJCRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994052; c=relaxed/simple;
	bh=fxdRF0i1f/4Kp0/k0SdtxwOagz2Mqwmkkn1pnd2xdGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGpIrf0ZHPt6BBZkQ7S8h97Ustj7i+iMv9wRzut5V9Mj/1t5hh3QG0PXqKbH7BLCCpGr/LIDRooIpXu4g/+R08LF9XkvqVJ5lNLl93k3jMpSId40+8tbKfTuUchGwEK8j+d4u0wAYdxBKknQRE/dyOdm3SRr2xt5gP+hVgfmGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnWPrvvZ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnWPrvvZ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ec4d494383so4300867fac.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994049; x=1766598849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=AnWPrvvZ1qn4YjIkkWgUh9qmWATE6Vn+lsJiRRkq9lCL575lerSOAGHPUO7D508SFb
         /RxQ1uX7M0fqJHT2/Fgffil18bOtXNt4/BSnDnRBaxhUK0MKi+nAReagkpS4Cj2my888
         5uJBQ3gzO2wEm8O3IygjvZGlEFRK5dDpf9SfAFPDQVrFYxJuTlWaMXssRj5Ws+tGVnV7
         hqv75Ujyn0qU2mN4m/Ca2sftteIZZpNjwlgZuegzYJ2NfqXnF7nIECxslbyzpmYszDZ8
         plJ7Jgy5OhIkjmS3nFlhkfksxK4boJSzqYKcq6isbvUsnKz5Tn0I620SRxxgwqMcoAAr
         ulCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994049; x=1766598849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0FWefyV+RQwHB8kM95WAB2YifbyvJsEyRj9TgMRFY=;
        b=cUzDWv8zYriTy/AwHgPoTzNoLelqujiPQv57w/FN+1SUBkGf+hLE6H4hYdWfaedkWl
         esz8szuAx60Yt9Y313AcK26DBT0ZKPwl+TIwC6UV4V+EHoFVP/oYDq6HCdwJunyBhMVt
         8IvT8NvjrgkhusEPXKPiuCzxX4RFYuokVCtxKMe2AV8W31ccJ+ttSKhwoOgu7g6gwvz6
         vIK8FNGPdxBBTMk/WhzNVHrejObGBYO21L7VYLbR57xhBQWh7pyqtcVI7OxIj2b+Pul/
         nqSjfwL5J7Q9V/Q49zcpQ6Dn9dHpviL73EprujGQVFVsu/ysmkNadl5nhmiwF9dw5Cu4
         VShw==
X-Gm-Message-State: AOJu0YzBXGfprlhiKtA9fgajNNVsktehh322aYL10fDUEU1p1XEqVWx3
	WhGn9ol8f1egzF8eEaIkw9JnE+20mYmYtdON6Qm0Ot4KKlsAwpxcDPGfMepYqQ==
X-Gm-Gg: AY/fxX4o6+I9S6EgLfz7cRg804vM/HdcA7YgNxNxuJTngboP5i2iAMkta0MqmTbieah
	s1U6uLkpmTB/oC6YmvjftloGpRX+7emrcrb+zoXHDH208IklypGMSTMrZvd7SBuOS7NEdMBZn2e
	7jseJU108PUCXGXAQROBK3S7C0LeCNWHJWAOfekQ2aKwFpXCbXJtiH1xguY+TJwDP1gUnYJjL+m
	yEMRFwbS/MQATh6SSb4NfpKcIlV8meeHD99G2eFNRw8bM2mK+ob4VGoh1YKcAtJsFbWD/3CsdBA
	aFfU+8R5S26ru3js0a67PoPsxCoBu9axLUb7TzUUo/fpu8UlamnriBkvGvlWUwOPw01G4+vzLbI
	As1UT1FW8GBTfeYETM1onQ2VFyK8TRZ6XctKuGjTqoF0o/cryfEaQN706gmbtsq8pr3ET0BzLkR
	ZIs152SaEuTzp8/fxNOmg=
X-Google-Smtp-Source: AGHT+IGpIdh3flgCmAgcXhz8IRHJclkvuC7TugMmDv25fWRlcz3rxuTkeKYLIJQyyQ+tlPFNqzNXwQ==
X-Received: by 2002:a05:6870:890b:b0:3ec:3f3e:b61c with SMTP id 586e51a60fabf-3f5f8ca0a4fmr9530872fac.46.1765994049344;
        Wed, 17 Dec 2025 09:54:09 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:09 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 1/7] builtin/repo: group per-type object values into struct
Date: Wed, 17 Dec 2025 11:53:58 -0600
Message-ID: <20251217175404.37963-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
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

