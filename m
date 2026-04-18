Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6F15CD7E
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472359; cv=none; b=hQDkIVvAtkRi9GifpMfSyLx4DvVQnQCKQjITeZ0roIXMEdN2p7SB8F7gKC4d68Qq2vYGXRsuAwXBY+YNbmaarwKq7FteBGfBRo5flkzc/0vIBH3JGGpjnv/u92ir5DGusYfPNheU1GfVK3ywwhmwie4CXJrPZj0jZeQhPWdOAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472359; c=relaxed/simple;
	bh=vntCNbq8EUtTowhvvk70CAbFjulNPzurtFrHnKQGaWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sHS1quAstVN4rEFuUuqDJRnjd1QyX1aCHVj2sDT5hwW7oES6mSFHEurOVKrmBLo/rKu4fGTVe5JnRFttvJK84wtfT9OlbGPP44CMlL11nUyH7zYJ1m4wQSEytw/60YOCfzRVTV/4e1Ozto1/2YegCIjUMHPvYHppVHXdutfWL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7+RO2T8; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7+RO2T8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d9436f2adso14689161cf.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776472356; x=1777077156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC7p8GN4H5RHToX0Dq39b0zlT9e2pSnMJfZMuw6tVBU=;
        b=E7+RO2T8oHWqKCYW+jP2LQpQu6uDDxFi0levvzFzYsSc1s7SYRZmbLdTBzmv85BUVO
         9Iri6nJGAYA0B8PS5aai8JX+2JOZaTzb/qnUdEoXPJkkHhmMMacQ5jCeenInCjbSwDvz
         n9FVbFAZyTDQoP8JYEoBOGeJixKVESduasIxLA4X1xZBw9+7WDfG7DLgfghfdrLIE5yg
         TxKDOIet6N4zyIG+p36gojIp+JRTyJa7VA3G2E0lig7snfRmgxXfwtUC9SEBAYGGfd81
         RnUlAw0wyAAbmeH/XXrQTGXZgDIW3PTaN85ZJdCdWchZ/futWXL6DOOs0zGQqjG+J7yb
         Su0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472356; x=1777077156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yC7p8GN4H5RHToX0Dq39b0zlT9e2pSnMJfZMuw6tVBU=;
        b=Jsvl/8Ml1eiSzVWJyCMQ/u8d0nHIB6jKaOvOhn+qrbMAMvvWcq+D7Tjz9nrM4l/MvR
         qhELweLVAJaG94nM2+vLlGuFv6iwLMlUr/+iiP7IQug9wayS5edTlrBZ+Gz+44/pExea
         OkeNJ1SVNmDqq4SWj7UkR2x/kTjjF7iWCRizavG3rzuA9fIV74yBzsrDC4Lks28a/FXG
         nesqgOuGQ/jsaV1F0OMwzk9n0gnhOg8xwfm0Ucf5rq5HrVXwTyzyBChMn3TQR3MFjLvb
         lf6Za1+KmK7VES1vVuGBBygqvQTxqG+2PaE0e35cK3EURUTmSZddoqgIf+P7UE2QjNCN
         /yHg==
X-Gm-Message-State: AOJu0YztFoUNYipYFmyfyjrElGsaUCy8Sg6EcrMKEtRft2PAkrR1qVnC
	srrot4gwwg5OueU8fdoeRQCO786W3qCCDuIkNgF6J89c5Tc0CVZgddYFdMlbyQ==
