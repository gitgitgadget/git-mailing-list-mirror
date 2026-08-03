Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C937B003
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750648; cv=none; b=KxcHfggVO8wjpQwLPIDxxnOtbyCy/EODyTGp9fdhklGOzFuzDw1ed2UxrEp3R7uEx8TlFHUBN3uRbtKT9SWG/dcDlfh752oGSxo6eorv8aFPA80yw/B6oLuLXR3U4IN2p5UvsZvzuHzW1gTSATE74BWpfD0dU2w3JqOWo5NGDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750648; c=relaxed/simple;
	bh=zhsjzpKNyTVgbhgKRvXJaUmaxrWc2UdNKFxBnLO/WrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFYo+zKdzckESVLN4aq8OsH1SNxhVqnmQnCb7dv1oQ+y7ueckE40HsTZoT7+uKOXDe/k0Bw37q1yDM0jRJD5xnQS+ApdJw9Wv9p8lpAjjWYLDo+ztYz6uGMH/miFp0FxOVEEYqUgpu+eBkw4U9rLjLfF5Rh/OtKvhwXr7edsMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHDXc4AF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHDXc4AF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso8281445e9.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750644; x=1786355444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/zfuoL3664W+xQ/gZA8O+jPFXJ8i05sdGHLWUZBtW8=;
        b=aHDXc4AFULVTf5fHRzYDnR1YFaTiDXergC11A/M37EZt5eY/x7Bxnlm72HwUNdER4h
         BX138eKWKuxmOjIyvvwY3WNYuhfrD5o462hwGPEUo+tGuzvxpqtmz/rOH5y3JhHFswZu
         YMK5lXlm6E+y/oSXRSN5XL1mpcZi690VbpmYaiXd/sGafyjVmaqm6v2260zqGvn0F8Ca
         lN56QJqg2lit2JzVZjMYjpTocslpESXN5/lYssL8LeNyMLdFySm9ITRWoUtYXVPPMt5D
         gRR5BdDTrfQzEyo3gY4oC5gTD0guO6FjtE/QA84CW5gdAppc+t1OrnLKlZ32aHyDMP7s
         Ptzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750644; x=1786355444;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/zfuoL3664W+xQ/gZA8O+jPFXJ8i05sdGHLWUZBtW8=;
        b=fj0aDm0xAK94RWFZeilLmqop2WRjWNXR8p5LPJrmaubNcixulr6ufxzYu77b7PwrVd
         7mzBYxLH/2RuxZ8i/R+CBrfVIbzmcmpuZrYsSnb7YePl6Xvd10JuEdlO0NG6vmSCfkuR
         cgEKAqVelb8RF2VvQ2OSU8HrZN7HvEl/nsKqg1G+zKHEEKs8A1k6dszCAQpaEdHNteni
         6xVW4b1L+PSi1+OTtVMzKuLPVNM0r2hDy31YIgG5o/iO3Qlhh1G0ztrXq8BJ7B3JNkih
         qffUd8tjPELXVoSoLnbZ0myp+QbBgmLmQVmZZ5gJxYNa4U+NBm1xPnh1KId1jUk9u8J8
         R0Zw==
X-Gm-Message-State: AOJu0YwKRlW4aevcNFAoorIrMYdfGgAxqzUGP+pMZsyatKjUP/t7YVeh
	6pvgqmz/tRS7sM4pg9Ja5rFuliqiiEihxmNmIy17iXO+537yVcSGRXMzop29og==
X-Gm-Gg: AR+sD13jetn5EBNxBxTU00n8DhDv1wthoFkC0L2x//8/bEpYRHFFE80zTaCDzyDMC0u
	H+PkBljOwtbOtEXZ/sSqZmmFuf9PujUlDMhGIPM7UppmeS9cyOx3UmW0mos5HFMBWLqpmLRdLFz
	ZSokGpTOaDsYRQ53WW6ZPDUsAqR2d67F42Fk/yy2IQndGGKtumhYMIYB9SjQEdRttEKMndynoG7
	xrn9njxBgcIvNfvWJjQ++gcpjYGuxHILFzo+/ZCU8Gu9GX/mDg2dumvsZ8QZVIYMwpaii4lgF8F
	gL60h1qBgEqlFa8mNo4xBjWxGO2JvgLUb6aUFV1O9fKENmSnHVDZlUyo8CV3dqBv+M8hlE999DI
	Qqv/u4VCZkpHuv6ptBh3ZGPtfPOck3YNNekX7TygC/gPDZYbZuxPpC4rkCo4OGvM1dBJHenc+bZ
	taq4q7WKwoe6EV/Y21V644JNGOjLpJXJsAlYPI2dumzAXXOBr6y3rP+Y6MdDIw57wO
