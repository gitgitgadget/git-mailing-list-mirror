Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C731FAD5
	for <e@80x24.org>; Sun, 29 Jan 2017 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdA2UZF (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 15:25:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36566 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdA2UYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 15:24:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1321751wmd.3
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=os8dcUmoC6Zi5kNjhq4KVpKvYlJkStE1pln1Y//KUBk=;
        b=CCthMVgot7ja7TVGpCEBI/f4+gzWVg7MK5xea88yV+nAAosldWbZXqIG/1nvK1A+CR
         I2euqI4aSVlzwGKeYXEczz5xHRdHGVTwFyGTNRygNDuQZmJkQqsoCoE01KErMDLrjYN2
         L4J31CPA/TdRtWKmw2Fe36tyWpSHMTqvg6lbNj6L1llxD5vGtnkidYOiIBuXAVnfD0/f
         ARZv+SVtFE379mYiRH1Rc5o1upktPiRsWOiQk/tix5NHgJ2Vu/LnRV3ymH8tQL8uWeCw
         frpfTwCHnD0NDpv7GGhD6vuMxp0jnA8+SNZ/gVAp/iwyOCLMxaYjVjDisDZ14SZiG3op
         jT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=os8dcUmoC6Zi5kNjhq4KVpKvYlJkStE1pln1Y//KUBk=;
        b=uiDgMReaou4hYXIhIPQLwBlfOibiTo7OIp+wKVarFP1YfFh7pDa40SzeaNVrnxqvP6
         v6QVMTm1JUdZGpeb1qIppWv3mPITIHGYdKcIqcy6TO9AR8DXSAfbrzfePpIVUx8M6/68
         Roj+W+wyGXIMk5Qaegf+bMFLsDJiVUlXBVqI0E/JEPiElPXjs1NCmmk4fbMZbUCdlwFq
         ukfyfdFqBHBoPfBA/iY7qgGYLcl1N/dgVhQIGr7yavTlbWtddGAqLftL8sAVPbtVmsul
         /E52sLdhO3tvpKlEfyMvVKWneP7zZf2/RLtcAe0Q2Fc6BiDz1q+GjPrkF64vh0fyA7VH
         rmZA==
X-Gm-Message-State: AIkVDXKYxeKsvRTpc19rTPI8tsxeskBU0S3jqnXHFqoacVs1kYaA4ppfnIeIzHAF6hzRBg==
X-Received: by 10.223.136.197 with SMTP id g5mr15382905wrg.56.1485720951285;
        Sun, 29 Jan 2017 12:15:51 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id x69sm15211765wma.15.2017.01.29.12.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 12:15:50 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/4] Documentation/stash: remove mention of git reset --hard
Date:   Sun, 29 Jan 2017 20:16:01 +0000
Message-Id: <20170129201604.30445-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.297.g9a2118ac0b.dirty
In-Reply-To: <20170129201604.30445-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't mention git reset --hard in the documentation for git stash save.
It's an implementation detail that doesn't matter to the end user and
thus shouldn't be exposed to them.  In addition it's not quite true for
git stash -p, and will not be true when a filename argument to limit the
stash to a few files is introduced.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9cef06e6..0fc23c25ee 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -47,8 +47,9 @@ OPTIONS
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
-	Save your local modifications to a new 'stash', and run `git reset
-	--hard` to revert them.  The <message> part is optional and gives
+	Save your local modifications to a new 'stash' and roll them
+	back both in the working tree and in the index.
+	The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
 	only <message> does not trigger this action to prevent a misspelled
-- 
2.11.0.297.g9a2118ac0b.dirty

