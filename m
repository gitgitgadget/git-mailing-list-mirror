Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644182;
	b=oYdzCxURInusAtUIMGKzv8KCB1hG11wD8Osd2M6KVFJxdTgUm+GHk0eampbq9enD4EX4
	 /uUbKSEA9Selg7GFF/SpSHBPAYtaiLnnqqp0jC7OvTf3leh6FNUrhAcijGBHsbLvaAGcc
	 qZZ3rGH/cdlpNOAkphkLraF0mybn5pROf1KKGSKYNF1O+YYfNS9Y6siPS37Y9uuakOfv/
	 VzXQpgrGn9+kuTHpxItLHmGcHxgAA9V9IJ1YlpQ0WBF6kWJzunXx3kU9eFHMgQdY0mryO
	 LpPncBw0+SgiUMvERCPQopUx3MhMqmzA3CsMhGvxtJJ3hN4S1VmuXzzX30nmUWazP5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J5wKzhpOTe0mR2Fousqbi4jqCAiyl735x3KoVLnrZdw=;
	b=WEZ9+EspAw2Eah65F2WohKITYfwaI7kB43adNAn4YqOq1RmnF9HSx6WoBrvbJqHuDHm+
	 UCZGtcxAxzf1G4QtoUOy7KX2mEdu3krj9nsDJQ3Jmn9aIGLVDg97ds1oRdW32206GvoSE
	 kUcd1G6bcAM1qOMg6bHLm0qD/LdXR/39PeEBXiUajvKynp6zz4g3+xl5IgS65UOKyz8vb
	 z+Lfc8d0cVOaNgYXeYaBy8eZmRdqe9Q+56xDua/7RAhlE7WQfGE9HOH0qSorN2VXM9Kqe
	 oNDgYOsBh9hehtsKiTNmnQ/D2uv90JFj1HLy/SwZDRL7019bap+bOZTEK0mT7INTQiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=N0ffLktq;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC92606D809
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC92606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=N0ffLktq
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53fdd2fb171so43055531cf.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793644180; x=1794248980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5wKzhpOTe0mR2Fousqbi4jqCAiyl735x3KoVLnrZdw=;
        b=N0ffLktq3J1diFPHbf3ypO+MbWE06EO77EzbdgvBydBivRXphUz55zcTFtf69mzNBz
         MGZzByN+cp4RP0bOIy5BrFLdr6IfRfRQuppGM4bkCK9blc8IP2w+iZ9y0Q+CTZGWq4Yx
         AO7Rs43f8Suewv1vJ9Zp8rTmrY/3BdwvacgFpnUu8NkrHivMpPipuibO3i4c+wZcU2fl
         EfBokGk5o649eCOh1pHU+w9RTUAQFTbpJANjxi+ilox3JzsYRgWXRyDokw0M+XdDzW9j
         JsbzIysV3QozXfHfOOLadCyd+eYHEOF4SnTxWpHyzCJ2Dsmrvp+FRTA7JIF8NaZpw9Dw
         i97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644180; x=1794248980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J5wKzhpOTe0mR2Fousqbi4jqCAiyl735x3KoVLnrZdw=;
        b=Zi/JxBPZaX3Y5yAQFSolmP+rgTwFMItqeewMoDuiPWvIHAGRZ/o/KCNyCupFMMwc2M
         25G/keIkroK4q0x0OYKCnAr7Sha/kQluNYAnWb3DNDpp74WCdlGTkgRXtHDKsva1i3vK
         wA041fm5IMIPrk5bPUC1U5J1h5ZXQru9XlybnjrAJd8GCmTtUrEopRd8sebkhPD/deIW
         w4ne9Dmj97+8hD6/Bt8wMMPPfFWQHGkUv9pOHUpiTpGK8MazvqK2GJCpYq5o94AsfbYI
         dX4RIZHFAu2Md2Z/WpPc2i9cYVA1UA32saoPC7AsO2I8qgIWa/kp8mpKJND4FrVIsyUM
         uitg==
