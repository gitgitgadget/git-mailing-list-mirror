Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003635;
	b=0vIIudozeGwZhemVxCCLadcEbguVMHXRkYnWo4aRAC/Lyis+6u5yTVVVlsz/w8DMPRGi
	 u2wH+0AZ1Glh0crxhwgjaNxLA/vOcu+mjVZVyS/wMnOiCAu/i3jAqIJXPrQU8a9r8jUps
	 t93t5ZsDWcWIrFZ2K9gIlX0KbBMxqWS3HZvoj1Zci5yv8891g4sVAy0sARa7lqj3ZOQcP
	 tsk4B+vobzlwg5WBNpdM4zuICUKTCVE27bz0PoIrcsgM6FDH+w5eyDuSGRDQuE12sW4gW
	 ipYbKH8qbGuelDcXK7/Zq+5u3obi2ZwLNy92VluK5E6V3yuyx/MdZ5ORaF+b4c21lug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LnWP6sIJx9Qr4679FX7YfRtmZ2CzBN5cQJxRGkyLB4k=;
	b=Lx+/B/ZLdsPeeS3FuRHO4vgf5zGMzUv17BNf2Hdtvd8pXJ9f4qpiTr4d5clOBM5+viRz
	 rtxzmZDhdV+DtkoyR4TVf1hMixYGWSeiqmx++ynk+I19R2VVJIK1XvseJ0ICGcHFS0veB
	 XPo9jhdcP5astlqRgEMMsj7Ffr2V0Rkc5kdv+pZRaNW+5SW8ssk6xseZeMAdzArpZG9vs
	 g9PPJ1taN62db5eRHRcLKEEGEchvdHbBkBZYd1EXshx/aulgr6GH9+qh0R1jRtTpk0Q5G
	 TnXvpof3VIkhJDbkNd+9YjNFfF7jHXUbcvyVsraMSVNP0BgF60q1Bg3qGglvSjChUJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DiNyShxU;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB5606A322
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FB5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DiNyShxU
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5378b281aso18382995ad.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003634; x=1793608434; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LnWP6sIJx9Qr4679FX7YfRtmZ2CzBN5cQJxRGkyLB4k=;
        b=DiNyShxU/cg2hVIhtpOSrbr2Gll27fLcch3Uawgw0gL01bmaZbVU1r0lxqXFzn7v+O
         XM6yh3dInHy7SQA0NqGYl3ucUkWSYH4fQW6ep84tOaeT5Z4rnWDisX1Nm0FMSIdE5N9i
         iZhXK/xXVKwwEJYVYQoCiebs5r8mCzUySrWb62pfiF5yyEMvxlHsNVBOH9dVBCxCYAfs
         Pvgt7T4ZOnre0R2BvOXhKr4gNOjq4H0S2zM2mXoGE8BQbCehLVVVM2oUHkmzHnARrN0A
         BDRvExDodCpGi92D+pJT2czGYk72DWEyT9tw6SVtKYZNx5UOeT9zNV5fNetd/CqKXgjV
         3eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003634; x=1793608434;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnWP6sIJx9Qr4679FX7YfRtmZ2CzBN5cQJxRGkyLB4k=;
        b=ZYp1Pi3KGI+DXnXIAOcsRyBV9uWCTaESf/+02Awe1R1rJWIkG3ZeXk+DjrdrTQazgj
         Qtjli1F9t65KaIDFOGngTewFRoiEJ7qH92aFV3/Ifr0aYPG/XOwCy6hqMDsIyqvnud77
         f/5WqMiRo5h+J2xWUmrIV92P+rnYQlWmv9GqKWhaNnMyQgSv4mCPMmtIRalX4/veAz6j
         EHe0uZIOeKTbZJx4RlNIvqcfwTCd1V3ZzYpq9vXHNy5JVeb1Ty4eLXHeTTWqBB7vBlzw
         /O29mSj5YoUe0TccU0P3q61FIb5THtjzYoqRRBdDOT9eUod6Cb1ST8If3k2fJuWJ+98m
         e7NA==
