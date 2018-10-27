Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848771F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeJ0PEC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44793 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbeJ0PEA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id v6-v6so3084178ljc.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q44fqojAYNz+6DPA/rRvjhV67XDN4iG8omKcebGOyY0=;
        b=OnNgKJ7jIZjHj7IosGlOswZY/CNj75Se+VedrLktNBais9ZqlJdcxhXAExOqkGig8w
         W3/NLMm+x8gnEdyUZQRIuC1p8snPC0YsgdnWJMIjnbXZQ+I7kBOSiEpggAV/F2Xdc9+P
         w0Wty+Qw/2V1j21DgUM58O+27cnOjvwMllezwZvKq7FSX2N5PS/7ZTYlLLbDMx1Ih4E2
         0t+Yp5sUsku5KwYRjradSJPLGqX1db8t1OhMTmDDrSYgXawc5L0i9phev9N+m12Z8doB
         PvFk2tEybnDK5chLghO2X1+DqrO8S3j4W2bSmVE4XHSNu5XyB1sNEeFN59Itct3dCwOG
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q44fqojAYNz+6DPA/rRvjhV67XDN4iG8omKcebGOyY0=;
        b=pMtv9FVm2w/RQGKGJTBuaiTPROWaUoD79HImzK6aYJn5c7aZqYUn5JbS987W33GyLO
         q4YP+0/6SBXw1BcF0yUYEUM5v7sS0CJ+yAYqis5qSYm9wk97WCLRfXaMMJxGVlAS2MMV
         zlCYjHaVfCzOpjX207RS9D8PV1Ic+HzUZMZflHTmH4j+sbKcuRhh6nRwBB0AynCtj6yK
         ptJ7gvscpYTESpi7qS0EzKN6MgRX/MLhSVDKk/krK6QyZTro+Qs+sufUqo5hLMgAOvO4
         VD0JwRqU5Y45Wj5rnTLwnwiFw4M9ccEqq9oo0/H72sUfpHshEezsmjsFfQHCtwF4q59V
         Yg1w==
X-Gm-Message-State: AGRZ1gL0+jn09CINwwvX5z9WDIoCSVdyo85oPspfOLP3JA6MT1OW60tw
        YE3lxrZvnqEWcMof+WLYqk5Zm+7U
X-Google-Smtp-Source: AJdET5dWUiFpUdYMnmeFQyfqSgYA+X5m9uJfgLXPBLGVJEjwBpNPZBuHJftdtkSzZxxkUj4kqVmdng==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr3987559ljk.20.1540621445246;
        Fri, 26 Oct 2018 23:24:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/78] config.txt: move blame.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:41 +0200
Message-Id: <20181027062351.30446-9-pclouds@gmail.com>
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
 Documentation/config.txt       | 22 +---------------------
 Documentation/config/blame.txt | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/config/blame.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c8d20227a8..9ee989bc67 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -299,27 +299,7 @@ include::config/am.txt[]
 
 include::config/apply.txt[]
 
-blame.blankBoundary::
-	Show blank commit object name for boundary commits in
-	linkgit:git-blame[1]. This option defaults to false.
-
-blame.coloring::
-	This determines the coloring scheme to be applied to blame
-	output. It can be 'repeatedLines', 'highlightRecent',
-	or 'none' which is the default.
-
-blame.date::
-	Specifies the format used to output dates in linkgit:git-blame[1].
-	If unset the iso format is used. For supported values,
-	see the discussion of the `--date` option at linkgit:git-log[1].
-
-blame.showEmail::
-	Show the author email instead of author name in linkgit:git-blame[1].
-	This option defaults to false.
-
-blame.showRoot::
-	Do not treat root commits as boundaries in linkgit:git-blame[1].
-	This option defaults to false.
+include::config/blame.txt[]
 
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
new file mode 100644
index 0000000000..67b5c1d1e0
--- /dev/null
+++ b/Documentation/config/blame.txt
@@ -0,0 +1,21 @@
+blame.blankBoundary::
+	Show blank commit object name for boundary commits in
+	linkgit:git-blame[1]. This option defaults to false.
+
+blame.coloring::
+	This determines the coloring scheme to be applied to blame
+	output. It can be 'repeatedLines', 'highlightRecent',
+	or 'none' which is the default.
+
+blame.date::
+	Specifies the format used to output dates in linkgit:git-blame[1].
+	If unset the iso format is used. For supported values,
+	see the discussion of the `--date` option at linkgit:git-log[1].
+
+blame.showEmail::
+	Show the author email instead of author name in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.showRoot::
+	Do not treat root commits as boundaries in linkgit:git-blame[1].
+	This option defaults to false.
-- 
2.19.1.647.g708186aaf9

