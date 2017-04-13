Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BCC20960
	for <e@80x24.org>; Thu, 13 Apr 2017 22:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdDMWJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 18:09:10 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35833 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdDMWJI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 18:09:08 -0400
Received: by mail-pf0-f180.google.com with SMTP id i5so33960416pfc.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zuDfce+OvjbpJww2pFzrFqotv8ca/C1lyDHWl/8fHcY=;
        b=uHWcSxyL4OpbvFEKsL22jAJCynDHGHQJYaiO5OsRAGO0SnnPrWG+26aFE/5zHif0jB
         QWPpS1682/heMz5VKmuLjdVAOuXxOHYTFD5doJkjW0oYJM4jrbkfidoNAO4r47M7tfqQ
         pyv67GIExw9GSu1V4ZhIKZ37eIq4WlcVrPlSdPpw37Bqfk2lexBLy1wP+Z5GDQ8F3BVF
         7d3RoGLshEw571y4gXYUPFbFMnob2j1Fu57i6B00dpMc9WSsx1dZkQQ67cSfVwyzLbsO
         jn/683DVYyzw4l94/Rrvb1WZ0DNQXck/g97k0G2IwkQTVIHH60sj85aGOSeSBlAJ65tB
         R4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zuDfce+OvjbpJww2pFzrFqotv8ca/C1lyDHWl/8fHcY=;
        b=tUr0qp4lcTOIlI0tQY+7vYfkt0GyWwiFgOSMQPOVZ1WJmt8NkCBWdm+xXwFGPdBlj/
         CAl3RVPc6CYSRrFVfOM24909m5bMCjnonxfJRzbNrSOluAnnCCz/kRjFfSCIECWthaRF
         rKmNGEqNAzdVmbTyN2k/zV7X3+b7qWbXTsRJIET7eFJTIe7sdWjdET56lCeyuj0Eyw8b
         rliK2fmChZ7eZngJNNsVN07Q8vqDwZvq9riVP06JEasc+edNHhDSZ2A3oetNVEJGcsRq
         lhJSKOfoxIn7iltjBxeMTUEvogvNgmucDWxLoTrXTbotGcs2kNuP3Lv4d+hrsp6pL8NF
         /qyg==
X-Gm-Message-State: AN3rC/7YbTTRmY7zjy0y9akPCvbrILZssBMUDN0NWOp578goNyW+aSwz
        8nTa5e4/A9kmWBH0
X-Received: by 10.84.143.1 with SMTP id 1mr5530730ply.70.1492121337570;
        Thu, 13 Apr 2017 15:08:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e8bc:6ed8:87e7:fc44])
        by smtp.gmail.com with ESMTPSA id e13sm33644pfb.30.2017.04.13.15.08.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 15:08:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule--helper: fix typo in is_active error message
Date:   Thu, 13 Apr 2017 15:08:54 -0700
Message-Id: <20170413220854.14767-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e42e671014..b1d4269e10 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1145,7 +1145,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 static int is_active(int argc, const char **argv, const char *prefix)
 {
 	if (argc != 2)
-		die("submodule--helper is-active takes exactly 1 arguments");
+		die("submodule--helper is-active takes exactly 1 argument");
 
 	gitmodules_config();
 
-- 
2.12.2.603.g7b28dc31ba

