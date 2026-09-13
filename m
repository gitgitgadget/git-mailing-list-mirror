Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364E35CBD7
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789269619; cv=none; b=Ulc6v6UtP+VIeptxbbjRzknj2hhPrq1xZ8+LUQop5Odf91SVkq4MWIEfPQjzkgLW9ewYGohFHkPcFysdPOMEX2Vls5WsT/ZHWduvTTG+U0ApSWf0eVM9xCk8TcTTLAiVLqcP5uc9E70oKHBOT978RyOzpeyUrXJrwKURrruriq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789269619; c=relaxed/simple;
	bh=/t+G6ivqNMd5iRVEMTmhJFHkrFHQ+N159vgh63qapCc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kTodnIG1xvlnEZ59NAJfhsuDW6QJgkdpS2tBFVKhFfRwg3BHolQNbXFriuq+SyVVKtFbCxjxZvXvw/ySuJLc90nHNmuhQAaIIqWmSIHUF2c9RQ2AkB2WllQthI1II61qgSH4XiC+Prq5i9HNAw7nkkDWMJfBSKLbkY9URtf402E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCSrtXY9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCSrtXY9"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so3123385ad.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2026 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789269617; x=1789874417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5wlCPsTvJiCvSa4IDk/nSsOt2Q6lfHnm5sS+UmyZKZw=;
        b=FCSrtXY9QQuyF1m1UJ3aHnIdytqVXo0GEOK6ytWJDzy3EtKJqOv5mKgHb3ZF2WQ9Ke
         Z+MyJbaRdDctGC/mEAPCJKJMyW9sJu55XzzM6OAzqN8TphOXuIBiHj2jih4lA4sr1t7a
         0KG+Zkdjj3rqy+kUIEy5thFphRhRsRMBzqGz+udv0lYSTTYYkqtwhxd0ZJll0x7KxKoc
         yTqD6NxPzObXg9ihFPWW6daaUzN/RCxFYIPwTxdc9UP3QwH1k7jvGGVTbtnxScxiG2ly
         8Yn20Y3LlBTV/Fuvlu4Aetp0A/r+u2lKkevHr76l8lzcD5/NHdhIifFf2X81Qp09Z8Ac
         GTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789269617; x=1789874417;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5wlCPsTvJiCvSa4IDk/nSsOt2Q6lfHnm5sS+UmyZKZw=;
        b=eydOpCo6iWTRXU2aosVJX7d2waofN/29Jj7zh7dzj8CLANLtOicXbtCcCgCaYk61aJ
         5n/ZO9FKuXW1ljddZmGkTVaEhdiyM9dIBRQAsyUxsg1EMi/qmhvPSwiArvb7+/FAtFMq
         HLgZno1m3vy/7S5vqKQ3UJb70GnBVPckYDwxvMKertQknd4G+YJU/tVedJ/ZpkmLasDm
         y5+6hdcVIHdIFbwuWMjdGolWVf6BVwknzelG39HW5jvyApgsiTa9blCMChnqEjqaB3Fz
         6APDp0oHK5nLshZFVi5wopBU05I1UfRCWemlAF6UNHlxixAKmuBafZ+BuKo3jejCTYtl
         /dpA==
X-Gm-Message-State: AFuF++l6Cv4YWDN+GrR9tvrbP57zAaeNkK16zaUNO3tq2C+KV0nYpv3X
	ORWSb4rQZ52L86McdGNARV9qWZ70rkI07zdERMF4L9W/DFvJkABFfGKASIOIoBBA
