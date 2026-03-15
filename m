Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6D366572
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591552; cv=none; b=TQ4p+WzFsRBftCwTQtY6ViY+k/L8yYVWD78bzHDCt3XTRrtpsCm9KAdC9CLZAYvz41vChA3558kH5S7vfNCQiRaSfgjQ2/5bNj2Quv/6csbRabXzSir+vKFpJxBvjMDWAhup6Z3ukQCEuCJuosjeHP1dM+kP6P8K+1EkXR6zd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591552; c=relaxed/simple;
	bh=frzaapeFAv8gU+MaIZUOzC0gloaTOdxogXiCzKZXbDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWOTJhqHQKQcCGu+tTnY5DBH+K1S3QoE9Q9LFfuJEgn4lynkXtqAG/pYnfvc0qbDXK3MuqRWeFBdHl+QcKsJgEksJzQudnTQvEKrs100cGVFaMeWruRuz8o+sveFbPMXyFqaAf3sfnqdWg5QMmrwzUX+3Gjgi9tJw7d/RmZ9N+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EffS6EqL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EffS6EqL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852ff06541so41901225e9.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773591549; x=1774196349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGQlZoMUqO616K9o5ti3oYPnh8TRRW8WdJNw2STC+QY=;
        b=EffS6EqLX/2Ylq+E4bQ15w9z0sPB0iHAoCHrlWHdju3+CJZdnQtMGHenGEw4hSSrAj
         EBYwNo3SSTynqSA4ZS9Lyeqz4uVvGQWMnZEqEORr1NlPfRi521AiqgOrXkN+KGE5ShU3
         72/YYCd0wrrdYDjNzDs2yVHm9Uv4WVl/pCfL4YZsvV6zrvU7aE5yeeBwEuULOQBPXCVG
         cYTL6F8w7GPlWO9I0v9QEyThb7Jt0IkS4WYE8eiCbKJ26xH2Dy8kNOv1OMX5v6u6q+5K
         oMBwE+azwFlT1AKErRDfR9S3MrJxO3qnwk+JkvPK1OrY1ps28EwPxSsQzqNABI/WZAVi
         ylnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773591549; x=1774196349;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGQlZoMUqO616K9o5ti3oYPnh8TRRW8WdJNw2STC+QY=;
        b=osKU/C3zMgosruOtgTsqQRT2aPpMPzYw/LQMP6OULcuIQB2fAqBEcV2cF4I/S9MzSa
         5sHAgz/oDwoHQfTl3YwP6mbDnhcvmMC7rUrinHbE+Cy4sQkwmuImO4xZRjB6JM4nz85G
         b+FtKomjzo5x6HPwc5MbGV/rZDxYxvAGHa/kzbDYaykLgilVbyGHhzAJALvgml/8J8a5
         b2xolV4savopSsYtEtQQWUPu8++n7eeNuVhNNDj/Pr7jDpFDKPplWbTDGbl9sF+TM2qF
         B45PhYjmp53JzBbZP7SoIHiBRGxBeifSLTF0WpfUaMO5Hy/CL1x88KivL+55Wz21yK64
         9YXQ==
X-Gm-Message-State: AOJu0YyVi5L6Q5bwC6rhRyHSTHrJ8Jdv1kKUl5heZyfRsMrZPwNfhjV2
	pRuGEne/4oakRIL09sF2mwSMU3TQW/2vUPVpKO9XBp0BaV1/ihATy5+rtddvbA==
X-Gm-Gg: ATEYQzwubsWwT6cLPtpm9ZyQhzaFsBOq3ioepCLEgxfqM6wCxOWjMdS7YUhFib0jrCA
	lOOexR1Ci1jMqks7IWay86C2D/dZsdGc62BjfV/i7JuVB4ZwilUDHM8uiHQjwrCSuij0IiwRe6t
	ax9ph+qd+4T+n/SVrEboSQRm3nWo+7AGm8OGFIu539/vBw3xyZHK6Gh9c8/IM99guM+hLgPim5W
	6C6ZPpWmvaPjjmVTfD4KL7mWJVyefIQvxichuPy2XAx5HYgHDvU+Tf7oJS50Pi8lYJFtsDhfai9
	yBuna9VLM8Tiao/dAn2Xv36jESccpX4YqBnFsmlOUPFRzPXndIi4+jNSdUZYlrftEYjzNILCADK
	n1bE9v05xWffQHofOehzqFlU4mf9nwphM2y/hWoUY4oIsJWWIEPj/7SwLQEpEA4Zp+1EHaG7rkR
	F8PqV0SkCzPDlHktbRh9iyLAUHfEUZqodD5MN6Kw==
X-Received: by 2002:a05:600c:1c21:b0:485:5ba3:37d8 with SMTP id 5b1f17b1804b1-4855ba33bf2mr134014235e9.5.1773591548834;
        Sun, 15 Mar 2026 09:19:08 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48558fd09d8sm200476225e9.7.2026.03.15.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:19:08 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/3] worktree: remove "the_repository" from is_current_worktree()
Date: Sun, 15 Mar 2026 16:18:50 +0000
Message-ID: <075700a22568913988c9fa8e1ff49db1a1a5b606.1773591528.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1773591528.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk> <cover.1773591528.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

is_current_worktree() compares the gitdir of the worktree to the gitdir
of "the_repository" and returns true when they match. To get the gitdir
of the worktree it calls get_workree_git_dir() which also depends on
"the_repository". This has the effect that even if "wt->path" matches
"wt->repo->worktree" is_current_worktree(wt) will return false when
"wt->repo" is not "the_repository" which is confusing.

The use of "the_repository" in is_current_wortree() comes from
replacing get_git_dir() with repo_get_git_dir() in 246deeac951
(environment: make `get_git_dir()` accept a repository, 2024-09-12). In
get_worktree_git_dir() it comes from replacing git_common_path() with
repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
in favor of `repo_common_path()`, 2025-02-07). In both cases we have
a repository instance available so use that instead. This means
that a worktree "wt" is always considered current when "wt->path"
matches "wt->repo->worktree" and so the worktree returned by
get_worktree_from_repository() is always considered current.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 worktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index e9ff6e6ef2e..344ad0c031b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -58,7 +58,7 @@ static void add_head_info(struct worktree *wt)
 
 static int is_current_worktree(struct worktree *wt)
 {
-	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
+	char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
 	char *wt_git_dir = get_worktree_git_dir(wt);
 	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
 	free(wt_git_dir);
@@ -78,7 +78,7 @@ struct worktree *get_worktree_from_repository(struct repository *repo)
 	wt->is_bare = !repo->worktree;
 	if (fspathcmp(gitdir, commondir))
 		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
-	wt->is_current = is_current_worktree(wt);
+	wt->is_current = true;
 	add_head_info(wt);
 
 	free(gitdir);
@@ -229,9 +229,9 @@ char *get_worktree_git_dir(const struct worktree *wt)
 	if (!wt)
 		return xstrdup(repo_get_git_dir(the_repository));
 	else if (!wt->id)
-		return xstrdup(repo_get_common_dir(the_repository));
+		return xstrdup(repo_get_common_dir(wt->repo));
 	else
-		return repo_common_path(the_repository, "worktrees/%s", wt->id);
+		return repo_common_path(wt->repo, "worktrees/%s", wt->id);
 }
 
 static struct worktree *find_worktree_by_suffix(struct worktree **list,
-- 
2.52.0.362.g884e03848a9

