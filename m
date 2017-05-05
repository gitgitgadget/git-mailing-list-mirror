Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BCD207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdEEF1g (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35764 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdEEF1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:35 -0400
Received: by mail-io0-f193.google.com with SMTP id v34so8561899iov.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbrpXtB/XLwdYuf/CnLMt62WkxO5APN8Et85ovoTnI8=;
        b=Cj8oF9duT+gerTCYCY6M8Kc25NYECN41qH+u1bBwLRiaxekAR7EcFzYXdC1aMkGw0n
         0RTj6vKOcVVLyHoJbd9ckhy//EDW+aII0K8bBCskjREt2tICy6aZd/WgQwyJPsrpxzxc
         ahZBJWHT+29QtYWVTf5L7i6LBA0Z3Pu6EOiH071SSlUgAlTn3QVOF5M1GgueGJOs1b8C
         kO2bFI4pq4EMwsZqE6NWiDyASdrGis45WgSsCNgsNFHXrEO+rECiMvOJHs8cI0pxP3l9
         9YBHhT+OAW37p3RqheT11ZZ+3QA73xK9hkWs/GNHUMUbuM4SZSXMFCmLUHlPhG21P+SG
         kYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbrpXtB/XLwdYuf/CnLMt62WkxO5APN8Et85ovoTnI8=;
        b=VsIGIoYsO02+Ro8g9IwNc4pot1ceURSkVHng8FUE57ZcQmOoIgZt6dt9o0nDFC65cs
         sXqGdiRNAGHPqwH7t8sWHVvDZOiPpEMgV/gNj3xdPW10VJxDNg7yEkht4MiT8TpEZnxw
         m7Td9qwm9Me1nXrzj+cVH2EhHTMcqi+CrjbqtbMK2S7Ye0sKREEZIIOZaGJTi8o12jKY
         U3mwhx7ZKgbe1eyalFqFhb54wvRfD9tgPIPJWCDCmstkopEk6mro9dKCiqei9RfE+upw
         Or93hLZ1cZIdkftLimDTwYSolpyXtrgyoVihpRI/u/Yn06XN5Ss9nRjiaXHZZ0v8TSA0
         vdFw==
X-Gm-Message-State: AN3rC/4BJvi5O30sfxfOtFtMYcobie/jYkZoLrkCqcXBk81MFkzzy/2M
        i3/WVZZZLs0yLA==
X-Received: by 10.157.19.72 with SMTP id q8mr15521722otq.227.1493962055103;
        Thu, 04 May 2017 22:27:35 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:33 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 01/10] Remove unneeded dependency on blob.h from blame
Date:   Fri,  5 May 2017 00:27:20 -0500
Message-Id: <20170505052729.7576-2-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3..42c56eb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,7 +8,6 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
-#include "blob.h"
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-- 
2.9.3

