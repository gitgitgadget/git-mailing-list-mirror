Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D46DEB64DC
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 08:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGAI2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGAI2w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 04:28:52 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB9BC
        for <git@vger.kernel.org>; Sat,  1 Jul 2023 01:28:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b7474b0501so2423234a34.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2023 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688200129; x=1690792129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfeYYkA79GV3bILXAddK22UdVveJGbWmnB22T2jismQ=;
        b=ULt9mnyfiXU5q3ptPBVeMVfVnlrvPX36FrRXHj1qt0ptj7HFRFwtkCbPcAxokmnVz+
         u7RQ6awVmzqWGcUzESWNYcOb5IsgU8PymDWhMTO0AamTVR55jEEAyYWlJCIOjfqW1ZhE
         BsYQG0KmZO+lwC4/lbPLfFE49zj9oe+BVQC4TYdCrwnhgi3liurQpEa+doyvyvHSedS9
         urjOOs17Unspjoxc3Cwm0B4oU3K960/fOZSbrvNJ1V7GflnKcAEu0AnprQ5XLFfvfxOd
         eu4qYOm+L6kQyIkmBrYYQDUUtOn8zcgUbJnLKrnrBeg/KCEYSuAMbT+9qwPjECR+KWRp
         nyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688200129; x=1690792129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfeYYkA79GV3bILXAddK22UdVveJGbWmnB22T2jismQ=;
        b=Ck51JcuhXD64Noh44HqkgfuStZ+Tj5+hfdQpa5DrjmtWkH6uCdZm0zi0JSyOVew825
         aaiVIp3W8A8VRwKLvzWObtSJOLPcRBnHaZwaM/dxyAqYmwswj3isoTryuCcqANeLKb6o
         coT9wsKMZ+j7f69XgFA98RyrBJJ16ekwaRKyR6XYDW1G4j9CoEQz1XOUQ6VuULflPTZM
         DpIV++evKip/VqPMoM81YzPS24bzdUmMWzDmq9cSdAMZRgsyDvi6ahJBqtIrxvyvINmH
         sNrNcA3KpzZAOZuHI1zITe9MfkKW5iyPSNZox2kV2u9GIW9kbQfVLHLp+NapdsRB5COq
         t2lw==
X-Gm-Message-State: AC+VfDyeZBvmFAPNJ3DRiw3cytRiJE71ztWuzzTJam5NnFEQjpA4Bk2M
        3Fu8MUKfljonK/9+revwYNwbQCLZZv4=
X-Google-Smtp-Source: ACHHUZ4sPxH1FOPeJrrULokObTpFN1Hwf/m42LTPpL0gXDirSpSP3ox5ak88OR8iVRGyR1nf0r+49Q==
X-Received: by 2002:a9d:76c2:0:b0:6b7:54cd:2115 with SMTP id p2-20020a9d76c2000000b006b754cd2115mr5644079otl.3.1688200129069;
        Sat, 01 Jul 2023 01:28:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6805:20a6:df5:5399:e289:d945])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b001b80760fd04sm9290304plo.112.2023.07.01.01.28.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Jul 2023 01:28:48 -0700 (PDT)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH] MyFirstObjectWalk: include necessary header files
Date:   Sat,  1 Jul 2023 13:58:42 +0530
Message-ID: <20230701082842.7952-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In Documentation/MyFirstObjectWalk.txt, the functions
trace_printf() and oid_to_hex() are used to enable trace
output and get object ids as strings respectively. However,
the files "trace.h" and "hex.h" are not included, which
produces an error when the code from the tutorial is compiled,
with the compiler complaining that the functions are not defined
before usage. Therefore, add includes for "trace.h" and "hex.h"
in the tutorial.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index eee513e86f..bb99e2bb6e 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -41,6 +41,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
  */
 
 #include "builtin.h"
+#include "trace.h"
 
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
@@ -49,12 +50,13 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 }
 ----
 
-NOTE: `trace_printf()` differs from `printf()` in that it can be turned on or
-off at runtime. For the purposes of this tutorial, we will write `walken` as
-though it is intended for use as a "plumbing" command: that is, a command which
-is used primarily in scripts, rather than interactively by humans (a "porcelain"
-command). So we will send our debug output to `trace_printf()` instead. When
-running, enable trace output by setting the environment variable `GIT_TRACE`.
+NOTE: `trace_printf()`, defined in `trace.h`, differs from `printf()` in
+that it can be turned on or off at runtime. For the purposes of this
+tutorial, we will write `walken` as though it is intended for use as
+a "plumbing" command: that is, a command which is used primarily in
+scripts, rather than interactively by humans (a "porcelain" command).
+So we will send our debug output to `trace_printf()` instead.
+When running, enable trace output by setting the environment variable `GIT_TRACE`.
 
 Add usage text and `-h` handling, like all subcommands should consistently do
 (our test suite will notice and complain if you fail to do so).
@@ -805,6 +807,10 @@ just walks of commits. First, we'll make our handlers chattier - modify
 go:
 
 ----
+#include "hex.h"
+
+...
+
 static void walken_show_commit(struct commit *cmt, void *buf)
 {
 	trace_printf("commit: %s\n", oid_to_hex(&cmt->object.oid));

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
-- 
2.41.0

