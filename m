Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9239334685
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868494; cv=none; b=W8Da+ol+2WNNUY3qak928R9yvbRL5IgHp/be4AECamRKVAhYl+GuBJ8QC8FwX2treSuiI87kFENHrZtKDgZxfNpKP6wAX3wV0qO+aGULWplLQr+s8pHIEWmDcQnmJxzz9+Wdvn0t10IgnKjfzhMI//vtncViR2vM4a8f5+9juhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868494; c=relaxed/simple;
	bh=u1T4jw20nhaKb+7D/MZA3UWlwkP1qqsqXm6gqAK1Wjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeEbYCHrop0cDO/jzt9lZCnyu0ZlgaJtvAHvD4isjmFz9hleth92g5NHASqttRiiAiSnq01GkypYqHsyCVMA6OqxXJiipBION+yVgmEku2f9AEjQlZhlMQA87vXtU+5lANv4vgRDEneyuxxGB7IzrSXn8WVM02ULXnHQ4xvofgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guRdeoCV; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guRdeoCV"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d18f80b5c2so3909406a34.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868491; x=1772473291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjwCSvvAdng9t5NPIYpNL8wZT4uV6rfSqDwiJpA253Q=;
        b=guRdeoCVmwQ8NWgXRhZ5B8pwomYwb7M7DId1ubSY4MDjr5lI66i9UWGRGva9I7vYHH
         IGUF0qb+kCzzyDQ+gh3ljEg7biU4t1TxuVJXZVBek0rt1sIYboYM+SbHgkkL0B4+LgHk
         diJUILUxnmgTWeOTHaQ0EawdlDfRixmyhZNXOD6pcbMoIZ5D2sMG4yLEKvJpZcZuPC9N
         0C3WqZpjR3wUe9eQfFIdG9/YGD3Naq1VGOUiAQGjFIoM0HqFTGaClZz31By7Bis7YL3k
         pwTzsByqdo9jviAMrRl+rD7/5a+VEfDiAUkI5RhtJan96IYz7rmR9168Sjx4rz1nxBwR
         PeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868491; x=1772473291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjwCSvvAdng9t5NPIYpNL8wZT4uV6rfSqDwiJpA253Q=;
        b=NZc6CK3Vkj4xtatYHNXB7FsoloFJzt1FPbQUORT/tUPzTua/+u3kX61qtUie32SAmB
         XMWO2PCovwE/OpFFLklaYxzw9thp0+2DuEZehyLXJa96oc2Px41Sy6eI28A/IcvJL1jM
         /y5eAevMgg0ueI+bPQHDx/LCNVMrjMAh8R4yKtay+qshZhepWnCSmbLzHaFeVE4tBxjp
         4Mv+TENa88OyEh+A31PTVE9Eh2VldV4waycfCk6w1yOehDmPBZh6YDC1XPkluJ4JFr7i
         RsJXnUFpS+WVqwkSpXArV05WSlV6UgYLSjux2PoK/VuY/+8HaOKkbigjxy+9/LG7ykU/
         7yXw==
X-Gm-Message-State: AOJu0YxwimCvJXsV7obsi+N58aFFLC3253A5RpR80NglsXjoGjK2N0JJ
	aMxkf78Hp/JjPRu2jeb9N//Zi5siJ22a6D3aiCOn2RUj8Z8prK9fA/NN/pTw3w==
X-Gm-Gg: AZuq6aJHSUWMYCyflzcXIv+83OamzyBHrdaEJQHSg1In5LBa9pupg4+CCS/kbTZJFr6
	M14MFbNYA/We5C6aM2ADWTI9U78/detqczbbi+4dBGF1AlFdaScFaw9Tjlzb9Y/aIUoGe8quwi3
	pF9ZImHn29cWz49JGyO0joq5RJnt7tlpMhj9dfDcQ9tSoO8/cvhDPjcJLP3DwRkb1PhGlSHccCE
	LV8Pw48NYj1gqJtEz6Td+NbRtTu677LWnQZ3habPvOtpmAbnHxzEgprnvW3hkK/O6Ma62eKwVAP
	0wOtosEh2ZkJjqrUcf9aAHqJ++Qzm7L8AoTBIjgpph0wiNTClEh91r47oSMbSktqAE0zd3RgEzo
	HpYeH++DB/JELw+cb2TombUNRaV0C2uTLLDQ79hRAp4DW2q78OLxV1pMDHQteGcTVtxwc4M3QrI
	YIMXurltPKKitAL4Tqez6IJB0+FopH9VM=
X-Received: by 2002:a05:6830:3689:b0:7cf:d0f3:4610 with SMTP id 46e09a7af769-7d52bf36ea6mr7151666a34.28.1771868491362;
        Mon, 23 Feb 2026 09:41:31 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0386c6sm8305476a34.13.2026.02.23.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:41:31 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	eslam.reda.div@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/5] builtin/repo: find commit with most parents
