Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F561F405
	for <e@80x24.org>; Sun, 16 Dec 2018 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbeLPO32 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:29:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42467 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPO32 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:29:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so7555396lfh.9
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQ/eZxl2Xzr5kNU7ICQuzJqtb8pMQOosITUAMwwbjAI=;
        b=eCEdlUsSOeppuxGhsojlb+4pxos5/OmYCJAY9ZFbqKNJl+yY5b2RaZzleqbuscmXJL
         8QuLIBrklAkB/cAp60bSKDWoIXkW/NoiBwJCi0RbspoWQZVzBDdycX2kEhq6mABE5FaD
         WuW39TET74ZnTcGKhOkfpYmjeO8Wrc6GowO0AefgdW5mp78MB4WB5ToDLebTXF+xHrri
         u4jUP/oDsHZhwPOmfXVr1xwzq4KbvcsAnRPwTiSn91y53yfSEzcYqWQFgGQfqx4aFDaU
         VFIn5kXdnxBMFAt8xBk3N0rYjFTwmyeBJbzIfjvSLH1Lh2cvybE966L5F10A2oNq+nZd
         MdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQ/eZxl2Xzr5kNU7ICQuzJqtb8pMQOosITUAMwwbjAI=;
        b=mhoDTIYCKgcjIfolVz5Bqk3wE+J1+MmqXdBdu8KS1epBxDfdqf0/RPiHduFs5rCaN3
         TmvOm8VdjBYEp3OGc17VBcwf8uvxuGyCTcX73RgIh73xsaIC9iKzkmm7vvgmcpWO2zgM
         qpvxNtrflyjNMJCZgeLiTMUVevfdjuHGF+wiBn8DcEC8aedeIXhTZEqToxMxvsIjei/h
         zIPAt39u6qlhiQzTLGiZEwrApvSuVaXwS6g3GQlKLgn+6/ze0pLohUc4djumRCJxEbda
         yFXv7y1wZfMehhhKZ0/Jj297FYJdb41r4qx4hD+mzO9k/Zpc4jIoofdKsy5SdlEXIB9J
         1/dw==
X-Gm-Message-State: AA+aEWaeUlNArAgs/1qB5+rLfrH1sNARk+YrfOw0bFJlkIeaRr8O6bt+
        5q0OgNnRSYdzsULjK0p2phC28iAW
X-Google-Smtp-Source: AFSGD/W0I2v07D50Y1R3Bkv6HnRJ5ZR8nCzN06+efPtQ1zZf6C3zE82ZbXDBRcXiUQ+a0vWr1vBfGw==
X-Received: by 2002:a19:c954:: with SMTP id z81mr5204212lff.150.1544970565719;
        Sun, 16 Dec 2018 06:29:25 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k63sm2083296lfe.13.2018.12.16.06.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:29:25 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] Documentation: do not nest open blocks
Date:   Sun, 16 Dec 2018 15:28:58 +0100
Message-Id: <c966c88d21d144160da4a8b4b4c97c541e970a78.1544969984.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1544969984.git.martin.agren@gmail.com>
References: <20181216105944.GG13704@sigill.intra.peff.net> <cover.1544969984.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears we try to nest open blocks, but that does not work well with
Asciidoctor, which fails to indent the inner blocks. As a result, they
do not visually seem to relate (as much) to the preceding paragraph as
they should. Drop the outer blocks to fix the rendering of the inner
ones. Asciidoc renders identically before and after this patch, both
man-pages and html.

This also makes Asciidoctor stop rendering a literal '+' before "Under
--pretty=oneline ..." in the manuals for git-log and git-rev-list.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-init.txt         | 4 ----
 Documentation/rev-list-options.txt | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 3c5a67fb96..057076ca38 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -38,8 +38,6 @@ the repository to another place if --separate-git-dir is given).
 OPTIONS
 -------
 
---
-
 -q::
 --quiet::
 
@@ -111,8 +109,6 @@ into it.
 If you provide a 'directory', the command is run inside it. If this directory
 does not exist, it will be created.
 
---
-
 TEMPLATE DIRECTORY
 ------------------
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bab5f50b17..98b538bc77 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,8 +13,6 @@ has a line that matches `<pattern>`), unless otherwise noted.
 Note that these are applied before commit
 ordering and formatting options, such as `--reverse`.
 
---
-
 -<number>::
 -n <number>::
 --max-count=<number>::
@@ -308,8 +306,6 @@ ifdef::git-rev-list[]
 	`<header>` text will be printed with each progress update.
 endif::git-rev-list[]
 
---
-
 History Simplification
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.20.1

