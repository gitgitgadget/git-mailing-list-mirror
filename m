Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B147F3B3
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241707; cv=none; b=Ek3CqWGEvZLGcpmZwAywefs+HnxCiWyW3xqlw34/6QuenUnya7ap/04zW5z7oCFMfLXLjfqD0rW0lXwEMVu0IoAsdwnv/gc4kPdO3JBZZ26j3y0S/QtVXT1qzOq5nmRc4T6vgAEdnPsnirFLRW1AR/kCNTfYKJ6EfMow31cLabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241707; c=relaxed/simple;
	bh=z35Wx7semWt29C11Yq0qQBgAQeiotPruzmdh/SBQo4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=athRkVnA7LNKWTFYEahL6ho4SyyTgkkPo5l3pcYwHTYMSKFF+lEZtYqM+4Ya7p3juh3Ure8ksL15lxJuUDqiNPuln5pD3PWDJ/62OW5Pb4rQ7pydoSZq2KJoQL8nIh2FFV/W2oEvdD2NpMJ0F718gn86+Sj6s79MMfBNodU/y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHcCr+Vt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHcCr+Vt"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530e75d1ba1so7086871cf.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241705; x=1792846505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gaIh/JHtphdvwHA8UXktSPDIZrBmDqB9dgEzHUu1LM=;
        b=jHcCr+VtTmxK7o8pkBOFPXDbxqwT/oB2RcSijmIbH92aL/yF8mPHFHsXNfAoMIDF8j
         Hh3GcbTV50DA9V46joKhfzHcqMwB7/l5wUp3P6MK/t/j5vNZ9JW1xFDV1MBY80iJquZJ
         zbOE/HR6Fzk3iOh8jGSzLBZJcNEpmnycJWzukoXNmFB2HxyZgd5WGCxqV6Ael4ELilpZ
         Ce/aktPMoLlGXwnwbE6hNw6uEEGoUNj3fXLH4ZFfU1I51ZvQGhxxUNS3rPi9yGZfedeg
         X2BBfnUjZto8Gcq51bZBBK8yY+fYquXbYNZmCVDYY6uhAAXHINvyjXMaEtOE59QiCDgw
         CT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241705; x=1792846505;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gaIh/JHtphdvwHA8UXktSPDIZrBmDqB9dgEzHUu1LM=;
        b=CWYJUWRx45olI0gX3pWKS0jPfyEF44RWOkrfyi2P03czrtin3CwunyxaINzK2YGhaT
         al4nXAE+Grd76SgiZ+6qPstFTMzyTR9nbYzIb/bRTRYSa6pCT9xacrYbsqSeW9pFttxp
         yNap+JEuT19xH1XKBVM6okJyretAP+f8SiTKtq4PoAzwmaZW9yU2wHLesBOpp8o+d5yV
         CEVs3PIWFcFiJba3O2xpBRydLMNo6/PFuhc30kJIPPJuF/1qY8KHbBCBtiJh8hYrdStR
         7HdhnQkiOcDTS0+nLnZnocPFMHvLUaSGrJn5Rk8q/JuvAgmY0dCg2DnDSBAPHh7fnoR1
         aY0A==
X-Gm-Message-State: AFq9FYLqNT+8nNeTqD5C6nI9QmDYuGS5WDqngqGXXd2Kr119LFV/MXlV
	CV3MQzvYSkQHORiR0KajxCbS1JNJwuRJO8FDvpehkeLccXM5TSEKcHbSrXmglw==
