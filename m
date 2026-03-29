Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950B275B1A
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779493; cv=none; b=lTu8zRvJLfJhoASD3d8kurf7UfAieFK0rLe9gt+iu6SrDERg1/J611Z7SKSWl0PS81DcHFhBy7YxaZpdltWox6G0OD+yoP6HAtUk21V+3g0PZURi2TJqPtseBa0Mb0Kk/3KQC0p7B77kSKZc8C/U49ZV8KDaBevPb3wp+klci4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779493; c=relaxed/simple;
	bh=IiPz2Z5hh/TqiVanpL/O7l7Zj0cnYl8xzBnurSjXzd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksTWNkGF7teEME+HtWE+JI9IBWIa3MzOZL5irIy0muL+wF77pc/pPq2EIe5+LOtljT4XpXsUKa3VeMbaZ2LvEtqNh8UDm+3sFoGuKKgGIQHFzkgx4MdylXH0pQM2mwTdymJs5cYG1F+8YJUiyDX1HwuCu9QQEUzNZ5AOARXtbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siJM2WnO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siJM2WnO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad21f437eeso23509065ad.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774779491; x=1775384291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPYNfHXScAXwbucXxkFHZ2Wyu6DbJNfwoRxaQ6X0iMQ=;
        b=siJM2WnOdR5FUBJVbdL3BA3Fzs0kPJOUpmE2AlknGLSZ3eKL4ue6kTFTVzcdBwLOXO
         F4CAGjNxLj9Egnb3V8te2XAoSKch8agFuDCVYvGoN0yIwEmytpNzKiObGD5EpFywyhkk
         NCXoBE1OIA43aafoX7ssQYwCgwCVcX//dk6h8LhP4kAGVV1eIt/U8tMX3eP2nRjJYmZ1
         0DG4c0oUQ7DEuEXFQzdXzrxpCMi/Yr2oQpXjmbPzFCftueB8EWCToWJS+xND9LT093TY
         qrbAY4wz8PJw8SK6+dLh2KahOfYaYK6p3ypui2t0c/PrCBkrdPkHfhHoBAt3bWFtudcl
         emCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779491; x=1775384291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPYNfHXScAXwbucXxkFHZ2Wyu6DbJNfwoRxaQ6X0iMQ=;
        b=dE4i9HhfcQyqLK6wB2wbC+bnAWbiREETEZxq/zX4A890wLfVoOOje8LCoJpj0/YK1L
         UHKs2+meEbv3OtJbvF6gOO6DXbCzD8F7elaWQskRRiwOxdVhf0/PYFTFcxsIHWhwNppB
         W8IgWDfS7PAeU8KjkSI7CB4Nwh71Rw6AjiZ4mJANekoKQJ/Ej6kX+cHGJZotovioiXF9
         X372zSzx/qzWP+e+BYIA/6Dn7R99C5hQp0+0+cHiOHMR0gd3G+CAjiebVo/32a3fMkCU
         2HAkMi2VrtABOrCZrhHanOvdm3sIzfE5vFQpUhYbP49vyQS1XlHlhSHoblBumCxGq3+F
         RlrQ==
X-Gm-Message-State: AOJu0Yye6UKT5nmOh74bRjMJq+wocGCVd7kZi7BWwvEMn6pPLRpXqspx
	xw3P62ts1owgmWaeyfgsRDTy+utgZibmazZtqSeTymuheZBkN7I4ziU19ZyIeg==
X-Gm-Gg: ATEYQzxrRvBdRA5wPXnU8v8VofDySNuW5ixJzhKZpvFdFcoGU6VWGjXrVWqwo9UP6Ui
	iQ9UORT6Fn3fa4Z12V4pGRd/f93MexffemXOlMDBhwfRVGbMSY2GSzU6Oamgh0VztC+9+oUrcgV
	fDwmWLgBX2fiB/KDimp7ykT1sVSYmx1gniuCc4d9sSO+2Vd5wYeqlwP/9M4gsd3A70yv5rSszQ6
	crkEHL+TL2FsXZLEQMVOvz64cxrnjCpOZcbb0Hgd3uXkS4U89+zIqXt8Ml0jqxBy19N2OhAr1WI
	eoeLasqTh8LkUwJ0kLNgyrHqyytVSuoBp+vsXejfrXM2PRMwKUBhcgHbOCEZRna+Q8pXbP502Nt
	+a0/mEoMFqCruedSLKZTQnVRTIV/yhkrxMWOP7S65UZ/DZCxzCc+Hmun+P2Ph6+brdjABnmdanJ
	WQHQAQkXenURM5hGNEzcTpebDQRY2S+Q+aNzdfJsD6TXE=
