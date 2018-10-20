Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D691F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJTUuD (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36444 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUuD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id p89-v6so33111189ljb.3
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+4e5DECkUG58Ssvw8baeB25w5BbI/toXaFYi2MrpAI=;
        b=lTiP480Jhyxu9R3cRn5mEhAncpCkkRvkTw/L+JuvTtZHHwxybXUeCgoY/elnDIqzOA
         Nyyn5RiBo+4+Dg331ICRlie4xZwKK8wAnZEVGs2m6nfKkt//UGTLElaKZpCkDIYBa+RW
         /oIMo+dY3G+xTwsyJKm3HSvdcvnWZyHkw9S4GGe7EPJN5wqQKMJUAu8cPIbke9skDgGl
         8it7GwOYCJZbacCydriC7a/XNPPjs5C7xp1Wz1Rq961GC2df4J/V8/Y91a2gawtDH7rD
         84eJ4EC9UzJlcTWGv6BwRZc9scHrfs61TXaNaIN6rf59GDEtNAW9vokklWyFDEdRZJwt
         9sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+4e5DECkUG58Ssvw8baeB25w5BbI/toXaFYi2MrpAI=;
        b=IUVOm2f1rWGdBW68E9xVhfEPWl3jJA472jOpu+3ZfeLah6cfsn3qdEUvTYjzw+/SAr
         Bu0S3pDS2VDE0A/hGvR+Mb7mAhBUveLOg4w8XbftuE81z80uurszmmJoUXaVGKmUtq+L
         z0sXUqeGJWpA+PoqxdLmodavzYHxs9KshEgkq5HbVLDpMVC77WegP3WRPX36reSweWfS
         +zmykm8wM3izOvRim/RPUzkVmIkDlS5v/HcKzLiqcSPKuN4mtTdmVD/Jwzp/tfl/1xcq
         uj3FjidK9meh2wZngJRXi5UpvkT749T1JjlyL/2M1Mr2KpR34TR25PrMlOXFQOfbl60l
         jWkQ==
X-Gm-Message-State: ABuFfojQrFQ++q7YuvCU9a5SLJvaDsF2oDh3ah1+uqbGfpF6Ozfj7uzI
        Ctl2cNOUrnaOuebMpCQwyA9XYNr4
X-Google-Smtp-Source: ACcGV63kqhwi8/9rFKu0gatZ3q0j5ihZhTgv3z8oziGjSaBLXAKTVADOVQuu/BVMyb8b26jlktWo+w==
X-Received: by 2002:a2e:9851:: with SMTP id e17-v6mr22401083ljj.143.1540039181075;
        Sat, 20 Oct 2018 05:39:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/59] config.txt: move i18n.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:18 +0200
Message-Id: <20181020123848.2785-30-pclouds@gmail.com>
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
 Documentation/config.txt       | 11 +----------
 Documentation/index-config.txt | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/index-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec0f4e2161..5ba7975837 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -606,16 +606,7 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
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
+include::index-config.txt[]
 
 init.templateDir::
 	Specify the directory from which templates will be copied.
diff --git a/Documentation/index-config.txt b/Documentation/index-config.txt
new file mode 100644
index 0000000000..4b94b6bedc
--- /dev/null
+++ b/Documentation/index-config.txt
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

