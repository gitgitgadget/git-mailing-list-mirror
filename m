Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD63492E24
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241712; cv=none; b=SLDAziVvm08y45TWepGDvv9EA738oedupndSvqup+MWf+RmrVwEqVfsmHo0J69NF91d7s0+KeublUDHtMS5cH6wjIzFdw6B3Zvv/6Fq0snTdVYDW2MsrB6KtrdKhnl23AbcEAyKaFvvGl6JKbpWb2SZT2w0g+DbM/XW29cNsDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241712; c=relaxed/simple;
	bh=PyRc/KyDgnJrxFyd76PSRpGHCtanp2IIOLbmtOg7IgE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hfPfHqLUEwcr28Bk50UKXggZm6Aj4P5wsmIlPtoP0rnLCfYwRUBss6+/1W9yg1E4ybvDIqJ8/eMoRmMZvIXyKieqs1zPLk/JhU3wRfHdQAH+WZynKEK/LPRKZjXn0OuK7zHuxQFxAIDbHURo3u/eCNoiBqAosnbQoyUuPydBTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSIaFnHK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSIaFnHK"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5351748222cso5527411cf.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241710; x=1792846510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MTIYfxBv/0zKkgIT6woxe+FX0VFaukjCklSCHYMho8E=;
        b=sSIaFnHKGVcjxSS8iITNzgxdR0UboAYqFuYTZdtv9SjF83ercnwOoh2G9mM6hzJqdB
         552NpMKq9UZg5n4apzT6eKAO+ENqEFLtqjEBzGFyVhTrRSE1MMjOsjl4/FDm635MeHt9
         dnScSv5dXUGx+z7FcQnaXHdT2AJFceFPaCCl5BQ4oDbtdXKI/AD5AHxSpuH2YCz4ti3s
         GtMU2V14yfnvhFffunGTRtZDdSuZtwHWu8fwpGotMZAGLdDL68tG2n64XuyIERYBJUGz
         WGwqAiqHxd9diaJK9wjrkQkhdBPr36RB/htck6RCQh6RZRmHeq/YPgxP+4ziGWhVKQhg
         7ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241710; x=1792846510;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTIYfxBv/0zKkgIT6woxe+FX0VFaukjCklSCHYMho8E=;
        b=aQzZpfbA7T7vPKrQqlU3BG1PVB32tnVFXSsKjyCoKaTm95XzUc+Sox0IFke1QrNeSO
         G4gaqYs9v95WVxJlEAcXa+9mgGJFC8ey1ZdYYfhXffLgH35T4/94+7w1FPnrgyEwkV9J
         ui4wyEf+hf7iYlOm6BGmFR8ttHHKLdGKzmx2MgxJQVN+7dBw05LkEc5yYnp68wB7diRt
         IJ89ReUpb0QB49f910+XWxkMI0e9AqMMikiW/1vh+EqsrfF2SBg8L3fbke4xE0nhETVJ
         bUxeNHbX6Mxks3SpQXlupXH04Zvwv6o9qCUHkDQx5IGusGr/0A6uRIUz2hMSIQakmR/K
         rf1A==
X-Gm-Message-State: AFq9FYLpkRx/u39D2an7Lo+VlB9pqc1x7DCa31AGDSS5KpJekSYtC9jk
	gN/w6sInfAfd1xgyZtlEjeOebbo0QqlRzAgJTmtdrTaq+uRcV8TZKcQb3BvSN9H+
X-Gm-Gg: AYBFou1Tqa8dgek5ijqWLg70TAavGrAcmcB7JFJibG3iOOXiWZppnF0oaqY6GhWJ8XG
	8WWXbBkmSwruAVgjqDtoxGUg+9nIwLjqALfTbhzV5ZVVXIkD5k+OcLwmjiACe5XOJ6geWzSHTDg
	Sh/HHP0ubz4LcscMUxOPrn7mLofFdorQ/hxXAJrNjCEJDNdWP/t1XxOi/ODxg7y75H0D/mQl2qt
	aPrQxuEs+PjVST8JGOblm/3EIkJG+QJbXeRSLCva242NR15g9RAw+hv0XaRpAEV16lh1qwiuYU3
	N3Fu0vdcoGAdRwUUTE1KHrgWPqbRZJTt6IG3ngUr1A2KnmohHNuPOej6I9OLDwj2yunJ5I03GD1
	EVG6osSssFKf4DurioHUD71RUh7h3D5eeQNoVuaa/bdhgVAJzGUvRMKDsH94lwdJy+3wCO+7Vgh
	3WIM17DY2WLxkBwqs4sey3N75tA+iP/aHFlDkacPyunRfq15vyI3hBXcdBz1JbQ0EFwUOC6RYX9
	5k=
X-Received: by 2002:a05:620a:a2c4:20b0:93f:2ed6:1f3a with SMTP id af79cd13be357-93f2ed61fecmr123518685a.49.1792241710053;
        Sat, 17 Oct 2026 05:55:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcedd6952sm42659996d6.39.2026.10.17.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:55:08 -0700 (PDT)
Message-Id: <e35285a4ea5a5f7b11cd112df841948e9a0a3ab9.1792241702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 12:55:01 +0000
Subject: [PATCH v3 4/5] worktree repair: reduce .git file reads
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

Pass the loaded contents of the .git file to infer_backlink().

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index 3627dbc044..879941a977 100644
--- a/worktree.c
+++ b/worktree.c
@@ -806,27 +806,20 @@ static int is_main_worktree_path(struct repository *repo, const char *path)
  * Returns -1 on failure and strbuf.len on success.
  */
 static ssize_t infer_backlink(struct repository *repo,
-			      const char *gitfile,
+			      const char *dotgit_contents,
 			      struct strbuf *inferred)
 {
-	struct strbuf contents = STRBUF_INIT;
 	const char *id;
-	int err;
 
-	err = read_gitfile_raw(&contents, gitfile);
-	if (err)
-		goto error;
-	id = get_worktree_id(contents.buf);
+	id = get_worktree_id(dotgit_contents);
 	if (!*id)
 		goto error;
 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 
-	strbuf_release(&contents);
 	return inferred->len;
 error:
-	strbuf_release(&contents);
 	strbuf_reset(inferred); /* clear invalid path */
 	return -1;
 }
@@ -877,7 +870,7 @@ void repair_worktree_at_path(struct repository *repo,
 	}
 
 	dotgit_contents = contents.buf;
-	infer_backlink(repo, dotgit.buf, &inferred_backlink);
+	infer_backlink(repo, dotgit_contents, &inferred_backlink);
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 
 	if (is_absolute_path(dotgit_contents)) {
-- 
gitgitgadget

