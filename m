Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3501F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeFCQfD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:03 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38523 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeFCQe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so9403434lfh.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7zEnG1UjTF2+dLkYi87D7I+Et8tjhjAfN/PDxkNeSE=;
        b=HYSj8fXKJxqrcD/e7jMUF/O/XjXPcgKAPUScP+jt3uTU+X2/yRO/PVI3qmCM9AG9Xo
         l1z5Ik8PWR8UP9P6zEz69Wf/gaaD+tlUK8+fkpF6LwG+J6ROyIVlQnJUOo8qL0WGkvVU
         GdsA7J6eo2RLKxsACRV4o3xm9Q7N2ZqtLos4QajzTUo6myxl+qOeu5jkIYodVXxTeCnk
         1B1Ey3TUhHfzEpxLmcQRL40FpY/OUR0YFlqV9Z3g4Jops0LITHHx5Np7RbUQ25cLWBzO
         X24jGwtsd0C/bpwpGD7yK8zG1iLztbxylMLWA72SrsO8QJi78RtMJBSLABZ+cLkR21tW
         rVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7zEnG1UjTF2+dLkYi87D7I+Et8tjhjAfN/PDxkNeSE=;
        b=aHoB1T4y0r+6tziYgOoWQRxabeO3iVWI5TdpFBh0UqIGE6Jo1EKo0MprwFvmkC138g
         NYRfLDj89Gn0gL+sTBUIR79tBuumGu51v+Bw2GAwYKAmMfy2L2tksjJntaeQy1rD4gAk
         8iffhQwUzA/hfoHU0wHrQ8VHxrcIVib62pjPZpqCEi9WrvJHPyEOstDEarh6zRyFCMNg
         jG13zQob8dWU41vACV26zq2P0G6rTaPv3a1rC9bzVgTGXBBhz/Gg0rE4XJP9FpD+VQWg
         ahp/uMJqxrRDUWcRoZ6prQmdqSW+pib+5v7b6Io7oYEFbQuMmzKVAe8DnXu+i2C1Ut+P
         RkJw==
X-Gm-Message-State: APt69E1d5PqGit+r7Tonsb+yS9ebajm+u+Wub9C7Pbxv2xOwNVPBGUKA
        K2HXZWqBHWYsdaJ9BzZKJSM=
X-Google-Smtp-Source: ADUXVKKqRIkK+106rzrly0OsvAsh1iZHZqyY71IueoSiUUvJJTE13W6IViI9ukcdS3ZByh7LBWsJCw==
X-Received: by 2002:a2e:8350:: with SMTP id l16-v6mr525409ljh.28.1528043695017;
        Sun, 03 Jun 2018 09:34:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/23] dir.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:09 +0200
Message-Id: <20180603163420.13702-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c                        | 6 +++---
 t/t3005-ls-files-relative.sh | 4 ++--
 t/t7400-submodule-basic.sh   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 7e39f38563..8e7fa02a01 100644
--- a/dir.c
+++ b/dir.c
@@ -560,7 +560,7 @@ int report_path_error(const char *ps_matched,
 		if (found_dup)
 			continue;
 
-		error("pathspec '%s' did not match any file(s) known to git",
+		error(_("pathspec '%s' did not match any file(s) known to git"),
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
@@ -3027,7 +3027,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 		return;
 
 	if (repo_read_index(&subrepo) < 0)
-		die("index file corrupt in repo %s", subrepo.gitdir);
+		die(_("index file corrupt in repo %s"), subrepo.gitdir);
 
 	for (i = 0; i < subrepo.index->cache_nr; i++) {
 		const struct cache_entry *ce = subrepo.index->cache[i];
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 341fad54ce..209b4c7cd8 100755
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
2.18.0.rc0.333.g22e6ee6cdf

