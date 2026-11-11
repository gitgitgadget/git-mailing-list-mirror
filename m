Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410904;
	b=CA97Cos6b+m3Z1P2I7gScg3fmqyUANKBhHLn7XosB8Udyvnpo0/ZFHqDgH9nEiiayQZn
	 8+Mdpa7zZrHiEUuxz4Qg+d58X+EsVBthE1U+4/mwBqVcBUqbXQKxawvIUhoE86XeYACgU
	 +TViyqyTHOhgQkE1LFXSsA0b+b1/R9bkrwBobrdsiu9QopBeqnbe1jsmHvCy2NaVPtxBP
	 PhkVYk7H8i3pjFizKxk27jE/1dqzZx81ztiiI2rFs5gLhbKlbtutMg7G7kRD+LHrVPM2d
	 zKb5ao+SmTdCOCTo930umw/j6cUJ7LNHQwJX3e298chQ95Hf9iVJEzHJpQJ5KB9o36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AKjRVuoJPOU5XADtXCsWVv3KPJ04+k/JpK8jrsuAPtU=;
	b=OSoBfGliDI/nxmS6LKRPn5z5swU2HuXkZgf+VO6xVSUT/5hnfoHdVynyKyDayd7RRaS4
	 q1ZCDRQY44HXh24ZWrVof3mxtBCPbL9chZqwahLgB83WpVhHOZGeaAp0uEJOluhSjZGT0
	 grSSiJiPWoLh5tMlWaQoWuPDporJwmOPTufL3SDtFub6ykbWVkGdLHTiBG6ApKl6KDCc3
	 0jZ3FeS6AkNv5x3Kr7urL51T1kxdHaOmDOpBFl/SnqzC3hdrLfpKGybW2o/38YV0UAcls
	 z6vgN+RMRFplk87ltf0miMdlaQmak4kFsM8TAgAj5lnjcZCpY5LHuumMpFzuePpCv7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=ToqbX5pq;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C3606A890
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913C3606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=ToqbX5pq
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9906870a9baso1425073241.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410902; x=1795015702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKjRVuoJPOU5XADtXCsWVv3KPJ04+k/JpK8jrsuAPtU=;
        b=ToqbX5pqJczLyj0iF5tdpdLoIP/KZOB8katGdrOT6vnztojxbUm7Fabk0T7BmDwpfx
         96cipwgYrY+PvivV3LApmXovpoa/aMgHcIX8wrG+9KkMs7GZ3sz/MI4R751jAqhHiq8/
         1xnxuoXN7OE6GNCQQWjRfF0LA8SDzMt1bPz+mDHol1PqmjWC0BsUbizWOWKh7D1P6PHX
         VrnOPNkr87Ta8KbZQm9+dWLKW+NO11fT65oYR5zXuiKxKBuUdpYVAZ2NtPadPAICuUPV
         jPEKVAshzkSwpk70G62QPjyhP7SBGQlhGSGFP8oWYiX03ZY7ju6+RFzgf/7UuCSKspVI
         hO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410902; x=1795015702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AKjRVuoJPOU5XADtXCsWVv3KPJ04+k/JpK8jrsuAPtU=;
        b=f1Yk7alUAOF+t9AnWFjYCrkLb8oODkhA6d3xRpWgVTn1zpRGq7vFBkB1VA0rWKUW0d
         bskqR8r8178SG8Z7Z1tbwBPZafmVDAHEwthH1Vy9ojOuHdzkCYva6Ntnxg9h/2Vyyd7o
         O3umWfGeLk0xmDeb3RqhyDZ7T4/aWTCZwjEFEVqEm8RaLoaaw+4Q6ps0hMKAenIVgyjW
         2mwVZ7+APTgYT3m9/sjT6UmMfLr95TyeRMOr8f4R0TUCNbsFbto71zTV9Z4GuE73u1UD
         fqms0Zt/JMvhL3wpLSuI1S6dzxDTQPAm+UA4tx3TwYx8I85aJg4tmcPbF6XH2hZq2X6F
         cGSw==
X-Gm-Message-State: APuU4Z80amPCn6cig8eDW8BNVl+vMDI7dRyITGCPG/k9DpnTuI/YxhoJ
	9Ffd3C8+UavEVS+V7pxhS6o5lqeL+V6sbg1+NxKe2+BPsCv4ZiXOSSkPdvV7eNVS76oWBDeOKQO
	4zjOK3yZdDxd4Q9Kf0B73z95umd1XDsDbs3k5IOxichSGyOpyhlsVA+ntfSiSpUYUvAzjFAkhl+
	5GSL1UtPahxe6HB2ElC2FCKzgzV34R1osuX3rDd1b03sTW+BBx6reAByYVOjnG/8z72hte/geNG
	4hRSk0g0+/4J1vlDMYD+3K1OsLS7Bxhw+zbO2QlQpc=