X-Gm-Message-State: AFq9FYL2dEaKTceX261dq0J3AUoR5PW7H95HUTQ0xxX4qV73RssgAmtE
	vPF1ZkH2xBE8lmHJyGaLYrzfA1M2wIjqbaMecZEJCbGoZuJkXDphDwznKp959j0F
X-Gm-Gg: AYBFou3VVsQGiO2sk3gnHc3z9j5H++1MNHOzKy/rO8Ku3XnKzSkd0wupbLRRpCMnnRm
	hwsudd1XTBhABSzbfMY1hD4S5EZGALzVlwpctTQyZHodZEjZouYLdagX/pmO3HwBwNVqBzqEaDt
	D6U6OsYyxoNWp/E2pTwYOls/uQNMCgdgw8B4RUDKXdZ8vBUgMFYTA8FzIkzeiqZcoFGfM7sZ1Ju
	56K7iZhW+PGPh29ymwbUJu8agUCOYIiIV8UDMM3vq8zvGiG6DQaBAi5iWDXfXdoS83A6+mR+ScZ
	p08/DfERd18fuVmVknHLjyutx0aCxlokyB7/sxtKc+p89CYfKjat2zzE6URHj95ugWP/elI9L3w
	T9jH6rhf8NblkL7MKgK0whgsTNCAjjy92NJjy1Th9eAoNQjv3j1Cssn1Cq6BOKX9GyqU7h4bfLB
	SwBJj9QMWPOvycEqmyyt5L/XKGiEAPaqRJW5yVUoL7e9G9QD8flGnQYPdg8v4jYlXz+MjZRX3CB
	I39+zF889Ukleav/MGnUeZlrIsRp/uJWi9UhFZnnDe0CerCGgtYLu0/nxFZ
X-Received: by 2002:a17:90b:5647:b0:3a5:1b:34a5 with SMTP id 98e67ed59e1d1-3adeafcf067mr5132121a91.49.1793003634335;
        Mon, 26 Oct 2026 01:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.211.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bf7cbsm7561927a91.16.2026.10.26.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:33:53 -0700 (PDT)
Message-Id: <19a9630c138500091fdec104dbd77f4e1fc48cd7.1793003627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 08:33:47 +0000
Subject: [PATCH v4 4/4] branch: let --delete-integrated find branches merged
 onto changed files
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch that upstream integrated with

    git merge --squash topic
    git commit

after upstream had also changed the files the branch touches is still
kept by "git branch --delete-integrated". The squash commit has neither
the branch's version of those files nor the fork point's, so the
previous check cannot see that the work landed. This happens all the
time on hosting services, where the "Squash and merge" button on GitHub
lands pull requests this way while the main branch keeps moving. A
rebase merge onto such changes looks the same.

For each such file, merge the branch's version into the upstream one
and treat the change as landed when that leaves the upstream version
unchanged. This has to read the files, so in a partial clone it may
download blobs.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 13 ++++---
 builtin/branch.c              | 71 ++++++++++++++++++++++++++++++-----
 t/t3200-branch.sh             | 42 +++++++++++++++++++++
 3 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 6be28c8a4e..489a9d5fd0 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -240,11 +240,14 @@ remove it anyway.
 	Like `--delete-merged`, but also delete a branch whose changes
 	the upstream already has even though its commits are not there,
 	as happens after a squash or rebase merge. Such a branch is
-	deleted when some upstream commit since the fork point has its
-	version of every file it changed, even if those changes were
-	later reverted, and the message names the first such commit.
-	It does not matter who made that commit. The same rules for
-	which branches are kept apply as for `--delete-merged`.
+	deleted when some upstream commit since the fork point has all
+	of its changes, even if they were later reverted, and the
+	message names the first such commit. It does not matter who made
+	that commit. A file counts when the commit has the branch's
+	version of it, or when merging the branch's version into the
+	commit's leaves it unchanged, which reads the file and may
+	download blobs in a partial clone. The same rules for which
+	branches are kept apply as for `--delete-merged`.
 
 `--dry-run`::
 	With `--delete-merged` or `--delete-integrated`, print which
