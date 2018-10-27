Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612871F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJ0PFW (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0PFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id g8-v6so216036ljk.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcishBF8a9yHD47CQHMlC/J2C2pUhMsDERVeLnlW7O8=;
        b=OU2n9dz7iXyGhpJ1CcmcZaSpik+LYDi++MDRwyiy1F7xdR2FYGUJw8ANcbs7bu1Jzg
         aYmB7zveVrJfKeHCQZiHr0fFCGx+3AZDtv4HtgLF5HUkPh8PdVZo/PT7TOlvPZEN6abl
         6Ibt3QMeVLwGX3+1tPmpF9MaQtKvHZPgTcvwrzBx/TIEMcuIHY34kDepExToNtRIGJ9e
         WNk9TIv0yxiE09BrECNaZ8MHi0zaWr80D8oKSJkSWaGKxCkxbmT35F8JXsTdOteZJ+nQ
         /JGrr/QUBqSZ4wnltogHHgBvUHG+cUfag3luNQ7Zb7WJtP8goC+luNINSIG0RfTNFTh9
         h6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcishBF8a9yHD47CQHMlC/J2C2pUhMsDERVeLnlW7O8=;
        b=SRNR6h6n5vBHRCcyu0XoSPibCk45STSC1B86WHs35Bzxja2f8EyTWvPGFNdO4bH4wu
         anWSxAZ2ATZqdbAiAfRPNlIbEhLcLRNUlRsBbOufpPvHNAMYtZXogzHCVjiHDIUG5mzz
         R0/XIDbSMPYYi2EE7M1fCOUnTSrFpCXJY5iooNPDNrNxhvogZ1SK3RyPdJ1y70A3S6sW
         YmpTvKNtqSr2NR+1+4VjbgeBuBUrmPgprTZNKlnFQnfeDLBilmgdGH40kgO6uHP6/3TC
         Ijqn5O8jbXeGaMJwmuUdfHR8KTeyjorgg9VTyzVg6gVZRmzbDk3cmCB1u9dIzu3CS9W1
         1RlA==
X-Gm-Message-State: AGRZ1gKgZzFYA/S4Zb86rQulEd71wb9lsCpAJE2VXTMKz/QBtnDl8xJt
        JWn9HqJXTP9PVlxA6F7BhZO/bl0o
X-Google-Smtp-Source: AJdET5dCPDlWnzFhU9x1bgxHxDD6WMfIE+XGDl474m5eURcCn6W5HG99vdBgjN2Iax9SZ6bBfHf4IA==
X-Received: by 2002:a2e:8e95:: with SMTP id z21-v6mr2968020ljk.166.1540621524450;
        Fri, 26 Oct 2018 23:25:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 77/78] config.txt: move worktree.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:50 +0200
Message-Id: <20181027062351.30446-78-pclouds@gmail.com>
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
 Documentation/config.txt          | 10 +---------
 Documentation/config/worktree.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/worktree.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 10617d0a10..75b8f6964d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -435,12 +435,4 @@ include::config/versionsort.txt[]
 
 include::config/web.txt[]
 
-worktree.guessRemote::
-	With `add`, if no branch argument, and neither of `-b` nor
-	`-B` nor `--detach` are given, the command defaults to
-	creating a new branch from HEAD.  If `worktree.guessRemote` is
-	set to true, `worktree add` tries to find a remote-tracking
-	branch whose name uniquely matches the new branch name.  If
-	such a branch exists, it is checked out and set as "upstream"
-	for the new branch.  If no such match can be found, it falls
-	back to creating a new branch from the current HEAD.
+include::config/worktree.txt[]
diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.txt
new file mode 100644
index 0000000000..b853798fc2
--- /dev/null
+++ b/Documentation/config/worktree.txt
@@ -0,0 +1,9 @@
+worktree.guessRemote::
+	With `add`, if no branch argument, and neither of `-b` nor
+	`-B` nor `--detach` are given, the command defaults to
+	creating a new branch from HEAD.  If `worktree.guessRemote` is
+	set to true, `worktree add` tries to find a remote-tracking
+	branch whose name uniquely matches the new branch name.  If
+	such a branch exists, it is checked out and set as "upstream"
+	for the new branch.  If no such match can be found, it falls
+	back to creating a new branch from the current HEAD.
-- 
2.19.1.647.g708186aaf9

