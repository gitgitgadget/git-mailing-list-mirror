Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA79B1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbeGRQvf (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43711 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbeGRQve (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id m12-v6so3858004lfc.10
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3L0WEGoMD5mD4L3rTT3F2d2BwOQs2tqZg35tKopKBgE=;
        b=R9W/TqzVEvYAeDFDbvAbmYEbOMvP+DX0UKDlZRDUcAaOYR7uzXaRGs9S5zKmkvzyFl
         hDuSrYvkFPF9Yu2kH37Hl1ftEubS1r8xfjNHniUi/8FTRk9FlFzBSwSaSCuvfiIddFEw
         WR+jJUkv1/4oIWd8+xepJqR8hJrk2g5s21UfIvatgQSTVMWLbV2zA9FOtN7TtUcSggdW
         wmMMnxlHhBOVGyYhXYWDu7JWGAS4oHJZfHEFpu3loyTuzfkxTopglblvScct57Ub1uDn
         l6YongFzFTSEXjylRioJqo2mmPQIXFxa1bPF+cwszxv8+Vm1u2QESQLNt4hwyXvVdkrc
         o1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L0WEGoMD5mD4L3rTT3F2d2BwOQs2tqZg35tKopKBgE=;
        b=h2sYluxw5//C79FXn9XABFTGW7R1XsAHyEo+SKrDYVdM6NnCOLnf2ethvWK6B76+qN
         S3C6AErNBkggzRGAnLjgE2243XsGoCqonUGy+47/eW0fsk9mLqo6WkOv9Fl7s39wqY0R
         pez98IcYgvifJ0M1D15k/6wV8eJwR9xt2XThPuV6VteAf9FEocJ6jo7Ip6tYH8/gyOR4
         ydJcoJiUTj3NfqSSKFUXNoXWeKmqfdAK3FTCEaEaJixsxTtP10OpxjsnuGpdMZh4G87K
         6Xgo9yU5PiwNJcdYg2G9FpQHQc7wKWFdt1fIou/nGmwYcqv5FkJtSewM9HuuIJuPy6We
         5SYw==
X-Gm-Message-State: AOUpUlER8OKcouWAJYRwO2S+DSBCLRwn3D2vYKnTV1j+Zv5e3LzrSY9z
        GbdfQLkg+o05VhpV3BOTcJCOoA==
X-Google-Smtp-Source: AAOMgpdVpQPXms2LBF70qnSTb3/+heTTvTAsekv0LuJlda/uyq8ValaK++loWkY3/e7Y+zYYvwwcLQ==
X-Received: by 2002:a19:6511:: with SMTP id z17-v6mr4342138lfb.56.1531930377192;
        Wed, 18 Jul 2018 09:12:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/23] dir.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:50 +0200
Message-Id: <20180718161101.19765-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
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

