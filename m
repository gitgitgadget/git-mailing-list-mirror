Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41435CBB0
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980958; cv=none; b=PiLN8zz4wL5g9zpAv96PFk4lCfj/EMWJOR3B1Hq97DoStUfMWNEihZJYcS2Ink/UxWh+GHKp4ovBEjJqVs2WsjYoa44BT1oMfERF6Ur9tdVPdDqcUMXt3OzSBu4rIUq7XqmJahBhA4XtJ9f3rufgSEnu7kUQMxla4o+HOxPYuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980958; c=relaxed/simple;
	bh=MFxoObPX+f0Oj4HZBjIbCICaWduMPewwpO6EzLWh/o0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J2I++x+THV0+9Y7bQ35ZqWDJudHH3dwSERrzuNRL8TcoEh95EfTH6Wl8j+p8czP2pwDTaEQICH8dziNzGTFmlRVN4nvJyvwF5oUUPDpf8LXdAgD+LED5GmyCW2dVu0tpVkjg/l83FwuJhZL39g3U6BmGMFxXWSmXrMMtYMR0QUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8yRgN94; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8yRgN94"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d56eaaceso494994085a.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767980955; x=1768585755; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS8PGRorVgP6EEnZ2nZuDZ6Um6AsANQUmfTEnfu3LX8=;
        b=E8yRgN94dCwX2gRQqvzIIW5hWAX+RtxQ7c3j50wSE0ZLIfWxDfWSBkMc2Zc8R452pg
         YIovuE12agqFkK9RfOzxe0UFCayXSwf1Ry6l2a8oE1akul0MY1uz9K0nzoyy/3qz07Tt
         n10meHMb7FgsppDH88tAl/FVhSzPwcJyoAby3GKi7bpVG8xc98JPx7OULobgYMQWhUe1
         LhRcC11Yb53vwDhEK+9yZCxlLc5Ntksdz3Vkf4Q+XGr8YDPG/p2j3SHWRqGjCYJpBula
         f/6OMkKnCmxDAsb4kDiSsHhKJHa9/Ii5pGUiYCv8MwDaWZKWjyfMCVxM/1vGQoYSkDiC
         PH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980955; x=1768585755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WS8PGRorVgP6EEnZ2nZuDZ6Um6AsANQUmfTEnfu3LX8=;
        b=uR5qaVx8U1DlcRoFzn5MaODhVUHYwNfYhHjFs2utY7ZISMHmxJ5DXSqwAwZ5ALT4eF
         LzbydL0jzELK9HVk5YsdjvyEvV7HgOOQR+WPLDnxsNan/X0YphMDd64WPuya8NaFUTtN
         CWFdmMFzgE6b8eVHkM3PZXxoFF9nAVKslZSpoTkCsvHkbuJ8Jn2uAxJA2EKnUFhVABtq
         Jwpd0oL7p51oFaJILY9tYocQYHLTGkf8lswLWiH85ObW6K6HEjgf/acNovAG1Xn8NL3n
         xE9AHJUzR93zrecGT8oBQeOW8ca6p1pCfAtks6W09Ui3mmitHsakS0furyzfrQzWrqrI
         o8+g==
X-Gm-Message-State: AOJu0YxPIJXpwXDDKLvbB5+Y8KXmRziv5goFd39Vs3jQDh1kOO0mQGDA
	xGgGSGTgvKB9RrJQC/S43osgTJTshU4G80SADOwIBF0r4ToS55+r0roDfo9PlzNy
X-Gm-Gg: AY/fxX57qwpfl2pTYrrbtojOEXWDFr52JH8GqzUOqfBO9LxS1dTadB9AJ4YlodWb3wI
	mEBgJL8fQ2/SOmi1R19AbWtbacjRdf1dCaGysKMK4hpCXqDnkpaUq9LqaDS8eUcbZc3sBBTCLPz
	TXCTjP9wlQvyTAj385YX00bJ6wf+YLeGNIcPWifDLuw/FAfk0kY7bIQCImTH4faXM0bLTeEIggH
	igNVG/rqQN0vboLdnLC4SKT4ZODwLIAnoUCjVi2NG1wJXZMAJOtRbFj/Q6VNCLqUq5kfxBns+/I
	d96PZvvNuVCx9z13CsEStZwE+PPbtkqPFXOzbE/vRY9rliVrn7C2ZoXgHAcdH1SP0/Z0YiSfukk
	iEM32hVPBKjvDh3Y4BwmSAjdMdNETBiX5Kn/Khyf1A9RTTgsS6FMUN+itJU8Hw1EuggsQmgk2gi
	+2o2S0o2xXQwM=
