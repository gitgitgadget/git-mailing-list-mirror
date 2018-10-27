Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCF21F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeJ0PD6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:03:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41753 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeJ0PD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so3099579lja.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQpBcRyD+0qaso8r/9FYv2+ZrSKUq60n/QW//I2GpGg=;
        b=nOVsi6AYPepG0uzjH+CjdSnWDRLEPWW8yVr483xbvBMjYOBGrjABqaYGDxgnk+dpb9
         dZX+i1ZxfCUSMCkbnXyOi6RsdUwoA+GUf7JH2fSqyheaWpWGCpDDu/CJtTfIkkfoeKI5
         uWzR1DskmrGwd606FxTBeRkvWRTlEV0SGSoguIkQG2lO0sLMm88m1SnCAjvm1srdJoyW
         33Rh2SbIhs9fZdBMoHtdy3Sakx9A6y0HhI46l28UNLst68yleyQZpN4xaCFuWIrvZXqm
         2jAu9WupWXadUtZQHCTE5cTDAPaxKc7GR1d7v0zwmm9TkAr741dULunT3CzYEGdmUGPZ
         Q44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQpBcRyD+0qaso8r/9FYv2+ZrSKUq60n/QW//I2GpGg=;
        b=eYoYJb2urgI03OdHH4UQ2XKhEnAciRSZX39kaIr6/XUT8lUSbpLWE2x+khMuu5QdtZ
         ByFrtQXV5y4MjtOa1gECVDMWwXiSN/VC4ZvV0D7SgC0b2+hl2paFS+h1mm5wckT+wEwr
         RKa0HoS8jHtuWlOu4dkl8Fby9YwIRlXaO3XT+PoGdTq6KaQln553NMjuQZlGzh4Ifx4O
         OICkk0+xQCGwxdZfh1prgZdG20odm9BaejCfAS1P9rcqIAbz/hQpx/EJqoobDGTaesYp
         0cypY2t5KbT0vdk+5N1M5uIBE0bPs59VQGGdcBNQrYhVv/2sIY0vcUNKE9N+8Y0j6LzI
         ODmQ==
X-Gm-Message-State: AGRZ1gL10XTsGZXxEXze+uwrZdXN58NEb1Sw16FnyfmS7xZc6l2oz8Kj
        rvWohuppo+IXnM15Ar1OYezSjLOp
X-Google-Smtp-Source: AJdET5ecFbG9GpH3MSYOG+LauICU22MzqOL+4tPv6dCNd+4/zjfK/JxzTNiNziTxRBhkb6oPio+3mQ==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr4564472ljh.0.1540621442029;
        Fri, 26 Oct 2018 23:24:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/78] config.txt: move alias.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:38 +0200
Message-Id: <20181027062351.30446-6-pclouds@gmail.com>
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
 Documentation/config.txt       | 19 +------------------
 Documentation/config/alias.txt | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/config/alias.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 77e45e5219..f207cae90c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -293,24 +293,7 @@ include::config/core.txt[]
 
 include::config/add.txt[]
 
-alias.*::
-	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining "alias.last = cat-file commit HEAD", the invocation
-	"git last" is equivalent to "git cat-file commit HEAD". To avoid
-	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored. Arguments are split by
-	spaces, the usual shell quoting and escaping is supported.
-	A quote pair or a backslash can be used to quote them.
-+
-If the alias expansion is prefixed with an exclamation point,
-it will be treated as a shell command.  For example, defining
-"alias.new = !gitk --all --not ORIG_HEAD", the invocation
-"git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
-executed from the top-level directory of a repository, which may
-not necessarily be the current directory.
-`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
-from the original current directory. See linkgit:git-rev-parse[1].
+include::config/alias.txt[]
 
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
new file mode 100644
index 0000000000..0b14178314
--- /dev/null
+++ b/Documentation/config/alias.txt
@@ -0,0 +1,18 @@
+alias.*::
+	Command aliases for the linkgit:git[1] command wrapper - e.g.
+	after defining "alias.last = cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD". To avoid
+	confusion and troubles with script usage, aliases that
+	hide existing Git commands are ignored. Arguments are split by
+	spaces, the usual shell quoting and escaping is supported.
+	A quote pair or a backslash can be used to quote them.
++
+If the alias expansion is prefixed with an exclamation point,
+it will be treated as a shell command.  For example, defining
+"alias.new = !gitk --all --not ORIG_HEAD", the invocation
+"git new" is equivalent to running the shell command
+"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+executed from the top-level directory of a repository, which may
+not necessarily be the current directory.
+`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
+from the original current directory. See linkgit:git-rev-parse[1].
-- 
2.19.1.647.g708186aaf9

