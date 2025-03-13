Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D52D052
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834008; cv=none; b=nvofpdLFOK12dZCRtGgxDVtBxypQKurjTCj+68JRSRpfj0wJGBohWodO+DsokOUoHusa11Zfe+9oj4zTEap+inYBwezcpmHBc/czYD0fjsbftw6CLrInonerlZBzunaB10s0VOl6zB+iY+f0fPVPL94yHW72+T4DzsRV1tQpuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834008; c=relaxed/simple;
	bh=KixAVzaZeeO9Jpi+z7TpEaQV+Y/78zMbUAh4hJpSfHg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kdZF+v4OWmxiF+0kk3uHxzQ6dcO/xHZHYO9B5rHcN+AZHO4MPbbDwdLc/NBXjWVn1xJseE239poSn7utQGFFABczTyV89Gs8KrC9YeVCWbJYhQ5lc+EEbIxlmvAgzrETciIWfoQKpNTBtIxWF1zsT6Me6ClBj50RgUDfny7Lmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duAb/fze; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duAb/fze"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso107391266b.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834004; x=1742438804; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCmJ/cyxn2mwJiXCaroaRblkEK5hYNzg+tUtuJeFjZs=;
        b=duAb/fzeWoljaQNl363y1ijlBuu4qTupaQbcRTuUei6Q80J+havkP/lETkf0lwnomy
         s+dqzjY7gvJljGi0RDxaoSx7J1PEmfcffMjENAbVK0IPFHJHgiAVckXpOS/qOQaHhlef
         rAE4+XrjWzI/IPsL74nTYtPQRJgQhUJbj2Ylac8oHnngAOY15ou2q8SijjHGU3NcD/DA
         91COSZ6Nks3gbGCKP4curHYVerlGllNml7/Qn+HP7/Mc6RnMIbxxGQHySd//U4Qw8Ppi
         ojlvu9nh7LEVDww2COwQsa8kEXnKqtiA+laTAL/woABYRLhuJAHyT13xdVSd62qwbaWz
         d5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834004; x=1742438804;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCmJ/cyxn2mwJiXCaroaRblkEK5hYNzg+tUtuJeFjZs=;
        b=fMi2acgJsMZO30HiYvx/AYo1s7WhPszx+7x/jyWBa2IVKV2vH+nlZO3Ypn6V8ULXZT
         faw75BK4tPZ2rsdp+qfMmdvwB/umnuMOf0wZ1B+92mUi9IPirr4lbjyYbuY5Ma8DhT/p
         ZZLHsPeuJysMYwFnqWYQb8MJv3mYk3KMW5kfwkgNk3BasfQPWkJc21ascmu9jYHcNjcR
         Vrd+kpDr5xqFWpp7qMBZmYj27RdFa4rfXeZU2PLHJ31X4wBccBZ7knne1rlRz207wsLJ
         Laz5cK/cPwGib2J/TrHrZrE7A88AxOfpiVXAcaRTsw8tPTH0nJI7uc50NARKyEatKX/S
         G3Vw==
X-Gm-Message-State: AOJu0YyZCBiJM7FXJCFioQ7EedochMN07DfxcLQ7w8WY61q/eCV7LP8g
	cRPMGNy6xCMZbk+8bjSxJDAbJUlQTna8nY7neoCrfrkKjAJTxHVMa/la/w==
X-Gm-Gg: ASbGncuSBOaR+EFr+Dc/oEqFiXSKduEloPtxcARpuKad4kH6IWabFrG6Zc4uEz/+wG8
	NIEF4Ty7pZkfwzLbGdXzwEfSf4Bw1TV2E0HXSo1/eNTJlPFtpE70//JykOfw014KGwUYIaukC42
	hLF19UU3uRPrxcAeHl7Cy048YBBkad5bv/8xlSjdow+EevHgx9abhok9Ov+obhHVSmoa6eHAbLt
	2OWddU6Za8YYd1Wri9Hy5W1/EjBssPsOiPyT/uvHG5rckMjv8kxPKTEvqEpVhxEPLzBE4oQTTEW
	UeCDs8vcPPS7f4TKMrJMwGPt+qjikkxdOATisuTjHccWTA==