Date: Mon, 23 Feb 2026 11:41:19 -0600
Message-ID: <20260223174120.2356504-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223174120.2356504-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complex merge events may produce an octopus merge where the resulting
merge commit has more than two parents. While iterating through objects
in the repository for git-repo-structure, identify the commit with the
most parents and display it in the output.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            |  47 ++++++++++++
 t/t1901-repo-structure.sh | 151 ++++++++++++++++++++------------------
 2 files changed, 125 insertions(+), 73 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bdf2820463..97da147f68 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "commit.h"
 #include "environment.h"
 #include "hash.h"
 #include "hex.h"
@@ -208,6 +209,8 @@ struct largest_objects {
 	struct object_data commit_size;
 	struct object_data tree_size;
 	struct object_data blob_size;
+
+	struct object_data parent_count;
 };
 
 struct ref_stats {
@@ -318,6 +321,27 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static void stats_table_object_count_addf(struct stats_table *table,
+					  struct object_id *oid, size_t value,
+					  const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+	humanise_count(value, &entry->value, &entry->unit);
+
+	/*
+	 * A NULL OID should not have a table annotation.
+	 */
+	if (!is_null_oid(oid))
+		entry->oid = oid;
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
 static void stats_table_size_addf(struct stats_table *table, size_t value,
 				  const char *format, ...)
 {
@@ -425,6 +449,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 				     &objects->largest.commit_size.oid,
 				     objects->largest.commit_size.value,
 				     "    * %s", _("Maximum size"));
+	stats_table_object_count_addf(table,
+				      &objects->largest.parent_count.oid,
+				      objects->largest.parent_count.value,
+				      "    * %s", _("Maximum parents"));
 	stats_table_addf(table, "  * %s", _("Trees"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.tree_size.oid,
@@ -587,6 +615,11 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.max_size_oid%c%s%c", key_delim,
 	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);
 
+	printf("objects.commits.max_parents%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.parent_count.value, value_delim);
+	printf("objects.commits.max_parents_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.parent_count.oid), value_delim);
+
 	fflush(stdout);
 }
 
@@ -674,16 +707,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	for (size_t i = 0; i < oids->nr; i++) {
 		struct object_info oi = OBJECT_INFO_INIT;
 		unsigned long inflated;
+		struct commit *commit;
+		struct object *obj;
+		void *content;
 		off_t disk;
+		int eaten;
 
 		oi.sizep = &inflated;
 		oi.disk_sizep = &disk;
+		oi.contentp = &content;
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
 						  OBJECT_INFO_QUICK) < 0)
 			continue;
 
+		obj = parse_object_buffer(the_repository, &oids->oid[i], type,
+					  inflated, content, &eaten);
+
 		switch (type) {
 		case OBJ_TAG:
 			stats->type_counts.tags++;
@@ -693,11 +734,14 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 				      inflated);
 			break;
 		case OBJ_COMMIT:
+			commit = object_as_type(obj, OBJ_COMMIT, 0);
 			stats->type_counts.commits++;
 			stats->inflated_sizes.commits += inflated;
 			stats->disk_sizes.commits += disk;
 			check_largest(&stats->largest.commit_size, &oids->oid[i],
 				      inflated);
+			check_largest(&stats->largest.parent_count, &oids->oid[i],
+				      commit_list_count(commit->parents));
 			break;
 		case OBJ_TREE:
 			stats->type_counts.trees++;
@@ -716,6 +760,9 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		default:
 			BUG("invalid object type");
 		}
+
+		if (!eaten)
+			free(content);
 	}
 
 	object_count = get_total_object_values(&stats->type_counts);
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 918af7269f..d003d64a8e 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -27,41 +27,42 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository structure     | Value  |
-		| ------------------------ | ------ |
-		| * References             |        |
-		|   * Count                |    0   |
-		|     * Branches           |    0   |
-		|     * Tags               |    0   |
-		|     * Remotes            |    0   |
-		|     * Others             |    0   |
-		|                          |        |
-		| * Reachable objects      |        |
-		|   * Count                |    0   |
-		|     * Commits            |    0   |
-		|     * Trees              |    0   |
-		|     * Blobs              |    0   |
-		|     * Tags               |    0   |
-		|   * Inflated size        |    0 B |
-		|     * Commits            |    0 B |
-		|     * Trees              |    0 B |
-		|     * Blobs              |    0 B |
-		|     * Tags               |    0 B |
-		|   * Disk size            |    0 B |
-		|     * Commits            |    0 B |
-		|     * Trees              |    0 B |
-		|     * Blobs              |    0 B |
-		|     * Tags               |    0 B |
-		|                          |        |
-		| * Largest objects        |        |
-		|   * Commits              |        |
-		|     * Maximum size       |    0 B |
-		|   * Trees                |        |
-		|     * Maximum size       |    0 B |
-		|   * Blobs                |        |
-		|     * Maximum size       |    0 B |
-		|   * Tags                 |        |
-		|     * Maximum size       |    0 B |
+		| Repository structure      | Value  |
+		| ------------------------- | ------ |
+		| * References              |        |
+		|   * Count                 |    0   |
+		|     * Branches            |    0   |
+		|     * Tags                |    0   |
+		|     * Remotes             |    0   |
+		|     * Others              |    0   |
+		|                           |        |
+		| * Reachable objects       |        |
+		|   * Count                 |    0   |
+		|     * Commits             |    0   |
+		|     * Trees               |    0   |
+		|     * Blobs               |    0   |
+		|     * Tags                |    0   |
+		|   * Inflated size         |    0 B |
+		|     * Commits             |    0 B |
+		|     * Trees               |    0 B |
+		|     * Blobs               |    0 B |
+		|     * Tags                |    0 B |
+		|   * Disk size             |    0 B |
+		|     * Commits             |    0 B |
+		|     * Trees               |    0 B |
+		|     * Blobs               |    0 B |
+		|     * Tags                |    0 B |
+		|                           |        |
+		| * Largest objects         |        |
+		|   * Commits               |        |
+		|     * Maximum size        |    0 B |
+		|     * Maximum parents     |    0   |
+		|   * Trees                 |        |
+		|     * Maximum size        |    0 B |
+		|   * Blobs                 |        |
+		|     * Maximum size        |    0 B |
+		|   * Tags                  |        |
+		|     * Maximum size        |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -89,46 +90,48 @@ test_expect_success SHA1 'repository with references and objects' '
 		# git-rev-list(1) --disk-usage=human option printing the full
 		# "byte/bytes" unit string instead of just "B".
 		cat >expect <<-EOF &&
-		| Repository structure     | Value      |
-		| ------------------------ | ---------- |
-		| * References             |            |
-		|   * Count                |      4     |
-		|     * Branches           |      1     |
-		|     * Tags               |      1     |
-		|     * Remotes            |      1     |
-		|     * Others             |      1     |
-		|                          |            |
-		| * Reachable objects      |            |
-		|   * Count                |   3.02 k   |
-		|     * Commits            |   1.01 k   |
-		|     * Trees              |   1.01 k   |
-		|     * Blobs              |   1.01 k   |
-		|     * Tags               |      1     |
-		|   * Inflated size        |  16.03 MiB |
-		|     * Commits            | 217.92 KiB |
-		|     * Trees              |  15.81 MiB |
-		|     * Blobs              |  11.68 KiB |
-		|     * Tags               |    132 B   |
-		|   * Disk size            | $(object_type_disk_usage all true) |
-		|     * Commits            | $(object_type_disk_usage commit true) |
-		|     * Trees              | $(object_type_disk_usage tree true) |
-		|     * Blobs              |  $(object_type_disk_usage blob true) |
-		|     * Tags               |    $(object_type_disk_usage tag) B   |
-		|                          |            |
-		| * Largest objects        |            |
-		|   * Commits              |            |
-		|     * Maximum size   [1] |    223 B   |
-		|   * Trees                |            |
-		|     * Maximum size   [2] |  32.29 KiB |
-		|   * Blobs                |            |
-		|     * Maximum size   [3] |     13 B   |
-		|   * Tags                 |            |
-		|     * Maximum size   [4] |    132 B   |
+		| Repository structure      | Value      |
+		| ------------------------- | ---------- |
+		| * References              |            |
+		|   * Count                 |      4     |
+		|     * Branches            |      1     |
+		|     * Tags                |      1     |
+		|     * Remotes             |      1     |
+		|     * Others              |      1     |
+		|                           |            |
+		| * Reachable objects       |            |
+		|   * Count                 |   3.02 k   |
+		|     * Commits             |   1.01 k   |
+		|     * Trees               |   1.01 k   |
+		|     * Blobs               |   1.01 k   |
+		|     * Tags                |      1     |
+		|   * Inflated size         |  16.03 MiB |
+		|     * Commits             | 217.92 KiB |
+		|     * Trees               |  15.81 MiB |
+		|     * Blobs               |  11.68 KiB |
+		|     * Tags                |    132 B   |
+		|   * Disk size             | $(object_type_disk_usage all true) |
+		|     * Commits             | $(object_type_disk_usage commit true) |
+		|     * Trees               | $(object_type_disk_usage tree true) |
+		|     * Blobs               |  $(object_type_disk_usage blob true) |
+		|     * Tags                |    $(object_type_disk_usage tag) B   |
+		|                           |            |
+		| * Largest objects         |            |
+		|   * Commits               |            |
+		|     * Maximum size    [1] |    223 B   |
+		|     * Maximum parents [2] |      1     |
+		|   * Trees                 |            |
+		|     * Maximum size    [3] |  32.29 KiB |
+		|   * Blobs                 |            |
+		|     * Maximum size    [4] |     13 B   |
+		|   * Tags                  |            |
+		|     * Maximum size    [5] |    132 B   |
 
 		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
-		[2] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
-		[3] 97d808e45116bf02103490294d3d46dad7a2ac62
-		[4] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[5] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
 		EOF
 
 		git repo structure >out 2>err &&
@@ -171,6 +174,8 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
 		objects.tags.max_size=132
 		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=de3508174b5c2ace6993da67cae9be9069e2df39
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.53.0

