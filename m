Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF051F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbfJVXa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:30:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38237 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389690AbfJVXa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:30:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so8642193wrq.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h608hSauCK7oKBW/upG57Ua5/YTx4Qu01dxJWMRQvbs=;
        b=QUhBUpwVIKpnbx8kT7izMjd/ip4l5uNtZo3yDVzLMSTqPv44kK92ABiqhzxhPMpMhH
         lpREMrdwimoPqOJDhsweXs0Eb14PUKXpeMFb22CVMqgEu53s1XSjuxtkXRg29xe7XOLm
         fSDE7Rvx3Zr4ixhwP+1SAxJylgH2z7uko825LtAijK5Ah/x3/MJO/gN/maZQPBrLC2z/
         g//7Nbe8Nr4qKkoYficsZZyaiw7tvKFF0w1d33YWwLWIaypo96mOVf0buc1HYRDP/zkX
         BzH4SCpdmGkbiH23oIyEf3sGIunHGk62+KCBbIhI9/J6DRFX9zbbEL30kUtnVpyI81ky
         rLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h608hSauCK7oKBW/upG57Ua5/YTx4Qu01dxJWMRQvbs=;
        b=Eye5phMeKQNHXkZzM3HWUh2+7YZgVHdUHpwruIzI5qJP/kC3Nrx/YVjcRpe5AhVi6O
         X8fhkvFPf3MTGAixOCKKtlTEg5ThcSnMBYvqgFBsQma+Eq8Yj1JV0rSJ7XQDDUkzwLqY
         lzpPYpKemg9zMOCnkpAH41/4ucydxdRpSINfMi7A1keERnZJMLLQeC7kqFC1D3Dc+o1z
         +ot+Ztiw14JAl4x1zZ/Jeu1DW3MbBrSZIDFv7Bn/18dTaQlsDSNHESQJm60r/sNfOrig
         rJF1guH/ImH+KNGGAoUjRku6vNeBw7VbhnR2TwtTBppodcY1riqcCHUgZ+RvPxagDUCE
         Lkdg==
X-Gm-Message-State: APjAAAX5yuOpUBfr4xWZXfzOh+J30x1QHfD02gLZGtE5UWk0h/hcWqW0
        2bC8FYZbI/DiN2F58aaHjfasMaea
X-Google-Smtp-Source: APXvYqyP0jaH8/0UC4vKLY/8sHDIyhSYoHQmCsmrKafpjKEcHx6xSt310m8SLgmwb8buzq5z5BX3JA==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr5687354wrj.345.1571787024859;
        Tue, 22 Oct 2019 16:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm17260046wmc.16.2019.10.22.16.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 16:30:24 -0700 (PDT)
Message-Id: <43211b82bcc5b18c90106ee4f01e180cad35ac87.1571787022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.417.git.1571787022.gitgitgadget@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 23:30:21 +0000
Subject: [PATCH 2/3] sequencer: export the function to get the path of
 `.git/rebase-merge/`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The presence of this path will be used in the next commit to fix an
incorrect piece of advice in `git commit` when in the middle of a
rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 sequencer.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..5bd7e9d05a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -47,7 +47,7 @@ static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 static GIT_PATH_FUNC(git_path_abort_safety_file, "sequencer/abort-safety")
 
-static GIT_PATH_FUNC(rebase_path, "rebase-merge")
+GIT_PATH_FUNC(git_path_rebase_merge_dir, "rebase-merge")
 /*
  * The file containing rebase commands, comments, and empty lines.
  * This file is created by "git rebase -i" then edited by the user. As
@@ -218,7 +218,7 @@ static inline int is_rebase_i(const struct replay_opts *opts)
 static const char *get_dir(const struct replay_opts *opts)
 {
 	if (is_rebase_i(opts))
-		return rebase_path();
+		return git_path_rebase_merge_dir();
 	return git_path_seq_dir();
 }
 
diff --git a/sequencer.h b/sequencer.h
index 574260f621..505852d7d1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -9,6 +9,7 @@ struct repository;
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *git_path_rebase_merge_dir(void);
 const char *rebase_path_todo(void);
 const char *rebase_path_todo_backup(void);
 
-- 
gitgitgadget

