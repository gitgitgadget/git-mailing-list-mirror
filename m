Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409142B324
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711673; cv=none; b=bEHn4inx4Dn2i1qCYOnlBMrDKn/rnM8rOfwLHqb0m8OuUxpGU8uDtqXKXEiNB8xIV4tr/S/4A6huDHg4pa8gEHvUlNBVWQ6GbSQJyinufstevWnWEbu7DzsClzVF6YcHUl324tG+5V3JARyZqm8X0ilSENrqGMYZ0tmTD55ga+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711673; c=relaxed/simple;
	bh=CA6mjxGbOmi/OAaPBKjJqokRCRz88a4b3ZMPKVX3bsg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fqLxfIIbbOh5E2EtDm6Pc9+KYFggPOA87AUSZ6iSoOt5O24OTNoVoduAMii4bNfmobAw+WVjdQcmXgeYuBkdwsKF8cNhddmNNk6+7DTAu0kr1OFkceVuzQuj9ni08C/p975H6SEpjKlTU4SZMyHGl3UDj1/QtGMYdkeo8nj+gqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGp6Jl5i; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGp6Jl5i"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533930955a4so10897791cf.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791711671; x=1792316471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V52Y5bm5kJTy4NUTw9OEsZ25xrCOI1qbu0X7P19fGak=;
        b=jGp6Jl5iYGvRJCqjogdXCE2Q8yaolE1HyL4fLdnaRWsfJym2wJUFoNaE7ZOWRshNRK
         sU1mxrye466jm8ujBzqfWXrkR0uTb3wZx35i4oqeXpUUfC7LXxeDM8R6NLMw2QgfMk9c
         C4iZGsCZLdhfuX+KTqNC/amdVWoWvIjfmDCEcVE+p744g7stUqySjGK0E5ZlKy6WvfVV
         GV2+CBM2/SLiT1gvkndusbTmEVhb9Vgomw14SkZGD2zwUMDCwUWtfivo9n+iNGT7hQY6
         /ZFNOk/oJbPsG7qfRhNpFywiWwEyIVzxW2hYeYF2Z8aEZOQNsHX2mea2E0wiK2f11/7Z
         gNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791711671; x=1792316471;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V52Y5bm5kJTy4NUTw9OEsZ25xrCOI1qbu0X7P19fGak=;
        b=gR6TiADINymSzV4N3LXVmOI+w4yzp7NA9dZB1tMJUPlh4KUr1m56RqrxqU23+DSjek
         tC0MFHXYpr+wirNJqqwToVd8pqNqLEe3p3Y9weozJeb0OzS/RqcF2mBkeY30WkRqvWpv
         sRIjiIxa2Cmk0qoFaafZovhPEVpVQX2EyO/733uasuV47g3jMvLRM1G3RyenierV4ttx
         61xgm3Eg3RiLaaqQczGejEsFgR08sENp4HPyz8REIQOLzVqqz1m7j93MSOjMOLnLQ4nP
         zdRie9yaqx+zbv+GJuQJdrDa8CpaNt5l0lLJ6rvJVGjTX0QL/lvzMsOw4EARLIU9t2Gn
         2wpg==
X-Gm-Message-State: AFq9FYKi7Vd5+O/q9AjPFgkkHSfbXrPKpRtA0h81I+Bo4TrOl2gjUGEi
	ERe3/KcHsUuSDl6xHKMlzl9pWJAlnvr0eDp51P2t9CZjjUBOKzwzgRxlKd6Sz//MkAE=
X-Gm-Gg: AYBFou2gbuEiucM4HbAMj5fOpsTuKfrySP9DZTo99gqHYOv5ZOcg+PHiqDj2FlijAWf
	Vd9NWF+Ep/gXsx9oJsqS0RURKrY56vEvvTJBDwlu+wyh6JYksh0RZ84mDR2lbFsx0+iqdHnhwBE
	LvlJjTWpLivDt2YOVgtRp6fN5eGiXmVOkaxcVhkBeXl9AD+AMYa1SCX8FLPJ/nPRZKuxxKh+1oa
	eUJMpDPfPaMma3RcEXcMmMVn/hszIoPV192UWufyiSNYX9l/norDfttkdngMqdgNhZG2tXCz6zf
	TNR7ztf8LSfjAOQRVVYsSUZOnUQvGPbOURkNq5UU8cMRu9y9WoJBbYk77BaKA9ypXS5PpWqcTqX
	YASfEgZPwq061gC5lR1lBkyIKiGYzZuwgd3Fr4hz+2k8JIAlP+aeTqLrkqf3Bb2i2nK3y+yqnkF
	oT3tmdFOgWzkganY7o4wZ/LvoHU8pEEXe27ZuvfYsTT9ssG+M3pR0PA1gC04X6RidzHrvLsS+md
	2Q=
