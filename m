Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744E480354
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241713; cv=none; b=FqC/cHgew4Nnul0brD00QvB7PeRROyjAi5+ZAbFvMPNSuho5DmtmdHXWQBgNmnVHltxM+ZPeznHiTJPj9m1Hd25IaVRQNUp7mlgkxvsVm7iqJqDLLUKjcpLnNjfLzq4HaUa4o3jZWBwBmr1dFLgrw1qiU5o3X4ClAuLgMi1SMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241713; c=relaxed/simple;
	bh=NuWGB/bnDbbBk9na+7aHqvkzgGpV/PYID+bSD43WBz4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TYzuCDWjj3UxIY+Wdm6e7j027cRygAFlhepIjYmcl3X5ZSB1/1mY1gIXQEp+TQ2hKdbXMB8id40ZQysbJ31mWE+xuUuJ6Aj9oooR0cZHvPcqWaeda2THot3dVRrlIofALlycvWQkAh8RlL2zhFwJrykqLuaYZPMjTvdHq6dzVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDjUzAY4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDjUzAY4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93efc0452b5so49433285a.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241711; x=1792846511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sPWo22+g329eo981DTmou3bSa+JbkzPXcNQk4xxRc9g=;
        b=cDjUzAY4vkvKciVzt1GUt0rebWTtN5dgWp0B7H27YanOSZCAniKMld+XGu5fmHh/k7
         hNmgp8rJEDSV/Myu6VQObiUGU6VIN8qRgqkxAGx3v8HtgoquZW7BD5ihJyUGAb9uXYZX
         0EmVPirAgb8tGssaeHtsEckOdY14GJRdRGzM5zjDzptwg2ezsJxrY7rpV69S0TyMBqJJ
         6cjr75DBscaqG1av1J1M80CEdI3f4NUejR548Z6ayGWdwdtmqugIW/KhA6QE+vasXGsr
         Gq9+kyOdl6iSsoknt6LUfd7VVoamlJ0/sMHDTHPJDkrLMMq2iUTF6wcEi5Elj/cHoq/v
         SQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241711; x=1792846511;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPWo22+g329eo981DTmou3bSa+JbkzPXcNQk4xxRc9g=;
        b=ttHbRbq/K1dW2ZiUvhlT9km5TaoSdb/7cUtL9+Ce8HaBRUVklh3oE/dqnHUIxXagip
         VcvLyobnZJ/YWFvab/8k06JjPk4LzxPMX8BUw3bUKOGgi9Hqn19OlkULw4J3YeOB0WeQ
         efRXOBNYF0UT1VdPadGFxXmSdhDL4E9gYWzu3pIvNDG0+rJwC7gSheE0TNUU8MWMKAIT
         Mwp4ZCeE+2t0kNhazo6C3aVR5NED/QjJ1aulbdEiVcM85lCRCbc6oNf1Hr92TSEv32f2
         Aqp+qWmGK1bXja/uNMFL53yAeRs3nLlm8JkYz8/8U7tgzDWgdteeqM4juENFZmuIQfdF
         4SQQ==
X-Gm-Message-State: AFq9FYKasb935cVIaN5ZJ7EnAHckJBeYXHgILBDQopVUHwJKRs5kSrvU
	a5wM6wrkyh70Mwvckirk9uosXSpPVqgP3NRDtfG3OOMunwnAmKfcQR3DhSQD5p4E
X-Gm-Gg: AYBFou22vWWNel9I9zDfrR4F9uamJjzf19tV/veHzyPAj+IUzdJHlfg8iYump93LiNv
	D6w6Kuqf2fX+O0HRsgc2o6JxXpGIZaVd+qgJGKMNRC8FV4u7ssvkKwsNgao1zbarNjVH2JOqDfE
	LbUiK//M07UyK0vCtVffINRB8iPto6g3vSX+v8/h32sY4Z48SLi/dKOjrp+i5o0DyldevCs7pHB
	XKKDVpF71EOgV/UON85UdM2f2WMtoXCW7LGr780HZmKcmuPcHRk6BdQVpJcvoIMg3r/TxNOLfwG
	n7Exbo+l2XboPAkpBYa3Bvb7ACN63YMEG4CsXfGyIJw7ZsDSpXHNqgGk1dc6rgavHYJBHx9C5SN
	3OzRnTyTagW4n1xoxtFH9tbTpnrZCX+vozBW/Tyjq4FeQiZaRvF3El0nmUAAd+DCTIkerbF7iqe
	PxKQ8bAWiT2NLRVkoT0KaPueN8LAkiJT80Ml6FdWRk7Nx3JjordwzswnR9OFG8U8gObutqeVJF0
	kZJ
X-Received: by 2002:a05:620a:410c:b0:93c:b33a:5ee0 with SMTP id af79cd13be357-93f29d3f0d1mr458244185a.41.1792241711032;
        Sat, 17 Oct 2026 05:55:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb233d2sm46511066d6.32.2026.10.17.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:55:10 -0700 (PDT)
