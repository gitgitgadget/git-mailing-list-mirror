Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93A81FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdBLVyY (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34644 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdBLVyW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so16202895wmi.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNzGxuMKsWSuJYTfmFQgnhHOVsrfrz1Ae22gF+j93/8=;
        b=rcnoN5ecDdX+nWbwqhd8w6yIqP5hmsmEzponXwSjMRdcO7S8qe/qHpJ1YBSozzLZ1H
         awnZSU1JAqyb4TJnsLFVxovtQkiEDfHM846kITydcBdxpfIqeIsw6o4nLZm+JXlIc5OW
         TGqGQkAFCqfIAyCmbQ0zVbmqVbXIzrxnOkWFqIj9ODc9u7saU7b7PuGdr0ItkHBwwhHL
         JkOFw6DPU8iymfhljYNyWaZX7MMqjvO8HPS96a3xnj5C6sZ5Ezwr5JqVoQMAsTTyEUeW
         p7lHhvwmtJ9LDq3k7fZpiiSZllSH1Uy16TsnSvUb7o2K+ZhapCXOv1KHRbgPr1AEobvV
         UrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNzGxuMKsWSuJYTfmFQgnhHOVsrfrz1Ae22gF+j93/8=;
        b=qVLzj78I6LPc08ofE8EWiUYZ1ggnh+9y13nxUFb6YEr3ATj9zvpK9tyNuj2xm53GMu
         Wt+9lzRvszq3/6il+nCJORkWKrGZ4g2q1t9bGdEWZFCa+565Ah/yu2llga3NYAPUkuf7
         1VEBY+KQ4U0OOb7VOq9X1e0Ni7F2Ssaky/3vqKO7JoezKb7k39CK8/ZtuaR3iaMjWbXN
         5siQ5vpO1U7kXyQoCpeaaWjwu1ux7K4r+MQlHF78qBk1ewVF3m6dTmFfkRaSksOwXXZ0
         pf+VqOxwGlwWc2K8dOSVBzl+lFo1bPVQYAgTmqidijEUAHGCcTbGa3L8GNIDn6wwtKVG
         vR4A==
X-Gm-Message-State: AMke39lr659sbDCY+ed3p2y7HyB+wPPZz82h7RTwXMgvMD28K47OoPcH8NFD1mIjbqvzYQ==
X-Received: by 10.28.105.68 with SMTP id e65mr15614332wmc.44.1486936461513;
        Sun, 12 Feb 2017 13:54:21 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b51sm11346172wrd.39.2017.02.12.13.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:20 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 1/7] Documentation/stash: remove mention of git reset --hard
Date:   Sun, 12 Feb 2017 21:54:14 +0000
Message-Id: <20170212215420.16701-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
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
index 2e9cef06e6..2e9e344cd7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -47,8 +47,9 @@ OPTIONS
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
-	Save your local modifications to a new 'stash', and run `git reset
-	--hard` to revert them.  The <message> part is optional and gives
+	Save your local modifications to a new 'stash' and roll them
+	back to HEAD (in the working tree and in the index).
+	The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
 	only <message> does not trigger this action to prevent a misspelled
-- 
2.11.0.301.g86e6ecc671.dirty

