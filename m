Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76D271456
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035555; cv=none; b=AwUx4NtaiMFHST7Njtp2Xa7W2kMDk6tfk9qh/5QUZa9+TdV9GJf1vy42+ajFlLpgtvIzICRmHtDEDWCFNhzHk0fudJhZM+o/WfyXpYXG9MVEeCFVRw4I0hq3VN/gCuiucNshpRohmJqybJ4B4aAvVZhZCRQx6M2YqM4Y0iuom7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035555; c=relaxed/simple;
	bh=SHofe67T0EgIeyLtBjGATSlHY7cl9GgICjo0mzK7gmw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=n4ztqahsXQSoxC71wdzGIqReyZCF40OSqKEnU4AM2logjv/K/+QGBGN2mQ6tVqSffMwLMVMsv799x8clUzpKhlqy88RwUStiRtjWPGcJghPwS5fnSIe+IYHH9yuX3dFwJWs+aTpaa3RTXFdTKFI6PceB7BNYcSLuZOG+RngVfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJExe1yA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJExe1yA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed9c19248bso80113861cf.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 11:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767035551; x=1767640351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ9bS94a117UIUukElqDq3Shu8BaDy9hgd3Gl2Q3upY=;
        b=eJExe1yAElayasRMGpTLfmpfNWEKeoBr4Y/9lUW/wEdVNvnJ72FRFoLsMAdQIlbvnf
         IAY7wJh3f8Xd4ub8UrQtCfcYYzz9KRVaUo7X+4Sjfp2cLLSn5k3jCuxV2cxryv6unkIU
         Cv6iK2Mz7kb1bR4aJJaH5BhKvN6T6ultFX1ASpX0NBzrBArJV29E4wgiLJ79vl0SNeDL
         nukdHH8rRcckaYmkxGO6NkNyUldzFFOIxYQIXkKtc8d3jvtCYeLzXtfc+wsmMUX7QpLU
         JmUy8Rh1/S7kIo+cx5BdtoB3DuBsCJeUdp14w61iye5xlzdQygcSGLkq7iD/W/t7fH8G
         UV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767035551; x=1767640351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ9bS94a117UIUukElqDq3Shu8BaDy9hgd3Gl2Q3upY=;
        b=OPi1SOP1LrgOfC30Wlf4NYjBoQVsD6ER2P6mmoQoPmnT+yBych98Hn9AP9aUsN9H0E
         TkOP6IAUf2F+SdqI7wk/cqK6Em2qnIlPhgC9GCwV3QAcaK+xSBt43CAN3MS+64uoL1ua
         40G8RmNuIBOeLdbUNKLDhnrJw3MeA1lw1DpnBDbwipndgUvhA6FI2DNwUylt9P3NLG+5
         ZFgNHN8RVnM1nTelK+F9z3kvgWbp3YPPlxssxahnJmgx/IvrN58doduK4ymIH1ELuQWO
         Kvpom6uny8aJ72hn1fJpDpCwnKRjRPrTyftYTN5mbSmzEB/dlw3PBFsGyRASWchSKkt3
         dLLA==
X-Gm-Message-State: AOJu0YzVkXo2rqLfTcDvC4mCqMZn0QZc+hIrnWF+rwNp2qI822Bt3oNB
	n4+WMDOc3mGV9FILYNiyJllEgb/FgCRpBRZe7jR+awJ1eZkq3cARqQSG7+g1wg==
X-Gm-Gg: AY/fxX6GkJ8wXGqkH96+oyLAmMcAtdCVoLZYGyV7HbDy+bw5+b2xNKHZEdFGUZwQVJ0
	HlMdjgZ96tLeSRAU/FhMU99nx/edg9oHVfjdjCRTMgLQGtpyLy5enm3FyBmaBl3aBEOdn8/m4WL
	jk++pjLfknac32oxSS1Yp8zTE2wJZKV6LyZtp6Rc792FVs0cw4Z/KpLlfBc2nqITw1Ly45GoYMJ
	NOsRZRILXimJqog7bYjAzUnUf2hd7YRW/MTl5SqIfmRyjqw1EHmE4BG2l/kp9GQAzJMz8+B/wVL
	gdwZkXvlW+djkSmqMVVbSjEs5T+oLYcQ99CrO3k89Nr9rUCy3Gv9rV17PuWJygaUrjhpRZ1lY+P
	spXer7XCScbC8T7ZdEYgquDQa0MDyXiRb5vvTPppF+luIK8KM6z8HZ8sqK3xQmzQbwLhlJBI7CO
	3JNWZbaoWi600CvQ==
X-Google-Smtp-Source: AGHT+IGi49IcUjFQ9t3+ZrKyISdnWnyGuF3FkiiKmXkVgXGBuvQGIllPDXUJ3dyzowROdZcggqVPKg==
X-Received: by 2002:a05:622a:1a8a:b0:4ee:2312:605a with SMTP id d75a77b69052e-4f4abdb866cmr457195641cf.62.1767035550786;
        Mon, 29 Dec 2025 11:12:30 -0800 (PST)
