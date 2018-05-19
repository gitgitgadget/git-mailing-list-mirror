Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CAFA1F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeESF3A (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:29:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41982 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeESF2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id m17-v6so16869918lfj.8
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hbxnGD9b39hFxwPdTQJYw8GDnqDZJp0OMmDsjV7i01g=;
        b=DZQdgjowTwj/ibM4FChrF1FdiyIhhbSMDVL8iuAh1lryumskik1TcUYpXhkgZixgoM
         N2zmDD8oItESeVGBCSiHeBVY0X6I/T1Wvnj1HkCVTh2O9IGQiPtP8hBVxJnJdkAq70qy
         Fl+JRbDsCoH6mnPL6BVKlK5pyoJtnEzXh3/1qdzTP3kWFhn7SMp8bZuE0+9W5lBjoJEa
         Dxo/gq5/LPClJ3KRdbnk2xOwFEPFY6r7Rc9dxV3UoaNEVtcBaDCCCu195TIw6ASNMUA3
         D9SX6ReM9jYPqThbaPYPy380eQjDtJ/9wYKygk2ILJnrGPGnW4aAsC4+svJGjXO1KSew
         NWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hbxnGD9b39hFxwPdTQJYw8GDnqDZJp0OMmDsjV7i01g=;
        b=L131+R1GBPR3mRHXLEvY5WWl6G+B/8MwHzZ02JFhUnQ06vaCidUAGcAWYLP0blPRlR
         j+f2hqNoo504GmH7DNP9uLYKFA2LMTUbFw+MBv96CCFM9IWXKJ+RRLcH9YK6lvpPHYKZ
         pEOb0gFtihjOefPo2Pp1Hb/aKU534S1bYPpI3w5Ph/URyVETmnqjRlGSTL9TyPHizbqa
         6be69hPpD0ngz8BKRn60rRLM4ZXzoufGrEaheM2zOsrGswh8jBz3ws0eH4DrWGI3a9p2
         kVdcJ3/3alnhT3B6r3/9eJMJmHonxNpnXmy0ILniuf3CJ0Ap+g5fnEm2tPUG0b0JTp1Q
         Uxig==
X-Gm-Message-State: ALKqPwcqIX+BvAZNj0+CL5ATsyiKdHc43cFUhfEh7N91ETDjgw1SszRS
        /3LYoSnNZM9FGir9USfvZ4U=
X-Google-Smtp-Source: AB8JxZo6SsyzoroLTJWz9/xfeFnn1CQKiJn80H1IQUVqjCuD/xyBKDHyo+Yb7hevl9t+wUucVaahuQ==
X-Received: by 2002:a19:5c9b:: with SMTP id u27-v6mr18035710lfi.138.1526707731803;
        Fri, 18 May 2018 22:28:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 15/15] commit.h: delete 'util' field in struct commit
Date:   Sat, 19 May 2018 07:28:31 +0200
Message-Id: <20180519052831.12603-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have come this far, you probably have seen that this 'util'
pointer is used for many different purposes. Some are not even
contained in a command code, but buried deep in common code with no
clue who will use it and how.

The move to using commit-slab gives us a much better picture of how
some piece of data is associated with a commit and what for. Since
nobody uses 'util' pointer anymore, we can retire so that nobody will
abuse it again. commit-slab will be the way forward for associating
data to a commit.

As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
architecture) which should help reduce memory usage for reachability
test a bit. This is also what commit-slab is invented for [1].

[1] 96c4f4a370 (commit: allow associating auxiliary info on-demand -
2013-04-09)
---
 commit.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 838f6a6b26..4432458367 100644
--- a/commit.h
+++ b/commit.h
@@ -16,9 +16,13 @@ struct commit_list {
 	struct commit_list *next;
 };
 
+/*
+ * The size of this struct matters in full repo walk operations like
+ * 'git clone' or 'git gc'. Consider using commit-slab to attach data
+ * to a commit instead of adding new fields here.
+ */
 struct commit {
 	struct object object;
-	void *util;
 	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
-- 
2.17.0.705.g3525833791