X-Google-Smtp-Source: AGHT+IGi6QNfXGCi/aTsSrr7eYs9YX1ZbAD5RufZ2Kcy1SChnVOC4qgDP3EJ0cA7Oal6yid3bs8bEA==
X-Received: by 2002:a05:620a:3714:b0:8b2:ec1e:fe24 with SMTP id af79cd13be357-8c3893ef768mr1469387085a.42.1767980954879;
        Fri, 09 Jan 2026 09:49:14 -0800 (PST)
Received: from [127.0.0.1] ([48.214.54.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6b4fsm858516385a.2.2026.01.09.09.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:49:13 -0800 (PST)
Message-Id: <pull.2026.v3.git.1767980953134.gitgitgadget@gmail.com>
In-Reply-To: <pull.2026.v2.git.1767749366719.gitgitgadget@gmail.com>
References: <pull.2026.v2.git.1767749366719.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 17:49:13 +0000
Subject: [PATCH v3] fsck: snapshot default refs before object walk
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
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,
    Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Fsck has a race when operating on live repositories; consider the
following simple script that writes new commits as fsck runs:

    #!/bin/bash
    git fsck &
    PID=$!

    while ps -p $PID >/dev/null; do
        sleep 3
        git commit -q --allow-empty -m "Another commit"
    done

Since fsck walks objects for connectivity and then reads the refs at the
end to check, this can cause fsck to get confused and think that the new
refs refer to missing commits and that new reflog entries are invalid.
Running the above script in a clone of git.git results in the following
(output ellipsized to remove additional errors of the same type):

    $ ./fsck-while-writing.sh
    Checking ref database: 100% (1/1), done.
    Checking object directories: 100% (256/256), done.
    warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
    Checking objects: 100% (835091/835091), done.
    error: HEAD: invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: HEAD: invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: HEAD: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    error: HEAD: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    [...]
    error: HEAD: invalid reflog entry 87c8a5c2f6b79d9afa9e941590b9a097b6f7ac09
    error: HEAD: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: HEAD: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: HEAD: invalid reflog entry 6724f2dfede88bfa9445a333e06e78536c0c6c0d
    error: refs/heads/mybranch invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: refs/heads/mybranch: invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: refs/heads/mybranch: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    error: refs/heads/mybranch: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    [...]
    error: refs/heads/mybranch: invalid reflog entry 87c8a5c2f6b79d9afa9e941590b9a097b6f7ac09
    error: refs/heads/mybranch: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: refs/heads/mybranch: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: refs/heads/mybranch: invalid reflog entry 6724f2dfede88bfa9445a333e06e78536c0c6c0d
    Checking connectivity: 833846, done.
    missing commit 6724f2dfede88bfa9445a333e06e78536c0c6c0d
    Verifying commits in commit graph: 100% (242243/242243), done.

We can minimize the race opportunities by taking a snapshot of refs at
program invocation, doing the connectivity check, and then checking the
snapshotted refs afterward.  This avoids races with regular refs between
fsck and adding objects to the database, though it still leaves a race
between a gc and fsck.  We are less concerned about folks simultaneously
running gc with fsck; though, if it becomes an issue, we could lock fsck
during gc.  We definitely do not want to lock fsck during operations
that may add objects to the object store; that would be problematic for
forges.

Note that refs aren't the only problem, though; reflog entries and index
entries could be problematic as well.  For now we punt on index entries
just leaving a TODO comment, and for reflogs we use a coarse solution of
taking the time at the beginning of the program and ignoring reflog
entries newer than that time.  That may be imperfect if dealing with a
network filesystem, so we leave TODO comment for those that want to
improve that handling as well.

As a high level overview:
  * In addition to fsck_handle_ref(), which now is only a few lines long
    to process a ref, there's also a snapshot_ref() which is called
    early in the program for each ref and takes all the error checking
    logic.
  * The iterating over refs that used to be in get_default_heads() plus
    a loop over the arguments now appears in shapshot_refs().
  * There's a new process_refs() as well that kind of looks like the old
    get_default_heads() though it is streamlined due to the work done by
    snapshot_refs().

This combination of changes modifies the output of running the script
(from the beginning of this commit message) to:

    $ ./fsck-while-writing.sh
    Checking ref database: 100% (1/1), done.
    Checking object directories: 100% (256/256), done.
    warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
    Checking objects: 100% (835091/835091), done.
    Checking connectivity: 833846, done.
    Verifying commits in commit graph: 100% (242243/242243), done.

While worries about live updates while running fsck is likely of most
interest for forge operators, it may also benefit those with
automated jobs (such as git maintenance) or even casual users who want
to do other work in their clone while fsck is running.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fsck: snapshot default refs before object walk
    
    Changes in v3:
    
     * Removed the attribution for Matthew, as per his request.
    
    Changes in v2, thanks to feedback & help from Peff & Junio:
    
     * Fixed errors in commit message
     * Changed to use a refname, oid struct and have an array of those
     * Snapshot command line arguments and worktree HEADs too
     * Add TODO items for snapshotting index entries, and for possibly
       improved reflog handling
     * Since nothing from Matthew's original patch in GitHub's fork of git
       remains in this patch by v2 (only a little of it remained in v1), I
       changed authorship to myself and gave Matthew an
       Originally-based-on-a-patch-by trailer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2026%2Fnewren%2Ffsck-snapshot-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2026/newren/fsck-snapshot-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2026

Range-diff vs v2:

 1:  7af3e9b92e ! 1:  46b3ae9380 fsck: snapshot default refs before object walk
     @@ Commit message
          automated jobs (such as git maintenance) or even casual users who want
          to do other work in their clone while fsck is running.
      
     -    Originally-based-on-a-patch-by: Matthew John Cheetham <mjcheetham@outlook.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>


 builtin/fsck.c | 162 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 122 insertions(+), 40 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c489582faa..eec4626bfa 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -51,6 +51,7 @@ static int show_progress = -1;
 static int show_dangling = 1;
 static int name_objects;
 static int check_references = 1;
+static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -509,6 +510,9 @@ static int fsck_handle_reflog_ent(const char *refname,
 				  timestamp_t timestamp, int tz UNUSED,
 				  const char *message UNUSED, void *cb_data UNUSED)
 {
+	if (now && timestamp > now)
+		return 0;
+
 	if (verbose)
 		fprintf_ln(stderr, _("Checking reflog %s->%s"),
 			   oid_to_hex(ooid), oid_to_hex(noid));
@@ -530,8 +534,22 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
+struct ref_snapshot {
+	char *refname;
+	struct object_id oid;
+	/* TODO: Maybe supplement with latest reflog entry info too? */
+};
+
+struct snapshot {
+	size_t nr;
+	size_t alloc;
+	struct ref_snapshot *ref;
+	/* TODO: Consider also snapshotting the index of each worktree. */
+};
+
+static int snapshot_ref(const struct reference *ref, void *cb_data)
 {
+	struct snapshot *snap = cb_data;
 	struct object *obj;
 
 	obj = parse_object(the_repository, ref->oid);
@@ -555,6 +573,20 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 		errors_found |= ERROR_REFS;
 	}
 	default_refs++;
+
+	ALLOC_GROW(snap->ref, snap->nr + 1, snap->alloc);
+	snap->ref[snap->nr].refname = xstrdup(ref->name);
+	oidcpy(&snap->ref[snap->nr].oid, ref->oid);
+	snap->nr++;
+
+	return 0;
+}
+
+static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
+{
+	struct object *obj;
+
+	obj = parse_object(the_repository, ref->oid);
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
 			     ref->oid, "%s", ref->name);
@@ -567,14 +599,35 @@ static int fsck_head_link(const char *head_ref_name,
 			  const char **head_points_at,
 			  struct object_id *head_oid);
 
-static void get_default_heads(void)
+static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 {
 	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
 
+	for (int i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		struct object_id oid;
+		if (!repo_get_oid(the_repository, arg, &oid)) {
+			struct reference ref = {
+				.name = arg,
+				.oid = &oid,
+			};
+
+			snapshot_ref(&ref, snap);
+			continue;
+		}
+		error(_("invalid parameter: expected sha1, got '%s'"), arg);
+		errors_found |= ERROR_OBJECT;
+	}
+
+	if (argc) {
+		include_reflogs = 0;
+		return;
+	}
+
 	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     fsck_handle_ref, NULL);
+			     snapshot_ref, snap);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
@@ -589,15 +642,52 @@ static void get_default_heads(void)
 				.oid = &head_oid,
 			};
 