X-Google-Smtp-Source: AGHT+IEH0cpw08WA8dvPfXZKLWk9z1B0LV8cgi7HFGDAC87a5VVDxk/zgJgCBgBr6O+9RqUtRRL65A==
X-Received: by 2002:a17:907:74a:b0:ac1:da09:5d32 with SMTP id a640c23a62f3a-ac25274a074mr2832123266b.6.1741834003843;
        Wed, 12 Mar 2025 19:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf133sm21362366b.106.2025.03.12.19.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:43 -0700 (PDT)
Message-Id: <c2f2e3e0cd646eae2801bf8fb079266f43219921.1741834001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
	<pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:36 +0000
Subject: [PATCH v2 1/6] merge-ort: add new merge_ort_generic() function
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

merge-recursive.[ch] have three entry points:
  * merge_trees()
  * merge_recursive()
  * merge_recursive_generic()
merge-ort*.[ch] only has equivalents for the first two.  Add an
equivalent for the final entry point, so we can switch callers to
use it and remove merge-recursive.[ch].

While porting it over, finally fix the issue with the label for the
ancestor (used when merge.conflictStyle=diff3 as a conflict label).
merge-recursive.c has traditionally not allowed callers to set that
label, but I have found that problematic for years.

(Side note: This function was initially part of the merge-ort rewrite,
but reviewers questioned the ancestor label funnyness which I was
never really happy with anyway.  It resulted in me jettisoning it and
hoping at the time that I would eventually be able to force the existing
callers to use some other API.  That worked with `git stash`, as per
874cf2a60444 (stash: apply stash using 'merge_ort_nonrecursive()',
2022-05-10), but this API is the most reasonable one for `git am` and
`git merge-recursive`, if we can just allow them some freedom over the
ancestor label.)

The merge_recursive_generic() function did not know whether it was being
invoked by `git stash`, `git merge-recursive`, or `git am`, and the
choice of meaningful ancestor label, when there is a unique ancestor,
varies for these different callers:

  * git am: ancestor is a constructed "fake ancestor" that user knows
            nothing about and has no access to.  (And is different than
            the normal thing we mean by a "virtual merge base" which is
            the merging of merge bases.)
  * git merge-recursive: ancestor might be a tree, but at least it
                         was one specified by the user (if they invoked
                         merge-recursive directly)
  * git stash: ancestor was the commit serving as the stash base

Thus, using a label like "constructed merge base" (as
merge_recursive_generic() does) presupposes that `git am` is the only
caller; it is incorrect for other callers.  This label has thrown me off
more than once.  Allow the caller to override when there is a unique
merge base.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort-wrappers.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 merge-ort-wrappers.h | 12 +++++++++
 merge-ort.c          | 17 ++++++++----
 merge-ort.h          |  5 ++++
 4 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index d6f61359965..62834c30e9e 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -1,9 +1,13 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
+#include "hex.h"
+#include "lockfile.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "read-cache-ll.h"
+#include "repository.h"
+#include "tag.h"
 #include "tree.h"
 
 #include "commit.h"
@@ -64,3 +68,63 @@ int merge_ort_recursive(struct merge_options *opt,
 
 	return tmp.clean;
 }
