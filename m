Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36AD11F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJTUtb (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44789 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJTUta (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so33058096ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+baa0Ewd/jcRusWUqRenhSS7VTMS3KXFxGtDn8/8ttw=;
        b=jJmaiM0sutPY6Bl2swbwbrfGOdru0FUzAQjCZQzFrv4P5bNHNCHrz2LGZpK1x1agTh
         wZlCeKofQzaK9PfDCIlwP1hZ8dSGkR5uKVpyjpFO5JX5BDA+C4+jBrZ0y231IPnk53EC
         jr8s8VFM5xG7qqFrwM8R2alkKixUwI2TfZG7BQlZLwxS7L60eTDgrRKJEMMsQXq83nzw
         ccDyYXlPQybyZ9Oi/YBUBrgN4jAoC/QEq1wCHDWSvbeG2ZJ3wUbj4J0xd75SfsarYiK2
         7tiMursjdnki8aa7hxakaoJRrfOJ4Ck0QcHisC9gXC7dMnrQHlfEHRLrwomOA2KdefXq
         So4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+baa0Ewd/jcRusWUqRenhSS7VTMS3KXFxGtDn8/8ttw=;
        b=OYI17Pxp9rToDvwoXW+KkyARKYa+QN9EuNXWjFqQAl5qWanoXDrwpTZb1/xjicaY/h
         EnfgTuM3S3GwdVGzaTxia0RUuwu7+U3xNKSIHdxJHskBOknXvNMzO8+7aG4RlLB2d00v
         gYcaBN59M3lx+1GFj9V9UeNjaOuQ8r6KV4RuckhNkK3lNOQqoPZMHRGFafsLGlMN6yBO
         LSEg7tPEAPC5jzY6IM/jbXgLoB2q/E4IUMfJCwBfZY4pnxigfyciqo0liOd65DV0pcDw
         tFJZVa4JCE2T2nahBvzD8l+uPF22tnTY89qMBLy/30Lx3tqDWSwGBe8laIz8PlWuZqvi
         SQpQ==
X-Gm-Message-State: ABuFfoir1HM5fqL3aJHJslkzFnbN+1nYyELUdq2VvQi3DmCA940i2gSH
        1BLkhdgRrpDo7OYR2avy8FhDd2G7
X-Google-Smtp-Source: ACcGV62yYMADbUDVULLxVY8jtcQakGCMFhffRAxqBYu3CjfaoLYZyZBTNxJVLEyJjBXz6fITfkOaPQ==
X-Received: by 2002:a2e:7109:: with SMTP id m9-v6mr24997460ljc.176.1540039148682;
        Sat, 20 Oct 2018 05:39:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/59] config.txt: move clean.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:00 +0200
Message-Id: <20181020123848.2785-12-pclouds@gmail.com>
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
 Documentation/clean-config.txt | 3 +++
 Documentation/config.txt       | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/clean-config.txt

diff --git a/Documentation/clean-config.txt b/Documentation/clean-config.txt
new file mode 100644
index 0000000000..a807c925b9
--- /dev/null
+++ b/Documentation/clean-config.txt
@@ -0,0 +1,3 @@
+clean.requireForce::
+	A boolean to make git-clean do nothing unless given -f,
+	-i or -n.   Defaults to true.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8d890cc22a..77acf785d1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -307,9 +307,7 @@ include::browser-config.txt[]
 
 include::checkout-config.txt[]
 
-clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f,
-	-i or -n.   Defaults to true.
+include::clean-config.txt[]
 
 color.advice::
 	A boolean to enable/disable color in hints (e.g. when a push
-- 
2.19.1.647.g708186aaf9

