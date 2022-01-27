Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75019C4332F
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245441AbiA0TIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiA0TIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:08:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A6C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso2485096wme.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Iwq7WehpMs5Yl9L12/kZ1dSjIALu6riIJpTzPAUgSOM=;
        b=cvEFxvKx5GP6QJQUwCEiIp0qkV+5IpJKhEKEzXj3nS45Tq0x5op9YVfv7HtooY5LOs
         cZIazWevv4+eh5PYwKNDZKgPT904ItgUgJvxsjIBm9Atk8/1SkXmOC8do/xoo12QaOBy
         5TnTxA12rCQAziEs+5A+wpt2K/fNi/PWTNsqRc4+LN0ujhAvDkSOBzNFst1PHPOUvSLd
         +xan8uTg4fE1VDfgyTHbCnpQSpJevCy8qJAngyynNWyHwz6kDaOB7qzAeATcRZW1PXs2
         +6U000IqKlxG6w5rCOHZlg7qSF8clRvCLcYS5QQqq/g+ghcAMNDcWDHBK4idXU45SdAy
         zK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Iwq7WehpMs5Yl9L12/kZ1dSjIALu6riIJpTzPAUgSOM=;
        b=Z6cgsd9TnXohbIkFt8hPHJHZ68BjBsbZSQJGCX4A3dXtbxJxiXhdkM33jHsdWLuO79
         5cmlVYJhlMzC5pjt4zUGxWwST7R30iYuovjm5HhtjcC4N3TpWSpgH5knZtW1/YDGLb5h
         repg5ORyLWSdiifmNEvn0vedF1l/E91l0l1dBZca+7YgU6Evb4z9Jn9pQOs39fjMnX+5
         iLZcVjGS/nUdX5BHPA7Ths0BHW22le6cNNeoI6Yvg1ECn7Ytmf5yWCtKMLj0r6T3GmDs
         3NJUWOGVt2E9gz0lH/yKc1hWP7QMUUocJtmHCKHRpuPZ51sE7DmVXZ02HDoe3LmzHbb6
         xHbw==
X-Gm-Message-State: AOAM530SHxZmx724v5a5PnOSd1bmgM9loQvRyiYk0To6Aooss9aNA0h/
        aXiupJYoAWZvdca40UiBlih6biANk0Y=
X-Google-Smtp-Source: ABdhPJwRIPqzwquW7W2JBUHPDReUDfWEneIGGBK7k2GlQvdnp/2EGMvGZF+vp0eyFfehkFUaqcB+9A==
X-Received: by 2002:a05:600c:17d5:: with SMTP id y21mr4528764wmo.102.1643310512324;
        Thu, 27 Jan 2022 11:08:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm128330wmj.12.2022.01.27.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:08:31 -0800 (PST)
Message-Id: <704bb2ba18ee3af5857064f6fd61689f98da0480.1643310510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 19:08:27 +0000
Subject: [PATCH v2 1/3] docs(diff): lose incorrect claim about `diff-files
 --diff-filter=A`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

