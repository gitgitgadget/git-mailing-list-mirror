Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1C485CD8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012842; cv=none; b=hiO/s3KzRm2vBs9avkScxSXnJgIRWglMxFmKERjVxtc7/HUqo2rKC7LN8bkMBeSR0mlCvxUh/jkcqE2ENVLCfDUmyB0lj30JjC3hYFiSmzJAIH6pgOoPpQ5Zt2KrlHMlf35FuLN4ZnSYMTHJ/mxnEAhFvmZxnExCFPSLmIDgT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012842; c=relaxed/simple;
	bh=z35Wx7semWt29C11Yq0qQBgAQeiotPruzmdh/SBQo4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jVOa8mvZAnF8jA2JPNdIeGdpCjxZ1QWhcl/9q8oovb13dPgN0LlS7wP3YxASw/K8DlcBmtud2nor2Jk5bkJA3/LeGTvM3y14veoSKT56adOJDD50CXH+NIdwqswLmDAv0OonZ4FB/Mmu4pIibJMdn/RSCl5Y/rcsuNoeMexM7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBfclZPk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBfclZPk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533797e72e8so5157501cf.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012840; x=1792617640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gaIh/JHtphdvwHA8UXktSPDIZrBmDqB9dgEzHUu1LM=;
        b=IBfclZPk4JiSC/uB0guQ7hdR/+cNU5pG01qPaQpuocTSR6lMOKvgPC61XfT7JIe5w8
         gwRytI1K+q98M+rIcc1S4lSTiGsV6h5PqD8gbONs1CfhRQL76pxKCdiTG7VVWI2tyMrR
         505xrA2+hlSnKdBPAjftdxdieS8mRdx43KK5fntqc7pjhmF15Rf5GroUPcKYJ/6Kero9
         csaQq82u7rgI9T3QBmjtu6Jp+jkVmGc6hLyrKIuy7jxHipOsR/zOIzhb1oLuO6IycVeF
         HXfzVdNxpfi6IkZiD1gmH90noBZ4kU1vA61TMTOeAyPtOrrO2H8a5pZ0U1X/2SdVghcw
         bUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012840; x=1792617640;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gaIh/JHtphdvwHA8UXktSPDIZrBmDqB9dgEzHUu1LM=;
        b=m685rd4Xyxa7FsJjeTRu3bnVyFWyODLgeXB86LDnblMnQsrMyBzBbIuJbmH1dKmUPA
         D/Tow+k2A6kADzwqay5dezaMh7Fl7VzLcuX1GzHsUyZx90krl8yonsT1jXnaljS5YZS1
         eACWaA6EdSH36gEv3wb79X/3NdN0HSbOQTEHduXKkTgww3gtivYFaCyxSjY+ozCuPpYq
         1no6zI9satim4kNxSC+EU1fyfIHRpaxYvRsmSRFeOMqiXceKlci1Ut9ErTDFyzV5NUt5
         KU8UupBLkCOZsM2gjEGVA+4twqHl/LEePEATsl6jniFx3d1V5jKaKjZFXHqumni3WotP
         RLjA==
X-Gm-Message-State: AFq9FYJ3MPXjCsRRr0ipJ4IMMral6hlwBp8nKg5a74e2oi4DaOVjxI9M
	UQoiWJnJVe+6h6M+YlXF0bqL5z7Kzq33cLy4S/0IbIqLqPYp1nd8UucMS5mzr/w/DH0=
X-Gm-Gg: AYBFou3HiqY4tWFE+JAo0Y0NZGGqSjanADr9Cp1dYhmIqkJFAyfl37bNtrahni3EHNB
	BJco0I5Yrx+GF2XoYwFhj0mX8Z4YTCTlqESlFf1qbBmqtwNKRavqB/rQHhQ43uN8Jtu+zED/0r3
	3g+fh6zTrm42smJ95+Ou+WsMIUyvJuhSknWv3ttdWckPQlTOUhag/5hdALU9lfDR5luDyWKE82c
	M+wR0W2K7TSrhzh8c2tZjsFKXn/x5S5YLsUi1UT9Vy25ypxWk7bd68m22WJomf2qHNRbvec6H4l
	7678NITODlM3GTPVIt708KTG4go0QtbfwaL3g+0AirfSe75Czt4Gl4yZaW9tYVBDgLsCUs/fLeu
	V/Q5LtEdvQi6YmlEE/B8ybqrIF3i2gvwPizdY0NlDbbEjm/oeZGpi3vXqkjE/4G+hv/MoC1qs8A
	XXi0vvqAMYEzqNY4ohP0dTjpCkwNZwWGzuIAQnVbxC66o4UKfEDzk/y27Pgztto55tgJG3y5+KL
	g==
X-Received: by 2002:ac8:6f0a:0:b0:533:3d48:37f0 with SMTP id d75a77b69052e-5359fb5a466mr258947411cf.47.1792012839945;
        Wed, 14 Oct 2026 14:20:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.220.125.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127baba0sm7102361cf.13.2026.10.14.14.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:20:38 -0700 (PDT)
Message-Id: <21b2878aa552a931788aa7bb14720b24e7809c75.1792012836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:20:32 +0000
Subject: [PATCH v2 1/5] worktree repair: align .git file handling with
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

