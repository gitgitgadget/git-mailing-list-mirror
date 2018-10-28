Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6921F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJ1Pfx (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41546 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1Pfx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id u21-v6so4782683lja.8
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsUCEerIDkz++nJaJwoscgK7BeH1ybm/fBUjis/LA5U=;
        b=gx6dhFfBFoD0PX6iRPCJvWxtTGUN/pN7B9j1Y/5h/zmT7VmSu6YG8POAAoT16VZya5
         aafCMu+j6/yHH5NV8MBqMRzALKy966k+7mavh5BiS7K3HR0Oti3hTp2lIpAEk5CDkW89
         7H7uufXZgt9z7Ul8AJpOA7jFVMh1OALLQL4ElQxev+ZPFzz8Fp9gKTK3hCTojzabcg0Y
         QTlW9rBYkmcjMS9WNSUWsMDFMu5Gc9P0er5qCxTe8KIkvPo8/7C0j8WbaLRgBG6w/S/l
         lfq3GaqWByByyZ7tMUG/bjBlY5X0Xbr8TgOILHyFEr7R/pdegggyDEKsCVaxmwdajzmm
         nutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsUCEerIDkz++nJaJwoscgK7BeH1ybm/fBUjis/LA5U=;
        b=LH+6njlrnccoRO4YZwbun5UonrI/pjV3FiAdLsbn8TsHypOwQbu+CsjhZRTGVZRQhP
         36Ixca6M65/fgWgsqvRBcYcCbWTCtSAafPdbeg1kSpcKmLTfTU8Bx3FZ0RUrcDJVOmS2
         gm1VWhplbHeOp1DJbSEEGQYST6DFYLRitUqGiiW78uTa5NDOVvTPZoQCVT0uk3uFsd7V
         mR8rqqbg5m4NZuC6fwftA6ReZ9mMXdC8F7XHRfaxNyWkq4PuOtz0mVtQA2qlaQ1IXVkq
         Ul0M7T5stJtkrkcFcvPBR7BhTtlkieT1yd/MtPk8+ozKwiSFgehTrr8bBX30L1ta6nVd
         z54A==
X-Gm-Message-State: AGRZ1gJSRskDehVAlq+ZfZD3K5m9LqX1y3tqRUrzScS4IdCg3PzvuWO5
        QxgMDVxYIbe7SI3riWQyaIq3Kvox
X-Google-Smtp-Source: AJdET5f3TvFqkSJ7GVdfvtxoAjAZVmGSTkU9Aw0DJ0OoXtGfGtgXJVmrelMqLPsyoJcG5cMoD8YUbA==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr3374324lji.34.1540709528860;
        Sat, 27 Oct 2018 23:52:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/12] read-cache.c: add missing colon separators
Date:   Sun, 28 Oct 2018 07:51:51 +0100
Message-Id: <20181028065157.26727-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

typechange_fmt and added_fmt should have a colon before "needs
update". Align the statements to make it easier to read and see. Also
drop the unnecessary ().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5083cd8333..02a49e957d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1492,11 +1492,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 						  istate->cache_nr);
 
 	trace_performance_enter();
-	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
-	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
-	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
-	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
-	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
+	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
+	deleted_fmt    = in_porcelain ? "D\t%s\n" : "%s: needs update\n";
+	typechange_fmt = in_porcelain ? "T\t%s\n" : "%s: needs update\n";
+	added_fmt      = in_porcelain ? "A\t%s\n" : "%s: needs update\n";
+	unmerged_fmt   = in_porcelain ? "U\t%s\n" : "%s: needs merge\n";
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
-- 
2.19.1.647.g708186aaf9

