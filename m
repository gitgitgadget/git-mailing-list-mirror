Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BA3570CC
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984393; cv=none; b=IPRiEmgUVQCGfzVpYXvT8nWniNxErPGuqB5QANo+9azI1O5zrC43mFf5nt2Y3ZKw+karVdfkdKepupRY6jfsG+4UDClQwvabFYOubi5m4Qe2xBMtKPIga0uZ7bLQZG2OvhRBkxl1FUW+k+iQBT6S+ShhCUbeueK2D1Miel9z+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984393; c=relaxed/simple;
	bh=mjDbauDtPa4oyTXf9NKu16cvSuoX5UIc41lS2ScVmXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwJbI6own+Z+e7LAJ69bPejsjjhSVVHyNM1yjArfg/PsExigeTK3fEsILklR1BawN+86J+VVZewmM9Pbdv08+znRpK4lNGtifGvrz9nrGYdvBEXCsbFKPnmt8aAra+MTrO2SMeqUDLxbAkflcV3u7SAe90eKn3P5qOTcKRKM+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLTsrTo/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLTsrTo/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaed195901so4331405ad.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770984392; x=1771589192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkVaLkXCpC61H1YlYAtk5wrFN4qutv70dJpBKCJVXBg=;
        b=HLTsrTo/nvGXxbHG/TUcnB/IXOi01h0jKgcCSBZ3/7kg9xK6bEp3QJm8+hccTxohaC
         p+zy/fCOkaXCSZPt1WiZvtnw5bNk6YmJoE3eFojV7GqXOfzce0sNkFlleorxlXmYdIl1
         2XozStZJMo53MHUoXpn1wg9E+qPLANq/6Vf8DSveJdfHITcJU+lkPbV8P++DSWrXtEaQ
         HIXf0VlU+HJr4u9mcsQGh6YznHFTOlgMtZZgV/YxJ+TSCSXo6EHwKHX88GCgpoclCB7t
         AlLjvSQ/VKfPkkxkTQ5Vg1GZGjLPzMZlQ8+R170fQuT2x4OH5xTiNqORIyFQkwv9jar5
         fa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984392; x=1771589192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkVaLkXCpC61H1YlYAtk5wrFN4qutv70dJpBKCJVXBg=;
        b=pdm1GLvoFo3t4S4GvNUAcMBC8xwh5HSobfAWLoFP6ucVC2oA34QdysuD3LHK5yWwfD
         OycatZo56WUftEAaxgShDuO9UFBw95a693hb6NNF/Z/SYTo+QaOBIyVU2x7i63MytZMN
         PiK9xw7NCJR2RujS1TxAZ2jO2VTgQjFrsCGHcNAwb17F+HiANLGygzSGT0sZ4BBHFG+t
         SHVUqtuCy9AEICXCzbUTKs0XkZewe/HPsvmaPXpghLBPDWBDFm6mGEPDv8dJmuIJ+Afr
         1UvTKChIR/+7csGR4r7A7BtZNWgNDqdrXJeEVDQCMVfOYX89FlyjdFuw7BUMNU1lE4OK
         /nxg==
X-Gm-Message-State: AOJu0YyZ4p2X7znS6kzn4njh02qiDSuAXTfmZEEadV3YUL5bsoX8wo/Z
	X1iAOmyrH07SPL/Qh6nFdaNUw4Q+jn12JRPokg6sl5S9Fsixc/lpR/C/3YFZ6A==
