Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732D01F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeJ0PEo (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39706 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbeJ0PEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so2488490lfc.6
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTjwiCHQrqZYhlV2p3e3hALyq/MQMB0jvHHS3f5l5ko=;
        b=mlLS5OSBKLUnIUr6gptBgTbazD9oIHKf95uzpof4T0cBQRF+yAeDCihuLIZF++1hT7
         kXBseoxlYqkrVVO9SVhAfHkAuxhKXlPVWZlrZZzmIK2VS+saTAwAsjZffldkL6QIq69R
         S/WgVpoNJwS7v4qEzuZ8shbMM26EPFGj2/A9afcWr345rEOcw5VbltCd8GPVyfjP7ITe
         lhSGQMO++7QkMSDDNj9/epxg4p0C6SK2sd0EUhTxv3rMZ+i3trOIFeoYV0PAqr7ATdfu
         SMJzCMS/VInHAcap2i3cNlJJdIYUtobGgkvIytfea7lvPN+/zaubNiC9/1buDd5Q4NZB
         4fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTjwiCHQrqZYhlV2p3e3hALyq/MQMB0jvHHS3f5l5ko=;
        b=H/kn1oMeAPJ72I5pMgOPfwan702aeZcDz4gJTRL85LNSNRRymyRBS6lAl+nvGVxmky
         406F2dT5KGhLMY4MLzrN0ceSnrn2kMHxvs53BXMk5elVvTMRqXAowfWQNc2QjG0GOePN
         Cayqf84+tjx2fNvtHI7FVZarA/Zqd0O62rAmj9vwk/RJ8KAZUN9ibHB/oIH82yDlaz1+
         ybJsEn4NRI+fmRtk1H0Vi7YhC4Nt67u4Qd2I5zuNqHckZkkiuBSmyfoqwDp/goqIh+gj
         Ayz2zQZM8bCUlNRelBXzCOi8SZo7BcIYZ0se+B4Lu3NFiheRmURTP52lV3h4rNzuph+1
         032A==
X-Gm-Message-State: AGRZ1gKwYHCTQpp8KFY6xScnSLChRzvbs4vjSQXuYCYHlRmQKEo8K3h4
        AJUi6OJENIXzhnoQrsisCI53Jta0
X-Google-Smtp-Source: AJdET5eaGNhz+Ujh3XhyeZDMNNj6UiBg4eu3xw6xOZhRdcKgvvpY0FPm9knPTvNebPc9bC5oHqtBsw==
X-Received: by 2002:a19:cb94:: with SMTP id b142mr3978238lfg.117.1540621487633;
        Fri, 26 Oct 2018 23:24:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 44/78] config.txt: move mailmap.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:17 +0200
Message-Id: <20181027062351.30446-45-pclouds@gmail.com>
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
 Documentation/config.txt         | 16 +---------------
 Documentation/config/mailmap.txt | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/config/mailmap.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 585d55d03d..ff9c8797a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -367,21 +367,7 @@ include::config/log.txt[]
 
 include::config/mailinfo.txt[]
 
-mailmap.file::
-	The location of an augmenting mailmap file. The default
-	mailmap, located in the root of the repository, is loaded
-	first, then the mailmap file pointed to by this variable.
-	The location of the mailmap file may be in a repository
-	subdirectory, or somewhere outside of the repository itself.
-	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
-
-mailmap.blob::
-	Like `mailmap.file`, but consider the value as a reference to a
-	blob in the repository. If both `mailmap.file` and
-	`mailmap.blob` are given, both are parsed, with entries from
-	`mailmap.file` taking precedence. In a bare repository, this
-	defaults to `HEAD:.mailmap`. In a non-bare repository, it
-	defaults to empty.
+include::config/mailmap.txt[]
 
 man.viewer::
 	Specify the programs that may be used to display help in the
diff --git a/Documentation/config/mailmap.txt b/Documentation/config/mailmap.txt
new file mode 100644
index 0000000000..48cbc30722
--- /dev/null
+++ b/Documentation/config/mailmap.txt
@@ -0,0 +1,15 @@
+mailmap.file::
+	The location of an augmenting mailmap file. The default
+	mailmap, located in the root of the repository, is loaded
+	first, then the mailmap file pointed to by this variable.
+	The location of the mailmap file may be in a repository
+	subdirectory, or somewhere outside of the repository itself.
+	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
+
+mailmap.blob::
+	Like `mailmap.file`, but consider the value as a reference to a
+	blob in the repository. If both `mailmap.file` and
+	`mailmap.blob` are given, both are parsed, with entries from
+	`mailmap.file` taking precedence. In a bare repository, this
+	defaults to `HEAD:.mailmap`. In a non-bare repository, it
+	defaults to empty.
-- 
2.19.1.647.g708186aaf9

