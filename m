Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EC11F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJ0PEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41509 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id c16so2480777lfj.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCdXSgucuI2ZkXckOne9PQSndCQmWXh2F+9CZtoPx4w=;
        b=C5PWuRPM2m8sPipMCXeEv0ZcjNKNEeFaNBFyZxK2qi80qis1p8zzJslhtoZt6Nc54j
         xyL2IRpHs95o1xclfnFolBUQFasxnmQoYtXbokn8UEWvcGFdsLvnUhHT0lz0BVLDVq2T
         C3U6YxaBC/vZpSDGweO3qbzwdKPN/rhYVVh7fwlafmj/2v0BTkJAKnh/FH6HsRXFYd0e
         91sUSDx2BXBSXSPrmYNYnHfTzBKm8TbdgGWuFAddHL4Vyqgh0yBLTtiTvgx031avY9uo
         LB6T+3xukEpQHGVKubW5QglKrCzoQkNB9EMNjPuNO6hTO+QCwgrG9+5pplLKOjGAhlND
         k6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCdXSgucuI2ZkXckOne9PQSndCQmWXh2F+9CZtoPx4w=;
        b=LFB45ZYeVWjbgqyokVY6u31k3UAeldaieQj3fqkF5kYNr7RRMxivVz31XcSAqxKvvM
         8XRwSt2VLKkNysNMn/XPCuHXAIpfNYh4Mdhq9fmS2bBtQNgelDnxt27pRYAbS5HSq9xv
         AB0/VP8061C/m3ofxvDDJ5B6ekqoFOEs3x7NY0ZyVt6VpdUEyScEIDBNRr0hYrVDaxeZ
         fwvqDYg1kSkFkL8qL/xoYicQrslbczwi/ZaUWMrm7Y99/oDp9tg2FM48JML2e+L4uaZI
         mUfOqGM0PfRn0sspX+u0OXc01bI48Zoa+qUpqGXq/9CGTyRyw1pyqAL8xRYw3xnYA3IL
         OM+A==
X-Gm-Message-State: AGRZ1gJXuckrrwVf6CpNzeC1LrbhKvlKQdDyFdSc3d09elYOpJNaLDSy
        s7XVgfvtGOWdSvE0xleYW9tkHAHD
X-Google-Smtp-Source: AJdET5cJoMeyCjqJkaH7yco4G5zjV7NI3w3q0hMMBRDMXknAfAGD8xENznTIDPkh+Vb6JSjKV3NYaw==
X-Received: by 2002:a19:3809:: with SMTP id f9mr3659758lfa.148.1540621486520;
        Fri, 26 Oct 2018 23:24:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 43/78] config.txt: move mailinfo.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:16 +0200
Message-Id: <20181027062351.30446-44-pclouds@gmail.com>
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
 Documentation/config.txt          | 7 +------
 Documentation/config/mailinfo.txt | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/config/mailinfo.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cce89ea50c..585d55d03d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -365,12 +365,7 @@ include::config/interactive.txt[]
 
 include::config/log.txt[]
 
-mailinfo.scissors::
-	If true, makes linkgit:git-mailinfo[1] (and therefore
-	linkgit:git-am[1]) act by default as if the --scissors option
-	was provided on the command-line. When active, this features
-	removes everything from the message body before a scissors
-	line (i.e. consisting mainly of ">8", "8<" and "-").
+include::config/mailinfo.txt[]
 
 mailmap.file::
 	The location of an augmenting mailmap file. The default
diff --git a/Documentation/config/mailinfo.txt b/Documentation/config/mailinfo.txt
new file mode 100644
index 0000000000..3854d4ae37
--- /dev/null
+++ b/Documentation/config/mailinfo.txt
@@ -0,0 +1,6 @@
+mailinfo.scissors::
+	If true, makes linkgit:git-mailinfo[1] (and therefore
+	linkgit:git-am[1]) act by default as if the --scissors option
+	was provided on the command-line. When active, this features
+	removes everything from the message body before a scissors
+	line (i.e. consisting mainly of ">8", "8<" and "-").
-- 
2.19.1.647.g708186aaf9

