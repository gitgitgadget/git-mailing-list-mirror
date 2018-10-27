Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792EF1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeJ0PEq (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45241 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeJ0PEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so2470140lfi.12
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvaIxiBWAf0pqdeCL7VbisBKHOTqr0sIV52W+JIJd8U=;
        b=uiOnZs/cZmh0ppio6dJuM2qa3yuHTzJBOt5LLR6w+Lw+Z3fIFqFsOlQVNMQuhRWKZj
         t2DwqbgUk+Ss3pLh4ieNM/L6YkV8IWhTf089Cc2k+P4KQMZEr6CfKCe13/VvLf8tdk9n
         GicF4dngEpLgGZR9PtnLkWrCqsaxbKnA+x2QTaSODp7x84YAs3ZL8R6DjZfntGLmmZJl
         KzkxHk1vDHvhmBIpxD7R7TKbMCVEIOLXkd7a+7OJj4sUdT/SVB0Ev6w6COYUa+ZE36Z0
         4EWychETgpsAvJLij2CIasO1zWUBiyEp5B4VbUA6SSvCPSFHKR2DLgYsDzZ6L+fkSJJF
         PU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvaIxiBWAf0pqdeCL7VbisBKHOTqr0sIV52W+JIJd8U=;
        b=j0Y7BvKNglNmbvvEXho/Hm/HQY14eiXYAQbY0tFi3EZl7Omf37ah92geL0fYLewpEX
         GwdvtmyQJWPKD4tpAS3RNjh2QAihzGEYC9GoaHDXojrcNnI1MMe9wilhyxQrL/XBmDwR
         GvOn0/VxL7v3/3kBZz5RJzEshS2IYutsVfWkPdGhxCJcPUUAOqF0TjFnfpE+lG5Xe01J
         YlFhpEXjm5xoLEDf6346ApJSWqPdVZsbJ3Ni3esxUR1fN5ztqN1LXDPyEAtM8e4nQ6Lr
         JcVCOsHirXWp+7xdzb6RIOFFXeHZZLr4wWLqJbKRbYnLZvaSC/joVAiKEGqFV6u9Cm56
         LwIQ==
X-Gm-Message-State: AGRZ1gKpr7a82z9ltkGqyAyhfMpFSsU4wjl3iGr0GIyVWiP2DnD7w7Tb
        eQoZKmY+7yiqBQwZTbFEKa9znMah
X-Google-Smtp-Source: AJdET5eb4kXM58G3u1rcCKFY2WaB0AJ0sRXgX+HwX/IczfiG5ZXZ9M56polv41O9My3r4YQ0CZ/0cw==
X-Received: by 2002:a19:5a84:: with SMTP id y4mr4019447lfk.156.1540621489729;
        Fri, 26 Oct 2018 23:24:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 46/78] config.txt: move merge-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:19 +0200
Message-Id: <20181027062351.30446-47-pclouds@gmail.com>
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
 Documentation/config.txt                             | 2 +-
 Documentation/{merge-config.txt => config/merge.txt} | 4 ++--
 Documentation/git-merge.txt                          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/{merge-config.txt => config/merge.txt} (98%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c3c92bc269..441787e815 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -371,7 +371,7 @@ include::config/mailmap.txt[]
 
 include::config/man.txt[]
 
-include::merge-config.txt[]
+include::config/merge.txt[]
 
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/merge-config.txt b/Documentation/config/merge.txt
similarity index 98%
rename from Documentation/merge-config.txt
rename to Documentation/config/merge.txt
index 0bb703fbac..321d1c8ba9 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/config/merge.txt
@@ -30,7 +30,7 @@ merge.verifySignatures::
 	If true, this is equivalent to the --verify-signatures command
 	line option. See linkgit:git-merge[1] for details.
 
-include::config/fmt-merge-msg.txt[]
+include::fmt-merge-msg.txt[]
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
@@ -63,7 +63,7 @@ merge.tool::
 	Any other value is treated as a custom merge tool and requires
 	that a corresponding mergetool.<tool>.cmd variable is defined.
 
-include::mergetools-merge.txt[]
+include::../mergetools-merge.txt[]
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index eb36837f86..4cc86469f3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -342,7 +342,7 @@ include::merge-strategies.txt[]
 
 CONFIGURATION
 -------------
-include::merge-config.txt[]
+include::config/merge.txt[]
 
 branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
-- 
2.19.1.647.g708186aaf9

