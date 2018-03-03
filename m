Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096501F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeCCLhM (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44555 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:11 -0500
Received: by mail-pg0-f68.google.com with SMTP id l4so4857902pgp.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNUSfwR9KDEuTeV7TZyxbxmPQKYeDxbgcdFNDQuHklc=;
        b=UaZLYzOqGdCbYNdjpcR669IBjv15LQHNrBH163pnsb+06pZX1JeWqe1LuWqrH+m1jN
         UWTw7DU6oiwUTOOdbbgcL6RMvL2/TkoLML7WvugYUgQnGw5IrOK7yWnlR18TInHfiv7Q
         yRiO/skAFxm69JOt9Z9GdKqKX9+GRw6br4tynOMJ/cUvckL2MfBkyt8xJdnCsGqhm4q2
         tYE1jIOaOjOEMOOGQ1NxVqq3CCcLsv3UfXE7vwKysdL9uIYOV5Kdwe840AWh4OfaEGkt
         JK5AyQkMOEXonnn0wIqOOqEzeaROXDQSrb1PCR65329QFmW6GQrpYWRV5RAm6nnT405K
         PxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNUSfwR9KDEuTeV7TZyxbxmPQKYeDxbgcdFNDQuHklc=;
        b=r73U+bDS2c8CATaLJlGsOLmHppbq3erKAPvge2U9bfZAqRf83p6+kwB849/iaBMqR+
         561d8YKxADQKThjk8yIcub+qrZznvMKMAcDqiizi8no8D/CX0/0wuUt+/5Wx95QmHWe8
         gysyO3anqB7JZwaWHIWdYSvgvxzrRBLe/kyPXqDtGPJLEPs0JizkknOHW8uj1pu8PuS+
         A6tHG6i1Lb+jcqNY9j3zM1DeEp5ZHT2wIi/7SB/AOjSYlTrEILOAJTkugBNmR/dFFw64
         Cm25Ev0fOQaAJ4JOjz91hhgi0/i9jBp0uobmr+yJQvi9PGXZNA/41RJPIS1Q0UzXDmaQ
         STPw==
X-Gm-Message-State: APf1xPDO/RbK7WQJZpSCFANQNoTXX+flywmKJnfFVgdEGrjlnK/b0HcI
        dNbiw4X1JtqleU8FxOjF/u+upg==
X-Google-Smtp-Source: AG47ELspIox5XRwazsaDDo3lNFfof1GA9R3l1wFSt4JoYhe2AcKM7m4sz7d8jfFabKGeQA1l5V1iPQ==
X-Received: by 10.101.75.70 with SMTP id k6mr7256700pgt.335.1520077030484;
        Sat, 03 Mar 2018 03:37:10 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l26sm17804045pfj.112.2018.03.03.03.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/44] repository: delete ignore_env member
Date:   Sat,  3 Mar 2018 18:35:58 +0700
Message-Id: <20180303113637.26518-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
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
 repository.c | 2 --
 repository.h | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/repository.c b/repository.c
index 04d85a2869..62f52f47fc 100644
--- a/repository.c
+++ b/repository.c
@@ -140,8 +140,6 @@ static int repo_init(struct repository *repo,
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
-	repo->ignore_env = 1;
-
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
 
diff --git a/repository.h b/repository.h
index 2bfbf762f3..e7127baffb 100644
--- a/repository.h
+++ b/repository.h
@@ -75,15 +75,6 @@ struct repository {
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