Message-Id: <f1d5c7b5f76b8f7bcdb34b38410f15bcc9178290.1792241702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 12:55:02 +0000
Subject: [PATCH v3 5/5] worktree repair: avoid breaking unrelated .git file
 and gitdir
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Currently, `repair_gitfile()` does not verify whether the worktree ID
recorded in the .git file matches the worktree being repaired, which
can result in an unrelated .git file being corrupted. For instance,
if two worktree directories are swapped without using 'git worktree
move', running 'git worktree repair' in the main worktree accidentally
swaps the links between their .git files and gitdirs.

`repair_worktree_at_path()` proceeds even if it fails to infer the
gitdir path. This can result in the corruption of an unrelated
gitdir. For instance, if we copied a linked worktree to a new location
X, running 'git worktree repair X' in a working tree which does not
belong to the original repository can accidentally overwrite the
gitdir in the original repository (the scope of impact should be
limited to the repository where the command was executed).

Resolve these issues by validating the worktree ID and stopping the
repair when the ID does not match or the gitdir path cannot be
inferred.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 t/t2406-worktree-repair.sh | 57 +++++++++++++++++++++++++++----
 worktree.c                 | 70 +++++++++++++++++++++++++++++++-------
 2 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index d4e53d492b..fa26565d0a 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -56,15 +56,12 @@ test_expect_success 'repair missing .git file' '
 '
 
 test_expect_success 'repair bogus .git file' '
-	test_corrupt_gitfile "echo \"gitdir: /nowhere\" >corrupt/.git" \
+	test_corrupt_gitfile "echo \"contents not started with gitdir:\" >corrupt/.git" \
 		".git file broken"
 '
 
-test_expect_success 'repair incorrect .git file' '
-	test_when_finished "rm -rf other && git worktree prune" &&
-	test_create_repo other &&
-	other=$(git -C other rev-parse --absolute-git-dir) &&
-	test_corrupt_gitfile "echo \"gitdir: $other\" >corrupt/.git" \
+test_expect_success 'repair unlinked .git file' '
+	test_corrupt_gitfile "echo \"gitdir: /nowhere/worktrees/corrupt\" >corrupt/.git" \
 		".git file incorrect"
 '
 
@@ -89,6 +86,42 @@ test_expect_success 'repair .git file from bare.git' '
 	test_cmp expect actual
 '
 
+test_expect_success 'skip unrelated .git file' '
+	test_when_finished "rm -rf corrupt other && git worktree prune" &&
+	git worktree add --detach corrupt &&
+	rm -rf corrupt &&
+	git worktree add --detach other &&
+	mv other corrupt &&
+	cat corrupt/.git >expect &&
+	test_must_fail git worktree repair 2>err &&
+	test_cmp expect corrupt/.git &&
+	test_grep "unrelated .git file" err
+'
+
+test_expect_success 'repair moved worktree whose .git file has extra separators' '
+	test_when_finished "rm -rf side sidemoved && git worktree prune" &&
+	git worktree add --detach side &&
+	mv side sidemoved &&
+	cat sidemoved/.git >expect &&
+	sed s,/,//,g sidemoved/.git | sed s,$,//, >sidemoved/.newgit &&
+	mv sidemoved/.newgit sidemoved/.git &&
+	git worktree repair sidemoved 2>err &&
+	test_cmp expect sidemoved/.git &&
+	test_grep "gitdir incorrect" err
+'
+
+test_expect_success WINDOWS 'repair moved worktree whose .git file uses backslash' '
+	test_when_finished "rm -rf side sidemoved && git worktree prune" &&
+	git worktree add --detach side &&
+	mv side sidemoved &&
+	cat sidemoved/.git >expect &&
+	sed s,\/,\\\\,g sidemoved/.git >sidemoved/.newgit &&
+	mv sidemoved/.newgit sidemoved/.git &&
+	git worktree repair sidemoved 2>err &&
+	test_cmp expect sidemoved/.git &&
+	test_grep "gitdir incorrect" err
+'
+
 test_expect_success 'invalid worktree path' '
 	test_must_fail git worktree repair /notvalid >out 2>err &&
 	test_must_be_empty out &&
@@ -113,6 +146,18 @@ test_expect_success 'repo not found; .git not referencing repo' '
 	test_grep ".git file does not reference a repository" err
 '
 
+test_expect_success 'repo not found; .git not for worktree' '
+	test_when_finished "rm -rf side other-repo && git worktree prune" &&
+	test_create_repo other-repo &&
+	git worktree add --detach side &&
+	cat .git/worktrees/side/gitdir >expect &&
+	cp -R side other-repo/side &&
+	test_must_fail git -C other-repo worktree repair side >out 2>err &&
+	test_cmp expect .git/worktrees/side/gitdir &&
+	test_must_be_empty out &&
+	test_grep ".git file is not for a linked worktree" err
+'
+
 test_expect_success 'repo not found; .git file broken' '
 	test_when_finished "rm -rf orig moved && git worktree prune" &&
 	git worktree add --detach orig &&
