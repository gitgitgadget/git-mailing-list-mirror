Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7D33D4EE
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775937; cv=none; b=MB8G3S6LiMWQQYdyQPdoWdgxzaYezfmGmGOxyi9+eneAAGJb1d2IPeXFZVYIjTvx8YOv+EvL8Rc0tzdSZT6iKKXAatkE2ETIYnaguVBpDJrSMYYWLOuD2NtZlTSKtAXXtZw5syjlc8LoL8cwalJTWvlVDzwTEsqkxs0+ENZwaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775937; c=relaxed/simple;
	bh=Qm0eGHAVSdyUrW7F0ZGK9wLfsoqLoA/TplGhG4121K4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=He5lVaT2vMF1/kV06XXhPqMsJxtYGiU4YZ0UhvbC30sah8LPd1pLROaVfqSsZ8CMUO7aJ+v3VIZaymO2+uyiP4T2mFXMuM3qDi3VFJDmCvTs1DPF2F+ZwxX/26rQfrl0n+bSNNAVdj4ut56NJNMl70Xb6GQIqkE23j6PGVtW4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOBOed6y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOBOed6y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b941cd869cso52436425ad.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778775935; x=1779380735; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKnZaO9bMaseUMEJwzpr+i4s3fSXM02NxS/c6DjmBog=;
        b=TOBOed6yOoX6+tjQ/ibfp5SlVEpD4ELcpWjszoAzSCj8CL+QhqwBQn0HCPnGwW4vuf
         +WH2FGWREpIsWazbtnJVyBdU5vbgVLIys5AsqtrgjsOTHRALFPzptN6w2rWCIEqys7KO
         s2dXT0rkTGbtrJtrVIPNGZz7MU+MrQpflMeNzobuBRAfnymajtlAFFWOuSZ1UqHr5VEt
         7GuW/KhVsWvE0pkGQfARd1iRqN+PVqKWOEw64oLnC1Yp1tj8h6rgFRc6Sgh7PLdnV9Ch
         sYKvR+bJsVoUoAZQ9ohrcthMtELr5FSaMXj7o1wIqLhTeGt3s5kf5h4mAy/dFkotyMlk
         zc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775935; x=1779380735;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKnZaO9bMaseUMEJwzpr+i4s3fSXM02NxS/c6DjmBog=;
        b=MO4JK2yCOtZtxXXHAJhxgyxMFYspTw5cJIq3gWRTTYO83DjWvLyqMXMwvHcdZmrFot
         FOGjID79YVOjHG1Ntuv6xxTvKOgTk8+4O+Dt6hF3pQaHD96oEBocrfm312wFCUTUgFvK
         oX0+4SlU0xgg1ixrNrO2D2NtG7jYgneiTKXCAK/oZtPkEvWm2uKmSbG8oou2Wsrdj6Wh
         6tGGYewRSgiqt2a1v+fvpvKVYsMB3JEycFnWt6IOmfcw9QkI1bCMfW7wfbSaOT5uM2Y+
         xlWssqpJzsrl+3tPBxURusamgeumdUxGvsHbnNTe0GeFVfQSekphrBq9U7vGb4A3rBg5
         Owmg==
X-Gm-Message-State: AOJu0Yw/lRbI6OSmh0hNaOpEJSjOx0zQHilAfJiuVEAdklyCMBemLwAK
	qOAvX0fX+vXQzA/tCCHI8YI3xwkBCo4g32KQg3AOOQdfN5pujWB5vmLurO83GEkw
X-Gm-Gg: Acq92OFUBw8TFchRjIYXQinvNXgPgfohotBrSaMP0Qkx0dsH9uY7Rk6oOjmzLt1MxMC
	42/tin0uq52PYazEc5u7AXzGYUEr9jEuY2OpghOqb7Nl4BtxNAcVvin5NUhZP5c6XtFpax2QlIm
	HqfqGeDr9aUUokC4lC4HzlJWgal7pHRTCV1Vs4GGXE4mAcAIvKgxDJU1DA8rpouKeQt4tmMU3nE
	CqfHG+uG9eDWHVme/vmayJB6RF04laUWvO0xWhamajF60K8NXGh5y8UnU99Be+5n+4q6nYRIbwO
	C011lxIe2TOJJwQUVhBmZ95QSWddwgI6sbzaCZxSQQgDDeIZYSXlvnVwX0LPd3irQN0DpbquiMS
	BPgTxunE9XaMM/aYDS7ah9/kZ8O062KAJphqwSiHTwdin7H/7c9JzpxKTF3To4p0eYBTxYYy4wT
	deDyp9EMYM26T1GvISzAdvJymf
