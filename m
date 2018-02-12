Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E201F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbeBLJuI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:08 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34629 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932720AbeBLJuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:06 -0500
Received: by mail-io0-f173.google.com with SMTP id e7so2398688ioj.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9aVX3fNYUrSaRuDvjhP/Tiis1w7wP1ygabEBm9KI7U=;
        b=ZQEKNd/Z4jGlZK0B0TilWNIPE0nWHascAJW/4gSE4WT52l6JHgIhvxvZpky2VYUGMf
         HhePAq2OhOdxYbzjoc8Whz86cvjOc/QpE/XXYUZh5BFRHI4g9CdQyd5eTcFvfh43XWbk
         vp5iMYHm1Czm240QXNAYZXb9BwFf23PXz7laWVzm6yUpK/8y/W2OJJZO6gYLGcFC1PrJ
         aUfGbmTioXp98Ut+gRfLSc1Evfa1RHrzGp4Xkff8QbwfCvaW8/qhyTw1HFOrMK/MHKYG
         S+7OFsdrFMBRyjaa/NrH51j0NrQ+jZTn53D4sd7shi+Nr/8UKoCR0TTVfp6i8/DdsGpr
         X03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9aVX3fNYUrSaRuDvjhP/Tiis1w7wP1ygabEBm9KI7U=;
        b=A2yQ4CYDsSbwJ9TKeVgo073h9jfYIqKAvXd6F6Ql76R48eEOw1PSlakTQQ4oR4WopE
         uatSJ/yDmpfWVVtmJQS7MUWEQ+Gmm+XX5eA+Qvpfvz2zlPMkgn3JSVfW4WUmsqodxfrk
         MKTkziivOvzMB+Fy/1XZPs7QkhfhPhlg1U1opnKpV7tncEWoT9LDHEd/awv8EYVg40JP
         21jD3kL7Fc3nvk27nrNbq+Ssw3WROhmXcoGFuXXUQ5gr8fpQrcKT8HyHayimlvsldrRM
         nHo1h0fSrP+FUDRGkPyHbdAOg1AcQGnNupRrXrRyMyd8QIofevFruF6lyH3hx5ER3qlF
         QfwA==
X-Gm-Message-State: APf1xPDjBIQ9lGdyoaagKUx5NKGSz/KiIx8H5Jp0uCnAa+G+K6SlXjzy
        nIgAQNcP+6jiD/YhSNSd4wnhNg==
X-Google-Smtp-Source: AH8x227jg7cC485LZpEARmZe8jFbwkU4bQKt21C1zlv6JS7ZEOsqRoJ3g0BwN7Bs+4P6LMpxuw/57Q==
X-Received: by 10.107.153.212 with SMTP id b203mr12230844ioe.264.1518429005551;
        Mon, 12 Feb 2018 01:50:05 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id c15sm7588121itd.4.2018.02.12.01.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:49:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 0/7] nd/worktree-move reboot
Date:   Mon, 12 Feb 2018 16:49:33 +0700
Message-Id: <20180212094940.23834-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 basically fixes lots of comments from Eric (many thanks!): memory
leak, typos, document updates, tests, corner case fixes.

Interdiff:

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 6f83723d9a..d322acbc67 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -36,10 +36,6 @@ The working tree's administrative files in the repository (see
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
 
-If you move a linked working tree, you need to manually update the
-administrative files so that they do not get pruned automatically. See
-section "DETAILS" for more information.
-
 If a linked working tree is stored on a portable device or network share
 which is not always mounted, you can prevent its administrative files from
 being pruned by issuing the `git worktree lock` command, optionally
@@ -211,7 +207,7 @@ thumb is do not make any assumption about whether a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
 
-If you move a linked working tree, you need to update the 'gitdir' file
+If you manually move a linked working tree, you need to update the 'gitdir' file
 in the entry's directory. For example, if a linked working tree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8ce86aef0e..f77ef994c4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -653,21 +653,19 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
