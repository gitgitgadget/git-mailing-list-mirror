Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C85C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbeGRPyD (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42187 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbeGRPyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so2147665pgp.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=iGtEWL1AWOtbTeb9R4CE+qjtSLDX0Cl5AHZh4QPdkbc=;
        b=gWpnz9Xi0uGy7TrKytSUb7hQRtrvs/i0pyA/X1z7b4jSgwoicZjBL4ZGJamudjo4zn
         4vnSIPiAEkEh9t4GaMuYF8L8Yc2ZSmFC2CpQTAlGRcz4vBduVCQfQYchO4J5UEE2F4Uc
         Wmw1rqH/njzUmr9+uTsKYWRMZSIorFdwyIJ8kkbIel0X3y+JelbL25XGp9q8t6hGlNtN
         X3BI0ZgDqf7TKIRWIE1ggO6FhMQVJAaaUMBoBB/Yi6UN3x49gnlAISNjNV83qlrmZ7SF
         CLePxmmk2s9OyKdU5iLuT2mXHXRKs5Gd8ureKci/519D60fKObcg4LEoVQzOVx+5/ZxV
         bAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=iGtEWL1AWOtbTeb9R4CE+qjtSLDX0Cl5AHZh4QPdkbc=;
        b=VSmhTQnYy2Ik9h1I+b/SiN+U89ALC8Y/qXAht6Al3eKpWpEOTkcucdRLSpovPH2eTa
         PvL4REjD4BLxDE9DmsffzUabPW62Vte7NXVeDYoMdL8zhsOOrXx5WVQ/TfIk6fcfkTeZ
         gb/f0o0ss4+ua6+dnsGpxmt7bK0/YQky/JvfYH3TUmavIwfjFbZlVsejtRJGO1X6EjvR
         8ATHT0csZiTSqySKJos0OAoMGo+UIokyw3Rnwhj+PB/z9l46oI4fgn07CdTuqd45cwfQ
         xCEUOEaAfJEFMaobagj/dese5uv66bDnJt1F9aWNx+p4ids4JSJmmfve8F+FLL0xm34z
         SWKA==
X-Gm-Message-State: AOUpUlG3rFr5MV1XbQMFQgK7I4gYNbZRcNkYaqy1XpDVxWHvmlae9DMC
        PO3jYnVCxfSAFFwGXL3zOXBvDA==
X-Google-Smtp-Source: AAOMgpe/qH915KqVirqBEFScdKTqurgWSvx5wgswZyQR3/hN5hK67ITCc3LE8Conqjkjv9RjO3DYLQ==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr6037405pgb.95.1531926940991;
        Wed, 18 Jul 2018 08:15:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id m15-v6sm11120222pfj.171.2018.07.18.08.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:40 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:40 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:27 GMT
Message-Id: <88711a3cf4c045365a40504db94c34675f3bdc4e.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/8] test-repository: properly init repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-repository.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 2762ca656..6a84a53ef 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -15,7 +15,10 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 	struct commit *c;
 	struct commit_list *parent;
 
-	repo_init(&r, gitdir, worktree);
+	setup_git_env(gitdir);
+
+	if (repo_init(&r, gitdir, worktree))
+		die("Couldn't init repo");
 
 	c = lookup_commit(&r, commit_oid);
 
@@ -38,7 +41,10 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 	struct commit *c;
 	struct tree *tree;
 
-	repo_init(&r, gitdir, worktree);
+	setup_git_env(gitdir);
+
+	if (repo_init(&r, gitdir, worktree))
+		die("Couldn't init repo");
 
 	c = lookup_commit(&r, commit_oid);
 
-- 
gitgitgadget

