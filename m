Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BB35E95E
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379704; cv=none; b=PXo8iXPIR7KnRvxL+09dpaMjRyGzWUil81s12F0FeGyZEPgSLsRjOikUF6d112MQnzQI5ftLyByjTFwK1kDYiCFKolvWD6laJEEVuJVtOKnraek1F0BeOT9NxVQ0ZU3Ah7xX0wg8i75zhofdSwPjpLK04DZwaAWBvVwWTAH7bJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379704; c=relaxed/simple;
	bh=vntCNbq8EUtTowhvvk70CAbFjulNPzurtFrHnKQGaWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BYZibFDtbmWKhWjCpIxattmmCHoBxIJb0XnNl8wfACSSnR750IPTafU6Mbm4eCw7X+Xqvt+iSnITG868jOOlYKku0NuF/ixEdcA7Us+vHQ7A/eZ/oqwYIeJFbUh+ySEiqwHemFvIQMl6baEGLRVvtSW2L+VH0gSIL6rumJo0lYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJdjuAkD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJdjuAkD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506bcb23a78so601221cf.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776379701; x=1776984501; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC7p8GN4H5RHToX0Dq39b0zlT9e2pSnMJfZMuw6tVBU=;
        b=lJdjuAkDG4nowLuqMpxMbl0G7GFakBw+bp3nT14Ww8+R/DYefBWSaNScybBxn0Xgyh
         ACRXPgVu8QYOJ9qDqdQeyznQODvCPZLHYc1XVR1M7eA47kLTXHKYWsypVGzo6hTgjjAk
         45jaNoupyN4G30OxkMhTmtIYcqn9p1fKIzH/aavECWJKJbpK7uSoazuqud7fddqBUkX4
         JYPjLQzV2gcSa9kIt3f+/CgfdIIbxDLyafbSC9PrKeXc84cXqt6ls4xQTWVj9JwAbFQE
         UasTS6FA5FK9GtVsPS9ANyFgANAn3Z74KFfujEI7TqC7Ha4Jv1H+iL2NXgFiKu82zesb
         GO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776379701; x=1776984501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yC7p8GN4H5RHToX0Dq39b0zlT9e2pSnMJfZMuw6tVBU=;
        b=qUxPfBUxtbzyFgNbsswqKlLFGf5ckC8KLJeJcQUV1gaHTS9OZG3S4nqazUgSDoVWPa
         WEBHaMSR8JHiM4cDLrR0srhf3PF/11mRgMyAft/cImAiXy+KV3f/Sw+V1Kl8AHA/vCl/
         S9ug8BRkeEP4Cbq95/8aY847oxRH4JnZNQFQ3dQTdBxfhKaSghCRKxo0V0Pkj35ASL5Q
         FkzBuRDW+PdKcoreRw0BT/QX3Xu7EQkD02nXYwJL4wPtFJqtXDiK5OA/KV9/1SVPlpO5
         W6LJIr3HYzWirzaJ4MLhJhwTHz2gMR0fHeH+nxpkXhCPt5BruV7tJsaXuA2DOgIJqKw2
         uYzw==
X-Gm-Message-State: AOJu0YzN+5u5bo5LQays7wF0JeiSEyVLwwNshJmgQfFpjsYmWr8SneeB
	ltAfoSHSFwScak3jjOCUJX0R9zr30kyie4IR0HAizqTTyLLrixnX1Dh71e8k87xq
X-Gm-Gg: AeBDietzW0lRvG3LWLYCFa5WyYtF8gI/0/XCflNt+t8EUa4912Iv0aDp/yKSdKxp/U2
	/ShKY8Kzob9b3SXmm/O2kHARBqhujU68MpNTTt1DsRd2EdUtXNB4KvJPOPSJwnpD1K6rhokfkBC
	day2cL3n5yO57xkDMviKxrIldzXNG2870c5lDm7xlbCG28NIZz+EYJ89nV6ySqJq0nge8HYlLNn
	YnwSCEB0s7Nznjhk4JaG5Fo9Pd1uDTlft8WSKcoEbc9dPcIXSKHn6kY2adHxbAGLk5Lw5z4fb2a
	9maY+ylFZDbe6XuutVprB1Z/JStdc8MGRT0b0y8DN2yNGxXHJ6ofSrWeuvfVp6Q4/YU68mGcw8s
	IKkX6CWnZaCzuBEU7ab5/WOxEMy72zGTuEU3Zq2NKYHSD7j3vJ90jcNeaB5ws62xqh5VVR/Xy3K
	ZYHeVcj7I9jl0fsGo65vAPAj3W6X610pMbL8L6Ta7qXF/AeW79
X-Received: by 2002:ac8:598b:0:b0:50d:a088:b9cb with SMTP id d75a77b69052e-50e36f0338fmr4585571cf.57.1776379701039;
        Thu, 16 Apr 2026 15:48:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afecf5csm49067031cf.28.2026.04.16.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:48:19 -0700 (PDT)
Message-Id: <6dbfc7608b7707decf9c036fade5d0fe25459aa8.1776379694.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 22:48:14 +0000
Subject: [PATCH 3/3] grep: prefetch necessary blobs
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
