Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB3C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiCMT5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiCMT44 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:56:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0957D003
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m12so17102785edc.12
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIDExULcN/Wt1YhL+2AtN7S5AfNOICRvtRc/HtK+zas=;
        b=GR8PFlSyrTZzKAHfvhcuebM7wkTRnFZDivbNCuALhwT9bKV74oNDrFFlmbh+5wS0wL
         R1PtFjkZ8UidOA5fxtnLNb3YfrQIleQI5qpV7vOEW+EIB1X3xu4mGEeIDc7kQ01Vq6vL
         cfF+GRzQQlhwl/D3g55pACk7YbWKUr+hrbKPzmXBzIFhcY91vHcnwtrN5Cg8axGfODXH
         Zrj5NfoqdymV7xd/JdnLa4S1YSD6gWcZJwL7JBZy6uf3TDhxD97jPqgpqttGsAkIEOIS
         0LzmXHfSGff4nvqed5JaXg0Hk1i5CPMQevmuymbyY3GGCpKdxCm2pEk3ryUUMGdITNKh
         oRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIDExULcN/Wt1YhL+2AtN7S5AfNOICRvtRc/HtK+zas=;
        b=LbVXTD6WCrsVWIq8CpgPjOy7OVwHxfS3dDsf8oEC5ipXRegUvN5ZwHgyPsTvdSlhfr
         YKFuMryrnR3PQpnPTtsfgTDzIiSiVsMJitDiGR/63Xdv70VLoIXahwTsO+v6Bto0ELiB
         FubA0wSnLwaosMs6+1yPB/TI7QHuQSC8BFkBAIqjGaOX90PpRlqHNi7L+vUnEPvAkW1R
         QA7lpE+xTM0DZoazpJb/r0j/YFlu0kbb2Iqev06N79siY8MrtT1T8slcGRJCi+41D+KP
         ZWerRAZWxSKUuGlcspoUuBuivA8DTcmMpATh2kJcUU5cyc5qXwvOJfUHBZiPIKbp6FFg
         LZDA==
X-Gm-Message-State: AOAM530cTuVPMhKoLdEy5fW2Ad3iiLZ2xx63aWHMfIW9qwEHZMTJVAO1
        wPMBnggKTQTqbjOZhkG+iSekLMRFAY4=
X-Google-Smtp-Source: ABdhPJxQ/dumahkgmpOsdH7wpc9yNnje7Jjxj1EAyF+uX+gMIXipLJEo7r4qbRABfanHUeCPalWxRw==
X-Received: by 2002:a05:6402:c81:b0:410:a329:e27a with SMTP id cm1-20020a0564020c8100b00410a329e27amr17746333edb.142.1647201346457;
        Sun, 13 Mar 2022 12:55:46 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b0041871c5b9a6sm2164087edd.41.2022.03.13.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:55:46 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 4/5] builtin/stash.c: delete duplicate include
Date:   Sun, 13 Mar 2022 19:55:35 +0000
Message-Id: <20220313195536.224075-5-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313195536.224075-1-gitter.spiros@gmail.com>
References: <20220313195536.224075-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 entry.h is included more than once.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/stash.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3e8af210fd..548048f444 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -16,7 +16,6 @@
 #include "log-tree.h"
 #include "diffcore.h"
 #include "exec-cmd.h"
-#include "entry.h"
 
 #define INCLUDE_ALL_FILES 2
 
-- 
2.35.1