diff --git a/worktree.c b/worktree.c
index 879941a977..31137018d9 100644
--- a/worktree.c
+++ b/worktree.c
@@ -637,12 +637,45 @@ int other_head_refs(struct repository *repo,
 	return ret;
 }
 
-static const char *get_worktree_id(const char *dotgit_contents)
+static int get_worktree_id(struct strbuf *worktree_id,
+			   const char *dotgit_contents)
 {
-	const char *slash = find_last_dir_sep(dotgit_contents);
-	if (!slash)
-		return "";
-	return slash + 1;
+	const char *id_end;
+	const char *id;
+	const char *prefix_end;
+	const char *prefix = "worktrees";
+	int prefixlen = strlen(prefix);
+
+	id_end = dotgit_contents + strlen(dotgit_contents);
+
+	/* skip trailing separators */
+	while (dotgit_contents < id_end && is_dir_sep(*(id_end - 1)))
+		id_end--;
+	if (id_end == dotgit_contents)
+		return 1;
+
+	id = id_end;
+
+	/* find the last separator */
+	while (dotgit_contents < id && !is_dir_sep(*(id - 1)))
+		id--;
+	if (id == dotgit_contents || id == id_end)
+		return 1;
+
+	prefix_end = id - 1;
+
+	/* skip repeated separators */
+	while (dotgit_contents < prefix_end && is_dir_sep(*(prefix_end - 1)))
+		prefix_end--;
+
+	/* check for "/worktrees" */
+	if (prefix_end - dotgit_contents < prefixlen + 1 ||
+	    strncmp(prefix_end - prefixlen, prefix, prefixlen) ||
+	    !is_dir_sep(*(prefix_end - prefixlen - 1)))
+		return 1;
+
+	strbuf_add(worktree_id, id, id_end - id);
+	return 0;
 }
 
 /*
@@ -658,6 +691,7 @@ static void repair_gitfile(struct worktree *wt,
 	struct strbuf repo = STRBUF_INIT;
 	struct strbuf backlink = STRBUF_INIT;
 	struct strbuf contents = STRBUF_INIT;
+	struct strbuf worktree_id = STRBUF_INIT;
 	const char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	char *path = NULL;
@@ -692,8 +726,11 @@ static void repair_gitfile(struct worktree *wt,
 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 		err == READ_GITFILE_ERR_IS_A_DIR)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
-	else if (err || !is_git_directory(backlink.buf))
+	else if (err)
 		repair = _(".git file broken");
+	else if (get_worktree_id(&worktree_id, dotgit_contents) ||
+		 strcmp(worktree_id.buf, wt->id))
+		fn(1, wt->path, _("unrelated .git file"), cb_data);
 	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
 	else if (use_relative_paths == is_absolute_path(dotgit_contents))
@@ -712,6 +749,7 @@ done:
 	strbuf_release(&gitdir);
 	strbuf_release(&backlink);
 	strbuf_release(&contents);
+	strbuf_release(&worktree_id);
 }
 
 static void repair_noop(int iserr UNUSED,
@@ -809,18 +847,20 @@ static ssize_t infer_backlink(struct repository *repo,
 			      const char *dotgit_contents,
 			      struct strbuf *inferred)
 {
-	const char *id;
+	struct strbuf worktree_id = STRBUF_INIT;
 
-	id = get_worktree_id(dotgit_contents);
-	if (!*id)
+	if (get_worktree_id(&worktree_id, dotgit_contents))
 		goto error;
-	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
-	if (!is_directory(inferred->buf))
+	repo_common_path_replace(repo, inferred,
+				 "worktrees/%s", worktree_id.buf);
+	if (!is_git_directory(inferred->buf))
 		goto error;
 
+	strbuf_release(&worktree_id);
 	return inferred->len;
 error:
 	strbuf_reset(inferred); /* clear invalid path */
+	strbuf_release(&worktree_id);
 	return -1;
 }
 
@@ -888,6 +928,12 @@ void repair_worktree_at_path(struct repository *repo,
 		   cb_data);
 		goto done;
 	}
+	if (!inferred_backlink.len) {
+		fn(1, dotgit.buf,
+		   _("unable to locate repository; .git file is not for a linked worktree"),
+		   cb_data);
+		goto done;
+	}
 
 	/*
 	 * If we got this far, either the worktree's .git file pointed at a
@@ -905,7 +951,7 @@ void repair_worktree_at_path(struct repository *repo,
 	 * in the *original* repository, not in the "copy" repository).
 	 * Therefore, we prioritize inferred_backlink over backlink.
 	 */
-	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf))
+	if (fspathcmp(backlink.buf, inferred_backlink.buf))
 		strbuf_swap(&backlink, &inferred_backlink);
 
 	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
-- 
gitgitgadget
