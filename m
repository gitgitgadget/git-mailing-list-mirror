Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3C11F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeJ0PEP (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36395 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJ0PEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id h192so2498095lfg.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWkQSUbUt1/V5113AZR5PdzUkcgExMPSBm9rDJvAX7g=;
        b=fcu9LHU6SbeLabJ4W4nKcpGwBhmqoSN9MZtHU+aCFE5NDmHKoZ+uJsZ2/94JbVxPZp
         kPYavWi5W4zC6Mq/WN5ArT4WEbKIPbdkuD92xiSo39wviNSM7OD0hFqDwbiuIpaU1k7N
         C3dPxVRmW79DFW+GyWdEmAc/invt5rsetOuIdGkB4Zflyqv6JA7j7zI8STWTmJjkQ9/E
         +Bs43osDHCgi7Wcp8ZJ1jTzFqkcxdMFjrBCmJuWa/5KxKD3kpIieBqOI9Jfl/bTebhCr
         PtbZW/xTDQVjaUEGMzawLnvCgWP7lgFuoeWnCERMParDhrolzvn+hhrK4yrm9NWe/Qp8
         fj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWkQSUbUt1/V5113AZR5PdzUkcgExMPSBm9rDJvAX7g=;
        b=QKJbpafwC92zLHHzy3FTLUS1eX7s4nfAZf9R3KvirgG+a6GGRyew5rFTUCYU7pNAZA
         /ajG5hUhncm/IIaSstatOSkzE3aKrSh082DvKnyQjkXoyxSbJFUabGRKDrnBr6Hu+a5b
         FJ+ZtGdULz2NC97Ng0z4WAhQLs/6oudfOhtDmkb+nTioBalMVztTFV1mI9VBxlmDjTHf
         tSyuN1JoUyUJB6gyvH6/lXbLs1nG+lOvrMzwi9XH7a9Mv5KbhlFg6zMTfWYmmOdl/kDH
         H7dXJlvGPkkBciqVVs5iimQNUUcxMZmgrQhu8ON07PI5Z8BLQyPm4qkPiTRz0FFNKBIo
         +t3g==
X-Gm-Message-State: AGRZ1gLr4VDhXPYGA9I6YfxPWqn9+CiQ47FeOo3g4b5GJa4XrI0JVh1m
        XYTxSJtVUsftd28hKw4G1kBSx3lR
X-Google-Smtp-Source: AJdET5fknAW2vyfOQz6rzIq9QLVOaw5TdkIieEbcd2gRLcfkty9CMn5Rmk9CNGz+Hc+oreVc5si3nA==
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr4026504lfc.147.1540621457487;
        Fri, 26 Oct 2018 23:24:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/78] config.txt: move completion.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:50 +0200
Message-Id: <20181027062351.30446-18-pclouds@gmail.com>
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
 Documentation/config.txt            | 8 +-------
 Documentation/config/completion.txt | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/config/completion.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2c21a5f366..83f5ce9056 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -317,13 +317,7 @@ include::config/commit.txt[]
 
 include::config/credential.txt[]
 
-completion.commands::
-	This is only used by git-completion.bash to add or remove
-	commands from the list of completed commands. Normally only
-	porcelain commands and a few select others are completed. You
-	can add more commands, separated by space, in this
-	variable. Prefixing the command with '-' will remove it from
-	the existing list.
+include::config/completion.txt[]
 
 include::diff-config.txt[]
 
diff --git a/Documentation/config/completion.txt b/Documentation/config/completion.txt
new file mode 100644
index 0000000000..4d99bf33c9
--- /dev/null
+++ b/Documentation/config/completion.txt
@@ -0,0 +1,7 @@
+completion.commands::
+	This is only used by git-completion.bash to add or remove
+	commands from the list of completed commands. Normally only
+	porcelain commands and a few select others are completed. You
+	can add more commands, separated by space, in this
+	variable. Prefixing the command with '-' will remove it from
+	the existing list.
-- 
2.19.1.647.g708186aaf9

