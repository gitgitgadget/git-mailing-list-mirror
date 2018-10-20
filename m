Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F881F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJTUtZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37844 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeJTUtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id 63-v6so33121598ljs.4
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JEenVR9za5HZ4eY/6eB9B9/u9N8IKGgMi9L0bn2PMQ=;
        b=RKfs8n4zksLP/eWmTbPicGcQes/II9HMVxCeE5Yqwb55YAQ+9e86ZLbjLo+wdtZIhu
         2ZKbQsP+OjMD2m4guXK8KzIIqtUa09x8NxyRxQD2xThSmWtKqUdDi6ew8b3uNPEs2+D4
         LNoM96Ahc8atz6hqyTQ2NfayoLnQRDl3/hhEIBuirU2g+Kc81l9t5SHRuOH3ngGKzCD+
         PYbyhWq+td90utO+ZBTiOF/Ycb99YoL4aGgYJLgFXCVnDWC9IFMe0ksSK4fR6C0pl/ui
         jzHT70jMOjlAzopG+codxBaUpjgbC+RU79/HYeIBKeBmzNAY2kqU3O2VjXSOHUEfqygW
         AcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4JEenVR9za5HZ4eY/6eB9B9/u9N8IKGgMi9L0bn2PMQ=;
        b=gf3kbqDJqXXCtpgEreTq9SyATAHCMXA/jJzp7OR+0bZ8IR13OjiEZG5/QC2AbQLTUg
         yS31AKm+UXrmZ+CqR1QzPrO4btaZB7difq+qV6TL0iLkw3jTvkAEoTmv7n5GOOjDtfC7
         W2BSDtfRPN5Qni445hBfqRyvCVWS4t08KiF8V9PKPZvmVBg4kcnQrBcg35Bt9/fWNDX3
         MlzzUuPj9zJC2j/+W0wtnmeWRMRglAQtIpW3Yf4Qm7LtujZ+xCnmMraqtES8DbXRbCWP
         19AtjW5SFE8jo1mPo0ySi+X6FGTV1zirwMlx/xIdPprZU3pGZ5V4NxJFfEM+hh/8GA7e
         tsCw==
X-Gm-Message-State: ABuFfoh/eAC6Tncti1XjVMOli4cvKUtXqDQX1HMFRwwY7ns/hsTLrKzR
        96r7GuE8H1ND1mRDHM4zVhHZnGEi
X-Google-Smtp-Source: ACcGV62s+hXwxU4rbNXqt8Ebs3G/ycxbP+aAwJoxPEL6XjTnrJGihj0QOrPw0w/XCpGHc/zwolf8ew==
X-Received: by 2002:a2e:80d2:: with SMTP id r18-v6mr28042726ljg.100.1540039143206;
        Sat, 20 Oct 2018 05:39:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/59] config.txt: move apply.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:55 +0200
Message-Id: <20181020123848.2785-7-pclouds@gmail.com>
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
 Documentation/apply-config.txt | 11 +++++++++++
 Documentation/config.txt       | 12 +-----------
 2 files changed, 12 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/apply-config.txt

diff --git a/Documentation/apply-config.txt b/Documentation/apply-config.txt
new file mode 100644
index 0000000000..8fb8ef763d
--- /dev/null
+++ b/Documentation/apply-config.txt
@@ -0,0 +1,11 @@
+apply.ignoreWhitespace::
+	When set to 'change', tells 'git apply' to ignore changes in
+	whitespace, in the same way as the `--ignore-space-change`
+	option.
+	When set to one of: no, none, never, false tells 'git apply' to
+	respect all whitespace differences.
+	See linkgit:git-apply[1].
+
+apply.whitespace::
+	Tells 'git apply' how to handle whitespaces, in the same way
+	as the `--whitespace` option. See linkgit:git-apply[1].
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 29dd694438..db259129b0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -297,17 +297,7 @@ include::alias-config.txt[]
 
 include::am-config.txt[]
 
-apply.ignoreWhitespace::
-	When set to 'change', tells 'git apply' to ignore changes in
-	whitespace, in the same way as the `--ignore-space-change`
-	option.
-	When set to one of: no, none, never, false tells 'git apply' to
-	respect all whitespace differences.
-	See linkgit:git-apply[1].
-
-apply.whitespace::
-	Tells 'git apply' how to handle whitespaces, in the same way
-	as the `--whitespace` option. See linkgit:git-apply[1].
+include::apply-config.txt[]
 
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
-- 
2.19.1.647.g708186aaf9

