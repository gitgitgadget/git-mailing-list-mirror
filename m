Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633373E7145
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693124; cv=none; b=bxiA2wsX8DWS0mRwxLfpX40V8zYwIMIKmlIFXCfoTcefMJN5k86woxkcdTO2vNbKzjwD9NGECP2WE62d6MnF+TosErRgLewQSkyFQpIY6GK9wmvA0v6usDPrB8fr0EfzNlNDXJjVBb5+MvzFyCu33Hbd91xvWUtauDO2PB5iQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693124; c=relaxed/simple;
	bh=iIBqM1h18sQzrbY2Ejcbu/H3LFJT/Tr9B3iE7ll7ejI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uxuH7CyfZ67h7K8xu8Z5Vk40RYBJ2cmekYEO362WjE/Pv4kUG0LRLLKSOe30xT6iffAjJcZCIyJb4nYzU1tTUKeFCD1Ga9tGRJhRDF3gJ3rYsDm/t3VutLoRPTtT2V4DB1auZ8Pj1IHOPuAb+720W8PA0SvgRlmk1LYkCIgcDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKlc5hvu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKlc5hvu"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedf433a99so198027a12.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787693122; x=1788297922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y5elOL37xBAMdVuqmseBdT3r9QEsedNGHnVkwqz8E4U=;
        b=WKlc5hvuSxU5YfZeHDnjvqsrfbSk4Lqk2cOti1szkf1uEkYJiQuJ/j6rID0HUyCesF
         cJzw6j6s78iHRO8OqVVh9Z84dZ3ugSga9ZZKPUclMrPLdzF5ZMOUu1Vs4HvSXkqlqVMH
         Xp8q4zup3/0lpeMzh5IlRpp+Kf1rQoxBYz08Pu3Q+2ptk6qUG1qjMsdS+1nDdFByav9h
         NY9SPurb4ZvoaoDER1NNvsdNQ+HInv2i5eYx9ROMykUrzFRyqZ7h0NLEfJJiz4EIFE2U
         pkEoxMxLYIWLpsRADZ16o3rJZsDCNkCGHMSMbeifNddtjdMUzyev9wgyXjzM0Q3bAVnx
         ftZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787693122; x=1788297922;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5elOL37xBAMdVuqmseBdT3r9QEsedNGHnVkwqz8E4U=;
        b=UPm98x3dKLwb8HPePDPB/FlojvLwmFp26e+r1AcHp3WnlwC/Vq8ZZUmMkuplAZkAFW
         tfK46vvZ8loBdjLu5z0b82WzIT9oXCGuvem9jA23lu+nxE7KFRHYocsBbwXDcyv+/GUi
         f2b0jL3ebUZetfBQHAtJPGZ1Jwb7jGYPQUKeMeYaS2ylwCmG7vkXq9yEQdb59lgrl2xQ
         JnddZnJsl1N3Oj0ailUHYS/1eMTxxkNPsyDbvYE7ewNpR/SWzjADdCbvWLYwBtZwQhKF
         +BLdwsPL3nYrALGuZMPoSwz2DzgX7/XSxet/9jxDUI1YmQdk+mk+GSEZ3QRu9rsxPi9K
         KeCw==
X-Gm-Message-State: AFuF++lAIH1R1qH4D4J8eRwCXdn7yi5WIApEqwN/h3EekqOHsRn1jEF0
	9vQE9Bp4ERAej6Z4hmFLYXRTUr2PUnkrPpl41tWK9MYR8O2MyJ0mrM+sHB5q1E9+
X-Gm-Gg: AR+sD12lHZ5Vcx30pVdTLX1ijOM39lupTXQy8Pr2IXB4MmJfXWhwtHQH5LVc8cT3m3j
	aibGj3JMrw7L2E48n750cCGEZLvWRQAU4Kh0DRYwaDgSYfcpy0GaWOnu3vi7U+JWHLlFifweFRB
	vy5DqDcJv4r41596zCVt/NDkA3Z71cjEGel+ZV3lV5oG/gwjHilYDPXNge/vOjFZxWB9kGOVe7E
	sz7PYDqjhHoYaCmsbhuIiKZBrTOF2HGuHXPhbC/W9HWqmJZpi2qp6AYg+/aa0xKjQxoDCRX1ZqC
	tTyGLQY+8ye9fhnK40S8Dsfqsd/1cQxqnJCgXOnwgihBaGb31cclD7BFY61KrcTqU26o3NPf1pc
	wWgpKvnkppYf1I5AayykCytqdSb16eDvSvM8hBkjVQ5QCyy0J9dW/tZSOzARGguQyUscQo8Qs8Z
	rcAxdJJb/WL+eXzVC6MbIk3g7WXK1O43at7DAoNB2lwhrggWowQ5rYcoxJ1//JeIXm
X-Received: by 2002:a05:6a21:6a0d:b0:3cd:6f46:aceb with SMTP id adf61e73a8af0-3cf82622ab8mr2988670637.8.1787693121790;
        Tue, 25 Aug 2026 14:25:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.158.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d63bb23sm1814509eec.7.2026.08.25.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:25:21 -0700 (PDT)
Message-Id: <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:25:17 +0000
Subject: [PATCH 2/2] branch: protect local upstreams from -d
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A local branch may be fully merged into its own upstream while still
serving as the base of a surviving stacked branch. Deleting it with
"git branch -d" then leaves the surviving branch with a missing
upstream.

