Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C16C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiA1MCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242911AbiA1MCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:02:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF98C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a13so10432863wrh.9
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Iwq7WehpMs5Yl9L12/kZ1dSjIALu6riIJpTzPAUgSOM=;
        b=nXLNjt2qy1YAvRE0LjnWNXkGY3K3clpilarfrMKxPo3q4+YuEGbH8myIV/NrJozwup
         tg6kViRZ6UGhnH8Cd6Zj+7RI3Vl9aoSkZhc93sX/iqdVbrXzjig8Af47y3Egnkzq82Xk
         oPKLEKW+h98NddmjfK9V5N81QmCZ/FCZc1zM1K5vpsctALrENEs6hp+70+Dn+/MYsa+T
         XxZA1gx7RCm5EWtCub+MUIsI2NhalR7eCotY5lLUvnKFYly/hUhKA6c3WpqsZUUyExc0
         hU//7h0AIIFecvPye3bwvYhFhZKwqd/J6Z5I6kiciqi7CentyJyo66kkonSWbl9Rl+69
         r7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Iwq7WehpMs5Yl9L12/kZ1dSjIALu6riIJpTzPAUgSOM=;
        b=4/i+fxcfhz7rFsGa678mmTMP25HsLrJs5/pvP4QWjDlRUPSbXzIbjW3UFe0c7RsUL0
         GdHqvnePpzw6FZ5loFpuklri5Wu1o8dcHVI+X1BZ8zOWzvtiCwe/676bGrYAugIB5qy7
         Zd8dcuCjzs2Yi8G1KqcSmZvMSBfpJGPT/9G3XrOJUHDeKq7/157pUclqOc1Pd9kX6LLF
         ZAgIB9JVU6KT0crM/oOhXdExDXa0UvwlW8/n9hZoZkYMe04Lm1qHpvP67cDke8WypJ1d
         5gI/B/11VfxNZie8jcfYcZvv3W6MM+uFy8Q2bzpXx7L/bQ55JJoigvkqLv0MYoxSmXBb
         tF9A==
X-Gm-Message-State: AOAM530MB4OQIHIAIv/fX4cUhIz7Yc3CnlBP/Dw/lK6Kc4c9KMY7hGmq
        XSwUIC499uqV3v1DUgQusPufR+1SAI0=
X-Google-Smtp-Source: ABdhPJziWZNHtR8Dl7G8Coqcxh306WwA9MiTz7q+KHnJDTbKntXCQHrk3fw5Z7FlU1LRFN7MrvyE+Q==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr6827895wrq.399.1643371373027;
        Fri, 28 Jan 2022 04:02:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm5470179wrd.64.2022.01.28.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:02:52 -0800 (PST)
Message-Id: <704bb2ba18ee3af5857064f6fd61689f98da0480.1643371370.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
References: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
        <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 12:02:48 +0000
Subject: [PATCH v3 1/3] docs(diff): lose incorrect claim about `diff-files
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

