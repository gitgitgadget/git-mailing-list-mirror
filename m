Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFB38BF62
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534659; cv=none; b=j4j8F7HVqeoP1c9wW+zUIgR5eGZRLzoVuJ/2VtM1s69s7RUZRSURPW2lSGMH+/FcGFJaC8WEAMaOpb0iY5XIdv7EndcOINjv443YKoOnb7FttVw64lyY4vUNbHgRs39uZJPyd2XB2KfXVAK2U14HJ4UnxZPQGGPyD8/mTv8Fj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534659; c=relaxed/simple;
	bh=puhJcY5evlLHpH9kest139q1rEU5mK2aUxmCAVfEi3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn8xoDa2DqwqTitjuHhAwoRO8OQ6/28uHldN4TSk84GlWGD8DouhCBfwzD4WnY//16HJK2BNStWc4HDA7n0xqJioFXVJyLdsmL+99ciIWWZITcQfeFBUBs7boYJleEm9UeKo++McQNjZnyakaRcoX7axllcu2TMsiFiqfRturl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDdpWPCO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDdpWPCO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso9296755e9.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534649; x=1775139449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=251l06KqAygP1T0aJWW4p9RD63Cvty6domWky58h16Y=;
        b=gDdpWPCOhkFbYhtMTuWwng5RdzudfJPc3q5nt+jOlwT+EQNtBKEwCAH2rDhzMf0OJ8
         M8VmZbbGV9GK1RuTgHi8t56v8fodZymfxRkJReve96XUIUfsYFVYTJKwl+FhXW/FNkd4
         uBtr1AHh3ZAx2THbEfbnABVv4ATiwYm+a7SxPTiLRCsboQ86NN8/rPKCc8w4T0MaiNR3
         YMA653j9qUcbV+8s4XxnKYse0kBWjujuQ38CITtv+i870b1qqjlOqoe2WsVFQoNHLeI1
         XQVE7+b9/Cc92duVzwOfFFwoVm0s6tPP6hjJ+r7trwjxPHNuDdgW8ipGIHLYPe1OH2Ge
         vTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534649; x=1775139449;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=251l06KqAygP1T0aJWW4p9RD63Cvty6domWky58h16Y=;
        b=Qm8Fy4KdZRd8FZi68UGA9+fbpHTvSDhaJ93woir9bZc4dBZZ0M/iiL5207888Qrf+t
         i/CdWg3oI0pPyLJ7oItIDAaJmJGQSwQ9rb5GfzDVHOrWE0qp+nMBetx6h5VnHUI390B5
         V3srkbFjd/LzeAIfb1XVYbCrnEQWlJuL0OcfJbKSb3U6A9fAdF9RrO1y0grAPQFpgLN0
         XZYqvxJo4NhMUvHHFIaBtAiYpcVLtns6EUUS3kLqU3ZwHR9zEyNM0s7Ul+LSd3MlxCSf
         +oJ4+C+mg54z+TVhMJZOJY8/t5/GnNlzhCNugInLKDCiSbb+H4yLzj7mzuEts7wvDMi4
         nBwg==
X-Gm-Message-State: AOJu0Ywsf2Na8nhyGX1YzTVRgbkQN8PNJcCeiA4a5OcZlOxBUvRuHd9c
	xFTqPmbaQz9vv+D1rtrFC6vF7vWUNSTBi3ZmtVjJyyp8ptZ1hBrTVSPKhXnX6Q==
X-Gm-Gg: ATEYQzxVQbIEyZIcbOy5ijZMlZ7NQC83hf9JsarZk14dNlYCJQ8rTqDoXflIbuqgUKK
	6RG+2G800DRnCsA6RxIpQ2gLmx9jFjWAgWwvkWoPxWl4/jVzceGiiqrAAbsY7r11yiFEF798V8I
	91FuqjToOiLelabzGksR3PU4qXcZUlHBIRAfUkqnHjwqKy6EWClx6o0dXTZAo7r4UFZ/Keh/AiR
	Jlb0XIfg430lYSYo/wScuv2G6kHVevM5clP8xD0pD8OCfbJm8LOZuV60fvI58ayuSutEvoPJ0MB
	o0mnpA1RVaFKkSe+wf6ZEDfgkgtk+W+twJirY2Bx70wGy33Y7w7RTQ7NvuQdVDSH6DrjmJWd6Rx
	hVqT4nW8v3i4TSvxD+z5buVxzJlZggJf9mZGnsNxlc71O2fz+f/zphMJ0A3UObd+hZ9ChT8yzov
	iCHjH+FFBqIhHOJ3HzsFznXhkTTX0=
X-Received: by 2002:a05:600c:1d15:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48715fc3d1dmr120138385e9.4.1774534649371;
        Thu, 26 Mar 2026 07:17:29 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720901b90sm15507775e9.17.2026.03.26.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:17:28 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/3] worktree: reject NULL worktree in get_worktree_git_dir()
Date: Thu, 26 Mar 2026 14:16:59 +0000
Message-ID: <c3329028010269995008d92653ba6dc4a5322118.1774534617.git.phillip.wood@dunelm.org.uk>
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
index 94ae58db973..400b614f133 100644
--- a/worktree.h
+++ b/worktree.h
@@ -51,7 +51,6 @@ int submodule_uses_worktrees(const char *path);
 
 /*
  * Return git dir of the worktree. Note that the path may be relative.
- * If wt is NULL, git dir of current worktree is returned.
  */
 char *get_worktree_git_dir(const struct worktree *wt);
 
-- 
2.52.0.362.g884e03848a9.dirty

