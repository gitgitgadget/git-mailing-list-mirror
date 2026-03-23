Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DC3976B7
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266031; cv=none; b=p3dmLy6Zqi5LJ+a2FLOyRhuzMqskyerELuCkBi8tDFvhGnv7TnQyb3goCWqprWtBJ7YWnBaOCb5dmtEXG5L1a9ORyvNxP3lI3ckO04ZBX7Qm42Aq5STck6xzNjz0CrDbQJQhsB3XsN+kpY8OaPIXYTpvVIYvDdvXOt1Qkbjy/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266031; c=relaxed/simple;
	bh=qS1j7FRgPg1d7/cI5mt9GgcekZxbLLxCxBTPcxqVRno=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S4gnhcwcYD1nZpufz8gEOjOmj2rlcGILEvD8teTtfTfNvATGbMqIOsuSuqTtM+ruCathl66SvrVPEarbw4+JfrFV5ogcLa0/7KIKe1bedF9rpcSdWAub+LsUDPKdh4WFMusHXKg6Ams0SS2z/LRwaB7fElWhdG0nBuv7kr6kJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaY92qJ6; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaY92qJ6"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c0c955a481so2539613eec.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266028; x=1774870828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BREoAFYlWj7eW5fcf8JSaEKsoKxozlUBYObym3qJ6eM=;
        b=iaY92qJ6eq6fxfmiMY7iBF9fZ+XkrvRuQSrkW31QSFj/36ZPkNMDzHX2DQ6fQsboi9
         Mw38SAUpK3CnmAPyUbscxzdnVjlaIuMPyLZ1N3s9Y42q+/Ukz3bU/MoK1hu/tdPm75Cs
         EBG9rRuXQmlr/7cXjUUWLahxZcw7V0ACmo7iSBrvkk4nlP2/OX1mnigoFwYBJcfakWqx
         xYztdYMbLXCcxfhN02OUSsSOwkzAwiKexJmA7gcuvDxGa1kC91PvIEICWILnxnnuhXjs
         62proLRmobAyxvj74LQgK4pqPb3suUtu2+eYGewr9aOqALsxf8mKtCnI0T0WBj/EkksB
         ggRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266028; x=1774870828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BREoAFYlWj7eW5fcf8JSaEKsoKxozlUBYObym3qJ6eM=;
        b=fV5Tt1cNoKokK+ifX5I2cKwpAceaO4To7m4nUV0BJ7Z9pIXKgi5Kv0od7qztxPn9Tl
         de3TBnMsp7NND5IB0Vm9xxbdMllsMF/HqQ2YaXLS0wzf6iNSCyZ7EwE7iJDboPZKtaCq
         4AMXw0vQyI/Y7qT+9/vJfa1Cf4VWfoSyAdrIz7aseZpJXl3S9TAcgo1mvXihop7v7CQA
         kSZbnvErEaepPD0Xw0r4f/5ayWehyegcBp4NAbpT9jcJMxFdJ8BKmO5x7QcZTrWi0CdK
         eXeJj+nClF0XZDuNsugMqgTe0aVAjetp2IeUfUEbbI5Os91NvNh0jS52j4eZ1n9jFWeM
         mYuw==
X-Gm-Message-State: AOJu0YztsL5+vrtDva1ciKdfzsjOA9dKATd6QFBX8ZDqDw65u+qAZkGH
	XN9hbRs/v1CMG+SpgDx2Mdjkjq2VQNgbDROQOd3vh1XzyYvde5UqqkDW//GmPw==
X-Gm-Gg: ATEYQzy99UM91XgjZrjwL3G87UpWa3rb/1PH81FFohT3f+OSZ5NHxWq5WwqWcjpzRSu
	o3+m/4af5HLmkIimTg3hGwSj1zc3IipO5A0zlSE5sDZNNCTdvmAP3OJ9hC4Gqj2X2TPIoDDpEQU
	YqIu1MpfovTRZop2zblnQjFZxG0pb/kwieH3LDDMDrUW+89krwQlp/mrjs4FWoIzTNyKA0fQy1N
	KrbiJIxAaiaWn8U9EznU03QCJmAzsnpGHeOKucBuf3VdOhcObN6w7hlJDXBCikmMAzckwXRDHGR
	H2sdqaeTUZlKgwquwIHjXggCiLDnBEJBUt5NArA7Ohq3N9dNvz7ApFqjjRs+Wa7cfojBSl5QtVN
	WbRcjd90yitvTzKJX5DkzG7PArhJ5AZm/JWxbCjncjslvcXsqD+1KmbgNRKs9IHm6VgRXI9ZyKD
	vN92sXgsWxgSP21bqoYh3X5JjiRAc=
X-Received: by 2002:a05:693c:2c13:b0:2ba:7875:10c9 with SMTP id 5a478bee46e88-2c109760e2dmr5138457eec.26.1774266028016;
        Mon, 23 Mar 2026 04:40:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm11972459eec.22.2026.03.23.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:27 -0700 (PDT)