X-Received: by 2002:a05:600c:3506:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-4980eb8e287mr138212305e9.2.1785750644150;
        Mon, 03 Aug 2026 02:50:44 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.4/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:24 +0100
Message-ID: <9f90fd2cc691176e5dcc78b43e7493c6b11d42bb.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Reject ranges with more than one tip

Given

          C
         /
    A - B - D

then

   git history squash ^A C D

should fail because the way we squash commits assumes the range has
a single tip. While we might want to support multiple tips in the
future lets not complicate things now.

To check for multiple tips mark each commit we see as a tip and
increment a tip counter, then, iterate over the parents of each commit,
removing the mark and decrementing the counter if the mark was set. As
we have to iterate over the parents anyway, stop using "--boundary"
and check that we've seen each parent before which allows us to
produce a better error message.

Note: I'm not sure what our policy is with respect to adding new
users of object flags. If that's a problem, we could use a commit
slab instead.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/history.c         | 80 ++++++++++++++++++++++++---------------
 object.h                  |  1 +
 t/t3455-history-squash.sh | 19 ++++++++--
 3 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 4dcfdb109d..bb4a74ec1a 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1006,6 +1006,10 @@ static int cmd_history_split(int argc,
 	release_revisions(&revs);
 	return ret;
 }
+
+/*Remember to update object flag allocation in object.h */
+#define SQUASH_SEEN (1u << 11)
+#define SQUASH_TIP (1u << 12)
 
 /*
  * Resolve a "<base>..<tip>" revision range into the base commit just outside
@@ -1023,16 +1027,14 @@ static int resolve_squash_range(struct repository *repo,
 {
 	struct rev_info revs;
 	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
-	struct commit_list *boundaries = NULL, *b;
 	size_t i;
-	int ret;
+	int ret, tip_count = 0;
 
 	repo_init_revisions(repo, &revs, NULL);
 	revs.reverse = 1;
 	revs.topo_order = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.simplify_history = 0;
-	revs.boundary = 1;
 	revs.ancestry_path = 1;
 	revs.limited = 1;
 	revs.ancestry_path_implicit_bottoms = 1;
@@ -1045,7 +1047,7 @@ static int resolve_squash_range(struct repository *repo,
 
 	if (revs.reverse != 1 || revs.topo_order != 1 ||
 	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
-	    revs.simplify_history != 0 || revs.boundary != 1 ||
+	    revs.simplify_history != 0 || revs.boundary == 1 ||
 	    revs.ancestry_path != 1 || revs.limited != 1 ||
 	    revs.ancestry_path_implicit_bottoms != 1) {
 		warning(_("ignoring rev-list options that would change how the "
@@ -1054,7 +1056,7 @@ static int resolve_squash_range(struct repository *repo,
 		revs.topo_order = 1;
 		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs.simplify_history = 0;
-		revs.boundary = 1;
+		revs.boundary = 0;
 		revs.ancestry_path = 1;
 		revs.limited = 1;
 		revs.ancestry_path_implicit_bottoms = 1;
@@ -1077,59 +1079,75 @@ static int resolve_squash_range(struct repository *repo,
 		ret = error(_("error preparing revisions"));
 		goto out;
 	}
-
-	/*
-	 * Set boundary commits aside for the base check below, and put every
-	 * in-range commit but the tip into the interior set. A ref pointing
-	 * at an interior commit would dangle once the range is folded away.
-	 */
 	while ((commit = get_revision(&revs))) {
-		if (commit->object.flags & BOUNDARY) {
-			commit_list_insert(commit, &boundaries);
-			continue;
-		}
+		struct commit_list *p;
+
 		if (!commit->parents) {
 			ret = error(_("cannot squash down to root commit"));
 			goto out;
+		}
+		for (p = commit->parents; oldest && p; p = p->next) {
+			struct commit_list *q;
+			struct object *o;
+			bool seen;
+
+			if (repo_parse_commit(repo, p->item)) {
+				ret = error(_("cannot parse commit"));
+				goto out;
+			}
+			o = &p->item->object;
+			seen = o->flags & SQUASH_SEEN;
+			/*
+			 * Allow parents that match the parents of the
+			 * squashed commit.
+			 */
+			for (q = oldest->parents; !seen && q; q = q->next)
+				seen = p->item == q->item;
+			if (!seen) {
+				ret = error(_("parent %s of commit %s is "
+					      "outside the revision range"),
+					    repo_find_unique_abbrev(repo, &o->oid,
+								    DEFAULT_ABBREV),
+					    repo_find_unique_abbrev(repo, &commit->object.oid,
+								    DEFAULT_ABBREV));
+				goto out;
+			}
+			if (o->flags & SQUASH_TIP) {
+				tip_count--;
+				o->flags &= ~SQUASH_TIP;
+			}
 		}
 		if (!oldest)
 			oldest = commit;
 		if (tip)
 			oidset_insert(interior_out, &tip->object.oid);
 		tip = commit;
+		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
+		tip_count++;
 	}
