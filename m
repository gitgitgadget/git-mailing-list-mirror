Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65DEC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiBWO37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiBWO3y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBBB2525
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i20so3481044wmc.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEwQOKVfS1z3z4RURBKjrMl0ojCq6mcDnKEPehPFfRg=;
        b=gUDuJGmrfck7GFPA8FRzn+LJDJMBb79a96k2B8bQz0Z3dCTi0gZPpahjltD4Ky39tj
         cCMc/2JMc33fRPy5FSMSxJUAhw6K+iOaccDByEH6ZYiqPS4+DY9KOVKxouvzs7IjQsOT
         HIeXNJWfs5Bkf2EhYmpKtb+wN/UIg2LPV48V+Taf6UOeUc6sKiPV8CAohlysknGSZlnG
         Y+Mh95juTBNA4FnpDgBRPQyDDNSvWz8OHtkZlfff3mAdGILKieNgX+z7ayjCttOY5Nuf
         A0kI+3FM2xeErytX/aO4NJZe5TruziAsovREc3s0zcfMt0jpCpGQJHpTbKx0RRu3piNZ
         Do5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEwQOKVfS1z3z4RURBKjrMl0ojCq6mcDnKEPehPFfRg=;
        b=FDe+f3p/EC9cgEMGy+WP1qebeslMoaXQsq/RqRFhMayQWhf+tjSU1PSHS7PxIBnlxP
         mLRFoYRSfKd5rSocAjj+4PLVG2+ar0t/cWrxbukOKaOgLkpTGtkwa+zI6SwT6WKGDnil
         CkK1lVsAAmtq5zJ85akrkVruRy6D4uLgsWa9iD0yMs/aMbBRDDWzJX8srlhsUEDYQgyp
         ZAjmZuXykxRAjH+I4xP8eBCQSwhQutfcegSFBoQ8qI0XjILZ7bmkz1H42TWbgavtjMnj
         TkI9bxSo2Cv8kUlLtGA+UWcrvzsb/dsMHxLCPHzL0RW8WTAMsiSoHpffzxJO7P2b2jnO
         8oCQ==
X-Gm-Message-State: AOAM531Ve2xocWWSTTmpf1n/K1IdUZ/LAe50VfojdCTXKORUYY4TNIhN
        p64uGziR5DtpCeN/dVNYS19cVfThihE=
X-Google-Smtp-Source: ABdhPJxXHeZyXruRBFjRCa/3CDawqoz0chV615wooQkDJXHP1fzMu6y536jLmV4CUrwGq9iLU90zRw==
X-Received: by 2002:a05:600c:2e54:b0:380:d3c8:ef33 with SMTP id q20-20020a05600c2e5400b00380d3c8ef33mr4446wmf.69.1645626564770;
        Wed, 23 Feb 2022 06:29:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm19971540wre.66.2022.02.23.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:24 -0800 (PST)
Message-Id: <1e62e4e4fa1a543ad134d70d97740cac5826e587.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:12 +0000
Subject: [PATCH v3 04/11] worktree: extract checkout_worktree()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The ability to add the --no-checkout flag to 'git worktree' was added in
ef2a0ac9a0 (worktree: add: introduce --checkout option, 2016-03-29).
Recently, we noticed that add_worktree() is rather complicated, so
extract the logic for this checkout process to simplify the method.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c806aa2b261..25807e63a25 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -292,6 +292,18 @@ worktree_copy_cleanup:
 	free(to_file);
 }
 
+static int checkout_worktree(const struct add_opts *opts,
+			     struct strvec *child_env)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
+	if (opts->quiet)
+		strvec_push(&cp.args, "--quiet");
+	strvec_pushv(&cp.env_array, child_env->v);
+	return run_command(&cp);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -425,17 +437,9 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->checkout) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-		cp.git_cmd = 1;
-		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
-		if (opts->quiet)
-			strvec_push(&cp.args, "--quiet");
-		strvec_pushv(&cp.env_array, child_env.v);
-		ret = run_command(&cp);
-		if (ret)
-			goto done;
-	}
+	if (opts->checkout &&
+	    (ret = checkout_worktree(opts, &child_env)))
+		goto done;
 
 	is_junk = 0;
 	FREE_AND_NULL(junk_work_tree);
-- 
gitgitgadget

