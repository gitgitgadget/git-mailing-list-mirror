Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E69369222
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591555; cv=none; b=dOfC1zMx7O5jzi5Duxp7x2HRdSOv97vJqRoYBQyZzOduP+dd3MlCw4NMVVMpZVJKqfsuNPCoNMo64bT+d1d2ychlcOQ5eTcQRp/utK9yie5btQLohuZnBeSSof3W42iGuHB1SM1os69TkI/oyvK9U0qZdAPLgOuKvkhd1H+KGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591555; c=relaxed/simple;
	bh=2n7GgEG1ZhsxSLyiYrWOlvRjZSjOEB2s8qCXSMH3gDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRpoNBUCkCYHLR/pliWwQP61ClUNQOKUgIkD72Fm9EufRbcwt1DEJ9JziO2ANoBoR+4qwRkr9axlAup2zHxfnSI86vc1CNXYQ5ZT26q/4gPF9ePC2DXpi5ynLJ0V8U0F4dhYaKs0uSHCi+IsfL5q5KmSq+CNvAJBsUM+XVPcTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmz1E4d5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmz1E4d5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso2891301f8f.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773591550; x=1774196350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ym5aS+9dL+OuJ07UvNuem6mw1n3bxgEj99fbf5/f9/8=;
        b=Jmz1E4d5pakwa9aydwWhItX8zk3tzvQE82iueSJcY64jkaEX6xHNZJhN7wuusjL66V
         gxAA2U1XD1a3TQI6uffsehwMntM3+DoEeXzgHhyffQHrpGhwi4eU5hbI4IBWbRV+xpt9
         9C032ZLjfooz2f1925BJ4Ld5Fnwa7VnJfAkVmzEADJJPq43qmQLgfAgjZNfFecry8gWw
         p2MOd6FpWl9O2MOuP3Nuliwf5LxDld0DlmZTuuUYBcLzPXnY3slRCHqw9klfaVDYtZuX
         UxrqXG6bddeRFI+M7ngRhiqTkz2Gp2s2qXUCWZ7yjZIzriLNUI932ngLtFt4+PVVQj0w
         DPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773591550; x=1774196350;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym5aS+9dL+OuJ07UvNuem6mw1n3bxgEj99fbf5/f9/8=;
        b=qDh/iqyu5jBW3tLJ1ZdPsnoVv7SAVRw5h3KDx2Jwao1NgTvcL4PVWVQhhWhHs5ba2E
         B3m1jRSBjukWPoDw+HDFz9JW1G3sXdEDLpZfEZqGx3vlJukihsXXQ2qlTUXDu2G2e8FT
         lXXcotEkzyQ6+MCd3QVU9D7jNISNbHMWdctFcku4FB859yTTGIWG8ZuG2qjZhx3uiQPM
         9fGwQA2Tnn4MDTaXw/+XhCx7uIpoOmcWIuuNjQ/kL6XorrfP5BZZbKg6RklS477A0Cdr
         Av/dtL2o+/uHlG+twJDZi1N7UwW93mSMhWa1V8jRI0W1kC6hWTFfyHrVi1X4VoFWyuoG
         pRrQ==
X-Gm-Message-State: AOJu0YyrLGdw0FErsMjnKJDBOaXr/Zuhwf53LcVs5Jj6qjBu/bU5QXIb
	4LTddcI2Axoi+XctbFkJJTXlrQjLzUxZEuHf2uy3wU4mLhUg+cRbCTyeo1Zmgg==
X-Gm-Gg: ATEYQzxAp7rZRnibYmgwsyLHt+q1bHzCWHG20Ej5fbo3psMaMCqGo72KO8k4D4phM2G
	mnPL1ZJPYU4J+m6uE7UluYq2b0QuGBi2NyYedI3wivmkxj8rMvKHo915ZN2FDh0BUoULLJYXMCI
	nXPeK//dJCzqIvj5/7izuDC/v5vuABUJYvAla3FX4Ko0aqSaK0wiBNBg7Vs1PKM0sWaI8rdNmCC
	vX5s4Of7zd4St+mkbmpC5X3/l38pSoG61JilUYOHvjUo56ypCQcpEyCGjeTQE9qFxZhGsprGVTY
	9FoC+eKi9wORZTgrXNTcoq6m5G4TeidfjFkCMflMwMHJG0JAEOYVQgfQa0U4noax/B3Wq3MKsHX
	Q+WxRIAOYGkrTVlGiqSylYumyUjPm8FxMJi41mi6fsbhptUp169wdilq1oGd7RhP4lEQEy9ej8V
	3EBn98XtmY5XrG9elVN0JjkZTIwgMB3zift+atlw==
