Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD051F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfENSsD (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:03 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36926 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfENSsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:02 -0400
Received: by mail-yb1-f193.google.com with SMTP id p134so47948ybc.4
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6kBqGumlgMWg//8WJMHQRmX3RpWhL8fUfwG0BHKvvg=;
        b=T6ANq0WDsB6Xe71HiBzVEsRzQ0XAR8HjI/EBc5bqzAmCDIoe3rePwH0WYmu/AscI5i
         wYNlgjoMZlNWvUTg5sONx5dXliJXtCzaIFp0WUZpOlvA3ETmhCeBbTG8KQpHNO+zUQ4M
         MhXvtnrRzCJf9pbpJHqUQ08fQeLk74Ja9x/pbnUvoC3fa6OqJqHM3orkmk8Iz3Wltl4o
         G7Fo/yfgPJ8LGH+JUFxVKi4/qP9CbCwqOfz8vqqydJY9VPiacIruytfvEVCquCLmi0CJ
         cIg/2Lp7V9YatRkE0KigUfukHcdTDXovcPuJeVgRBSWZP9wxz7DIOtrfgUAvbuPbBOie
         E3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6kBqGumlgMWg//8WJMHQRmX3RpWhL8fUfwG0BHKvvg=;
        b=IVY3Rb80jOvpvbUMpOFJRK61MIqMgBqkWd6teSVp9946G69oWM8zWIgDWGpvcLCKcz
         vTM4yZLfBhiWqUG3OZhDi//uPJN/HNTDFPowkUU3RW91EpmeSCNiWetjD05fBN6ylxo5
         obz+4C9eHHD4B+9Urrg+BQm+L/vvOZUROJYfxAuHq7I8mmTwDxe8cGSjjOZGzQ3mxu/7
         fLnl1O1V1yHoyTeTR1j/pu7Nsy96e2jlhzwCo84qyJfK5aRcrxLdfLsOL5HHuDWKJa7i
         qh7cb1f5w9ITdd0K0eQEWlRURwyrKSe5PGNtJTKi9QvpVk4ljlCusKF0XLlRuGmeqnSW
         BOVw==
X-Gm-Message-State: APjAAAX+02Lt/6xBr2eBIT45z6d8KGsjevggB5iwGMSjbd4cdmgqP/Y1
        yyLMCJF6AGwk3rt5/XIUy5oBgG1687k=
X-Google-Smtp-Source: APXvYqzFj81IsD/whP/R8oskpTRV9RPM4B1eVHsGLV3t/Fzp2MZ34PVgbKqFVkCDSvntnz3+OHeeGQ==
X-Received: by 2002:a25:449:: with SMTP id 70mr73885ybe.25.1557859680804;
        Tue, 14 May 2019 11:48:00 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:00 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Szeder=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 02/11] Docs: rearrange subcommands for multi-pack-index
Date:   Tue, 14 May 2019 18:47:45 +0000
Message-Id: <20190514184754.3196-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will add new subcommands to the multi-pack-index, and that will
make the documentation a bit messier. Clean up the 'verb'
descriptions by renaming the concept to 'subcommand' and removing
the reference to the object directory.

Helped-by: Stefan Beller <sbeller@google.com>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index f7778a2c85..1af406aca2 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] <verb>
+'git multi-pack-index' [--object-dir=<dir>] <subcommand>
 
 DESCRIPTION
 -----------
@@ -23,13 +23,13 @@ OPTIONS
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
+The following subcommands are available:
+
 write::
-	When given as the verb, write a new MIDX file to
-	`<dir>/packs/multi-pack-index`.
+	Write a new MIDX file.
 
 verify::
-	When given as the verb, verify the contents of the MIDX file
-	at `<dir>/packs/multi-pack-index`.
+	Verify the contents of the MIDX file.
 
 
 EXAMPLES
-- 
2.22.0.rc0