Received: from [127.0.0.1] ([135.232.193.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623feb0sm237751226d6.2.2025.12.29.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 11:12:30 -0800 (PST)
Message-Id: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Dec 2025 19:12:29 +0000
Subject: [PATCH] fsck: snapshot default refs before object walk
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
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Fsck has a race when operating on live repositories; consider the
following simple script that writes new commits as fsck runs:

    #!/bin/bash
    git fsck &
    PID=$!

    while ps -p $PID >/dev/null; do
        sleep 3
        git commit -q --allow-empty -m "Another commit"
    done

Since fsck reads refs at the beginning, walks those for connectivity,
and then reads the refs again at the end to check, this can cause fsck
to get confused and think that the new refs refer to missing commits and
that new reflog entries are invalid.  Running the above script in a
clone of git.git results in the following (output ellipsized to remove
additional errors of the same type):

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

This problem doesn't occur when refs are specified on the command line
for us to check, since we use those specified refs for both walking and
checking.  Using the same refs for walking and checking seems to just
make sense, so modify the existing code to do the same when refs aren't
specified.  Snapshot the refs at the beginning, and also ignore all
reflog entries since the time of our snapshot (while this technically
means we could ignore a reflog entry created before the fsck process
if the local clock is weird, since reflogs are local-only there are not
concerns about differences between clocks on different machines).  This
combination of changes modifies the output of running the above script
to:

    $ ./fsck-while-writing.sh
    Checking ref database: 100% (1/1), done.
    Checking object directories: 100% (256/256), done.
    warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
    Checking objects: 100% (835091/835091), done.
    Checking connectivity: 833846, done.
    Verifying commits in commit graph: 100% (242243/242243), done.

While worries about live updates while running fsck is likely of most
interest for forge operators, it will likely also benefit those with
automated jobs (such as git maintenance) or even casual users who want
to do other work in their clone while fsck is running.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Co-authored-by: Elijah Newren <newren@gmail.com>
[en: several changes:
  * adjusted for upstream refactorings to refs callback call signatures
  * handle reflogs as well
  * free recorded snapshot of refs when done
  * default to snapshotting instead of making it a non-default option
  * provide reproducible testcase in commit message and rewrite commit
    message around it
]
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fsck: snapshot default refs before object walk

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2026%2Fnewren%2Ffsck-snapshot-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2026/newren/fsck-snapshot-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2026

 builtin/fsck.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c489582faa..8d20505f5d 100644
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
@@ -567,14 +571,53 @@ static int fsck_head_link(const char *head_ref_name,
 			  const char **head_points_at,
 			  struct object_id *head_oid);
 
-static void get_default_heads(void)
+struct ref_snapshot {
+	size_t nr;
+	size_t name_alloc;
+	size_t oid_alloc;
+	char **refname;
+	struct object_id *oid;
+};
+
+static int snapshot_refs(const struct reference *ref, void *cb_data)
+{
+	struct ref_snapshot *refs = cb_data;
+
+	ALLOC_GROW(refs->refname, refs->nr + 1, refs->name_alloc);
+	ALLOC_GROW(refs->oid, refs->nr + 1, refs->oid_alloc);
+
+	refs->refname[refs->nr] = xstrdup(ref->name);
+	oidcpy(&refs->oid[refs->nr], ref->oid);
+	refs->nr++;
+
+	return 0;
+}
+
+static void free_snapshot_refs(struct ref_snapshot *snapshot)
+{
+	for (size_t i = 0; i < snapshot->nr; i++)
+		free(snapshot->refname[i]);
+	free(snapshot->refname);
+	free(snapshot->oid);
+}
+
+static void get_default_heads(struct ref_snapshot *the_refs)
 {
 	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
 
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     fsck_handle_ref, NULL);
+	if (the_refs)
+		for (size_t i = 0; i < the_refs->nr; i++) {
+			struct reference ref = {
+				.name = the_refs->refname[i],
+				.oid = &the_refs->oid[i],
+			};
+			fsck_handle_ref(&ref, NULL);
+		}
+	else
+		refs_for_each_rawref(get_main_ref_store(the_repository),
+				     fsck_handle_ref, NULL);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
@@ -964,6 +1007,14 @@ int cmd_fsck(int argc,
 {
 	int i;
 	struct odb_source *source;
+	struct ref_snapshot default_refs_snapshot = {
+		.nr = 0,
+		.name_alloc = 0,
+		.oid_alloc = 0,
+		.refname = NULL,
+		.oid = NULL
+	};
+	bool use_snapshot;
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -999,6 +1050,19 @@ int cmd_fsck(int argc,
 	if (check_references)
 		fsck_refs(the_repository);
 
+	/*
+	 * Take a snapshot of the refs before walking objects to avoid looking
+	 * at a set of refs that may be changed by the user while we are walking
+	 * objects. We can still walk over new objects that are added during the
+	 * execution of fsck but won't miss any objects that were reachable.
+	 */
+	use_snapshot = !argc;
+	if (use_snapshot) {
+		now = time(NULL);
+		refs_for_each_rawref(get_main_ref_store(the_repository),
+				     snapshot_refs, &default_refs_snapshot);
+	}
+
 	if (connectivity_only) {
 		for_each_loose_object(the_repository->objects,
 				      mark_loose_for_connectivity, NULL, 0);
@@ -1071,7 +1135,7 @@ int cmd_fsck(int argc,
 	 * in this case (ie this implies --cache).
 	 */
 	if (!argc) {
-		get_default_heads();
+		get_default_heads(use_snapshot ? &default_refs_snapshot : NULL);
 		keep_cache_objects = 1;
 	}
 
@@ -1148,5 +1212,7 @@ int cmd_fsck(int argc,
 		}
 	}
 
+	if (use_snapshot)
+		free_snapshot_refs(&default_refs_snapshot);
 	return errors_found;
 }

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
