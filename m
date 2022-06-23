Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ADCC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 05:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiFWFMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 01:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiFWFLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 01:11:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0224667D
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 22:01:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g18so404263wrb.10
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R7Zv1u1c2kSy9zdVSLoZ+YYQfWArNLQhO8tJzSEVAc4=;
        b=Ck5JSy2EqojvtQ/LXiJfxfRmNqpLQrr7bev8bE1+r7Yo/+pihGJigOCWnD1ZOZ4ON+
         QgPiJlghUlS+yPqvpxhxkBWKshRsV73g5rkmeaWH+uP195DMj2Xdv7/V0vzoBKFeHD+k
         2SCx/zC2w84bbBCazRkJH7hhxNF5oWt4383zOEbQYz66vmBnWJ14vfobq04bNMqt8Lzx
         Uk4EbE7dh88DIfuHL9iuIzo89jWani9kgOl4z6JeSsFy0yGFgZ/DiY08+uh/ZM2uCT7/
         fvDQnLo5SU/D8JnoFkl1WCyypwMuq+l637GyNGEvrY7TG8uBmWRajEyOqs07B9uum1sH
         9Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R7Zv1u1c2kSy9zdVSLoZ+YYQfWArNLQhO8tJzSEVAc4=;
        b=f1yUYK91zYYRlp17xxGXye40bJleV/9W4aOdaV+BLTc9174GsWEuY1qGY4G/r9x1hA
         AlrxFRClgCJv9QUXDK4z03k51QPWH3vEfJj1xJ2HMNt9tGujfV4y2lAJjfhg6L41188b
         i7jc2vkUoD7t1wB2aXDgCz98Bw4YAp0QiKfuodAuqokL3/UwhuhPFSvHm53YNC3x0vQu
         odZ4eNsR62LDM9cjcDwNrivJtAiBKvlRyxTczmQKdDttXtGN71Kdjc1Gd/Be4462lngr
         WwxgzHmnVFtz0o4e0fGh5crurSJtg5tl/vu/oaR7D9xEDi4WwYHT8twx2OU3id+HPB/2
         zwoA==
X-Gm-Message-State: AJIora/OdkYUTNPhGFk0Mrl0qyf+rUP3lgIcE4mnwNCe/Qv0doRLiwwz
        j1zgijenPvYTdPwecsR4ml5HYGH9y13EYQ==
X-Google-Smtp-Source: AGRyM1uSPeR0wCXaCVrlQltplX/KQlUyoJcyxFAA1B6IK7fAa9UGbN8CUwKsMt73zsZOJt+Px6+cDA==
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr6196296wrb.464.1655960514448;
        Wed, 22 Jun 2022 22:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020adff70f000000b002185d79dc7fsm20604799wrp.75.2022.06.22.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 22:01:53 -0700 (PDT)
Message-Id: <pull.1265.v2.git.1655960512385.gitgitgadget@gmail.com>
In-Reply-To: <pull.1265.git.1655697671724.gitgitgadget@gmail.com>
References: <pull.1265.git.1655697671724.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jun 2022 05:01:52 +0000
Subject: [PATCH v2] rev-parse: documentation adjustment - mention remote
 tracking with @{u}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The documentation explained the conversion from remote branch path to
local tracking ref path for @{push}, but not for @{upstream}.

Add the explanation to @{upstream}, and reference it in @{push} to avoid
undue repetition.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    rev-parse: documentation adjustment - mention remote tracking with @{u}
    
    Small clarification in the doc for git rev-parse.
    
    Changes in V2:
    
     * Applied Junio's proposed simplification

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1265%2FTaoK%2Ftao-upstreak-doc-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1265/TaoK/tao-upstreak-doc-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1265

Range-diff vs v1:

 1:  58d2735d752 ! 1:  9e47e12e9cb rev-parse: documentation adjustment - mention remote tracking with @{u}
     @@ Commit message
          The documentation explained the conversion from remote branch path to
          local tracking ref path for @{push}, but not for @{upstream}.
      
     -    Add the note to @{upstream}, and reference it in @{push} to avoid undue
     -    repetition.
     +    Add the explanation to @{upstream}, and reference it in @{push} to avoid
     +    undue repetition.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
       ## Documentation/revisions.txt ##
      @@ Documentation/revisions.txt: some output processing may assume ref names in UTF-8.
     +   before the current one.
       
       '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
     -   The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
     +-  The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
      -  refers to the branch that the branch specified by branchname is set to build on
      -  top of (configured with `branch.<name>.remote` and
      -  `branch.<name>.merge`).  A missing branchname defaults to the
      -  current one. These suffixes are also accepted when spelled in uppercase, and
      -  they mean the same thing no matter the case.
     -+  refers to the remote branch that the branch specified by branchname
     -+  is set to build on top of (configured with `branch.<name>.remote` and
     -+  `branch.<name>.merge`). As `branch.<name>.merge` is the branch path on the
     -+  remote, it is first converted to a local tracking branch (i.e., something in
     -+  `refs/remotes/`). A missing branchname defaults to the current one. These
     -+  suffixes are also accepted when spelled in uppercase, and they mean the same
     -+  thing no matter the case.
     ++  A branch B may be set up to build on top of a branch X (configured with
     ++  `branch.<name>.merge`) at a remote R (configured with
     ++  `branch.<name>.remote`). B@{u} refers to the remote-tracking branch for
     ++  the branch X taken from remote R, typically found at `refs/remotes/R/X`.
       
       '[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
         The suffix '@\{push}' reports the branch "where we would push to" if
     @@ Documentation/revisions.txt: some output processing may assume ref names in UTF-
      -  in a remote repository, of course, we report the local tracking branch
      -  that corresponds to that branch (i.e., something in `refs/remotes/`).
      +  `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
     -+  the local tracking branch that corresponds to that remote branch.
     ++  the remote-tracking branch that corresponds to that branch at the remote.
       +
       Here's an example to make it more clear:
       +


 Documentation/revisions.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f5f17b65a12..7fcfbcbac7e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -96,19 +96,16 @@ some output processing may assume ref names in UTF-8.
   before the current one.
 
 '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
-  The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
-  refers to the branch that the branch specified by branchname is set to build on
-  top of (configured with `branch.<name>.remote` and
-  `branch.<name>.merge`).  A missing branchname defaults to the
-  current one. These suffixes are also accepted when spelled in uppercase, and
-  they mean the same thing no matter the case.
+  A branch B may be set up to build on top of a branch X (configured with
+  `branch.<name>.merge`) at a remote R (configured with
+  `branch.<name>.remote`). B@{u} refers to the remote-tracking branch for
+  the branch X taken from remote R, typically found at `refs/remotes/R/X`.
 
 '[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
-  `HEAD` if no branchname is specified). Since our push destination is
-  in a remote repository, of course, we report the local tracking branch
-  that corresponds to that branch (i.e., something in `refs/remotes/`).
+  `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
+  the remote-tracking branch that corresponds to that branch at the remote.
 +
 Here's an example to make it more clear:
 +

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
