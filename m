Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF5EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGBPPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBPPH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 11:15:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9722E67
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 08:15:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686ef86110so1810943b3a.2
        for <git@vger.kernel.org>; Sun, 02 Jul 2023 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688310905; x=1690902905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDr277gR2YWCfEpwbiEApByfeG0oov8ydLseXtH3kfQ=;
        b=eOKYhRZyD2yjAcBylPaaZaORGsCIzUjubmQ0H32FKspXLqJ5tqvgNIe8HI/TItYo0X
         25bb/LnDwcze1THNgDb272360gbNtnHlzlpwuI7vxg1iwvFTwGoCzXGwPj+vA4v8LiHU
         /gRil7ZqvPzdKT7wdPRfszqKl7GKSRGzkE9ExOJyMw1FqWp0qtkGkD6S1TlJnk78/uKf
         hP19GaktGaTsQzyuHzOWJkoYp1XNS/vRckaHu/VPtTTunrLppqG12m5NrxZAO+5pjanH
         /0D+fCtBZo54RAuQuJ6EFBgmg9OnAteuouvJCmuiDjskpTk+fqv9QWGazIb3mep8FN+L
         Abyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688310905; x=1690902905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDr277gR2YWCfEpwbiEApByfeG0oov8ydLseXtH3kfQ=;
        b=KcTcqcoL/oJcNDo9NGN8jRw6f4TM5izPQ8FIOIwzccPxgpazYa2o8Nm20zGGjUxhF+
         2itCpCLog9RBcvdK4H0QtQjP6tB956W5pUPR+kkLAXf9GRfuhvwkkh4h9bMUPlHC8Y25
         7wqKJS7guLA/XC/0Qr41WbYK4fqFi+YukVnyC1VdGjNLW3INaLwA8Ut5jFUCP3HNwHhI
         cDtMUMGhmmfXuZ2aLgOu82AMcgwSHRKsNj+q9sX7BD6WalZoDt6s3mG4OXVrcJtLSEFt
         jem17oyy+qPKK1FqSMs5qbUr7CKM0s7ot7yI71arfP1kf4WvufP2lCbOu1CVZV4+Ipf/
         y6yw==
X-Gm-Message-State: ABy/qLahsHD31gnB+DyTDMkYQA/uuXZhXCvTzSx7ToSCRzZD/l6YHkjU
        nI3+U349DTRDc4g9yzc0hg4=
X-Google-Smtp-Source: APBJJlGzABhJ3EBfAllBsi0wp+jHR8F5oxUXoq3Zylk65DzAjdrIcpgMIo6GwInwtW7kK7P6NbMdiw==
X-Received: by 2002:a05:6a00:148b:b0:66a:5466:25bd with SMTP id v11-20020a056a00148b00b0066a546625bdmr8457916pfu.15.1688310904841;
        Sun, 02 Jul 2023 08:15:04 -0700 (PDT)
Received: from localhost.localdomain ([49.36.220.18])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b0067a50223e44sm9684124pff.74.2023.07.02.08.15.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Jul 2023 08:15:04 -0700 (PDT)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH] docs: add necessary headers to Documentation/MFOW.txt
Date:   Sun,  2 Jul 2023 20:44:57 +0530
Message-ID: <20230702151457.3227-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vinayak Dev <vinayakdev.sci@gmail.com>

The tutorial in Documentation/MyFirstObjectWalk.txt
contains the functions trace_printf(), oid_to_hex(),
and pp_commit_easy(), and struct oidset, which are used
without any hint of where they are defined. When the provided 
code is compiled, the compiler returns an error, stating that 
the functions and the struct are used before declaration. Therefore,include
necessary header files (the ones which have no mentions in the tutorial).

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
---
I sent a patch to the mailing list previously, but today I noticed that
the CI builds for the branch on my fork were failing. I turns out that
the tutorial required addition of more files than I had noticed.
I am really, really sorry for this mistake, but I am sure that the tutorial 
is fixed now. The CI builds now pass perfectly.


 Documentation/MyFirstObjectWalk.txt | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 200e628e30..c68cdb11b9 100644
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
@@ -341,6 +343,10 @@ the walk loop below the `prepare_revision_walk()` call within your
 `walken_commit_walk()`:
 
 ----
+#include "pretty.h"
+
+...
+
 static void walken_commit_walk(struct rev_info *rev)
 {
 	struct commit *commit;
@@ -754,6 +760,10 @@ reachable objects are walked in order to populate the list.
 First, add the `struct oidset` and related items we will use to iterate it:
 
 ----
+#include "oidset.h"
+
+...
+
 static void walken_object_walk(
 	...
 
@@ -805,6 +815,10 @@ just walks of commits. First, we'll make our handlers chattier - modify
 go:
 
 ----
+#include "hex.h"
+
+...
+
 static void walken_show_commit(struct commit *cmt, void *buf)
 {
 	trace_printf("commit: %s\n", oid_to_hex(&cmt->object.oid));

base-commit: 9748a6820043d5815bee770ffa51647e0adc2cf0
-- 
2.41.0