X-Received: by 2002:a17:902:e851:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b0c461ec7bmr127050815ad.0.1774779490748;
        Sun, 29 Mar 2026 03:18:10 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6fcd:e3ea:7ddd:8d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242679bb3sm46199185ad.30.2026.03.29.03.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:18:10 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 1/5] refs: add struct repository parameter to branchname helpers
Date: Sun, 29 Mar 2026 15:46:39 +0530
Message-ID: <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_branchname() in refs.c relies on the_repository when calling
repo_interpret_branch_name(), introducing an implicit dependency on global
state. Add a struct repository parameter and use it instead.

Update check_branch_ref() to take a repository parameter as well, since it
calls copy_branchname(). Propagate this change to higher-level helpers
validate_branchname() and validate_new_branchname(), which also lack access
to a repository instance. Most callers of these helpers reside in builtin
code and already operate on the_repository, so pass it explicitly at those
call sites (builtin/checkout and builtin/worktree) otherwise pass struct
repository where available.

This makes branch name handling explicitly repository-aware and aligns with
ongoing efforts to remove reliance on global state. This change builds on
top of jw/object-name-bitset-to-enum (2026-03-18), which introduced the
enum interpret_branch_kind parameter to copy_branchname().

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 branch.c                   | 15 ++++++++-------
 branch.h                   |  5 +++--
 builtin/branch.c           | 14 +++++++-------
 builtin/check-ref-format.c |  3 ++-
 builtin/checkout.c         |  6 +++---
 builtin/merge.c            |  2 +-
 builtin/worktree.c         | 10 +++++-----
 refs.c                     |  8 ++++----
 refs.h                     |  4 ++--
 9 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..63a9c0c238 100644
