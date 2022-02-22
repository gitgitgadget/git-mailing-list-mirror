Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3127C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiBVASg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiBVASb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443D25593
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso467255wmb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEwQOKVfS1z3z4RURBKjrMl0ojCq6mcDnKEPehPFfRg=;
        b=L63cAZC7OkPKPWWqh6GKWFhuNG+im/kQ1N/dg6Yn3ipCFm5uGnt1V6ipe+qLyJ9Aq/
         lhGj1Iok5A03iYYrG5cw4IFxP+rByt1YaNuqKv4AevzdbbDqOn43iEKBZnDfBED3ex2E
         p1xbUOutXRlAWZLLE2ABjrS+6c+fbpAppPOKQmCTPrEAckI5khnb8gNRgJBiPtG979ZV
         og5jjmlzQETixAhRzyyM+u54lcHu/eEvMV34Q8YvMI/0V/qkah6qzQMnns46CzNluFnH
         BelJ8Tk57cPCpUXUigh8Tzx/DQDvfukVW4/CD6OQaTL0bGZDp4nbL9Lvp696pnn86YS0
         nlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEwQOKVfS1z3z4RURBKjrMl0ojCq6mcDnKEPehPFfRg=;
        b=ZQ49CKNCJHiRlRuD6/OxOO+yFKi9Fpi9vGKHEejA3VVONJI6qMgPb6qBwOCitoIDCH
         V/YZWNvlQlW5DoL9IFUfWLuQJPOXcojGBGUcJX01jNQSneIYK3CO6XEf6lIavEAEqu9e
         uP2LmkTa30h2ZfTLi/OAYmDkF6Hlcouj01e/WdpEjlIvuv4muctp31JIRniMJySs+Urw
         oH6Pr7C/1BY6t6Lu2u3yglYvSmyNXl47773MGLcJL5gHq6ZN3ceH6cV1htU5tpBtbXzx
         cJVxR19Xzfw8if6UoXrUNwvzEaSauvIzJGX4jrNQ6KngxoQaK1eHqIUOToiAO2OMAfN+
         Nb7A==
X-Gm-Message-State: AOAM533Cdonp8aKYX2MN2fucO0hfuvWe7fh2JbAjIGBGOqTrxJIjNCts
        zlgQOS9vu1CV7efY2NfUtuGwEYZo8LI=
X-Google-Smtp-Source: ABdhPJwclWutvMOPO8h8Hw8w61qE898elkFheBhPLhrb/Yv37Fog28ocvfXToQMKiXcjtAC9V8Q1yA==
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr1125575wmk.109.1645489085260;
        Mon, 21 Feb 2022 16:18:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm15382739wre.110.2022.02.21.16.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:04 -0800 (PST)
Message-Id: <1e62e4e4fa1a543ad134d70d97740cac5826e587.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:53 +0000
Subject: [PATCH v2 04/11] worktree: extract checkout_worktree()
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