-
-	validate_no_submodules(wt);
-
 	if (is_directory(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
 		if (!sep)
 			die(_("could not figure out destination name from '%s'"),
 			    wt->path);
+		strbuf_trim_trailing_dir_sep(&dst);
 		strbuf_addstr(&dst, sep);
-		if (file_exists(dst.buf))
-			die(_("target '%s' already exists"), dst.buf);
-	} else if (file_exists(dst.buf)) {
-		die(_("target '%s' already exists"), av[1]);
 	}
+	if (file_exists(dst.buf))
+		die(_("target '%s' already exists"), dst.buf);
+
+	validate_no_submodules(wt);
 
 	reason = is_worktree_locked(wt);
 	if (reason) {
@@ -677,7 +675,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		die(_("cannot move a locked working tree"));
 	}
 	if (validate_worktree(wt, &errmsg, 0))
-		die(_("validation failed, cannot move working tree:\n%s"),
+		die(_("validation failed, cannot move working tree: %s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
 
@@ -686,6 +684,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 
 	update_worktree_location(wt, dst.buf);
 
+	strbuf_release(&dst);
+	free_worktrees(worktrees);
 	return 0;
 }
 
@@ -708,6 +708,10 @@ static void check_clean_worktree(struct worktree *wt,
 	char buf[1];
 	int ret;
 
+	/*
+	 * Until we sort this out, all submodules are "dirty" and
+	 * will abort this function.
+	 */
 	validate_no_submodules(wt);
 
 	argv_array_pushf(&child_env, "%s=%s/.git",
@@ -724,7 +728,7 @@ static void check_clean_worktree(struct worktree *wt,
 	cp.out = -1;
 	ret = start_command(&cp);
 	if (ret)
-		die_errno(_("failed to run git-status on '%s'"),
+		die_errno(_("failed to run 'git status' on '%s'"),
 			  original_path);
 	ret = xread(cp.out, buf, sizeof(buf));
 	if (ret)
@@ -733,7 +737,7 @@ static void check_clean_worktree(struct worktree *wt,
 	close(cp.out);
 	ret = finish_command(&cp);
 	if (ret)
-		die_errno(_("failed to run git-status on '%s', code %d"),
+		die_errno(_("failed to run 'git status' on '%s', code %d"),
 			  original_path, ret);
 }
 
@@ -748,7 +752,6 @@ static int delete_git_work_tree(struct worktree *wt)
 		ret = -1;
 	}
 	strbuf_release(&sb);
-
 	return ret;
 }
 
@@ -797,7 +800,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		die(_("cannot remove a locked working tree"));
 	}
 	if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
-		die(_("validation failed, cannot remove working tree:\n%s"),
+		die(_("validation failed, cannot remove working tree: %s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
 
diff --git a/strbuf.c b/strbuf.c
index 1df674e919..46930ad027 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -95,6 +95,7 @@ void strbuf_trim(struct strbuf *sb)
 	strbuf_rtrim(sb);
 	strbuf_ltrim(sb);
 }
+
 void strbuf_rtrim(struct strbuf *sb)
 {
 	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
@@ -102,6 +103,13 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
+{
+	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_ltrim(struct strbuf *sb)
 {
 	char *b = sb->buf;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..e6cae5f439 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -179,6 +179,9 @@ extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 
+/* Strip trailing directory separators */
+extern void strbuf_trim_trailing_dir_sep(struct strbuf *);
+
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 459f676683..082368d8c6 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -66,21 +66,16 @@ test_expect_success 'move non-worktree' '
 
 test_expect_success 'move locked worktree' '
 	git worktree lock source &&
-	test_must_fail git worktree move source destination &&
-	git worktree unlock source
+	test_when_finished "git worktree unlock source" &&
+	test_must_fail git worktree move source destination
 '
 
 test_expect_success 'move worktree' '
 	toplevel="$(pwd)" &&
 	git worktree move source destination &&
 	test_path_is_missing source &&
-	git worktree list --porcelain | grep "^worktree" >actual &&
-	cat <<-EOF >expected &&
-	worktree $toplevel
-	worktree $toplevel/destination
-	worktree $toplevel/elsewhere
-	EOF
-	test_cmp expected actual &&
+	git worktree list --porcelain | grep "^worktree.*/destination" &&
+	! git worktree list --porcelain | grep "^worktree.*/source" >empty &&
 	git -C destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
@@ -90,23 +85,38 @@ test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
 
+test_expect_success 'move worktree to another dir' '
+	toplevel="$(pwd)" &&
+	mkdir some-dir &&
+	git worktree move destination some-dir &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree.*/some-dir/destination" &&
+	git -C some-dir/destination log --format=%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2
+'
+
 test_expect_success 'remove main worktree' '
 	test_must_fail git worktree remove .
 '
 
+test_expect_success 'move some-dir/destination back' '
+	git worktree move some-dir/destination destination
+'
+
 test_expect_success 'remove locked worktree' '
 	git worktree lock destination &&
-	test_must_fail git worktree remove destination &&
-	git worktree unlock destination
+	test_when_finished "git worktree unlock destination" &&
+	test_must_fail git worktree remove destination
 '
 
 test_expect_success 'remove worktree with dirty tracked file' '
 	echo dirty >>destination/init.t &&
+	test_when_finished "git -C destination checkout init.t" &&
 	test_must_fail git worktree remove destination
 '
 
 test_expect_success 'remove worktree with untracked file' '
-	git -C destination checkout init.t &&
 	: >destination/untracked &&
 	test_must_fail git worktree remove destination
 '
@@ -124,4 +134,13 @@ test_expect_success 'remove missing worktree' '
 	test_path_is_missing .git/worktrees/to-be-gone
 '
 
+test_expect_success 'NOT remove missing-but-locked worktree' '
+	git worktree add gone-but-locked &&
+	git worktree lock gone-but-locked &&
+	test -d .git/worktrees/gone-but-locked &&
+	mv gone-but-locked really-gone-now &&
+	test_must_fail git worktree remove gone-but-locked &&
+	test_path_is_dir .git/worktrees/gone-but-locked
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 542196f0ad..28989cf06e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -340,11 +340,10 @@ void update_worktree_location(struct worktree *wt, const char *path_)
 	if (is_main_worktree(wt))
 		die("BUG: can't relocate main worktree");
 
-	strbuf_add_absolute_path(&path, path_);
+	strbuf_realpath(&path, path_, 1);
 	if (fspathcmp(wt->path, path.buf)) {
-		write_file(git_common_path("worktrees/%s/gitdir",
-					   wt->id),
-			   "%s/.git", real_path(path.buf));
+		write_file(git_common_path("worktrees/%s/gitdir", wt->id),
+			   "%s/.git", path.buf);
 		free(wt->path);
 		wt->path = strbuf_detach(&path, NULL);
 	}

