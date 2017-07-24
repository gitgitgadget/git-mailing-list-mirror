Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF70203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbdGXUgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:36:00 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34985 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdGXUf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so12635353pgc.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3KPVOT2picinBERO1EvOrb7cfpMHlduj0wRoBLm7Mbk=;
        b=cZy1HG7kDtAWBenC29juAhLGIoBBNI4R0HGec5iHznpV/tgEELYG2a57xrFABMT1om
         G3GsVLmDlHMFderMdHlKRVqk/Xbctb3wg/Eb5o1x65/5/krC8SGvyIw8jnWSR429QC73
         fr8bJR966MSVrjM7JZfnG92oRVC40P1k09jkkEgpX5njTm1TpWGlKsBRJKM7oFjoU3XC
         4ow+VijfkTwdUMW1FxTkzEDkO3CKKjqOBtN8R0NSTUOlLqhhHPj5dZKY5Bg3gJPC7WVz
         siwmcxMVd3AJWzS+w4RrsemntNy1WmY2boGVluaJJbJ19TnpWYaXiVyHOT0k2U1KQd28
         XWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3KPVOT2picinBERO1EvOrb7cfpMHlduj0wRoBLm7Mbk=;
        b=sbM2zxAaQUSpTHnQ0XKX6UqemGhwwjDKBEV/1t2NYZDH4pfH9tzYSAGygVG2G/7TGD
         6+1bZCEpc1RGD2j5P0vQ54i9m7SLfAqxyKbytyxR5ygtcTfIoPtYiNfUci270w+X6oUY
         ED7g8Jct5wyxWwMY7rvMwlctRiwOhVUTpA8by5YeHiDlZU2m8djZbpopxCRl/9jtW941
         K5/oXcv6dxt6cturUNvUHewbhhZd0WKhWiCJSeZwKRa1mEErGLeGevoRjkQ0RTqKy+pZ
         DFUdcGLBaoh7U171TFEebCaeJ1wz0MF5Wk4qHs/JkiK9U8puXn4WKPZcYVjIvHNTS+8t
         RzVw==
X-Gm-Message-State: AIVw11208SE8JiUx5LaJ4LkkyOhUcxzTuEktM1gv0VNCLmeneKo7rW2V
        wGmb7tHyhRvfUzMK9wg=
X-Received: by 10.84.237.15 with SMTP id s15mr19825983plk.100.1500928557022;
        Mon, 24 Jul 2017 13:35:57 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:56 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 10/13] submodule foreach: document '$sm_path' instead of '$path'
Date:   Tue, 25 Jul 2017 02:04:51 +0530
Message-Id: <20170724203454.13947-11-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..a23baef62 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,12 +183,14 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
+	The command has access to the variables $name, $sm_path, $sha1 and
 	$toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$sm_path is the path of the submodule as recorded in the superproject,
+	$sha1 is the commit as recorded in the superproject, and
+	$toplevel is the absolute path to the top-level of the superproject.
+	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
+	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-- 
2.13.0

