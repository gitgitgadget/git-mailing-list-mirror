Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52DA1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJTUug (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43449 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeJTUuf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so33087504ljc.10
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCjmKLjfA6DTboWLH4V/76LEsuVPO4ggMbG4ST3rNbA=;
        b=hinH8naRmRUz/nMT/NqN/VwUhiN8SlWzyRiB9NAGtqHS4ZDgDsm19gYf4DGm4/IRCV
         ADKds5An92KNDFO7LaIuEw4T8CbaK/OZY6fzKpl7asUMI9qxAuOVlBizNnFU7TKM4JBY
         w22iubsMGycS/v2PTr7WbzCNgL4JqhGbHw0/nkgbzFuEuemZl1TrWKXVtDK1C3wX5lsG
         7p5NttC2IHXe4xTFoBoOj33Lvh2jmxgI41j+W/RnlHtvvjxz2Z3mfr4INdvrNfX7J2QL
         xdEVy61hatzCrYO7BHelL6GxbzFY5etHr60AuIv8HjTuBzxvVnp1DXYGpHOzrAxxzcw1
         0/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCjmKLjfA6DTboWLH4V/76LEsuVPO4ggMbG4ST3rNbA=;
        b=Gdz0qop+dDXWxIEMfnoZhwcbo+pzgCdhjtDx5id1XT9+HnGxSpBxZQdjhd01Tm3Bo5
         RXdfBr8x2fhl40KdBk+RlGFZogGvW3ttBwB4ZB0qU3RLlxr06j0nz4yQylMv+1f724Rn
         Md15S+JLKYXR8XvD0paoxB/WHMT76dhrXwMorzMpN77o0b+O+ghlwVRn3Aj8v2fGQstk
         dvqr96Pc44dt+cIJDyahJ3+HKkj3H07Kj8TZN9K4yBwPQMr7mQAK7yHA5HBaCnMYEbnL
         16u6k0QX6Cz25uUqon5idxa03/6kEcmT1xI6pbY5LbzFVbU0ZHg2Wo7YskexykklrXtJ
         KDmw==
X-Gm-Message-State: ABuFfohcBj2QwVNtDFjZ8BGKWpmVHVt53/SrgtvDwMEb5hICIX8QbgI9
        6BAHTsX1Qn2QnHqaL7T7CvJWk8CE
X-Google-Smtp-Source: ACcGV60R73LBpuMl4a0gTu08zO99OyVal75ii6KKOAv8q6FF2UKAYX0qpOuLad7FB3uj5se+rVxNGw==
X-Received: by 2002:a2e:7109:: with SMTP id m9-v6mr24999154ljc.176.1540039212453;
        Sat, 20 Oct 2018 05:40:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 47/59] config.txt: move sequencer.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:36 +0200
Message-Id: <20181020123848.2785-48-pclouds@gmail.com>
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
 Documentation/config.txt           | 6 +-----
 Documentation/sequencer-config.txt | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/sequencer-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f42b69f3b0..e5454df2f8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -654,11 +654,7 @@ include::rerere-config.txt[]
 
 include::sendemail-config.txt[]
 
-sequence.editor::
-	Text editor used by `git rebase -i` for editing the rebase instruction file.
-	The value is meant to be interpreted by the shell when it is used.
-	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
-	When not configured the default commit message editor is used instead.
+include::sequencer-config.txt[]
 
 showBranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
diff --git a/Documentation/sequencer-config.txt b/Documentation/sequencer-config.txt
new file mode 100644
index 0000000000..b48d532a96
--- /dev/null
+++ b/Documentation/sequencer-config.txt
@@ -0,0 +1,5 @@
+sequence.editor::
+	Text editor used by `git rebase -i` for editing the rebase instruction file.
+	The value is meant to be interpreted by the shell when it is used.
+	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
+	When not configured the default commit message editor is used instead.
-- 
2.19.1.647.g708186aaf9

