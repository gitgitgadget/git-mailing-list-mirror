Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B93B5E15
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900129; cv=none; b=qUl3ahqPtwoKisj2rVguud+JVJuTpEvQJQG5/joXDVpajbCSMqcsKJVtJppaO0xNhSbNupGbYFlsZKYK+1kojQWRGtE/fw48YS/rFPuivK81rFLDcis5TVEmfX80Ew//Z0bfrYdNCMPvgONlcdgHrYkXImLJgudytXVP3GfSGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900129; c=relaxed/simple;
	bh=Oq7slLISGZMdl/3NRERbgUkRdlOjsmZUWXdAnUfIty8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZixY3E31cieil7pboa0vSQFKbLUGwbqbLHkzQNBtCH3gUCU9k9gK2Hooym/uhdRnvkidXkFf0gJcV0PWWmL+EPcjUhSWZQc2pMudHK1Ww5Z4KEmjdENohT+ojlv1VPilD7Of5xngAUTILijNuIdimZZcXPTc4gFAxzKtUy8VhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXpYva4D; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXpYva4D"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76543e2so5845221cf.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900126; x=1789504926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0P+dCsn3n/YGzBzM+mdTv9tHuA3Bp437rJ0Qw4crBuE=;
        b=TXpYva4DvfpvsH6A3ulN2zl9eluGK7efobblH+GlT4la4fHPH0pEe6LB6RhWSY2tkm
         HxY4di+No1s2XaKdTNdmIeKDc1VFMmXA/5qjr5tA7qRog6v8aqIBjbtldlIzeY0LTcGl
         3Uulx6x4mL/gnPJosRcr39nvFGnCgCz+awAfN2c/6G2kEqM8hqBL5JpBtnZ3SgqmnSXV
         jpQQqmZd9Y4/JBBop8Rt3I16Xr8/8nI/d7z5egjQE71B41TQK4xOP1TfiY0hOXs1yEjm
         4JGrkHu6qOUYDTpe4vKSLwjYJ3toayRl146sAmGVYRp7rBgfh5a2x89KOjWPJRp2ZpIQ
         Nk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900126; x=1789504926;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0P+dCsn3n/YGzBzM+mdTv9tHuA3Bp437rJ0Qw4crBuE=;
        b=C8MrlktDhmacq/81mtiKuCHft/MN1EwlgEncd52+/n0MvegHucNMf45lM8T6xAZ6bJ
         K4j7wOT1drDZJ69/rcojX+dvT8RgErMPeLmRyB7Zt9IIMhKFtqhV2/ByaMotc8mb6jCO
         KT6gzfx59jECha//LlfcykB0NF3dkuOJMJOqUqiTYUrDMGUunFnQ472SYZ2gBOifxNe/
         mwGXjQFSlo6lxPUm0K2quaAj1MZmk8qfL4nQ3Wf5lyOZNLD9XSJE8vNDYf6ujgVDwq+G
         xq6vS4XpWNSIYjn8UeldOOgKcDZ8LAMZwQYsPHJcEcJ3jny8zXp30D2ub/39iG3ZGUmh
         UlZA==
X-Gm-Message-State: AFuF++kELr37jXI8+APqWjoKFZMaM6hGVbBvlvVAA7cX8iz0QT0+5op3
	notefM0xJeXUAMoj4aHIjUbaHkhsT0rKsEk89A8CX8xWpVRlDW93UajzZoZZ4CLN
