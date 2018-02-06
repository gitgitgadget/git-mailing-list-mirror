Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88001F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBFA2H (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:28:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35320 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFA2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:28:05 -0500
Received: by mail-pg0-f66.google.com with SMTP id o13so186447pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gyEndFQ7feryObj+Ln0kuQopCOZ4FTAvTtXGawMpOk0=;
        b=lLgQydZTXmGHAprJhrHOKJEZdqxMsWmYHWKaQ0pNPFwLWFVzohacvuey/jAEGWBswH
         JxMHtCjK6DEOdFt0Y/LcLW92ElUrl5yqWmq/UeCN7f0/Wi7VqShVQ1V4H0Ie8JMCPzIO
         vLmN1BI0jCyviFuQFIdxebLTvsQVsqQIFGbVtaGZNZGcFmXvefWGmUxZeHSbUkXFw/Y4
         0bHbKZ5c7RcOEn2XBIGRshtm6+MP3vQhjP4tytgb6BcwuWEDi1Kqc9P9WErMpfeNdkla
         rSiYjf07x4L/euZnRRB7lg8OvJIQJo51y2tYq7L098Fk2fC2CMtWOh96yWrrx1XSbIfg
         HccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gyEndFQ7feryObj+Ln0kuQopCOZ4FTAvTtXGawMpOk0=;
        b=eQ8d7AD1cdwg7+PbRjcErBOo0+bbCrjXK6+BUA4FIR56M1tN7DvLu26oPPPvBHxcLc
         KoB5O1HK/JyES9AfrXqIuDh8TUO6CPbqvtKxHfj08bysPOxxJfWPccqjGV3PX2GEps33
         QDuKqW09pzlTjYNbeTNN/Pu7s6qDB8r7vZfrQnBY9bZo5mf56z5CRxNqfsWd88pebiR2
         9SLoExd4jJYsI7kVVxf3C4hazXtclXMrQZaLqQEQsNcaa+VwVRca0yMhnWFyzN8lJpAS
         0KbyaIIOkyIRXCwgI3hQAtKJsnlmjfkEKLDpdY1mB9f27k7MbJHJ/Dtar+bkpYjM7Q6H
         3CMA==
X-Gm-Message-State: APf1xPAeddjA+PDneCue9RyjOxarGornPYYENPDKAPD6uGb9G7rGWjVf
        lI+EvFnI0jMw1wzD42IxjlatSFx/mC4=
X-Google-Smtp-Source: AH8x225hDTjpJKmRD3P9tAUxIpOyRK1FbHvdXf8wDRXD1CinNwRt+362QLVi9Soip9VM0clQQQIXrw==
X-Received: by 10.98.22.65 with SMTP id 62mr536985pfw.211.1517876885069;
        Mon, 05 Feb 2018 16:28:05 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f78sm18636067pfk.144.2018.02.05.16.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:28:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 162/194] commit: add repository argument to get_merge_bases_many_0
Date:   Mon,  5 Feb 2018 16:17:17 -0800
Message-Id: <20180206001749.218943-64-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index bd9049a9df..a4f35cd9fc 100644
--- a/commit.c
+++ b/commit.c
@@ -969,7 +969,8 @@ static int remove_redundant(struct commit **array, int cnt)
 	return filled;
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
+#define get_merge_bases_many_0(r, o, n, t, c) get_merge_bases_many_0_##r(o, n, t, c)
+static struct commit_list *get_merge_bases_many_0_the_repository(struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -1014,19 +1015,19 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
 }
 
 struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 					       int n,
 					       struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
 
 /*
-- 
2.15.1.433.g936d1b9894.dirty

