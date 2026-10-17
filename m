Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21410332EBD
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241706; cv=none; b=aoOJogDsNz0vKOhff+jKD9TSd1CcAmG4w4vwb0FD/H+FXIZwkNnk/7R2Q+sSb4Qwmktcmnw4q8Z+GeBXPaAwyRe+udY1OyNfLDzOpA9WF+KokOSLvG2VwvwSJiUegDU3Le0S6w8ajypolPqvzi0+flSOpHpP+2RGzVxEpj7z1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241706; c=relaxed/simple;
	bh=5guW0C7/uCcF4SDHjyIahuJZ/e/L0WqNorLlRf6/vbY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sQ+gfNzsaoDg8GwlMXd+0AHNKdzAgOKYADPnz6kQEUE7ZWECuPAVxAV9tOk5M+Pggg1D2L2xaU7ZcjTS/7W/Bigba6N4XyBozkq5kYR1MlahSRGdynU1OUQySW5bVBD24Tie9aNcM5+8o52CUCT8BXsAS4xSTq+3wagGy1nXEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlpwBv8V; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlpwBv8V"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53653e30353so3691061cf.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241704; x=1792846504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oqNTRHKeWy973kqNIDKlL9QGVmhtHgyOWiRVMjN8W2Q=;
        b=ZlpwBv8Vl5+LU8lpN0GcDDGMNt/Xfl+DowieTArXxpEge//dkCiqdgL5A2bvNetSYB
         rpMvV+dAxYycij5H9ntK28lkeExRp0+jKKUoEAug9H+c4aCNDMsD62uGzmXcL45IaQ6V
         XUY8m8X6ThuoP5DDGF2E/tSseNSH+7FlrNz8aq6HT0fLW0lDWsNubwsiGlQQyhsSu6PW
         eHtVpm/zX3Yvp4hhS8h3b4xsOvKA8CoDwqu+xQOq0cNutfjAsfRgwWbEbiu3Dy9FnzMV
         R0CbrxGkXK/5MN8l1ZomGxHctfVjRsTDdZOZO6ek1aK478y8QggGk4f8eM++dGl4btXw
         6gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241704; x=1792846504;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqNTRHKeWy973kqNIDKlL9QGVmhtHgyOWiRVMjN8W2Q=;
        b=CSOkA87vJZ5S5amTIZPzGJjo3HD2Exw0ygYGuuvbJ/GaWoqjWgU7iPc+TNgk5xyHyb
         ZdqSsMCDkMEvDMkfWz+jxa4jcHa0PRhs83zvpKJc90zy93nysvENySI5xfdKRsE0gUsI
         vwylKrMcn96Ay4Ici5T0qt/Pal9yECbxJHCWi5xlbcfoc+YozOr4ZIHnA/Qeh06921kW
         my/ggEAJDyi60dlQY4vv3TFPvGsxASP75m5Ptp2OIi/vvQu0Ong6OOCeFRIKWbX9011v
         cp5AafcGhFRO3bLEoS/QxJe5iiZNitfFrNjE9LZc30SsvycV5eKKnNeCF7u0TWu2p5ek
         MpoA==
X-Gm-Message-State: AFq9FYKiHvuHUHv78z4tuSrFnuFfmLsL9rkdVL5kqVtzLDxZzS3GbxsG
	BTqxKi3ro1+ajszQCNeZGuVmAX6E9bX3uEbUuV4Yc0Mmjfke3VMQq2bs7JuSzw==
X-Gm-Gg: AYBFou1XT6DiGKyd3MT1LfFmwp31l9gD7ruqEq72gNVBGXvBB3eg6vzI1El5OmFT6dW
	WC/v4/c3WKklCKWKaZbGSem9G0HzBabhPBHbaWfqHavQ/9wY4CZeKz82WDVPFBlAY3w2bViTay+
	gGFHnfyYFIgGacYGzOW4JQR8L1amC2yyeWDE/6+XiIaK30QTMWUoImE0VlUT0RjAnUPNvBz9E9f
	UWLSPEtV2TLdlpcybR1P0OpmFpzIukx8SIV91oRwL87mJCBzkspXSOCqLtPkQ9o7W4EIGaCWXHj
	sc1ZGYGmRcZovHN4UNCLjI0RK0ke9gQqRrhe6NHRtY/do0RykH1sRz7t0krCZ+mZkK/xk5RsGiZ
	5TZEJMtlVfKdn2H7VLiSruZ37mCz8QAahYkb/4EUmu9SqJanpcgmGO6M3fe9NwwuZtkdgXkMHQI
	iuYOyDppe2UwKjo1c9miNhkL0dTSqAFVYJGjAUZN2iGrJfs9C11eBnUm2ttsxedayraDjKjyZdw
	C5xG76l0l5hBg==
