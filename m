Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FA71F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBBE6G (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:58:06 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38736 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBBE6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:58:04 -0500
Received: by mail-pl0-f66.google.com with SMTP id 13so5310354plb.5
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eT2F/woggZTx1Q2Xr54tQ/+EYS39BEwKxwPbZdxUjSw=;
        b=NEbAt/exJyGdoPAZ3+EkIwEyIp35HRQHc4FGS4dUiT05H1bHMFwQop45LmxjtDXZKn
         Bkyugqu8/rpbjjPjfQCimmuQZR9cyjphQQyg1JeI9VL5Zc7S/eYTqg7GY2ek2nx5j1uU
         6Hc+nuMmXO16R4oHru1tX5QYv9sXVqq1rXOaa8dKTLx1JTse/h5VTdc0jpdJzQoSoQXA
         BL3V6j59LucBcWwGoivBmpiYgVfG+vfLi6FBaFMTC395CUWQEFUAUuGZggvwkMQLkCzt
         vHJtkBNcicyyuPGDlCQJAldhcNNPFEX4i4Hdu5UxUwCuIyLUBM7l5vjYKa4DWXuQhfDI
         1dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eT2F/woggZTx1Q2Xr54tQ/+EYS39BEwKxwPbZdxUjSw=;
        b=clQgBGb/JJozZO9xFXbRpURtvsLwC79Taw/m3NJ7Tvfg5jRnNENe4HW6wI6/y0WclL
         R0vanOLta7VvYg34OkrWAEB+ShQso2yIeWsk5NFURzJOmwKBUTJDM6ig1ClHO0i97E2D
         MUfHFCms4v8IQnv2wfk2Ds+bL9OZm1M6OS9XGriyePEDxHhu9T+i0xtuxbpoFvJSHkPp
         CnYueWAoY2goRe2KB5fLxsyaDrIBVTa6MS/284mdWz8TlTRxIleG7hWXNjGceJKyli2d
         rp0BxuVgRxwLGT4DxJ2v9LGyn/tyAZjIS5mHdHPel9DRdnnvqlbFioqloxmw2zvoxmXP
         yb9w==
X-Gm-Message-State: AKwxytcW+6KbGcbcLG0s4OdWyVDhpK9/apDFMl8QliYmxdrl8BOtuM+R
        QvtmAXOrjed68r8Z0dSHqPEDSg+Y
X-Google-Smtp-Source: AH8x225+iht/iJl3A5hjeSiORFc5GolGBN4MM0OSKnGdoJB3fR1rhB7KbC3GoJnVgheBR07TcIVrvQ==
X-Received: by 2002:a17:902:46:: with SMTP id 64-v6mr34325544pla.341.1517547483304;
        Thu, 01 Feb 2018 20:58:03 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.200])
        by smtp.gmail.com with ESMTPSA id e3sm1496467pfb.143.2018.02.01.20.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:58:02 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 3/5] submodule foreach: clarify the '$toplevel' variable documentation
Date:   Fri,  2 Feb 2018 10:27:43 +0530
Message-Id: <20180202045745.5076-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202045745.5076-1-pc44800@gmail.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not contain the topmost superproject as the author assumed,
but the direct superproject, such that $toplevel/$sm_path is the
actual absolute path of the submodule.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a23baef62..8e7930ebc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,7 +188,8 @@ foreach [--recursive] <command>::
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
 	$sha1 is the commit as recorded in the superproject, and
-	$toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to its superproject, such that
+	$toplevel/$sm_path is the absolute path of the submodule.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
 	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
-- 
2.15.1

