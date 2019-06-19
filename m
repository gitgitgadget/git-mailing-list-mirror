Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A111F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfFSJ7U (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35768 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSJ7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so9386220pgl.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9Xv/oXxCB2MzWde2XsIAPLxNvKv0G045l+bVrKJShU=;
        b=IhdW/pzfGm/RSESRMIJtEA8cO2BY6Z/RnHno7TjZmxOP86H9G0ZyR6vVxTcIQh3v84
         5gDf5nruRgwZRIFFrz6erZ5mIMVjxjkeRXQ2Jdb34/3vFbjR4H4zBJYCsvcFrfeold5k
         8OQEn5K38PBM76pV5tL58eGyzYY00OK3L+xjelsMPQzZIHxGZ3PA3VkzCEUFBJycawGc
         Y+meaqY58V/L0t9UvF7qY5bd4VdbXStbie/yb2a5IGdNQLSOtwPJ52erS/efoL4ID2+y
         X4hxqd4qXFYnOCk3I6FdSlDqjN8o7/G5rj4Q3+TlXKIu6Xpa9GTxdjghkcpX/T6CNcIk
         JPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9Xv/oXxCB2MzWde2XsIAPLxNvKv0G045l+bVrKJShU=;
        b=m7TsCLrCSbQ/QQzfJLsi6CRYRqPzGi+Hy1Cn1LkmE9i2mwwnNU6B6DNwvW+kJm5u/m
         xIIWXYEE3xDmImWlkfR7yuXln0fmlK5aWAmDBLcv4PQ9dAEUT0KV8EZkrQx8+K25RlHt
         SNHqgr7IgLIx6LL9rFWs7QEgmVbGrDsYgLVCELHQ0DDaxgt0Pd9dT30YfIPbdZumeL0L
         vaVa5luMGDMtVd8PymFJv25BiQJhdY1I4q3YDZtXoWY2KyFMkqBmAsZidoUDXWmCLmfv
         sF3DEnel1azRErZCwsm+uKvIFW0kCS+g37YnGz8q8pJi2CUFxe3vDMVw7uD/U1EopxA0
         vTGQ==
X-Gm-Message-State: APjAAAUtN+8OjslPSqRK6+USxQ61owMx8UKGmh21J09tdZ44rTjUiy4V
        FXxobQuDoupX7kII0Nd+FPbzuuiy
X-Google-Smtp-Source: APXvYqyIejlrkFzVEnWxvJFGcKR4N2hz1BdU7k2IXd07HDmQCnddP/cSb8QOAe7GWl0qAHfaJgXCRA==
X-Received: by 2002:a63:1919:: with SMTP id z25mr7103156pgl.440.1560938359329;
        Wed, 19 Jun 2019 02:59:19 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id j23sm20938801pgb.63.2019.06.19.02.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/8] fsmonitor.c: dump "FSMN" extension as json
Date:   Wed, 19 Jun 2019 16:58:53 +0700
Message-Id: <20190619095858.30124-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fsmonitor.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1dee0aded1..f6ba437255 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "json-writer.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -50,6 +51,14 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
+	if (istate->jw) {
+		jw_object_inline_begin_object(istate->jw, "fsmonitor");
+		jw_object_intmax(istate->jw, "version", hdr_version);
+		jw_object_intmax(istate->jw, "last-update", istate->fsmonitor_last_update);
+		jw_object_ewah(istate->jw, "dirty", fsmonitor_dirty);
+		jw_object_intmax(istate->jw, "ext-size", sz);
+		jw_end(istate->jw);
+	}
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
 }
-- 
2.22.0.rc0.322.g2b0371e29a

