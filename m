Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACDC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 17:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiFMRTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbiFMRSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 13:18:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF16F1A
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so3854249wms.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZZQE3QYA2JbqOmSptV2LuRxedy/zEXuFwSgp77oCjng=;
        b=F4cLpLPsT6Mh4jxaS15xpR0aHM17k76GOjESgonXS6eo9wIhPsnfH1mXDrGWVOhaut
         dSOZ1V/Q2HxK5acQYDySkYIcaEnoE2lICG3H0GB7xARP50GtbckCgbv0t0vypZavN8IU
         m/KLRfFgzsO7dzwioQrWVyyWgMSiQ4xQboC7PWJla4Ye0PqLIfUs13A/d+PFKW/xpX/C
         ovOqwDDKpGujJpV72Buws7hgUfo5nQqegf0cU7woq1wMtGBlolvFEJDeSnjgB/MSechr
         VsQA6DRYqCm8hPaem8bMKLQb49Sn7snC4TsxuUZHANjD24uFRIrJDTwGSepEmdanbCJW
         pZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZZQE3QYA2JbqOmSptV2LuRxedy/zEXuFwSgp77oCjng=;
        b=N9Zbk0yY3uIFpimVTlx7j0uJJ/tD7u+Ia7yoDC+TjsYG62rlrMhs5WND5tgkyiWwJ+
         2MUbi5TYu9eCmY6hMYCh9nmTCLnKg5beGdobyou42IPiufWc8ticLiNAvjubz3zBdQoF
         VOWOA0p9VTqrkVm9x9b2nOpYAg0fZxNrSxq94nYqNG+Vj3hPgMSP+qQJctiHU2nAzgRD
         yGPjT+Ut/ahy5rDXX7AsyMrR7Fcc52APOqNZtnivacQva155gSRh0KPXM1kQQrA5GAOi
         uPrgcGzNZc9B46q6olbla7xzFXcrlnPYx3WbtWbiTwBrdp0YemSdlDkhxpHOYAMPPzjX
         cltQ==
X-Gm-Message-State: AOAM533NlJYpFhA3yFYnq4TLkrjXe0lYxpItAmk+YF9Rn0J4LkuzfrOc
        N/npzwd4E+0AcZH5YO1/x5WQsF//INuPRA==
X-Google-Smtp-Source: ABdhPJwymYnHH6lNAk1RrBF6JjNYP13E/i29MHcyY+c02oozj3Q42YUSJ20V/PHI5k4KnWxiSqTK9A==
X-Received: by 2002:a05:600c:3788:b0:39c:3a20:a50e with SMTP id o8-20020a05600c378800b0039c3a20a50emr15283495wmr.196.1655123386758;
        Mon, 13 Jun 2022 05:29:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c3b8400b0039c5224bfcbsm13425171wms.46.2022.06.13.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:29:46 -0700 (PDT)
Message-Id: <5ff3a52556716e92f7207c75660cec2eb3da2587.1655123383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 12:29:42 +0000
Subject: [PATCH 2/3] diff-format.txt: correct misleading wording
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Near the end of the "Raw output format" section, an example shows the
output of 'git diff-files' for a tracked file modified on disk but not
yet added to the index. However the wording is:

    <sha1> is shown as all 0's if a file is new on the filesystem
    and it is out of sync with the index.

which is confusing since it can be understood to mean that 'file' is a
new, yet untracked file, in which case 'git diff-files' does not care
about it at all.

When this example was introduced all the way back in c64b9b8860
(Reference documentation for the core git commands., 2005-05-05), 'old'
and 'new' referred to the two entities being compared, depending on the
command being used (diff-index, diff-tree or diff-files - which at the
time were diff-cache, diff-tree and show-diff). The wording used at the
time was:

    <new-sha1> is shown as all 0's if new is a file on the
    filesystem and it is out of sync with the cache.

This section was reworked in 81e50eabf0 ([PATCH] The diff-raw
format updates., 2005-05-21) and the mention of the meaning of 'new' and
'old' was removed. Then in f73ae1fc5d (Some typos and light editing of
various manpages, 2005-10-05), the wording was changed to what it is
now.

In addition, in b6d8f309d9 ([PATCH] diff-raw format update take #2.,
2005-05-23), the section was further reworked and did not use '<sha1>'
anymore, making the example the sole user of this token.

Rework the introductory sentence of the example to instead refer to
'sha1 for "dst"', which is what the text description above it uses, and
fix the wording so that we do not mention a "new file".

While at it, also tweak the wording used in the description of the raw
format to explicitely state that all 0's are used for the destination
hash if the working tree is out of sync with the index, instead of the
more vague "look at worktree".

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/diff-format.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index b8319eeb41d..a3ae8747a22 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -43,7 +43,7 @@ That is, from the left to the right:
 . a space.
 . sha1 for "src"; 0\{40\} if creation or unmerged.
 . a space.
-. sha1 for "dst"; 0\{40\} if deletion, unmerged or "look at work tree".
+. sha1 for "dst"; 0\{40\} if deletion, unmerged or "work tree out of sync with the index".
 . a space.
 . status, followed by optional "score" number.
 . a tab or a NUL when `-z` option is used.
@@ -69,8 +69,8 @@ percentage of similarity between the source and target of the move or
 copy).  Status letter M may be followed by a score (denoting the
 percentage of dissimilarity) for file rewrites.
 
-<sha1> is shown as all 0's if a file is new on the filesystem
-and it is out of sync with the index.
+The sha1 for "dst" is shown as all 0's if a file on the filesystem
+is out of sync with the index.
 
 Example:
 
-- 
gitgitgadget

