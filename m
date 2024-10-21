Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875101EB9F2
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517680; cv=none; b=ONAUtsau071f42WUyovSmBGN27WzEKbfjL9AnDgUlNB/Bvvusfn0E0mY/6y80vTXSGhhWOqMSp492MqCYlXwAGF0YdACwVKDGnO8+mL2PHnkJllqA6AniHiN48Rljn2Jv0qz++hRBN/SXh3sOrjuZ83nOAjYG9ne6nvtmMQ+d/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517680; c=relaxed/simple;
	bh=ZE2KSJw49THT5RdcbGkKV5fEEA4fm87U9afV3dsW+G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y48/ITIW7l2SU+G2jnOGeflrnLNg6mKDUH2TPu2NHy35FEUj+jbKYLPUZ0mDG0UG6evCXx8IB9zzcHyda2lkt0twrblNzjZ5HoHPSxib9vPRLNHaMdkhpYiHr1V9PjZizIh7uwkhVY55ejSAIbia3KQZMKQcUbdjhFrQzx4hADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcn3vn/W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcn3vn/W"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb89a4e4cso30535395ad.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517677; x=1730122477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE3kkVNGtxIiVPEnCVFwFowPumHB1qlzjMLlu4ndFCI=;
        b=fcn3vn/WDcmUZ3BQMhG3pNQ0v5Q2Z1R2UfWEVjrOsE4QrkiOa472ZIoBP9w5HfPh2D
         kNKw1yTWFACKu7Y1HxJuogvQn7NaQgzVGonFSpLG6oWPVX0PLGcXqFppxEUO1OECKwpc
         Ijy+YbCB1Zqn2mi9jX5XPZh1B5/QLNlMJJVMf8QsUyxJYvVD3Z0p9on7Q9/raC23Gjvb
         hGxf8bB8kKCV1uA6YZNVr3rKp74Qjwhkzd0g2KpaUywq4EYogy8/Vl6ftnNQJmoQRe6b
         RFoVyfjPmlxKqxt/pAsg3RXy7DQo40HVkuwqq7LxnTH1TfRRWmCYL2izaxNImdP+jQE/
         rSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517677; x=1730122477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE3kkVNGtxIiVPEnCVFwFowPumHB1qlzjMLlu4ndFCI=;
        b=U+SJw3m09v5T7v+ztI6Wgw2qRqSDMyE4OtwE89ReaN+BW6iigNYYfF4LNSc5fJdXj/
         lyE53fNkkPTQb8dmbJh+J5wlvB2dZTiuSV6rAcwngGRFrAmVdYbKP2cA1BlDvj4etAGR
         1YwnBZ0oFlh07cbx59aps2AoqRkYfgK4zN29O/BOiHlXte6hcjnIj1NxGz5kqrlZTHVI
         ss9TMi2i44eDWmbNwdkXb8CtMFtbNsPikv2SHj9kOgN+RcswxMAAbnsQDTVQKa6Z5PtF
         QJP3uVpenjmgNvdgpw6W8daCogKWzHNZVu3H/uC0HMCGkwN3fvzLaWDagPFujyr7WmOZ
         /zIw==
X-Gm-Message-State: AOJu0Yyx2pHQ8rdvpLtFl+3Gar9PHX7ypb0EFcu5kDTUA9y3OPFPPVY7
	3czyCOJUPZkZjJhllPpBBQSfRRQaQwhqEaT2M6JM/fWlHNO1FROq4eQAxB2P
X-Google-Smtp-Source: AGHT+IGxgD/JasnglCJ18xLeaFRTXQjNvXr09NmYQ5fehvk5/475jmPf8X4ba3zItyKrNImqAEE3Kw==
X-Received: by 2002:a17:902:e5cd:b0:20c:b3d9:f5bd with SMTP id d9443c01a7336-20e5a75a9a7mr165079495ad.18.1729517677147;
        Mon, 21 Oct 2024 06:34:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db2desm25653465ad.203.2024.10.21.06.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:36 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:34:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZxZYcPwLB5oLTFUo@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

We have already set up the infrastructure to check the consistency for
refs, but we do not support multiple worktrees. As we decide to add more
checks for ref content, we need to set up support for multiple
worktrees.

Because each worktree has its own specific refs, instead of just showing
the users "refs/worktree/foo", we need to display the full name such as
"worktrees/<id>/refs/worktree/foo". So we should know the id of the
worktree to get the full name. Add a new parameter "struct worktree *"
for "refs-internal.h::fsck_fn". Then change the related functions to
follow this new interface.

The "packed-refs" only exists in the main worktree, so we should only
check "packed-refs" in the main worktree. Use "is_main_worktree" method
to skip checking "packed-refs" in "packed_fsck" function.

Then, enhance the "files-backend.c::files_fsck_refs_dir" function to add
"worktree/<id>/" prefix when we are not in the main worktree.

Last, add a new test to check the refname when there are multiple
worktrees to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/refs.c           | 12 ++++++--
 refs.c                   |  5 ++--
 refs.h                   |  3 +-
 refs/debug.c             |  5 ++--
 refs/files-backend.c     | 17 ++++++++----
 refs/packed-backend.c    |  8 +++++-
 refs/refs-internal.h     |  3 +-
 refs/reftable-backend.c  |  3 +-
 t/t0602-reffiles-fsck.sh | 59 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index 24978a7b7b..886c4ceae3 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "worktree.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
