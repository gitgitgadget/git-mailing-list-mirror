Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370112;
	b=dJ1kYgxBRsa1sWMSdsPgz2szJYf5oZn6aienDpefeMt+ZHh4sVmOi1IEDb/wneC/8C0G
	 Th9w/TQXyRSTQ3iE/e3h4shLln8s4eNthYBzf5hBfnbRny5lXf8r94q6t9ZBYyBGDCEQP
	 LYnBJDH3esLeS/DH4RL76ad2trSqFSgpnE2448O/p9v041COWwmGiODhSuEea5pvojQXH
	 btcXrGlxPFwtMX0VK9/0Vg7fhFmrI1bS53W569zi/omR4iIBuM+9TxR8xd5iTPDiyxJvW
	 pBJqCnylZdhhFLL16xeeLY7IWJk6r7T6uf5UtArXEh/ypZIpkqg3K4LmjWs4Alebatg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yGPnmubuXfL9gryM+nGNLV0mRo/amRq/s4mHU01BpSw=;
	b=Q3cyHmjqufJ2+driKQ7cYxzcvoKhfBO3M5swmlzg5mzlFw2DdWgyOpmPQKSoPO1S7mId
	 e1z+uBe+hHQeG+7RXfdqYlNtHysSKSOv8nyl5jITDZPDVwR3dHqwfPHgRjwDrZlC4jNCT
	 jSqpma43lS9WZQIMVS/cAN5ESfPXiLyxSCR1qDCXaEE/c8h9xdueHgsF4cAYvsSW6bNcy
	 m66fMCVWkymCvdBNRmt3/drAnaeXsE4ifIlO1+Fi7KLy+FKY8nXqnVEkbmKV5RtNC6E6p
	 mnFZHTyufL7zX7cWqgBJWQe1yd8fDsOidEAXUED+EjIOSrUVhdOo8M8okR9iUYOweLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=KXyuS4Ow;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466C606A324
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6466C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=KXyuS4Ow
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93ece7a73b9so94000885a.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793370111; x=1793974911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yGPnmubuXfL9gryM+nGNLV0mRo/amRq/s4mHU01BpSw=;
        b=KXyuS4Ow1FKfsLNFk1+JMOG9f1vUo7tUCj4fB5w395VoiBxoDTOOhxfCygOgmwuku/
         P7D0mVHPVDCt5eTcJNBtodBO9df/igDPYb8F/fUligIRVMOL+Azrtd2zBMK22IxlVvOv
         HgQsC2S6evurU6aZochqmULMWpTrruVnmtbql+WnkvbW7H613P0Jn6H+1e85Xcg+SGcC
         yrdwSpyMlRhJL2Cc8R9hN4wV5t+/45rqYvZ6xuy/G4g6vS0L0E2F2tSR6Hpabe20XUcj
         9nm/doEX+rRSPBj07jIxcS36pwGQBAgN+A3ZmATTyrGkT5UfDB6b1J0YhvLM6vL08RZx
         XYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370111; x=1793974911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGPnmubuXfL9gryM+nGNLV0mRo/amRq/s4mHU01BpSw=;
        b=lBA9GV6NaZYvTTcarj9VAytaCrOOGNVdHCAbwDVbEW/DOf4w+nwAKEvRI908OeeUnC
         pBr/ebmSWdpsHPqwMb9jQBCTqhBocwMio2WFrbl+DFR5YIWdAa1V/Rd+EviFvJpcAx02
         riNKKjuyzzd0Qcp3aKDpWUx7rmc1lSBP3/3Cb9CEIv7JJ+4mefz9vb8+TodHPVkN0y7h
         ODKjXfd6veHd4TNgkIRtKMZ/tN0HHi8P7WWy03viblifuWCFLAfeSDcA/GLSIowZj3FZ
         7/1f5rWcouA6fflgR32xKGTbHDwcw/TSe3kJyBdgSE0588OpUrRult9XFnIhKCJqfmAf
         s20w==
X-Gm-Message-State: AFq9FYLbJNPRWqKzlkULiPvCmzBRKIU/dsI98CnxqftXLn0hPnXP5c52
	+mUnPFuoMtfV5gotPzpzehpF0rX7vmgp1LbYIKijNzvpg6jvVKkjqMV9QBU7IGrpCa23Az7JGwm
	DTR3ahb6BmdUS9Km83zYFMd0fmHqWzxCaoD4H+LW5MAHSrOeQ0MTToen8ppf1mL0QOeaWrsJoZb
	1bBgFEYweEtVaKQnPHDnUlolReURN35Bz8jBTwyDaS6Ml2WCSNsMtOaE4vhvq2XgJlOFTn49Spz
	p3xk1f7G20IU41qb57lr0m/bxmngcxxEpTMU8P+Qio=
