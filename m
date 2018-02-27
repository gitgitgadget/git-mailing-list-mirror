Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C501F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeB0J7h (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:59:37 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42147 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeB0J7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:59:17 -0500
Received: by mail-pf0-f193.google.com with SMTP id a16so1918424pfn.9
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZECkyKmiLBp22kWzAuqJfep/l2EHD9HHb8GBbgKpGE=;
        b=WitL0uaJ5xuBdGRJ+cO3KLpKqEl8k8FlEi2j8FwkUfDpTlRCvqm4h2n0iUZgNnVThd
         XYPG+wfa/d/EZ3KMlmTzfnhiux6ZggR3p7LH3y52TEEkE1um2+pfhoLdZcBVfnrlwMnE
         QR1RyNFh/mW/+pdA6qbHVKPaeI8LHbyOjpa1v0BlP4Uo2NPGTjNcgpSuXbBoxA9PrA96
         YhiQmBJ+ED3RZW+e1HfWSqWYuuy+BjX1NTcY4/o6Ei3eR7YXP7HTnX/VffrHwoyfpwPw
         Bo71vjYUKKsgqKnQIY/yYkcASi7WTf0xhy7GA4OYJ/hujcXPxnRbJAXbRN4je9lJTKG7
         +LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZECkyKmiLBp22kWzAuqJfep/l2EHD9HHb8GBbgKpGE=;
        b=T5lLZGnnu1Erkb35t1MUDvXzsJlzrpwG63rO1R5cVFbcWGEvymZcaTiF77Pd6Qt0jb
         juiYPB9G4sX5W1jURf+823Dtz20cR8xyjSppbOkMDDh0NU2iB7ezz0T8A/K2AWDVmK1c
         jP0khVV0g+Hq6SdgB0eg2KxE+nRWU4tWvNzQ6oYd5+HJFIt7JYr9ZzRSmhL+hL7ROdno
         Sbmwr8KU2Co3fx8bqeUEHqY1Qo9QOyoNGMtl6XKsPu6cGtZMKCin9PuJlp/R+H/0QlcU
         BoZ9vmJfdLAD0hFSUoLUcaLw044suXR3EvEt/Lllf6NGa7IWIcPBrAIPYMW4sMU97x+/
         B7/g==
X-Gm-Message-State: APf1xPCQnurhsSkizeRUDq1HtT+jS5UpYTm6QLoLrFJ1/Nv+qqlQHkSW
        pjnjfmO3LToT4bL4y1QE1BX1rg==
X-Google-Smtp-Source: AH8x224PQdOno8VPXhztrsMlf+OHfyjVu0p6lAmtOnake7Vyk8WBEH6UgHCuMCywO66s/gJUWWWzug==
X-Received: by 10.101.97.139 with SMTP id c11mr10652306pgv.439.1519725556919;
        Tue, 27 Feb 2018 01:59:16 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e22sm17445531pgn.50.2018.02.27.01.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 01:59:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:59:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 4/4] repository: delete ignore_env member
Date:   Tue, 27 Feb 2018 16:58:46 +0700
Message-Id: <20180227095846.9238-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was added because the repo_set_gitdir() was created to
cover both submodule and main repos, but these two are initialized a
bit differently so ignore_env == 0 means main repo, while ignore_env
!= 0 is submodules.

Since the difference part (env variables) has been moved out of
repo_set_gitdir(), this function works the same way for both repo
types and ignore_env is not needed anymore.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 4 +---
 repository.h | 9 ---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/repository.c b/repository.c
index e326f0fcbc..c555dacad2 100644
--- a/repository.c
+++ b/repository.c
@@ -12,7 +12,7 @@ static struct repository the_repo = {
 	NULL, NULL, NULL,
 	&the_index,
 	&hash_algos[GIT_HASH_SHA1],
-	0, 0
+	0
 };
 struct repository *the_repository = &the_repo;
 
@@ -139,8 +139,6 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
-	repo->ignore_env = 1;
-
 	INIT_LIST_HEAD(&repo->objects.packed_git_mru);
 
 	if (repo_init_gitdir(repo, gitdir))
diff --git a/repository.h b/repository.h
index b1da2a6384..07e8971428 100644
--- a/repository.h
+++ b/repository.h
@@ -73,15 +73,6 @@ struct repository {
 	const struct git_hash_algo *hash_algo;
 
 	/* Configurations */
-	/*
-	 * Bit used during initialization to indicate if repository state (like
-	 * the location of the 'objectdir') should be read from the
-	 * environment.  By default this bit will be set at the begining of
-	 * 'repo_init()' so that all repositories will ignore the environment.
-	 * The exception to this is 'the_repository', which doesn't go through
-	 * the normal 'repo_init()' process.
-	 */
-	unsigned ignore_env:1;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
-- 
2.16.1.435.g8f24da2e1a

