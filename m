Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BC487CFD
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241708; cv=none; b=eO7eAKBZiULJoIMQG2oyAjyrrGitGTNMFh9xztZZkJcwBiubiH+VMBIV9Ckz0HV1fU+e5d0vjNP88qSCmPstPHyZyFUY6NDHn0T8dvSDvdLRi8d5BGDGoJKZDapUBdl3KoJ54k3GRVCepc0WAtr7EAZq1PV1WmXhfXt/urIx+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241708; c=relaxed/simple;
	bh=tStAA+iV5JYyj+xhQQf6ESMDZYPaFwuHsLf7tjEdd3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aL6BPg8/TBj/5amtU3FjKNur///AxIO881qtn+Yp9mnJBdGvzrCuNv5dJirKXR5Cr9utxhuSQi1+WNrwGUDaKY6Xolfw3Ds2932P30o/gHa+2tbsohMMUHz9LkSAiqiLvpUNQGXW+YRqOOS8EqZDmFoH562KXv9XHPoZZdA2EL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEq2A++4; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEq2A++4"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9144e8021d3so9782426d6.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241706; x=1792846506; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+9r8bfcUTktv16qLYUr988CQtHLw8NXFURbVjaGD42o=;
        b=kEq2A++4kxoXbc8PTAzAb15an0SwVv0unubS42cU6KpUaahtSXdSbVw0oOO7myuRXV
         dSyVx172H0W4FM7qBC5BczWX0fRlAoJSdnO3QkshYKYn/VUWfJHh9XtQIFtO99VtTkhM
         637FETjvgGzrxF7gzt3005lzjxLQTbHFHHpMDmSWTm/qGAG6E1FeLXQMMTCFg1+gsKi7
         1QGpGWneXOCNn9sjSAbxc/fKJ8404hKmTQiisJMPGgIpP5PLPaeuDq1l5hUGxS+xncyT
         E4UclJdVzK+HWSYirNMjk9hqWrRtBjX06lGbdecgkyqbFTWpV7QYSidp4NM+NLxde1TK
         BSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241706; x=1792846506;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9r8bfcUTktv16qLYUr988CQtHLw8NXFURbVjaGD42o=;
        b=kNSM1/h14mnmAe3FJnWb5etI6caY8xwmSkSOoMC3AjT4rj9WTAHNYiV6mqGonaOWEZ
         Une12HtQJtVXBKTP973eoneg2+AJykXAH4rkSOyX7LXd7HPVcneyHYmcnPY5/pEw3POg
         fUK56zQcgwC/+YwS3uU8c+FbJW3dHMcQs9tSUlcO18lY6UcWeYl8KOXlSiI1CAQceETo
         gN2rAaKFAguyyabIWwTEmqHiK6jlULkBKWvZNXPZ68y99mB0HBaRBkDmci8dzqTiEum1
         IfnFy0hBIV4Hum3LjXc736Gs6nUK4jWz5bETx3et+swBqsetnvNqKM2zuOFRCkTp7p6B
         IzaA==
X-Gm-Message-State: AFq9FYJMmzszWLrZ9sd6cLElKci+Mg6veb9IR5Xt/2jUHj30IE6sxnAx
	ooniEHFqJoPk1NuFTH0Ad1cUMEf+8kR4XuT0dyrYx4FS0mpcICrvhnPr2EKO0HA+
X-Gm-Gg: AYBFou1kNY33V2NCgZkptloEi0y+tku6/s6F6+jcd58I6sShOoyAnyXs2Iug/i/Qt2L
	XZZwVGky9KmkRQnxGZBNLR6VUQaKlOwOg1aYuS8Kh//unhyXPIvhH4JAbTbl11uccRaqzhAXgXA
	ZzhwCCZzPy+YcmDZ8kUOxVwEAn7f9998sy+3axvMdZQTqCT3EgEJ9vXt0pOYRtGJMYhQ4yS6P91
	X9wX7KRwMFtD4B7pzcwCaVswlIqPx8t1ZBpuovG/Wo1i1uyC/WYZJ8yVKUWIR4meLe9XvaBXXRf
	CzScDsbH5EX7hzddFdBiCfRxLZoRbUWQ3y4mpssCCIcNpgDkI8RXj6JnuPgbgkT16W+Wvl+TKUW
	hujJGBflZl6Ue95yxDkrwd4d2JMMASi/7mkDBRlShdHsCyIe298750pgSri/LwgX0b9YD9AacO3
	Lfqy1kT406kGGUEew2JgFm7eonHWiqijocl6wxBCATmDs7R2e3RUp9ar/As31tdJKBkzYK4kBpp
	YrJ
X-Received: by 2002:a05:620a:3196:b0:93e:c12c:9b71 with SMTP id af79cd13be357-93f29dfc421mr446280385a.76.1792241706075;
        Sat, 17 Oct 2026 05:55:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb4f865sm46652626d6.37.2026.10.17.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:55:05 -0700 (PDT)
Message-Id: <86021f31af4985d9c2a42e2b96031605652837bf.1792241702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 12:54:59 +0000
Subject: [PATCH v3 2/5] worktree repair: centralize inferred backlink
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

