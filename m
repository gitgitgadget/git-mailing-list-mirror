Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CE37186C
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591555; cv=none; b=QtFnaPllDv6TWcsEzZRyBShKtMyeYlTw8mQ7VQ9lI1QtHBMmlUZrj8y5SipT5WVnTKj4lEbaDW012KU1c+qqqvy3LC/c0lYCU+Rx6CEUk4IStGUHFIh717K4v2wVGklWBIs+c10SRnWlh/dNiGgaL8gpmrtPxzChjwuv3UrP5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591555; c=relaxed/simple;
	bh=eTQZFoQyYZuwoNQHTCWOofZvoeeoL9Z6I/nJJZj6p7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNNqiSsYLoXhb9rbrz1TFw4FCf14JbAdL3utwLH4bMM68oUx7BppN8CHr/cmMuqL5ZI7Q1DO8Ca+PFZ4mxf/crJyNFSmRBDQ4ChhP/Wl5+ej5jn2xWro4oBONpcmX1wK60D9CoMNs/XdC2eowfYaUShVN5qlwOXCvJpKVM2I0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp1efPvj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp1efPvj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso34524815e9.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773591551; x=1774196351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=573nfqusiJQf3Gvl1YOw8BJajYl3W9OqbwPkH0QKwA4=;
        b=Cp1efPvj8I3X3gpWn+SDOK3NeJAocCMxKmCskkz2nGzwFkcvjPMFGHZyYyr7jEEYTN
         PEYJM1XwjyT4i7+3ncvTN5wjn+KManxmpWRLglaJXIYh5w+O2dSIuayiTAzqFHs9wgju
         wyGFfZxhtYZa27t6t+KmiS/llhq/YndyYPwAkA9rxnlajgWj/AFbsEjMfdAGBirIuSIt
         SncX/MwGUH8U3zqQHZgrF/OkHITXyzvKw0FfZuqcizsh3TjGuk/0A8LmInCnhiGPM9q6
         3Mvv92Eyk1oEeAApJ3QnifeGMZBcmeN5ZN3wh8IXs5iTJ21h65vGaWo09879BWRu/SPl
         aNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773591551; x=1774196351;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=573nfqusiJQf3Gvl1YOw8BJajYl3W9OqbwPkH0QKwA4=;
        b=gA2UvVzIKqhuMB4Z/H/UjcIlmcldd03KBIyHH8G30oiPAHLDW7lQwAtv1dMtn2sc/T
         5Gwux9Q5tELm4JEh3VRetpIdqDxxjOCkFalePSqqMtnLsz3NKXQws6o2/3jgrazs25yH
         OeTzWn/iFQnXerzw8NzLgzW8kf0qSYSu/RQrG0KJ+pHsOCnK3/eXa9gQtPaRT49tOd5a
         J/a5ScYiJcNoU1+suARek3hDdqvUkzf4v1Fl+pFqGOrHkqEMcxtYlszl23jT7H1VV4pO
         7piG2GTaDwLY4JRwdTpvjRXGUfY9XfXlEM10oTA/VzQsJtSQl6wJ94cm0zwXHi8jLwYL
         fWmw==
X-Gm-Message-State: AOJu0YwmTWe7qj3ESpWhRcVZpn5sdBQQykPjfM/QnIGxUbphmwlMpVJb
	3obFT9vQ1rA61HjdbIb9U3F/RcbXHfsCeF2nTlhE6v39OOEWUrMkY2lCSwvPKA==
X-Gm-Gg: ATEYQzxkUJcO7eaLGGlTHGgw+lMGw12rvoTp2S5kt0gEg3fjbTUPcZSmuvyl7PZXZ6F
	gNxjZOtQXp9kv6pGtSN9cNGpRJ+/2aYqnR1dCHT0WB0pNpoAuQzwU73nzPoMez+7OrHeB31eG4Y
	lBB+MJi/DtARsYSMUbidYWclyHbSTHCxLpfvxLxxbz2AWmgfHbAgoWo/pyGxycVwMUbfAIPZ5gT
	OIrx7yRhXP8GmkQ7BiIlE56TndtqaVcq33KRxhLj11uDivoFZKgtOssKUh4r0v4leoXMuqKZGjc
	x7Y8pfak/UIQE+/G07b4yWFx5+uQ+B3vyz97FashHqZbTYsDN1mKuEoV++iiyELExNTFDPSOlFu
	flq4721A5lAXOn4gwMoHSuyVR/3hiHYE1Yqh8V6AKfK8mLgut6+cflhSx+y/hE0qD75fnx0ZJD0
	z/IuSvphF708veVOdP/Iu5v+iCX9c=
X-Received: by 2002:a05:600c:8489:b0:485:4552:8fbb with SMTP id 5b1f17b1804b1-485566fab29mr167348735e9.22.1773591550797;
        Sun, 15 Mar 2026 09:19:10 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48558fd09d8sm200476225e9.7.2026.03.15.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:19:10 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/3] worktree: reject NULL worktree in get_worktree_git_dir()
Date: Sun, 15 Mar 2026 16:18:52 +0000
Message-ID: <75eecc8492e3fae70c3f11edfc29417937459dd0.1773591528.git.phillip.wood@dunelm.org.uk>
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

This removes the final dependence on "the_repository" in
get_worktree_git_dir(). The last commit removed only caller that
passed a NULL worktree.

get_worktree_git_dir() has the following callers:

 - branch.c:prepare_checked_out_branches() which loops over all
   worktrees.

 - builtin/fsck.c:cmd_fsck() which loops over all worktrees.

 - builtin/receive-pack.c:update_worktree() which is called from
   update() only when "worktree" is non-NULL.

 - builtin/worktree.c:validate_no_submodules() which is called from
   check_clean_worktree() and move_worktree(), both of which supply
   a non-NULL worktree.

 - reachable.c:add_rebase_files() which loops over all worktrees.

 - revision.c:add_index_objects_to_pending() which loops over all
   worktrees.

 - worktree.c:is_current_worktree() which expects a non-NULL worktree.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 worktree.c | 2 +-
 worktree.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index 344ad0c031b..1ed5e8c3cd2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -227,7 +227,7 @@ struct worktree **get_worktrees_without_reading_head(void)
 char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
-		return xstrdup(repo_get_git_dir(the_repository));
+		BUG("%s() called with NULL worktree", __func__);
 	else if (!wt->id)
 		return xstrdup(repo_get_common_dir(wt->repo));
 	else
diff --git a/worktree.h b/worktree.h
index e450d1a3317..85d634c36c0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -51,7 +51,6 @@ int submodule_uses_worktrees(const char *path);
 
 /*
  * Return git dir of the worktree. Note that the path may be relative.
- * If wt is NULL, git dir of current worktree is returned.
  */
 char *get_worktree_git_dir(const struct worktree *wt);
 
-- 
2.52.0.362.g884e03848a9

