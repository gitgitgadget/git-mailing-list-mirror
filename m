Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01E920229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756324AbcJWJ1W (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36745 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbcJWJ1T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so5232385wmg.3
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUx3YENd6/QuUVuCQV9dILBuKPcFInJ7T7QhUyTVSLw=;
        b=skQNnWJQsFiUwOXvS5aaaC2K0aZhzlJeqaX8s2I4OJkS7G+l60Etul1C9EjTEASlta
         1gRWV7lqkQMhTFA9+Q+QLXrBvQ5fKKXZYrhrCiV2WvMSsDXq5IiZhGt9Q+WBTBpujJ8T
         bMAzC5gSfFap3zyMyG/elLOiv+Wjdcv/id+NvIIjfEROSglhnDIZpqvzMCP1yyAv5dKB
         YQoQNpHXJH7nhMpD/038u+g+z0sCeU7WNq5NbPUoun4u7Z+ByZYJ5PR2od+nO2LNVJRK
         NQfLHyKKBXaRl6wiydXLDHOgFcNFjNMwl2HyLewVLB5avad5PpgL2106j+cxvb48GAbI
         F1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUx3YENd6/QuUVuCQV9dILBuKPcFInJ7T7QhUyTVSLw=;
        b=GDHm7rXsKrIJw76//+3i+D0Mxkd2rUjDC41c89iK+fAMDQrSthMVBPJM2eRmhxYSS2
         RyqBeLDltq7A4Tuj0SaTKvNcmtxxX63zX12qvZR9fWhx81CYtsqlvSavjbzhcWcbhzm/
         nhjeXWJKrq+btwNX6xMhu34S+KC/DIaG5zFuCkbnC+FwXaqLyxIlxpMDgtD03JvKv6Em
         z6rF0uuWVuv7YjGZqnHmS6OypglCQTDfOQTf2pKqI0cKHq66YhqfjRvtzpZdD37Rp/V8
         Bnkitm6LSjnWyMch9zGlMphOOXOV+FbCCjZgKkTx9G9En2G+SEm3CU8KDrtkM/JoZvDr
         IbBw==
X-Gm-Message-State: AA6/9RmhV8AsTMh73K12+fZ3YKrULmrB3q+WTN6XePBaAbYsmrwPpJcoR87aRE640Lv4CA==
X-Received: by 10.28.57.84 with SMTP id g81mr9891213wma.91.1477214838125;
        Sun, 23 Oct 2016 02:27:18 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 07/19] Documentation/config: add information for core.splitIndex
Date:   Sun, 23 Oct 2016 11:26:36 +0200
Message-Id: <20161023092648.12086-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27069ac..96521a4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -331,6 +331,10 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.splitIndex::
+	If true, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. False by default.
+
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
 	index. It will be kept, if this variable is unset or set to
-- 
2.10.1.462.g7e1e03a