X-Gm-Gg: AYBFou3pTFRUJWxFqchpyLR41VjhvKx8tfZX57qLoLpQPrIQ12IeVp/aaNq6dTAgquV
	i39ZRycCbyymrs5PbKKeloEzzauaXrp8GQhhZnmNd2k1EU2SC9/2gZtFwUj2xIzkwMn9xyj2bFH
	2SMs5di6mmL3NCv8dwELfpsNQX+FcMxJ5BbWZP7VCK/EAUmnH/salCGabAaTu15wrxIo8VQYeEi
	/Qb7DiyKEqnDG64tgYmiwpYpuMyD0yzyrTZssplOF3Qw2IodNTCFkMrZbhr3N0NyBHi8kWOkzWN
	ZFFSI9KhzBx6+5j16XLQXWjC5WzsFS1sS3JTxJlvwIrrn6Vg0UwvAlV7rfIJQjJCNVIvUxmi/MN
	Auf3ZBhseQ+QrEoXmyUzlxSw8zLoM9XuEZ8vXrElEKoNDJ5w8hHSxSzzStkOUN/24Xr4JuRJaOa
	A2QNcx4/Iq/uwaCb4rdxNoOFi206MkpUyrR/+bCCHb0MP7ZIGR+1DbjMGN3iB3z+DGGGoI7U9Ms
	69hAzgEAY+aWkVIuMoNXp33xSFNdBs26eN58sDzp3+rAcNx3UZRf73cTqY/ZMYL+FQcAymL6P0i
	doWbw0GE6l8y2PyfM9seuWDtiDGPjrvWlhYggYzNe72zmA1pTztsf9t9CClykEfykOZfXbWAGJd
	3Wx0qcegvpSQegIp913H3v7I824j+XZby04IL7qo0uUnCfvbJXPoAylq+RiFepeXXYvC1clax1e
	G659XktYnTB5aQMei0GiSc94TeX8254W8ux3BN1sYc0EzhK798IC+uyX5TBc15Lde5H69zZ0WKA
	ZXz7CMrM3y0FVXfQGT+qpVDpdiRoZcFbmerUUtwAsihTWzKiwmaMQ==
X-Received: by 2002:a05:6102:5708:b0:7c3:e156:da3c with SMTP id ada2fe7eead31-7d501be25femr1148864137.15.1794410902119;
        Wed, 11 Nov 2026 07:28:22 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm21341136d6.22.2026.11.11.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:28:21 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v5 3/5] ref-filter: name the worktree of a branch being rebased or bisected
Date: Wed, 11 Nov 2026 10:28:08 -0500
Message-ID: <20261111152811.99986-4-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111152811.99986-1-me@jaspermayone.com>
References: <20261102182930.3511-1-me@jaspermayone.com>
 <20261111152811.99986-1-me@jaspermayone.com>
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
is bisecting. Record those branches in a map as well, add
branch_checked_out_worktree() to look a branch up in it, and use that
for %(worktreepath) in place of the map that ref-filter.c builds from
the HEAD of each worktree.

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
 branch.c                            | 10 ++++
 branch.h                            |  9 ++++
 ref-filter.c                        | 74 ++--------------------------
 t/t3203-branch-output.sh            | 29 +++++++++++
 t/t6302-for-each-ref-filter.sh      | 76 +++++++++++++++++++++++++++++
 7 files changed, 135 insertions(+), 74 deletions(-)

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
index 5bb1c28915..87f3ffc35f 100644
--- a/branch.c
+++ b/branch.c
@@ -384,6 +384,8 @@ int validate_branchname(const char *name, struct strbuf *ref)
 
 static int initialized_checked_out_branches;
 static struct strmap current_checked_out_branches = STRMAP_INIT;
+/* Like current_checked_out_branches, without the "update-ref" branches. */
+static struct strmap checked_out_worktrees = STRMAP_INIT;
 
 enum branch_checkout_kind {
 	BRANCH_CHECKOUT_KIND_CHECKOUT,
@@ -416,6 +418,8 @@ static void register_checked_out_branch(const char *prefix, const char *name,
 	checked_out_branches_nr++;
 
 	strmap_put(&current_checked_out_branches, refname, path_copy);
+	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF)
+		strmap_put(&checked_out_worktrees, refname, path_copy);
 }
 
 static void prepare_checked_out_branches(void)
@@ -485,6 +489,12 @@ const char *branch_checked_out(const char *refname)
 	return strmap_get(&current_checked_out_branches, refname);
 }
 
+const char *branch_checked_out_worktree(const char *refname)
+{
+	prepare_checked_out_branches();
+	return strmap_get(&checked_out_worktrees, refname);
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

