Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0445B1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbeGKWtY (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:24 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:45621 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:23 -0400
Received: by mail-yb0-f202.google.com with SMTP id b12-v6so2003127ybr.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=J9HtN3x3WB+mqFU7wbYdcuUPDYcKUvBWntMdEVNHzKc=;
        b=u1NzzKDYdxJHPHC93KxeRishCjeILcBQglQC2UHNKJa+Jk/H2pi2mTn+UCC5mk/XPC
         P2IOimv5UwNcEfS45aLuEjpPYGuHa5HkfsWMkY5qFtT7aKqSpN6OtIdgnt1WuYnJxmRb
         68w3xrdT8lkzObbyJXyEm+ShWhPX4glDdkZgLKl+C9nFKbLXo4p3d7YVesL6WK0fMFqY
         ZBwrb4EhPKGb2egzS6pIIXN7Br4kvBBk1owlN9qky2FCTh96w0f+eXPe/7/C7BPd6MvX
         Seg/O7V+q74umF+QCV0MqVH4mB+B5JoFVyqNTzf1jDqSCnIORGDhMt6YhwKc3sDUNLKZ
         AeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=J9HtN3x3WB+mqFU7wbYdcuUPDYcKUvBWntMdEVNHzKc=;
        b=IJtk0ip8mCGDEec/sp9eXGn7M91+FmF4rT9hv9Dyjq+yNcTBEpbB1ilxPWYixwkNHZ
         YLbiLc5GIos5lSFYP5AgLa1qyUxb6JERxL0lhUOA9FG7Pa7YE5BdaK1NKPkke9pU/h0T
         U0Mkm2xTSMVFev9ZkoLM5qSffNgqty9yxiGsGQknXNO7AzeOLpecNk+yxTE+H46nW4Cs
         877YTMjYcBSg6eo23AwNLY/GCCP638jINrlQetsHIMrZ4zx3xw8sdFOO0Gw6tBSdDWeq
         0e9D+rIhYH1lXBGGpGwmoH5ph0yVYOnVTOVHdAApCUbVmf5gkq8gicnTomYtD7s7WTUS
         d3xw==
X-Gm-Message-State: AOUpUlFBnqOkZdYpcznM67LfwD4E49ozPL8xf6njVIljbbbccY5cutld
        Xxnaff13HBIIigPaCRWb6bk7yxYndF7+LQccfVPLiF/5arshUSIWVyxrw8yyEZ4280TQk8NMZcY
        Wisp30X99S15/h8np3oEotv2lhwyeEAW35xzHWk9yQZgGZ2CaViqT/U3Uq3t9Rn+/EWoEYv+ECI
        PO
X-Google-Smtp-Source: AAOMgpeBPr/m/xYyXmpuDsRHcodalDwm4mG9vLjdNuicpUGQlUsE+yZ+MMcv/dmFwnGIePacotBbXJYZO6Xsejd0i3SP
MIME-Version: 1.0
X-Received: by 2002:a81:57c6:: with SMTP id l189-v6mr195977ywb.125.1531348972645;
 Wed, 11 Jul 2018 15:42:52 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:38 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Message-Id: <ab6c2d449dcec37234b051aa3ad489ffe713404c.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531348540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 2/6] object-store: add missing include
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-store.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/object-store.h b/object-store.h
index a3db17bbf5..0e13543bab 100644
--- a/object-store.h
+++ b/object-store.h
@@ -2,6 +2,9 @@
 #define OBJECT_STORE_H
 
 #include "oidmap.h"
+#include "list.h"
+#include "sha1-array.h"
+#include "strbuf.h"
 
 struct alternate_object_database {
 	struct alternate_object_database *next;
-- 
2.18.0.203.gfac676dfb9-goog

