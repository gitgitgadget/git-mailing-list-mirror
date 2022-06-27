Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF88C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbiF0Set (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiF0Se2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:34:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0913D4C
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:29:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r20so14295021wra.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BeaRd+8LzFXthgcovVCeIHb52n21LI1zuMof+WiCOv8=;
        b=TY9YhBwwJfREF0Hihzvb41bWO1aJZhDX3OEF19W9K7w/LpBTHRuVDFAg9r0RTIZ2rw
         VZfPpqdz+k2CMf3yUNB4NtMtiz4+6cj/jEQM7ShVtLWVzG+jIKtu8QM/841sVgijoOZt
         hiREcmENHYmUo0aq0+iDMLmyMG4FNt/8MxIgnO0G2ot1EvBX/AN21ReM+KdWUHAPD/rs
         cu9/pgCThjRuulttfzgUXHWw2ykXzkQgx0d2iTELOC+FiV8BkbPfCekEAeXnb96LI1X0
         ieNsWJgjBUBFi+W6j1BzlKMmiaEksBAeIYrrUnvd7URFn/x/pnl45ibRXdf+dpC+pidS
         84Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BeaRd+8LzFXthgcovVCeIHb52n21LI1zuMof+WiCOv8=;
        b=MuJUvVZHQoyVffCm/WqT0JZXJUkMukRflURCPEtbWF67oTcC5aQKFwmQZnxIqKLfmr
         1kZXiygKwE7UYyacbTg1+uRXfKveibeLWyOMhEnAkYLyRB6wNKKuUz1mxVnroSGJo+RF
         0q0pY3XFQ8l4cGJZLi6urKUujHroekH0J71sRQ16z64ZRBRYC4Wy7xydtabB4OaG8VaL
         IOGFqFtLV+1qCg8jjn1RcFsJlzKC9hnw+U6DNC9tzU5WT3fef0eb0XwGg3bxxL9NrjfG
         RpKtw2G56lzvRuTswq8z9CI0KY4+2L0Z+7popyTfekMYLanI2RH13glz4C8UgMsuY3Jz
         XteQ==
X-Gm-Message-State: AJIora9XlIQOVwwIcRbGcAR/fSE/iMBYEPU92XcYNJk7SwYsHO0c/MnM
        98He7KLG9KpRgBl8qA2ltDKZ0RaugS39rg==
X-Google-Smtp-Source: AGRyM1u7T6OlK26Z8ouspK/UH7KhL7RaXjPN2RmKVa8Hg6M/psxwVZDkPKXFaOwxjbhUxKithEbwsA==
X-Received: by 2002:adf:e44c:0:b0:21b:b003:6bc with SMTP id t12-20020adfe44c000000b0021bb00306bcmr13989515wrm.278.1656354588888;
        Mon, 27 Jun 2022 11:29:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b003a03185231bsm13801934wmk.31.2022.06.27.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:29:48 -0700 (PDT)
Message-Id: <pull.1271.git.1656354587496.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:29:47 +0000
Subject: [PATCH] vscode: improve tab size and wrapping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The contrib/vscode/init.sh script initializes the .vscode directory with
some helpful metadata so VS Code handles Git code better.

One big issue that VS Code has is detecting the tab width based on file
type. ".txt" files were not covered by this script before, so add them
with the appropriate tab widths. This prevents inserting spaces instead
of tabs and keeps the tab width to eight instead of four or two.

While we are here, remove the "editor.wordWrap" settings. The editor's
word wrap is only cosmetic: it does not actually insert newlines when
your typing goes over the column limit. This can make it appear like you
have properly wrapped code, but it is incorrect. Further, existing code
that is over the column limit is wrapped even if your editor window is
wider than the limit. This can make reading such code more difficult.
Without these lines, VS Code renders the lines accurately, without
"ghost" newlines.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    vscode: improve tab size and wrapping
    
    I've been using these settings myself for a few weeks now. Fixed some
    problems I saw in recent submissions.
    
    Abhradeep was having similar issues, which drove me to actually submit
    the change.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1271%2Fderrickstolee%2Fvscode-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1271/derrickstolee/vscode-improvements-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1271

 contrib/vscode/init.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index f139fd86444..521d3037225 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -25,8 +25,12 @@ cat >.vscode/settings.json.new <<\EOF ||
         "editor.detectIndentation": false,
         "editor.insertSpaces": false,
         "editor.tabSize": 8,
-        "editor.wordWrap": "wordWrapColumn",
-        "editor.wordWrapColumn": 80,
+        "files.trimTrailingWhitespace": true
+    },
+    "[txt]": {
+        "editor.detectIndentation": false,
+        "editor.insertSpaces": false,
+        "editor.tabSize": 8,
         "files.trimTrailingWhitespace": true
     },
     "files.associations": {

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