--- a/branch.c
+++ b/branch.c
@@ -370,16 +370,16 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref)
+int validate_branchname(struct repository *repo, const char *name, struct strbuf *ref)
 {
-	if (check_branch_ref(ref, name)) {
+	if (check_branch_ref(repo, ref, name)) {
 		int code = die_message(_("'%s' is not a valid branch name"), name);
 		advise_if_enabled(ADVICE_REF_SYNTAX,
 				  _("See 'git help check-ref-format'"));
 		exit(code);
 	}
 
-	return refs_ref_exists(get_main_ref_store(the_repository), ref->buf);
+	return refs_ref_exists(get_main_ref_store(repo), ref->buf);
 }
 
 static int initialized_checked_out_branches;
@@ -468,10 +468,11 @@ const char *branch_checked_out(const char *refname)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+int validate_new_branchname(struct repository *repo, const char *name,
+			    struct strbuf *ref, int force)
 {
 	const char *path;
-	if (!validate_branchname(name, ref))
+	if (!validate_branchname(repo, name, ref))
 		return 0;
 
 	if (!force)
@@ -613,8 +614,8 @@ void create_branch(struct repository *r,
 		BUG("'clobber_head_ok' can only be used with 'force'");
 
 	if (clobber_head_ok ?
-			  validate_branchname(name, &ref) :
-			  validate_new_branchname(name, &ref, force)) {
+			  validate_branchname(r, name, &ref) :
+			  validate_new_branchname(r, name, &ref, force)) {
 		forcing = 1;
 	}
 
diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..b41176ee7f 100644
--- a/branch.h
+++ b/branch.h
@@ -111,7 +111,7 @@ const char *branch_checked_out(const char *refname);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref);
+int validate_branchname(struct repository *repo, const char *name, struct strbuf *ref);
 
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
@@ -119,7 +119,8 @@ int validate_branchname(const char *name, struct strbuf *ref);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(struct repository *repo, const char *name,
+			    struct strbuf *ref, int force);
 
 /*
  * Remove information about the merge state on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..ea4109f893 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -259,7 +259,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		copy_branchname(&bname, argv[i], allowed_interpret);
+		copy_branchname(the_repository, &bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
@@ -581,7 +581,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	int recovery = 0, oldref_usage = 0;
 	struct worktree **worktrees = get_worktrees();
 
-	if (check_branch_ref(&oldref, oldname)) {
+	if (check_branch_ref(the_repository, &oldref, oldname)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
@@ -619,9 +619,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref);
+		validate_branchname(the_repository, newname, &newref);
 	else
-		validate_new_branchname(newname, &newref, force);
+		validate_new_branchname(the_repository, newname, &newref, force);
 
 	reject_rebase_or_bisect_branch(worktrees, oldref.buf);
 
@@ -898,7 +898,7 @@ int cmd_branch(int argc,
 				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch_name = buf.buf;
 		} else {
 			die(_("cannot edit description of more than one branch"));
@@ -941,7 +941,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to set new upstream"));
@@ -971,7 +971,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			branch = branch_get(NULL);
 		else if (argc == 1) {
-			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
 			die(_("too many arguments to unset upstream"));
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 5d80afeec0..b7ba098363 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -1,6 +1,7 @@
 /*
  * GIT - The information manager from hell
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "refs.h"
 #include "setup.h"
@@ -42,7 +43,7 @@ static int check_ref_format_branch(const char *arg)
 	int nongit;
 
 	setup_git_directory_gently(&nongit);
-	if (check_branch_ref(&sb, arg) ||
+	if (check_branch_ref(the_repository, &sb, arg) ||
 	    !skip_prefix(sb.buf, "refs/heads/", &name))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", name);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..93ad894dc2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -743,7 +743,7 @@ static void setup_branch_path(struct branch_info *branch)
 			   &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
-	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
+	copy_branchname(the_repository, &buf, branch->name, INTERPRET_BRANCH_LOCAL);
 	if (strcmp(buf.buf, branch->name)) {
 		free(branch->name);
 		branch->name = xstrdup(buf.buf);
@@ -2014,10 +2014,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct strbuf buf = STRBUF_INIT;
 
 		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+			opts->branch_exists = validate_branchname(the_repository, opts->new_branch, &buf);
 		else
 			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
+				validate_new_branchname(the_repository, opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 2cbce56f8d..3f4b9dc47a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -552,7 +552,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	char *found_ref = NULL;
 	int len, early;
 
-	copy_branchname(&bname, remote, 0);
+	copy_branchname(the_repository, &bname, remote, 0);
 	remote = bname.buf;
 
 	oidclr(&branch_head, the_repository->hash_algo);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4035b1cb06..a5e116d8f9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -415,7 +415,7 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
 	struct strbuf symref = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	validate_new_branchname(ref, &symref, 0);
+	validate_new_branchname(the_repository, ref, &symref, 0);
 	strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
 	if (opts->quiet)
 		strvec_push(&cp.args, "--quiet");
@@ -481,7 +481,7 @@ static int add_worktree(const char *path, const char *refname,
 	worktrees = NULL;
 
 	/* is 'refname' a branch or commit? */
-	if (!opts->detach && !check_branch_ref(&symref, refname) &&
+	if (!opts->detach && !check_branch_ref(the_repository, &symref, refname) &&
 	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
 		is_branch = 1;
 		if (!opts->force)
@@ -649,7 +649,7 @@ static void print_preparing_worktree_line(int detach,
 		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
 		struct strbuf s = STRBUF_INIT;
-		if (!detach && !check_branch_ref(&s, branch) &&
+		if (!detach && !check_branch_ref(the_repository, &s, branch) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
 			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
 				  branch);
@@ -788,7 +788,7 @@ static char *dwim_branch(const char *path, char **new_branch)
 	char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
 
-	branch_exists = !check_branch_ref(&ref, branchname) &&
+	branch_exists = !check_branch_ref(the_repository, &ref, branchname) &&
 			refs_ref_exists(get_main_ref_store(the_repository),
 					ref.buf);
 	strbuf_release(&ref);
@@ -885,7 +885,7 @@ static int add(int ac, const char **av, const char *prefix,
 		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !check_branch_ref(&symref, new_branch) &&
+		    !check_branch_ref(the_repository, &symref, new_branch) &&
 		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
diff --git a/refs.c b/refs.c
index 685a0c247b..5cdc8858c5 100644
--- a/refs.c
+++ b/refs.c
@@ -743,14 +743,14 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-void copy_branchname(struct strbuf *sb, const char *name,
+void copy_branchname(struct repository *repo, struct strbuf *sb, const char *name,
 		     enum interpret_branch_kind allowed)
 {
 	int len = strlen(name);
 	struct interpret_branch_name_options options = {
 		.allowed = allowed
 	};
-	int used = repo_interpret_branch_name(the_repository, name, len, sb,
+	int used = repo_interpret_branch_name(repo, name, len, sb,
 					      &options);
 
 	if (used < 0)
@@ -758,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const char *name,
 	strbuf_add(sb, name + used, len - used);
 }
 
-int check_branch_ref(struct strbuf *sb, const char *name)
+int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
 {
 	if (startup_info->have_repository)
-		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
 	else
 		strbuf_addstr(sb, name);
 
diff --git a/refs.h b/refs.h
index d65de6ab5f..5407a4c4d6 100644
--- a/refs.h
+++ b/refs.h
@@ -225,7 +225,7 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  * If "allowed" is non-zero, restrict the set of allowed expansions. See
  * repo_interpret_branch_name() for details.
  */
-void copy_branchname(struct strbuf *sb, const char *name,
+void copy_branchname(struct repository *repo, struct strbuf *sb, const char *name,
 		     enum interpret_branch_kind allowed);
 
 /*
@@ -234,7 +234,7 @@ void copy_branchname(struct strbuf *sb, const char *name,
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
-int check_branch_ref(struct strbuf *sb, const char *name);
+int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name);
 
 /*
  * Similar for a tag name in refs/tags/.
-- 
2.53.0