X-Gm-Gg: AYBFou01wnf6zSKpBOKjHBEY4v/+118XovvoP/b5hlm0FzADxONJi1jxfCZrM94sYUj
	lotW03qwnn5E8J2/4a5zVnNrRC6aoGmmye8SuSNQsOZJp9oRgvTYEGjA7aXUt6bTe/+/xGOYJgW
	BpZCb/Q92oQEMMUnx6p9b1vRAvgY3qxvYAKZuoQg9EXM3rZsAxiVQFbZaS5pOfvxgZQHAt7eM1y
	cd8qIkmd+o/iGW0I5QTWhi2ND5wVKQS5GC86kQkdgX7sk76XYwtu1VSBYByf08NJY7Ozb2o2DrQ
	8xvDeljL9QinNoWVGIbzc8HCWb7eWB63ciDBYRpXlfYOAW0qMOWiPovyD1K+OHN2FA9io9tnJeA
	rHDwjeTlDq5DGJNESJZfxqb/3dcP6VNAan77g1fkXHwKjNpVib8Nfv6VUqyWYP/vzEx0AJeq5Cg
	qccZZB4w+QvUz8mvqOJyNP2oDKj+yMLp5EZc6Z9N+bueeYEBOIxyfkdePImtU4xxH+ZgaynvTBr
	BCgVd5OmzGWegt1YDM/3YDN6rbIoV7vnjyX5Z5I6knj0EHeDpqyDfEmlcKJq4CeEKr2fYQIQIyx
	+5ClDSsJuLatTg4Qm3LXvSN+Uch0Pp09CWb2WBPWihJa7WqGuof8r7MDO4xmThUYW0z1DsNEp11
	Gfu4jCvkBdrredmMPksMUpdXQ0UwMyJbt+ox+63/Bc5qVpjBTkDNYTMcc1FRr7RKuajGOjQ8IBs
	pDnUVXDgy760We4JTmwfSy593M5vJAdgHcmDB5eZxbweGxyaM2T50fQQjM0iZAxrWHkRD0SK/8n
	QImPHi2xpV+OFWPGZlzywzRg+DEjTOrDr03HwbjayigVbDMvYCx
X-Received: by 2002:a05:620a:28cb:b0:93f:35fc:5253 with SMTP id af79cd13be357-94421739824mr418064785a.31.1793370111089;
        Fri, 30 Oct 2026 07:21:51 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm153831485a.1.2026.10.30.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:21:50 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH 2/2] ref-filter: name the worktree of a branch being rebased or bisected
Date: Fri, 30 Oct 2026 10:21:37 -0400
Message-ID: <20261030142137.54750-3-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030142137.54750-1-me@jaspermayone.com>
References: <20261024165311.57387-1-me@jaspermayone.com>
 <20261030142137.54750-1-me@jaspermayone.com>
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
rebase or bisect will check it out again. "git worktree list" shows
such a worktree as "(detached HEAD)", so %(worktreepath) is the only
place a script could find out which worktree is working on the
branch.

Also map the branch that a worktree is rebasing or bisecting to that
worktree, as prepare_checked_out_branches() in branch.c does.
Branches that "rebase --update-refs" will update are not mapped: that
worktree has not checked them out, it only moves them when the rebase
is done.

As a result "git branch" marks such a branch with "+", also when it
runs in the worktree that is rebasing or bisecting it, where it shows
both "* (no branch, rebasing topic)" and "+ topic". Document that.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-branch.adoc       |  5 ++-
 Documentation/git-for-each-ref.adoc |  4 +-
 ref-filter.c                        | 60 +++++++++++++++++++++------
 t/t3203-branch-output.sh            | 35 ++++++++++++++++
 t/t6302-for-each-ref-filter.sh      | 63 +++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..d499d7e0d4 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -33,7 +33,10 @@ DESCRIPTION
 If `--list` is given, or if there are no non-option arguments, existing
 branches are listed; the current branch will be highlighted in green and
 marked with an asterisk.  Any branches checked out in linked worktrees will
-be highlighted in cyan and marked with a plus sign. Option `-r` causes the
+be highlighted in cyan and marked with a plus sign. A branch that a
+worktree is rebasing or bisecting counts as checked out there, so it is
+marked in the same way, also in the worktree that is rebasing or
+bisecting it. Option `-r` causes the
 remote-tracking branches to be listed,
 and option `-a` shows both local and remote branches.
 
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index a7b31e8aaf..90ff37259e 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -182,7 +182,9 @@ but if used together the last option is selected.
 
 `worktreepath`::
 	The absolute path to the worktree in which the ref is checked
-	out, if it is checked out in any linked worktree. Empty string
+	out, if it is checked out in any linked worktree. A branch that
+	a worktree is rebasing or bisecting counts as checked out there,
+	although that worktree's `HEAD` is detached. Empty string
 	otherwise.
 
 `ahead-behind:<commit-ish>`::
