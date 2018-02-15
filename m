Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617131F404
	for <e@80x24.org>; Thu, 15 Feb 2018 00:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032236AbeBOAS3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 19:18:29 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42068 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032127AbeBOAS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 19:18:28 -0500
Received: by mail-pg0-f65.google.com with SMTP id y8so2886662pgr.9
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 16:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5rcO2mAo1jTB6wDW9GA++Zue4KMXsRvA7QBqsXKL9Ig=;
        b=gtIo7trXtk/gh+ijU8k1+0/fabj53oKhTpnMtVU11ajlpXSjjaMAxUJf76Tuti3PmE
         /s8uIgZm0nqll8WiopwuvryxZxUJXZYLLPcLf18M/1DzoYCWhCPi4bfVeCSuPWo/FXac
         er9CBeUFZa/juWykW9Adm5tK2sWs3ide7i4Gz/OZx6yazaBIa3aYrsSccJhGtW78zXDb
         l4HndJ2PMQbNGZNy0ExljTj+olgVES0B0QiourjQEtRry81ZhJvYh+HLDaRPuIijZUXG
         JRZqU0W69EybEsrV2tzqQNCCnPYRcpFNmMUdPgislGjrRtocSZSGeFCPP/7t9l6myFNr
         IprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5rcO2mAo1jTB6wDW9GA++Zue4KMXsRvA7QBqsXKL9Ig=;
        b=OreVkVqQ1lEEFftcm0fR0gSGXEX1dMfpODuaLrI/oO+q/ZoQ5Wwr68wXf5AruyeAA0
         zLKRD2J7klS/SUqhrMBgcLI5ghIyyalw4KV23WY9abL3OQZ6EV6dIb9wXP/a43g9PG96
         fW21d9DXCFbfIsL/9BZ+uyHe1368b1rpZX2xFLYS10LC3Ji4xnf8EqzWfFs1ZTPQRp5u
         wji0Nbzp2MgADAYRaxVNg8vM/3dBPwIrBGsdEulRpXphLbnkRpu4sJe18FV42r5NrYgf
         Q5feK9xaeJHVHh5VS8kUwflMekw1+uJsgG8xwh5GVWvcKWPjU6mVVnMCynyKSENAuSPL
         F0sQ==
X-Gm-Message-State: APf1xPD0Wjw+/4F3jeayiWSlRVG94WpS3cyrxKbz+tQWCwrAtS/gXmUO
        95eUbDxC1m0nRNtfax2jPPZ6YlmmveE=
X-Google-Smtp-Source: AH8x225H3iLYnG7lH/wPR06WDUjJP1lTe+5EStmG7AY8z+oBYe49usgkTfKyfB3Sv2y9FOXlP7IajA==
X-Received: by 10.98.98.194 with SMTP id w185mr791970pfb.9.1518653907678;
        Wed, 14 Feb 2018 16:18:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e18sm29493236pgr.3.2018.02.14.16.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 16:18:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/1] Documentation/git-status: clarify status table for porcelain mode
Date:   Wed, 14 Feb 2018 16:18:12 -0800
Message-Id: <20180215001812.135304-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180215001812.135304-1-sbeller@google.com>
References: <20180215001812.135304-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to have the output ' A' from 'git status --porcelain'
by adding a file using the '--intend-to-add' flag.  Make this clear by
adding the pattern in the table of the documentation.

However the mode 'DM' (deleted in the index, modified in the working tree)
is not possible in the non-merge case in which the file only shows
as 'D ' (and adding it back to the worktree would show an additional line
of an '??' untracked file). It is also not possible in the merge case as
then the mode involves a 'U' on one side of the merge.
Remove that pattern.

Reported-by: Ross Light <light@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-status.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 72bfb87f66..de69035cca 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -184,10 +184,10 @@ in which case `XY` are `!!`.
 
     X          Y     Meaning
     -------------------------------------------------
-              [MD]   not updated
+             [AMD]   not updated
     M        [ MD]   updated in index
     A        [ MD]   added to index
-    D         [ M]   deleted from index
+    D                deleted from index
     R        [ MD]   renamed in index
     C        [ MD]   copied in index
     [MARC]           index and work tree matches
-- 
2.16.1.291.g4437f3f132-goog

