Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDAA1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeJTUuJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40867 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so33087113ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aujn6cxwuo2c7cWTYiHNOiOlGt9ne6ZLph8m3K+LJXg=;
        b=gKKdBBvh304dCy7Qgn+zO2Q05ZmJUD+RdSU9/K81lhQGPJhGIZE++KNuV48s+yN4ZA
         O4oPMja2vTze/LFMm0iQ+tbg8JkiQdskp5i8nbu99U0p2ntOk9IbEIx1LeF9nYS1Zcxa
         Z2ELgCkVkcewsKlzJUeAfHskTYoevdRbcHLQHSPMBYBfpO6zZRzyqYP/+6sqZHyrTGp4
         2soRZyfLQ75YsbQEPnyy9sTWvd5hPhzsCt73wu5syPi4O1DrpKfwOtj0vKEDJMBdmQGP
         yw66ZWTbTInd2O5JbE/7vx+zRhMp7DYHReQpBjGVfvm6Kli9Ih4JmH+TAAK/LxcZgK9j
         7jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aujn6cxwuo2c7cWTYiHNOiOlGt9ne6ZLph8m3K+LJXg=;
        b=k/d85PoVQohRSSdTrSWTGWym+ska8QVExmz5XAn8+S8xLpJu/5pcs4Fmar+24DH6D9
         x1L0cF1PgMB7D0CjgyD2IVf+eCBE9snJYT1QYjFS5QvXC0sc2ywaTGV0PihGH7+euamC
         N+pctnElvml+v7cLjwBbyNMlCJUZwGdmZ8pSgvXIKI5XGQ8B//2AUrbvWnPxNIThOUx9
         3QkDnN2w41oT5Ag5jve1z30Ygw/Jw465iTDP0g0LHmqsMXx8+q01mR4qtaUjPKV5jio5
         /c/9sdxUptB+5UmTok9PA1luod+8F/dsvaNfedmPhJ6fJUm0slW12+siZBZw6/lopnHo
         FyuA==
X-Gm-Message-State: ABuFfoirHHnqr9fex9Re0Nzhx1YQ5vbFlGUhpTeL31sovbD6lq8XrTxl
        8I3xP/suaWSw52VNqazgxh6MpWZ9
X-Google-Smtp-Source: ACcGV61WVFQk+K/ZkxELge2sVHh6GcXnqmP7UpJdvGTittkYL7MFoyUN32gtxyA2KbYrRml7cdVttA==
X-Received: by 2002:a2e:505b:: with SMTP id v27-v6mr24571223ljd.126.1540039187479;
        Sat, 20 Oct 2018 05:39:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 32/59] config.txt: move interactive.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:21 +0200
Message-Id: <20181020123848.2785-33-pclouds@gmail.com>
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
 Documentation/config.txt             | 17 +----------------
 Documentation/interactive-config.txt | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/interactive-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d60aead5d..03d91ef5b9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -612,22 +612,7 @@ include::init-config.txt[]
 
 include::instaweb-config.txt[]
 
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
+include::interactive-config.txt[]
 
 log.abbrevCommit::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
diff --git a/Documentation/interactive-config.txt b/Documentation/interactive-config.txt
new file mode 100644
index 0000000000..ad846dd7c9
--- /dev/null
+++ b/Documentation/interactive-config.txt
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

