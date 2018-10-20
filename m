Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF3E1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJTUtl (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45144 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeJTUtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so676687lfi.12
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ml68f6u01c9XT24VWXplI91hzjb44bzeL+cW9QJ2uCo=;
        b=JuJGpOetBUJSUOsw8sgUZ5DDrpFy5Q6AwSMUxbbd/sLFlvwaeXTz+gfK8w7LDkt7SR
         4WkwFd/j558djEeyq6yS3CkTEF4F1haCCGnJNgf4smhdVbEIfYfpW1vMomCmt1nHhCKg
         1uiqfIVlrSuYuh4uOBVL2R/eiL5MIhuQqiKh+A8vthRdH++PjYQT6iAk2NS6De3eIN0R
         ETz4gWhC99OPpwLNFfR9Rmgchx5uyb/ymfABCqR/Y7xdb6n50QvgTGtR1ybRkl5JBXRk
         Lw6N8IiUTJmdhNteuZ/d2zAuTWEkTIkMLxNP7q0MGsms3tF9P1KXEQxXurnljdf7pVm7
         r+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ml68f6u01c9XT24VWXplI91hzjb44bzeL+cW9QJ2uCo=;
        b=nN6Y3E7E4IIrxgq1tJqpINe+rm+OczUXzyPBjAdrTGo5YfI3Phc7jDpwW6WzWIqRRI
         /hth7aj0+VLkdOefBbPhk+FTSBJvGd3ua3airGEkx46lL3bkZLak3nr4ZB7xD3DQMHdt
         ng1HgtfO4jeaicM1pzUGKelwouHkOqvQbe62b12o5SadEaZOZ09oleHV43fSZsBErqbK
         Vg1Z/tADVd65K1rVJTfQRjqtK2i5kR1t5tFcYSvrcyzBdonvMJNVQyep5KWyaAIk3gqQ
         E7pakPt3cs6ZuzLVGzFtlsQGfFepYKdDI8OQn79yAD4oYFMGkz2rGnfwCXe8LW7QBkt/
         j5Eg==
X-Gm-Message-State: ABuFfohxQNQLlHZltUsPbHj1a9+RtSJTXYecwBsf5vae2/nbyWBnxp7i
        2fOmAb8qPTBMsh+Lozd455tOkkvh
X-Google-Smtp-Source: ACcGV63UAQofmShkiUBRwmxWJHegEpoDChI5Rs1Zs3fuSz01sa0cFN08WRejv1Vao04+K41Iq5VAxg==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr1091470lfb.72.1540039158030;
        Sat, 20 Oct 2018 05:39:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/59] config.txt: move fastimport.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:07 +0200
Message-Id: <20181020123848.2785-19-pclouds@gmail.com>
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
 Documentation/config.txt            | 9 +--------
 Documentation/fastimport-config.txt | 8 ++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/fastimport-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f38e0a8334..66791f0918 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -323,14 +323,7 @@ include::diff-config.txt[]
 
 include::difftool-config.txt[]
 
-fastimport.unpackLimit::
-	If the number of objects imported by linkgit:git-fast-import[1]
-	is below this limit, then the objects will be unpacked into
-	loose object files.  However if the number of imported objects
-	equals or exceeds this limit then the pack will be stored as a
-	pack.  Storing the pack from a fast-import can make the import
-	operation complete faster, especially on slow filesystems.  If
-	not set, the value of `transfer.unpackLimit` is used instead.
+include::fastimport-config.txt[]
 
 include::fetch-config.txt[]
 
diff --git a/Documentation/fastimport-config.txt b/Documentation/fastimport-config.txt
new file mode 100644
index 0000000000..c1166e330d
--- /dev/null
+++ b/Documentation/fastimport-config.txt
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

