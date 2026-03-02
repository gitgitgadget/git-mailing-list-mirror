Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CD347505
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487936; cv=none; b=ZxTckwo8gMI7/5KLmtRTvBCBUan0ToDTWb57Ven4427it/P28+rVECC5F6KNA9t6c6Zlia4VPysr20QPJ6souvy07kFO+MAf8LzeexalOryGC5y2aDwPz99601lqKUXFPICxxQa6r9y1/RXTfo0Skzvq0lTbXpliCKBfcGqkXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487936; c=relaxed/simple;
	bh=3+g/YGA39CwCvDy6Sh6nnODwR4a3BkFBErtZ+4bva2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTrz9Jo52NhM9+pado+rJW602RJLg+LOyZfUkQayZGhpXZ06f9nHcNK3B8YYRqN+Gr1ZTzXh+AtZQ+TV3rz7aUuQHQMHXO9Dr0zb2HznXAa4WjCzaVjlj7OjQt94IZwpvFtj0kr9ux/GVvT0vK6hL0CumQEP9L1Z1PmrretWHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njwuml7v; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njwuml7v"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so5452122a34.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487934; x=1773092734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTQ/8Pkw8rf99L+eWFFHSoe3F6J5pbEjboJn2EoOewc=;
        b=njwuml7vUXy2zgN/C46Xb0Utehw7m7wOSeJctNmvm5M2WsgCtepufsLPK8FpMdd5YA
         CZte41FajjtWTBdAxhPUlAog2orU8bO3XsAb/SyV2MspfCqCPG8Fcc+r4RDUQbsn4+6J
         P2BjYV9MijwOAQh7Y5OWylUX8cVLV0ee/20sFUd8eZ0w3BuNNkt81jFqIw+t2HZrtgMG
         4Mz3YMvlBZoDQCxepb3hjk8wbK7paFJMaJjGIp9TjDjN6iBZKVfXctQVmemUAricQMP1
         HBCzlhRo9/gGPMoazG/XOtIl2U5bn4jmRRM/548ZXpK/B4n/9CX5goCpX2wG0Gbb0JD9
         jOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487934; x=1773092734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTQ/8Pkw8rf99L+eWFFHSoe3F6J5pbEjboJn2EoOewc=;
        b=JbY+RFUTVCQ8VFnmq0jj+bf/4ot2xeKzr4sIM6kAIJuraoEE9ynyknqymY9sO59TxW
         /6GE20XB+SD1Z0hiGjJtRaMRSzZqyvOQKnaRpUdmBCDtnZ246RowzK9ozUNiWdV33vmq
         R5ujcdWFXQ79bOZZ8RCHkc7iuhl9jKPZVVbjrZ0mJI22Av/lb7oOKpmpp3VwxIQdDIAC
         Sr7+Z4IgKp1QMS5oUQo7+mdH+GMCgGH28fwPu1efrdFLJYY/QE0X1U+zHf4GFD36NByl
         FkPcSq33lMji+2W4INF51PWqdAKvnlRa5KKX7erfLY80uFttlNTnXM33Cd91hXsM+S7X
         Bsmg==
X-Gm-Message-State: AOJu0YxKsZQYrVz/iSfGfos5A2EMnLOu+v7H8LSHe+2j/npj88I79SL5
	4DE6kfN714H8jHKf/wwZjkGJgPr+sUGqpRiNPdmvBXAWnvDuqv4C7cAdkq+dJA==
X-Gm-Gg: ATEYQzzVGYggfex06pcAgJpRKfm1T+d0xpwKEkVU/BfmjbfkQau3G53neqxg4vgh+yo
	+GZ4Jf4jVdwsjh5RSNMaVkqU/J1eLEpBNSXDrj8thZaoSfig4Jtw7HqCtdG9uf/5dYmWtbBQafZ
	XhbSDQ7L7RkIfHqEKrrWcpRNxzaVGReC01/ayzeuwVRsWZDA3rsltGaTkgf0QlRIsN4p7a93SgU
	WDSmnnhf9DZGw3n604V5cAoB1YG+Jtj0c7GLvPc2qZA30WQJG/zr1gHKY+5WdXyIE6fQXrhn+Yk
	IMUMsGsUxZMwQNkKZLKZjn9qVOvRspoZ6oYGfsenD4kEjtxNNs1DXLUJvCaQVQpWMXw0x8GpPvD
	8b7xmMELfs2q5LAkYgRqm/rMrdUGqD/NTCplA/tl6arW/RAf4na+OAiF2bdSZrvvdrjIwlEGzS8
	rqduLxUUp0qGAA8fOeOEjyd4JG4NL79ng7Rg6fRfZxdg==
X-Received: by 2002:a05:6820:813:b0:677:74dd:45e5 with SMTP id 006d021491bc7-679faf833bemr7920207eaf.54.1772487933703;
        Mon, 02 Mar 2026 13:45:33 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:33 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/6] builtin/repo: collect largest inflated objects
Date: Mon,  2 Mar 2026 15:45:23 -0600
Message-ID: <20260302214526.2034279-4-jltobler@gmail.com>
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

The "structure" output for git-repo(1) shows the total inflated and disk
sizes of reachable objects in the repository, but doesn't show the size
of the largest individual objects. Since an individual object may be a
large contributor to the overall repository size, it is useful for users
to know the maximum size of individual objects.

While interating across objects, record the size and OID of the largest
objects encountered for each object type to provide as output. Note that
the default "table" output format only displays size information and not
the corresponding OID. In a subsequent commit, the table format is
updated to add table annotations that mention the OID.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 63 +++++++++++++++++++++++++++++++++++++
 t/t1901-repo-structure.sh   | 28 +++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..e812e59158 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -52,6 +52,7 @@ supported:
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
 * Total disk size of reachable objects by type
