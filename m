Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56621F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJTUuZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36880 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbeJTUuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id 63-v6so33122822ljs.4
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvxCDWGJzdwbeWceojoJOblvuON0Xh3qFQMZTNh4Hhs=;
        b=nzqqp0zM4SrADh9DbJNNZQn2ZesTqBtaRYU6d9qOV1EdvdEsdRV3e1HVt9yPFvZHF9
         mtgyc7vCE6efwiXjplCqtTcZU2A5Aea5dO+syCuyK2wTtsafyrWvqdqi2QBfHG7+UtUj
         y+WuVVh+DDIsK9MDfS5YBpv8VianMFeuIU84wXnQysq3XAAN7A5pjSWuiU9/qakLvYYy
         FCoB5Se3iQh2hTohlpS8J+88I+PWkFgl5E6hBv7CPW4KD/GAHHCIwGJ7Z2XqzcwmPZKW
         DK+nfkDNVbCOykEHqI0wAjIMPueYTASYyYiUBpGj0JMic09ffwdcYX9lN7vQ06PWzjOH
         rNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvxCDWGJzdwbeWceojoJOblvuON0Xh3qFQMZTNh4Hhs=;
        b=jvktc4SA96MjCQd0B0/uQQ4sIuTdx7k0W4PA1w4LPNMlF75FTInKl6D5KGOxV/MgHw
         FLqEctLcbUhC6is05Dh9bX8oA4o49gabN4KZgyXjjKmayGfy3vPIOoFqK8iM6rf53+hN
         Nu9pFsVVaTQr08iYKz3t7hPVBdv3uP4t9+vbskqzm2yy4CBA1l3RY93akuLu15+xpjxw
         kntdWhEXvDEfphvqpXNLDUaYk5hA5h/ruLtGdXtEWB0CAONfwG3ATFZWgDMKT7QtSUax
         3xOGZv3Jc7N4RN5OdxhXT5/265k+o0v7LZCjEuVABHmW8uLTy2q2XyTMUB4FiIZWPpfz
         Dqvw==
X-Gm-Message-State: ABuFfojC210+wVtO7seO1ILC/STL3IvFRcrd9Z3VyvUlCF3mzLREID/Q
        UQ1NN25X95J8E/P4FMbLjU/BGgLy
X-Google-Smtp-Source: ACcGV60LzJ5sHNdFwCncA/IdJpUzqnEJG0wNXIDKdzKgx27fpoyF7n7Ksv+KpKAByJWr8jbaWuwIwg==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr27848062ljj.6.1540039202380;
        Sat, 20 Oct 2018 05:40:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 40/59] config.txt: move pager.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:29 +0200
Message-Id: <20181020123848.2785-41-pclouds@gmail.com>
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
 Documentation/config.txt       | 9 +--------
 Documentation/pager-config.txt | 8 ++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/pager-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 45b184b247..656ae3158c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -630,14 +630,7 @@ include::notes-config.txt[]
 
 include::pack-config.txt[]
 
-pager.<cmd>::
-	If the value is boolean, turns on or off pagination of the
-	output of a particular Git subcommand when writing to a tty.
-	Otherwise, turns on pagination for the subcommand using the
-	pager specified by the value of `pager.<cmd>`.  If `--paginate`
-	or `--no-pager` is specified on the command line, it takes
-	precedence over this option.  To disable pagination for all
-	commands, set `core.pager` or `GIT_PAGER` to `cat`.
+include::pager-config.txt[]
 
 pretty.<name>::
 	Alias for a --pretty= format string, as specified in
diff --git a/Documentation/pager-config.txt b/Documentation/pager-config.txt
new file mode 100644
index 0000000000..d3731cf66c
--- /dev/null
+++ b/Documentation/pager-config.txt
@@ -0,0 +1,8 @@
+pager.<cmd>::
+	If the value is boolean, turns on or off pagination of the
+	output of a particular Git subcommand when writing to a tty.
+	Otherwise, turns on pagination for the subcommand using the
+	pager specified by the value of `pager.<cmd>`.  If `--paginate`
+	or `--no-pager` is specified on the command line, it takes
+	precedence over this option.  To disable pagination for all
+	commands, set `core.pager` or `GIT_PAGER` to `cat`.
-- 
2.19.1.647.g708186aaf9

