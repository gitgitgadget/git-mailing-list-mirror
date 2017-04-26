Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A5D207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967073AbdDZTji (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:39:38 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37829 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967071AbdDZTjg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:39:36 -0400
Received: by mail-wm0-f41.google.com with SMTP id m123so14558613wma.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OsykR+sr1a7JuzofTBiheUJjQ9Dg2OsWNdQ0rLmW72I=;
        b=kX3/lphPMLkqJJ/b0CLXp88uFFK03RlhsPXFjpKg+C+aZQpHbar0vQZnlf/CWcSzlm
         Z8tY7tZDfoom+YsPZsgoIbP9+zXdRaXvAoM98QwAC8mhyylXNJGjTR+HRNn4K+Dh1LQd
         ag0Y+OrK0ufCp1kRO/mdgIPnuqOGprEgkoLmjGF2wuAG7ykG9aeXe/6i6QxPhbij6hQd
         YZQrhrqtiZNbZtEaVtCEhtbzuxhYln/eNMsTUwLLVQc5sb/2ODXNMAZ6+VukX0PpMU3q
         bR/lmo/UlSbnTM7dkMGXan2yYoEyPmp8TflJaQwR/MQhReP6KuTr5DFYTMfiv9nDDU5J
         34Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OsykR+sr1a7JuzofTBiheUJjQ9Dg2OsWNdQ0rLmW72I=;
        b=Lt/IQxy+heoKRh56QNtCaA7lABiTM1aa9VFqnxIRgNzIk5myuG07ymOteQ31Vjyqu0
         c3DgtcaIK2SlnBMdPKDjBXQtwNAGVPl5OMziEc7JbVno7MSHR2M0004LUBuE1X2KyW8R
         DMHquiWORoUNs/9BA8HRRian63/W8IQv3sipAqXupvwLI5BPZyY2um1EAinCiywCAuSt
         oZdBz2ef1Y1VyPITIVNvkHqvuh+Ce63tPWXNhgimacsSRDlcHb+qiIoDqa3qe7120b16
         z6GC9wgEcRmp4OJYCA7C8ilYwD7gJ8+O3BOoyU9UNRF2vABz/YT/pOoIyyEejMAWvQzu
         9GJg==
X-Gm-Message-State: AN3rC/72uhDT2OpJDME+j+ynp6kkioHCBbcpjJYlOPlT9e4eUGzmGuxa
        l3VsPrw4DkCrWA==
X-Received: by 10.80.148.123 with SMTP id q56mr2145788eda.58.1493235575527;
        Wed, 26 Apr 2017 12:39:35 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f58sm189671edf.9.2017.04.26.12.39.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:39:34 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de
Subject: [PATCH v1] travis-ci: printf $STATUS as string
Date:   Wed, 26 Apr 2017 21:39:33 +0200
Message-Id: <20170426193933.28961-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the $STATUS variable contains a "%" character then printf will
interpret that as invalid format string. Fix this by formatting $STATUS
as string.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/f08d4dc6a0
    Checkout: git fetch https://github.com/larsxschneider/git travisci/win-fix-v1 && git checkout f08d4dc6a0

 ci/run-windows-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index 4e3a50b60e..e043440799 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -55,7 +55,7 @@ while true
 do
 	LAST_STATUS=$STATUS
 	STATUS=$(gfwci "action=status&buildId=$BUILD_ID")
-	test "$STATUS" = "$LAST_STATUS" || printf "\nStatus: $STATUS "
+	test "$STATUS" = "$LAST_STATUS" || printf "\nStatus: %s " "$STATUS"
 	printf "."
 
 	case "$STATUS" in

base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
-- 
2.12.2