X-Gm-Message-State: AFq9FYIo+IjVI+UeR7w6CNv0GzoTr4IVooRyh8M/w3S1ld0yYNl/q5Id
	bXjCEYF0BGuPzDC4ISGeRG6gHI2TnvUn6pzAicIXo+zMewfxahrw+9ezDJBU3PJv2ANH/4PwIXD
	jiWL3sndQbeTCMT1gUmi53xIV6gKJRr44G44OOGrzbwjhhxCW2OATR8/RzOyN0B9nFkyeydlfS+
	kWchWh1wRwIr1g1tYDmO1MafUo4kkYrrQHGUlglojimIH3wgnyTdutPkAByRV4fZOijFSiBMNfw
	GW3JpPa/bqCPg1jyrkyOdsFSC/p24d3haFp6kUJf1Q=
X-Gm-Gg: AYBFou2thGB2J5c49cEGzJ1dnq7FVHEHldBC9joXV/2orBEmsuyZlq1afLFrWFST2Sh
	QJcvLwVOBiGClzUXqO4LKiwPQ6lL2YrgvoFhBqtNhhFIssz7wlngh2y6aZGsRnmsuxmNgy4IdrC
	xrMbCp1YRnzJpj0xH6DdDnYygbgqENy2ME+winIFY1K+ziGdf8zkxQ4RFYbA0LSrLG+lq3kFxX1
	NIrPYMq1Io2me24QDtB5a3NKaJKwnPqanyyg2xGjg+x5tWrxzKztufZyrCUecuv9VReTbiPhaK+
	wVl5XsznOJ5Xg1vj1BoTso6qs3KmRehmDYmSFDwD0Dx0kGqNtE3HCmkpFFN6mABYTWrF77mTVGJ
	U/rKm5c2SwmaoA71bNaYv8Gq6aSEy7HWPb2z5JB0Yehl/E8+7krCyY/cRoIdIYAtaeJugT9+/pz
	gIKXulNrgQZCuFFHCxsSBsSQcJeBEXJ+CqBaSVe9lBkBwk3zsyaqyOC6v43tsFXYkqxTTK27XjL
	xy8A6BI12abysb0+g52O0uI+Js7x/hAKHKjabzV7FIm24vziL+vGcQAqATZckKhVCZp7uWrl/wW
	OHg+7X7LSFRXs/P9Rdvn+qk+oat3erm6RbbmFzW3Ca73L0xwYJv/ua7tcCWHfC+Dozonoz5uSMK
	PiH5t3ha6SJDQe7XxD9UyrsincZmFQsCf1qfIidWBEOclTqjcl4glLm8zjwBRTVbpZ09QjmogUB
	vrD0fqy/GoNFK4EVEqG3bfq6neHrdUZNx4dviGmVTk3eEOmrz+kcm/fZ8RiDON6JWsC5Z4qN0on
	CzYdvhETQ794khRjbgDcWHo9N3irnNY9r20VLfHpgTUbxY=
X-Received: by 2002:a05:622a:5a18:b0:535:232f:ca25 with SMTP id d75a77b69052e-542b3d6f303mr169736361cf.7.1793644180395;
        Mon, 02 Nov 2026 10:29:40 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce29sm4346221cf.4.2026.11.02.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:29:39 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v4 3/4] ref-filter: name the worktree of a branch being rebased or bisected
Date: Mon,  2 Nov 2026 13:29:29 -0500
Message-ID: <20261102182930.3511-4-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102182930.3511-1-me@jaspermayone.com>
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

%(worktreepath) gives the worktree that has a branch checked out, and
"git branch" uses it to mark such branches with "+". It only looks at
the HEAD of each worktree, so while a worktree is rebasing or
bisecting a branch, its HEAD is detached and the branch shows no
worktree at all.

The rest of Git already treats that branch as checked out: "git
worktree add" and "git branch -d" refuse it, because finishing the
rebase or bisect will check it out again. But no command shows which
worktree is working on the branch: "git worktree list" shows such a
worktree as "(detached HEAD)", and %(worktreepath) is empty.

branch.c already knows the answer, as prepare_checked_out_branches()
records the branch that each worktree has checked out, is rebasing or
is bisecting. Add branch_checked_out_worktree() to look a branch up in
that list, and use it for %(worktreepath) in place of the map that
ref-filter.c builds from the HEAD of each worktree.