X-Received: by 2002:a05:600c:4e08:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-485566cdc39mr159820635e9.6.1773591549988;
        Sun, 15 Mar 2026 09:19:09 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48558fd09d8sm200476225e9.7.2026.03.15.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:19:09 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/3] worktree add: stop reading ".git/HEAD"
Date: Sun, 15 Mar 2026 16:18:51 +0000
Message-ID: <c3c5767725d6d3b31604fbd0dd29486b70bc18a1.1773591528.git.phillip.wood@dunelm.org.uk>
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

The function can_use_local_refs() prints a warning if there are no local
branches and HEAD is invalid or points to an unborn branch. As part of
the warning it prints the contents of ".git/HEAD". In a repository using
the reftable backend HEAD is not stored in the filesystem so reading
that file is pointless. In a repository using the files backend it is
unclear how useful printing it is - it would be better to diagnose the
problem for the user. For now, simplify the warning by not printing
the file contents and adjust the relevant test case accordingly. Also
fixup the test case to use test_grep so that anyone trying to debug a
test failure in the future is not met by a wall of silence.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/worktree.c      | 21 ++-------------------
 t/t2400-worktree-add.sh | 28 ++++++++++++----------------
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index bc2d0d645ba..9170b2e8981 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -692,25 +692,8 @@ static int can_use_local_refs(const struct add_opts *opts)
 	if (refs_head_ref(get_main_ref_store(the_repository), first_valid_ref, NULL)) {
 		return 1;
 	} else if (refs_for_each_branch_ref(get_main_ref_store(the_repository), first_valid_ref, NULL)) {
-		if (!opts->quiet) {
-			struct strbuf path = STRBUF_INIT;
-			struct strbuf contents = STRBUF_INIT;
-			char *wt_gitdir = get_worktree_git_dir(NULL);
-
-			strbuf_add_real_path(&path, wt_gitdir);
-			strbuf_addstr(&path, "/HEAD");
-			strbuf_read_file(&contents, path.buf, 64);
-			strbuf_stripspace(&contents, NULL);
-			strbuf_strip_suffix(&contents, "\n");
-
-			warning(_("HEAD points to an invalid (or orphaned) reference.\n"
-				  "HEAD path: '%s'\n"
-				  "HEAD contents: '%s'"),
-				  path.buf, contents.buf);
-			strbuf_release(&path);
-			strbuf_release(&contents);
-			free(wt_gitdir);
-		}
+		if (!opts->quiet)
+			warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
 		return 1;
 	}
 	return 0;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 023e1301c8e..58b4445cc44 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -987,7 +987,7 @@ test_dwim_orphan () {
 				then
 					test_must_be_empty actual
 				else
-					grep "$info_text" actual
+					test_grep "$info_text" actual
 				fi
 			elif [ "$outcome" = "no_infer" ]
 			then
@@ -996,39 +996,35 @@ test_dwim_orphan () {
 				then
 					test_must_be_empty actual
 				else
-					! grep "$info_text" actual
+					test_grep ! "$info_text" actual
 				fi
 			elif [ "$outcome" = "fetch_error" ]
 			then
 				test_must_fail git $dashc_args worktree add $args 2>actual &&
-				grep "$fetch_error_text" actual
+				test_grep "$fetch_error_text" actual
 			elif [ "$outcome" = "fatal_orphan_bad_combo" ]
 			then
 				test_must_fail git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
-					! grep "$info_text" actual
+					test_grep ! "$info_text" actual
 				else
-					grep "$info_text" actual
+					test_grep "$info_text" actual
 				fi &&
-				grep "$bad_combo_regex" actual
+				test_grep "$bad_combo_regex" actual
 			elif [ "$outcome" = "warn_bad_head" ]
 			then
 				test_must_fail git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
-					grep "$invalid_ref_regex" actual &&
-					! grep "$orphan_hint" actual
+					test_grep "$invalid_ref_regex" actual &&
+					test_grep ! "$orphan_hint" actual
 				else
-					headpath=$(git $dashc_args rev-parse --path-format=absolute --git-path HEAD) &&
-					headcontents=$(cat "$headpath") &&
-					grep "HEAD points to an invalid (or orphaned) reference" actual &&
-					grep "HEAD path: .$headpath." actual &&
-					grep "HEAD contents: .$headcontents." actual &&
-					grep "$orphan_hint" actual &&
-					! grep "$info_text" actual
+					test_grep "HEAD points to an invalid (or orphaned) reference" actual &&
+					test_grep "$orphan_hint" actual &&
+					test_grep ! "$info_text" actual
 				fi &&
-				grep "$invalid_ref_regex" actual
+				test_grep "$invalid_ref_regex" actual
 			else
 				# Unreachable
 				false
-- 
2.52.0.362.g884e03848a9

