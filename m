Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26881F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJTUta (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36400 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJTUt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so33110325ljb.3
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mP/yaHYsFFp7fXWD5JAEe0+f+SbKESmti5h1K3R0gDU=;
        b=l8zhOG9AfSY3cGGgO2Igj2nfwfOFDfz6AfkiU18sve/d/XxmVzvkCeJf6O/eAoSya1
         kiOMAgQb5O3T6c5qaz4tOuRv3RNtcxHshWrIusTza+KDtsRE8I1amLNPbrIOpkcydMKK
         AtXBH1l27Xf79BjuJOemaR2UouEklJY2l9rpJFCcS3FhjuGLUNm8hkbrtdbLH5eF16sN
         ha/4XSbHYrCdFArqydHy9RPZP3TaJ7atkfSKFLeJbDzxKrbwloieXtb2H9Kf2ZHIAot8
         Dsdk8yQeBHio26td39su5yXekYpWnDMmXEHc4kt/6g6YiWFKfX4JaPajF3FnMiQv45lz
         MvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mP/yaHYsFFp7fXWD5JAEe0+f+SbKESmti5h1K3R0gDU=;
        b=ENninZXrLn897kWxCJZte1stB65YAy5+f9j+UWK+st9vZ5xqhhg2s1OBw/4hPlsDB8
         ebaRNWu466OHXZJvLmqPJOLRL7Qk7aXj2dg/cb5DpcXd/CUA3RWdSKTS7flsB5nnnf3o
         30B7CaItFl5QYFwbDSMLryhp5cPkv0F4LmblDsfZtj+qlGb8QPUuCsiyaXV9aKV7JSDV
         grl91ncg9QF3pio0DAFA9FQPYmU7BG+mjspNFJGy9jod43PcZPaip5tEzspoSG/X80Zz
         mt4JrzRTWCGYZZN0f3y/6SMvKKUdh+WoSpSeCEp2t7nhQNRk0W3IpgCgQf1icnEbdFqi
         egig==
X-Gm-Message-State: ABuFfoikr35puSYNR22MHwZwb5b/9PDCiB2+6p5CqbdWU1E5LwPGOEb8
        NwxZCQPxwVZotQtG3Hm9UCdBtXIc
X-Google-Smtp-Source: ACcGV61nAii2OGAKWl5pUpTJ6Pjr8X+BJKtBYbe6vSkGiKky6h5+/itosxWILv2fhAQgbuz5qnutKg==
X-Received: by 2002:a2e:1615:: with SMTP id w21-v6mr25536776ljd.33.1540039146604;
        Sat, 20 Oct 2018 05:39:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/59] config.txt: move browser.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:58 +0200
Message-Id: <20181020123848.2785-10-pclouds@gmail.com>
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
 Documentation/browser-config.txt |  9 +++++++++
 Documentation/config.txt         | 10 +---------
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/browser-config.txt

diff --git a/Documentation/browser-config.txt b/Documentation/browser-config.txt
new file mode 100644
index 0000000000..195df207a6
--- /dev/null
+++ b/Documentation/browser-config.txt
@@ -0,0 +1,9 @@
+browser.<tool>.cmd::
+	Specify the command to invoke the specified browser. The
+	specified command is evaluated in shell with the URLs passed
+	as arguments. (See linkgit:git-web{litdd}browse[1].)
+
+browser.<tool>.path::
+	Override the path for the given tool that may be used to
+	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
+	working repository in gitweb (see linkgit:git-instaweb[1]).
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 249b90b107..407fd390a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -303,15 +303,7 @@ include::blame-config.txt[]
 
 include::branch-config.txt[]
 
-browser.<tool>.cmd::
-	Specify the command to invoke the specified browser. The
-	specified command is evaluated in shell with the URLs passed
-	as arguments. (See linkgit:git-web{litdd}browse[1].)
-
-browser.<tool>.path::
-	Override the path for the given tool that may be used to
-	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
-	working repository in gitweb (see linkgit:git-instaweb[1]).
+include::browser-config.txt[]
 
 checkout.defaultRemote::
 	When you run 'git checkout <something>' and only have one
-- 
2.19.1.647.g708186aaf9

