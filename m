Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32AAC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiCMT5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiCMT4y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:56:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BED7CDE2
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb39so29598650ejc.1
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjg3Or1Ln10JcJSAvgYBaEbpZQa3roCt1HPua5pyWkY=;
        b=cQf5LMaVEQZMIM+VyGoG47pdvEfxc/gjVSf5JEjNsfktLMeENHjFGbpptnm6TyEtXN
         ByAzDWPxa9dkjHfcsekpmAPNjluaA69BtVQV1NxJTxDDA3Wl7x0hfEc2UlRN5QMdiRgf
         1abkPri2ucvahKchQQkEkMiRFE5gwY3gq1rQQBu6UHM/dKKxZ5EZ5jpUCmEeA4AHDlnr
         gM18pUT1EeEONE5DJfDwJTOzsp2dKgmvDziG2ZkahqZXbO0W3m+ClEjzBTLuhyjTDEvb
         /byjm06FLg/nZLs59nLGNfMpczTKHucY+iV6rqUGmBgNB37H1gylcpqxFHDnIeL7iJGc
         UVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjg3Or1Ln10JcJSAvgYBaEbpZQa3roCt1HPua5pyWkY=;
        b=YyQdsc0Hti8iaxlHu1TD2hVY7ZaV8/oV7376nO0T8pWScb9qU0ud8uP/xyLxZDPSQ+
         MeuEaNgb3/QJYki4c6oFlL9toFafg9CcUwSfaM1ggtnlnPPKA6k9PTzpbK4Tgdo8fvpg
         3Yeu/w/tiJn4YAaWHr0opZKTLo6m+JVBmSLXNFSyiqmk27hltbxTB6vOFdXfOynJitMz
         X5/Iu0w0InuHOOJlbitNlVWKSOZ69cwjt9ut5AEuv1PC08YtyfuQwoQsP0bVwv2mwgiW
         6bGddpADOuWAnJVYkQLakIFZISljrhCsP0bElWIYQ5QdyyNpE/pNUDyvidTzDcRKUOYJ
         qLkw==
X-Gm-Message-State: AOAM532W4cINwb73/0xLZTC1CO8sY1nrG5Z5KzxVtWF6bJGDBxxGxpYv
        wAUVI+or12F1Mtwl8FDa8/YhGXiGpbo=
X-Google-Smtp-Source: ABdhPJxpeyKpgfghPQElYSh6iwogn0ReH3P/ixQ8nlrNrVXafCbVju2W0Hm+sIR47fBmWk+Zi1YDgw==
X-Received: by 2002:a17:907:3fa8:b0:6d3:477a:efe with SMTP id hr40-20020a1709073fa800b006d3477a0efemr17168861ejc.401.1647201344722;
        Sun, 13 Mar 2022 12:55:44 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b0041871c5b9a6sm2164087edd.41.2022.03.13.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:55:44 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/5] builtin/gc.c: delete duplicate include
Date:   Sun, 13 Mar 2022 19:55:33 +0000
Message-Id: <20220313195536.224075-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313195536.224075-1-gitter.spiros@gmail.com>
References: <20220313195536.224075-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

object-store.h is included more than once.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/gc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ffaf0daf5d..b335cffa33 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -30,7 +30,6 @@
 #include "promisor-remote.h"
 #include "refs.h"
 #include "remote.h"
-#include "object-store.h"
 #include "exec-cmd.h"
 #include "hook.h"
 
-- 
2.35.1