X-Gm-Gg: AYBFou3nCDqTE+uz0vI1GJt7JRgL7cPBKjDtKpWsSTrlKvS2LkDug1V0szM36RjW3I6
	mzh9wSRDQ5oIvA7Ptcwpo6uDNCFGlTTes79uWs3IjIt+IM5/FzY6QGfLR1lyiI4EOOVgkfCZK5g
	VMxXCdUqGxxGRngeZ44StU7ji4mnJFe5HTJmaFft2ENACBp6uZX3L+7/d5kKHi0u7wTOYy4Y2h5
	DKByox8rjdtar3KTgD8hD8GyOa4k8BHNk90bHNr7frPU3NOF6Ob6Sl2uuTFof9mxhdc/2SJIn0K
	c+0B6hoVAz8oeYC4ner2ov5PB2TYAS4R6+I/zUaWM9apcEVqzeTTPh/HRN82a61c6QdDYTvhJqQ
	rgbZH78Ms+ANV737/mYSgwNbkrqz7GSpGQ2pyPon7OlT3ZVkRnrPEg0sevtO9/+L3T4hMiy0OPQ
	NWqAvO/5DX8Dx4Ik0FKvBFB59K1jk2yqmChLOlfrFSxF3t4XrHJ9GvShkhT1zgBj6k
X-Received: by 2002:a05:622a:2290:b0:52e:2d19:b30e with SMTP id d75a77b69052e-530911d4899mr98525441cf.3.1788900126305;
        Tue, 08 Sep 2026 13:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53054180b8fsm120687171cf.17.2026.09.08.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:05 -0700 (PDT)
Message-Id: <4389729c8340a01c8e2e4165254bfc50b1fe1093.1788900120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:56 +0000
Subject: [PATCH v15 5/8] history: validate squash revision ranges
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Walk the selected commits in topological order from oldest to newest and
mark each one as it is seen. Every parent after the oldest commit must
already be selected or also be a parent of the oldest commit. This
accepts merges contained by the range while rejecting a merge arm that
entered it from elsewhere.

Track the remaining graph tips during the same walk and require exactly
one. Also reject empty and single-commit ranges and any selection that
reaches a root commit. These checks identify the oldest commit whose
parents will be preserved and the single tip whose tree will be used by
the rewrite.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c         | 119 ++++++++++++++++++++++++++++++++++----
 object.h                  |   1 +
 t/meson.build             |   1 +
 t/t3455-history-squash.sh |  65 +++++++++++++++++++++
 4 files changed, 174 insertions(+), 12 deletions(-)
 create mode 100755 t/t3455-history-squash.sh

diff --git a/builtin/history.c b/builtin/history.c
index 4f5a7a46ce..6541a397e8 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1006,6 +1006,9 @@ out:
 	return ret;
 }
 
+#define SQUASH_SEEN (1u << 11)
+#define SQUASH_TIP (1u << 12)
+
 static int setup_squash_revisions(struct repository *repo,
 				  int argc, const char **argv,
 				  struct rev_info *revs)
@@ -1052,6 +1055,104 @@ static int setup_squash_revisions(struct repository *repo,
 	return error(_("not a '<base>..<tip>' revision range"));
 }
 
+/*
+ * Resolve a revision range into its oldest commit and single tip. Every
+ * parent after the oldest commit must either be selected or also be a parent
+ * of the oldest commit.
+ */
+static int resolve_squash_range(struct repository *repo,
+				int argc, const char **argv,
+				struct commit **oldest_out,
+				struct commit **tip_out)
+{
+	struct rev_info revs;
+	struct commit *commit, *oldest = NULL, *tip = NULL;
+	int ret, tip_count = 0;
+	bool walk_started = false;
+
+	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	if (ret < 0)
+		goto out;
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+	walk_started = true;
+	while ((commit = get_revision(&revs))) {
+		struct commit_list *p;
+
+		if (!commit->parents) {
+			ret = error(_("cannot squash down to root commit"));
+			goto out;
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
+				if (p->item == q->item)
+					seen = true;
+			if (!seen) {
+				ret = error(_("parent %s of commit %s is "
+					      "outside the revision range"),
+					    repo_find_unique_abbrev(repo, &o->oid,
+								    DEFAULT_ABBREV),
+					    repo_find_unique_abbrev(repo,
+								    &commit->object.oid,
+								    DEFAULT_ABBREV));
+				goto out;
+			}
+			if (o->flags & SQUASH_TIP) {
+				tip_count--;
+				o->flags &= ~SQUASH_TIP;
+			}
+		}
+		if (!oldest)
+			oldest = commit;
+		tip = commit;
+		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
+		tip_count++;
+	}
+
+	if (!tip_count) {
+		ret = error(_("the revision range is empty"));
+		goto out;
+	} else if (tip_count != 1) {
+		ret = error(_("the revision range contains more than one tip "
+			      "commit"));
+		goto out;
+	} else if (oldest == tip) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	} else if (!oldest->parents) {
+		BUG("an in-range commit must have a parent");
+	}
+
+	*oldest_out = oldest;
+	*tip_out = tip;
+	ret = 0;
+
+out:
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	if (walk_started)
+		reset_revision_walk();
+	release_revisions(&revs);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1074,26 +1175,20 @@ static int cmd_history_squash(int argc,
 			 N_("edit the commit message")),
 		OPT_END(),
 	};
