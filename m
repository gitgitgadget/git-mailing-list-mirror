Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0151F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeJ0PFE (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40926 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeJ0PFE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so2486546lfe.7
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7qzB9Qe3+OoqLfXuOgTQ/Mos6HK61X6WXjZ1mPKoUI=;
        b=dJa3uEpCxoo/pYItnDE4CsPQhLCRNj0iiildqmOAM5WFXmNt6XbgOSd+Tna3KOGUGQ
         817VaQJPnR7GsZVYGkwq+964vjui20fvVFEQk7M/FQVq60bqF73JNj9QiKODrgwUQ7zi
         yLpsUzd1YyVnkxV5eos3IO5UO4nFtRyfbrR1V6Rp65cxS+EjwZSNaaDKvuMWeSpnUGQc
         pkbyhInUm8YZLhx64co+UasMc8WWVBW3DLVROx7cy4EmHFr/+zLKQHURZspkeXh6b7pY
         16Kgw4B0bxOKIhCL3+Zbeh7/5HLgEZKUUFhbUsom92941YPtGtVmRLKrvp6bUU396tWD
         RQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7qzB9Qe3+OoqLfXuOgTQ/Mos6HK61X6WXjZ1mPKoUI=;
        b=aPoxsBQG31cQicMMw9R6bjuHozePR37BKMpZIQp7tNUdW0jC/B5kkYpD5YQh3E27nG
         mqX1NOY2esZkuBoWKL2RMZNtuYSthXHljmMliP/yYaVSiQ9LURrBNPzNtBUCrgneNWiR
         ap5qs6BMHMmxWsa4gBgCzZyq7os3MRiR+gvow6wBdVxtva/LYc0LJ0bnqIhf/xi/ai6e
         9oebtyvb+K+J16DDJ7+GVpiZ+eawK1rzWiEg2yh4cvThnJ1V4Z0Ys9CEHLfYGqU1nZm4
         yt+idNNRki+Yqw5UcZzZo8RkT3D1GZ7g4HAQdVxsXz0Ieb3Bug6qdujx/684NXm+WtA3
         qgCQ==
X-Gm-Message-State: AGRZ1gLeFodWSLbOCypo2thEl070MKawPQKbopORkKsjNCcj3kDvJUPu
        QwxqlPxvXeoOR/TrXg2tOygxdGBP
X-Google-Smtp-Source: AJdET5eItZeUE3uY6UFaFVIndvB2wNPdjvdMC3gU4znnKJihKfpcsqqqwr8IbbbdRcgBCFqVhirVvw==
X-Received: by 2002:a19:660a:: with SMTP id a10-v6mr2514970lfc.100.1540621508485;
        Fri, 26 Oct 2018 23:25:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 63/78] config.txt: move sequencer.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:36 +0200
Message-Id: <20181027062351.30446-64-pclouds@gmail.com>
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
 Documentation/config.txt           | 6 +-----
 Documentation/config/sequencer.txt | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/sequencer.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1c2a6ec3c5..ab504eaba2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -405,11 +405,7 @@ include::config/reset.txt[]
 
 include::config/sendemail.txt[]
 
-sequence.editor::
-	Text editor used by `git rebase -i` for editing the rebase instruction file.
-	The value is meant to be interpreted by the shell when it is used.
-	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
-	When not configured the default commit message editor is used instead.
+include::config/sequencer.txt[]
 
 showBranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
diff --git a/Documentation/config/sequencer.txt b/Documentation/config/sequencer.txt
new file mode 100644
index 0000000000..b48d532a96
--- /dev/null
+++ b/Documentation/config/sequencer.txt
@@ -0,0 +1,5 @@
+sequence.editor::
+	Text editor used by `git rebase -i` for editing the rebase instruction file.
+	The value is meant to be interpreted by the shell when it is used.
+	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
+	When not configured the default commit message editor is used instead.
-- 
2.19.1.647.g708186aaf9

