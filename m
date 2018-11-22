Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2036A1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392854AbeKWG7A (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 01:59:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33910 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392842AbeKWG7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 01:59:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so2360407pfg.1
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 12:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWjf/yJC2cIAD/qGX+vgIsfyPFPpnvCOZPK7Wfk5lt0=;
        b=Xph034PXTum4COgym2F1Jv3I0UuKufmZVkFYQTwoizImF+PFTVSRjZB3hnalin0+pl
         uuzPWDaEjV/NW1G8zySCxmXnNRwKNRUewFINq95kixJ2uOulKwcHDE5q7Q01GEESrSVS
         MQZi+LU2nK1tAb2fOQYzZePz1VqGBBTw2UvemXXgOWgZFVczO3bKZvrFT3if7i4Izs64
         PQZqpBa98u6VUpkCrhh0X2INxlhqPAZ6VmA2thIS0B3BK5NLzPBP5BjQ4gzFN5JlLUvi
         jCHGQYGX8IZaCy3Q20aUqqE+cxkQBptyYbNYw+A8ghXhCZRtRPFkrcLqxsLp98aS4/VY
         8Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWjf/yJC2cIAD/qGX+vgIsfyPFPpnvCOZPK7Wfk5lt0=;
        b=RtrCBkIP8onLGIBeb5PD7+PXqHi6zRzxoFMSDZ9bF5ax5Uj+/OBc788LLSHF8hsK8L
         MCiVFeTsrhd3IdQSRMc3VBhpMTR33AGsB7m4XIgxoTQRJMjouuD69+/efF+/64Ye8Gb8
         AUu/l0LzkIroYfaLzYNeFcSSZFHzg5zmGo3koxlG4D2l/W/KDwdx0H2i6uEzR8cRn6nl
         Kuo9xEotly9DUrsMBluJbzhNRWnB3TLczflK2Zxo08ru6slv90QdY1fYp7Pj7DI0WQjC
         HZLBL648gIa6cqNsctNSyGiQTkbmofSlGi1EkUWC3tmyDtD8TXmVBzgWGbjVljBUFJEe
         kB+g==
X-Gm-Message-State: AA+aEWZ4sYBOxK4lijx/100sxG1k3VY0Buarfho7PJoALJ2D8dPbEzqg
        13Gvx1mP7SkHuWy1oCTmBYY=
X-Google-Smtp-Source: AFSGD/X2T2e4f7zEq2085cjYwH5S7P4ptKjLhoODgLQNxtswNLxMYw+/nEwNhiZSuC3KP8BsGGrzQg==
X-Received: by 2002:a63:9809:: with SMTP id q9mr11291110pgd.109.1542917881889;
        Thu, 22 Nov 2018 12:18:01 -0800 (PST)
Received: from localhost.localdomain ([172.58.35.238])
        by smtp.gmail.com with ESMTPSA id w80-v6sm81545294pfk.11.2018.11.22.12.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 12:18:01 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     tboegi@web.de
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, pclouds@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, sandals@crustytoothpaste.net,
        szeder.dev@gmail.com
Subject: [PATCH v1 1/1] t5601-99: Enable colliding file detection for MINGW
Date:   Thu, 22 Nov 2018 12:16:40 -0800
Message-Id: <20181122201640.78495-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181122175952.25663-1-tboegi@web.de>
References: <20181122175952.25663-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Which FS was this tested on?, is Git LFS I keep hearing about also considered
a "filesystem" for git?

Could you also test with the following applied on top?

Carlo
-- >8 --
Subject: [PATCH] entry: remove windows fallback to inode checking

this test is really FS specific, so is better to avoid any compiled
assumptions about the platform and let the user drive the fallback
through core.checkStat instead

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 entry.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/entry.c b/entry.c
index 0a3c451f5f..5ae74856e6 100644
--- a/entry.c
+++ b/entry.c
@@ -404,10 +404,6 @@ static void mark_colliding_entries(const struct checkout *state,
 {
 	int i, trust_ino = check_stat;
 
-#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
-	trust_ino = 0;
-#endif
-
 	ce->ce_flags |= CE_MATCHED;
 
 	for (i = 0; i < state->istate->cache_nr; i++) {
-- 
2.20.0.rc1

