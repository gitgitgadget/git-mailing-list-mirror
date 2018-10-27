Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FBE1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeJ0PEF (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42912 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeJ0PEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id f3-v6so3105811ljk.9
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcSzHaNVSifSdBt8+PZEDiTEZwYn85eimBdTK5lmA3o=;
        b=SkQx3LqJ8acoyV2x9Ncb1FHVsivFZbxaQIUJ+t4SAZdeK88pkvD+Y3f47ZRhEOrc1a
         gJtiUflBMFve0dwuOlmq+FR+bbwOf31FEcpuqnOqKWXdHBC5e5N8VDGsbFA7A8g/WBhv
         X+00j8EcNh9Je9aLYnU9ZWaGwFFrmNPF/XdjS2t0hKZMujn8rbqg4JLwJtfL6zd+Zvmm
         7MTHplsKPve+iL7SWVRXm4Jb8AxBjRKOw3vlSvXeYebG6nLOijP50gYpm/Qh1Yoqo+HU
         4T7ZALxHPwhayfaUi+gLp17OPb1s2biGb0fz1XbavptZkz1J1PMy6O6ZYjbMPKr829u9
         rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcSzHaNVSifSdBt8+PZEDiTEZwYn85eimBdTK5lmA3o=;
        b=rL5xFzXH9l7AVXOTttlISLb6XJwBI7kE5cPBDCS8sdb7+mI7ULz6tqw85pbMPGH/9a
         1ZXE4NPQv0VEC1iRmysPjYaaF3g5EcXZerKwA4vvHlae8tRinEr7cTiKGPiuEjgqOb9K
         I2Ox0mBis2+5ESQr265Qh/5Ur3TbQBbws7Wq1MV4NlOz4n9vUyTL2dDmXeEKaIctV4C1
         3xjYE6e4yC7hjjXAbqehzMTqpO86uH61PPl+lAQ6+cx+xFN6siMsu6cbg5j1UbmwHSxJ
         sQaeCGK1eQ9CiRB6ze3NPrFc3zbj2b6C81tTP/p2+tgS12MN1j4s2HCjqJq3CzTEMPJ/
         SLTA==
X-Gm-Message-State: AGRZ1gIXVjxJwJeiJ8ITcY8OkqtEtXNW9tVCQxjth+ITmqrbjkZOVGbt
        P1a7wjGp2p4iHg4FN7mrxTYECl+9
X-Google-Smtp-Source: AJdET5dj7/9rWSA+bMXiuiPr2u+S9rDJBYyK8q7c2k/iPPqvZ1tWkbYMboYyxMwkAsaLal5X84j1FA==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr4640496ljj.6.1540621448557;
        Fri, 26 Oct 2018 23:24:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/78] config.txt: move checkout.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:44 +0200
Message-Id: <20181027062351.30446-12-pclouds@gmail.com>
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
 Documentation/config.txt          | 24 +-----------------------
 Documentation/config/checkout.txt | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/config/checkout.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 47eb119976..a473ddc3c3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -305,29 +305,7 @@ include::config/branch.txt[]
 
 include::config/browser.txt[]
 
-checkout.defaultRemote::
-	When you run 'git checkout <something>' and only have one
-	remote, it may implicitly fall back on checking out and
-	tracking e.g. 'origin/<something>'. This stops working as soon
-	as you have more than one remote with a '<something>'
-	reference. This setting allows for setting the name of a
-	preferred remote that should always win when it comes to
-	disambiguation. The typical use-case is to set this to
-	`origin`.
-+
-Currently this is used by linkgit:git-checkout[1] when 'git checkout
-<something>' will checkout the '<something>' branch on another remote,
-and by linkgit:git-worktree[1] when 'git worktree add' refers to a
-remote branch. This setting might be used for other checkout-like
-commands or functionality in the future.
-
-checkout.optimizeNewBranch::
-	Optimizes the performance of "git checkout -b <new_branch>" when
-	using sparse-checkout.  When set to true, git will not update the
-	repo based on the current sparse-checkout settings.  This means it
-	will not update the skip-worktree bit in the index nor add/remove
-	files in the working directory to reflect the current sparse checkout
-	settings nor will it show the local changes.
+include::config/checkout.txt[]
 
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
new file mode 100644
index 0000000000..c4118fa196
--- /dev/null
+++ b/Documentation/config/checkout.txt
@@ -0,0 +1,23 @@
+checkout.defaultRemote::
+	When you run 'git checkout <something>' and only have one
+	remote, it may implicitly fall back on checking out and
+	tracking e.g. 'origin/<something>'. This stops working as soon
+	as you have more than one remote with a '<something>'
+	reference. This setting allows for setting the name of a
+	preferred remote that should always win when it comes to
+	disambiguation. The typical use-case is to set this to
+	`origin`.
++
+Currently this is used by linkgit:git-checkout[1] when 'git checkout
+<something>' will checkout the '<something>' branch on another remote,
+and by linkgit:git-worktree[1] when 'git worktree add' refers to a
+remote branch. This setting might be used for other checkout-like
+commands or functionality in the future.
+
+checkout.optimizeNewBranch::
+	Optimizes the performance of "git checkout -b <new_branch>" when
+	using sparse-checkout.  When set to true, git will not update the
+	repo based on the current sparse-checkout settings.  This means it
+	will not update the skip-worktree bit in the index nor add/remove
+	files in the working directory to reflect the current sparse checkout
+	settings nor will it show the local changes.
-- 
2.19.1.647.g708186aaf9