diff --git a/ref-filter.c b/ref-filter.c
index bdf54f6f59..1aebea243e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -97,7 +97,8 @@ static struct expand_data {
 
 struct ref_to_worktree_entry {
 	struct hashmap_entry ent;
-	struct worktree *wt; /* key is wt->head_ref */
+	struct worktree *wt;
+	char refname[FLEX_ARRAY]; /* the key */
 };
 
 static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
@@ -110,8 +111,8 @@ static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
 	e = container_of(eptr, const struct ref_to_worktree_entry, ent);
 	k = container_of(kptr, const struct ref_to_worktree_entry, ent);
 
-	return strcmp(e->wt->head_ref,
-		keydata_aka_refname ? keydata_aka_refname : k->wt->head_ref);
+	return strcmp(e->refname,
+		keydata_aka_refname ? keydata_aka_refname : k->refname);
 }
 
 static struct ref_to_worktree_map {
@@ -2380,21 +2381,56 @@ static int get_object(struct ref_array_item *ref, int deref,
 	return ret;
 }
 
+static void add_worktree_entry(struct hashmap *map, struct worktree *wt,
+			       const char *refname)
+{
+	struct ref_to_worktree_entry *entry;
+
+	FLEX_ALLOC_STR(entry, refname, refname);
+	entry->wt = wt;
+	hashmap_entry_init(&entry->ent, strhash(refname));
+	hashmap_add(map, &entry->ent);
+}
+
+/*
+ * Map each branch to the worktree that has it checked out. A worktree
+ * that is rebasing or bisecting a branch has it checked out, too,
+ * even though its HEAD may be detached, as for
+ * prepare_checked_out_branches() in branch.c.
+ */
 static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
 {
-	int i;
+	struct strbuf ref = STRBUF_INIT;
 
-	for (i = 0; worktrees[i]; i++) {
-		if (worktrees[i]->head_ref) {
-			struct ref_to_worktree_entry *entry;
-			entry = xmalloc(sizeof(*entry));
-			entry->wt = worktrees[i];
-			hashmap_entry_init(&entry->ent,
-					strhash(worktrees[i]->head_ref));
+	for (size_t i = 0; worktrees[i]; i++) {
+		struct worktree *wt = worktrees[i];
+		struct wt_status_state state = { 0 };
 
-			hashmap_add(map, &entry->ent);
+		if (wt->is_bare)
+			continue;
+
+		if (wt->head_ref)
+			add_worktree_entry(map, wt, wt->head_ref);
+
+		if (wt_status_check_rebase(wt, &state) &&
+		    (state.rebase_in_progress ||
+		     state.rebase_interactive_in_progress) &&
+		    state.branch) {
+			strbuf_reset(&ref);
+			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			add_worktree_entry(map, wt, ref.buf);
 		}
+		wt_status_state_free_buffers(&state);
+
+		if (wt_status_check_bisect(wt, &state) &&
+		    state.bisecting_from) {
+			strbuf_reset(&ref);
+			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
+			add_worktree_entry(map, wt, ref.buf);
+		}
+		wt_status_state_free_buffers(&state);
 	}
+	strbuf_release(&ref);
 }
 
 static void lazy_init_worktree_map(void)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 7c44186341..e04599392d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -442,6 +442,41 @@ test_expect_success 'worktree colors correct' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branch being rebased in a worktree is marked' '
+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
+	git worktree add -b rebasing rebase_dir branch-two &&
+	git -C rebase_dir commit --allow-empty -m rebase-me &&
+	test_must_fail git -C rebase_dir rebase -f -x false HEAD~1 &&
+	test_must_fail git -C rebase_dir symbolic-ref -q HEAD &&
+	git branch --list rebasing >actual &&
+	echo "+ rebasing" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'branch being rebased is marked in its own worktree' '
+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
+	git worktree add -b rebasing rebase_dir branch-two &&
+	git -C rebase_dir commit --allow-empty -m rebase-me &&
+	test_must_fail git -C rebase_dir rebase -f -x false HEAD~1 &&
+	git -C rebase_dir branch --list rebasing >actual &&
+	echo "+ rebasing" >expect &&
+	test_cmp expect actual &&
+	git -C rebase_dir branch >actual &&
+	test_grep "^\* (no branch, rebasing rebasing)" actual
+'
+
+test_expect_success 'branch being bisected in a worktree is marked' '
+	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
+	git worktree add -b bisecting bisect_dir branch-two &&
+	git -C bisect_dir commit --allow-empty -m bisect-one &&
+	git -C bisect_dir commit --allow-empty -m bisect-two &&
+	git -C bisect_dir bisect start HEAD HEAD~2 &&
+	test_must_fail git -C bisect_dir symbolic-ref -q HEAD &&
+	git branch --list bisecting >actual &&
+	echo "+ bisecting" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>main<RESET>" >expect.color &&
 	echo "main" >expect.bare &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..d656901f21 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -3,6 +3,7 @@
 test_description='test for-each-refs usage of ref-filter APIs'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
 test_expect_success 'setup some history and refs' '
@@ -541,6 +542,68 @@ test_expect_success 'validate worktree atom' '
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
 test_expect_success 'start after with empty value' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
-- 
2.56.0