-	struct rev_info revs = { 0 };
+	struct commit *oldest, *tip;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
-	if (argc < 2) {
-		ret = error(_("command expects a revision range"));
-		goto out;
-	}
+	if (argc < 2)
+		return error(_("command expects a revision range"));
 	repo_config(repo, git_default_config, NULL);
 
-	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	ret = resolve_squash_range(repo, argc, argv, &oldest, &tip);
 	if (ret < 0)
-		goto out;
-
-	ret = error(_("squashing commits is not implemented yet"));
+		return ret;
 
-out:
-	release_revisions(&revs);
-	return ret;
+	return error(_("squashing commits is not implemented yet"));
 }
 
 static int update_worktree(struct repository *repo,
diff --git a/object.h b/object.h
index 8fb03ff90a..dcf30156ca 100644
--- a/object.h
+++ b/object.h
@@ -74,6 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
+ * builtin/history.c:                    1112
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/meson.build b/t/meson.build
index 7f53cca7d1..ba6f33cdff 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -407,6 +407,7 @@ integration_tests = [
   't3452-history-split.sh',
   't3453-history-fixup.sh',
   't3454-history-drop.sh',
+  't3455-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
new file mode 100755
index 0000000000..df92aa4f6c
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'setup linear history' '
+	test_commit base file a start &&
+	test_commit one file b &&
+	test_commit two file c &&
+	test_commit three file d
+'
+
+test_expect_success 'errors on missing range argument' '
+	test_must_fail git history squash 2>err &&
+	test_grep "expects a revision range" err
+'
+
+test_expect_success 'errors on an empty range' '
+	test_must_fail git history squash HEAD..HEAD 2>err &&
+	test_grep "the revision range is empty" err
+'
+
+test_expect_success 'errors on a single revision that is not a range' '
+	test_must_fail git history squash HEAD 2>err &&
+	test_grep "not a .*range" err &&
+	test_must_fail git history squash HEAD~1 2>err &&
+	test_grep "not a .*range" err
+'
+
+test_expect_success 'errors on a range holding a single commit' '
+	test_must_fail git history squash "HEAD^!" 2>err &&
+	test_grep "single commit; nothing to squash" err
+'
+
+test_expect_success 'rejects a root commit' '
+	oid=$(git commit-tree -m root three^{tree}) &&
+	test_must_fail git history squash \
+		--ancestry-path=start "$oid..three" 2>err &&
+	test_grep "cannot squash down to root commit" err
+'
+
+test_expect_success 'rejects multiple tips' '
+	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
+	test_must_fail git history squash ^start "$oid" three~1 2>err &&
+	test_grep "revision range contains more than one tip" err
+'
+
+test_expect_success 'rejects a merge parent outside the range' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b outside-parent &&
+	test_commit --no-tag outside-parent outside x &&
+	git checkout "$main" &&
+	test_commit --no-tag outside-main file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag outside-mid file c &&
+	git merge --no-ff -m "merge outside-parent" outside-parent &&
+	git branch -D outside-parent &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err
+'
+
+test_done
-- 
gitgitgadget