X-Received: by 2002:a05:622a:e607:20b0:535:1a83:124e with SMTP id d75a77b69052e-53645feb1e1mr24282781cf.28.1792241703936;
        Sat, 17 Oct 2026 05:55:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8e5831sm48779191cf.10.2026.10.17.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:55:03 -0700 (PDT)
Message-Id: <pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 12:54:57 +0000
Subject: [PATCH v3 0/5] worktree repair: avoid breaking unrelated .git file and gitdir
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
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree repair' does not sufficiently validate the cross-references
between a linked working tree and its administrative data before repairing
them. This can cause the repair to modify the wrong .git file or gitdir in
certain situations.


v3
==

Make the separator check in get_worktree_id() more lenient.

 * [1/5] align .git file handling with repair_gitfile()
 * [2/5] centralize inferred backlink selection
 * [3/5] use read_gitfile_raw() in infer_backlink()
 * [4/5] reduce .git file reads
 * [5/5] avoid breaking unrelated .git file and gitdir


v2
==

Split the first commit of v1 to make the changes easier to understand. Fold
long lines.

 * [1/5] align .git file handling with repair_gitfile()
 * [2/5] centralize inferred backlink selection
 * [3/5] use read_gitfile_raw() in infer_backlink()
 * [4/5] reduce .git file reads
 * [5/5] avoid breaking unrelated .git file and gitdir


v1
==

This series first refactors the code to read the .git file once and extract
the worktree ID, then uses that information to validate the repair target
before modifying the cross-references.

 * [1/2] Refactor the code without changing functionality before making the
   fix
 * [2/2] Validate the worktree ID and inferred gitdir path before repairing

Yoichi NAKAYAMA (5):
  worktree repair: align .git file handling with repair_gitfile()
  worktree repair: centralize inferred backlink selection
  worktree repair: use read_gitfile_raw() in infer_backlink()
  worktree repair: reduce .git file reads
  worktree repair: avoid breaking unrelated .git file and gitdir

 t/t2406-worktree-repair.sh |  57 ++++++++++++--
 worktree.c                 | 153 ++++++++++++++++++++++++-------------
 2 files changed, 152 insertions(+), 58 deletions(-)


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2225%2Fyoichi%2Fworktree-repair-keep-unrelated-gitfile-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2225/yoichi/worktree-repair-keep-unrelated-gitfile-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2225