X-Gm-Gg: AZuq6aLrjHBXahFvvkx1AjamHRR3ra0jXHJkbMPFRcQbiQ3EbJtOmc1WA2bhQoV7XLr
	SDfQ12MZhpNoMBMJ9of3WntSWYDLirv/J6s+he70IwlZdR+pgioSp65hGZ5zAH8vJBg2F6GG8NB
	rJ0uNjpGd46aq37maxinOM+pdltVezPSrvviH+Eu2RUfBXOXGPjE8mA/d5TXXYVinnuFH/uHkO4
	SCQW1/vvENtuYVqnO6IBZ5QUqUOUV7hUTufuAmEBjGGZ/DrPMaXOQwWHOlTT4blSEzIXSsrEgL1
	eRCKO3x+3nCtUC4K0wInUgUrOgxxy6YzcMhG9M/qyqPZdN8IrqpPv/v/U0djl9kqJd6uOGQS5TO
	sPbmf4uOuIFb9B5R3hVZyOgczqhE5R7gzBHjdCu3IpzNKr7Qza8TwGxLsssiiD70A4nwXYiNq2E
	EIxPmVFIAQkJ/HmSIUmaaEaRzUpFqjL6RSEg71DzUT432ScHRVM7oZZowT7QI=
X-Received: by 2002:a17:902:f609:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2ab50521f49mr18693705ad.11.1770984391827;
        Fri, 13 Feb 2026 04:06:31 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:8f0a:9a89:5610:9cd3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a0c3sm2303078b3a.51.2026.02.13.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:06:31 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [RFC][PATCH 1/2] worktree: represent the primary worktree with '/' instead of NULL
Date: Fri, 13 Feb 2026 17:29:53 +0530
Message-ID: <20260213120529.15475-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The worktree API uses NULL to represent the primary worktree. As a result,
many callers pass NULL to implicitly refer to it, which in turn requires
additional checks to ensure that `wt` is defined before use.

Represent the main worktree explicitly by setting `wt->id` to "/" in
`get_main_worktree()` and update `is_main_worktree()` accordingly. Replace
checks for wt to be defined in worktree.c functions with calls to
`is_main_worktree()` (or strcmp(wt->id, "/")).

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 worktree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/worktree.c b/worktree.c
index 9308389cb6..b29934407f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -101,6 +101,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 
 	CALLOC_ARRAY(worktree, 1);
 	worktree->repo = the_repository;
+	worktree->id = xstrdup("/");
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_current = is_current_worktree(worktree);
 	worktree->is_bare = (is_bare_repository_cfg == 1) ||
@@ -127,6 +128,8 @@ struct worktree *get_linked_worktree(const char *id,
 
 	if (!id)
 		die("Missing linked worktree name");
+	if (!strcmp(id, "/"))
+		die("'/' is reserved for primary worktree");
 
 	repo_common_path_append(the_repository, &path, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
@@ -206,9 +209,7 @@ struct worktree **get_worktrees_without_reading_head(void)
 
 char *get_worktree_git_dir(const struct worktree *wt)
 {
-	if (!wt)
-		return xstrdup(repo_get_git_dir(the_repository));
-	else if (!wt->id)
+	if (is_main_worktree(wt))
 		return xstrdup(repo_get_common_dir(the_repository));
 	else
 		return repo_common_path(the_repository, "worktrees/%s", wt->id);
@@ -277,7 +278,7 @@ struct worktree *find_worktree_by_path(struct worktree **list, const char *p)
 
 int is_main_worktree(const struct worktree *wt)
 {
-	return !wt->id;
+	return !strcmp(wt->id, "/");
 }
 
 const char *worktree_lock_reason(struct worktree *wt)
@@ -566,7 +567,7 @@ void strbuf_worktree_ref(const struct worktree *wt,
 {
 	if (parse_worktree_ref(refname, NULL, NULL, NULL) ==
 		    REF_WORKTREE_CURRENT &&
-	    wt && !wt->is_current) {
+	    !wt->is_current) {
 		if (is_main_worktree(wt))
 			strbuf_addstr(sb, "main-worktree/");
 		else
@@ -629,6 +630,9 @@ static void repair_gitfile(struct worktree *wt,
 	char *path = NULL;
 	int err;
 
+	if (is_main_worktree(wt))
+		goto done;
+
 	/* missing worktree can't be repaired */
 	if (!file_exists(wt->path))
 		goto done;
-- 
2.53.0

