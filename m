Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416381F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeJ0PEQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33033 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbeJ0PEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id w16-v6so2504228lfc.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1UlYEITdDmYC4I16wbyssd7Bovli/VVbwWKqUuzNbRo=;
        b=D791ODkKjMcFMp/pBG/ExxEHqwUDIzFnTI+th5RqIDo39sKqk7Lb6Grjdbo2T4kCz+
         WTRJP7adn6AIgzEMf2h4fmHdQjZ0bysW+c9vCRA/BzNlAa1YT1soX0UU9+G+2u8/SppF
         kunseAFJdiaIkjFDLWkY1Rrhgxc5FOQS8BdlR5Iu/Ttr1i8nbJKaaU6Vb3b8UGIx3e8c
         pZW0o8Wfh4Cz85KQyFWUGHtrqKDGbv5GzM0I5SdxMZJbxg1QfEvbjfTonpJGsMxRThd8
         jaluh9WH+GU1lWliOtW1J7KATy9QJAtFBHJScSoH7c+l599zkRzPY6c1aC7iVZADGp/j
         Vkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1UlYEITdDmYC4I16wbyssd7Bovli/VVbwWKqUuzNbRo=;
        b=EUd04zg+Ic7U1sR+vUE5yLd7TbbBgipd2he4C7buZMNKl54OyYd69C5uvxKXW4pAuI
         c5Mn42uQxALYCVN+BhdwEHx/5Th1aRs+RAusS11UTA3zvnq7SAgrP2dxIfwi3F0slLFs
         KmNTF/OxwDewPx13t1Gd1UuUUXDPYUzRT9kF3RZRiHbY+ZYgZYNvD9CrObgZHweAhE/Q
         j3ybZz+5rJRPxg6/vEf48ZBHINTWclXmWCW5qRXcgjL52pgRo8aoi7Fp8Qd98u+PU++W
         GR6++eHqs+G+9Q2hiH2Nr7pvOGIEVoX2zjfkP8EX/Fcmy0X5lmx2xeOBz7BgSZW+fONK
         3Q3A==
X-Gm-Message-State: AGRZ1gK2fUt/xB4fXrIVbjgWhq2mN3zHUksmBXeCQsYY+mvbwglMNjjH
        krtVYWt9b2jIRHZzc2TseLoQa/wn
X-Google-Smtp-Source: AJdET5e1+180oDKXAPI5DukHVY9331ITBcsvaDLMaa2hwMbUWt2VwNy91cu7w8ZgMKm3q4d4TW1Cgw==
X-Received: by 2002:a19:a5cc:: with SMTP id o195-v6mr3810684lfe.92.1540621460637;
        Fri, 26 Oct 2018 23:24:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/78] config.txt: move fastimport.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:53 +0200
Message-Id: <20181027062351.30446-21-pclouds@gmail.com>
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
 Documentation/config.txt            | 9 +--------
 Documentation/config/fastimport.txt | 8 ++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/config/fastimport.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f313c7da2e..92bc420245 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -323,14 +323,7 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
-fastimport.unpackLimit::
-	If the number of objects imported by linkgit:git-fast-import[1]
-	is below this limit, then the objects will be unpacked into
-	loose object files.  However if the number of imported objects
-	equals or exceeds this limit then the pack will be stored as a
-	pack.  Storing the pack from a fast-import can make the import
-	operation complete faster, especially on slow filesystems.  If
-	not set, the value of `transfer.unpackLimit` is used instead.
+include::config/fastimport.txt[]
 
 include::fetch-config.txt[]
 
diff --git a/Documentation/config/fastimport.txt b/Documentation/config/fastimport.txt
new file mode 100644
index 0000000000..c1166e330d
--- /dev/null
+++ b/Documentation/config/fastimport.txt
@@ -0,0 +1,8 @@
+fastimport.unpackLimit::
+	If the number of objects imported by linkgit:git-fast-import[1]
+	is below this limit, then the objects will be unpacked into
+	loose object files.  However if the number of imported objects
+	equals or exceeds this limit then the pack will be stored as a
+	pack.  Storing the pack from a fast-import can make the import
+	operation complete faster, especially on slow filesystems.  If
+	not set, the value of `transfer.unpackLimit` is used instead.
-- 
2.19.1.647.g708186aaf9

