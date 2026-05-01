Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F672DB798
	for <git@vger.kernel.org>; Fri,  1 May 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648816; cv=none; b=TXf5urSKfTmDTr70nPE5l84WNaEySfyJXO1q+azZNhcn64olLxvuwwe5nE7MOTzAuhrp9OvCFHRZSnT3iNMLGfVCKgeijoaX6xUInFxGqQGVoA5s61hJNHH/N91dioBZSi0GDN/BdlRHPPLJAsI74bSHGeaEtMyudV8WbTw/t7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648816; c=relaxed/simple;
	bh=2qfD1dcY0rQ7d+BzAhQmdyO5oyZIWqUPtm/h+jY7A34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNBM5Kx1jDhw0xDpWA1XLCykJ9mN6GHc1oJOGeg/4FZCcUIQsSdZ87xdbAcgwRis5asDTjfroeCwV4PLV2zHxa2Ybv95KLmDQMlIAiJsj7dqSMzR1j0LzFZF2AS0qjpG6pGil5YMp8/rJG4PrOGiCGyFcpdngSWv/gWh+YD5JM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOhJmYz/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOhJmYz/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso14082315e9.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777648814; x=1778253614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJyqF2Rwn9xPfPS1s19i3k8kB4DCYzOCcY7xpWup7tM=;
        b=oOhJmYz/2L2OHYd2SkUnRSC3k6RTWWy6iyxAumW4/xGUb78/LNiaoei8D9iyAl3e94
         JmB5H+JNCxTtm4x+C/PjC8dc34N1mmCDCDSHe3+Y3XdEfILc+V1nXc0V7tfdGJK1/hMt
         o0DwrQyzubktfDguTWxXPmScEXhv8hTerqKFlCLEicYV/vNTfRtKf96BWMxnkKWvPXVS
         kOEHqulQa3eQ3KUgBKgD+taFqXtedPfgV82mCzxf2GbE+PRssMJ6UNIvgth7dC3VePe/
         kwHOiIZLBZCaanOugVLLUDO6norgSp4F1vZbE2KBQNSuBd2yUvuRT1yHjNQkhSO7FaI7
         MCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648814; x=1778253614;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJyqF2Rwn9xPfPS1s19i3k8kB4DCYzOCcY7xpWup7tM=;
        b=F5lYWu9tTz+sd0ggOUEl21WOryEq5tuzfsSrUSi1ZnYrmgDcS4s7lMXmcPJiQHiG2E
         tNIlaZpRHKFOYgAeY3h4uyQOPuba+u9bgNSMEFp2M4hTGGLWSaH9M4Gzmggd9iamzjUv
         X/vtgOE03p7jcF+c7YlZfoyG7XyPYzqtBXSrdmFn/TgL5NBy310sKoAp8Yj48LPoQUip
         0XMTl3Voxz4oXgm0a8KdsZXq5UDBKl+flVOc23GjVIG1RWHcFn9lef1w3KMiGEvlqFsa
         5y4G/fTd3J7Koa23H2Dj8nykwY322m87wnUojELlBp7saFPFQvpCt4sdc3GbkMdChq9/
         S23g==
X-Gm-Message-State: AOJu0Yz0P9ZbpDJz/ktuInTEXQwuyQqEB8TIbKbyHKqTxhnf49rGm3w7
	jcb+rBbSWYiN7/or8Af9CoQDaCm0yj/5l/CW7W1155ezUq3djO71amk+Tck8dg==
X-Gm-Gg: AeBDievL1aUJNG75Cq+ZP3ACL1pz8ZsTIHGTsAnWo428KxuaqD52FJhFQ23jWrWtT97
	7C2/Poa4wlXRaiwotiGEJ84iKEbmPRQmO4bC8ShBLNc4zW8WtYvRHTvh6O6mxPOcXgaQ2W/sUMB
	4gzbM8/ZMvg8nwZ90Rp32YMbI/mPFlIF19MkfcgErGsaPzcatYTQC7wQ/OG3ojvi9B2X1VH6byo
	9pIv61ICVKKCld4bF3BtpgTp9nn/sxCVXV5Eo+kgPVpK+uF6+uQ6ii4gux4i0KNy/xkULSEFsLz
	bMwqKSuy6Xrd3At716ZDm0TTWLW6KxzJSwOSrMZy4cBsTJaLuUdOx8UUuLjOHG9Qdo4VDCGsGhy
	0fXgeN4J/EGmBlDLlpuUSkqsaxNLZ7k/Koy8WKrtXGBBBWkUdUXjQWT9ZtNmyw8gkC6LTUvQjwT
	6B0fPH46MIK+LObIC/QkuFdZHV0ASvXBrNP0seXZ8=
X-Received: by 2002:a05:600c:a413:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48a8eb8a430mr48205175e9.16.1777648813818;
        Fri, 01 May 2026 08:20:13 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm61464045e9.5.2026.05.01.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:20:13 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] worktree: rename get_worktree_from_repository()
Date: Fri,  1 May 2026 16:20:00 +0100
Message-ID: <bd48396137f8d1352d11b3bd2dca2848f24a347d.1777648798.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

get_worktree_from_repository() returns a struct worktree that
describes the worktree that the repository argument would operate
on. Since 0f779147602 (worktree: remove "the_repository" from
is_current_worktree(), 2026-03-26) that worktree is always the
"current" worktree. Change the name to get_current_worktee() to
reflect better what the function does.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Base-Commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frename-worktree-from-repository%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/94f057755...bd4839613
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rename-worktree-from-repository/v1

 worktree.c  | 2 +-
 worktree.h  | 2 +-
 wt-status.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index d874e23b4e..340b4ed777 100644
--- a/worktree.c
+++ b/worktree.c
@@ -66,7 +66,7 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
-struct worktree *get_worktree_from_repository(struct repository *repo)
+struct worktree *get_current_worktree(struct repository *repo)
 {
 	struct worktree *wt = xcalloc(1, sizeof(*wt));
 	char *gitdir = absolute_pathdup(repo->gitdir);
diff --git a/worktree.h b/worktree.h
index d19ec29dbb..1075409f9a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -42,7 +42,7 @@ struct worktree **get_worktrees_without_reading_head(void);
  * Construct a struct worktree corresponding to repo->gitdir and
  * repo->worktree.
  */
-struct worktree *get_worktree_from_repository(struct repository *repo);
+struct worktree *get_current_worktree(struct repository *repo);
 
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
diff --git a/wt-status.c b/wt-status.c
index 479ccc3304..c12fca7078 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1827,7 +1827,7 @@ void wt_status_get_state(struct repository *r,
 	struct stat st;
 	struct object_id oid;
 	enum replay_action action;
-	struct worktree *wt = get_worktree_from_repository(r);
+	struct worktree *wt = get_current_worktree(r);
 
 	if (!stat(git_path_merge_head(r), &st)) {
 		wt_status_check_rebase(wt, state);
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