X-Gm-Gg: AeBDieugVLOqw+MfU3XYMsrgtpVbDM3Z6W9NkM553n11BC5WlqPTX+aIq33kJnLu8JZ
	35VUpWqMlhnsKEJuTTT3/V2Y+NGylR/Dg+QPSlBrJ0CZjoiI1KWTym/Qd5Dqfe0dPyhSAB5loDN
	LXwL2gh851wdNKCNA1xeMIR5UZOrjifCGgSIwIylRdhYS+4/3JIEymarlRhuWolE4Mn5Xjc7TSF
	ER4GZYqoCZjgdueBbv4YnUdEUOiaJtoKz9OaMkIsliLEor2B/QdiuNY5eTka2dtAUl5wywDOBut
	AHBLcWS8cabFTdJg0YsjlvJou+0memD9Cz7HkvlZCFSfGukuwq1f7dZHf7npQKu7vhzj6Y0L1+x
	5fh8x6UOs5EMR9bE9Ux1NMuq2td6PGk5curVBOgxvQbRfsw+AOSJTk8G7O7dx1wOB5F4/XYnZ9/
	JibMP3FBCBWflefXMNIfJwKmLgTXtCQIPZXwW4gFQ=
X-Received: by 2002:a05:622a:2ca:b0:50b:506d:736b with SMTP id d75a77b69052e-50e36c4e283mr74736001cf.47.1776472355820;
        Fri, 17 Apr 2026 17:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm26628561cf.10.2026.04.17.17.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:32:35 -0700 (PDT)
Message-Id: <8fbfe69bc4d0c6166967986f24861ffa393ed7cf.1776472347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
	<pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Apr 2026 00:32:27 +0000
Subject: [PATCH v2 3/3] grep: prefetch necessary blobs
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In partial clones, `git grep` fetches necessary blobs on-demand one
at a time, which can be very slow.  In partial clones, add an extra
preliminary walk over the tree similar to grep_tree() which collects
the blobs of interest, and then prefetches them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/grep.c  | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t7810-grep.sh |  35 ++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index e33285e5e6..d559c48d94 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -28,9 +28,12 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "oid-array.h"
+#include "oidset.h"
 #include "packfile.h"
 #include "pager.h"
 #include "path.h"
+#include "promisor-remote.h"
 #include "read-cache-ll.h"
 #include "write-or-die.h"
 
@@ -692,6 +695,143 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	return hit;
 }
 
