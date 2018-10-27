Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F1D1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeJ0PFU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33364 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeJ0PFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so3127271ljz.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ku5INiq7mpouNdsuvGeqmn1fip7RX8D3UYR870IQ8z4=;
        b=Uhl+uDt1rTRelmMTdmcYuRhRICn0+RplnJQNnxGOXlFIftEF0/ZV6toj3vVtHkpkbS
         SbepQ6YxqfDNqGwk5nSMeW34M4zv+2qseH4aWHbclIQAgv8/XHrGOs3AkoWHqnL8hor0
         48Pmx16KdMgefC+KAyzxX6TNMzPd3g/QQZ47IE+NOPm1YwSe+OFZNAabnX2HDkMi/yaq
         xFOuA85VAeJMWqJaIG2zz+AEz0DEUeWCrHyq++H4CBOXP4PlkeZjR4f1SQBWTJ/j+9gF
         6UGjpNdYvFHKVG8TEhRAXp4M2YW/DlYZyD74Ssbc0WxLMJcMOzreQAZWhwkCbM4KE9vF
         Iuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ku5INiq7mpouNdsuvGeqmn1fip7RX8D3UYR870IQ8z4=;
        b=skPrmdFiaqBdQ5q/nwP8KDLYBOJub1/9eosKa0qe5tprRapiEsXu/q044yTCqTE20+
         pqc9EBXq+AydzQzbEu4aSD0joE9ePh8djul/fNHdL3EWoV5kCHrUzNPIGHATqVm2Y6ek
         pqrQEzpqJGs1qQD8S4N1+oJL2dN8TzUG3/eUxxNM3TvGQ4n+3dLTcziruf89EyzjZyrR
         HdHKBxHL+2fytEJHVy4iPhNbZYuGMyAGfXoh0niKb5jd1Fwt45dYZ7vIBS66267YISYY
         ahVIwE4Le1cz8V5YqJucfvjQWm0ixsptDKv7OznJyiBWHNsn6wh3CFe/hUNLS3PskQmt
         QSmg==
X-Gm-Message-State: AGRZ1gLSjNEha83iE2MNNha4ys2VmqCqvBmAr6RACg2Ca0ahgMyXanWY
        3aNUDYJ7KjzABTpj8nY2WGyo0fEc
X-Google-Smtp-Source: AJdET5dES0ejVkQ6zHcsIMTmA8H+MjONGqAzAvl2gFcf+342KHrH7rIt4vH/3TTcQLIDKU1R2zz7fw==
X-Received: by 2002:a2e:3e0b:: with SMTP id l11-v6mr4588116lja.16.1540621521254;
        Fri, 26 Oct 2018 23:25:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 74/78] config.txt: move user.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:47 +0200
Message-Id: <20181027062351.30446-75-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
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
 Documentation/config/user.txt | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/config/user.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 924776f7fa..3cba2420e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -429,32 +429,7 @@ include::config/uploadpack.txt[]
 
 include::config/url.txt[]
 
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
+include::config/user.txt[]
 
 versionsort.prereleaseSuffix (deprecated)::
 	Deprecated alias for `versionsort.suffix`.  Ignored if
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
new file mode 100644
index 0000000000..b5b2ba1199
--- /dev/null
+++ b/Documentation/config/user.txt
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

