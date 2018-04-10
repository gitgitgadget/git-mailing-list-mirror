Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C0B1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeDJV0o (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35501 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJV0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id u86so9324151pfd.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DdVWptsHow7dV4hbi9hcm09y5OVybtXHN36OKvl/d+E=;
        b=np+jxsg7snGn1q+BG46c0AbDzZ3WBkMlsIY2IlBa7IChv5uoB4qDFsjKI9CUffn8ST
         VXPPMLcfTjap0hDeg5RrThrMZ9H8qYcaws6OYDpetXRFIqD9AINSXy7q+8OGWK5K+mzb
         SuMTHxX1rXJOpzuctHg4XL8FtN04PgBM1JM9p3rGns3c3znciwMJwW+dCh8Hz3SJxU5P
         FADUN4rqPmvItbkQ197E6d3IUTq5BxsGCYVZZGyVAHZ+WgCR92SlPL5D7o+/JV+e9S7Z
         Q59AeENGLKxr+z3d0dJhxYfxOz8yKznzHB7E+HlFS3I05GRGaNOjHeDservNRd7tGZtn
         5aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DdVWptsHow7dV4hbi9hcm09y5OVybtXHN36OKvl/d+E=;
        b=uRqwbgSlPOYeeWHskCIOa+ttlLuT2qx4mRYiW+lKWTrhfSO8pfJD0n0deAElLi9Mce
         Aq0GldNhzfyNt2Q1riic2ixmHOv9MT+a0B7HuAU11AUDIH8JTDELmnIZW5/kJG8DTHnA
         ox7HdoZzMeXPM/WgD7rOpW+Ccw33T2Cr2LlvrgMwC8z+akltBy8X04M2Yg5gGKwhN1Ft
         XUvKp/EaaqXL+vNunO6HHalqE7dAZ7aP/4bIPOdnN2fLQi+EKQtucxg71iBcTxpmPvBU
         O99s0VHJf/17OS7cQAQBXnRGCFw5yykpGAXbtYkcaPSJg+DFrynJhCsu3IwgRAqJ031P
         g+ew==
X-Gm-Message-State: ALQs6tB0Pn1d7AdHysU3r5VTrpus89qkWRCOnI1Dk95cbZKDX87fb6Zn
        cuzOFZHf0VtomUr/QSlGylC2yQ==
X-Google-Smtp-Source: AIpwx49Je5cxihNZwqUSk6Hhhs0uW383JanI5/th7srGY/MPdeZ6eInTEmUMz6R0M3OOx3zhEfOl3w==
X-Received: by 10.101.83.7 with SMTP id m7mr1433833pgq.1.1523395601526;
        Tue, 10 Apr 2018 14:26:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y14sm8731799pff.81.2018.04.10.14.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 6/6] replace_object.c: rename to use dash in file name
Date:   Tue, 10 Apr 2018 14:26:21 -0700
Message-Id: <20180410212621.259409-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
 <20180410212621.259409-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more consistent with the project style. The majority of
Git's source files use dashes in preference to underscores in their file
names.

Noticed while adding a header corresponding to this file.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                             | 2 +-
 replace_object.c => replace-object.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename replace_object.c => replace-object.c (100%)

diff --git a/Makefile b/Makefile
index d24695f292..6a8168b858 100644
--- a/Makefile
+++ b/Makefile
@@ -885,7 +885,7 @@ LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
-LIB_OBJS += replace_object.o
+LIB_OBJS += replace-object.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
diff --git a/replace_object.c b/replace-object.c
similarity index 100%
rename from replace_object.c
rename to replace-object.c
-- 
2.17.0.484.g0c8726318c-goog

