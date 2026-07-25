Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD532A3FF
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993679; cv=none; b=pADzLkWZ+8+eebiN4g+UGb7etaVU2lDeMyo4HXXXD822ygIYnLP1IlnWf8i5oajvUC94tnM60o1g9sGmOoRUXshQTl6or4rPVwVA3oeITpwNgVR3jeFFlDpTZ9Y3jJjAW34MN4hrvIY7QGCxzo9yiXbSaxGvnSOED3B+T4FGHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993679; c=relaxed/simple;
	bh=NRNY3EnPCzp1LqzP2Nx+r70TVQFnmKrQNOqGtrW1K3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k2iELDEjyctHvrlNwPJ6j5+n+8aOGpm/r0FOKJImf7WF38Dplo+KJb1suDAp3n2tJgRIKY2Nws2H6R66btfQqXKSaE4g+vOzxGOJGsH9Bm8ILyEonWrrCe2yUYjU87Rkv1niul0JgDCOPD01OxMR8lky/JXpPemSmAm/VYTtK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6/t6kNa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6/t6kNa"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1096032a91.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784993676; x=1785598476; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLp0SXWTIBwVIkhR3Po5WPBI0iaNbikcghTAB7aUBoc=;
        b=N6/t6kNauF+mqNMLpyV//PM1dMXR97MrekUkEyYCeWlplV8ho8JETfxUrUV9Y1HcMG
         mBVbbaNiGp03TfIqvb/ZjVUrnrRnwDK6sXFV2QFjdDslEvV0Szse77vZAWdGMDdLQxgU
         5sARPZixtpgiOVbbORi6zLzZJCUqMejeiRTra3w3NxZPPCcMjAzBBE5te/82k0s3Ajh1
         nvqqQW1rFu6WTGKQtoZNROCsko8/1AYv4o/bz7JTCoI9FoqXuK1UMUgUwQPbwi+gIN6w
         SaeS6Ig9SqWAg6oFeI3uxTraRDoMIsWvuHAzVduGljMAraFVQj3chfw7dnEDDx2sjH3h
         1xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784993676; x=1785598476;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLp0SXWTIBwVIkhR3Po5WPBI0iaNbikcghTAB7aUBoc=;
        b=a+o5E4mtm+FHxRLA4czpx6S/GddOGjXi3cMOD+J8RgMr30grx22HnUXPPUCia0vzAV
         3ymRKT5M7ixQsjC9wWLyxGtBAxmBysCQsBuxkCZg3gLo2ALVh5N4nLWArqmOuPdLPzjy
         EGEJKTMj0OpZVyOYc0UaMKu2VNBDCdBXhtyzdO7qvFyUNO2LmyH6mPjd2fH9C4i4LnEB
         DdCLnVagbouNA3Lk82nNske7vRPyNNFWT9CA0vU/EBdXX5Y7reDhcpxpn8ZHLMjvRDfH
         I5opVuiXCeN/ns1EuypL9ckwPao9tNzZvdpTkWn/8BYbbgGBPd0+7S5H8myuvAhBDeA7
         QxPw==
X-Gm-Message-State: AOJu0YxrW8NOJNtDQraiyTlw8KDHH9sFmgD1pvxsnKvcJJWOUbPDcARy
	5uMX3VvzuGY2KW6028qnUikc2+n3jEqwHxf0jx3XrYnrunlU59lEtFuZsAMAUFj9
X-Gm-Gg: AR+sD11ITL3UMQyAJDnkVHzBndp53laFQaqUdczHIRunltlplWKFJrAQ2mF/e0gRcW7
	UZoBjb6VG53fZjMuxsyIeHrLfOt0grVj395XqTQsvEMQRtsDFJcVv5mPFSb8JshrizD0LvQPbG7
	lqWZnaYyYNtiBMD8Q5RMKWPp9E2OOnogIQs5l6545ydazfQdHocXkMP5R+S/TEJu7HzHD6QBqEc
	iedHAY9Jdt1itXTxNVvjg7YbY/6GoXEbre5vH89oNEYANVxZXtjBBdeqdDOHPxU+vjYCsaNOb/P
	0ZGinYZycM1RvZnUug64s/GYCM7DfGorEA+IRc7qy2Rhif1a6ecnrofLFfwzCT65dl0Np2bfykR
	PjLBOCWXItOZNTC/1NmX5RG2uN3F8SKn6f1PwK6/XMl8hRqkJYO6fx6p0yz4v+y1BZ4RSpTSkwO
	N/
