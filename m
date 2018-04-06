Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E011F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDFXVx (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:21:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39213 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeDFXVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id c78so1789544pfj.6
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwRMtcLWuw7Up+yPlDfZONq/K+mysiH8MTIrGFb99mg=;
        b=vdjz9/mMByTu3QEZgSjUn1rZ2PBH05t9TVchrEMGSDMbHFFnW8f3xmnKhxK1W4c3ym
         Nt6QIGIXEBV4hauEXD4OnXWdKZoao09jN3nKxrZzwOWajxH0Z17kFqPoUOD2DATy8qsX
         reyp5XpFXrf6f3GAC29CwQP57F2/vvgGoKs02Ti47NZhqasPo7wKpMtMZuR7tTKIXr+K
         o6pg6k0omKBAobSwCF4JU3G/nt0Zzmv5nmDn722HsZQ+FAhIJQNtQXHY0R1RG6YtVqW/
         +osVvDKntBRgVeInmWjhYwrNMaTmAe0A2glysZFV7eH7i9W8Sz87Ftj7VBR1sKNxm66F
         YynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rwRMtcLWuw7Up+yPlDfZONq/K+mysiH8MTIrGFb99mg=;
        b=QY/DWsabzTeNLP/3r3kThAA2Q33nnGmAQw8xdN/X3P/FPscNQ+wuNiJhj+s+si5fE8
         sqZp3hy3LbionBjLjfX2Bg5PyeGAQsifsucVQTUdEzKeJs5aAD2jLJZmNPOmEmkZhKlw
         XT0WD8xhfRdVeyXTyqHwzI99IOmuWKkF6zmLDVQSHmqwRzYgD7oJrEalslmCvZLx9cNR
         hG2gu6IUH3jtRqK3DAwcXhpaLby/N+EXSImkc0RvG4NEod8iw5727yx3xgT4OMEEKBnD
         osonStGMZDCX21C/qihfHno9DiXhOKu5NwZuw1lhWv364dY+IP2913eVGeS6qyybtOLN
         Qf1w==
X-Gm-Message-State: AElRT7G8wmf/mdwPmf6jUUCiQKmML8PIx8vlkGq19Ff53vAhsEWD9/JK
        TEeDW7Eyd9W8VdHdplazBYFGHw==
X-Google-Smtp-Source: AIpwx4+8HrHTcMrURISTLJ8kf6V38Mb1HuRQ+QBO05aBdAry9wM6aaajOlYSmePmEafv1AHkZ/Kldg==
X-Received: by 10.99.114.1 with SMTP id n1mr18932660pgc.107.1523056911256;
        Fri, 06 Apr 2018 16:21:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d199sm20978626pfd.95.2018.04.06.16.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/19] replace_object.c: rename to use dash in file name
Date:   Fri,  6 Apr 2018 16:21:18 -0700
Message-Id: <20180406232136.253950-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
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
index 5bcd83ddf3..e345e9e75d 100644
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

