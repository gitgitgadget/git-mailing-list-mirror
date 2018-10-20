Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232CE1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbeJTUus (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36483 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeJTUur (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so33112145ljb.3
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwP33qgS9+KFHm8tvjuW0OoCe6/x/rZQqfGtXr7b/Wo=;
        b=YhdAWV0hBLt+awueilQwWTiop63W5MXYpdcdfUhE0y1MrD+LutqdZWDNjzDn+Yj79Y
         SnwgE5Z8pxucJ5Fo7gwYGNfc12vFBB5u9v5RHjhzT+oPyTTMCAa4rdoX9+zpYJE7+ueW
         vlFbMA1ZqPNORAsg63TSoRvivPpImg4WxfmD3nH90qKmWlJn7oUnaj30uGOOrmXPpKIx
         GQtw/j8o9fXLxPJn3zvSJ+T1j7SMRbEQSB4JS9gMW4sM6oCkYcxWrAvO3sVHB39GDwSO
         A/1cj/cOVY4zkSPI3CN+qszJUFhpNpIuUj6LFRrE62SB7d5uJ+Cw44tM2Ip3zvplMd/G
         7JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwP33qgS9+KFHm8tvjuW0OoCe6/x/rZQqfGtXr7b/Wo=;
        b=Ni1bEAoFbiM1jqdnfFEoBEtRtzwzyfbpP+Rf9I3xCBFtKTwTDLM1i9bYq8CSvUqcVK
         TS540lfe/1mzVDtjPSvbvRe9qWrRFwZTjw+orz4qhTa8B6EuRmqVGmGXjJhWCUlO300M
         Xik4aMMEV+nIsokRR7vx59Tz55YgDkwF3T/N0J3zu+MN/AAjEFVXu3LlHNiWO8zY8Enz
         b9aXUoFaUjFkE5r/tkJ98dTI9TzK8tk7fp3XsVOJtzfalLCkNS1avXHdGrARvOz3erg5
         IwirEG7M81xkwqMwImcowrKkiGPk1fkdqfYWwluEWOKtgnyvoUGZMIEPkfwlaBxQXxZr
         At9A==
X-Gm-Message-State: ABuFfogLMk95ObP66RJ6QVNwGeCxNKe5wTyXIsONA9AKCp0ZRFQvA5/s
        X4wuM86RxZlpo9ZzoWrF9bAXhN2a
X-Google-Smtp-Source: ACcGV60gE+rpK9u0ytUQ65n/rMKTptfIN/E2Y6i+1R8K0gcsYJyCGGCRfqK0WZa7AW/Xu+WIlWHFrw==
X-Received: by 2002:a2e:9615:: with SMTP id v21-v6mr25032407ljh.150.1540039224618;
        Sat, 20 Oct 2018 05:40:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 56/59] config.txt: move user.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:45 +0200
Message-Id: <20181020123848.2785-57-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 27 +--------------------------
 Documentation/user-config.txt | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/user-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9f38178220..3ccf88ea4c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -678,32 +678,7 @@ include::uploadpack-config.txt[]
 
 include::url-config.txt[]
 
-user.email::
-	Your email address to be recorded in any newly created commits.
-	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
-	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
-
-user.name::
-	Your full name to be recorded in any newly created commits.
-	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
-	environment variables.  See linkgit:git-commit-tree[1].
-
-user.useConfigOnly::
-	Instruct Git to avoid trying to guess defaults for `user.email`
-	and `user.name`, and instead retrieve the values only from the
-	configuration. For example, if you have multiple email addresses
-	and would like to use a different one for each repository, then
-	with this configuration option set to `true` in the global config
-	along with a name, Git will prompt you to set up an email before
-	making new commits in a newly cloned repository.
-	Defaults to `false`.
-
-user.signingKey::
-	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
-	key you want it to automatically when creating a signed tag or
-	commit, you can override the default selection with this variable.
-	This option is passed unchanged to gpg's --local-user parameter,
-	so you may specify a key using any method that gpg supports.
+include::user-config.txt[]
 
 versionsort.prereleaseSuffix (deprecated)::
 	Deprecated alias for `versionsort.suffix`.  Ignored if
diff --git a/Documentation/user-config.txt b/Documentation/user-config.txt
new file mode 100644
index 0000000000..b5b2ba1199
--- /dev/null
+++ b/Documentation/user-config.txt
@@ -0,0 +1,26 @@
+user.email::
+	Your email address to be recorded in any newly created commits.
+	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
+	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
+
+user.name::
+	Your full name to be recorded in any newly created commits.
+	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
+	environment variables.  See linkgit:git-commit-tree[1].
+
+user.useConfigOnly::
+	Instruct Git to avoid trying to guess defaults for `user.email`
+	and `user.name`, and instead retrieve the values only from the
+	configuration. For example, if you have multiple email addresses
+	and would like to use a different one for each repository, then
+	with this configuration option set to `true` in the global config
+	along with a name, Git will prompt you to set up an email before
+	making new commits in a newly cloned repository.
+	Defaults to `false`.
+
+user.signingKey::
+	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
+	key you want it to automatically when creating a signed tag or
+	commit, you can override the default selection with this variable.
+	This option is passed unchanged to gpg's --local-user parameter,
+	so you may specify a key using any method that gpg supports.
-- 
2.19.1.647.g708186aaf9