X-Received: by 2002:a17:90b:4d11:b0:387:d5bd:622e with SMTP id 98e67ed59e1d1-38f2aa99eb8mr1882931a91.17.1784993676104;
        Sat, 25 Jul 2026 08:34:36 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.7.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f090b0c9dsm1499472a91.4.2026.07.25.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:34:34 -0700 (PDT)
Message-Id: <37becf38c2ef175a3dadcf750e2cca836942d83e.1784993669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 15:34:29 +0000
Subject: [PATCH 2/2] checkout -m: refine autostash fallback
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

When unpack_trees() fails under "git checkout -m", only create an
autostash and retry if there are tracked local changes.  Without such
changes, the fallback cannot help and merely repeats the same failure.

Use the conflict result from apply_autostash_ref() to print a blank line
before the branch-switch message, visually separating it from the
conflict advice.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/checkout.c | 17 +++++++++++++----
 t/t7201-co.sh      | 17 ++++++++++++++++-
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 72aafa4049..2e8b2a2348 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -838,10 +838,11 @@ static void init_topts(struct unpack_trees_options *topts,
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
-			      bool quiet,
+			      bool allow_autostash,
 			      int *writeout_error)
 {
 	int ret;
+	bool can_autostash = false;
 	struct lock_file lock_file = LOCK_INIT;
 	struct tree *new_tree;
 
@@ -888,9 +889,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			return 1;
 		}
 
+		if (allow_autostash)
+			can_autostash = has_unstaged_changes(the_repository, 1) ||
+				has_uncommitted_changes(the_repository, 1);
+
 		/* 2-way merge to the new branch */
 		init_topts(&topts, opts->show_progress,
-			   opts->overwrite_ignore, quiet);
+			   opts->overwrite_ignore, can_autostash);
 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
@@ -917,7 +922,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			rollback_lock_file(&lock_file);
-			return MERGE_WORKING_TREE_UNPACK_FAILED;
+			return can_autostash ?
+				MERGE_WORKING_TREE_UNPACK_FAILED : 1;
 		}
 	}
 
@@ -1166,6 +1172,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	int flag, writeout_error = 0;
 	int do_merge = 1;
 	int created_autostash = 0;
+	bool autostash_conflicted = false;
 	struct strbuf old_commit_shortname = STRBUF_INIT;
 	struct strbuf autostash_msg = STRBUF_INIT;
 	const char *stash_label_base = NULL;
@@ -1243,7 +1250,7 @@ static int switch_branches(const struct checkout_opts *opts,
 					    "local",
 					    stash_label_base,
 					    autostash_msg.buf,
-					    NULL);
+					    &autostash_conflicted);
 		}
 		if (ret) {
 			branch_info_release(&old_branch_info);
@@ -1256,6 +1263,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
 		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
 
+	if (autostash_conflicted && !opts->quiet)
+		fputc('\n', stderr);
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	if (created_autostash) {
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0ddd1ad7aa..f9696dab36 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -240,6 +240,14 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
 	test_grep "git stash drop" actual &&
 	test_grep "git stash pop" actual &&
 	test_grep "The following paths have local changes" actual &&
+	sed -n "/apply the local changes later/,/Switched to branch/p" \
+		actual >separator.actual &&
+	cat >separator.expect <<-EOF &&
+	apply the local changes later by running "git stash pop".
+
+	Switched to branch ${SQ}side${SQ}
+	EOF
+	test_cmp separator.expect separator.actual &&
 	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
 	sed /^index/d actual >actual.trimmed &&
 	cat >expect <<-EOF &&
@@ -262,11 +270,18 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
 	git reset --hard
 '
 
-test_expect_success 'checkout -m which would overwrite untracked file' '
+test_expect_success 'checkout -m only retries untracked-file failure with local changes' '
 	git checkout -f --detach main &&
 	test_commit another-file &&
 	git checkout HEAD^ &&
 	>another-file.t &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/trace" \
+		git checkout -m @{-1} 2>err &&
+	test_grep "untracked working tree files" err &&
+	grep "\"region_enter\".*\"category\":\"index\",\"label\":\"refresh\"" \
+		trace >refresh.events &&
+	test_line_count = 1 refresh.events &&
+
 	fill 1 2 3 4 5 >one &&
 	test_must_fail git checkout -m @{-1} 2>err &&
 	q_to_tab >expect <<-\EOF &&
-- 
gitgitgadget
