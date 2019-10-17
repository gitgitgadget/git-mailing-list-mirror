Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96ACF1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441779AbfJQXRV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33919 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441771AbfJQXRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id k20so2241303pgi.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ugMYQrLw1Kp1XsUyLvz+R5QNwZ/zrm56Jgw5EJjJoT8=;
        b=QDnweGUUJNKazGyeBnAHqKCQwEzJfJDhWrUWfJ9Y2gFlnZDTmzhwoPOqdOsWNgNlsq
         TZ/6pRxbf6H3fuvIva6fyQqFo3vBgj14Gs+Mq+RrqRtceF2Sd4ikrT+CVwAqsXH2f/1V
         OoaXZBBWQrSPNJ4UhN//oV/c06SlA3URMs42AfPPu6rDscbT/e71Fr7SmvPKzkJCLCks
         8FhC96WnkJ2X3XSahT81/Q5OZ5stfBRP0fE1V4+swqPapWvilpQCh/B2jCoxbTvsfq5e
         Fz8o+GYOaPi41rLnJXJxScpNj4dPVufW/3K3lhH+vdDNA7FM6ga5opc6cPGSJuvyChg0
         eGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugMYQrLw1Kp1XsUyLvz+R5QNwZ/zrm56Jgw5EJjJoT8=;
        b=D0pTBnCH30ku6smWV9SApINkOvXddLI92Jf8hdfEtyw2TrISdi/n6H0PHSezBUPcJk
         bJ6pViAb7CdifiNhQdNwEaIQ62GjsYMQeiMqvNhE82LzLIrOrbqCkN7ppx6waEsTu0au
         NiQIwLUClgJ1zLLvGsrWeAvsuT+1lPt9QzzY55Si4Z27zxTtkR6JASthZmawMthVYNwi
         M1bexfnzE+Cn2O75e5dvtbx2RydTwBYr7w28NMpwYcNuTN57H1lN0SaLGHdU5TkTb+wt
         rA2WkGHxIAaxukuU2B3NusYlcdy7YoHUoZ58g/0RUrG2Tp8qvLwCrIqlB1rsm+fCg6F7
         C2IQ==
X-Gm-Message-State: APjAAAW9yqYuLp92z37yzDbPKB6J/kydkO9w80YE3pSy/hiHtYbCiCg1
        zZyFXN+uddEMZrUk4h2GT/Hu6IVK
X-Google-Smtp-Source: APXvYqyoYL2sWCM4ijKjoHQoYdt2FQ4fhrhiCBxhq5HE+en1IW4TouORzkP1nucahVWvzXnW8Nhkkw==
X-Received: by 2002:a63:778f:: with SMTP id s137mr6734009pgc.147.1571354238151;
        Thu, 17 Oct 2019 16:17:18 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id i11sm3474685pgd.7.2019.10.17.16.17.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:17 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:16 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 10/12] t5520: don't put git in upstream of pipe
Message-ID: <148d05cacda5fcfe686e787a6ed180c48239a21a.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, if the invocation of git failed, it would be masked by the pipe
since only the return code of the last element of a pipe is used.
Rewrite the test to put the Git command on its own line so its return
code is not masked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0eebab7d86..e611d414c8 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -668,7 +668,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 	(
 		cd corrupt &&
 		test_commit one &&
-		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		git rev-parse --verify HEAD >head &&
+		obj=$(sed "s#^..#&/#" head) &&
 		rm -f .git/objects/$obj &&
 		test_must_fail git pull --rebase
 	)
-- 
2.23.0.897.g0a19638b1e

