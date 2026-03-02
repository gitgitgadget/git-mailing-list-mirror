Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26D347529
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487939; cv=none; b=kiMDceWVKRJQcTmRzKFLkoGm5SBuP1HuKS+7wOnMIttgIqBm4wumiZ+EsRTscNLxoZZOzkFLNQqXUVlI0Jl13+v/Nc3obw1iD4fxq1OTm92S56xm46eJ2GxIXRPtQ6oz1zBtfAGIjdq4bEtcvDEchT5JhE+Ckd3Jh1xxpucCAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487939; c=relaxed/simple;
	bh=5hzTClOVsaOnuKJUpXvWOMFJIMx8FwBwcNbtvrrF3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZZ2jXwuTOSHX/VFkQl1dIwdSGlv5HxYaJqS2m+FrhPGefiF5J87uMCKyiHMeZiTEywUeqjbi3TqVDrofjEGhX3rYOqk4Wx6XUpVVwIHlVWqjEiUO/Z0tEKyrf9OEUMsUD/BLHNB8dmXwKlizndnxdPkX2w3Eh/qtU7fxF20z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd/G7mLp; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd/G7mLp"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c3896e32so2821388a34.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487937; x=1773092737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuvnBiE0Wn7LOt2inIcSTnboQG+Hs43xCUJsIMLJUdw=;
        b=Yd/G7mLpJhj5tl9EjD9MpUPIVvH+1rP+FADYWT5udG0yzlq2CwCNQQqZK8UDoBybuv
         Y7125cwUWpNMeau/NvHFZvsIHiRyskkc9ciK0n1sMCRs5CKS3Wum2WK+1QxLtJDGHTue
         o0znoKg/DrBfSsBh7fI0uyvEVBHBlkoCIDSyBouIwjhd7UCN10kbn6GpahTEvKXhfmbB
         zHuzUrYLoMf1GOusyBb+6JD4MUrMLUM71YvjjnuXBgHITyrCD6mQk7DSBo8OoSNzRhYv
         MdCZKanSjjf5hA7P88MbVYYz8mM18Fhv/YcIRkJO9lmUEcMZa8eDb1UzZB9dd69cFn7E
         8FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487937; x=1773092737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NuvnBiE0Wn7LOt2inIcSTnboQG+Hs43xCUJsIMLJUdw=;
        b=DptJxPIOE28p6ASwE0usBP1YkomHgIxFjDpqIDdsqSWONVkJ+O+qaqw+dnjDnK1PeH
         69BLgiwgUaIbdr0qWhXrm3Yf/tZGMH6UMiTsf2WjytJ4gjbOo3rUrjG78itRfvHVUyrC
         gT6fUMYVctcRwbMIEcLBJJPMhXIA76V4W1KXmzxSuJA9xUecukoXfIWb3dRgWwYyTdS0
         mNHfNFlchODcM9Hl3N+6ZrTBbKfCJ16Su0euPX8cR9zQcPh+Kq0ax1c5OJOIejO2spjD
         4IcOpGIVNtEuG1fOeaC3MBAvcSsLn8fgVx/+sxTJJAM/KVTDNMUkHQXnpKfmmH4mZ/l9
         lazQ==
X-Gm-Message-State: AOJu0YweYQq6K1ZYzC3DD/K/oAP3I/tQsSqRQ0qSjzrgAkmyT9aYBDbQ
	73EMNRI1KqwnXGaGMeyZlHgxqvS3x3ieH/i8VTviKreYY14yaG/pZXdecfhc7Q==
X-Gm-Gg: ATEYQzzKRQn/jP2AG83P2TX7XwJtsCaic7hbQEwhp1Fftn3I7LOcqe+n5Y/wx1q0gYJ
	bDapVWIOWFkAmlJmf7dKwWonk6s/rrVko1CpM4geaC9tBAvdDoZNNkD1ZjaOPBB9DfuAP0vn+2z
	YaFPeXYxcSXB764Py0q5xXAarkN3JK28n0Aume+kWSuE4puD2n2R80ow8FSf8y0SANiwQqikdTt
	N+0nR0z+iDV9QwuC2i3avxO16L6m/44TEsFYdg+qsO8nhEptKyTuLMuwP/j9/WulZ+RlkHX7dHz
	yW5z9CisYluVpFgpnRscLBpthrmEtQ9taB4ghUWBVQMrTWwCqa/Ay7xiXJfEIfCc/VU/zVdL4qv
	NqngUXf1TZk2eI5NC0CNo8rqBn19G8SYoPeeyMUnjeUSTcxWvlFwac2I7M+oTWmbUkD6TsWY2ZT
	FpWycqu2fHkdKEgyugGoJlf0bfZLUFdZ/z70kPEka1bQ==
