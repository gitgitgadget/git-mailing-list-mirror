Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6C8C0B
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUV4vZ2k"
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55085B0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:13:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso1076131276.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697605994; x=1698210794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pW36dCKZw6LiOwI4UKKq2X1l/J9Nt3VpwjV3iBruN8=;
        b=lUV4vZ2kqz3CC/Y+0R6wuEga/K+APCWo5ztcBAi67of3Gm6gaupK5vq5qXNdfRooPf
         sAugqEr/TgZGyjJ1aBdowihStLgdKr5/MkcBiTetWV3K4M4pOmxlNVbL+085X7CEr+RR
         nhUQ/wlWTamrcy11Mssw5YaTAktMrl4vm6O6VHLPLkfMYVl11d6uoijKxxt0jq4z6szF
         ZCqo6oMpBKoPLDrCurU0bUkv7VM4N6K3wrg/z6/Xcgqr4khdKLP1txTZKj7X71PTTpCa
         quSSWf9CnQnC1kPDXoxziwF0bfD3I6AGLI7Tl+k0aaWBehNNrlL2yb7A3K7e91AQNESg
         CRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697605994; x=1698210794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pW36dCKZw6LiOwI4UKKq2X1l/J9Nt3VpwjV3iBruN8=;
        b=Vb7yUso1Tbv0sDfAc8ZI7FNlUutebHZsa7yKY1Flq6AlW8dXwIK9NUrbklOYowoSmS
         1Y5aiBcdwyr374EgCZZKbKruqa80gzqIXQ0pB9ZDVyYpRtOataphhb9gs96V2fdqiJEQ
         vTjssru94L7kwEEfMusnJNt7YsJUwL8ULK7qKqoNmx/ycTl2vFwvEghKpy3GWavz42vv
         AzUm87KIb3/i3AFH72qQobaXZVyW3XCW07+xOcSvbpFr9nSYI6nJ0V+Z+laPgE2eAO4h
         QmJy8fjzbJObLnKGuDO8AocZcabYaeCv6btYFJ3HP3MfFo64u9mG+g2fdiVsYRRj56zD
         Pe1w==
X-Gm-Message-State: AOJu0Yzqj69TkYlPk88Ft3UqWvEbaWwnXsEnI2Uhb3n+qpxyaxeJ9NdU
	cOGt/lFbG81luE2MDNfAcjah8fOgl94JCTjazFA=
X-Google-Smtp-Source: AGHT+IEvbL9LcORBPS3rRHKHnsM+dYd5QgACAiiotR3pjW0nPwXdvLHpb9bpOdXjF5e6PcxcVAgIsg==
X-Received: by 2002:a25:404d:0:b0:d9a:52dc:15d4 with SMTP id n74-20020a25404d000000b00d9a52dc15d4mr3874429yba.52.1697605994068;
        Tue, 17 Oct 2023 22:13:14 -0700 (PDT)
Received: from isoken-VirtualBox.. ([105.112.222.254])
        by smtp.gmail.com with ESMTPSA id k31-20020a25b29f000000b00d9b8c3d4e5bsm1059019ybj.11.2023.10.17.22.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 22:13:13 -0700 (PDT)
From: Isoken June Ibizugbe <isokenjune@gmail.com>
To: git@vger.kernel.org
Cc: rjusto@gmail.com,
	christian.couder@gmail.com,
	Isoken June Ibizugbe <isokenjune@gmail.com>
Subject: [Outreachy][PATCH] branch.c: adjust error messages to coding guidelines
Date: Wed, 18 Oct 2023 06:12:22 +0100
Message-ID: <20231018051223.13955-1-isokenjune@gmail.com>
X-Mailer: git-send-email 2.42.0.346.g24618a8a3e.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
---
 builtin/branch.c | 66 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ec190b14a..938c40bfaa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -173,11 +173,11 @@ static int branch_merged(int kind, const char *name,
 	    (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
-				"         '%s', but not yet merged to HEAD."),
+				"         '%s', but not yet merged to HEAD"),
 				name, reference_name);
 		else
 			warning(_("not deleting branch '%s' that is not yet merged to\n"
-				"         '%s', even though it is merged to HEAD."),
+				"         '%s', even though it is merged to HEAD"),
 				name, reference_name);
 	}
 	free(reference_name_to_free);
@@ -190,13 +190,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
-		error(_("Couldn't look up commit object for '%s'"), refname);
+		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("The branch '%s' is not fully merged.\n"
+		error(_("the branch '%s' is not fully merged.\n"
 		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'."), branchname, branchname);
+		      "run 'git branch -D %s'"), branchname, branchname);
 		return -1;
 	}
 	return 0;
@@ -207,7 +207,7 @@ static void delete_branch_config(const char *branchname)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
 	if (git_config_rename_section(buf.buf, NULL) < 0)
-		warning(_("Update of config-file failed"));
+		warning(_("update of config-file failed"));
 	strbuf_release(&buf);
 }
 
