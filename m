Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827311F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfJSKfx (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:35:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37713 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfJSKfx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so8338808wmc.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7QrJej4PYv8ghfmPIe507A12jbjBI0M2hwH9c1bPdM=;
        b=jD/P+iw8fm2U/gWF8GkohESc+hSzKipG1ro1nfBoUYIio9JUcJgGJsJJ2AF/GUULG1
         QJAm+eCB9GUiAV0rNyvAYFm4PF83Ymzu4isW/NniRhYath/AGx85pCqf4YWNMHWVOsjv
         CAzOsLpz1fBLYapi03dODnmO0krqX7HUZ/pfsEoO7+ce2EZNFEFTf7dz6cWYk/vhVSbg
         tP0CjAhbeTyWmS+Fb/vb/qMq6LI+8OmG+L8vEbofNp1l03F9Lf0Z/CmARJPUK99/WFG4
         YDlrmSaZVArqCxt/oCRp7L5ULYtoXzwWsROJAAdBBjaFemIA+CuvZbqU6wuu3Vbw1AuT
         AT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7QrJej4PYv8ghfmPIe507A12jbjBI0M2hwH9c1bPdM=;
        b=LPJAqmlrJQOqtfeWu3AS/Xt4Ula+F4DuTk/14fNHORPfLVFPaqyz3wq2kmlreuNzRI
         og22Qf9CJwgzGh//UD41DaKy6eb5F5fuZgQqJwGZCMeCbcmjBsqVc/BIXreZcqp2VsbL
         /NyjnLs79NHjyos+b30JClz3/wbEbwtdxus6TQamf8aY/e4r5fnh9yJi3b8tgRlHm4Vf
         JC7WMqlKhXJUCAJsIRJ/FxROlOjZNusOOeRcLaT4oNpG4MLWJCL7BoZsM5XXJSzKFkiL
         OmyYvdTu0Iqvv8NtOHSn5woxJMQ3za9LqPoiRlzS18+MHEHwsk9CH2S693XLlwbm++9V
         Q0Aw==
X-Gm-Message-State: APjAAAV9m4dzIyg3n9xWgHzx78lB2QP5HKtaIqhUPK0JNAhsw4Z8gFOr
        UUiDfQhWktHpm8SX7+DG7X30nu5A2nmc9A==
X-Google-Smtp-Source: APXvYqxjg6fE6FG51JJWJRzC+OiIkXbiOCyDhFZcYM3jRp+81hFeB4/1iUH9ztQyA+z3Ch63Hb0jUQ==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr11496820wmb.120.1571481350918;
        Sat, 19 Oct 2019 03:35:50 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        James Ramsay <james@jramsay.com.au>
Subject: [PATCH v2 1/9] builtin/pack-objects: report reused packfile objects
Date:   Sat, 19 Oct 2019 12:35:23 +0200
Message-Id: <20191019103531.23274-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

To see when packfile reuse kicks in or not, it is useful to
show reused packfile objects statistics in the output of
upload-pack.

Helped-by: James Ramsay <james@jramsay.com.au>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5876583220..f2c2703090 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3509,7 +3509,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-			     " reused %"PRIu32" (delta %"PRIu32")"),
-			   written, written_delta, reused, reused_delta);
+			     " reused %"PRIu32" (delta %"PRIu32"),"
+			     " pack-reused %"PRIu32),
+			   written, written_delta, reused, reused_delta,
+			   reuse_packfile_objects);
 	return 0;
 }
-- 
2.24.0.rc0.9.gef620577e2