X-Gm-Gg: AYBFou2x2acpxNE0+XhDuGgHQ7P/C0ppby5N8LJzDZmy8rDLGw1MDE5qO+XvsABOF3q
	pzg1xVtWI8v+ribOSAE89HN+TspcaEuds/TTeUurm2SZsTZwgj5m9gn+/O5howUoZ2IspBdlc7b
	vpLs6h8oSaxnv2cUtSA3Y4RSs2v7pexPLq8WJJMPVjOR8ZN7z3NcFTW3Qsd3uEcXCFGuPs5TDIX
	sBfpowNVCKPXr3c+cpor7PFTYt+fQcx6JVPU5tt+mBq8H7NqXyxPkyfL9Pph6boq/3YvMAF3DAP
	MYLR8tFrEAhhsj3hp46zU0xDBWxGMh7i18r8OX2MwNpDzimb5oXhCggFDaHjTJJB3ChL+K2543b
	GY9w+5IEzl8cB1YSJZ44cAvRIS0jXi/n3nMFpU7v0yRt7Iuw8mu02SmtKotaSIU1+RFXmtb3y4k
	trtCIftzbxyXe0atljxhcXFw+o7lwoPMKtnGCQ3Xan20tgxt88V2YcS/a90N686MWVztzNmlzQ
X-Received: by 2002:a17:902:dac4:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2dd4bd64dbbmr90492055ad.13.1789269616600;
        Sat, 12 Sep 2026 20:20:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.65.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9b359sm16717904eec.14.2026.09.12.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:20:16 -0700 (PDT)
Message-Id: <dc7ebb427bedc7318ebbf84c05ecd02063408353.1789269613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 03:20:12 +0000
Subject: [PATCH 1/2] worktree repair: refactor and reduce .git file reads
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

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Remove the file reading and trimming logic from `infer_backlink()`,
and instead read the .git file once in its caller,
`repair_worktree_at_path()`, using `read_gitfile_raw()`. Since
`read_gitfile_gently()` is replaced with `read_gitfile_raw()`, restore
the logic for constructing the absolute path and replace the
READ_GITFILE_ERR_NOT_A_REPO handling with a check using
`is_git_directory()`. Simplify the logic for prioritizing
'inferred_backlink' over 'backlink'.

Extract `get_worktree_id()` to get the worktree ID from the contents
of the .git file. We are going to modify and use this function in
subsequent commits.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 89 ++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/worktree.c b/worktree.c
index 8cb8637b18..7af13898d0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -637,6 +637,14 @@ int other_head_refs(struct repository *repo,
 	return ret;
 }
 
+static const char *get_worktree_id(const char *dotgit_contents)
+{
+	const char *slash = find_last_dir_sep(dotgit_contents);
+	if (!slash)
+		return "";
+	return slash + 1;
+}
+
 /*
  * Repair worktree's /path/to/worktree/.git file if missing, corrupt, or not
  * pointing at <repo>/worktrees/<id>.
@@ -798,30 +806,20 @@ static int is_main_worktree_path(struct repository *repo, const char *path)
  * Returns -1 on failure and strbuf.len on success.
  */
 static ssize_t infer_backlink(struct repository *repo,
-			      const char *gitfile,
+			      const char *dotgit_contents,
 			      struct strbuf *inferred)
 {
-	struct strbuf actual = STRBUF_INIT;
 	const char *id;
 
-	if (strbuf_read_file(&actual, gitfile, 0) < 0)
-		goto error;
-	if (!starts_with(actual.buf, "gitdir:"))
-		goto error;
-	if (!(id = find_last_dir_sep(actual.buf)))
-		goto error;
-	strbuf_trim(&actual);
-	id++; /* advance past '/' to point at <id> */
+	id = get_worktree_id(dotgit_contents);
 	if (!*id)
 		goto error;
 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 
-	strbuf_release(&actual);
 	return inferred->len;
 error:
-	strbuf_release(&actual);
 	strbuf_reset(inferred); /* clear invalid path */
 	return -1;
 }
