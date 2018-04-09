Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE261F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDIWpr (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:47025 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeDIWpl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id h69so6609041pfe.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fe+/8wmNe2gkViEXBk3yd2uoCFYXZD+YUOe/dXGQBOQ=;
        b=lTtVmw+B3RccstrrqbWYIKgYddGWcj6lKfYE4afg/f6EIZi+YQPJ2pDJrAISfr1Ce0
         qE6T1MFcPwuJeeVc0xDpIGRaubjPBV+eKuk00evO53Z7fm5SxKOALw5USfYclUCcr059
         Jo1dyTsdhLCrautine7q54O6SmTB42xS+45o08TiXeFzA8GXh3vqBxc2lUEeMzbTDGMH
         FyLCq68LxHtB5nPvTC7CfWv2knV5Trzd7J/GaLTNi84qqtRjDwOGXsNHTEbjrkFYKQyS
         DhPIEaKFn+3nDQPnmyMHuRgQHEaa9wRDcV7VgJKhwGWQJqV6w/K32V+yZi+qHFT8QRUR
         Xw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fe+/8wmNe2gkViEXBk3yd2uoCFYXZD+YUOe/dXGQBOQ=;
        b=nk6KJOcwi0SFBnm7TM05v2D6qwLuMIiyHMPQm0AcAmtqeADpdFlUxHOxwopIszJkSV
         vUvyq3RoGPuAemmhibsKlPaWOlPo9Dkv3fqT9LMkOTwpXx7ml0b4t9g7Bgp1wVAxdBVc
         RpgH/kJC6OuFOBY01DfOz8AhJPY+Xe+aNy3gUM/fbrMbwNwkPk+7sAsdN3Uj+vphJ/sb
         fU+JPUhJrRDKL2KumC74+VUCkFDLragz9j10b9CoCaG6UA3AqccyDaEwCLRt0gNplGGK
         utU/+o25nNnts1FLDVZx+vbd69fIADBQAOPFBdmlQiP35MJh403XRA7I939s28mppOxa
         TxFA==
X-Gm-Message-State: AElRT7FTtGK+QqQ1NRS2arG+mIKHwvLd0G/VFhfL8jSiP3kB2pxdKg+9
        PvgINgaIPweGn1uwrRaeTZyVlg==
X-Google-Smtp-Source: AIpwx49xnzj7NtTUk3nmdmVX6hWaUxOW41X6VAlRU3Glfc4DValSbExp0fK+SpsGUp6NXfEdpbO8cw==
X-Received: by 10.99.110.129 with SMTP id j123mr25910676pgc.65.1523313940729;
        Mon, 09 Apr 2018 15:45:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r70sm2617557pfe.22.2018.04.09.15.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/16] replace_object.c: rename to use dash in file name
Date:   Mon,  9 Apr 2018 15:45:19 -0700
Message-Id: <20180409224533.17764-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
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
index de4b8f0c02..94e0bf47b1 100644
--- a/Makefile
+++ b/Makefile
@@ -871,7 +871,7 @@ LIB_OBJS += refs/packed-backend.o
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

