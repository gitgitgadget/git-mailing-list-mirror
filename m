Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7640E1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJSW7e (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40351 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJSW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id t22-v6so25456188lfb.7
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z71lYxtfETFJn6Exe58pkZX4fqjUaV+EXNVDX3aliPg=;
        b=bkaZYICcOPAUjGXcvXDstoiAtBQojKn95ijo/EQ74hhgW1bx7VOZRA1Pvu9o3k7T/v
         SFA4QYz0WqUFD1HVlBBsyVSPAUkT3xQXqXKrG2NhLWCtLv3NsXk6w0lHLDmw/j+KjX0r
         1Pivm2BEE99AOaSVugeUyCxRulba1TGeomy7uB0dxDMBlpofby8Nk/XWFgIYmbChT/xB
         0/2YLcZy+O59tHsPiSo2QejReCuU8cKoPpinvj+dvvsq3oVj/4nQVseCzqI2Ap8tmmc0
         OtPQDocMaguk0hCv+VLGpaFjiDjWfK6IkFy20W8cMkZhyG1cw5i5/Clw9nHy/WH7aG7D
         61Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z71lYxtfETFJn6Exe58pkZX4fqjUaV+EXNVDX3aliPg=;
        b=Jx9AA1OrBWf+KBAjmK/oSYHbctoEzSe7RjO8V0B+CdkDHkV9tMjAn+91fR/hUSWQ2e
         pOEYdZKN3nRbJWjLO7f8bcnBz5qy1+sFygSI52QuWnwnLiFUDVT8LqxBwKDDdbN7UPSH
         xJK/wJxFfsaM9QibqaMrwaUuV6kYzqIOs4u1U0KeQmKsj5uDiF7nDpt7gj9Q3iiBWrFy
         GcFBgUkDQUsygrHgghtDp1N2M2bGgVe6vosMXe1lhLXdAJU2/x4HMAobmXMSZBvEbRkB
         LQG+NR7nR/6d4yOfmkJsQ6VdgEJgf5XZmqldmzwGXAunalrGwLtmz8/fUGBcgMiVdtmi
         2WsQ==
X-Gm-Message-State: ABuFfog6PrZCl1Xbj2a9jF4qlbh39qwILfTa31X5JqnlAkM6+PAk6y/t
        51uKFXCm3haYSWdP1A8zuZ4RH6W7
X-Google-Smtp-Source: ACcGV62JpdiG+JxRv5KDnPVMYjdNXt7nENIcB/6UVXyTGVtrV2inl9uhDdMQeQt0GFzdZu867VfUNw==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr1327520lfi.21.1539960784532;
        Fri, 19 Oct 2018 07:53:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:53:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/19] Flip NO_THE_REPOSITORY_COMPATIBILITY_MACROS
Date:   Fri, 19 Oct 2018 16:52:37 +0200
Message-Id: <20181019145237.16079-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to NO_THE_INDEX_COMPATIBILITY_MACROS, this switch is now off
by default. It remains here just to make it easier to merge in-flight
topics where the old functions are still used. Then you can just stick

    #define USE_THE_REPOSITORY_COMPATIBILITY_MACROS

at the beginning of those files.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h     | 2 +-
 rerere.h   | 2 +-
 revision.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.h b/diff.h
index ce5e8a8183..de7cb7018f 100644
--- a/diff.h
+++ b/diff.h
@@ -341,7 +341,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#ifdef USE_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
 #endif
 void repo_diff_setup(struct repository *, struct diff_options *);
diff --git a/rerere.h b/rerere.h
index 5ad8864b3c..8ddd0b20da 100644
--- a/rerere.h
+++ b/rerere.h
@@ -24,7 +24,7 @@ struct rerere_id {
 };
 
 int setup_rerere(struct string_list *, int);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#ifdef USE_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define rerere(flags) repo_rerere(the_repository, flags)
 #endif
 int repo_rerere(struct repository *, int);
diff --git a/revision.h b/revision.h
index bc30a3023e..5b6ab10143 100644
--- a/revision.h
+++ b/revision.h
@@ -271,7 +271,7 @@ struct setup_revision_opt {
 	unsigned revarg_opt;
 };
 
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#ifdef USE_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
 #endif
 void repo_init_revisions(struct repository *r,
-- 
2.19.1.647.g708186aaf9

