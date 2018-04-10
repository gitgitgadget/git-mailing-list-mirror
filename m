Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90551F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeDJV0m (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38143 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJV0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id c7-v6so5084630plr.5
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKx8ITiQ8QPSWPaCFGdBydYuQG2UtmcVDFWfUKgjeOA=;
        b=VcKGJ8/rtyZmCfBbwwxVWJI5utUGReWCz4aPwmUPBNFmGAu10uCSOqikQDcVUYLyqB
         +AOT93zl/NlYR+q5xf39LSqjLXrk+JEvejP40HlqzV/dt8sJCLsXeFpzv4X08WLHmQYZ
         WJkCipIP9kSKq8STj7uAVqf2JJm2d8APpnfjDF7LcEPh0TK2MBLvDxABpBLz30Hi//4o
         9ybVln5Aa68A7tleT3ZiOozFk9c/bEpTj6e/TE1qHBAiNMha1C7TnJKJB2J2aYSO9MhW
         TuH+GQBO4cDbBPnSoARPwKDp+cvAUyCsge/+PwAN4Rog5IZJW4iCir27QO362tfb3HMu
         vexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKx8ITiQ8QPSWPaCFGdBydYuQG2UtmcVDFWfUKgjeOA=;
        b=I7Izcted+7mMv7WwvWRb1u41Hc0Vg7voHgidfSAGnRZSHkLk80Mf8viipK5fKmpj46
         +b+iBaUEivZ7zT1EDCpBu5kUlhc23fyz3kt4URwHmj2AYSg/JZvxtdZcDIbchO7pIjI1
         nKTK43eLN9PExv8SLzz3087/Wczh8OtyTLWiTdIfzv6D5UTB0BmD7olJagV7xME3dkHU
         qjVPy/C+QCfe6YOg9Mxlt1+OwbnrV50etaI/rGOPinqc/oxPa5v7Avkd3/kdax6T2EQw
         jlqcy/KpC6A2ZHAjfT70di6M2YbabAvMcB2iDVr58D8ojvJumowopCXB3xcOFB+UZsPd
         6WQg==
X-Gm-Message-State: ALQs6tBwW733gskrJtyBbw8Qnk55/XqtGP1eD/LDtwLMgcR4+84F6RBM
        aWMj3zbdYXH6wRA3MgmCw1BrFg==
X-Google-Smtp-Source: AIpwx487HkFko1tjl8Hc3ZMGfI+f1aMaYqVHGBxTltTLFsniUZONRz3sFRWWUEKhN5RKz5OChaI1hA==
X-Received: by 2002:a17:902:149:: with SMTP id 67-v6mr2149119plb.296.1523395600015;
        Tue, 10 Apr 2018 14:26:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t25sm7452421pfk.69.2018.04.10.14.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 5/6] sha1_file.c: rename to use dash in file name
Date:   Tue, 10 Apr 2018 14:26:20 -0700
Message-Id: <20180410212621.259409-6-sbeller@google.com>
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
 Documentation/technical/api-object-access.txt | 2 +-
 Makefile                                      | 2 +-
 builtin/index-pack.c                          | 2 +-
 sha1_file.c => sha1-file.c                    | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename sha1_file.c => sha1-file.c (100%)

diff --git a/Documentation/technical/api-object-access.txt b/Documentation/technical/api-object-access.txt
index a1162e5bcd..5b29622d00 100644
--- a/Documentation/technical/api-object-access.txt
+++ b/Documentation/technical/api-object-access.txt
@@ -1,7 +1,7 @@
 object access API
 =================
 
-Talk about <sha1_file.c> and <object.h> family, things like
+Talk about <sha1-file.c> and <object.h> family, things like
 
 * read_sha1_file()
 * read_object_with_reference()
diff --git a/Makefile b/Makefile
index a54eef2f23..d24695f292 100644
--- a/Makefile
+++ b/Makefile
@@ -897,7 +897,7 @@ LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
-LIB_OBJS += sha1_file.o
+LIB_OBJS += sha1-file.o
 LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e89c039b56..a9b0fefc94 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1592,7 +1592,7 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	/*
 	 * Get rid of the idx file as we do not need it anymore.
 	 * NEEDSWORK: extract this bit from free_pack_by_name() in
-	 * sha1_file.c, perhaps?  It shouldn't matter very much as we
+	 * sha1-file.c, perhaps?  It shouldn't matter very much as we
 	 * know we haven't installed this pack (hence we never have
 	 * read anything from it).
 	 */
diff --git a/sha1_file.c b/sha1-file.c
similarity index 100%
rename from sha1_file.c
rename to sha1-file.c
-- 
2.17.0.484.g0c8726318c-goog