+static void collect_blob_oids_for_tree(struct repository *repo,
+				       const struct pathspec *pathspec,
+				       struct tree_desc *tree,
+				       struct strbuf *base,
+				       int tn_len,
+				       struct oidset *blob_oids)
+{
+	struct name_entry entry;
+	int old_baselen = base->len;
+	struct strbuf name = STRBUF_INIT;
+	enum interesting match = entry_not_interesting;
+
+	while (tree_entry(tree, &entry)) {
+		if (match != all_entries_interesting) {
+			strbuf_addstr(&name, base->buf + tn_len);
+			match = tree_entry_interesting(repo->index,
+						       &entry, &name,
+						       pathspec);
+			strbuf_reset(&name);
+
+			if (match == all_entries_not_interesting)
+				break;
+			if (match == entry_not_interesting)
+				continue;
+		}
+
+		strbuf_add(base, entry.path, tree_entry_len(&entry));
+
+		if (S_ISREG(entry.mode)) {
+			oidset_insert(blob_oids, &entry.oid);
+		} else if (S_ISDIR(entry.mode)) {
+			enum object_type type;
+			struct tree_desc sub_tree;
+			void *data;
+			unsigned long size;
+
+			data = odb_read_object(repo->objects, &entry.oid,
+					       &type, &size);
+			if (!data)
+				die(_("unable to read tree (%s)"),
+				    oid_to_hex(&entry.oid));
+
+			strbuf_addch(base, '/');
+			init_tree_desc(&sub_tree, &entry.oid, data, size);
+			collect_blob_oids_for_tree(repo, pathspec, &sub_tree,
+						   base, tn_len, blob_oids);
+			free(data);
+		}
+		/*
+		 * ...no else clause for S_ISGITLINK: submodules have their
+		 * own promisor configuration and would need separate fetches
+		 * anyway.
+		 */
+
+		strbuf_setlen(base, old_baselen);
+	}
+
+	strbuf_release(&name);
+}
+
+static void collect_blob_oids_for_treeish(struct grep_opt *opt,
+					  const struct pathspec *pathspec,
+					  const struct object_id *tree_ish_oid,
+					  const char *name,
+					  struct oidset *blob_oids)
+{
+	struct tree_desc tree;
+	void *data;
+	unsigned long size;
+	struct strbuf base = STRBUF_INIT;
+	int len;
+
+	data = odb_read_object_peeled(opt->repo->objects, tree_ish_oid,
+				      OBJ_TREE, &size, NULL);
+
+	if (!data)
+		return;
+
+	len = name ? strlen(name) : 0;
+	if (len) {
+		strbuf_add(&base, name, len);
+		strbuf_addch(&base, ':');
+	}
+	init_tree_desc(&tree, tree_ish_oid, data, size);
+
+	collect_blob_oids_for_tree(opt->repo, pathspec, &tree,
+				   &base, base.len, blob_oids);
+
+	strbuf_release(&base);
+	free(data);
+}
+
+static void prefetch_grep_blobs(struct grep_opt *opt,
+				const struct pathspec *pathspec,
+				const struct object_array *list)
+{
+	struct oidset blob_oids = OIDSET_INIT;
+
+	/* Exit if we're not in a partial clone */
+	if (!repo_has_promisor_remote(opt->repo))
+		return;
+
+	/* For each tree, gather the blobs in it */
+	for (int i = 0; i < list->nr; i++) {
+		struct object *real_obj;
+
+		obj_read_lock();
+		real_obj = deref_tag(opt->repo, list->objects[i].item,
+				     NULL, 0);
+		obj_read_unlock();
+
+		if (real_obj &&
+		    (real_obj->type == OBJ_COMMIT ||
+		     real_obj->type == OBJ_TREE))
+			collect_blob_oids_for_treeish(opt, pathspec,
+						      &real_obj->oid,
+						      list->objects[i].name,
+						      &blob_oids);
+	}
+
+	/* Prefetch the blobs we found */
+	if (oidset_size(&blob_oids)) {
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+		struct oidset_iter iter;
+		const struct object_id *oid;
+
+		oidset_iter_init(&blob_oids, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			oid_array_append(&to_fetch, oid);
+
+		promisor_remote_get_direct(opt->repo, to_fetch.oid, to_fetch.nr);
+
+		oid_array_clear(&to_fetch);
+	}
+	oidset_clear(&blob_oids);
+}
+
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name, const char *path)
 {
@@ -732,6 +872,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	int hit = 0;
 	const unsigned int nr = list->nr;
 
+	prefetch_grep_blobs(opt, pathspec, list);
+
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 64ac4f04ee..1f484502fe 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1929,4 +1929,39 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep of revision in partial clone does bulk prefetch' '
+	test_when_finished "rm -rf grep-partial-src grep-partial" &&
+
+	git init grep-partial-src &&
+	(
+		cd grep-partial-src &&
+		git config uploadpack.allowfilter 1 &&
+		git config uploadpack.allowanysha1inwant 1 &&
+		echo "needle in haystack" >searchme &&
+		echo "no match here" >other &&
+		mkdir subdir &&
+		echo "needle again" >subdir/deep &&
+		git add . &&
+		git commit -m "initial"
+	) &&
+
+	git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/grep-partial-src" grep-partial &&
+
+	# All blobs should be missing after a blobless clone.
+	git -C grep-partial rev-list --quiet --objects \
+		--missing=print HEAD >missing &&
+	test_line_count = 3 missing &&
+
+	# grep HEAD should batch-prefetch all blobs in one request.
+	GIT_TRACE2_EVENT="$(pwd)/grep-trace" \
+		git -C grep-partial grep -c "needle" HEAD >result &&
+
+	# Should find matches in two files.
+	test_line_count = 2 result &&
+
+	# Should have prefetched all 3 objects at once
+	test_trace2_data promisor fetch_count 3 <grep-trace
+'
+
 test_done
-- 
gitgitgadget
