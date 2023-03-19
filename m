Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD59C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCSG2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCSG2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E55FE7
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so7650830wrh.9
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0e2IZ/QQmjevGBmt3thYiC9+X9KSGQGEMxZ14F8rM0=;
        b=byWL/Ex+TTtHI50+3+WUKHwDHJ019NyvFk4bfVHI5OGIwLMMxRcgzcWflVngQFmCLP
         PwNXQtELpusHCETXv5uvkjXNc0XXREbf7ljxv9+He7HPo/CxtQWi7uzYtzzoxu1I9XDZ
         zX76Uh5DQ9U12nkYkx0k9D1C7p66nN2a815aK181gmrHMSDLPByRAU6RyezAv4mb4pC4
         VPDN7CCuDJe2lp8PdKQin4xo9cHtcV7Tk/dclyYDCbrp5X3igiuvD/48VguhnMTc+HAM
         nhcHDWEYoU4oSJ0rLTpsB3KpTRE8vmRs7Ki9Z1C/uP5pTxClK6EArOnDPkW0wrF1RHlL
         DY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207289;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0e2IZ/QQmjevGBmt3thYiC9+X9KSGQGEMxZ14F8rM0=;
        b=QXHF0yC+99eQNslBLBHWB8qkYeOPMUac5jQcEKXDwAgz4CDi/OkHZR0evYRzlL0pnr
         PSOPqJsSTuNWD95VkHFra/Xdz2FZuuxKtNhmKvW26r4UFvLcSDfBQYpaXsPrOYSTUCUj
         HtdQk8dOSxcIMiZbQZ71LoVFRZCXzllTNG1lMZmmdPfamsqxuwEv6eywjMChkF98aB5N
         VyLolssFIeereCnn7a9GOH58Ve9NNZdEgVjyXF6ZKrJAySltDZHc4WMWjwP91yZY5lfL
         XytWIWGL/XLrwDZ5s8iI/7k9IYTvwPaMSHa4FnfuF+vU3ouYIApU3Sko7RVAc3cUF9cJ
         eErQ==
X-Gm-Message-State: AO0yUKUCxIzIVZf4fOzk/LOatwdnIPIjN/2a18NUrSEUJVGiESbh73xM
        Ua3IphySxYL5DjLAqtBJP+Muv2KR8Es=
X-Google-Smtp-Source: AK7set/E+5/ge3FFWjt7Hp+ycAXDvrLC1azX/UZPSvLGlxlKyVcs6wlNvZU08kdJT/3IC8Raj5uJCw==
X-Received: by 2002:a5d:4382:0:b0:2cd:ddd6:c215 with SMTP id i2-20020a5d4382000000b002cdddd6c215mr11704414wrq.52.1679207288957;
        Sat, 18 Mar 2023 23:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm5871833wrs.44.2023.03.18.23.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:08 -0700 (PDT)
Message-Id: <a31269a26b31fec345f4207e4ee9da56da326e0c.1679207284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:49 +0000
Subject: [PATCH 03/16] treewide: remove unnecessary inclusion of gettext.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Looking at things from the opposite angle of the last patch, we had a
few files that were including gettext.h and perhaps needed it at some
point in history, but no longer require it.  Remove the include.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 progress.c                          | 1 -
 t/helper/test-parse-pathspec-file.c | 1 -
 t/helper/test-progress.c            | 1 -
 t/helper/test-run-command.c         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/progress.c b/progress.c
index 9b33a2df325..44c784d75f1 100644
--- a/progress.c
+++ b/progress.c
@@ -10,7 +10,6 @@
 
 #define GIT_TEST_PROGRESS_ONLY
 #include "cache.h"
-#include "gettext.h"
 #include "progress.h"
 #include "strbuf.h"
 #include "trace.h"
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index b3e08cef4b3..b704690d845 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -1,7 +1,6 @@
 #include "test-tool.h"
 #include "parse-options.h"
 #include "pathspec.h"
-#include "gettext.h"
 
 int cmd__parse_pathspec_file(int argc, const char **argv)
 {
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 6cc9735b601..66acb6a06c9 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -19,7 +19,6 @@
  */
 #define GIT_TEST_PROGRESS_ONLY
 #include "test-tool.h"
-#include "gettext.h"
 #include "parse-options.h"
 #include "progress.h"
 #include "strbuf.h"
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index b0d041ec5ff..c0ed8722c87 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -16,7 +16,6 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "wildmatch.h"
-#include "gettext.h"
 
 static int number_callbacks;
 static int parallel_next(struct child_process *cp,
-- 
gitgitgadget