The new function skips the branches that "rebase --update-refs" will
update. branch_checked_out() includes them, so that they cannot be
checked out or deleted during the rebase, but the worktree that runs
the rebase has not checked them out. %(worktreepath) therefore stays
empty for them, unlike branch_checked_out().

This also changes the result for a bare repository: its HEAD names a
branch, and %(worktreepath) used to give the path of the bare
repository for that branch. "git branch" in a linked worktree marked
the branch with "+", although no worktree has it checked out and "git
worktree add" lets you check it out. prepare_checked_out_branches()
skips bare repositories, so %(worktreepath) is now empty for that
branch and "git branch" no longer marks it.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-branch.adoc       |  6 ++-
 Documentation/git-for-each-ref.adoc |  5 +-
 branch.c                            | 13 +++++
 branch.h                            |  9 ++++
 ref-filter.c                        | 74 ++--------------------------
 t/t3203-branch-output.sh            | 29 +++++++++++
 t/t6302-for-each-ref-filter.sh      | 76 +++++++++++++++++++++++++++++
 7 files changed, 138 insertions(+), 74 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..510b0afc74 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -33,8 +33,10 @@ DESCRIPTION
 If `--list` is given, or if there are no non-option arguments, existing
 branches are listed; the current branch will be highlighted in green and
 marked with an asterisk.  Any branches checked out in linked worktrees will
-be highlighted in cyan and marked with a plus sign. Option `-r` causes the
-remote-tracking branches to be listed,
+be highlighted in cyan and marked with a plus sign. A branch that a
+worktree is rebasing or bisecting counts as checked out in that
+worktree, so the other worktrees mark it in the same way. Option `-r`
+causes the remote-tracking branches to be listed,
 and option `-a` shows both local and remote branches.
 
 If a `<pattern>`
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 9247737aa7..4456b4809a 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -182,7 +182,10 @@ but if used together the last option is selected.
 
 `worktreepath`::
 	The absolute path to the worktree in which the ref is checked
-	out, if it is checked out in any linked worktree. Empty string
+	out, if it is checked out in any linked worktree. A branch that
+	a worktree is rebasing or bisecting counts as checked out there,
+	although that worktree's `HEAD` is detached. A branch that
+	`git rebase --update-refs` will update does not. Empty string
 	otherwise. If the ref is checked out in more than one worktree,
 	only one of them is shown. The path can contain a newline, so
 	use one of the quoting options such as `--shell`, or follow
diff --git a/branch.c b/branch.c
index 5bb1c28915..8dab72d857 100644
--- a/branch.c
+++ b/branch.c
@@ -485,6 +485,19 @@ const char *branch_checked_out(const char *refname)
 	return strmap_get(&current_checked_out_branches, refname);
 }
 
