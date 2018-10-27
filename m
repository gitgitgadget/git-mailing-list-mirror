Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D791F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeJ0PE0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38755 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJ0PEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id k11-v6so3113798lja.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO0JudaSEH/NPZM/qqOYQ9R2ccoiCRtNBDzjhq4dNZY=;
        b=WtkiPYknksOFeoJ39F/9LxSVSA3zg5CrjkDK2lNAEzfd9AYEWeugelQxwYTz+G7ubz
         1Z3qzekNxECHYI1Lrl/UR8Qw6kegkockC0W+pqk5Tk4Prz76s/CqzQYzORVf0ogHbmYD
         DfxP4CdFj3BXL+a4vwOi3vJxkNiOZt3ai/Hej0MW9lloLAdog9g/+tjXtbfdzxZ6OYlh
         v4jU889ZU671Lr8ekma85QF/e9ZbyfJxyEGF7MT11MMQ0Mj38mmPfPdtoBk6FjzXYolU
         0jMGiBo8fau4qnsDbLJodxrXDmr0cQ75KSmlJpSBLHvw1idUuG0+bLQc6z/9EYEn+kG0
         1n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO0JudaSEH/NPZM/qqOYQ9R2ccoiCRtNBDzjhq4dNZY=;
        b=KmSIRIkWorUyArqhMT6mwYXTEC6NtpSNjJ14dVWU9wkW2wSqOsbElvU2kUxGdQdf2+
         U4Y2PEtjJJfmEXfpXHEXqjIlccXjbdm7vELprWUtpFF+voFfCRaO7dgXgysFKPyI1uvx
         lAx+8ETF5VcdF/6VekBoPuB4RXDPBEqgGFD4cWz1mmqdKPO1dn+kaC/KdPVIOWc6VEws
         jADVq6YUJhRuFFCVTQshK/7/W+jTJ28vTpA9DlwTbJc+ZomE0oJnzm7/Rqu3ehh3Y3mf
         OWxVAM4IyJLqJHt1csOKgeNBoyXrZuw+jshb1VrcNnxmGRpJnG34/rO8OhVSAe+3R43S
         Ntng==
X-Gm-Message-State: AGRZ1gKVNLVVA06cZhv7+AkdcVVTFy3RugJSySVc5ryhYnMP7O+pv9FH
        NhhjdaYxcpBD4gT/Pb6YwLfB78r5
X-Google-Smtp-Source: AJdET5do+wfQSY2TEKdJSk7F0ayfrDLa1ohnmUgPBE0GODHIDlfRJN+IucM4JiLN161EweFgqtiq7Q==
X-Received: by 2002:a2e:5159:: with SMTP id b25-v6mr4595349lje.156.1540621469432;
        Fri, 26 Oct 2018 23:24:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/78] config.txt: move gitweb.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:01 +0200
Message-Id: <20181027062351.30446-29-pclouds@gmail.com>
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
 Documentation/config.txt        | 17 +----------------
 Documentation/config/gitweb.txt | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/config/gitweb.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6f4a66b3f2..99ac8fc8ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -337,22 +337,7 @@ include::config/gc.txt[]
 
 include::config/gitcvs.txt[]
 
-gitweb.category::
-gitweb.description::
-gitweb.owner::
-gitweb.url::
-	See linkgit:gitweb[1] for description.
-
-gitweb.avatar::
-gitweb.blame::
-gitweb.grep::
-gitweb.highlight::
-gitweb.patches::
-gitweb.pickaxe::
-gitweb.remote_heads::
-gitweb.showSizes::
-gitweb.snapshot::
-	See linkgit:gitweb.conf[5] for description.
+include::config/gitweb.txt[]
 
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
diff --git a/Documentation/config/gitweb.txt b/Documentation/config/gitweb.txt
new file mode 100644
index 0000000000..1b51475108
--- /dev/null
+++ b/Documentation/config/gitweb.txt
@@ -0,0 +1,16 @@
+gitweb.category::
+gitweb.description::
+gitweb.owner::
+gitweb.url::
+	See linkgit:gitweb[1] for description.
+
+gitweb.avatar::
+gitweb.blame::
+gitweb.grep::
+gitweb.highlight::
+gitweb.patches::
+gitweb.pickaxe::
+gitweb.remote_heads::
+gitweb.showSizes::
+gitweb.snapshot::
+	See linkgit:gitweb.conf[5] for description.
-- 
2.19.1.647.g708186aaf9