Range-diff vs v2:

 1:  21b2878aa5 = 1:  e336afa029 worktree repair: align .git file handling with repair_gitfile()
 2:  30ac7acad3 = 2:  86021f31af worktree repair: centralize inferred backlink selection
 3:  2cc7b817ee = 3:  7087e829bb worktree repair: use read_gitfile_raw() in infer_backlink()
 4:  8c80b9ae05 = 4:  e35285a4ea worktree repair: reduce .git file reads
 5:  015602168c ! 5:  f1d5c7b5f7 worktree repair: avoid breaking unrelated .git file and gitdir
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair .git file from bare.git'
      +	test_cmp expect corrupt/.git &&
      +	test_grep "unrelated .git file" err
      +'
     ++
     ++test_expect_success 'repair moved worktree whose .git file has extra separators' '
     ++	test_when_finished "rm -rf side sidemoved && git worktree prune" &&
     ++	git worktree add --detach side &&
     ++	mv side sidemoved &&
     ++	cat sidemoved/.git >expect &&
     ++	sed s,/,//,g sidemoved/.git | sed s,$,//, >sidemoved/.newgit &&
     ++	mv sidemoved/.newgit sidemoved/.git &&
     ++	git worktree repair sidemoved 2>err &&
     ++	test_cmp expect sidemoved/.git &&
     ++	test_grep "gitdir incorrect" err
     ++'
     ++
     ++test_expect_success WINDOWS 'repair moved worktree whose .git file uses backslash' '
     ++	test_when_finished "rm -rf side sidemoved && git worktree prune" &&
     ++	git worktree add --detach side &&
     ++	mv side sidemoved &&
     ++	cat sidemoved/.git >expect &&
     ++	sed s,\/,\\\\,g sidemoved/.git >sidemoved/.newgit &&
     ++	mv sidemoved/.newgit sidemoved/.git &&
     ++	git worktree repair sidemoved 2>err &&
     ++	test_cmp expect sidemoved/.git &&
     ++	test_grep "gitdir incorrect" err
     ++'
      +
       test_expect_success 'invalid worktree path' '
       	test_must_fail git worktree repair /notvalid >out 2>err &&
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repo not found; .git not refere
      
       ## worktree.c ##
      @@ worktree.c: int other_head_refs(struct repository *repo,
     - static const char *get_worktree_id(const char *dotgit_contents)
     + 	return ret;
     + }
     + 
     +-static const char *get_worktree_id(const char *dotgit_contents)
     ++static int get_worktree_id(struct strbuf *worktree_id,
     ++			   const char *dotgit_contents)
       {
     - 	const char *slash = find_last_dir_sep(dotgit_contents);
     +-	const char *slash = find_last_dir_sep(dotgit_contents);
      -	if (!slash)
     -+	const char *prefix = "/worktrees";
     +-		return "";
     +-	return slash + 1;
     ++	const char *id_end;
     ++	const char *id;
     ++	const char *prefix_end;
     ++	const char *prefix = "worktrees";
      +	int prefixlen = strlen(prefix);
     -+	if (!slash ||
     -+	    slash - dotgit_contents < prefixlen ||
     -+	    strncmp(slash - prefixlen, prefix, prefixlen))
     - 		return "";
     - 	return slash + 1;
     ++
     ++	id_end = dotgit_contents + strlen(dotgit_contents);
     ++
     ++	/* skip trailing separators */
     ++	while (dotgit_contents < id_end && is_dir_sep(*(id_end - 1)))
     ++		id_end--;
     ++	if (id_end == dotgit_contents)
     ++		return 1;
     ++
     ++	id = id_end;
     ++
     ++	/* find the last separator */
     ++	while (dotgit_contents < id && !is_dir_sep(*(id - 1)))
     ++		id--;
     ++	if (id == dotgit_contents || id == id_end)
     ++		return 1;
     ++
     ++	prefix_end = id - 1;
     ++
     ++	/* skip repeated separators */
     ++	while (dotgit_contents < prefix_end && is_dir_sep(*(prefix_end - 1)))
     ++		prefix_end--;
     ++
     ++	/* check for "/worktrees" */
     ++	if (prefix_end - dotgit_contents < prefixlen + 1 ||
     ++	    strncmp(prefix_end - prefixlen, prefix, prefixlen) ||
     ++	    !is_dir_sep(*(prefix_end - prefixlen - 1)))
     ++		return 1;
     ++
     ++	strbuf_add(worktree_id, id, id_end - id);
     ++	return 0;
       }
     + 
     + /*
     +@@ worktree.c: static void repair_gitfile(struct worktree *wt,
     + 	struct strbuf repo = STRBUF_INIT;
     + 	struct strbuf backlink = STRBUF_INIT;
     + 	struct strbuf contents = STRBUF_INIT;
     ++	struct strbuf worktree_id = STRBUF_INIT;
     + 	const char *dotgit_contents = NULL;
     + 	const char *repair = NULL;
     + 	char *path = NULL;
      @@ worktree.c: static void repair_gitfile(struct worktree *wt,
       	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
       		err == READ_GITFILE_ERR_IS_A_DIR)
     @@ worktree.c: static void repair_gitfile(struct worktree *wt,
      -	else if (err || !is_git_directory(backlink.buf))
      +	else if (err)
       		repair = _(".git file broken");
     -+	else if (strcmp(get_worktree_id(dotgit_contents), wt->id))
     ++	else if (get_worktree_id(&worktree_id, dotgit_contents) ||
     ++		 strcmp(worktree_id.buf, wt->id))
      +		fn(1, wt->path, _("unrelated .git file"), cb_data);
       	else if (fspathcmp(backlink.buf, repo.buf))
       		repair = _(".git file incorrect");
       	else if (use_relative_paths == is_absolute_path(dotgit_contents))
     +@@ worktree.c: done:
     + 	strbuf_release(&gitdir);
     + 	strbuf_release(&backlink);
     + 	strbuf_release(&contents);
     ++	strbuf_release(&worktree_id);
     + }
     + 
     + static void repair_noop(int iserr UNUSED,
      @@ worktree.c: static ssize_t infer_backlink(struct repository *repo,
     - 	if (!*id)
     + 			      const char *dotgit_contents,
     + 			      struct strbuf *inferred)
     + {
     +-	const char *id;
     ++	struct strbuf worktree_id = STRBUF_INIT;
     + 
     +-	id = get_worktree_id(dotgit_contents);
     +-	if (!*id)
     ++	if (get_worktree_id(&worktree_id, dotgit_contents))
       		goto error;
     - 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
     +-	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
      -	if (!is_directory(inferred->buf))
     ++	repo_common_path_replace(repo, inferred,
     ++				 "worktrees/%s", worktree_id.buf);
      +	if (!is_git_directory(inferred->buf))
       		goto error;
       
     ++	strbuf_release(&worktree_id);
       	return inferred->len;
     + error:
     + 	strbuf_reset(inferred); /* clear invalid path */
     ++	strbuf_release(&worktree_id);
     + 	return -1;
     + }
     + 
      @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
       		   cb_data);
       		goto done;

-- 
gitgitgadget
