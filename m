Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6991F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeDJV0t (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44599 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeDJV0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id b6-v6so8328462pla.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7GBusqnwbRm/80Xh0JzUdIFgRm+lDQsgLMPYmf5hMo=;
        b=GnQ6m2lVMo5e93GUJPOClXpBuN8RQbmr6vc8DB16UPJXOZ4AqDr3lhrU7PxFsVuqmL
         LXsxg1buPw4zhmX4gw2b29CMbrx+6Bv4crdw/oLoT26CPkDto3Oc3rsqPyfMabAjRxcl
         JROcQ+1RLFPVGO0jYliCb6USdt6kMBvArsJYFFjIhXRBAbsXqu4fAryqEB6IJitV69zE
         eXXgBOxf5OU9ShsotHw0c5H949JEu44OE1FZknMItUHP7BuxChRXsOX3Z6SkVxgceA2H
         oM+V0Hn1NeGTayDQCDoFIbuoGSNTn6SWL6GC8g1GVrnz/zGn1M3vwrL7/GTiu9a+3Mos
         Abig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7GBusqnwbRm/80Xh0JzUdIFgRm+lDQsgLMPYmf5hMo=;
        b=AeqWPpg38G7gQbsHKdK98wDhRm7exop0YPNnebhNZCpGEIu6nlwsnMva/uBpZ7BfYu
         vu/TjPMQKpD/SPobmZWdaH9Z68jck2MjgiUZr4gUKOGpmVqARUdzQIYS77OAhXK2kEve
         bgI0T8KFuf7ttuW1BG7qIXevFaQLu8SU9u3EcWlbGeZl/uu22MrGOcSOkUn75OSG1/a3
         d4P+O3/2HDqpGDGr9wIkf6HYs8ZxeDpcX5GbRX9Lupd5IHX1sVClfqct2FWxp3Vld/JA
         sVweB/X6T1C4J78OHyKt7eQw5R/8aLqlC7mHVd+tdumtoMRYP5a9Yoi0VHaHWelZi1Qt
         cIBA==
X-Gm-Message-State: ALQs6tAc5+fEao4dXs1SsXvMuWaF1bGvHPHvvC71KaBzWLW5kvmoXbox
        Fcv+FubzBj8x8sBFa8Dw50w8RQ==
X-Google-Smtp-Source: AIpwx48Xu6PGjLq5N3tXzXzDV5MGGUD7Pe4FxJA7rHf/HSY93b1r/fUgNJdctE+GMSTudPQYFjDGmw==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6-v6mr2098533plt.201.1523395598696;
        Tue, 10 Apr 2018 14:26:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e190sm7176480pfe.171.2018.04.10.14.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 4/6] sha1_name.c: rename to use dash in file name
Date:   Tue, 10 Apr 2018 14:26:19 -0700
Message-Id: <20180410212621.259409-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
 <20180410212621.259409-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more consistent with the project style. The majority of Git's
source files use dashes in preference to underscores in their file names.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                   | 2 +-
 list-objects-filter.c      | 2 +-
 object.h                   | 2 +-
 sha1_name.c => sha1-name.c | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename sha1_name.c => sha1-name.c (100%)

diff --git a/Makefile b/Makefile
index f608c592b7..a54eef2f23 100644
--- a/Makefile
+++ b/Makefile
@@ -898,7 +898,7 @@ LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_file.o
-LIB_OBJS += sha1_name.o
+LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 0ec83aaf18..247717561f 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -19,7 +19,7 @@
  * in the traversal (until we mark it SEEN).  This is a way to
  * let us silently de-dup calls to show() in the caller.  This
  * is subtly different from the "revision.h:SHOWN" and the
- * "sha1_name.c:ONELINE_SEEN" bits.  And also different from
+ * "sha1-name.c:ONELINE_SEEN" bits.  And also different from
  * the non-de-dup usage in pack-bitmap.c
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
diff --git a/object.h b/object.h
index f13f85b2a9..b8e70e5519 100644
--- a/object.h
+++ b/object.h
@@ -37,7 +37,7 @@ struct object_array {
  * bundle.c:                                        16
  * http-push.c:                                     16-----19
  * commit.c:                                        16-----19
- * sha1_name.c:                                              20
+ * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
  * builtin/fsck.c:           0--3
  * builtin/index-pack.c:                                     2021
diff --git a/sha1_name.c b/sha1-name.c
similarity index 100%
rename from sha1_name.c
rename to sha1-name.c
-- 
2.17.0.484.g0c8726318c-goog

