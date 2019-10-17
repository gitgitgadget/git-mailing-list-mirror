Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D261F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436992AbfJQURZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:25 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46612 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:24 -0400
Received: by mail-pl1-f202.google.com with SMTP id o9so2194412plk.13
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WkUKT08bNc2kI+unhVYVIPGXpNpMOhf36018IYaugZg=;
        b=Avvl5pNrwiVl4pSJNxD++oK+0hGZAyTzxWf+3jULcwPaXYsozXfU03zhCLdTUsyW6M
         AOBeFh15KfSUtxfy76w5vTMu5VWJTKDum+pflsjNlmmcczdWMB61VtutMoC05pQuWoLL
         OeWgT473MzP6I3UItDdlfLqNDqs9x1JeacjXSMcLOxQYyMR9hWU+PPidNGNXRU/IY+hJ
         fECgLzNTh1zZtSetqq+3YHgPXu/CZVRGjEFXrrFbxOrCI6uVBOecU6QsiH7Uy1hRrdYz
         tDdoqNftgUBKfNSlXOxPLZtaI/dOZSjgVsOiWQRD90P/4sHKKbA9oQqL+MYcna56rcfD
         Nqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WkUKT08bNc2kI+unhVYVIPGXpNpMOhf36018IYaugZg=;
        b=LkceS7Mh+q5+y8EyafD/IpZOXmpdqlq+9gdF0TxBLkPF189J+OLP0/nWeBwJ3gxoxG
         GXnOXg6FzqdiANKWIcrqBJoGflQFZS05Swg0jhA2qj1IoniCAepwialwGJguSN7o/a5Y
         5dPN2AzFo9e6w4jt68FDFh1RBctvC0VikHBCkkfZ2SP2vuOq50Mg31XMCbQ7TC21FXNS
         Ji2Xtn6e3UcG1pFm/z4LoRvR/fH1XHqzR4qILk0cwjUUugDrHLaiOT+LY7Ij+amR5pbU
         Jv/BKCJ7VFiGBKQhlDwyOYM4MU9mB6OOj0IkPDLy6EP8uSO0wmg4MDLWCFsfrpd/pSAn
         RmHg==
X-Gm-Message-State: APjAAAUogP8k3Wi8tAPjsA7AaAx8jlBKuwIUd2kJPWU2OTinLZ+uAvEc
        SOPrOnOxbgOhKnWfvTIqC0qsXcnoxavSTh8x2gcAxldn9Aoaal97HpYGxhu6kyxhB51lMfOHdah
        dWGBN5SvJnx3C2o97FWmyA+hJ/3VXbfypnLqVARBu44vdMmWquPTbKuvRmIB+AVic0afm1dpNmU
        Zh
X-Google-Smtp-Source: APXvYqw6jJ4XfreTS0JsEk8ZPkAZKQmk5/ipJ2l96qMStDOmKVKGcf4Jb31JB5ILkdC49BMnpCM4leIev0mQCKGv1RHg
X-Received: by 2002:a63:5d04:: with SMTP id r4mr6123547pgb.22.1571343443858;
 Thu, 17 Oct 2019 13:17:23 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:10 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <0a6777a2431e96f1e53110fa2ce2219420b0640c.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 1/7] Documentation: deltaBaseCacheLimit is per-thread
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that core.deltaBaseCacheLimit is per-thread, as can be seen from
the fact that cache usage (base_cache_used in struct thread_local in
builtin/index-pack.c) is tracked individually for each thread and
compared against delta_base_cache_limit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/core.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 852d2ba37a..ce1ba8d55f 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -388,7 +388,7 @@ the largest projects.  You probably do not need to adjust this value.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.deltaBaseCacheLimit::
-	Maximum number of bytes to reserve for caching base objects
+	Maximum number of bytes per thread to reserve for caching base objects
 	that may be referenced by multiple deltified objects.  By storing the
 	entire decompressed base objects in a cache Git is able
 	to avoid unpacking and decompressing frequently used base
-- 
2.23.0.866.gb869b98d4c-goog