+* Largest reachable objects in the repository by type
 +
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 782194cf4c..59d5cb2551 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "environment.h"
+#include "hash.h"
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
@@ -197,6 +198,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		return print_fields(argc, argv, repo, format);
 }
 
+struct object_data {
+	struct object_id oid;
+	size_t value;
+};
+
+struct largest_objects {
+	struct object_data tag_size;
+	struct object_data commit_size;
+	struct object_data tree_size;
+	struct object_data blob_size;
+};
+
 struct ref_stats {
 	size_t branches;
 	size_t remotes;
@@ -215,6 +228,7 @@ struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
 	struct object_values disk_sizes;
+	struct largest_objects largest;
 };
 
 struct repo_structure {
@@ -371,6 +385,21 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	stats_table_addf(table, "");
+	stats_table_addf(table, "* %s", _("Largest objects"));
+	stats_table_addf(table, "  * %s", _("Commits"));
+	stats_table_size_addf(table, objects->largest.commit_size.value,
+			      "    * %s", _("Maximum size"));
+	stats_table_addf(table, "  * %s", _("Trees"));
+	stats_table_size_addf(table, objects->largest.tree_size.value,
+			      "    * %s", _("Maximum size"));
+	stats_table_addf(table, "  * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->largest.blob_size.value,
+			      "    * %s", _("Maximum size"));
+	stats_table_addf(table, "  * %s", _("Tags"));
+	stats_table_size_addf(table, objects->largest.tag_size.value,
+			      "    * %s", _("Maximum size"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -453,6 +482,14 @@ static inline void print_keyvalue(const char *key, char key_delim, size_t value,
 	       value_delim);
 }
 
+static void print_object_data(const char *key, char key_delim,
+			      struct object_data *data, char value_delim)
+{
+	print_keyvalue(key, key_delim, data->value, value_delim);
+	printf("%s_oid%c%s%c", key, key_delim, oid_to_hex(&data->oid),
+	       value_delim);
+}
+
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
@@ -492,6 +529,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	print_keyvalue("objects.tags.disk_size", key_delim,
 		       stats->objects.disk_sizes.tags, value_delim);
 
+	print_object_data("objects.commits.max_size", key_delim,
+			  &stats->objects.largest.commit_size, value_delim);
+	print_object_data("objects.trees.max_size", key_delim,
+			  &stats->objects.largest.tree_size, value_delim);
+	print_object_data("objects.blobs.max_size", key_delim,
+			  &stats->objects.largest.blob_size, value_delim);
+	print_object_data("objects.tags.max_size", key_delim,
+			  &stats->objects.largest.tag_size, value_delim);
+
 	fflush(stdout);
 }
 
@@ -560,6 +606,15 @@ struct count_objects_data {
 	struct progress *progress;
 };
 
+static void check_largest(struct object_data *data, struct object_id *oid,
+			  size_t value)
+{
+	if (value > data->value || is_null_oid(&data->oid)) {
+		oidcpy(&data->oid, oid);
+		data->value = value;
+	}
+}
+
 static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
@@ -585,21 +640,29 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->type_counts.tags++;
 			stats->inflated_sizes.tags += inflated;
 			stats->disk_sizes.tags += disk;
+			check_largest(&stats->largest.tag_size, &oids->oid[i],
+				      inflated);
 			break;
 		case OBJ_COMMIT:
 			stats->type_counts.commits++;
 			stats->inflated_sizes.commits += inflated;
 			stats->disk_sizes.commits += disk;
+			check_largest(&stats->largest.commit_size, &oids->oid[i],
+				      inflated);
 			break;
 		case OBJ_TREE:
 			stats->type_counts.trees++;
 			stats->inflated_sizes.trees += inflated;
 			stats->disk_sizes.trees += disk;
+			check_largest(&stats->largest.tree_size, &oids->oid[i],
+				      inflated);
 			break;
 		case OBJ_BLOB:
 			stats->type_counts.blobs++;
 			stats->inflated_sizes.blobs += inflated;
 			stats->disk_sizes.blobs += disk;
+			check_largest(&stats->largest.blob_size, &oids->oid[i],
+				      inflated);
 			break;
 		default:
 			BUG("invalid object type");
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..1999f325d0 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -52,6 +52,16 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|                      |        |
+		| * Largest objects    |        |
+		|   * Commits          |        |
+		|     * Maximum size   |    0 B |
+		|   * Trees            |        |
+		|     * Maximum size   |    0 B |
+		|   * Blobs            |        |
+		|     * Maximum size   |    0 B |
+		|   * Tags             |        |
+		|     * Maximum size   |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -104,6 +114,16 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Trees          | $(object_type_disk_usage tree true) |
 		|     * Blobs          |  $(object_type_disk_usage blob true) |
 		|     * Tags           |    $(object_type_disk_usage tag) B   |
+		|                      |            |
+		| * Largest objects    |            |
+		|   * Commits          |            |
+		|     * Maximum size   |    223 B   |
+		|   * Trees            |            |
+		|     * Maximum size   |  32.29 KiB |
+		|   * Blobs            |            |
+		|     * Maximum size   |     13 B   |
+		|   * Tags             |            |
+		|     * Maximum size   |    132 B   |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -138,6 +158,14 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.trees.disk_size=$(object_type_disk_usage tree)
 		objects.blobs.disk_size=$(object_type_disk_usage blob)
 		objects.tags.disk_size=$(object_type_disk_usage tag)
+		objects.commits.max_size=221
+		objects.commits.max_size_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_size=1335
+		objects.trees.max_size_oid=09931deea9d81ec21300d3e13c74412f32eacec5
+		objects.blobs.max_size=11
+		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
+		objects.tags.max_size=132
+		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.53.0