diff --git a/builtin/branch.c b/builtin/branch.c
index ba04d8c486..c2343f3164 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -33,8 +33,10 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hex.h"
+#include "merge-ll.h"
 #include "revision.h"
 #include "tree-walk.h"
+#include "xdiff-interface.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -851,10 +853,17 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+enum change_state {
+	CHANGE_MISSING,
+	CHANGE_LANDED,
+	CHANGE_NEEDS_MERGE,
+};
+
 struct branch_change {
 	char *path;
-	struct object_id branch_oid;
+	struct object_id base_oid, branch_oid, upstream_oid;
 	unsigned short branch_mode;
+	enum change_state state;
 };
 
 struct landing_search {
@@ -886,6 +895,8 @@ static void collect_branch_changes(struct landing_search *search,
 			   search->changes_alloc);
 		change = &search->changes[search->changes_nr++];
 		change->path = xstrdup(p->two->path);
+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
+		       &p->one->oid : null_oid(the_hash_algo));
 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
 		       &p->two->oid : null_oid(the_hash_algo));
 		change->branch_mode = p->two->mode;
@@ -893,25 +904,65 @@ static void collect_branch_changes(struct landing_search *search,
 	diff_flush(&opt);
 }
 
-static int change_landed(const struct branch_change *change,
-			 struct commit *commit)
+static int merge_keeps_upstream(const struct branch_change *change)
+{
+	mmfile_t base, upstream, branch;
+	mmfile_t result = { 0 };
+	int ret;
+
+	read_mmblob(&base, the_repository->objects, &change->base_oid);
+	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
+	ret = ll_merge(&result, change->path, &base, "base",
+		       &upstream, "upstream", &branch, "branch",
+		       the_repository->index, NULL) == LL_MERGE_OK &&
+	      result.size == upstream.size &&
+	      !memcmp(result.ptr, upstream.ptr, upstream.size);
+
+	free(base.ptr);
+	free(upstream.ptr);
+	free(branch.ptr);
+	free(result.ptr);
+	return ret;
+}
+
+static enum change_state change_state_at(struct branch_change *change,
+					 struct commit *commit)
 {
-	struct object_id oid;
 	unsigned short mode;
 
 	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
-			   change->path, &oid, &mode))
-		return is_null_oid(&change->branch_oid);
-	return oideq(&oid, &change->branch_oid) &&
-	       mode == change->branch_mode;
+			   change->path, &change->upstream_oid, &mode))
+		return is_null_oid(&change->branch_oid) ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (oideq(&change->upstream_oid, &change->branch_oid))
+		return mode == change->branch_mode ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (is_null_oid(&change->base_oid) ||
+	    is_null_oid(&change->branch_oid) ||
+	    oideq(&change->upstream_oid, &change->base_oid) ||
+	    mode != change->branch_mode || !S_ISREG(mode))
+		return CHANGE_MISSING;
+	return CHANGE_NEEDS_MERGE;
 }
 
 static int changes_landed(struct landing_search *search,
 			  struct commit *commit)
 {
-	for (size_t i = 0; i < search->changes_nr; i++)
-		if (!change_landed(&search->changes[i], commit))
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		change->state = change_state_at(change, commit);
+		if (change->state == CHANGE_MISSING)
 			return 0;
+	}
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		if (change->state == CHANGE_NEEDS_MERGE &&
+		    !merge_keeps_upstream(change))
+			return 0;
+	}
 	return 1;
 }
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 64dc4c7561..ecded6085b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2122,6 +2122,48 @@ test_expect_success '--delete-integrated deletes a squash merged branch that was
 	)
 '
 
+test_expect_success '--delete-integrated deletes a squash merged branch after upstream changed the same file' '
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
+		git add shared &&
+		git commit -m "add shared" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b edits-shared --track origin/next &&
+		test_write_lines 1 two 3 4 5 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 2" &&
+		git push origin edits-shared &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 5" &&
+		git checkout main
+	) &&
+	squash_merge_upstream edits-shared &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short edits-shared) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
-- 
gitgitgadget
