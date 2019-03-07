Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7ABB20248
	for <e@80x24.org>; Thu,  7 Mar 2019 09:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCGJfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:35:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36543 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGJfn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:35:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so12852036eds.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GdT3j5IgrhNQavwpTNQXEui2sGmb06C817d8Z/wNGMw=;
        b=DrBi4clvroBMzAKTN5ZcEcLxs6khZfs/WiO+jqMea6dgvSpUwbGFqZCa7sYXB9VRZS
         UTPDrYa507TcU8LVxVvvNR3/zGwwqElyvAh3aaYsF5LGW1vpF0PNUXPNYH0HoecZknhh
         1zljrLHzxh9pmPm+IzD8xeGJP9e8KgQEzgnnJ5fNn6WPlWdxhXQDvSDhOPzJZniQ5f9H
         3sPgQbfckTpYVc+PFnKpeFDINTkFcnITMUdHsUA4pw4zF00VDiYvamt0lTlgETxc6PP3
         85N4UCY/0fUB0DjD8jyjyw3b6C4WXlo/ds6B6LvHu+UxGcs1sdnAGXU5bb6t++9Z3e+3
         WoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GdT3j5IgrhNQavwpTNQXEui2sGmb06C817d8Z/wNGMw=;
        b=ttQuS86hRGt7WsrQ31afLJ4CKdDGgI/EPwe28r9XbzTGurFLDhINy3yowTwWTb85Mx
         TaV1BZVFoxxbldyMHcByCX4Pk4R1gpNn3NW8T/gPaK1KiyhHFiZD9ANzqiXnv79q4/Z9
         OAW0Rx5I+6joSWolwGi/VRldQi/teCbORjv4EZ97whBOwSrADGPYGAayqHyep4Oa8EGY
         WcqdE/At451iHsdCVYHAmMVv3snXkN4fisTQ06cprLRqWQY+HJVByEqglVyXFV7LVQ4p
         k2CiC0s1HUX6ENI0Almn40KPRt1BWC82I4x2j5/xac+aKqtMUcZmUlcxAQ481elpZJIz
         RTAg==
X-Gm-Message-State: APjAAAXCAupCv0lFFUGLo74DNPhWBd2ueeobJ7T/XWmH+EqTedkIUTbL
        NlDYlg/fhOip/UlMHb63/rakOuDx
X-Google-Smtp-Source: APXvYqzN726hnK0jx21K4zB9EPDJ/9kgcIAuJaLjWI++1e4WcsAdF/z9p++DYyUZMTRE1lgW1Ry93Q==
X-Received: by 2002:a50:9fe9:: with SMTP id c96mr28105906edf.0.1551951341149;
        Thu, 07 Mar 2019 01:35:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a52sm1166765edc.74.2019.03.07.01.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:35:40 -0800 (PST)
Date:   Thu, 07 Mar 2019 01:35:40 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 09:35:39 GMT
Message-Id: <008e367d26de12debd596e8f16356f70c74d3d7e.1551951339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.131.git.gitgitgadget@gmail.com>
References: <pull.131.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: respect core.hidedotfiles = false in git-init
 again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a brown paper bag. When adding the tests, we actually failed
to verify that the config variable is heeded in git-init at all. And
when changing the original patch that marked the .git/ directory as
hidden after reading the config, it was lost on this developer that
the new code would use the hide_dotfiles variable before the config
was read.

The fix is obvious: read the (limited, pre-init) config *before*
creating the .git/ directory.

This fixes https://github.com/git-for-windows/git/issues/789

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/init-db.c |  6 ++++++
 t/t0001-init.sh   | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 93eff7618c..94df241ad5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -155,6 +155,9 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "init.templatedir"))
 		return git_config_pathname(&init_db_template_dir, k, v);
 
+	if (starts_with(k, "core."))
+		return platform_core_config(k, v, cb);
+
 	return 0;
 }
 
@@ -361,6 +364,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	}
 	startup_info->have_repository = 1;
 
+	/* Just look for `init.templatedir` and `core.hidedotfiles` */
+	git_config(git_init_db_config, NULL);
+
 	safe_create_dir(git_dir, 0);
 
 	init_is_bare_repository = is_bare_repository();
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 42a263cada..35ede1b0b0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -453,6 +453,18 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success MINGW 'core.hidedotfiles = false' '
+	git config --global core.hidedotfiles false &&
+	rm -rf newdir &&
+	(
+		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
+		mkdir newdir &&
+		cd newdir &&
+		git init
+	) &&
+	! is_hidden newdir/.git
+'
+
 test_expect_success MINGW 'redirect std handles' '
 	GIT_REDIRECT_STDOUT=output.txt git rev-parse --git-dir &&
 	test .git = "$(cat output.txt)" &&
-- 
gitgitgadget
