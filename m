Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C0C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AC360FC4
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhJ1QYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ1QYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0EEC061767
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so11205497wrg.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=z1nVhiMq6/ristx/M1UvdaT+chgF8Pxuu2GA2akLWJA=;
        b=RSP17hYW1W/LxlhDQWgDk20+mBY0QuaG7Vq+dXakIb/eUZaGKKuzAtP3gZxzMEt6yK
         9GEwb4Q57jx0ZoenB4GHatSSZU0e2zLDVy4ajftVA8I3ByAzn9gt2Lwbu6Eb14CP/Pww
         xsqWDdGvAJfvOQQGuCN2CwhY9hzuyKXkrwR2KkxkU7vqrJD88bZdyZ3Ix3ty2x8f/lcm
         ayHTE163G7FDzUJaP7EqB1Ty9MrtYFyMAMCqs43H4xmWoj02F3S7pSXqrXWcrKsx1h+K
         zSDQm/+iJBHgX4Vwj7AJabuSwKqW+Mlfww9gR1HbJNTVXTuYk/AHG23W1aLbjniNcJru
         KHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=z1nVhiMq6/ristx/M1UvdaT+chgF8Pxuu2GA2akLWJA=;
        b=gtsCaS2sINSJtYei+UoagEjdE3iSIbDpLc/+9gxA/PpqatqcwQsW+qF8Fg3Dt9I6NP
         o5T/v5F0urx4yN12cXNpMqPbd74oOEuwNMiwhOJDgdbhE45TOFWM2+HAFCY+HThDRRAc
         +WZ12ZBHmQMkXH6N89mSwYYApyVHnHixMDDuHLF8GzsO/rfM4oqjGnhb63HEWIcLd2wY
         2UfKfPEjn9BCL+3vW2pOrBizBT58ZvQBnHpE70vrTaSNuuaMKAI+uA9bb9hHKnSUz/S5
         mD2pl4/1Cs66E6M2pyQz4oXe68N9omRPMUVPMJWtz358z2Ie0l72b2z8QUId1ciCfhJv
         BFlA==
X-Gm-Message-State: AOAM531415g9ZGrwuXSXUnisrtijtH6DrsPM0XA7AMmF6gzFq0lcKdeg
        l61o4i7e/AneFNIbGRfNb+a0UyyZ/Os=
X-Google-Smtp-Source: ABdhPJwOpKsylgn9vB/r2P4z9Y2IfCdzcVe/OUn5ew0UikJnkz69O/JI4sWkPo9jnlPd2HK8ILUz+Q==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr6925232wrw.320.1635438129154;
        Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm4599552wrs.5.2021.10.28.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
Message-Id: <0c7b1d53808b091ce54490b3c73a26b31a350e4d.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:22:01 +0000
Subject: [PATCH v2 6/9] doc: use three dots for indicating repetition instead
 of star
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This is how it is specified in CodingGuidelines.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-fsck.txt        | 2 +-
 Documentation/git-merge-index.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index bd596619c0d..5088783dccb 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-	 [--[no-]name-objects] [<object>*]
+	 [--[no-]name-objects] [<object>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 2ab84a91e53..eea56b3154e 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
+'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
 
 DESCRIPTION
 -----------
-- 
gitgitgadget

