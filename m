Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECB21F453
	for <e@80x24.org>; Fri, 22 Feb 2019 11:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBVL2I (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 06:28:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36965 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVL2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 06:28:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so1021143pgq.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 03:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dr+6LrWOlKq1ONwr70jWSyPIVEh7Tb3g0XfCeqnZhXE=;
        b=EQHjqMGwXyR8WnmMIsz44CqnuETs4tJiMgGOT+jh94CJB5LJHcS8JuUi0DyzneumGi
         F/qkYR95dq9n9G4RTpIvCfJS2MLBgrQ2IZHhPL6uGMRZNEb+0ZfxKZdsd9oEjepgWrYK
         5mDSjX13gjt1OvX3TQO0w2SM8EVkL0YriG9MB6d+ZQLNSPkFUeqDhahBQFpHy7+BlyVw
         E4bFiumPZnCuIwD/wpnbAaCpDr8rNGOTVpI3BYNYnGYRmXurYoM1cszijmPzuaWFXBJi
         6x1pVjODN3EeQcmd+nWFerhdeiAOENup9V8kvPKatq4AAumrVfBIhNuZHfgdblLaFOlj
         +XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dr+6LrWOlKq1ONwr70jWSyPIVEh7Tb3g0XfCeqnZhXE=;
        b=SvY46rLJg7K2Eq7bJU7J75NyEVBHYhIKxiJVtYk+X8mtT2/eipBVfIjBQt0cnM9c+K
         dKk5jRq9Xj6jn+8HvZqxA92TsoX+PEYQ3TpMkEcY0BfCfrnnPKowQoMVNSlxhwJYyIzZ
         nZZD752QI/z1Gsc2l7E2L+B2N+pCzYXo7EDCd11tmNKm7l81ZAq8kAsnh86WaQYPWx58
         NYU3E+lZNjswzu8HBJX0EhJUt3Zm+7vDyyCEES7FL4VGElZZcdltP2DDVuBcZ6MC8fh9
         tTTxH2o6QsDK/81f23FYPZXjCbqZAiCT2rEkZZ8l6U19/WgQ4YXD2QkXHB4EIpBDJQzq
         7bfw==
X-Gm-Message-State: AHQUAuZP6mEyqMAg/fP9aHcgvMhK+wX1qfthJ0GpYBFsiSrMtLrz+yAN
        1+2L0Ly2sbhtUDCuDcoNs0yhH+4m
X-Google-Smtp-Source: AHgI3IY5uAe67rmpyYcSiDiesMz5a52Dzpq8sO/8dZL2uZoyc8N38y+Q+mNF2J6RPCWCTWOE0CS1Kg==
X-Received: by 2002:a63:6a88:: with SMTP id f130mr3530910pgc.114.1550834886469;
        Fri, 22 Feb 2019 03:28:06 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v15sm1754553pgf.75.2019.02.22.03.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 03:28:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 22 Feb 2019 18:28:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Delete check-racy.c
Date:   Fri, 22 Feb 2019 18:27:57 +0700
Message-Id: <20190222112757.20035-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is git-checy-racy command, added a long time ago [1] and was never
part of the default build. Naturally after some makefile changes [2],
git-check-racy was no longer recognized as a build target. Even if it
compiles to day, it will not link after the introduction of
common-main.c [3].

Racy index has not been a problem for a long time [4].  It's time to let
this code go. I briefly consider if check-racy should be part of
test-tool.  But I don't think it's worth the effort.

[1] 42f774063d (Add check program "git-check-racy" - 2006-08-15)
[2] c373991375 (Makefile: list generated object files in OBJECTS -
    2010-01-26)
[3] 3f2e2297b9 (add an extra level of indirection to main() -
    2016-07-01)
[4] I pretend I don't remember anything about the recent split-index's
    racy problem

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 check-racy.c (gone) | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/check-racy.c b/check-racy.c
deleted file mode 100644
index 24b6542352..0000000000
--- a/check-racy.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include "cache.h"
-
-int main(int ac, char **av)
-{
-	int i;
-	int dirty, clean, racy;
-
-	dirty = clean = racy = 0;
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		struct stat st;
-
-		if (lstat(ce->name, &st)) {
-			error_errno("lstat(%s)", ce->name);
-			continue;
-		}
-
-		if (ce_match_stat(ce, &st, 0))
-			dirty++;
-		else if (ce_match_stat(ce, &st, CE_MATCH_RACY_IS_DIRTY))
-			racy++;
-		else
-			clean++;
-	}
-	printf("dirty %d, clean %d, racy %d\n", dirty, clean, racy);
-	return 0;
-}
-- 
2.21.0.rc1.337.gdf7f8d0522

