Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DFCC433FE
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhLNEJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhLNEJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BEEC061751
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so30257969wrw.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5VRL/COZrrE2C/RlI8KN2PlRId4Ot6isrchZ2ZL3zR4=;
        b=Tec4P6crLpoCWrzas2AqGWbRcBcY6NEQl3+XH40RZumD8V2Tf/KejcBX7fZ46QmE2z
         nj14E3H7J9MkN4lzdJObvboBsoCcGD68BABwFqHEuV7z4sHDwwwgP+dWeyVbtyEQD57w
         BXlH+g61RcJHcGk+HDLqzqcmkIzXKDTJQZggj5jGPzoht4GUV1k5yc6PVdt23afZxNB0
         gqxK6Dpx21PxwO5GxGKwBvWwE+a4hfIVc+yQyBL9IVN9QI40bBvvf41u7/wZUkM+5C2J
         50d4cLEHE+TnJ58+1dPaapXjlrwxwgtzyI3s763oKhcE7fYM5QH+mKdp93HXQeDJt6/M
         EKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5VRL/COZrrE2C/RlI8KN2PlRId4Ot6isrchZ2ZL3zR4=;
        b=mIiS//ACGyH6nNAg6uWcEmOBKT2DdjL2ypFcs240FyOLwimknlNMwuGKZ2uSlhkPk6
         DtSyFBElcI1PKtj1z+Ifdc6Kg9JQzz9Jr9LG0gNVCnOJ5xjhov9VnRvoSm1Bhara8ymc
         b/7PVH5SsKlQXwzFVTvlOr2GNRctZJvbD4RZ3I22aHhi/QUjpv3q24lSA5uY9V8U+9HH
         y6RCDPWs4fAxG5GFlT3PsGycYZBWAlIdZHRXwvTqxuaY8QnhXrseQGpnZMu6gPaTW/Bc
         S1JebOY6mW1dT+dWuN4miZ3ZArdwFFMYsZ3OGq2cmBc9oOkO3becZH0yoTWKXl4BDCjp
         HwDw==
X-Gm-Message-State: AOAM5302wQZpSL5GSPRyxgKcyAlXFjpzEhQeXPcFU2Uzucjw1L0ougv8
        ahdJYnocFJAUbyXo9/YB7aWCn9SJ6Bc=
X-Google-Smtp-Source: ABdhPJxZk7ePP+qwG6UTpStOYlUtbRVeY1Hb93TPp2uL1XBn5ZWCjGwulT7OroFLRU+4x/diIMNPVQ==
X-Received: by 2002:a5d:4901:: with SMTP id x1mr2915423wrq.473.1639454958776;
        Mon, 13 Dec 2021 20:09:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm10112725wre.106.2021.12.13.20.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:18 -0800 (PST)
Message-Id: <f669829a98b590d8a53be75b88d97b1d004eb855.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:11 +0000
Subject: [PATCH v4 09/10] Documentation: clarify/correct a few sparsity
 related statements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clone.txt           | 8 ++++----
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1ce..b348a71fc68 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -167,10 +167,10 @@ objects from the source repository into a pack in the cloned repository.
 	configuration variables are created.
 
 --sparse::
-	Initialize the sparse-checkout file so the working
-	directory starts with only the files in the root
-	of the repository. The sparse-checkout file can be
-	modified to grow the working directory as needed.
+	Employ a sparse-checkout, with only files in the toplevel
+	directory initially being present.  The
+	linkgit:git-sparse-checkout[1] command can be used to grow the
+	working directory as needed.
 
 --filter=<filter-spec>::
 	Use the partial clone feature and request that the server sends
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 72fcb6b2acc..9a4b43c105b 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -121,7 +121,7 @@ SPARSE CHECKOUT
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
 Git whether a file in the working directory is worth looking at. If
 the skip-worktree bit is set, then the file is ignored in the working
-directory. Git will not populate the contents of those files, which
+directory. Git will avoid populating the contents of those files, which
 makes a sparse checkout helpful when working in a repository with many
 files, but only a few are important to the current user.
 
-- 
gitgitgadget

