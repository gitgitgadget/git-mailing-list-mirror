Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC7D1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeJ0PEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33049 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeJ0PEj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id w16-v6so2504583lfc.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5UJtoEp3AMiNglqYmMEsaS3dvKHd1Md35tvtiHlSy1Q=;
        b=GIpNhaYyGk1eMcC4bKyI5+NV2EEnUfLUm2wD2ss3GXB57dnLkJK6asnDrsHwo4rYpU
         IggbD5UnbyzGOR58MAFDWCHPKRmZi2Sv+mkhOcAwDNkoq7OM16W0TRkpi54BdjV87cdQ
         wHCY6ycBH2RkoJSy/8ig9cdZuulTLtihWBm4bjHNSu4HC+GMFIVEiIcudBJHsIjX+Rhb
         SaUeg2mUMcn0eEMOMXF6JsIbWLAk+ZVk73BcuGklw5J6NgsyBmvx7V3uG4/KP6novxXJ
         K43e7x1OTLbDOBNWqKzY15Xkd33HGrU59Z+/dTRGI1hBchPmTkXamQu60UKErH9MOl6y
         BZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5UJtoEp3AMiNglqYmMEsaS3dvKHd1Md35tvtiHlSy1Q=;
        b=A9F1uxI4XUlYX5mk6Akdl99XOFsLolH0y2wuqk19Qi26KePOJYzz/PabXaBOWizYQU
         mKjC/bHPAYphbPpFBeD2fhnzVb/Garl/Xjltmffd5WbLQIvA/m3vpEUybNnmijIrZoN0
         0k5eCo/eL4DguRpDUpij+jKuK11MhRNHItEUZ2NOLG6YYiSHeme9+yz27VQ5G/ifXeuP
         3f22ODGxH3DdCwHac7X4aO0VMAj35CK1DgtmyjxNKxggbmEeotoYTWfEUxWiTzBTsq75
         p9tQn5tG8GCRVyGOJ0RIhfYsPA81no/3Mc1o01CRtuQ/R/sX4UU7U9Al3simmvvDpu76
         q9Kg==
X-Gm-Message-State: AGRZ1gJf3NCyAyo9az8IC9fQR9831+RdUsdWuBoNPt9i2k5TVz0l+f/x
        SOaCBPgJG7Flr2DokKJXP5DdypKJ
X-Google-Smtp-Source: AJdET5dsMMshcgn5l+v5yBZf8LEAamD2myuGRGY7CWcxiulZ2BCYZNzAAil9Tl3pidn7ZNyQrzTgcw==
X-Received: by 2002:a19:e601:: with SMTP id d1mr4035555lfh.71.1540621483549;
        Fri, 26 Oct 2018 23:24:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 40/78] config.txt: move instaweb.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:13 +0200
Message-Id: <20181027062351.30446-41-pclouds@gmail.com>
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
 Documentation/config.txt          | 21 +--------------------
 Documentation/config/instaweb.txt | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/config/instaweb.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 94b14af9f3..5b6e2971e3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -359,26 +359,7 @@ include::config/index.txt[]
 
 include::config/init.txt[]
 
-instaweb.browser::
-	Specify the program that will be used to browse your working
-	repository in gitweb. See linkgit:git-instaweb[1].
-
-instaweb.httpd::
-	The HTTP daemon command-line to start gitweb on your working
-	repository. See linkgit:git-instaweb[1].
-
-instaweb.local::
-	If true the web server started by linkgit:git-instaweb[1] will
-	be bound to the local IP (127.0.0.1).
-
-instaweb.modulePath::
-	The default module path for linkgit:git-instaweb[1] to use
-	instead of /usr/lib/apache2/modules.  Only used if httpd
-	is Apache.
-
-instaweb.port::
-	The port number to bind the gitweb httpd to. See
-	linkgit:git-instaweb[1].
+include::config/instaweb.txt[]
 
 interactive.singleKey::
 	In interactive commands, allow the user to provide one-letter
diff --git a/Documentation/config/instaweb.txt b/Documentation/config/instaweb.txt
new file mode 100644
index 0000000000..50cb2f7d62
--- /dev/null
+++ b/Documentation/config/instaweb.txt
@@ -0,0 +1,20 @@
+instaweb.browser::
+	Specify the program that will be used to browse your working
+	repository in gitweb. See linkgit:git-instaweb[1].
+
+instaweb.httpd::
+	The HTTP daemon command-line to start gitweb on your working
+	repository. See linkgit:git-instaweb[1].
+
+instaweb.local::
+	If true the web server started by linkgit:git-instaweb[1] will
+	be bound to the local IP (127.0.0.1).
+
+instaweb.modulePath::
+	The default module path for linkgit:git-instaweb[1] to use
+	instead of /usr/lib/apache2/modules.  Only used if httpd
+	is Apache.
+
+instaweb.port::
+	The port number to bind the gitweb httpd to. See
+	linkgit:git-instaweb[1].
-- 
2.19.1.647.g708186aaf9

