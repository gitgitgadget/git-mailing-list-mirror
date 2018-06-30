Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B6B1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935580AbeF3JJX (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36794 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934488AbeF3JIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:39 -0400
Received: by mail-lf0-f67.google.com with SMTP id n24-v6so8461935lfh.3
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3L0WEGoMD5mD4L3rTT3F2d2BwOQs2tqZg35tKopKBgE=;
        b=d1GzLTrkQoTPcza7EQdLx3sS2REIZ6UAGci2I5SgwPz0HsqgisnnMqfkMGf+oxsmKA
         MGGOd/BRMiIjKfygQbl0FyM5f20JyGm129KAsPRtHPKWfq6wlMVygfcTXPHhIp3Hxqwb
         P9CfxZmQbI+IBCmgWoIXH/Msm/WH5sF6D3wNBNnJBIEfhQP6YNci+Cea3emy5dpNyFE9
         xs4rxB4YrVHe6lmVyGJYlSgtqWg2xjZuf9+x9Lbdu3+QQw8uydOchBro16BofGlO4HQx
         17Gkw0z4TR4YUD8UzqZmflmyjbBqj3hYSPKsIxphFc7dRgW021be5IBlciNKntK9z6z4
         014w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L0WEGoMD5mD4L3rTT3F2d2BwOQs2tqZg35tKopKBgE=;
        b=gnji1fskMpjKsJvzjXgo7dAY5vNNVFu6dFO+FL2RB/XFLhaSMc28S/M1HnCCXju15g
         f+A5avR+y/4FUb3Pfolxq8QPBf3Y9nsw1HAFvUb7V+teRuJcl47dZd+HKd78K2bWFrXT
         iyTHtDAmGA4ecFNkb8SUV/HRuUZEE0KqvhmCnq/APt/LrMM8WR/vIuOiSTzSGjfjpeBw
         uv8KR8DqoLaD3sH4nSAjTYtx9N+j5B0yegaJgcvrHL0V3z1a0+8soqP+BE1deW95Pexd
         1zekVP4wXGchJqiLd5dZFpN138NwLppGlXBavUtipRP04Bgbv7e7Y57Detjq1PZdZe0t
         YMhg==
X-Gm-Message-State: APt69E1Dneekk1yUCs4Oy2H4mNYS5PDqIPpumBgs0NGsd/oWUfgBY5Id
        wCUOs+MOVcCnrxf3uIpdbv4HXQ==
X-Google-Smtp-Source: AAOMgpfdV3/otxQgt3Gq3zbanXgeMvMOylR4VfiQqm9tEpZL7ZK6qQYZ5mOylB1WtGgd9JkcAe5Jtg==
X-Received: by 2002:a19:17c2:: with SMTP id 63-v6mr11497172lfx.112.1530349718180;
        Sat, 30 Jun 2018 02:08:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/23] dir.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:07 +0200
Message-Id: <20180630090818.28937-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
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
index e1a2e1cffb..7c6e7a0a37 100644
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
@@ -3028,7 +3028,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
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
index 812db137b8..d6853e94be 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -377,7 +377,7 @@ test_expect_success 'init should register submodule url in .git/config' '
 
 test_failure_with_unknown_submodule () {
 	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
-	grep "^error: .*no-such-submodule" output.err
+	test_i18ngrep "^error: .*no-such-submodule" output.err
 }
 
 test_expect_success 'init should fail with unknown submodule' '
-- 
2.18.0.rc2.476.g39500d3211