+const char *branch_checked_out_worktree(const char *refname)
+{
+	const char *path = NULL;
+
+	prepare_checked_out_branches();
+	for (size_t i = 0; i < checked_out_branches_nr; i++) {
+		if (checked_out_branches[i].kind != BRANCH_CHECKOUT_KIND_UPDATE_REF &&
+		    !strcmp(refname, checked_out_branches[i].refname))
+			path = checked_out_branches[i].path;
+	}
+	return path;
+}
+
 const char *branch_bisecting(const char *refname)
 {
 	prepare_checked_out_branches();
diff --git a/branch.h b/branch.h
index 95b2431f24..60cb92a3e4 100644
--- a/branch.h
+++ b/branch.h
@@ -106,6 +106,15 @@ void create_branches_recursively(struct repository *r, const char *name,
  */
 const char *branch_checked_out(const char *refname);
 
+/*
+ * If a worktree has the branch 'refname' checked out, or is rebasing or
+ * bisecting it, return the path of that worktree, or of the last one if
+ * there are more. Otherwise return NULL. Unlike branch_checked_out(),
+ * this ignores the branches that "git rebase --update-refs" will
+ * update, because no worktree has them checked out.
+ */
+const char *branch_checked_out_worktree(const char *refname);
+
 /*
  * If the branch at 'refname' is currently used for bisecting in a
  * worktree, then return the path to that worktree.
diff --git a/ref-filter.c b/ref-filter.c
index bdf54f6f59..b636e56199 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2,6 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "branch.h"
 #include "environment.h"
 #include "gettext.h"
 #include "config.h"
@@ -95,30 +96,6 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
-struct ref_to_worktree_entry {
-	struct hashmap_entry ent;
-	struct worktree *wt; /* key is wt->head_ref */
-};
-
-static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
-				      const struct hashmap_entry *eptr,
-				      const struct hashmap_entry *kptr,
-				      const void *keydata_aka_refname)
-{
-	const struct ref_to_worktree_entry *e, *k;
-
-	e = container_of(eptr, const struct ref_to_worktree_entry, ent);
-	k = container_of(kptr, const struct ref_to_worktree_entry, ent);
-
-	return strcmp(e->wt->head_ref,
-		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
-}
-
-static struct ref_to_worktree_map {
-	struct hashmap map;
-	struct worktree **worktrees;
-} ref_to_worktree_map;
-
 /*
  * The enum atom_type is used as the index of valid_atom array.
  * In the atom parsing stage, it will be passed to used_atom.atom_type
@@ -2380,49 +2357,11 @@ static int get_object(struct ref_array_item *ref, int deref,
 	return ret;
 }
 
-static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
-{
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
-		if (worktrees[i]->head_ref) {
-			struct ref_to_worktree_entry *entry;
-			entry = xmalloc(sizeof(*entry));
-			entry->wt = worktrees[i];
-			hashmap_entry_init(&entry->ent,
-					strhash(worktrees[i]->head_ref));
-
-			hashmap_add(map, &entry->ent);
-		}
-	}
-}
-
-static void lazy_init_worktree_map(void)
-{
-	if (ref_to_worktree_map.worktrees)
-		return;
-
-	ref_to_worktree_map.worktrees = get_worktrees(the_repository);
-	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
-	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
-}
-
 static char *get_worktree_path(const struct ref_array_item *ref)
 {
-	struct hashmap_entry entry, *e;
-	struct ref_to_worktree_entry *lookup_result;
+	const char *path = branch_checked_out_worktree(ref->refname);
 
-	lazy_init_worktree_map();
-
-	hashmap_entry_init(&entry, strhash(ref->refname));
-	e = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
-
-	if (!e)
-		return xstrdup("");
-
-	lookup_result = container_of(e, struct ref_to_worktree_entry, ent);
-
-	return xstrdup(lookup_result->wt->path);
+	return xstrdup(path ? path : "");
 }
 
 /*
@@ -3195,13 +3134,6 @@ void ref_array_clear(struct ref_array *array)
 	FREE_AND_NULL(used_atom);
 	used_atom_cnt = 0;
 
-	if (ref_to_worktree_map.worktrees) {
-		hashmap_clear_and_free(&(ref_to_worktree_map.map),
-					struct ref_to_worktree_entry, ent);
-		free_worktrees(ref_to_worktree_map.worktrees);
-		ref_to_worktree_map.worktrees = NULL;
-	}
-
 	FREE_AND_NULL(array->counts);
 }
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 7c44186341..debfac5f26 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -442,6 +442,35 @@ test_expect_success 'worktree colors correct' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branch being rebased in a worktree is marked' '
+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
+	git worktree add -b rebasing rebase_dir branch-two &&
+	(
+		cd rebase_dir &&
+		git commit --allow-empty -m rebase-me &&
+		test_must_fail git rebase -f -x false HEAD~1 &&
+		test_must_fail git symbolic-ref -q HEAD
+	) &&
+	git branch --list rebasing >actual &&
+	echo "+ rebasing" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'branch being bisected in a worktree is marked' '
+	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
+	git worktree add -b bisecting bisect_dir branch-two &&
+	(
+		cd bisect_dir &&
+		git commit --allow-empty -m bisect-one &&
+		git commit --allow-empty -m bisect-two &&
+		git bisect start HEAD HEAD~2 &&
+		test_must_fail git symbolic-ref -q HEAD
+	) &&
+	git branch --list bisecting >actual &&
+	echo "+ bisecting" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>main<RESET>" >expect.color &&
 	echo "main" >expect.bare &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..317ed6f6cd 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -3,6 +3,7 @@
 test_description='test for-each-refs usage of ref-filter APIs'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
 test_expect_success 'setup some history and refs' '
@@ -541,6 +542,81 @@ test_expect_success 'validate worktree atom' '
 	test_cmp expect actual
 '
 
+test_expect_success 'worktree atom names a worktree rebasing the branch' '
+	test_when_finished "git -C rebasing rebase --abort; rm -rf rebasing; git worktree prune; git branch -D rebasing" &&
+	git worktree add -b rebasing rebasing main &&
+	git -C rebasing commit --allow-empty -m rebase-me &&
+	test_must_fail git -C rebasing rebase -f -x false main &&
+	test_must_fail git -C rebasing symbolic-ref -q HEAD &&
+	echo "$(pwd)/rebasing" >expect &&
+	git for-each-ref --format="%(worktreepath)" refs/heads/rebasing >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'worktree atom names a worktree bisecting the branch' '
+	test_when_finished "git -C bisecting bisect reset; rm -rf bisecting; git worktree prune; git branch -D bisecting" &&
+	git worktree add -b bisecting bisecting main &&
+	git -C bisecting commit --allow-empty -m bisect-one &&
+	git -C bisecting commit --allow-empty -m bisect-two &&
+	git -C bisecting bisect start HEAD main &&
+	test_must_fail git -C bisecting symbolic-ref -q HEAD &&
+	echo "$(pwd)/bisecting" >expect &&
+	git for-each-ref --format="%(worktreepath)" refs/heads/bisecting >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'worktree atom with an interactive rebase stopped at edit' '
+	test_when_finished "git -C editing rebase --abort; rm -rf editing; git worktree prune; git branch -D editing" &&
+	git worktree add -b editing editing main &&
+	git -C editing commit --allow-empty -m edit-me &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1" git -C editing rebase -i --keep-empty HEAD~1
+	) &&
+	test_must_fail git -C editing symbolic-ref -q HEAD &&
+	echo "$(pwd)/editing" >expect &&
+	git for-each-ref --format="%(worktreepath)" refs/heads/editing >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'worktree atom ignores branches rebase --update-refs will move' '
+	test_when_finished "git -C updating rebase --abort; rm -rf updating; git worktree prune; git branch -D updating mid" &&
+	git worktree add -b updating updating main &&
+	git -C updating commit --allow-empty -m one &&
+	git -C updating branch mid &&
+	git -C updating commit --allow-empty -m two &&
+	test_must_fail git -C updating rebase -f --update-refs -x false main &&
+	git for-each-ref --format="%(refname:short) [%(worktreepath)]" \
+		refs/heads/updating refs/heads/mid >actual &&
+	cat >expect <<-EOF &&
+	mid []
+	updating [$(pwd)/updating]
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'worktree atom ignores a rebase of a detached HEAD' '
+	test_when_finished "git -C detached-rebase rebase --abort; rm -rf detached-rebase; git worktree prune" &&
+	git worktree add --detach detached-rebase main &&
+	git -C detached-rebase commit --allow-empty -m detached &&
+	test_must_fail git -C detached-rebase rebase -f -x false main &&
+	git for-each-ref --format="%(worktreepath)" refs/heads/ >actual &&
+	test_grep ! detached-rebase actual
+'
+
+test_expect_success 'worktree atom ignores the HEAD of a bare repository' '
+	test_when_finished "rm -rf bare.git bare-wt" &&
+	git clone --bare . bare.git &&
+	git -C bare.git symbolic-ref HEAD refs/heads/main &&
+	git -C bare.git worktree add --detach ../bare-wt main &&
+	git -C bare.git for-each-ref --format="%(worktreepath)" refs/heads/main >actual &&
+	echo >expect &&
+	test_cmp expect actual &&
+	git -C bare-wt branch --list main >actual &&
+	echo "  main" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'start after with empty value' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
-- 
2.56.0

