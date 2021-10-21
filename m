Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2699AC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CA56120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhJUO2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhJUO1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA207C061243
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g39so884820wmp.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ZCSptOjl+/jnoWZRke7uwNpWpjV7OfsebHsXtMQsR8=;
        b=J/kaGf36COKfpHqs/aTKfXo/WAuIeiZLnFwe0+GAVRyxti1vVxOrme4fZgmMxJ5uEx
         kMX9o9REsmF1X62jpLzD0NC6HQxKwBLF5Dlu6CpTRxRZOZf04HzeTX7EIwNNpxNG+W1s
         yB+CJ2t29mhrYnaFD8g8IkDwDKUiyrseplwIFlOWX1BGK7Gw3Nuk54C9XHVQ8wELcAvQ
         lTTvMgvcmrRREA+lbAo+qUfkS7zAVVEG/NiFM4KCZGACW5/Klhg+f1CwtqXzTgtoFBrM
         Zm22mo+jx5I7NOEontCsby4tJRlEyaQb3HpRcQPzdIJDpXV37i02QG9gMmJr78Xj5//D
         U3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ZCSptOjl+/jnoWZRke7uwNpWpjV7OfsebHsXtMQsR8=;
        b=ZATGXu8+v2cgARO8C+bmYFukP7ys4DieaZ1abg7OOWHew/yVMnU8dG0NDXisvOX/H0
         gWFw1Ch1hWFN8jMLqgeis2PjznucPFU9GIDzyKvtpR2G5Emy6gTHPc+HqAX4wRnjaz5c
         sEiCmzmilJvK0fxmq/zVXrIiYToEu+cC04JhLGKYm1zKi/6es1HrzvgX8q99VBgfxlgm
         rmZ395sHkSfy1fbEZKU12wZDLKuCBA+YJVfkc6HdWGI39kh18G61WyYuqg/V28sb7oXJ
         52G/V9qPaKavf+r+x9Lg84KMTob+SHyI6Hz0J3LZYlROifm2yjbSybM031H+8lPnKl83
         FCfg==
X-Gm-Message-State: AOAM5322qdE1k6ErBxNDlfAb3pMCRsNqKnpvW5TT5nnzhF1Ada81UoBl
        CeAXgjzXWMiRXTY4M0+OKvaUWuw5nyY=
X-Google-Smtp-Source: ABdhPJxTpZ8xiM+BCnrGarXMPlqCE0a3KvvoMDvbto0t1jnHiPSyIid1qZ7MuKJfJFqe9IMqWjZeDg==
X-Received: by 2002:a7b:ce1a:: with SMTP id m26mr4485987wmc.187.1634826324424;
        Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm4937458wrc.93.2021.10.21.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
Message-Id: <4e96e0667ba51fafa7da110c55f691fd39a15d56.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:02 +0000
Subject: [PATCH v4 22/29] t/perf: avoid copying builtin fsmonitor files into
 test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Do not copy any of the various fsmonitor--daemon files from the .git
directory of the (GIT_PREF_REPO or GIT_PERF_LARGE_REPO) source repo
into the test's trash directory.

When perf tests start, they copy the contents of the source repo into
the test's trash directory.  If fsmonitor is running in the source repo,
there may be control files, such as the IPC socket and/or fsmonitor
cookie files.  These should not be copied into the test repo.

Unix domain sockets cannot be copied in the manner used by the test
setup, so if present, the test setup fails.

Cookie files are harmless, but we should avoid them.

The builtin fsmonitor keeps all such control files/sockets in
.git/fsmonitor--daemon*, so it is simple to exclude them.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f5ed092ee59..dc29df12fd5 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -74,7 +74,7 @@ test_perf_copy_repo_contents () {
 	for stuff in "$1"/*
 	do
 		case "$stuff" in
-		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees)
+		*/objects|*/hooks|*/config|*/commondir|*/gitdir|*/worktrees|*/fsmonitor--daemon*)
 			;;
 		*)
 			cp -R "$stuff" "$repo/.git/" || exit 1
-- 
gitgitgadget