Use the existing stacked-branch protection after checking every
requested deletion. This makes multi-branch deletion independent of
argument order: a branch that fails its safety check remains available
to protect its upstream. Allow -D to override the protection, and allow
a complete stack to be deleted together.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  4 +++-
 builtin/branch.c              | 38 +++++++++++++++++++++++++++++--
 t/t1507-rev-parse-upstream.sh |  4 ++--
 t/t3200-branch.sh             | 43 +++++++++++++++++++++++++++++++++++
 t/t6040-tracking-info.sh      |  2 +-
 5 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..5c2a3339b2 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -102,7 +102,9 @@ OPTIONS
 `--delete`::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
-	`--track` or `--set-upstream-to`.
+	`--track` or `--set-upstream-to`, and must not be an upstream,
+	directly or indirectly, of another local branch that will remain
+	after the operation.
 
 `-D`::
 	Shortcut for `--delete --force`.
diff --git a/builtin/branch.c b/builtin/branch.c
index 87f0aa4051..7f76789027 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -294,12 +294,13 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	struct object_id oid;
 	char *name = NULL;
 	const char *fmt;
-	int i;
 	int ret = 0;
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct strset deletable_branch_names = STRSET_INIT;
+	struct strset protected_branch_names = STRSET_INIT;
 	struct string_list_item *item;
 	int branch_name_pos;
 	const char *fmt_remotes = "refs/remotes/%s";
@@ -326,7 +327,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	    !(flags & DELETE_BRANCH_NO_HEAD_FALLBACK))
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
-	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
+	for (int i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int ref_flags = 0;
 
@@ -397,11 +398,42 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
 				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
+		if (!remote_branch && !(flags & (DELETE_BRANCH_FORCE |
+						 DELETE_BRANCH_SKIP_UNMERGED)))
+			strset_add(&deletable_branch_names, bname.buf);
 
 	next:
 		free(target);
 	}
 
+	if (!remote_branch &&
+	    !(flags & (DELETE_BRANCH_FORCE | DELETE_BRANCH_SKIP_UNMERGED)) &&
+	    refs_to_delete.nr) {
+		protect_stacked_branch_bases(get_main_ref_store(the_repository),
+					     &deletable_branch_names, &protected_branch_names);
+		for (size_t i = refs_to_delete.nr; i; i--) {
+			const char *branch_name;
+
+			item = &refs_to_delete.items[i - 1];
+			if (!skip_prefix(item->string, "refs/heads/",
+					 &branch_name))
+				BUG("expected local branch ref, got '%s'",
+				    item->string);
+			if (strset_contains(&deletable_branch_names, branch_name))
+				continue;
+
+			error(_("the branch '%s' is an upstream of another branch"),
+			      branch_name);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					    "run 'git branch -D %s'"),
+					  branch_name);
+			ret = 1;
+			unsorted_string_list_delete_item(&refs_to_delete, i - 1,
+							 1);
+		}
+	}
+
 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
 	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
@@ -428,6 +460,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(describe_ref);
 	}
 	string_list_clear(&refs_to_delete, 0);
+	strset_clear(&deletable_branch_names);
+	strset_clear(&protected_branch_names);
 
 	free(name);
 	strbuf_release(&bname);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index cb9ef7e329..04abfb6f94 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -146,9 +146,9 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 )
 '
 
-test_expect_success 'branch -d other@{u}' '
+test_expect_success 'branch -D other@{u}' '
 	git checkout -t -b other main &&
-	git branch -d @{u} &&
+	git branch -D @{u} &&
 	git for-each-ref refs/heads/main >actual &&
 	test_must_be_empty actual
 '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..a3d492ffcd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2173,6 +2173,49 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
+test_expect_success 'branch -d keeps the upstream of a surviving branch' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch foundation origin/next --track &&
+		git checkout -b topic foundation --track &&
+		git commit --allow-empty -m "topic work" &&
+		git checkout --detach &&
+
+		test_must_fail git branch -d foundation 2>err &&
+		test_grep "branch .foundation. is an upstream of another branch" err &&
+		test_ref_exists refs/heads/foundation &&
+		test_ref_exists refs/heads/topic &&
+
+		git branch -D foundation &&
+		test_ref_missing refs/heads/foundation &&
+		test_ref_exists refs/heads/topic
+	)
+'
+
+test_expect_success 'branch -d protects a base when another deletion fails' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch foundation origin/next --track &&
+		git checkout -b topic foundation --track &&
+		git commit --allow-empty -m "topic work" &&
+		git checkout --detach &&
+
+		test_must_fail git branch -d foundation topic 2>err &&
+		test_grep "branch .foundation. is an upstream of another branch" err &&
+		test_grep "branch .topic. is not fully merged" err &&
+		test_ref_exists refs/heads/foundation &&
+		test_ref_exists refs/heads/topic &&
+
+		test_must_fail git branch -d topic foundation 2>err &&
+		test_grep "branch .foundation. is an upstream of another branch" err &&
+		test_grep "branch .topic. is not fully merged" err &&
+		test_ref_exists refs/heads/foundation &&
+		test_ref_exists refs/heads/topic
+	)
+'
+
 test_expect_success '--dry-run without --delete-merged is rejected' '
 	test_must_fail git -C forked branch --dry-run 2>err &&
 	test_grep "requires --delete-merged" err
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..01145f6681 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
 		git checkout -b brokenbase origin &&
 		git checkout -b b5 --track brokenbase &&
 		advance g &&
-		git branch -d brokenbase &&
+		git branch -D brokenbase &&
 		git checkout -b b6 origin
 	) &&
 	git checkout -b follower --track main &&
-- 
gitgitgadget
