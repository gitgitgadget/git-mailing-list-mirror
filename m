Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756522425B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270513; cv=none; b=HZ2lRPPA7q/vbxGlOw1TiyIbaadIUJ4xCcTFRiH69U+1x9lef20pkkhUGuUOFDCrjpyKEIVRFbTAoW1ywLYQE2GD1kWsfGih1faT9/s5kCczTs912+Pu40JdtJRpW57iXOCAXLGmA+ir0aN4MAb20zVn7NISHCNTnE7SXIvzeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270513; c=relaxed/simple;
	bh=E6i116PKEIWifnqSBbe24mYTwqzJ8UEroS4f/iCeOpE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WS0QM7qxxt+/KH9xNTCHzLJghgrt8Yg475W9jNVNoV8I/9HlOuRKDkFzVtSrDYQItUSXri29vO4w9O/adE6zOI/9vWe5L14h+i3F3tpic2D5qInJdl1cSU4M8ARhWclM9NQCKO5zrkahOTMveeWf3VvJcnHVc+Js2DTOYsT2rjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm1t7rm1; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm1t7rm1"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49429181ce9so122939fac.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270510; x=1791875310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cxh1CkOOZcdhr/fjqKjN1su2XWUNfI0mOneNUC45pGc=;
        b=Nm1t7rm1n1XTNxAT6qcxqGIJ9hXXq5ryGw19t66Rh7SworQu8hryZvL3Vw6CHMEdF+
         uMPSTQuJc7PvxIk/4dvc4/Vm6wsQG62Upmgq5A2w0GEUgmxKfQUo3IdofyssVFtho4xv
         oeyaBQm4cFUmUgM/cARso5fMXLNFZXSw2dMyalIXpK5UZsG1L9xcnmjRkXp0w0KXISFg
         giGQNY7AiamgsCkA2/GpwNYu+CFcIJIVFjiW2j61P6SZ+xszynLokaJYjxk2+yqH3gL0
         wWJpNlSEkV+ijXSqwaYcpUp72ImXitB+s/G8quvegRyJf0S6zlMkzF8iaNz0vq6DmA9M
         qjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270510; x=1791875310;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxh1CkOOZcdhr/fjqKjN1su2XWUNfI0mOneNUC45pGc=;
        b=qKxcRYt+ce5Uazjw/pn3M2gj8qeYNaEZn0ZiN7kbhYtDWsHSEPkd2VQzAApU2RWI6V
         Zs1sZp4kIWkzB525+bwyKaw6CPeFqqG8iU4SynDfkbYYDx018ak80xrrP0DVtZ4P8dJO
         OjOWg0rX2ZHO4VijD8MOwM9VqZuPIQg+422fjeb8H0DQ3qHaTDCLQ31yuMXHR2VIIz4r
         y/RBhzL3lnE/6npsnBpFovILMjIWAslL1XbOAVvEhQcB24p7zvussTuraEnkEKkavzWw
         z4sPUL9oyIupYujMyYo00IkXqrhnHW0piCyodG4sGpI0MZCW2bRDxeX7jN3oMua1W7no
         kypg==
X-Gm-Message-State: AFq9FYKcnA9e0aV7IAglPJ+7Stklr/gXxKbTvd9pYj+ohtOkpkmNVCmI
	XkzxmhlwBxy2tPW8rnJhqtEW8YtHb+jyOg2CovlXHc5M/ReCAXV/hW2ML7WzNBb1
X-Gm-Gg: AYBFou1LCJkKWFJ6sEz6FQ8WMDrF+6pMNnBgT8dpSCu15k86EDWqNAmlKhZ2slktX6w
	synFiJkGlvk4F1RKW5z+DCyvkEvGmkrS7KdhecxXIUWqvJdpUIKK1QQI1/9SOQHL3sGwLS9L5FY
	8C7CzSJ7vNaTYOFHgrsKE5yNwKfEgaaG2jKBv777OwaRs7FCAB32T8RDxuA2ccILVCxs9t9Tvwb
	JiaNy6gZsRKWU8ROcmz9aNqRsr06KwIJ3NofsH3fQAqk0Xa/hUfNDoIQjw8alnd6fVhWCYs3Jiw
	grna+aVxV15HsGdPr00QkRP+GilaT1wcaTMIvOGa8xNNipiHFTW/fsbwU5AwwHoEl65o712fo32
	JrRWNF6ZiAX0pJH3j8ePtqW6dXDAlUDNLYOKwT1NTgTwZ4TYjCYwUx4846XWpLJL0+KOa6AA8/E
	XVHMln/3cKy4ybo7B+96z6bER54aqg5Vjkn14PPXTCRQP2TUZfZLCcvNJgtErqnYO92D/wHQPMI
	Ww=
