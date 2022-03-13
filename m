Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A2EC433FE
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiCMT5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiCMT4z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:56:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4701A7CDEC
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c20so17122178edr.8
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWnr1z+/Nq4+T/7Zl36kGMaf112NmTNu0U/P/GlY5JU=;
        b=ZPlE8r37MUYi3RCObUInJrQegY390JVQhlIh+OH8Ezk7BhnSliXLFt/Nt5TjnhS5Cr
         +P7ZDT82S+lKCjB+SdRvRDcE2gw1CZuyARJ6j5NXWvjpf3I4Qbn6PO22xsVUYkziBEeZ
         7S4ElF5DbK4jl4f0HgsfhzyveiaKH4TjezhgSQSWgB6IrA9AI6D38qiRJr8gQN4JvWGe
         hbFhZtTLWXJcpMa60lIOOcluDB7gVhDBec3ueLkn0KFB0hUo2ET5OCExGTnC5puleO4r
         Hm0WwTyodIlQobO9hF5qMojDQOwC3hOL+bMIB1o5sGzhkz1t3JrQ5c+LQpZvCKelMyoe
         0Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWnr1z+/Nq4+T/7Zl36kGMaf112NmTNu0U/P/GlY5JU=;
        b=u8t3Uv1zd3iq14ruZQ8sJUy/yPz5KxEoXmKouvyJmxofSIHfe7jse3DKv+WHrNYBnn
         rZWiRoWLbh2fPudFsYfFn7tT+7iNup1X/U53yRRooK2R2aaTK0RSeSGo8EoiDhEbLpvj
         mBX0ckoY24yGNXP7MpBX3gXsdM/yihmq8XI+VSKtHz6Z9uEGOczuCo1PVvl14N8yIYFl
         wIOdakEw4XfconCaFSNewTaei5jnXkzV5WNRJ2nDYaxXdpMHE0uw8rz7W79CKvPGEdeB
         RJ7yu7JKcfkt4BrIaldiFMnfu8c4wh4tRAdRNsQ1leyhbm2a7wYpuMfRmnTy4HmxUB9D
         AZlA==
X-Gm-Message-State: AOAM530YLStcj5oIZ1QE10SLICSe9IPoWnu1IBFXGgYusYmQTh9/FzF9
        8SqOENZfp5dX0DeLjdAHEyL8PledWms=
X-Google-Smtp-Source: ABdhPJwLOd7B8AKbv7WaPbuQOrmBApcNh2N1mivw6Oou7ZJHdK9O+HBJuavfCh6YixkknZcpMgVQww==
X-Received: by 2002:a50:cf48:0:b0:415:df40:9e3d with SMTP id d8-20020a50cf48000000b00415df409e3dmr17483316edk.185.1647201345578;
        Sun, 13 Mar 2022 12:55:45 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b0041871c5b9a6sm2164087edd.41.2022.03.13.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:55:45 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 3/5] builtin/sparse-checkout.c: delete duplicate include
Date:   Sun, 13 Mar 2022 19:55:34 +0000
Message-Id: <20220313195536.224075-4-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313195536.224075-1-gitter.spiros@gmail.com>
References: <20220313195536.224075-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cache.h is included more than once.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/sparse-checkout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5518ed47f6..d88d141076 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,6 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "cache.h"
 #include "cache-tree.h"
 #include "lockfile.h"
 #include "resolve-undo.h"
-- 
2.35.1