-			fsck_handle_ref(&ref, NULL);
+			snapshot_ref(&ref, snap);
 		}
 		strbuf_release(&refname);
 
-		if (include_reflogs)
+		/*
+		 * TODO: Could use refs_for_each_reflog(...) to find
+		 * latest entry instead of using a global 'now' for that
+		 * purpose.
+		 */
+	}
+	free_worktrees(worktrees);
+
+	/* Ignore reflogs newer than now */
+	now = time(NULL);
+}
+
+
+static void free_snapshot_refs(struct snapshot *snap)
+{
+	for (size_t i = 0; i < snap->nr; i++)
+		free(snap->ref[i].refname);
+	free(snap->ref);
+}
+
+static void process_refs(struct snapshot *snap)
+{
+	struct worktree **worktrees, **p;
+
+	for (size_t i = 0; i < snap->nr; i++) {
+		struct reference ref = {
+			.name = snap->ref[i].refname,
+			.oid = &snap->ref[i].oid,
+		};
+		fsck_handle_ref(&ref, NULL);
+	}
+
+	if (include_reflogs) {
+		worktrees = get_worktrees();
+		for (p = worktrees; *p; p++) {
+			struct worktree *wt = *p;
+
 			refs_for_each_reflog(get_worktree_ref_store(wt),
 					     fsck_handle_reflog, wt);
+		}
+		free_worktrees(worktrees);
 	}
-	free_worktrees(worktrees);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -962,8 +1052,12 @@ int cmd_fsck(int argc,
 	     const char *prefix,
 	     struct repository *repo UNUSED)
 {
-	int i;
 	struct odb_source *source;
+	struct snapshot snap = {
+		.nr = 0,
+		.alloc = 0,
+		.ref = NULL
+	};
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -999,6 +1093,17 @@ int cmd_fsck(int argc,
 	if (check_references)
 		fsck_refs(the_repository);
 
+	/*
+	 * Take a snapshot of the refs before walking objects to avoid looking
+	 * at a set of refs that may be changed by the user while we are walking
+	 * objects. We can still walk over new objects that are added during the
+	 * execution of fsck but won't miss any objects that were reachable.
+	 */
+	snapshot_refs(&snap, argc, argv);
+
+	/* Ensure we get a "fresh" view of the odb */
+	odb_reprepare(the_repository->objects);
+
 	if (connectivity_only) {
 		for_each_loose_object(the_repository->objects,
 				      mark_loose_for_connectivity, NULL, 0);
@@ -1040,42 +1145,18 @@ int cmd_fsck(int argc,
 			errors_found |= ERROR_OBJECT;
 	}
 
-	for (i = 0; i < argc; i++) {
-		const char *arg = argv[i];
-		struct object_id oid;
-		if (!repo_get_oid(the_repository, arg, &oid)) {
-			struct object *obj = lookup_object(the_repository,
-							   &oid);
-
-			if (!obj || !(obj->flags & HAS_OBJ)) {
-				if (is_promisor_object(the_repository, &oid))
-					continue;
-				error(_("%s: object missing"), oid_to_hex(&oid));
-				errors_found |= ERROR_OBJECT;
-				continue;
-			}
-
-			obj->flags |= USED;
-			fsck_put_object_name(&fsck_walk_options, &oid,
-					     "%s", arg);
-			mark_object_reachable(obj);
-			continue;
-		}
-		error(_("invalid parameter: expected sha1, got '%s'"), arg);
-		errors_found |= ERROR_OBJECT;
-	}
+	/* Process the snapshotted refs and the reflogs. */
+	process_refs(&snap);
 
-	/*
-	 * If we've not been given any explicit head information, do the
-	 * default ones from .git/refs. We also consider the index file
-	 * in this case (ie this implies --cache).
-	 */
-	if (!argc) {
-		get_default_heads();
+	/* If not given any explicit objects, process index files too. */
+	if (!argc)
 		keep_cache_objects = 1;
-	}
-
 	if (keep_cache_objects) {
+		/*
+		 * TODO: Consider first walking these indexes in snapshot_refs,
+		 * to snapshot where the index entries used to point, and then
+		 * check those snapshotted locations here.
+		 */
 		struct worktree **worktrees, **p;
 
 		verify_index_checksum = 1;
@@ -1148,5 +1229,6 @@ int cmd_fsck(int argc,
 		}
 	}
 
+	free_snapshot_refs(&snap);
 	return errors_found;
 }

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
