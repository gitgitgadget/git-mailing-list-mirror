Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363621F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJTUuL (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41613 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeJTUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so33075716lja.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brSJtUxYf+GNi2fl4K640sRD3ftbFk91wisdXkaSeJo=;
        b=HdB7hMjrBX+hnk3e5kwNJSAlykJiFfkS7AHZSQgUZ3X1JrzBEqY/ArC77HmQwkPm+s
         aWayv9qKDYpy7Kw7XABZa1k08qY2Uc6RaggQIuq8RgcM/YggyXW2Zcyj6J6TWpvNmhEC
         eDhAdp6KF5B/0oxD7RsAsfcD3wvoG8kcaZ3SGT9X4It9qnXq5ZvaDjbjA0BTnVrT1q4r
         j3JdugRDm0KJVyQh7hNv1p6B50VEYICDeLrFLqDORY9CA5Mqwuuh+dIjIMeXpEznmMUv
         4dIkI1+7d2Q7h+IXpYhBE1GgQ2iVIdSSPlLzSdFk71x4Os/BsqAHYLls9CRS8ZgYXK5F
         ktmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brSJtUxYf+GNi2fl4K640sRD3ftbFk91wisdXkaSeJo=;
        b=hONsGsOVFFxFS3xj0xUmmaOVq9peLO/hnOyoS0SjtVaH27Hz2oHjuurSPGrmWueGTX
         4ZqGarcLUO+6PptimMjw5QhmsuiAjQGCbXfEBFgWlQX4V0P3gr1q5AVR5CNaiba0xZlW
         XBow7Fov7aLbv3CIPXVFssEb+U37RID4FMQDkei+X3euxNQvVPyugWKUwYjFdrqe7YpI
         cA9XL5K3Zp25scJMusyq3nkQhcR9CMWrMVHDYMA9R/yfR49BVwST6OtULOzj54obUdGR
         g+pMQ0lWFnOnE64i2rUxwHuiZHfvWQBg1XMfehHWY4yZ39qnhu7nINaLJm9Nwv7tv/if
         A17Q==
X-Gm-Message-State: ABuFfog3sPkZ7gqZulY2wO5BLntKsTPmKOXUW2IW3jveGxrsTh35Rpw+
        bdN0tAgFQKOfFwauPwAFxCvV2llP
X-Google-Smtp-Source: ACcGV616iFESTLy7hfGeZmpK/4PhDsFF6vx+qCAECQa8LJEj3lmhUNgQ7iCB2vV9ZfoHRTxBHId8MQ==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr27128891ljh.0.1540039188739;
        Sat, 20 Oct 2018 05:39:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 33/59] config.txt: move log.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:22 +0200
Message-Id: <20181020123848.2785-34-pclouds@gmail.com>
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
 Documentation/config.txt     | 44 +-----------------------------------
 Documentation/log-config.txt | 43 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/log-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 03d91ef5b9..8d9423beca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -614,49 +614,7 @@ include::instaweb-config.txt[]
 
 include::interactive-config.txt[]
 
-log.abbrevCommit::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
-	override this option with `--no-abbrev-commit`.
-
-log.date::
-	Set the default date-time mode for the 'log' command.
-	Setting a value for log.date is similar to using 'git log''s
-	`--date` option.  See linkgit:git-log[1] for details.
-
-log.decorate::
-	Print out the ref names of any commits that are shown by the log
-	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
-	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
-	specified, the full ref name (including prefix) will be printed.
-	If 'auto' is specified, then if the output is going to a terminal,
-	the ref names are shown as if 'short' were given, otherwise no ref
-	names are shown. This is the same as the `--decorate` option
-	of the `git log`.
-
-log.follow::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
-
-log.graphColors::
-	A list of colors, separated by commas, that can be used to draw
-	history lines in `git log --graph`.
-
-log.showRoot::
-	If true, the initial commit will be shown as a big creation event.
-	This is equivalent to a diff against an empty tree.
-	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
-	normally hide the root commit will now show it. True by default.
-
-log.showSignature::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--show-signature`.
-
-log.mailmap::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+include::log-config.txt[]
 
 mailinfo.scissors::
 	If true, makes linkgit:git-mailinfo[1] (and therefore
diff --git a/Documentation/log-config.txt b/Documentation/log-config.txt
new file mode 100644
index 0000000000..78d9e4453a
--- /dev/null
+++ b/Documentation/log-config.txt
@@ -0,0 +1,43 @@
+log.abbrevCommit::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
+	override this option with `--no-abbrev-commit`.
+
+log.date::
+	Set the default date-time mode for the 'log' command.
+	Setting a value for log.date is similar to using 'git log''s
+	`--date` option.  See linkgit:git-log[1] for details.
+
+log.decorate::
+	Print out the ref names of any commits that are shown by the log
+	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
+	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
+	specified, the full ref name (including prefix) will be printed.
+	If 'auto' is specified, then if the output is going to a terminal,
+	the ref names are shown as if 'short' were given, otherwise no ref
+	names are shown. This is the same as the `--decorate` option
+	of the `git log`.
+
+log.follow::
+	If `true`, `git log` will act as if the `--follow` option was used when
+	a single <path> is given.  This has the same limitations as `--follow`,
+	i.e. it cannot be used to follow multiple files and does not work well
+	on non-linear history.
+
+log.graphColors::
+	A list of colors, separated by commas, that can be used to draw
+	history lines in `git log --graph`.
+
+log.showRoot::
+	If true, the initial commit will be shown as a big creation event.
+	This is equivalent to a diff against an empty tree.
+	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
+	normally hide the root commit will now show it. True by default.
+
+log.showSignature::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--show-signature`.
+
+log.mailmap::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--use-mailmap`.
-- 
2.19.1.647.g708186aaf9

