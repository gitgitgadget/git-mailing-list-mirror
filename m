Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1FDD1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJ0PEE (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46282 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeJ0PED (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id o2-v6so2461278lfl.13
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGXtziuyfOdNZBP0bmkbOJUedvx9CkedTK0WuDoMVRE=;
        b=pac6zG5azKDtZOd6mu/Cb/7B2t15VBBcrlzKIHE82qUU+ssp4+aZADHE1rmqrfUgso
         WcsXy48gSLTywTFsHSg+baoGiwZfmVeJGVld0OvvkPNHU6q5BxXp9Ifawf9ypuJ0JJZy
         dc7OCpATmdfI3WiRoBaUxgL3ttpvvImFdjaZtQhk9LBBpzf/y9TWb8KRGU3d2iwPjG4o
         DWlUyDvUbNgz0VgBlXBAtjiz8Jpi/tpvIUg/VSuKTrUu7/lyzULXWtmcgOp8rc5Yg2Io
         dTYg3COpVSLx/JLIcU5aDJEv7oZg8nPjT83dyNyED31lHDFKt0zxivsHUtytH/Rq0OuD
         XeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGXtziuyfOdNZBP0bmkbOJUedvx9CkedTK0WuDoMVRE=;
        b=f11SbLJA/+yPZaS37KyBi9c8mNP2+ORN3yEm67ZGmWpa+YIfy1eyRHAB70VIB4hxii
         CVxDdq8gJNDpDgTSeCR98uKRbsMO4CWPOpauPy/0vU1k+aEZQ8ozZlga841NcM5mNc+C
         aL6ZMoC4BLFOrUXes6JRddQ/PBQ7mwxG/CzIpYvaca8DURkqRHRsdnaykk/kVa8zo4Ny
         K1r7U6WfjNNVkCnlJnYo/4RYtJ79Ad58PjTShYipPab2u9p6MnU2P1Iatw5WUJpMDPbF
         sXOCnS7tQn6dwMNfaeFGUivqc0EFz5L/Lsnjpv8Rmr9abw1yhTC7dcGcMNEehahypKYE
         IJhw==
X-Gm-Message-State: AGRZ1gLxjnhDDzcs/n298ZvaN7GfPYDI1mWiqMQ9w3QIxzyY6JyeS1Kh
        676pQZkF5pfVX3gYvVKOhMWxCNPB
X-Google-Smtp-Source: AJdET5fUVzU24nBZTRpt6LD3ttbP+xv0LmVV/yrItyPnOQ0ZTWuO6Md5nUYLcezOfx6cQcdftey/Aw==
X-Received: by 2002:a19:660a:: with SMTP id a10-v6mr2513143lfc.100.1540621447501;
        Fri, 26 Oct 2018 23:24:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/78] config.txt: move browser.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:43 +0200
Message-Id: <20181027062351.30446-11-pclouds@gmail.com>
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
 Documentation/config.txt         | 10 +---------
 Documentation/config/browser.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/browser.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3dc7dd6cdb..47eb119976 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -303,15 +303,7 @@ include::config/blame.txt[]
 
 include::config/branch.txt[]
 
-browser.<tool>.cmd::
-	Specify the command to invoke the specified browser. The
-	specified command is evaluated in shell with the URLs passed
-	as arguments. (See linkgit:git-web{litdd}browse[1].)
-
-browser.<tool>.path::
-	Override the path for the given tool that may be used to
-	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
-	working repository in gitweb (see linkgit:git-instaweb[1]).
+include::config/browser.txt[]
 
 checkout.defaultRemote::
 	When you run 'git checkout <something>' and only have one
diff --git a/Documentation/config/browser.txt b/Documentation/config/browser.txt
new file mode 100644
index 0000000000..195df207a6
--- /dev/null
+++ b/Documentation/config/browser.txt
@@ -0,0 +1,9 @@
+browser.<tool>.cmd::
+	Specify the command to invoke the specified browser. The
+	specified command is evaluated in shell with the URLs passed
+	as arguments. (See linkgit:git-web{litdd}browse[1].)
+
+browser.<tool>.path::
+	Override the path for the given tool that may be used to
+	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
+	working repository in gitweb (see linkgit:git-instaweb[1]).
-- 
2.19.1.647.g708186aaf9

