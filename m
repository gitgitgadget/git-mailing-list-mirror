Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E342D1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 06:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFRGpl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 02:45:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45440 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfFRGpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 02:45:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so7053666pfq.12
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BslaF+mayGjuWnY2C4l5U2WgQoDWw8/dmAUHzLppeXE=;
        b=AJjMmtUzl9pEklNDcJbpyl7Kbmn1Xp/+a0uW3lj+dL2lKYh4Gwmu3Ci7ivv+xY6Apu
         pvN40BgC+KfvSuZ4GLqlm/SNJtWGxNOBVPT5OMb44qJxbNfdTWRQPQbkp8kyUESqdOn5
         aSPsaQaapuCpDTxwW7DEv5yeBVmpdfu+78Zbg+sRbzS2hFZI92LXjIINkUlQ3+oo1OCH
         Swl98kF0amHHhdRRTD3YEf/4BC1sXZ5UvvTHz07/wBB+iZckMZMfg5W66My2Zlyx4YTe
         6ZL0eKhZuPjVWf1n+lUgVxpNOMczwuwEoKIQF5R5TaeKw3oUEfYCMffnAi2kuSX4sNQF
         xGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BslaF+mayGjuWnY2C4l5U2WgQoDWw8/dmAUHzLppeXE=;
        b=ejZjyV/qJhe5W+KYZyB91P8/FQxr5m5hRBosCasfD4xUTG3FlKZDHNKLKGbU3D5Nl3
         0wzhVJsmNN9ReO3Z7j0Xcfsx8m+f4ydJf/IXPHg7aZbHJgNENDUCPUrPMDEQkF7zNvXx
         6awJ7zOKiZYi/kBFmOfqiMWrsSdFk6uNID3uJcEzRyfEkbyEEuhLAZveU44/gOx+l1/M
         PMg/k5PY9+azEzwLi+IEwXZ00A9Jc0yLEOrUbdN1i7qNS8hDNs1Z+IgohgIScX52ogz8
         GRTJn/Kkn5H2dnhfPgK8PwRRUxG5zw17hmtlu+xFWzCLwpHDR2hgKyP4HXQOh16bdKEl
         cBXg==
X-Gm-Message-State: APjAAAVevTcI8pvoG/uH72GA2e4oOPPEL4HkUFOrVbmq8cfVksY1LpuI
        VAaeiR1KVyNcrE/frmVhad07dAiq
X-Google-Smtp-Source: APXvYqzFatKzBATbCIPYOBQo9zzUh4KvtY5c0wWm13gkuD+LA220wyxngePnJRCBRyIStUEao8dquA==
X-Received: by 2002:a63:4d05:: with SMTP id a5mr1142071pgb.19.1560840339845;
        Mon, 17 Jun 2019 23:45:39 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d6sm12807784pgv.4.2019.06.17.23.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 23:45:38 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH] xdiff: avoid accidental redefinition of LFS feature in OpenIndiana
Date:   Mon, 17 Jun 2019 23:45:37 -0700
Message-Id: <20190618064537.62369-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

after b46054b374 ("xdiff: use git-compat-util", 2019-04-11), two system
headers added in 2012 to xutils where no longer needed and could conflict
as shown below:

In file included from xdiff/xinclude.h:26:0,
                 from xdiff/xutils.c:25:
./git-compat-util.h:4:0: warning: "_FILE_OFFSET_BITS" redefined
 #define _FILE_OFFSET_BITS 64

In file included from /usr/include/limits.h:37:0,
                 from xdiff/xutils.c:23:
/usr/include/sys/feature_tests.h:231:0: note: this is the location of the previous definition
 #define _FILE_OFFSET_BITS 32

make sure git-compat-util.h is the first header (through xinclude.h)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 xdiff/xutils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 963e1c58b9..cfa6e2220f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -20,13 +20,9 @@
  *
  */
 
-#include <limits.h>
-#include <assert.h>
 #include "xinclude.h"
 
 
-
-
 long xdl_bogosqrt(long n) {
 	long i;
 
-- 
2.22.0