X-Received: by 2002:a05:622a:5148:b0:532:c82e:7481 with SMTP id d75a77b69052e-5359fba605fmr102468821cf.51.1791711670594;
        Sun, 11 Oct 2026 02:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.108.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ddf7csm66467036d6.42.2026.10.11.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 02:41:10 -0700 (PDT)
Message-Id: <ec88bde25273700c70a547593ac8f68046218408.1791711665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 09:41:05 +0000
Subject: [PATCH v2 2/2] branch: add --no-squashed to skip the squash search
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Finding branches that were squash or rebase merged makes "git branch
--delete-merged" slower, and in a partial clone it may have to
download blobs. Users who do not need it have no way to skip that
search.

Add --no-squashed, which only deletes branches whose tip is reachable
from their upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 +++++++-
 builtin/branch.c              | 12 ++++++++++--
 t/t3200-branch.sh             | 27 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 0427324de1..90960384c4 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
+git branch [--dry-run] [--no-squashed] (--delete-merged <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
 -----------
@@ -244,6 +244,12 @@ remove it anyway.
 	sanity-checking a wide pattern like `'origin/*'` before
 	committing to the deletion.
 
+`--no-squashed`::
+	With `--delete-merged`, only delete branches whose tip is
+	reachable from their upstream. This skips the search for
+	branches that were squash or rebase merged, which takes longer
+	and may have to download blobs in a partial clone.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 513c39763b..96f10a7546 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -209,6 +209,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 	DELETE_BRANCH_DRY_RUN = (1 << 4),
+	DELETE_BRANCH_NO_SQUASHED = (1 << 5),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -1149,7 +1150,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
 			struct commit *upstream = lookup_commit_reference_by_name(
 				upstream_refname);
 
-			if (!rev || !upstream)
+			if ((flags & DELETE_BRANCH_NO_SQUASHED) ||
+			    !rev || !upstream)
 				continue;
 			ALLOC_GROW(searches, searches_nr + 1, searches_alloc);
 			searches[searches_nr++] = (struct landing_search) {
@@ -1272,6 +1274,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	struct strvec delete_merged = STRVEC_INIT;
 	int dry_run = 0;
+	int no_squashed = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1330,6 +1333,8 @@ int cmd_branch(int argc,
 			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			N_("with --delete-merged, only print which branches would be deleted")),
+		OPT_BOOL(0, "no-squashed", &no_squashed,
+			N_("with --delete-merged, skip the search for squash merged branches")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1394,6 +1399,8 @@ int cmd_branch(int argc,
 
 	if (dry_run && !delete_merged.nr)
 		die(_("--dry-run requires --delete-merged"));
+	if (no_squashed && !delete_merged.nr)
+		die(_("--no-squashed requires --delete-merged"));
 
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
@@ -1436,7 +1443,8 @@ int cmd_branch(int argc,
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
 					     (quiet ? DELETE_BRANCH_QUIET : 0) |
-					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0) |
+					     (no_squashed ? DELETE_BRANCH_NO_SQUASHED : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index adf1bc2233..70a38663f1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2095,6 +2095,28 @@ test_expect_success '--delete-merged deletes a squash merged branch after upstre
 	)
 '
 
+test_expect_success '--delete-merged --no-squashed deletes only reachable branches' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch merged &&
+	push_topic squash-merged squash-merged-work &&
+	squash_merge_upstream squash-merged &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short merged) &&
+
+		git branch --delete-merged origin/next --no-squashed \
+			>actual 2>&1 &&
+		echo "Deleted branch merged (was $sha)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		squash-merged
+		EOF
+	)
+'
+
 test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
@@ -2316,6 +2338,11 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
+test_expect_success '--no-squashed without --delete-merged is rejected' '
+	test_must_fail git -C forked branch --no-squashed 2>err &&
+	test_grep "requires --delete-merged" err
+'
+
 test_expect_success '--dry-run without --delete-merged is rejected' '
 	test_must_fail git -C forked branch --dry-run 2>err &&
 	test_grep "requires --delete-merged" err
-- 
gitgitgadget