+
+static struct commit *get_ref(struct repository *repo,
+			      const struct object_id *oid,
+			      const char *name)
+{
+	struct object *object;
+
+	object = deref_tag(repo, parse_object(repo, oid),
+			   name, strlen(name));
+	if (!object)
+		return NULL;
+	if (object->type == OBJ_TREE)
+		return make_virtual_commit(repo, (struct tree*)object, name);
+	if (object->type != OBJ_COMMIT)
+		return NULL;
+	if (repo_parse_commit(repo, (struct commit *)object))
+		return NULL;
+	return (struct commit *)object;
+}
+
+int merge_ort_generic(struct merge_options *opt,
+		      const struct object_id *head,
+		      const struct object_id *merge,
+		      int num_merge_bases,
+		      const struct object_id *merge_bases,
+		      struct commit **result)
+{
+	int clean;
+	struct lock_file lock = LOCK_INIT;
+	struct commit *head_commit = get_ref(opt->repo, head, opt->branch1);
+	struct commit *next_commit = get_ref(opt->repo, merge, opt->branch2);
+	struct commit_list *ca = NULL;
+
+	if (merge_bases) {
+		int i;
+		for (i = 0; i < num_merge_bases; ++i) {
+			struct commit *base;
+			if (!(base = get_ref(opt->repo, &merge_bases[i],
+					     oid_to_hex(&merge_bases[i]))))
+				return error(_("Could not parse object '%s'"),
+					     oid_to_hex(&merge_bases[i]));
+			commit_list_insert(base, &ca);
+		}
+	}
+
+	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
+	clean = merge_ort_recursive(opt, head_commit, next_commit, ca,
+				    result);
+	free_commit_list(ca);
+	if (clean < 0) {
+		rollback_lock_file(&lock);
+		return clean;
+	}
+
+	if (write_locked_index(opt->repo->index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		return error(_("Unable to write index."));
+
+	return clean ? 0 : 1;
+}
diff --git a/merge-ort-wrappers.h b/merge-ort-wrappers.h
index 90af1f69c55..aeffa1c87b4 100644
--- a/merge-ort-wrappers.h
+++ b/merge-ort-wrappers.h
@@ -22,4 +22,16 @@ int merge_ort_recursive(struct merge_options *opt,
 			const struct commit_list *ancestors,
 			struct commit **result);
 
+/*
+ * rename-detecting three-way merge.  num_merge_bases must be at least 1.
+ * Recursive ancestor consolidation will be performed if num_merge_bases > 1.
+ * Wrapper mimicking the old merge_recursive_generic() function.
+ */
+int merge_ort_generic(struct merge_options *opt,
+		      const struct object_id *head,
+		      const struct object_id *merge,
+		      int num_merge_bases,
+		      const struct object_id *merge_bases,
+		      struct commit **result);
+
 #endif
diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..b4ff24403a1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4878,9 +4878,9 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-static struct commit *make_virtual_commit(struct repository *repo,
-					  struct tree *tree,
-					  const char *comment)
+struct commit *make_virtual_commit(struct repository *repo,
+				   struct tree *tree,
+				   const char *comment)
 {
 	struct commit *commit = alloc_commit_node(repo);
 
@@ -5186,6 +5186,8 @@ static void merge_ort_internal(struct merge_options *opt,
 		ancestor_name = "empty tree";
 	} else if (merge_bases) {
 		ancestor_name = "merged common ancestors";
+	} else if (opt->ancestor) {
+		ancestor_name = opt->ancestor;
 	} else {
 		strbuf_add_unique_abbrev(&merge_base_abbrev,
 					 &merged_merge_bases->object.oid,
@@ -5275,8 +5277,13 @@ void merge_incore_recursive(struct merge_options *opt,
 {
 	trace2_region_enter("merge", "incore_recursive", opt->repo);
 
-	/* We set the ancestor label based on the merge_bases */
-	assert(opt->ancestor == NULL);
+	/*
+	 * We set the ancestor label based on the merge_bases...but we
+	 * allow one exception through so that builtin/am can override
+	 * with its constructed fake ancestor.
+	 */
+	assert(opt->ancestor == NULL ||
+	       (merge_bases && !merge_bases->next));
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	merge_start(opt, result);
diff --git a/merge-ort.h b/merge-ort.h
index 82f2b3222d2..b63bc5424e7 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -44,6 +44,11 @@ struct merge_result {
 	unsigned _properly_initialized;
 };
 
+/* Mostly internal function also used by merge-ort-wrappers.c */
+struct commit *make_virtual_commit(struct repository *repo,
+				   struct tree *tree,
+				   const char *comment);
+
 /*
  * rename-detecting three-way merge with recursive ancestor consolidation.
  * working tree and index are untouched.
-- 
gitgitgadget

