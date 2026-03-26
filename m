Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F5388E40
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534656; cv=none; b=eWgQaSKTZlADWwt1slDKZ6LSjcALkLVVlnyyfTk2gnIFi7awPSdJeW/kTVqUvweNj+pnWMQuunw/AF4/m+CTH82OahAqeBUDDh+oWWM9HQzS0C3mTKsL8/BXbeCxM1HGnZ/aAnWFnoTPxcNP1u79p1vkzXYYwmgY3yeVL/J8LA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534656; c=relaxed/simple;
	bh=h7BIvOBR6UKPqyQYODPm5CEgvricrOWeoNYeLZMDh2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfK3Cw/VWTd9zJaZugpOxHoULVv70CtdK6k+ZxiW+mA5k95p9LqOvCxHrG2LUgk7agHUPy4EBy3TpzZwQGLgswKuQTVlUoxDtrlJt319rRpQGZfknUqN/or7XmqDbfGAEwZAS18HegfZ9VCwCu2oQPFW2sP4NSk9dy2IrcW2HXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddi52dqZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddi52dqZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48704db565eso14599065e9.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534648; x=1775139448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FKdjVXd8JnJRVsD3M9liuW5L8D8je5BHbK22GMe1G5U=;
        b=ddi52dqZXNRuStYXJsEDMMtE2zc+L68F9hV2Vpj+sQNiP7gaQtWVGDGPpD59QdeVCO
         l+cz3hJIEKngPlymGsbfHravtGfYMKslweM2BqrLz+L5mqhhGviHow+6A5Om+gH6Sxru
         5odkYFL7e2DfylvDpvDM5QFXyn+E8/5aVKrWeRZQipoxPDGPZymlQXLbtQqdtGavDgyA
         1NEzXvzT8XwRRP78ddr1ygu8f/XCdi/N3pdJGqtApWhs1A99L8uhyRO4MV9JGyquzBAn
         4ORLszJ8nmpvdCc2/f/EdCN/PZENlbGTMJJaIPKjpFaFs6edAfhVGYr8pPE7h+92NR/K
         eysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534648; x=1775139448;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKdjVXd8JnJRVsD3M9liuW5L8D8je5BHbK22GMe1G5U=;
        b=aufvLegPkx3AKRGj+2ik5kL3vJtXBOEulLqVUEvUVhuQPkor4WZregNvG2coydQD17
         hTIAnt5vBeaxkbACyB/cMR+zUgqRakldWHnM1kEXXS9PZZarVC+O4rB9659rVNzebqwx
         VNe9I7hJjCP2zUWft5/mrHmbUVykVEAoDUpzUxxNqlhIi4OVncpeXdt37gUp2k6EPkd1
         mtf9XubS+/HKNyiZKGae41oCxEZej/iJ501KXXNInhJFbE58ZAjIKYyI/muCJGos8JJP
         j8+Cwc9Svi0rNNI4hztvKL1Ezqqo3IWAhlKcJ3CiBiyDiKvCXJlTwWBX8WstxAjNan+e
         gWwQ==
X-Gm-Message-State: AOJu0YwrKfVJnfKYgAj8jSPdWswGN8jNQr2ddRTLapYc4MNeZJGHK9Z4
	EppHDdML2sgFVsxCwHqvyyWzHENq1+dRvF4+ngVPYugDKPcWhjewyff/DXLtbw==
X-Gm-Gg: ATEYQzwHApCbDWLwibQL0mmtlU74SPSDFJKkYQ19uNGjZRkH+P2wKSIyCP22cQyAN2T
	upGt3B+NYravyiAodsTTzFQWBPKPDs72HU3G4eWnmFbPpbE/RoeCw9GIaMV0UGnWjbdsHFxXReb
	ieuRRtCtPwbKlDOphCiOsfKe8vvHt+PIAD1rkufykL0FFZ6YESe2LXYq/x4z8Ao6aoKgTgcGEVi
	MR50ff+PS7BYos5W6yWYntMCBg5DOEvzz0pEwNrUXZDBbkoDWbc/bZk+FK3QyemMAsrJ/tZernG
	dkBBLxCSTwll/8OSko57FE7lq0lKijFXn3s/EQfPcujVNrO6kbRa8iIDv8Lm372UXBN/lN5Uv6L
	nzaAVI3sLzx0ayZVmuo8BP4wX2ZdLC+TPoKhVhNSTTWhmSow67Xq5F73KjQ9lQLcW14GYLqoXhL
	LilMFZehTLrOaa8TcQejPzc8xm34b61w4rIWUd1Q==
X-Received: by 2002:a05:600c:4705:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-487160a2a33mr123392745e9.31.1774534647157;
        Thu, 26 Mar 2026 07:17:27 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720901b90sm15507775e9.17.2026.03.26.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:17:26 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/3] worktree: remove "the_repository" from is_current_worktree()
Date: Thu, 26 Mar 2026 14:16:57 +0000
Message-ID: <5357c0dd53ee123a4ea064412c83983b0be5e400.1774534617.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1774534617.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk> <cover.1774534617.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The "is_current" member of struct worktree was added in 750e8a60d69
(worktree.c: mark current worktree, 2016-04-22) and was used in
8d9fdd7087d (worktree.c: check whether branch is rebased in another
worktree, 2016-04-22) to optionally skip the current worktree when
seeing if a branch is already checked out in die_if_checked_out().

To determine if a worktree is "current" is_current_worktree() compares
the gitdir of the worktree to the gitdir of "the_repository"
and returns true when they match. To get the gitdir of the
worktree it calls get_workree_git_dir() which also depends on
"the_repository". This means that even if "wt->path" matches
"wt->repo->worktree" is_current_worktree(wt) will return false when
"wt->repo" is not "the_repository". Consequently die_if_checked_out()
will fail to skip such a worktree when checking if a branch is already
checked out and may die errounously. Fix this by using the worktree's
repository instance instead of "the_repository" when comparing gitdirs.

The use of "the_repository" in is_current_wortree() comes from
replacing get_git_dir() with repo_get_git_dir() in 246deeac951
(environment: make `get_git_dir()` accept a repository, 2024-09-12). In
get_worktree_git_dir() it comes from replacing git_common_path() with
repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
in favor of `repo_common_path()`, 2025-02-07). In both cases the
replacements appear to have been mechanical.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 worktree.c | 8 ++++----
 worktree.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

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
diff --git a/worktree.h b/worktree.h
index e450d1a3317..94ae58db973 100644
--- a/worktree.h
+++ b/worktree.h
@@ -16,7 +16,7 @@ struct worktree {
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
-	int is_current;
+	int is_current;		/* does `path` match `repo->worktree` */
 	int lock_reason_valid; /* private */
 	int prune_reason_valid; /* private */
 };
-- 
2.52.0.362.g884e03848a9.dirty

