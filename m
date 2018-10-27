Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEC51F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJ0PuQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36446 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeJ0PuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id h192so2542149lfg.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NICg9Cu7JUzj1kC1SFqvl9rQPtNHtmIhcjE7o2czEAc=;
        b=rYzKwq+YGop/KctT7cSOoGgvR93Vc/ovd65+aJUBqr19BWLaK9ZO9lJ4V1pD4SziHg
         UZ5FtDH00I3kTR1aguHPq9p9bb06E71X5XZL9AI5zpsoXksMpIriYcNUIxYHGPwAMXhI
         xjGmTzyTB33DA6DzeJ57SUO6kAZwXWP5NUochYXiieOngnxAlAbWB09HMwxBM9q450f+
         q9bbNS+CYzIXVDSaj5sTpvLfUYy5ziXTF2icoEWLcVKCHdgy2+Aqf5MNHGoJ4ZqUZ9kb
         UXuqT/Djayxr8Fo+wHaHaxYK2kVmubVphbDeSW/xhMlROn4M9NB5XcuKXbbqY8CSyZ+J
         A7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NICg9Cu7JUzj1kC1SFqvl9rQPtNHtmIhcjE7o2czEAc=;
        b=qT9Pe22h+UjPB7JfPYURSjU+VVLKYcuwS0oy+XeGJTNFNuOpZ3DileX04q50Tbfabx
         jfNrX5WigUvdCEDzYYNRwPvkll38CKo+4JAumgtBbMd+JWiO/oqb+jz72WUeWWCk+E5Q
         boMQ0kYMf5oIjDHFuWg4aKxTtrVkGR75uQf/U0RC8pu0ju4lloNoyG+HXiiSTP8Xx3WE
         eCdP4yNok1er2gViaEMmG3skYe7Fu56CnZ7RMe0ot4JpQPMgyEaSqNv1i2gapWXkJNCx
         ZaA46JrhMqdywB0X0woosRpqNL3HIVk68u28+nMf0yirqzgHB6vFyYVXMZO3tl+kFZBp
         zseA==
X-Gm-Message-State: AGRZ1gJ044A10p0IPAyefXJQjwWE1W1GObXdnTqCWOrf+jzsLnDLSvnJ
        teDlE1gte6ycM2iRNI8gZyyvPutL
X-Google-Smtp-Source: AJdET5cWKX4/Wms8+MgNBPSUTO6civ3N/CigTY2fv1hqubEEGfsqtVSHyYpctswp1WTtBHwOOJBznQ==
X-Received: by 2002:a19:4345:: with SMTP id m5mr3872355lfj.142.1540624215314;
        Sat, 27 Oct 2018 00:10:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/10] send-pack.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:09:58 +0200
Message-Id: <20181027071003.1347-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there correct "#include cache.h" position. It must be one of
the first includes.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 send-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index e920ca57df..fa7dc44b36 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "cache.h"
 #include "config.h"
 #include "commit.h"
 #include "refs.h"
@@ -14,7 +15,7 @@
 #include "version.h"
 #include "sha1-array.h"
 #include "gpg-interface.h"
-#include "cache.h"
+#include "thread-utils.h"
 
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset)
@@ -203,9 +204,8 @@ static int receive_status(int in, struct ref *refs)
 static int sideband_demux(int in, int out, void *data)
 {
 	int *fd = data, ret;
-#ifdef NO_PTHREADS
-	close(fd[1]);
-#endif
+	if (!HAVE_THREADS)
+		close(fd[1]);
 	ret = recv_sideband("send-pack", fd[0], out);
 	close(out);
 	return ret;
-- 
2.19.1.647.g708186aaf9