X-Received: by 2002:a17:903:fae:b0:2bd:a5f:1d04 with SMTP id d9443c01a7336-2bd7e8aad34mr2562915ad.9.1778775935242;
        Thu, 14 May 2026 09:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235e04sm30762605ad.80.2026.05.14.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:25:34 -0700 (PDT)
Message-Id: <75d4ca7cff07a14b2f0beef4524623e541e140a8.1778775928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
	<pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 16:25:28 +0000
Subject: [PATCH v3 4/4] grep: prefetch necessary blobs
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In partial clones, `git grep` fetches necessary blobs on-demand one
at a time, which can be very slow.  In partial clones, add an extra
preliminary walk over the tree similar to grep_tree() which collects
the blobs of interest, and then prefetches them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/grep.c  | 143 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t7810-grep.sh |  58 ++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index e33285e5e6..85656d8d3f 100644
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
 
@@ -692,6 +695,144 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
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
+			if (!odb_has_object(repo->objects, &entry.oid, 0))
+				oidset_insert(blob_oids, &entry.oid);
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
@@ -732,6 +873,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	int hit = 0;
 	const unsigned int nr = list->nr;
 
+	prefetch_grep_blobs(opt, pathspec, list);
+
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 64ac4f04ee..3d08fd2a0c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1929,4 +1929,62 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep of revision in partial clone batches prefetch and honors pathspec' '
+	test_when_finished "rm -rf grep-partial-src grep-partial" &&
+
+	git init grep-partial-src &&
+	(
+		cd grep-partial-src &&
+		git config uploadpack.allowfilter 1 &&
+		git config uploadpack.allowanysha1inwant 1 &&
+		mkdir a b &&
+		echo "needle in haystack" >a/matches.txt &&
+		echo "nothing to see here" >a/nomatch.txt &&
+		echo "needle again" >b/matches.md &&
+		git add . &&
+		git commit -m "initial"
+	) &&
+
+	git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/grep-partial-src" grep-partial &&
+
+	# All three blobs are missing immediately after a blobless clone.
+	git -C grep-partial rev-list --quiet --objects \
+		--missing=print HEAD >missing &&
+	test_line_count = 3 missing &&
+
+	# A pathspec-limited grep should prefetch only the two blobs
+	# in a/.  It should fetch both blobs in one batched request.
+	GIT_TRACE2_EVENT="$(pwd)/grep-trace-pathspec" \
+		git -C grep-partial grep -c "needle" HEAD -- "a/*.txt" >result &&
+
+	# Only a/matches.txt contains "needle" among the matched paths.
+	test_line_count = 1 result &&
+
+	# Exactly the two a/*.txt blobs should have been requested, and
+	# the server packed those two objects in the response.
+	test_trace2_data promisor fetch_count 2 <grep-trace-pathspec &&
+	test_trace2_data pack-objects written 2 <grep-trace-pathspec &&
+
+	# b/matches.md should still be missing locally.
+	git -C grep-partial rev-list --quiet --objects \
+		--missing=print HEAD >missing &&
+	test_line_count = 1 missing &&
+
+	# A second grep without a pathspec must recurse into both
+	# subdirectories, but should request only the still-missing blob
+	# from the promisor.
+	GIT_TRACE2_EVENT="$(pwd)/grep-trace-all" \
+		git -C grep-partial grep -c "needle" HEAD >result &&
+
+	test_line_count = 2 result &&
+	test_trace2_data promisor fetch_count 1 <grep-trace-all &&
+	test_trace2_data pack-objects written 1 <grep-trace-all &&
+
+	# Everything is local now.
+	git -C grep-partial rev-list --quiet --objects \
+		--missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
 test_done
-- 
gitgitgadget
