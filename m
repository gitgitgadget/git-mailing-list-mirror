Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984C91F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeGUIl6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39042 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGUIl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so12892728lji.6
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMuOT8jJfHs/V0nqYm7prZ/3GO+4uecUwVEle+9WDzA=;
        b=JizGel3a90/BYwspN4TQ2ProMZrGTbNx5QepNJR1pHvRBhTrKQlHWm+NlgKvcGisRs
         /LKiI2k9FUsKz//NCdAhQ0h1TxRHxc9eFdIXrQTaOiDTuanjkjtBF6akJKqyAyujNCwO
         j50hddpa1udPKg1HCc/76PX8N3nQkzAjn7goCPWkdN8f9oixuQJNORp/DqcX5d7csbtW
         JVQLzTxCDhWagNPnhGTWtRmQoRcvy1jQPxKQGiqNRJMfF39BGFVKWjkMoQKelUnAv7II
         A0GIRwMRXY15K9MuGz/atAbxyECFJy5XAq5BVnX9LNYHImHnQjAbSNPEfqJ7hdohnyy+
         82QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMuOT8jJfHs/V0nqYm7prZ/3GO+4uecUwVEle+9WDzA=;
        b=cD1YTFrKBqwbybiPzdVEn0szAFJrSFMdBOZCyj8pBuC0h1ghmbWHGSEFeDcQnGYQOn
         ktx86N7jRV/TxIEcbKswAri2sXwcqhInpqLrzfzVy0+eIckCV7mfLujR/0iqcEdLGBir
         UfKiEojAXexbkBAV+OPVuykX+w8cT56LAMybLcfRzwWbcDfPqz3rjaESJtx1UhMuGlhk
         8wsTxnEVGKAkBuwRkTx2b4OW8NuZp8dT8u/MdCK1SpL/wGRkY6dnSFrc7hj/b4B48QW2
         h5IQYNsHhDic/Neh1hjuA0j24xH5HW5VzT3kLuo3OYOYImgnYkD9nYqQXGK1jQyfZKPW
         68ZQ==
X-Gm-Message-State: AOUpUlGdPZENU2rYz0YalHx2akQ1VROiAWiCSrdE/GFLolydk07qYVyU
        7WLiCWieYKO5NXYHKTHYQNI=
X-Google-Smtp-Source: AAOMgpcVOHX2tQ+2K8l4nxOA4jWEQudBlT0UIj9713M+mFf2JBvi8Qsrr1OAKW2l8nfbOOicKbYMJw==
X-Received: by 2002:a2e:752:: with SMTP id i18-v6mr3562852ljd.118.1532159408405;
        Sat, 21 Jul 2018 00:50:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 12/23] dir.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:30 +0200
Message-Id: <20180721074941.14632-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
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
2.18.0.656.gda699b98b3