@@ -260,7 +260,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const char *path;
 			if ((path = branch_checked_out(name))) {
-				error(_("Cannot delete branch '%s' "
+				error(_("cannot delete branch '%s' "
 					"used by worktree at '%s'"),
 				      bname.buf, path);
 				ret = 1;
@@ -275,7 +275,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					&oid, &flags);
 		if (!target) {
 			if (remote_branch) {
-				error(_("remote-tracking branch '%s' not found."), bname.buf);
+				error(_("remote-tracking branch '%s' not found"), bname.buf);
 			} else {
 				char *virtual_name = mkpathdup(fmt_remotes, bname.buf);
 				char *virtual_target = resolve_refdup(virtual_name,
@@ -290,7 +290,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 						"Did you forget --remote?"),
 						bname.buf);
 				else
-					error(_("branch '%s' not found."), bname.buf);
+					error(_("branch '%s' not found"), bname.buf);
 				FREE_AND_NULL(virtual_target);
 			}
 			ret = 1;
@@ -518,11 +518,11 @@ static void reject_rebase_or_bisect_branch(struct worktree **worktrees,
 			continue;
 
 		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
+			die(_("branch %s is being rebased at %s"),
 			    target, wt->path);
 
 		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
+			die(_("branch %s is being bisected at %s"),
 			    target, wt->path);
 	}
 }
@@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		if (ref_exists(oldref.buf))
 			recovery = 1;
 		else
-			die(_("Invalid branch name: '%s'"), oldname);
+			die(_("invalid branch name: '%s'"), oldname);
 	}
 
 	for (int i = 0; worktrees[i]; i++) {
@@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
 		if (oldref_usage & IS_HEAD)
-			die(_("No commit on branch '%s' yet."), oldname);
+			die(_("no commit on branch '%s' yet"), oldname);
 		else
-			die(_("No branch named '%s'."), oldname);
+			die(_("no branch named '%s'"), oldname);
 	}
 
 	/*
@@ -624,32 +624,32 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch rename failed"));
+		die(_("branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch copy failed"));
+		die(_("branch copy failed"));
 
 	if (recovery) {
 		if (copy)
-			warning(_("Created a copy of a misnamed branch '%s'"),
+			warning(_("created a copy of a misnamed branch '%s'"),
 				interpreted_oldname);
 		else
-			warning(_("Renamed a misnamed branch '%s' away"),
+			warning(_("renamed a misnamed branch '%s' away"),
 				interpreted_oldname);
 	}
 
 	if (!copy && (oldref_usage & IS_HEAD) &&
 	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
 					      logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("branch renamed to %s, but HEAD is not updated"), newname);
 
 	strbuf_release(&logmsg);
 
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is renamed, but update of config-file failed"));
+		die(_("branch is renamed, but update of config-file failed"));
 	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is copied, but update of config-file failed"));
+		die(_("branch is copied, but update of config-file failed"));
 	strbuf_release(&oldref);
 	strbuf_release(&newref);
 	strbuf_release(&oldsection);
@@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
-		die(_("Failed to resolve HEAD as a valid ref."));
+		die(_("failed to resolve HEAD as a valid ref"));
 	if (!strcmp(head, "HEAD"))
 		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
@@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!argc) {
 			if (filter.detached)
-				die(_("Cannot give description to detached HEAD"));
+				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
@@ -878,8 +878,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
 			error((!argc || branch_checked_out(branch_ref.buf))
-			      ? _("No commit on branch '%s' yet.")
-			      : _("No branch named '%s'."),
+			      ? _("no commit on branch '%s' yet")
+			      : _("no branch named '%s'"),
 			      branch_name);
 		else if (!edit_branch_description(branch_name))
 			ret = 0; /* happy */
@@ -892,8 +892,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!argc)
 			die(_("branch name required"));
 		else if ((argc == 1) && filter.detached)
-			die(copy? _("cannot copy the current branch while not on any.")
-				: _("cannot rename the current branch while not on any."));
+			die(copy? _("cannot copy the current branch while not on any")
+				: _("cannot rename the current branch while not on any"));
 		else if (argc == 1)
 			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
 		else if (argc == 2)
@@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not set upstream of HEAD to %s when "
-				      "it does not point to any branch."),
+				      "it does not point to any branch"),
 				    new_upstream);
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!ref_exists(branch->refname)) {
 			if (!argc || branch_checked_out(branch->refname))
-				die(_("No commit on branch '%s' yet."), branch->name);
+				die(_("no commit on branch '%s' yet"), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
@@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not unset upstream of HEAD when "
-				      "it does not point to any branch."));
+				      "it does not point to any branch"));
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!branch_has_merge_config(branch))
-			die(_("Branch '%s' has no upstream information"), branch->name);
+			die(_("branch '%s' has no upstream information"), branch->name);
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
@@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *start_name = argc == 2 ? argv[1] : head;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
+			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
+			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
 		if (recurse_submodules) {
 			create_branches_recursively(the_repository, branch_name,
-- 
2.42.0.346.g24618a8a3e.dirty