Message-Id: <f8f2c613260458e3c86109888ee1c51313095319.1774266019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:17 +0000
Subject: [PATCH v2 4/6] backfill: work with prefix pathspecs
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change allowed specifying revision arguments over the 'git
backfill' command-line. This created the opportunity for restricting the
initial commit set by filtering the revision walk through a pathspec. Other
than filtering the commit set (and thereby the root trees), this did not
restrict the path-walk implementation of 'git backfill' and did not restrict
the blobs that were downloaded to only those matching the pathspec.

Update the path-walk API to accept certain kinds of pathspecs and to
silently ignore anything too complex, for now. We will update this in the
next change to properly restrict to even complex pathspecs.

The current behavior focuses on pathspecs that match paths exactly. This
includes exact filenames, including directory names as prefixes. Pathspecs
containing wildcards or magic are cleared so the path walk downloads all
blobs, as before.

The reason for this restriction is to allow for a faster execution by
pruning the path walk to only trees that could contribute towards one of
those paths as a parent directory.

The test directory 'd/f/' (next to 'd/file*.txt') was prepared in a
previous commit to exercise the subtlety in prefix matching.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 path.c              |  2 +-
 path.h              |  6 ++++++
 t/t5620-backfill.sh | 16 ++++++----------
 4 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 364e4cfa19..0d640e2f24 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "object.h"
 #include "oid-array.h"
+#include "path.h"
 #include "prio-queue.h"
 #include "repository.h"
 #include "revision.h"
@@ -206,6 +207,34 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				 match != MATCHED)
 				continue;
 		}
+		if (ctx->revs->prune_data.nr) {
+			struct pathspec *pd = &ctx->revs->prune_data;
+			bool found = false;
+
+			/* remove '/' for these checks. */
+			path.buf[path.len - 1] = 0;
+
+			for (int i = 0; i < pd->nr; i++) {
+				struct pathspec_item *item = &pd->items[i];
+
+				/*
+				 * Continue if either is a directory prefix
+				 * of the other.
+				 */
+				if (dir_prefix(path.buf, item->match) ||
+				    dir_prefix(item->match, path.buf)) {
+					found = true;
+					break;
+				}
+			}
+
+			/* return '/' after these checks. */
+			path.buf[path.len - 1] = '/';
+
+			/* Skip paths that do not match the prefix. */
+			if (!found)
+				continue;
+		}
 
 		add_path_to_list(ctx, path.buf, type, &entry.oid,
 				 !(o->flags & UNINTERESTING));
@@ -481,6 +510,17 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (info->tags)
 		info->revs->tag_objects = 1;
 
+	if (ctx.revs->prune_data.nr) {
+		/*
+		 * Only exact prefix pathspecs are currently supported.
+		 * Clear any wildcard or magic pathspecs to avoid
+		 * incorrect prefix matching.
+		 */
+		if (ctx.revs->prune_data.has_wildcard ||
+		    ctx.revs->prune_data.magic)
+			clear_pathspec(&ctx.revs->prune_data);
+	}
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
diff --git a/path.c b/path.c
index d726537622..aebb10b2e9 100644
--- a/path.c
+++ b/path.c
@@ -57,7 +57,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
 		strbuf_remove(sb, 0, path - sb->buf);
 }
 
-static int dir_prefix(const char *buf, const char *dir)
+int dir_prefix(const char *buf, const char *dir)
 {
 	int len = strlen(dir);
 	return !strncmp(buf, dir, len) &&
diff --git a/path.h b/path.h
index 0ec95a0b07..829fafd7e9 100644
--- a/path.h
+++ b/path.h
@@ -114,6 +114,12 @@ const char *repo_submodule_path_replace(struct repository *repo,
 					const char *fmt, ...)
 	__attribute__((format (printf, 4, 5)));
 
+/*
+ * Given a directory name 'dir' (not ending with a trailing '/'),
+ * determine if 'buf' is equal to 'dir' or has prefix 'dir'+'/'.
+ */
+int dir_prefix(const char *buf, const char *dir);
+
 void report_linked_checkout_garbage(struct repository *r);
 
 /*
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index db66d8b614..52f6484ca1 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -273,13 +273,11 @@ test_expect_success 'backfill with prefix pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# TODO: The pathspec should limit the downloaded blobs to
-	# only those matching the prefix "d/f", but currently all
-	# blobs are downloaded.
-	git -C backfill-path backfill HEAD -- d/f &&
+	git -C backfill-path backfill HEAD -- d/f 2>err &&
+	test_must_be_empty err &&
 
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 0 missing
+	test_line_count = 40 missing
 '
 
 test_expect_success 'backfill with multiple pathspecs' '
@@ -292,13 +290,11 @@ test_expect_success 'backfill with multiple pathspecs' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# TODO: The pathspecs should limit the downloaded blobs to
-	# only those matching "d/f" or "a", but currently all blobs
-	# are downloaded.
-	git -C backfill-path backfill HEAD -- d/f a &&
+	git -C backfill-path backfill HEAD -- d/f a 2>err &&
+	test_must_be_empty err &&
 
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 0 missing
+	test_line_count = 16 missing
 '
 
 test_expect_success 'backfill with wildcard pathspec' '
-- 
gitgitgadget

