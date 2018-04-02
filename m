Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137361F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbeDBWtM (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40015 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbeDBWtH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id x4-v6so6119212pln.7
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aspRxvq9eTZiAILwfZhGs/Kg0ZhA+3uMJus3XYZHSWA=;
        b=QdCypyyj9PgcS85u7HsizQMgiuEpusJZgagjc3nTsrx6N1GH0jGwWOBV0Ry0GG+bcr
         qApA0Fq0mWIPKlS/x4mQtIefG482fLV9iLjEr+hIqo+XTHPhdU1KtmTgZsVznGNnGfS7
         HbifAgicdcBv4xCXKK/5hPPIJ+2UHP4uyhgMm7uvJxqm2O2iCGhmfNlW63cF9YYEzK2f
         kpohmABfIRVc+fiadC7Q3IS8L8GvDhrC5e18bfAIwPNHNvdKf1AY+Gd+wLkRKhv2iPUe
         3c094oCOA7q94Vv/mRtOPZCM3PaCb9E/pE8xRHMH7cAmV51UQXlCPKb70OkjsvmwyRMN
         usHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aspRxvq9eTZiAILwfZhGs/Kg0ZhA+3uMJus3XYZHSWA=;
        b=MRlu5hEuZR0uJ88j7NSCV0bO+g2tzRh4MuTr26p4sBtahCkJonEBmU4QCxtWBz8eTf
         /6ZH9HwMC0HiN+NQKRm2l3K/u/dcRIQq4dmqiQsF1ldLKSASPMqp3BEkNczz7XlaW1OZ
         WBnrpVC01GkDj3IZN2NSPCPC/jv/Oj2rbkHtzRZqJeT76NHJs5xhZOfaxeFkMoHHI9/E
         qZVKBJL6Qq8SzE8YqvXgaQiR+BKqtjQDb2uH8xU2JnygIQEtXFvyuztp22QA5F9eQ2lR
         xZKD6xX1yBhN94n4qyHWiYF7gITCCWv1Zdu3ze+47J0faXQ4jECKjNOT7OMKnGJZN8lJ
         P53Q==
X-Gm-Message-State: AElRT7FnqerA5EhKlSYDi4N/Db93RO/lPyOWWOn8cBk1h8mQAFNurHQo
        pmgLLFgOzq7ATlIsCmS/iLcPVWHP0ng=
X-Google-Smtp-Source: AIpwx4+B7bePmFk52CeqFt0u1zoV37LfblAM53BywF147XBvT7p/l3tJr34bipkkZGpT/fScE74xPg==
X-Received: by 2002:a17:902:bd91:: with SMTP id q17-v6mr9719984pls.330.1522709346558;
        Mon, 02 Apr 2018 15:49:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y15sm2222388pfb.37.2018.04.02.15.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] xdiff/xdiff.h: remove unused flags
Date:   Mon,  2 Apr 2018 15:48:48 -0700
Message-Id: <20180402224854.86922-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These flags were there since the beginning (3443546f6e (Use a *real*
built-in diff generator, 2006-03-24), but were never used. Remove them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c1937a2911..2356da5f78 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -52,14 +52,6 @@ extern "C" {
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
-#define XDL_MMB_READONLY (1 << 0)
-
-#define XDL_MMF_ATOMIC (1 << 0)
-
-#define XDL_BDOP_INS 1
-#define XDL_BDOP_CPY 2
-#define XDL_BDOP_INSB 3
-
 /* merge simplification levels */
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
-- 
2.17.0.484.g0c8726318c-goog

