Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A78C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiCMT4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiCMT4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:56:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9757CDEB
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qa43so29573087ejc.12
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVYDedbsPLyuU4C9pndOMFGHXI1Jto8olMl0BSHlpbs=;
        b=cb0Xmzx/z1ew+pJqXGS253xu3F+2Ha/EHyEB429KpBmU9s4Jc0cvMx579Za1qFjbZI
         DALfHe2MEB9MWGqna6b2WlfjSYEH17icFvBP0qAn7wxPoDJWbJePgfMxORRYbXw3LamU
         /us+InXVzwnXwyPFlogYj3a4gx3Vdy+t9awm6KvY+8OynkLbpb76KVWl7FSQ3iJkTCXm
         le3vvHnq+pEPn5S19X+YrkpVEPBzuNxYtOmsyclOtctkASIDUwUEH6V3AFKVvSSse7fK
         8uB9qodN0DPeD3dDeSfopP7KzmYCtcqtMhfIu3OMuyhgJSiJFaMmAF20AZP/skXT1JjZ
         ok3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVYDedbsPLyuU4C9pndOMFGHXI1Jto8olMl0BSHlpbs=;
        b=1UEhGIvm08Hc+vrERsHuWLPlNm4Cs0fCABvIpC253oEc7qLZNyZKBWKbLQl4o2mot/
         +cdy2Wqrq4PrpUKD/HicTYHKmT0GLmXYOt//Xrv9iEsZbSWOd1AdR2W3+wLMaQqdMYvI
         19vGQ8EELf/bODHj3D893DJZS5iFap5vQpyr+kbJfs5BtgD88pjjs7YeIuj94iyHOBOP
         E43zKdEVAe7imGTu1ZamZtdQb9AbJ5bAwN28fk2fcNf7vPuj637wtF3EGSPhxJAc286j
         iIp09w68zCu9PdlEpCFJDffm/ZJGsglbst1DmEpfRL8NJEE2a3IY+e0CjIsF57PQth0j
         bd1g==
X-Gm-Message-State: AOAM531WRexH/RGElsz2lrb35UH7gSHP3NHgeq40gr4K7PCF3IIM+2x9
        BgxDXABUMG6a0Qm/6bLfwQkRqXwTjmY=
X-Google-Smtp-Source: ABdhPJxLPFeKNHnBhhIEh1LxiNLmMg2Vd3wrjiagUZxqZ+9Vle3v0+k0zjoAROtMtnbtNNlHUqwipQ==
X-Received: by 2002:a17:906:5cb:b0:6cf:954:d84d with SMTP id t11-20020a17090605cb00b006cf0954d84dmr16809854ejt.560.1647201343710;
        Sun, 13 Mar 2022 12:55:43 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b0041871c5b9a6sm2164087edd.41.2022.03.13.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:55:43 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/5] attr.c: delete duplicate include
Date:   Sun, 13 Mar 2022 19:55:32 +0000
Message-Id: <20220313195536.224075-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313195536.224075-1-gitter.spiros@gmail.com>
References: <20220313195536.224075-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dir.h is included more than once

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 attr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/attr.c b/attr.c
index 79adaa50ea..1626cade8b 100644
--- a/attr.c
+++ b/attr.c
@@ -14,7 +14,6 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
-#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
-- 
2.35.1

