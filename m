Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580039989B
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425068; cv=none; b=eV/Kv0ixS4SZETUIP4kMcIM9HVdfRw0CMXSWg03zLWo4v5o+8u2KaArNbiGwNEyyHXojcr3B0oGG82gNGojDqP0KNCnWEYdPFBWjqi3jOVzhLr1nZMxKwVl2uCdeRZg1Dx2+gcDFeupquRMN2nPWmSWlT2IFCNZRkoCjciJEyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425068; c=relaxed/simple;
	bh=ANuIzcE1NUT+F/gmzY1fJoxpv0MC2TYHC6wZBfK4Mls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdhFhrdatvQciPiEcg8qZMunzNlLsFHfUZrwEMPYPIAUmxnbZbypFzckOWKuD6HrHv9KqQ+P2E7thHK1Q5VQHkz3cCeBWxyIDTLUoCQYepV6+VmJUT3MWeSUoJdlpUOV7Ieftz11FHwcexsAUdbKni6yFd/+Qi+/9QECaLAEc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhzlBcUr; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhzlBcUr"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-67109935888so1593380d50.3
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425066; x=1791029866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n55kxPtyjcz3XATfMg+/1KzsnbmX84myEnNT/qtr6CY=;
        b=jhzlBcUr6HrXlh1I79e+e5JHyMEKnv215ycrE3U6EfL1i40L25z8lI7/WfvoxSOLgs
         M62MHvuL8EaTjOtnGXuHYl+aZWUBRVIt9iMXBYIIP6kdR0wXif5Oc5igk0qIEJdoFEko
         2MgAjnqgOU9HWpnlAHksA2yAKD5bo3K0ZWPBY/eUGp1Yi5pFPq+znukXKgpcxNZbY49Z
         TavZO/or7zYt6TOPRSGQMZVEZ58MJOLB3SdCp77fyHTf6NEzsJXsu41WDN4u9vseK7uG
         Q3mxfY21VUF4yjGKFs9IMfokGEp9kQI9ti7fsUhVLyA4IsWYNyNnJ1D5L3FMej5FiCfD
         Hkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425066; x=1791029866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n55kxPtyjcz3XATfMg+/1KzsnbmX84myEnNT/qtr6CY=;
        b=k33Ea8dcfzykkKGV6Zw7ZAKF5Ywy8fQtgZKLfPBFZs3o9j+7yte5itmZNuNGe/aIX8
         tj9SbJyeUItR7cZNbwhaHQLMCCghjTO3ZSOE3joELUVamOtlgqLzjW8veZCHXYrKlHqx
         Qj4LQ6Gy00SZFC5axAx2E9TLyMe1L9Om42OrcLZ69eaxgopdkrlcmCIhAxHr/OIJxY9N
         N9TYelNE0UQZNY5yubdk2RdzCLrwPdM6Ide8GIJyRW7Am3TSibdKttOiM1zUOuS7Nyrb
         7q/5eHXlFZDwbnetdPR0LLR2f3c8OWTQq3qE5PKVJfhvl1SWkPmG/EpxNtiXzc0nHWwd
         MQWw==
X-Gm-Message-State: AFq9FYLbiwOzHCx6Y2+bNyG/HZ/Al4J5az7vBxoEPo1EquOSnhn6liPx
	sB/vlsyYA9/mknxE/zT1YR3FffZdWqve1SFu8WgbgFDSlktDfELGZbmqm8luvc8b
X-Gm-Gg: AYBFou19Ja9jL7CcIUH3g2v9Ne9SMV9uEypRtf9CMFJkh36cW6653v2FwMm18VxkOLn
	S/LyPagkLENIoclyoEwLXTup6e5Yz/rMcYROPQQxVyEf75DscdUTG8vVEQEiXNi4Y0S+/nwirtb
	vPAvH8DkntOUT/CJQ1pStA1a3HOo9lOB6VDm4Y2pQ3tPLqGsV++MuRrIJl2/rkFCwlvrrWobubB
	0f0xmfmC+bkfbpOFVtpNQ4QckfO8yv9LrBo5yApjw/AIrEQUTSA2SLzQeII33C8GpZRkc8cHg4G
	MWvIdF+0xWEtIXaGThlR0Whx2dfSeeHdqKIuxICQaNMBax1Rzz+mbpFywfWU18HfIt8cfJubjPF
	q66MS3Js/uZtqlXgzDjTL6ifEtEk1r8CEI4HpJQtbUpGdBc7uWTVhM7N03SfIDmdN0xwxdCtXg9
	fuomiCfscfhp/wwQaViP4c153BpZtkjrFnWPi02dLfSrZ9+UCFxRVZiDlbxRyCasw97sOXnfIEa
	dvwegVAHDy7RrEFPYkJnOEOi3XQNcnmhhBhIHsH8EP4w856zfNT0GeMgIAuI6A0e3tTJ0rrSjw6
	LZXIsjLi68MUPOKvAoAVCYKocwgtLt6eR5GDb1BNuXQ=