@@ -66,6 +67,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 {
 	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	struct worktree **worktrees, **p;
 	const char * const verify_usage[] = {
 		REFS_VERIFY_USAGE,
 		NULL,
@@ -75,7 +77,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
 		OPT_END(),
 	};
-	int ret;
+	int ret = 0;
 
 	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
 	if (argc)
@@ -84,9 +86,15 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 	git_config(git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
-	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+	worktrees = get_worktrees();
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		ret |= refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options, wt);
+	}
+
 
 	fsck_options_clear(&fsck_refs_options);
+	free_worktrees(worktrees);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 5f729ed412..395a17273c 100644
--- a/refs.c
+++ b/refs.c
@@ -318,9 +318,10 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
-int refs_fsck(struct ref_store *refs, struct fsck_options *o)
+int refs_fsck(struct ref_store *refs, struct fsck_options *o,
+	      struct worktree *wt)
 {
-	return refs->be->fsck(refs, o);
+	return refs->be->fsck(refs, o, wt);
 }
 
 void sanitize_refname_component(const char *refname, struct strbuf *out)
diff --git a/refs.h b/refs.h
index 108dfc93b3..341d43239c 100644
--- a/refs.h
+++ b/refs.h
@@ -549,7 +549,8 @@ int check_refname_format(const char *refname, int flags);
  * reflogs are consistent, and non-zero otherwise. The errors will be
  * written to stderr.
  */
-int refs_fsck(struct ref_store *refs, struct fsck_options *o);
+int refs_fsck(struct ref_store *refs, struct fsck_options *o,
+	      struct worktree *wt);
 
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
diff --git a/refs/debug.c b/refs/debug.c
index 45e2e784a0..72e80ddd6d 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -420,10 +420,11 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 }
 
 static int debug_fsck(struct ref_store *ref_store,
-		      struct fsck_options *o)
+		      struct fsck_options *o,
+		      struct worktree *wt)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->fsck(drefs->refs, o);
+	int res = drefs->refs->be->fsck(drefs->refs, o, wt);
 	trace_printf_key(&trace_refs, "fsck: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fbfcd1115c..24ad73faba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -23,6 +23,7 @@
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
+#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../revision.h"
@@ -3536,6 +3537,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
+			       struct worktree *wt,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
 	struct strbuf target_name = STRBUF_INIT;
@@ -3558,6 +3560,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
 			strbuf_reset(&target_name);
+
+			if (!is_main_worktree(wt))
+				strbuf_addf(&target_name, "worktrees/%s/", wt->id);
 			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
 				    iter->relative_path);
 
@@ -3587,7 +3592,8 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 }
 
 static int files_fsck_refs(struct ref_store *ref_store,
-			   struct fsck_options *o)
+			   struct fsck_options *o,
+			   struct worktree *wt)
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
@@ -3596,17 +3602,18 @@ static int files_fsck_refs(struct ref_store *ref_store,
 
 	if (o->verbose)
 		fprintf_ln(stderr, _("Checking references consistency"));
-	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
+	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
 }
 
 static int files_fsck(struct ref_store *ref_store,
-		      struct fsck_options *o)
+		      struct fsck_options *o,
+		      struct worktree *wt)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	return files_fsck_refs(ref_store, o) |
-	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	return files_fsck_refs(ref_store, o, wt) |
+	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
 }
 
 struct ref_storage_be refs_be_files = {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 07c57fd541..46dcaec654 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -13,6 +13,7 @@
 #include "../lockfile.h"
 #include "../chdir-notify.h"
 #include "../statinfo.h"
+#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../trace2.h"
@@ -1754,8 +1755,13 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 }
 
 static int packed_fsck(struct ref_store *ref_store UNUSED,
-		       struct fsck_options *o UNUSED)
+		       struct fsck_options *o UNUSED,
+		       struct worktree *wt)
 {
+
+	if (!is_main_worktree(wt))
+		return 0;
+
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..037d7991cd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,7 +653,8 @@ typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refnam
 				 struct strbuf *referent);
 
 typedef int fsck_fn(struct ref_store *ref_store,
-		    struct fsck_options *o);
+		    struct fsck_options *o,
+		    struct worktree *wt);
 
 struct ref_storage_be {
 	const char *name;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f5f957e6de..b6a63c1015 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2443,7 +2443,8 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 }
 
 static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
-			    struct fsck_options *o UNUSED)
+			    struct fsck_options *o UNUSED,
+			    struct worktree *wt UNUSED)
 {
 	return 0;
 }
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 0aee377439..6eb1385c50 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -105,4 +105,63 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_must_be_empty err
 '
 
+test_expect_success 'ref name check should work for multiple worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+
+	cd repo &&
+	test_commit initial &&
+	git checkout -b branch-1 &&
+	test_commit second &&
+	git checkout -b branch-2 &&
+	test_commit third &&
+	git checkout -b branch-3 &&
+	git worktree add ./worktree-1 branch-1 &&
+	git worktree add ./worktree-2 branch-2 &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-3
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-3
+	) &&
+
+	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
+	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err &&
+
+	(
+		cd worktree-1 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	) &&
+
+	(
+		cd worktree-2 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	)
+'
+
 test_done
-- 
2.47.0

