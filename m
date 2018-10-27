Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF251F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeJ0PEi (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43537 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id u18so2473182lff.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P62Cxnnmiuiu+Y7XPlhx3xzx/u0NNiKIerbhzajnzPU=;
        b=U0cXpZ6Z+R1EcHByK0vj03kAM4JYoYtqIootsIX7p5xctY2+EgnIH2KR/1OgAMiu56
         Wvo2A1+xObCxIL5GfPmzTPlIMWDeQWEFdpos5fs1rUv4hnQ0SCRdg+15N/nLD8yV2S5C
         waC3rt8rkdyi4OXMtjvIyga/omnKcYeDDbFZN1zzUsJe4yG099mcJBAIHFfWIu3yMRli
         oaa8q6H9Ew71ewX/44i44kP7CIg2wnguiI4hann/2fVMRmE9kcQ+UQy9xaFcuz4vV5KI
         m4sS3JEWHR5v+r+g+zDZ0o4DSr1Zp0otGrisS+79vvmSHACAVnsgiRk7jPNL6deoGRnD
         BgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P62Cxnnmiuiu+Y7XPlhx3xzx/u0NNiKIerbhzajnzPU=;
        b=uDCcnRL9Fu+IhxQjATdRuZIcKro7lGN4le3VgoTLY2hir8vn59CaoSC7qg403jtcAW
         y2it6GMHIODMH5FifCmJAKQkC4W3dSYuut3I5BHKWeZJ7z5Na48LY6OksUeLx1JwshB9
         uj+2h+xscrO+eFS6OiJk3I4CfvPl3I2ioOaG6AxS0rr5jicszIA3cHr5lHIyKvdqYb0w
         wvBtjqOM7OiFsrNIektySolOBR1dcJ5gF4y0e9hmZ1OWfwKd5xwqFDx1T9u4dQ4NqHs4
         8wgKTkJRghZ184bVOMy6cupoWqMtfmS+snutFL09TUl7s6RJgyRZuWFS1if0chu3fX2E
         ge2g==
X-Gm-Message-State: AGRZ1gKgAaL3QRZHmDOhT/HMcCG7gd6PiXutR954zf2t+qDZkpPueSP4
        MAghczCbDPFAXNHzz29lP3/HX8xG
X-Google-Smtp-Source: AJdET5fLYAmr/X1+fIPHixeNG9pRSIKjNmvSxDHiVOIczSj0eMRPwi9kQYaBp644E++XpXtHktjzYQ==
X-Received: by 2002:a19:f89:: with SMTP id 9mr3738964lfp.10.1540621481684;
        Fri, 26 Oct 2018 23:24:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 38/78] config.txt: move index.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:11 +0200
Message-Id: <20181027062351.30446-39-pclouds@gmail.com>
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
 Documentation/config.txt       | 11 +----------
 Documentation/config/index.txt | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/config/index.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d26656df95..03b7ac75fc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -355,16 +355,7 @@ include::config/i18n.txt[]
 
 include::config/imap.txt[]
 
-index.threads::
-	Specifies the number of threads to spawn when loading the index.
-	This is meant to reduce index load time on multiprocessor machines.
-	Specifying 0 or 'true' will cause Git to auto-detect the number of
-	CPU's and set the number of threads accordingly. Specifying 1 or
-	'false' will disable multithreading. Defaults to 'true'.
-
-index.version::
-	Specify the version with which new index files should be
-	initialized.  This does not affect existing repositories.
+include::config/index.txt[]
 
 init.templateDir::
 	Specify the directory from which templates will be copied.
diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
new file mode 100644
index 0000000000..4b94b6bedc
--- /dev/null
+++ b/Documentation/config/index.txt
@@ -0,0 +1,10 @@
+index.threads::
+	Specifies the number of threads to spawn when loading the index.
+	This is meant to reduce index load time on multiprocessor machines.
+	Specifying 0 or 'true' will cause Git to auto-detect the number of
+	CPU's and set the number of threads accordingly. Specifying 1 or
+	'false' will disable multithreading. Defaults to 'true'.
+
+index.version::
+	Specify the version with which new index files should be
+	initialized.  This does not affect existing repositories.
-- 
2.19.1.647.g708186aaf9