X-Received: by 2002:a05:690e:d0a:b0:674:14d2:5447 with SMTP id 956f58d0204a3-67414d25d9bmr1594625d50.23.1790425065891;
        Sat, 26 Sep 2026 05:17:45 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm2179151d50.5.2026.09.26.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:17:43 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Adam Johnson <me@adamj.eu>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 5/5] builtin/stash: merge index in-core
Date: Sat, 26 Sep 2026 08:16:48 -0400
Message-ID: <fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com>
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git stash apply --index" does a 2-step dance to report index conflicts
before carrying out the main unstash: first, attempt to merge the index
(and remember the name of the resulting tree). If that succeeds, reset
the index and carry on unstashing the working tree, then use the
remembered index tree to unstash the index.

The "merge the index" step is performed on the actual index by a
combination of git-diff-tree(1) and git-apply(1), which incurs an extra
cost to git-reset(1) to cleanup. This also introduces an autostash bug
when stash.index is true: "git reset" eventually wants to
remove_merge_branch_state(), which calls save_autostash() due to
a03b55530a (merge: teach --autostash option, 2020-04-07). This can
happen from a "git merge --autostash", which itself calls
save_autostash(). Operating on the file-system in this way is not
re-entrant, so we end up trying to lock a now-deleted MERGE_AUTOSTASH
ref [1]. This bug has lurked for a while, but it would have been
impossible to trigger without the availability of stash.index to force
the autostash apply into index mode.

[1]: https://lore.kernel.org/git/CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com/

Fortunately, we can achieve 2 goals at once: avoid round-tripping to the
file-system (and invoking expensive subprocesses) by performing the
merge in-core. If there are conflicts, we discard the resulting tree, so
we don't see the usual branch and ancestor labels, but the merge
subroutines insist on their presence, so use something simple.

We *could* swap just the git-reset(1) subprocess with our internal
reset_tree() and refresh_index(), which would fix the bug. We'd much
prefer to clean up these vestiges of the shell-based git-stash, though.

Reported-by: Eli Barzilay <eli@barzilay.org>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c  | 80 ++++++++++--------------------------------------
 t/t7600-merge.sh |  9 ++++++
 2 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 043a38cc6d..ac3b3cf84d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -422,50 +422,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	return ret;
 }
 
-static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *w_commit_hex = oid_to_hex(w_commit);
-
-	/*
-	 * Diff-tree would not be very hard to replace with a native function,
-	 * however it should be done together with apply_cached.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "diff-tree", "--binary", "--no-color", NULL);
-	strvec_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
-
-	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
-}
-
-static int apply_cached(struct strbuf *out)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	/*
-	 * Apply currently only reads either from stdin or a file, thus
-	 * apply_all_patches would have to be updated to optionally take a
-	 * buffer.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "apply", "--cached", NULL);
-	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
-}
-
-static int reset_head(void)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	/*
-	 * Reset is overall quite simple, however there is no current public
-	 * API for resetting.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
-
-	return run_command(&cp);
-}
-
 static int is_path_a_directory(const char *path)
 {
 	/*
@@ -671,29 +627,27 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		    oideq(&c_tree, &info->i_tree)) {
 			has_index = 0;
 		} else {
-			struct strbuf out = STRBUF_INIT;
+			struct merge_result result = { 0 };
 
-			if (diff_tree_binary(&out, &info->w_commit)) {
-				strbuf_release(&out);
-				return error(_("could not generate diff %s^!."),
-					     oid_to_hex(&info->w_commit));
-			}
+			o.branch1 = "Current index";
+			o.branch2 = "Stashed index changes";
+			o.ancestor = "Stash base";
 
-			ret = apply_cached(&out);
-			strbuf_release(&out);
-			if (ret)
+			o.verbosity = 0;
+
+			head = lookup_tree(o.repo, &c_tree);
+			merge = lookup_tree(o.repo, &info->i_tree);
+			merge_base = lookup_tree(o.repo, &info->b_tree);
+
+			merge_incore_nonrecursive(&o, merge_base, head, merge,
+						  &result);
+
+			oidcpy(&index_tree, &result.tree->object.oid);
+			merge_finalize(&o, &result);
+
+			if (!result.clean)
 				return error(_("conflicts in index. "
 					       "Try without --index."));
-
-			discard_index(the_repository->index);
-			repo_read_index(the_repository);
-			if (write_index_as_tree(&index_tree, the_repository->index,
-						repo_get_index_file(the_repository), 0, NULL))
-				return error(_("could not save index tree"));
-
-			reset_head();
-			discard_index(the_repository->index);
-			repo_read_index(the_repository);
 		}
 	}
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 64fe21717d..8f6109fb91 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -801,6 +801,15 @@ verify_no_mergehead () {
 	test_cmp result.1-5 file
 '
 
+test_expect_success 'fast-forward merge with --autostash, stash.index' '
+	git reset --hard c0 &&
+	git stash clear &&
+	echo staged >>z && git add z &&
+	git -c stash.index=true merge --autostash c1 2>err &&
+	test_grep "Applied autostash." err &&
+	test_stdout_line_count = 0 git stash list
+'
+
 test_expect_success 'failed fast-forward merge with --autostash' '
 	git reset --hard c0 &&
 	git merge-file file file.orig file.5 &&
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

