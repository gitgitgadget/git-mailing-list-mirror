Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA626C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383188AbhLCVTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbhLCVTf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861EEC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso5832424wmr.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rooMQHv/GtYad0Sn9rHuPSMWvnhkO0/WC7D6rGtcQo8=;
        b=M/xhpBx3lEjEPDiZNKtsp6IpqOVcdIYzrNsY1KXOle4f8Zvbj7UsKynGVGrr49Pyyx
         k3WouJolxLSxMInfEVjArP+o9v5jFCoefPa81gVJPlveDMvdp3bbSQgr0SLHZDharlwa
         dW2nEiPNRDsYI+gutoocXFeDf8rYGJ5YDYUglwWwHU5e1SmWMP7k3QA2yH9UEi6K+dvG
         Pe64R5zVfOUVu13hXy+fY+iRhtCiH7Me7mMAthGy3OoOourPpa9DYdQO6BjRF7cRVHSa
         TwnpZ8PYEeVLtFVNkWjWdi3hyOqVy0tvyJsoxkjgYaqIRWZQRT6VdACa9RbdG0TTatRJ
         uMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rooMQHv/GtYad0Sn9rHuPSMWvnhkO0/WC7D6rGtcQo8=;
        b=KR1xIxiKUnme9dNuMSZntA/3LZWjVB1QS/OqScrEQWG/2k46nPu2RKWawDtPifClvn
         Sb5srdxcWLgUWq22ZG5Ccdi/VN3DouvP44cNL87w8i6nLjMCNS3aTGhZoctPBEbZgSUB
         4rCJrN7QY7t3wVamIYWi20wlDGa73XrUtUpF1/m92FrFP5zuKA6A2tXFa8oWa+nEXG/8
         TbNFmCNVpvrYIaeVzRXCG3qbESEEOXGJ8ko2YeA4O2tjGOKstB12NeEHT8jM0edai6uv
         4krRwJRRepFBoGbr5y5f/yMlb9DNuyApop9fYMpm9ofE+X2GQZE+AZoK3s+JKMV5v2+N
         hY7A==
X-Gm-Message-State: AOAM530aeafov9FabMCeLDkxKwpBAXXoS+ph6Qe9mvMUzzcvp26oPgbK
        U0QsggjLFfIKv8EKg8HVF+uhRg/usTw=
X-Google-Smtp-Source: ABdhPJw9secPtrYxT7jIdUUJwtxcTgUX8Ct/Lc8/b9f3f2WXJ+5ijYunH0mo3NiGjd1/2+WKphsVRA==
X-Received: by 2002:a1c:7910:: with SMTP id l16mr18259707wme.36.1638566168883;
        Fri, 03 Dec 2021 13:16:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm7104934wmq.18.2021.12.03.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:08 -0800 (PST)
Message-Id: <09c2ff9f89833b3ac918a399e10d1b6abe71b339.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:15:59 +0000
Subject: [PATCH v5 1/7] git: esnure correct git directory setup with -h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Ensure correct git directory setup when -h is passed with commands. This
specifically applies to repos with special help text configuration
variables and to commands run with -h outside a repository. This
will also protect against test failures in the upcoming change to BUG in
prepare_repo_settings if no git directory exists.

Note: this diff is better seen when ignoring whitespace changes.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 git.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/git.c b/git.c
index 60c2784be45..03a2dfa5174 100644
--- a/git.c
+++ b/git.c
@@ -421,27 +421,28 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	int status, help;
 	struct stat st;
 	const char *prefix;
-
+	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
 	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
-	if (!help) {
-		if (p->option & RUN_SETUP)
-			prefix = setup_git_directory();
-		else if (p->option & RUN_SETUP_GENTLY) {
-			int nongit_ok;
-			prefix = setup_git_directory_gently(&nongit_ok);
-		}
-		precompose_argv_prefix(argc, argv, NULL);
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
-		    !(p->option & DELAY_PAGER_CONFIG))
-			use_pager = check_pager_config(p->cmd);
-		if (use_pager == -1 && p->option & USE_PAGER)
-			use_pager = 1;
-
-		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
-		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
+	if (help && (run_setup & RUN_SETUP))
+		/* demote to GENTLY to allow 'git cmd -h' outside repo */
+		run_setup = RUN_SETUP_GENTLY;
+
+	if (run_setup & RUN_SETUP)
+		prefix = setup_git_directory();
+	else if (run_setup & RUN_SETUP_GENTLY) {
+		int nongit_ok;
+		prefix = setup_git_directory_gently(&nongit_ok);
 	}
+	precompose_argv_prefix(argc, argv, NULL);
+	if (use_pager == -1 && run_setup &&
+		!(p->option & DELAY_PAGER_CONFIG))
+		use_pager = check_pager_config(p->cmd);
+	if (use_pager == -1 && p->option & USE_PAGER)
+		use_pager = 1;
+	if (run_setup && startup_info->have_repository)
+		/* get_git_dir() may set up repo, avoid that */
+		trace_repo_setup(prefix);
 	commit_pager_choice();
 
 	if (!help && get_super_prefix()) {
-- 
gitgitgadget

