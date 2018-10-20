Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433591F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJTUtj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46851 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeJTUti (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id p143-v6so16100381lfp.13
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rbWNr/yDU7x3TgHPpIIG3YYq0DWD5OPl5Mbka/IRKQ=;
        b=hR3pEkoonC+5jFLvIdqbwJuO6+SkMGO2twT8qXpn7rLeT1j3Y6tkZxRAn+/0Bb7jmw
         32h6kLkiSXLczXFunaNPG4SR2qOs2u4jMZSP3hW4uZ3tgbbhvz7zLVyuYsAfliX9QAAa
         S0to9lgtd+qzgELQ4IBnVbMSeLI/aTJMIkYPPgLzQtd67ubKsixJ1fml7XeEJHDlFmV8
         B4hlttjrxIDtp4j/PUgX2RRvLlDpj0eoD7eLEgxP9UyyeJVCdCJqyD9MllDZU+jVeuUs
         Gzk9FIPyJh7X/4d83k0EKmrXu8bC+NKJFmnH+U61CUB2W+gaYZbgUwCjqiwwLr13lE+u
         sr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rbWNr/yDU7x3TgHPpIIG3YYq0DWD5OPl5Mbka/IRKQ=;
        b=KBF+hkJFdlN4V/bDRqUFBgibCzWE0kbwahCaFwgbqm+VlOgBlOrYDbGlpjFSPUL5XD
         GH6+LyMze2xGfp+ie5b+HMxkR8FTyShZBhaWjOechp6fMOJWvW68fAGNh0PUsXGBXm6J
         RDYemgAsPb8IQUk7DGHIB7jlBXz2jixSyfD/p6pvYcGXuTgjrsjeOfeUQwZ3lQbZ9vFg
         zcVamcfdfKGnuLzKJQ1o3ws8CWRjqRWWUgGazTMyQvebCQKOouJVlkWu5BXfLIEn38qd
         m21eDljj63QYWmRaHOUFONxLcuaKkx8Zaaqz/lCJ64FewNbaFCWBbP7e+b7LJJcC2mZd
         TCzQ==
X-Gm-Message-State: ABuFfojSVth9irlJww5dyk9NvtLTZXLGkxG2Iwo62qXNb2bPHDRmPI9O
        7KUgIzXurk/tv/OYljxgJUmbirtq
X-Google-Smtp-Source: ACcGV60oeoT3U0uZDYCZ9ozqg+LYTcbyh/nJa3ttsiBjyZSoW7GhLZo431UM9c07NPUXkpQ/17Vs+g==
X-Received: by 2002:a19:d999:: with SMTP id s25-v6mr5244329lfi.122.1540039155344;
        Sat, 20 Oct 2018 05:39:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/59] config.txt: move completion.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:05 +0200
Message-Id: <20181020123848.2785-17-pclouds@gmail.com>
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
 Documentation/completion-config.txt | 7 +++++++
 Documentation/config.txt            | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/completion-config.txt

diff --git a/Documentation/completion-config.txt b/Documentation/completion-config.txt
new file mode 100644
index 0000000000..4d99bf33c9
--- /dev/null
+++ b/Documentation/completion-config.txt
@@ -0,0 +1,7 @@
+completion.commands::
+	This is only used by git-completion.bash to add or remove
+	commands from the list of completed commands. Normally only
+	porcelain commands and a few select others are completed. You
+	can add more commands, separated by space, in this
+	variable. Prefixing the command with '-' will remove it from
+	the existing list.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 36a8d120be..d1509dd25e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -317,13 +317,7 @@ include::commit-config.txt[]
 
 include::credential-config.txt[]
 
-completion.commands::
-	This is only used by git-completion.bash to add or remove
-	commands from the list of completed commands. Normally only
-	porcelain commands and a few select others are completed. You
-	can add more commands, separated by space, in this
-	variable. Prefixing the command with '-' will remove it from
-	the existing list.
+include::completion-config.txt[]
 
 include::diff-config.txt[]
 
-- 
2.19.1.647.g708186aaf9

