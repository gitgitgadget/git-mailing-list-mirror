Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622DB1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeFBEd0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35727 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbeFBEdD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:03 -0400
Received: by mail-lf0-f65.google.com with SMTP id y72-v6so17596647lfd.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0Yr6Z101Krt9kCGbsCbg1bS8uaRwUUMiSO79UC6RxE=;
        b=WUHSTSElsCq+mTFjW4Qquckg7s3oMv59Mtq12Z3sDkwO1eGh6P/R3PkOE/0RhOciNY
         LKyEP/j1F21lesFTi3ewN+rm95lYSennQPuOHp6qBZU5cm56KpJZrAv4xnscx9g6CuVU
         JbzhH/Rc6O0dFpvt2+VVObhpnqI4Jma6f4UUCmvVvRME36cC/FOoQdd4lfqqmT2/rq4k
         F8fGWyWVndpB/1nKnkOHdQmrpcanQK4J8rEBhEBz8um7iUtr1u8Cgm7e9M6GdGmy/sbu
         l4fabIeuxSTSH8qSPfqQP9GXpE6pbHLpk5RL+AuaEhFciCwBBqmFwDZKvaoStBb3vMI/
         SNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0Yr6Z101Krt9kCGbsCbg1bS8uaRwUUMiSO79UC6RxE=;
        b=Hi+h3Uig2Je0yJBau7cRnX4R7+CgD2Tvy4N90reO37siUQRhzLtgJYSf5YI/3jPrUp
         2W04mZTWTGMgCkMwPKH75x4WvODC57e0dIl6KIx8PaoB1xEgcSvVvv6qqQdgpVjTiU4L
         wUgAIDTsB/Xn2FhEwjHzrYeybjjsV5SwgtZgh2Hoy1B8RKeTnSGAumFcda4OZ1yIc1QI
         zZHpnCPFQRXrKpzglyFYUVJJ2YVYS95Ng9sNdTWgo8n9rLhmniaKgq5GUwwS0+pCe91C
         3ZmTChU3mG/3ywIupW63TGeVZ3/+OAlkySrZHGeeuw1prBtf2Bb2GRFcURquXmItnMmx
         1mCg==
X-Gm-Message-State: ALKqPwcbRBt8I03SICaMyW9fL86pGvsoUph3M5Is3waSleZT0So1eQf6
        7WQ5/0jK+Hvc2+e2nq4jeL66hA==
X-Google-Smtp-Source: ADUXVKI45kX9U4C6oRkbEeKPt/KpPHqaMiol1Q0xJkORS9hXxl4KFbRqvfeVxSKVirXi3N18rM5/Fg==
X-Received: by 2002:a2e:4149:: with SMTP id o70-v6mr10164992lja.3.1527913981447;
        Fri, 01 Jun 2018 21:33:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/22] dir.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:30 +0200
Message-Id: <20180602043241.9941-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c                             | 8 ++++----
 t/t3005-ls-files-relative.sh      | 4 ++--
 t/t7063-status-untracked-cache.sh | 2 +-
 t/t7400-submodule-basic.sh        | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index ccf8b4975e..848df83321 100644
--- a/dir.c
+++ b/dir.c
@@ -560,7 +560,7 @@ int report_path_error(const char *ps_matched,
 		if (found_dup)
 			continue;
 
-		error("pathspec '%s' did not match any file(s) known to git.",
+		error(_("pathspec '%s' did not match any file(s) known to git."),
 		      pathspec->items[num].original);
 		errors++;
 	}
@@ -949,7 +949,7 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 		dir->unmanaged_exclude_files++;
 	el = add_exclude_list(dir, EXC_FILE, fname);
 	if (add_excludes(fname, "", 0, el, NULL, oid_stat) < 0)
-		die("cannot use %s as an exclude file", fname);
+		die(_("cannot use %s as an exclude file"), fname);
 }
 
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
@@ -2230,7 +2230,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 
 	if (!ident_in_untracked(dir->untracked)) {
-		warning(_("Untracked cache is disabled on this system or location."));
+		warning(_("untracked cache is disabled on this system or location"));
 		return NULL;
 	}
 
@@ -3027,7 +3027,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 		return;
 
 	if (repo_read_index(&subrepo) < 0)
-		die("index file corrupt in repo %s", subrepo.gitdir);
+		die(_("index file corrupt in repo %s"), subrepo.gitdir);
 
 	for (i = 0; i < subrepo.index->cache_nr; i++) {
 		const struct cache_entry *ce = subrepo.index->cache[i];
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 377869432e..cd63ad129a 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -50,7 +50,7 @@ test_expect_success 'ls-files -c' '
 		ls ../x* >expect.out &&
 		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual.out 2>actual.err &&
 		test_cmp expect.out actual.out &&
-		test_cmp expect.err actual.err
+		test_i18ncmp expect.err actual.err
 	)
 '
 
@@ -65,7 +65,7 @@ test_expect_success 'ls-files -o' '
 		ls ../y* >expect.out &&
 		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual.out 2>actual.err &&
 		test_cmp expect.out actual.out &&
-		test_cmp expect.err actual.err
+		test_i18ncmp expect.err actual.err
 	)
 '
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index c61e304e97..c9162c54f4 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -666,7 +666,7 @@ test_expect_success 'test ident field is working' '
 	mkdir ../other_worktree &&
 	cp -R done dthree dtwo four three ../other_worktree &&
 	GIT_WORK_TREE=../other_worktree git status 2>../err &&
-	echo "warning: Untracked cache is disabled on this system or location." >../expect &&
+	echo "warning: untracked cache is disabled on this system or location" >../expect &&
 	test_i18ncmp ../expect ../err
 '
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2f532529b8..c1011b2311 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -375,7 +375,7 @@ test_expect_success 'init should register submodule url in .git/config' '
 
 test_failure_with_unknown_submodule () {
 	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
-	grep "^error: .*no-such-submodule" output.err
+	test_i18ngrep "^error: .*no-such-submodule" output.err
 }
 
 test_expect_success 'init should fail with unknown submodule' '
-- 
2.18.0.rc0.309.g77c7720784