-
-	if (!oldest) {
+	if (!tip_count) {
 		ret = error(_("the revision range is empty"));
 		goto out;
-	} else if (oldest == tip) {
+	} else if (tip_count != 1) {
+		  ret = error(_("the revision range contains more than one tip "
+				"commit"));
+		  goto out;
+	  } else if (oldest == tip) {
 		ret = error(_("the revision range holds a single commit; "
 			      "nothing to squash"));
 		goto out;
 	} else if (!oldest->parents) {
 		BUG("an in-range commit must have a parent");
 	}
 	base = oldest->parents->item;
-
-	/*
-	 * A boundary other than the base is an in-range commit reaching a
-	 * commit outside the range, so the range has more than one base.
-	 */
-	for (b = boundaries; b; b = b->next) {
-		if (b->item != base) {
-			ret = error(_("the revision range has more than one base; "
-				      "cannot squash"));
-			goto out;
-		}
-	}
 
 	*base_out = base;
 	*oldest_out = oldest;
 	*tip_out = tip;
 	ret = 0;
 
 out:
-	commit_list_free(boundaries);
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
 	reset_revision_walk();
 	release_revisions(&revs);
 	return ret;
diff --git a/object.h b/object.h
index 8fb03ff90a..ad18ffcc55 100644
--- a/object.h
+++ b/object.h
@@ -74,6 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
+ * builtin/history.c:                    11-12
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index b181f93892..ba826df592 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -33,8 +33,7 @@ check_log_messages () {
 }
 
 test_expect_success 'setup linear history touching two files' '
-	test_commit base file a &&
-	git tag start &&
+	test_commit base file a start &&
 	test_commit --no-tag one other x &&
 	test_commit --no-tag two file c &&
 	test_commit three file d
@@ -76,6 +75,18 @@ test_expect_success 'rejects root commit' '
 	test_must_fail git history squash --ancestry-path=start $oid..three 2>err &&
 	echo "error: cannot squash down to root commit" >expect &&
 	test_cmp expect err
+'
+
+test_expect_success 'rejects multiple tips' '
+	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
+	test_must_fail git history squash ^start $oid three~1 2>err &&
+	echo "error: the revision range contains more than one tip commit" >expect &&
+	test_cmp expect err &&
+
+	git reset --hard three &&
+	git history squash ^start three~1 three &&
+	test_cmp_rev HEAD~1 start^0 &&
+	test_cmp_rev HEAD^{tree} three^{tree}
 '
 
 test_expect_success 'accepts multiple revision arguments with an exclusion' '
@@ -404,7 +415,7 @@ test_expect_success 'refuses a merge whose other parent is outside the range' '
 	merged=$(git rev-parse HEAD) &&
 
 	test_must_fail git history squash "$base.." 2>err &&
-	test_grep "more than one base" err &&
+	test_grep "parent .* of commit .* is outside the revision range" err &&
 	test_cmp_rev "$merged" HEAD
 '
 
@@ -533,7 +544,7 @@ test_expect_success 'refuses an octopus merge with an arm forked before the base
 	git branch -D octo-pre octo-within &&
 
 	test_must_fail git history squash "$octo_base.." 2>err &&
-	test_grep "more than one base" err &&
+	test_grep "parent .* of commit .* is outside the revision range" err &&
 	test_cmp_rev "$merged" HEAD
 '
 
-- 
2.54.0.200.gfd8d68259e3

