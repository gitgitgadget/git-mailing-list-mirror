Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4C71F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJXEWL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:22:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36891 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXEWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:22:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh10-v6so1133122plb.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NlVaPR/gHGRi69754meAVf2ZFOt/Rpb/mVfzHHadN7Q=;
        b=qofjrrKCYcdcfBe5lAXbtwPUybjVV9bGCbGam9HVVxg9MeuPnZP+eL+6aA3Y03s14M
         aUAQ9paJhJFpQlJNtapyCS6Ii/SNweOI1E37DzAd8YYWc1SrrioLYuahTz2TMIPj2WHo
         b6R/23jO5vncqZ6jEpK26ZRGhthaKchxx6HS/eiEWtYEJdy0iySHfvm1I1Wau5+QlRIb
         eYu8KCKBlPWBP1XuLgwk6iIMGoWs4GW1t6ZO9Po4LFCNaa5fzYqWDkA1uPdIoepnYAsl
         La4at195WbjLZPM7Ck9yNofMdUAhbloA3gBdWET5HEWkqquM08cWgR5q2S8L/9bjh6PA
         y/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NlVaPR/gHGRi69754meAVf2ZFOt/Rpb/mVfzHHadN7Q=;
        b=F4TwUF4j1XvQGNt9RETgEhq3+m0IXK/LViK/zkyjToICjRxRscPG4YoJQBftjYyv5A
         M26zWBixPnIiW8JQwMvKu519d2vpXm3lZof+3dwzY5erWTBu2OWLCk/t+R71zHbCjBf4
         QOhqJckU0uveV5qrtkLap28sswNruxS4etHhiu0r47UqwjaTE5OSAPLv5ZaC01QC3qbe
         7dBQT9vap02x3KpwskbUZbDnQVE3guDCLRr4PuKWopvS5LvwkDRU3bcddIyfvB2+Bh44
         8Stw/gdfOfktRtmGebxzFKkBYV/O3HjtDG/A+G2KD9Yi/1xMlOQCVKJpfj5yHseRdgJt
         QFug==
X-Gm-Message-State: ABuFfoh6AXy/WwVj8GhY3GfcWn+ikncb0P3wDC91AZQd8B8tPAiCqrOL
        RMMcr8pUT2ondHOe2bl8uySSUdA+
X-Google-Smtp-Source: ACcGV63Xx+IL8uZdMdKQB02Va1EePUQ7xll9c0kEvWtP2/2rVvcJ7RhajienSk9vkL6wJZy06Zt7Cw==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr50632064plt.268.1540324638629;
        Tue, 23 Oct 2018 12:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k24-v6sm2582103pfi.11.2018.10.23.12.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:57:17 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:57:17 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 19:57:12 GMT
Message-Id: <ee4b715284c95698fd1b68dc4b1a2d38056df56b.1540324633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.56.git.gitgitgadget@gmail.com>
References: <pull.56.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] rebase --autostash: fix issue with dirty submodules
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

Since we cannot stash dirty submodules, there is no use in requiring
them to be clean (or stash them when they are not).

This brings the built-in rebase in line with the previous, scripted
version, which also did not care about dirty submodules (but it was
admittedly not very easy to figure that out).

This fixes https://github.com/git-for-windows/git/issues/1820

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c            | 2 +-
 t/t3420-rebase-autostash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 09f55bfb9..1dd24301f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1349,7 +1349,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			update_index_if_able(&the_index, &lock_file);
 		rollback_lock_file(&lock_file);
 
-		if (has_unstaged_changes(0) || has_uncommitted_changes(0)) {
+		if (has_unstaged_changes(1) || has_uncommitted_changes(1)) {
 			const char *autostash =
 				state_dir_path("autostash", &options);
 			struct child_process stash = CHILD_PROCESS_INIT;
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 7eb9f9041..f355c6825 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -351,7 +351,7 @@ test_expect_success 'autostash is saved on editor failure with conflict' '
 	test_cmp expected file0
 '
 
-test_expect_failure 'autostash with dirty submodules' '
+test_expect_success 'autostash with dirty submodules' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b with-submodule &&
 	git submodule add ./ sub &&
-- 
gitgitgadget
