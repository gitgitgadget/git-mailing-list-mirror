Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DDE1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeJ0PEk (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43538 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id u18so2473237lff.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlDUc7cpyPQeKearWM7oy1maTrqLd/fwlxi30wIgiLk=;
        b=NK0ISxlaAzZrHIZupUxRD9xsYrbre3B9RO0qJ0qIfs5oLOyrucZzpASo8RmEU0rqTT
         IhRrx0BWFtXKgKh/mPqAp7kwptFnBbpgpmMaU+qUzagTxDmuX6CiHFIdv9IDuuIEswMe
         5IJzVqjlx65pNkrkUqBT/s5i5I/1lRdetagECQrt3gi98e/cemaiyu1ZECQ+c5DmMR24
         ZQLNBzwrosNDOmWX8s5lb+yeMNrIu5H01mD/RvlqoYib3zoIexHos/liGMTETfRpjMoh
         kSOorrImCQ6Zl/UvTAYvMlp7kEqnohgg1rHAsTy0nIW+bzq81GVN3pD8vCeEcygpDKVD
         cx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlDUc7cpyPQeKearWM7oy1maTrqLd/fwlxi30wIgiLk=;
        b=o51ELgFva6kp0WPNK2vajihMzmXgwR6RcHID6pn6SGlBuEV9F5tvclYJj9YNAgYHNM
         G9b2H4GmUAlJ36dXhP60wgjbn+1MU3ATWc79yTtpKEGrMqbo0cQB1a5SrrNE/haSRnJC
         3Fp50C7KNVwZdIA41QVHJ5+IRxtoCUiWTLVEK5HXI/JDa7BkVvzy1yrNuCwdlEYnRO0v
         ioZ/IzVeLgdwgeD+C1Dkyk0hN0aZZYL1xiC9KR+7NF8obwpjoEYOH4VF01I/D2zIHBeR
         jSz5QUzZqXWSTTFvTWs8O1IWvFjYgQClMIm2OZz1jEI1rorb130UR2639H3sxW5oyBs+
         F9eA==
X-Gm-Message-State: AGRZ1gIz49OYkSUGi+mT3uz4aLJjqZDzCxA2OPzAoGMx8ytZYQ7sMcZb
        z3PwBTk3WOlpyUBKq2ELtuGLLuAV
X-Google-Smtp-Source: AJdET5eYidAFmKiDrClRj1wonFouhsEVgr94TMru+7J5ejIHzq995rRmX4iOaaDYjXHQSvUZ4l0tpw==
X-Received: by 2002:a19:db82:: with SMTP id t2mr3158576lfi.130.1540621484624;
        Fri, 26 Oct 2018 23:24:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 41/78] config.txt: move interactive.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:14 +0200
Message-Id: <20181027062351.30446-42-pclouds@gmail.com>
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
 Documentation/config.txt             | 17 +----------------
 Documentation/config/interactive.txt | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/config/interactive.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5b6e2971e3..763bb291e5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -361,22 +361,7 @@ include::config/init.txt[]
 
 include::config/instaweb.txt[]
 
-interactive.singleKey::
-	In interactive commands, allow the user to provide one-letter
-	input with a single key (i.e., without hitting enter).
-	Currently this is used by the `--patch` mode of
-	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
-	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
-	setting is silently ignored if portable keystroke input
-	is not available; requires the Perl module Term::ReadKey.
-
-interactive.diffFilter::
-	When an interactive command (such as `git add --patch`) shows
-	a colorized diff, git will pipe the diff through the shell
-	command defined by this configuration variable. The command may
-	mark up the diff further for human consumption, provided that it
-	retains a one-to-one correspondence with the lines in the
-	original diff. Defaults to disabled (no filtering).
+include::config/interactive.txt[]
 
 log.abbrevCommit::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
new file mode 100644
index 0000000000..ad846dd7c9
--- /dev/null
+++ b/Documentation/config/interactive.txt
@@ -0,0 +1,16 @@
+interactive.singleKey::
+	In interactive commands, allow the user to provide one-letter
+	input with a single key (i.e., without hitting enter).
+	Currently this is used by the `--patch` mode of
+	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
+	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
+	setting is silently ignored if portable keystroke input
+	is not available; requires the Perl module Term::ReadKey.
+
+interactive.diffFilter::
+	When an interactive command (such as `git add --patch`) shows
+	a colorized diff, git will pipe the diff through the shell
+	command defined by this configuration variable. The command may
+	mark up the diff further for human consumption, provided that it
+	retains a one-to-one correspondence with the lines in the
+	original diff. Defaults to disabled (no filtering).
-- 
2.19.1.647.g708186aaf9

