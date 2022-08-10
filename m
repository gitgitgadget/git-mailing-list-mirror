Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B65C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiHJPCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiHJPCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:02:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F24760C8
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so1139452wmb.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=IiyAAazuRgzTBIhR7doOkSDf4ZWZUp/2zjSHTSbR9YA=;
        b=GFq2cKQF8mhJTAMvFzFc4qQZLNzIOzSICKu3Fq8SAB+fUi0Xy+OI2svcO6A5gzcEkP
         Hsm4HUvSglnwyDFQdJhALWbDBhfCWZ+KyCl4z7diHDtyPkzWzNYAdqlF5vMZ41PQ8M1x
         v6VVaHpZmA6z5miUZ+5ncNojKMrAfiCG+mUdOFNsgKr68SbUY0EIjRnj1mt9R6IwGmx/
         n/uHd7pydZEz/O9VzeKDMgPwzPfMA3XpDv/fjrc3nZdvlzdgJpzCcLeLCZ6dTalPZYrf
         huh9Gh5hRATKItnw+Q/hjr1gw+EIs1+3lN9MFX9zVDAZyAuEZk9hHOfVebM/vf0R2JzI
         L+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=IiyAAazuRgzTBIhR7doOkSDf4ZWZUp/2zjSHTSbR9YA=;
        b=u5sR89L8O0yUi2aMVuiFmkwdX4NQi0APvvEUt/2yTJ/yfxIOivwFk8A2SRvOKEp6wT
         gWP/o9YiAEbf4RylFHFLd/yaCndanM4T6/ymJaADC4dKqjW6yNvYm2y/gQOrzIrqY6NI
         aiOKT8eo032jH+zGEyTMFNzKErFGkSyQvmFSAn+V0af+rg89LjqHftwHv+P+TRvZgF0u
         +pymvDTVa9bqqLtKHpBxxJQkj1tCNf573aqslAdkHRnFXSUzu7o78Cx56dxIx1hiZNev
         IFP2L1cQpX/M7iyZuGty1KMrOBFH9MHIz2S58Mp7a1wQppPu6Aq+az9QlSaRCbIukg1G
         1HVQ==
X-Gm-Message-State: ACgBeo0bNS1+8BMoLVrOnkbydEgnSUFb3Dec79j9XlEbz3RRoAc0PaUG
        OuissBF9pTsuCpZiZAW65PTVH4h+0To=
X-Google-Smtp-Source: AA6agR6pcMVTbPzlHup0p9F2e08ztfvxQr+8KJwgGvZwve4Or5N64FRRcOxlUODXpgt0/sWlmJPROg==
X-Received: by 2002:a1c:7518:0:b0:3a5:1681:b175 with SMTP id o24-20020a1c7518000000b003a51681b175mr2711160wmc.139.1660143755514;
        Wed, 10 Aug 2022 08:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c26d600b003a511e92abcsm2510852wmv.34.2022.08.10.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:02:34 -0700 (PDT)
Message-Id: <79abfa82c32ea686469cfe2417bc491c04179623.1660143750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 15:02:28 +0000
Subject: [PATCH 3/5] tests: explicitly skip `chmod` calls on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, we use a POSIX emulation layer, the MSYS2 runtime, to allow
for running shell scripts (albeit at a hefty performance cost, Git's
test suite takes ~700 seconds to complete on Linux, according to Git's
CI runs, while it takes more than 6,000 seconds on Windows).

This emulation layer has a funny quirk when it comes to `chmod`
invocations: it pretends that it succeeded, when in reality it did not
do a thing (because the Access Control Lists used in Windows' permission
model are so different to Unix' default permission model that Git's test
suite assumes to be in effect).

Git's test suite relies on this quirk by assuming that the `chmod` calls
in `test_chmod` and `test_write_script` simply succeed on Windows
(without actually doing anything).

However, this quirk is only in effect as long as `chmod` is run inside
the pseudo Unix root directory structure or within the home directory.
When run outside, such invocations fail like this:

	chmod: changing permissions of '<file>': Invalid argument

Now, when running Git's tests in, say, Visual Studio, we frequently are
in a worktree where the `chmod` invocations would fail.

Let's accommodate for that by explicitly skipping those `chmod`
invocations on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6da7273f1d5..7c63b22acab 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -492,7 +492,10 @@ test_commit_bulk () {
 # of a file in the working directory and add it to the index.
 
 test_chmod () {
-	chmod "$@" &&
+	if test_have_prereq !MINGW
+	then
+		chmod "$@"
+	fi &&
 	git update-index --add "--chmod=$@"
 }
 
@@ -548,7 +551,10 @@ write_script () {
 		echo "#!${2-"$SHELL_PATH"}" &&
 		cat
 	} >"$1" &&
-	chmod +x "$1"
+	if test_have_prereq !MINGW
+	then
+		chmod +x "$1"
+	fi
 }
 
 # Usage: test_hook [options] <hook-name> <<-\EOF
-- 
gitgitgadget

