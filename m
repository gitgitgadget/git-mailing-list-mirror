Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2736D1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeCQH5H (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:57:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46706 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeCQHzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id w16-v6so18467109lfc.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfvAfHQin33uRfgCrh/+qWL6mxfaBkHratmiXSr/7F8=;
        b=jRwJl/vsRBQf6wb5tiA0+ybUpbpmvmPiQKsmxAaKQz9cY0wXu+oiEotg93slyYsVnn
         dUjxg+9jG1eyNWmupWd02+XrcH4C26+XfS0r69jz/N5Mt0+ewQLXFm0cTFYjDRZC+XN/
         Lzv7BbwV5J+j5RxaEaVbjO/H3AeSGpeo/X+kCm8ImUzKtmcLWGu+4cyYPxBSpdl2IXgF
         xC3hVMAwBscfS61OFGd5TyhWUNZ4zxtutNbfuj+6UugGoRa4+ZPikW49x5o5GUVRhn55
         JVmU0cmVtGZBJWXiq+vEtjIS4E4yIR585JWIpI0kHC1Cyt69M/klZ5OftR402xa7FyVA
         Rsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfvAfHQin33uRfgCrh/+qWL6mxfaBkHratmiXSr/7F8=;
        b=nOTWW8o0HjVEEclKLVkEn0BToPzWkG939mFsaWtwXfRTHt0UzYtJ7D+3j9W6MkoBiZ
         AwbgaGLql+lMlsoHVKMXdzm/UI1/3upFMJo5oJGbr0kRknzCDCiusPdQLmhmawScK5lC
         1nMuPMRZ5F6LvzdpPwHtQ94uVIwMEcelheip3clNp+Kma7GsoScprHel5+P7fRbTUgPE
         nfkcK0QGFsmISAfA9deN/XmRsSROFoheH5nrewpJPFEMsdVQSp2F6jCm9IF0e13GiW2k
         Vc7Lya1lBjX0lmY1AHHu9V5T4Kq4Kv7GjTi4KJx/8pKYwub9w1R/0mtO7+dFrVIfYMlt
         OMNg==
X-Gm-Message-State: AElRT7EuvYlYUVapgWYkiE86ePg4ClLHsBncicfxcOcPOhhg1ZYUdTwZ
        0zfGhDTTvPR5RQqFjWcMUJdGHw==
X-Google-Smtp-Source: AG47ELszWPupPWzL8BioCgZeIyMjbg11fYy3a+daOPcvgL3oDuUcEbKJ9p+DQtSDPmbVneglMs+AZQ==
X-Received: by 2002:a19:4f0a:: with SMTP id d10-v6mr3384741lfb.134.1521273347896;
        Sat, 17 Mar 2018 00:55:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/36] t/helper: merge (unused) test-match-trees into test-tool
Date:   Sat, 17 Mar 2018 08:54:01 +0100
Message-Id: <20180317075421.22032-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                    | 2 +-
 t/helper/test-match-trees.c | 3 ++-
 t/helper/test-tool.c        | 1 +
 t/helper/test-tool.h        | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d7342e3a8b..6552a8f4ed 100644
--- a/Makefile
+++ b/Makefile
@@ -665,13 +665,13 @@ TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
+TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 356d8edef1..2d58886acb 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,7 +1,8 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "tree.h"
 
-int cmd_main(int ac, const char **av)
+int test_match_trees(int ac, const char **av)
 {
 	struct object_id hash1, hash2, shifted;
 	struct tree *one, *two;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c8c8f3ead6..cde9f16fc8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -20,6 +20,7 @@ static struct test_cmd cmds[] = {
 	{ "hashmap", test_hashmap },
 	{ "index-version", test_index_version },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
+	{ "match-trees", test_match_trees },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a81e071a80..937c408dcc 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -14,6 +14,7 @@ int test_genrandom(int argc, const char **argv);
 int test_hashmap(int argc, const char **argv);
 int test_index_version(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
+int test_match_trees(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
-- 
2.16.2.903.gd04caf5039