@@ -840,7 +838,8 @@ void repair_worktree_at_path(struct repository *repo,
 	struct strbuf inferred_backlink = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
-	char *dotgit_contents = NULL;
+	struct strbuf contents = STRBUF_INIT;
+	const char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	int err;
 
@@ -856,51 +855,49 @@ void repair_worktree_at_path(struct repository *repo,
 		goto done;
 	}
 
-	infer_backlink(repo, dotgit.buf, &inferred_backlink);
-	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
-	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
-	if (dotgit_contents) {
-		strbuf_addstr(&backlink, dotgit_contents);
-	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
-			err == READ_GITFILE_ERR_IS_A_DIR) {
+	err = read_gitfile_raw(&contents, dotgit.buf);
+	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
+	    err == READ_GITFILE_ERR_IS_A_DIR) {
 		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
-	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-		if (inferred_backlink.len) {
-			/*
-			 * Worktree's .git file does not point at a repository
-			 * but we found a .git/worktrees/<id> in this
-			 * repository with the same <id> as recorded in the
-			 * worktree's .git file so make the worktree point at
-			 * the discovered .git/worktrees/<id>.
-			 */
-			strbuf_swap(&backlink, &inferred_backlink);
-		} else {
-			fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
-			goto done;
-		}
-	} else {
+	} else if (err) {
 		fn(1, dotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
 		goto done;
 	}
 
+	dotgit_contents = contents.buf;
+	infer_backlink(repo, dotgit_contents, &inferred_backlink);
+	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
+
+	if (is_absolute_path(dotgit_contents)) {
+		strbuf_addstr(&backlink, dotgit_contents);
+	} else {
+		strbuf_addbuf(&backlink, &dotgit);
+		strbuf_strip_suffix(&backlink, ".git");
+		strbuf_addstr(&backlink, dotgit_contents);
+		strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
+	}
+
+	if (!is_git_directory(backlink.buf) && !inferred_backlink.len) {
+		fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
+		goto done;
+	}
+
 	/*
 	 * If we got this far, either the worktree's .git file pointed at a
-	 * valid repository (i.e. read_gitfile_gently() returned success) or
+	 * valid repository (i.e. is_git_directory() returned true) or
 	 * the .git file did not point at a repository but we were able to
 	 * infer a suitable new value for the .git file by locating a
 	 * .git/worktrees/<id> in *this* repository corresponding to the <id>
 	 * recorded in the worktree's .git file.
 	 *
-	 * However, if, at this point, inferred_backlink is non-NULL (i.e. we
-	 * found a suitable .git/worktrees/<id> in *this* repository) *and* the
-	 * worktree's .git file points at a valid repository *and* those two
-	 * paths differ, then that indicates that the user probably *copied*
-	 * the main and linked worktrees to a new location as a unit rather
-	 * than *moving* them. Thus, the copied worktree's .git file actually
-	 * points at the .git/worktrees/<id> in the *original* repository, not
-	 * in the "copy" repository. In this case, point the "copy" worktree's
-	 * .git file at the "copy" repository.
+	 * Even if the worktree's .git file pointed at a valid repository,
+	 * it doesn't always mean that the backlink is correct. For example,
+	 * the user might have *copied* the main and linked worktrees to a
+	 * new location as a unit rather than *moving* them (the copied
+	 * worktree's .git file actually points at the .git/worktrees/<id>
+	 * in the *original* repository, not in the "copy" repository).
+	 * Therefore, we prioritize inferred_backlink over backlink.
 	 */
 	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf))
 		strbuf_swap(&backlink, &inferred_backlink);
@@ -926,12 +923,12 @@ void repair_worktree_at_path(struct repository *repo,
 					     gitdir.buf, use_relative_paths);
 	}
 done:
-	free(dotgit_contents);
 	strbuf_release(&olddotgit);
 	strbuf_release(&backlink);
 	strbuf_release(&inferred_backlink);
 	strbuf_release(&gitdir);
 	strbuf_release(&dotgit);
+	strbuf_release(&contents);
 }
 
 int should_prune_worktree(struct repository *repo,
-- 
gitgitgadget