X-Received: by 2002:a05:6870:2494:b0:47c:4f69:3f1f with SMTP id 586e51a60fabf-4a24045c335mr416968fac.14.1791270510196;
        Tue, 06 Oct 2026 00:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16ead0dbsm12150611fac.12.2026.10.06.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:28 -0700 (PDT)
Message-Id: <e1651568b1923ab075542e2c5027917bae76c619.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:19 +0000
Subject: [PATCH 1/6] status: count push divergence outside the upstream
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

After rebasing onto a newer upstream, "git status" counts every commit
the upstream gained since the last push as a difference from the push
branch when status.compareBranches includes "@{push}". That can be many
commits, even when only a few of your own differ.

Keep the full counts, and when they include commits from the upstream,
add how many of them are not in it:

  Your branch and 'origin/topic' have diverged,
  and have 51 and 1 different commits each (1 and 1 not in 'upstream/main').

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 81 +++++++++++++++++++++++++++++++++-------
 t/t6040-tracking-info.sh | 32 ++++++++++++++++
 2 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/remote.c b/remote.c
index fe62068463..cbe79275f7 100644
--- a/remote.c
+++ b/remote.c
@@ -2247,11 +2247,12 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
  */
 
 static int stat_branch_pair(const char *branch_name, const char *base,
+			     const char *exclude,
 			     int *num_ours, int *num_theirs,
 			     enum ahead_behind_flags abf)
 {
 	struct object_id oid;
-	struct commit *ours, *theirs;
+	struct commit *ours, *theirs, *excluded = NULL;
 	struct rev_info revs;
 	struct strvec argv = STRVEC_INIT;
 
@@ -2268,6 +2269,14 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	if (!ours)
 		return -1;
 
+	if (exclude) {
+		if (refs_read_ref(get_main_ref_store(the_repository), exclude, &oid))
+			return -1;
+		excluded = lookup_commit_reference(the_repository, &oid);
+		if (!excluded)
+			return -1;
+	}
+
 	*num_theirs = *num_ours = 0;
 
 	/* are we the same? */
@@ -2284,6 +2293,8 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_pushf(&argv, "%s...%s",
 		     oid_to_hex(&ours->object.oid),
 		     oid_to_hex(&theirs->object.oid));
+	if (excluded)
+		strvec_pushf(&argv, "^%s", oid_to_hex(&excluded->object.oid));
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
@@ -2305,6 +2316,8 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	/* clear object flags smudged by the above traversal */
 	clear_commit_marks(ours, ALL_REV_FLAGS);
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
+	if (excluded)
+		clear_commit_marks(excluded, ALL_REV_FLAGS);
 
 	strvec_clear(&argv);
 	release_revisions(&revs);
@@ -2344,7 +2357,23 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!base)
 		return -1;
 
-	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
+	return stat_branch_pair(branch->refname, base, NULL,
+				num_ours, num_theirs, abf);
+}
+
+/*
+ * Count the commits that differ between branch_name and base but are not
+ * in upstream. Return false when they cannot be counted or upstream
+ * accounts for none of the ours and theirs commits.
+ */
+static bool stat_outside_upstream(const char *branch_name, const char *base,
+				  const char *upstream, int ours, int theirs,
+				  int *ours_unmerged, int *theirs_unmerged)
+{
+	if (stat_branch_pair(branch_name, base, upstream, ours_unmerged,
+			     theirs_unmerged, AHEAD_BEHIND_FULL) < 0)
+		return false;
+	return *ours_unmerged != ours || *theirs_unmerged != theirs;
 }
 
 static char *resolve_compare_branch(struct branch *branch, const char *name)