X-Gm-Gg: AYBFou1lUiyNojSpyDOGktr++tUiZlsylJKScG2Y/220nCqvL7jqU81VEFEEu6fs3ka
	Yp24TDiOqMoPND4GXZhyLQb19jriWWJCu5Hc8rwoUgxW/0MvQ+OcyeNTyM03lTjg/prEZj8ymHp
	zDMb2vQ23dK6LGcGPb6nGQSN2WJWxPOXBcoAbT3aH+V2btuBofQoqxsyaVEXpx+weUdMkaBz00c
	o8CmIc5mRwNQ/P4OTkdLdI4a2h1hOTXkkaEkTQM2EjyyKLTi+6rFPvkZoRgG1zZhIxoV0IBxrAe
	V6ORSC4A8AOecUui5J7Y5CafxHZfqzifyEfXBBgJIofK+iNFtnzKEAns7DqB6Mx8gCAcgD6+jZu
	LIltbphtfYGCpl9h//QK+8LU1HRBFHVRS6KoHl/AkgD3SpxO9bUvXe4Jw9YQVdTAHBXrsTEZfwd
	JdCCYuxkOuqX4Qaf9mytD3qf87EkZRMU8cAnrQaP1qfXLiRMDM6TCp8eL6ULPzkvusm5p+A0AIG
	jo=
X-Received: by 2002:a05:622a:1aa5:b0:535:bf6:3213 with SMTP id d75a77b69052e-53645e4dc4dmr36146511cf.28.1792241704847;
        Sat, 17 Oct 2026 05:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a9dbdb5sm48717661cf.22.2026.10.17.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:55:04 -0700 (PDT)
Message-Id: <e336afa0296abd3e7e7e0e99b4e6b1b33649e274.1792241702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 12:54:58 +0000
Subject: [PATCH v3 1/5] worktree repair: align .git file handling with
 repair_gitfile()
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

Use read_gitfile_raw() instead of read_gitfile_gently() in
repair_worktree_at_path(), moving path resolution and repository
validation to the caller. This makes .git file handling consistent
with repair_gitfile() and avoids using the non-reentrant
read_gitfile_gently().

A subsequent commit will update infer_backlink() to use
read_gitfile_raw() as well.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/worktree.c b/worktree.c
index 8cb8637b18..4492ca835d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -840,7 +840,7 @@ void repair_worktree_at_path(struct repository *repo,
 	struct strbuf inferred_backlink = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
-	char *dotgit_contents = NULL;
+	struct strbuf contents = STRBUF_INIT;
 	const char *repair = NULL;
 	int err;
 
@@ -858,14 +858,26 @@ void repair_worktree_at_path(struct repository *repo,
 
 	infer_backlink(repo, dotgit.buf, &inferred_backlink);
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
-	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
-	if (dotgit_contents) {
-		strbuf_addstr(&backlink, dotgit_contents);
-	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
-			err == READ_GITFILE_ERR_IS_A_DIR) {
-		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
+	err = read_gitfile_raw(&contents, dotgit.buf);
+	if (!err) {
+		const char *dotgit_contents = contents.buf;
+		if (is_absolute_path(dotgit_contents)) {
+			strbuf_addstr(&backlink, dotgit_contents);
+		} else {
+			strbuf_addbuf(&backlink, &dotgit);
+			strbuf_strip_suffix(&backlink, ".git");
+			strbuf_addstr(&backlink, dotgit_contents);
+			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
+		}
+	}
+	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
+	    err == READ_GITFILE_ERR_IS_A_DIR) {
+		fn(1, dotgit.buf,
+		   _("unable to locate repository; .git is not a file"),
+		   cb_data);
 		goto done;
-	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
+	} else if (!err && !is_git_directory(backlink.buf)) {
+		strbuf_release(&backlink);
 		if (inferred_backlink.len) {
 			/*
 			 * Worktree's .git file does not point at a repository
@@ -876,11 +888,15 @@ void repair_worktree_at_path(struct repository *repo,
 			 */
 			strbuf_swap(&backlink, &inferred_backlink);
 		} else {
-			fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
+			fn(1, dotgit.buf,
+			   _("unable to locate repository; .git file does not reference a repository"),
+			   cb_data);
 			goto done;
 		}
-	} else {
-		fn(1, dotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
+	} else if (err) {
+		fn(1, dotgit.buf,
+		   _("unable to locate repository; .git file broken"),
+		   cb_data);
 		goto done;
 	}
 
@@ -926,12 +942,12 @@ void repair_worktree_at_path(struct repository *repo,
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

