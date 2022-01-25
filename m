Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B21C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiAYW32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiAYW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:29:24 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DDC061747
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:29:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a13so22487349wrh.9
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Iwq7WehpMs5Yl9L12/kZ1dSjIALu6riIJpTzPAUgSOM=;
        b=iitQ7ACasOMpaBmIICzSv9Yw1jDYryQOcLubO9V8+sPSS9iiWuMdVRqelExSDpSZ1p
         KYdBSwRmoxkB/mlmHaAWZrBFZ7yZeziJ+Xj/EwX43nd60otQiw/PoSRP85ij9Ed7h6Sk
         2ynTQVO5YpGzeNBrjl1Dw5jCSwJwrRBlB7RYseJywBNjUDdVlFL00gCwoR4rddbf2KgF
         upPS/iLv5VlJjb2tTTWFlu65m3+1qwChxe3Gns6wTnDYcO8xuaRxnBZ8vZ2VWTpt1kH1
         75FNEk873yjN4sNBm+tJPitt/xXVilTrbTmI5zVHdqncJKGPZlnGgl2jkeI4+Pt6ukWY
         eSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Iwq7WehpMs5Yl9L12/kZ1dSjIALu6riIJpTzPAUgSOM=;
        b=EkScoiJaCD3fo621tPuVjPcSzLQfwtgG+tZeb8iL6XqgpXF051VGCNBxcpXy2hYvkv
         d3b2GacD1PFvKGwtnmAm/tmFTuMCpCzjmu0F0kgCxKbs+6RAxepW53zXp0H7P2h15fcg
         jxfEFtEsJMgqtWa8Q7ukF3xtPaswf0MBXQwcZZMBYqT842RaiccVOSbtvuaggPdHZ2qr
         56h9cMUmnj66SKSOWfpU8wkjbq5C4UD+XrNBNPhDjz44sWIr2tVZgppNTKVCkPYSOThu
         29ZRUPuM5aAYXNxgls7EgD7s0eXK86UjEERTAX5pAhAhqT82iXa1Td4UrB04o5bLbf14
         185w==
X-Gm-Message-State: AOAM533X3gSaBWEHQu0/7yJrSGbJd5+PxCiIY3m6m7vdU/qofUAi3PJG
        kfcw0ZTxE95H8FfeDge8jsVPQWlaITg=
X-Google-Smtp-Source: ABdhPJyDR6BTJjIb/iKab2ct4HItYsQCC4JJNN7L3oIDIrUW5vTzPp+NXm3UzS4wXD8pcQQqAl2KWw==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr8054798wrm.520.1643149761255;
        Tue, 25 Jan 2022 14:29:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm1676183wmq.26.2022.01.25.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:29:20 -0800 (PST)
Message-Id: <704bb2ba18ee3af5857064f6fd61689f98da0480.1643149759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 22:29:18 +0000
Subject: [PATCH 1/2] docs(diff): lose incorrect claim about `diff-files
 --diff-filter=A`
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

Originally, before we had `--intent-to-add`, there was no way that `git
diff-files` could see added files: if a file did not exist in the index,
`git diff-files` would not show it because it looks only at worktree
files when there is an index entry at the same path.

We used this example in the documentation of the diff options to explain
that not every `--diff-filter=<option>` has an effect in all scenarios.

Even when we added `--intent-to-add`, the comment was still correct,
because initially we showed such files as modified instead of added.

However, when that bug was fixed in feea6946a5b (diff-files: treat
"i-t-a" files as "not-in-index", 2020-06-20), the comment in the
documentation became incorrect.

Let's just remove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/diff-options.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c89d530d3d1..2549df0d212 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -616,11 +616,8 @@ ifndef::git-format-patch[]
 Also, these upper-case letters can be downcased to exclude.  E.g.
 `--diff-filter=ad` excludes added and deleted paths.
 +
-Note that not all diffs can feature all types. For instance, diffs
-from the index to the working tree can never have Added entries
-(because the set of paths included in the diff is limited by what is in
-the index).  Similarly, copied and renamed entries cannot appear if
-detection for those types is disabled.
+Note that not all diffs can feature all types. For instance, copied and
+renamed entries cannot appear if detection for those types is disabled.
 
 -S<string>::
 	Look for differences that change the number of occurrences of
-- 
gitgitgadget

