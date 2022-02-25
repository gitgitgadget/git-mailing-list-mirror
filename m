Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFDDC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbiBYLoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiBYLop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:44:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C01E4812
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d28so4080351wra.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6766akpyO/bv1XaJriTIe1tvYGqjphFS3cL/dXlqmDw=;
        b=QKVZnIEnWNxbsJW0sK/pq+is0sZDHi1zc1zYQkn6jBENabfG66qpfpOmFH1msVR21/
         zF3yuw9kOZEQe8sdRYTaqCBM3QJc6YNTmMgaEGON34gEGbtUsxE5cD6VQED1E7HnYFR/
         VqVgKOEvdfi8na2SkkQ4DqzyQqbH2Sxbe89Ie+XvHrNfgDLanICxAlPFdQts1F+T1+xT
         1h5/mHOx7TgnD3cV3A63fs1J/ORXid5iyvMmXuXOyCRsy8mT08egH7/ZEblxbR/I5cem
         +78h2GhNlB4fJkZozeND4QUG3x/i24Put64cAYeqRLxLCIrSw+bqpup6GddANrbnabbn
         EAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6766akpyO/bv1XaJriTIe1tvYGqjphFS3cL/dXlqmDw=;
        b=f2pbQNOfi+0zubafB1B13/cs8M+OTwHXO/S8QTep8Gb4O3ekmIFvsabxiRNXaPXA+W
         dZ1NieHJgJJERP+AaUrmB7pskqZNMwEDnbduLpa0kUTRINpxiF8UmS/jgj8oawEr0wfL
         dXIPH5hk4t7aRRBeNRjlZV/eleUzMtaj4YkSR+0j2YjxQWLxA7e+ZTRJfT4PWjo5z/Yz
         sJiIM/OBylSdlUd3Bs2FQMlgLbERXa4ysgLuv2g1mZBRlp3zGUnPRbph7SYKHef12FJ0
         NhR9+JXUq84G+l/IO4JnFB0q4/luTKk1BJ/y1M1JMaSnFXXduGiLvhSpp2fDX30RHaHl
         lP5g==
X-Gm-Message-State: AOAM532jbPoTE65yycPBiQBdvxGlSwzZo+wYgTWXY2/8LlCAZK7GwKYS
        SMrnE6craNIx7gQnqYeRD8xQ5oR8brY=
X-Google-Smtp-Source: ABdhPJwtMMdOREajHk/uMjln4Zu9YhgOf0vIVkZEMhckcbleZ4KvjYI7AWIS7UfkX42HuSYfZCwOxw==
X-Received: by 2002:a5d:5589:0:b0:1ef:6505:e8a2 with SMTP id i9-20020a5d5589000000b001ef6505e8a2mr1986485wrv.477.1645789450685;
        Fri, 25 Feb 2022 03:44:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9-20020adff349000000b001e32675a367sm2020215wrp.28.2022.02.25.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:44:10 -0800 (PST)
Message-Id: <58ff3d8affed1c0f79a4a56945d23a5a9b0073f0.1645789446.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:44:06 +0000
Subject: [PATCH 4/4] git-prompt: put upstream comments together
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

Commit 6d158cba28 (bash completion: Support "divergence from upstream"
messages in __git_ps1, 2010-06-17) introduced support for indicating
divergence from upstream in the PS1 prompt. The comments at the top of
git-prompt.sh that were introduced with that commit are several
paragraphs long. Over the years, other comments have been inserted in
between the paragraphs relating to divergence from upstream.

This commit puts the comments relating to divergence from upstream back
together.

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 2772f990888..87b2b916c03 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -66,6 +66,11 @@
 #     git           always compare HEAD to @{upstream}
 #     svn           always compare HEAD to your SVN upstream
 #
+# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
+# find one, or @{upstream} otherwise.  Once you have set
+# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
+# setting the bash.showUpstream config variable.
+#
 # You can change the separator between the branch name and the above
 # state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
 # is SP.
@@ -79,11 +84,6 @@
 # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
 # by setting GIT_PS1_OMITSPARSESTATE.
 #
-# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
-# find one, or @{upstream} otherwise.  Once you have set
-# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
-# setting the bash.showUpstream config variable.
-#
 # If you would like to see more information about the identity of
 # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
 # to one of these values:
-- 
gitgitgadget
