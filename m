Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF02620989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbcJKAWP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36033 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbcJKAWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:11 -0400
Received: by mail-pa0-f44.google.com with SMTP id ry6so3895051pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kt80NPMUL4H4+y2KmxzDYnBTzrZicxapy5O0exJmj/k=;
        b=RkcMELIBqp1i7d+qtGCRvdyxmBYIEP9eIuQasQwlZpjLI67+A447qpLtwMkEGSKwsD
         AOKqscH5KhYrSNueJrr/PdjxiZrshDhGsiXm2zjSKQ68hQ/4lffpXm68woI9iNMguKFs
         +FGfxcHDboJcriLtt2cjrWJR/xd9V1MvcIy2Ae4pM3u9LxS77bfhgpRAUmGjbTsVd4I2
         nbFtG4c95qBZCrd9COEgFJV4LxpXFC5I1nGDCL5uVrQj9dJwOgVoJ4eJeUC16cInLV+6
         DaJrMJ//HPaBjTEcpHsgQU1bDvAk/Zw+ZG6ZfZogli+tTiiNfmGaWi9+2YPJr47IXIx0
         byYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kt80NPMUL4H4+y2KmxzDYnBTzrZicxapy5O0exJmj/k=;
        b=eX7nU4zgFOuNAFnaZJqByCRwrPk9pGVw8Zuxe1/0woq/NcE8JvaTTFccqdkAR9pJzY
         2wxH3OqDcO3m8Z6XpbLbGr2Ttlcy+K4oMQcsLrABtxxyLoRdJh8bYo4s9KjVegJiexxd
         DXQE+mVC4Ch2WIxwnR6Fy6EWN5RWDE7DjAIThzgA4DIgKE2eKuDLi5d002ssaMHHd1EB
         buLrTAAgK5VKUcYXN2gHqBv6oPcAFvpta6GPrUEHRSvpZu4ZAMbflDbULaVa0tZVCNU/
         sEo/+rYC5iwpIXqUweZNA8KH266BAe3UZmpuohOTi/XVy8Yt/5cVGqdcxXAk8FR9wr+5
         Bzxw==
X-Gm-Message-State: AA6/9Rn1WmjZZYU4m+fprDuuIpL/WN/SEIh1Ks8S3EJL6M5sKDdFVTzKm4PtQdd77GpeHg5W
X-Received: by 10.67.22.230 with SMTP id hv6mr1668683pad.93.1476145331108;
        Mon, 10 Oct 2016 17:22:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id wd7sm547207pab.2.2016.10.10.17.22.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 27/28] attr: make git_check_attr_counted static
Date:   Mon, 10 Oct 2016 17:21:14 -0700
Message-Id: <20161011002115.23312-28-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not used outside the attr code, so let's keep it private.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 attr.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index ea6d5c1..fea0f10 100644
--- a/attr.c
+++ b/attr.c
@@ -892,8 +892,8 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-int git_check_attr_counted(const char *path, int pathlen,
-			   struct git_attr_check *check)
+static int git_check_attr_counted(const char *path, int pathlen,
+				  struct git_attr_check *check)
 {
 	check->finalized = 1;
 	return git_check_attrs(path, pathlen, check);
diff --git a/attr.h b/attr.h
index f85a95f..163fcd6 100644
--- a/attr.h
+++ b/attr.h
@@ -41,7 +41,6 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
-extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.382.ga23ca1b.dirty

