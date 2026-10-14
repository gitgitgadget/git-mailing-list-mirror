Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B348D883
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012843; cv=none; b=tWg7Q0fbd7RJCGTog+003hcNoGSenMVzd7FGeebwPCycgbBGcbWYOuEde5Ofp8bOn9bx/GBcYPlBhr5EUT/W0vUq7wmcUILG904mc8mxq6FqtvW0XDKULjbVxaGwh0gw+YPaQAO+YiGkYc8NobwKigYxLFeX+WWHpe/UH0uwEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012843; c=relaxed/simple;
	bh=tStAA+iV5JYyj+xhQQf6ESMDZYPaFwuHsLf7tjEdd3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bi0GEJ4fq4h+X7SJVcxBu3yh72bUSXsuSKXPaiBr4YMH7ozLk/aBg9Y4RwXoaoH9tCVYSYGn5mIlXREJZF0FgTXALqoVYirJp7f3t5hKzS8F3vg+r8qbQ92Q5BdZpGKqbVoDs1Mj+jCWmXMBoB2pNjTF8yXvxkCsiOT1WC854eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sj0mGGiR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj0mGGiR"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-534e6545939so7317881cf.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012841; x=1792617641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+9r8bfcUTktv16qLYUr988CQtHLw8NXFURbVjaGD42o=;
        b=sj0mGGiRJVz4p5+sNV955ZfGGxYJh/y9UjCmtLGFEdY0JneiPVr8PNLcRvjD0ATr2+
         UFBXnZ45N7ibvJ/11deV/VQbzSPx17naCEshpJCC7xQQio3Zh7e1WoAPdhN4m7/l7DdC
         jEBVj1Qdxz5yHu/jesFeIbJxyz2+Dfn01jaIE3/GEFzS7a6yj2S7tV1j91D7JzrzvPmG
         ylNRpc3SD96xukkQp4RgD2L93UMgani/GY75tZ9r0vNDFF2MECSQjQVRpFekFGf9S08/
         2ACzb7R+X1c0S9FgUwFbB1b7UszEzovTgvCvqeyRqFduRnT6GtDpSNTUq1AKzdtVo0MW
         UFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012841; x=1792617641;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9r8bfcUTktv16qLYUr988CQtHLw8NXFURbVjaGD42o=;
        b=lTAbJf2MaiQlWvhKd2Ea058eKtmfd4nXMqUhDC+PRzCDQXu3YkV/0f7pndSdyXW7le
         PExaZaDlDxwyPxVTaujYkd1m3/LQ10CHjSBUBDSIoPLyFEtPqr/6qYLGCAIRZvjSkQRX
         j1/TcIE0X5TLGH4vTnq+e6AmmpYX1+UC7UTOuEJaPD3EuFM6G3grPO3dQPEYeIMXVwcm
         zUOd4qhSpP/Z7ACSd6k2XDH+NqAeoABea8H7ciIFUYK/KX35xB6KNT15U//uNff6LAbD
         eVH/sVNUzJriee+Gj8raL6F+s5VmbTQQWmhnjO08fXfxuwGbi4KO6gk0XUv6Ujg9gTmv
         H2xA==
X-Gm-Message-State: AFq9FYLKmEpwnHUE6qNTxjw5Is2ZNe+2vB2QH8HK7JnvspH/4c3ONmcQ
	C1xI1BM2RzoEek3AJA6F43/qy/cB15IRAaLnciBY6X4n7egkrAT2c7LmTGu+Wn2vF2s=
X-Gm-Gg: AYBFou2XmDA2y8hvwhM+G/eWYvinz4Qo/3uAmtom98dj6BFXO90BGNSAgK6Zek/tSKq
	O1M+6MDZlpD5IWPZAKz5Y02ftIh/zbfnYPCjk1Ynjuv0cCisi3koI8x/k91doWLz6TX3s0z7PBF
	FvBQAcOOeBCGSJJpRyQZusIk47hvzh+pPS62TiRBLFn4j9W55LD4CExbK6P+nqNurVp0N6ikMuX
	Zmzn/dTKW0dtEu2DvsEIlrQkX0fQSg6hAwQPxhfJhpLIlNzjHtBooVGOBGmaxNhXo6wtAOqp1qs
	GkCVgndA4Z1QoSL0HOkfxoSY5a1bfwd0ASAJ13w7qEd00rUb+gmK79oPirGlm+UAvDF6mj+goJD
	1j60PW8RrmwisvNasPDEFp9BzRqEk/39Z+sR/huhsLIyRvjZsAjbjKAcOAT+81V3zMMVFQF/nlE
	KhKwyaJfbdtm4P8vnWScN+G4CnoCg+1Dcw9Pq6f9/+rnoG1uh2/94X6kFRNjv6v/RStMfAEZitv
	g==
X-Received: by 2002:a05:622a:2445:b0:534:5df5:aa11 with SMTP id d75a77b69052e-5359fb75dd0mr233775591cf.50.1792012841065;
        Wed, 14 Oct 2026 14:20:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.220.125.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bdf068sm62881276d6.39.2026.10.14.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:20:40 -0700 (PDT)
Message-Id: <30ac7acad32750609befc3049c0f4174f6ec2f2e.1792012836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:20:33 +0000
Subject: [PATCH v2 2/5] worktree repair: centralize inferred backlink
 selection
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

Reorder the processing steps to centralize the logic for preferring
the inferred_backlink.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 69 +++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/worktree.c b/worktree.c
index 4492ca835d..f8e9850f6f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -841,6 +841,7 @@ void repair_worktree_at_path(struct repository *repo,
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
 	struct strbuf contents = STRBUF_INIT;
+	const char *dotgit_contents = NULL;
 	const char *repair = NULL;
 	int err;
 
@@ -856,43 +857,13 @@ void repair_worktree_at_path(struct repository *repo,
 		goto done;
 	}
 
-	infer_backlink(repo, dotgit.buf, &inferred_backlink);
-	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 	err = read_gitfile_raw(&contents, dotgit.buf);
-	if (!err) {
-		const char *dotgit_contents = contents.buf;
-		if (is_absolute_path(dotgit_contents)) {
-			strbuf_addstr(&backlink, dotgit_contents);
-		} else {
-			strbuf_addbuf(&backlink, &dotgit);
-			strbuf_strip_suffix(&backlink, ".git");
-			strbuf_addstr(&backlink, dotgit_contents);
-			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
-		}
-	}
 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 	    err == READ_GITFILE_ERR_IS_A_DIR) {
 		fn(1, dotgit.buf,
 		   _("unable to locate repository; .git is not a file"),
 		   cb_data);
 		goto done;
-	} else if (!err && !is_git_directory(backlink.buf)) {
-		strbuf_release(&backlink);
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
-			fn(1, dotgit.buf,
-			   _("unable to locate repository; .git file does not reference a repository"),
-			   cb_data);
-			goto done;
-		}
 	} else if (err) {
 		fn(1, dotgit.buf,
 		   _("unable to locate repository; .git file broken"),
@@ -900,23 +871,41 @@ void repair_worktree_at_path(struct repository *repo,
 		goto done;
 	}
 
+	dotgit_contents = contents.buf;
+	infer_backlink(repo, dotgit.buf, &inferred_backlink);
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
+		fn(1, dotgit.buf,
+		   _("unable to locate repository; .git file does not reference a repository"),
+		   cb_data);
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
-- 
gitgitgadget