@@ -2376,6 +2405,8 @@ static void format_branch_comparison(struct strbuf *sb,
 				     const char *branch_name,
 				     const char *push_remote_name,
 				     const char *push_branch_name,
+				     const char *upstream_name,
+				     int ours_unmerged, int theirs_unmerged,
 				     enum ahead_behind_flags abf,
 				     unsigned flags)
 {
@@ -2421,15 +2452,27 @@ static void format_branch_comparison(struct strbuf *sb,
 					_("  (use \"git pull\" to update your local branch)\n"));
 		}
 	} else {
-		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
-			   ours + theirs),
-			branch_name, ours, theirs);
+		if (upstream_name)
+			strbuf_addf(sb,
+				Q_("Your branch and '%s' have diverged,\n"
+				       "and have %d and %d different commit each "
+				       "(%d and %d not in '%s').\n",
+				   "Your branch and '%s' have diverged,\n"
+				       "and have %d and %d different commits each "
+				       "(%d and %d not in '%s').\n",
+				   ours + theirs),
+				branch_name, ours, theirs,
+				ours_unmerged, theirs_unmerged, upstream_name);
+		else
+			strbuf_addf(sb,
+				Q_("Your branch and '%s' have diverged,\n"
+				       "and have %d and %d different commit each, "
+				       "respectively.\n",
+				   "Your branch and '%s' have diverged,\n"
+				       "and have %d and %d different commits each, "
+				       "respectively.\n",
+				   ours + theirs),
+				branch_name, ours, theirs);
 		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS)) {
 			if (push_remote_name && push_branch_name)
 				strbuf_addf(sb,
@@ -2473,7 +2516,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	for (i = 0; i < branches.nr; i++) {
 		char *full_ref;
 		char *short_ref;
+		char *upstream_name = NULL;
 		int ours, theirs, cmp;
+		int ours_unmerged = 0, theirs_unmerged = 0;
 		int is_upstream, is_push;
 		unsigned flags = 0;
 		const char *push_remote_name = NULL;
@@ -2498,9 +2543,17 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (is_upstream && (!push_ref || !strcmp(upstream_ref, push_ref)))
 			is_push = 1;
 
-		cmp = stat_branch_pair(branch->refname, full_ref,
+		cmp = stat_branch_pair(branch->refname, full_ref, NULL,
 				       &ours, &theirs, abf);
 
+		if (cmp > 0 && ours && theirs && upstream_ref && !is_upstream &&
+		    stat_outside_upstream(branch->refname, full_ref,
+					  upstream_ref, ours, theirs,
+					  &ours_unmerged, &theirs_unmerged))
+			upstream_name = refs_shorten_unambiguous_ref(
+				get_main_ref_store(the_repository),
+				upstream_ref, 0);
+
 		if (cmp < 0) {
 			if (is_upstream) {
 				strbuf_addf(sb,
@@ -2542,11 +2595,13 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		}
 		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
 					 push_remote_name, push_branch_name,
-					 abf, flags);
+					 upstream_name, ours_unmerged,
+					 theirs_unmerged, abf, flags);
 		reported = 1;
 
 		free(full_ref);
 		free(short_ref);
+		free(upstream_name);
 	}
 
 	string_list_clear(&branches, 0);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..f8df16a5de 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -746,4 +746,36 @@ test_expect_success 'status.compareBranches suppresses advice when push tracking
 	test_cmp expect actual
 '
 
+test_expect_success 'status.compareBranches counts push divergence outside upstream' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	(
+		cd test &&
+		git checkout -b feature18 origin/main &&
+		advance work18 &&
+		git push
+	) &&
+	git checkout main &&
+	advance main18a &&
+	advance main18b &&
+	git checkout - &&
+	(
+		cd test &&
+		echo amended >work18 &&
+		git commit -a --amend --no-edit &&
+		git pull --rebase &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature18
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch and ${SQ}origin/feature18${SQ} have diverged,
+	and have 3 and 1 different commits each (1 and 1 not in ${SQ}origin/main${SQ}).
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

