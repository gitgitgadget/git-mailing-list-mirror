Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9931F453
	for <e@80x24.org>; Sun, 21 Oct 2018 16:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJVAtM (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 20:49:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37654 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJVAtM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 20:49:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so1020931wrq.4
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAKldO0n3u/BcFGrg3p3pAObsH+ZGQcF8mJFJmMpLaM=;
        b=Bl5QSfDj2pyQvc1uqP/+szRBYV2wjpjmcFAkH4cLDcbz0q6KxHJnQuOHhT3cBXpgX8
         qg20pE0L1rvoJ9s3AinDIQy6WnmjKyPnpprBcafUdQHiQqRJjeehTb6FtzRv/rgonjLR
         13V34GVatDsYvSRpGBJqfW/QMMYBM9RIvV6szL9woRXwhGv3tM3qQ8bgXy7Yox/fDHcy
         KCVjkzkL//sCQYkd0EAhBCp4yrdG8qnaih/Zx7a8XT5hqG/icTErjTxaZ1C0A0JKklzj
         pA7boJ8drtrDNM2Zf91HV+kLY0rMSaCY9L0UpbK6/MNDq2dskZtiWn5BSJaNqUB1DexS
         +amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAKldO0n3u/BcFGrg3p3pAObsH+ZGQcF8mJFJmMpLaM=;
        b=Tb5UMK6ZaMzW+QCQWJsImWXVZE0rmUt51K63Welc0jICig9FSI6ABfD7CyzSRbB52Y
         V+7LpJVEY4vnSbrpJzORD6h7xyPWu4UlrweTFb/P5OI8FhIsPW42FI1gWuEg7gV1iUiQ
         Ngl/KkJFtNUkkDtxKewnEOfjZ0ZFn3xmetsKmJf6DH39q/aka0hHq/8lKKZcaSvcrUti
         Km3qwbuRAUX5vCvMMosQ8u6UkJ9TvzxJRG26r4FOYlKe85+KhTi/bm2ge9lEYHC5B1Ds
         R+ozWJc9qEuGggYdUrpq2361uvvChIX1qIsIdPTwxeaCVgoxfoEdYT8Ae+jsprt7pdV6
         G2iA==
X-Gm-Message-State: AGRZ1gJ2uaBW/kggHr5+3lCgDWpHh/ouP7L3B8YTII2DMJrTwRvT2BUT
        epFd6gJ7OG16HWsT5PJpm047sie7QTk=
X-Google-Smtp-Source: AJdET5dDkdTE3n4nrujaON9tvEoxHHrYM2NtB5RS3EW9tVb9fkdTVhqOibozw7StIErGhENI9LwWTA==
X-Received: by 2002:adf:ec86:: with SMTP id z6-v6mr10979927wrn.45.1540139659172;
        Sun, 21 Oct 2018 09:34:19 -0700 (PDT)
Received: from xps13.fritz.box (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id i7-v6sm12168990wmd.41.2018.10.21.09.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 09:34:18 -0700 (PDT)
From:   Dummy Name <gabriele.mzt@gmail.com>
X-Google-Original-From: Dummy Name <dummy@example.com>
To:     git@vger.kernel.org
Cc:     paulus@ozlabs.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] gitk: Do not mistake unchanged lines with submodule changes
Date:   Sun, 21 Oct 2018 18:34:01 +0200
Message-Id: <20181021163401.4458-1-dummy@example.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Unchanged lines are prefixed with a white-space, thus unchanged lines
starting with either " <" or " >" are mistaken for submodule changes.
Check if a line starts with either "  <" or "  >" only if we listing
the changes of a submodule.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..dd4bbbf 100755
--- a/gitk
+++ b/gitk
@@ -8191,11 +8191,11 @@ proc parseblobdiffline {ids line} {
 	} else {
 	    $ctext insert end "$line\n" filesep
 	}
-    } elseif {![string compare -length 3 "  >" $line]} {
+    } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  >" $line]} {
 	set $currdiffsubmod ""
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" dresult
-    } elseif {![string compare -length 3 "  <" $line]} {
+    } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  <" $line]} {
 	set $currdiffsubmod ""
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" d0
-- 
2.19.1