X-Received: by 2002:a05:6820:81d2:b0:662:f244:3530 with SMTP id 006d021491bc7-679fae11a30mr7106125eaf.17.1772487936731;
        Mon, 02 Mar 2026 13:45:36 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:36 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/6] builtin/repo: find tree with most entries
Date: Mon,  2 Mar 2026 15:45:26 -0600
Message-ID: <20260302214526.2034279-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302214526.2034279-1-jltobler@gmail.com>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of a tree object usually corresponds with the number of entries
it has. While iterating through objects in the repository for
git-repo-structure, identify the tree with the most entries and display
it in the output.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 25 +++++++++++++++++++++++++
 t/t1901-repo-structure.sh | 13 +++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 047f5e098d..e726bb858c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -16,6 +16,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "tree.h"
+#include "tree-walk.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
@@ -211,6 +213,7 @@ struct largest_objects {
 	struct object_data blob_size;
 
 	struct object_data parent_count;
+	struct object_data tree_entries;
 };
 
 struct ref_stats {
@@ -458,6 +461,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 				     &objects->largest.tree_size.oid,
 				     objects->largest.tree_size.value,
 				     "    * %s", _("Maximum size"));
+	stats_table_object_count_addf(table,
+				      &objects->largest.tree_entries.oid,
+				      objects->largest.tree_entries.value,
+				      "    * %s", _("Maximum entries"));
 	stats_table_addf(table, "  * %s", _("Blobs"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.blob_size.oid,
@@ -625,6 +632,8 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 
 	print_object_data("objects.commits.max_parents", key_delim,
 			  &stats->objects.largest.parent_count, value_delim);
+	print_object_data("objects.trees.max_entries", key_delim,
+			  &stats->objects.largest.tree_entries, value_delim);
 
 	fflush(stdout);
 }
@@ -703,6 +712,20 @@ static void check_largest(struct object_data *data, struct object_id *oid,
 	}
 }
 
+static size_t count_tree_entries(struct object *obj)
+{
+	struct tree *t = object_as_type(obj, OBJ_TREE, 0);
+	struct name_entry entry;
+	struct tree_desc desc;
+	size_t count = 0;
+
+	init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
+	while (tree_entry(&desc, &entry))
+		count++;
+
+	return count;
+}
+
 static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
@@ -755,6 +778,8 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->disk_sizes.trees += disk;
 			check_largest(&stats->largest.tree_size, &oids->oid[i],
 				      inflated);
+			check_largest(&stats->largest.tree_entries, &oids->oid[i],
+				      count_tree_entries(obj));
 			break;
 		case OBJ_BLOB:
 			stats->type_counts.blobs++;
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index d003d64a8e..12ed67e846 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -59,6 +59,7 @@ test_expect_success 'empty repository' '
 		|     * Maximum parents     |    0   |
 		|   * Trees                 |        |
 		|     * Maximum size        |    0 B |
+		|     * Maximum entries     |    0   |
 		|   * Blobs                 |        |
 		|     * Maximum size        |    0 B |
 		|   * Tags                  |        |
@@ -122,16 +123,18 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Maximum parents [2] |      1     |
 		|   * Trees                 |            |
 		|     * Maximum size    [3] |  32.29 KiB |
+		|     * Maximum entries [4] |   1.01 k   |
 		|   * Blobs                 |            |
-		|     * Maximum size    [4] |     13 B   |
+		|     * Maximum size    [5] |     13 B   |
 		|   * Tags                  |            |
-		|     * Maximum size    [5] |    132 B   |
+		|     * Maximum size    [6] |    132 B   |
 
 		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
 		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
 		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
-		[4] 97d808e45116bf02103490294d3d46dad7a2ac62
-		[5] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
 		EOF
 
 		git repo structure >out 2>err &&
@@ -176,6 +179,8 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
 		objects.commits.max_parents=1
 		objects.commits.max_parents_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_entries=42
+		objects.trees.max_entries_oid=09931deea9d81ec21300d3e13c74412f32eacec5
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.53.0

