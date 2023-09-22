Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49FFE6FE35
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjIVOOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjIVOOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C964F100
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:14:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40528376459so22473065e9.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392083; x=1695996883; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=skLeq2nvBBzvxmp6HC9K0CtNMA60gxj69dP9a0fIJ7E=;
        b=aAZ1PWPFDYxV5h3HAQPQZStyCsSAHOa2WyKnKYOqHkNWbzw3Mp04vFWNDJ1dZGYGp/
         iOibykz96fVL3lrA1UKAPT0hK49V+Cl6wuSNfe4VlKeZ/MqRR+SVGA/xDQDBn2tpBire
         +HrA8NGkH+ZQNXwb1QxZWmgcphT9YdMqw1SE85DBkA0CfTHI7AytObr57rZhpPs6pd5K
         ufd6U0TB4bkmW4usHx9qRTQUh3joLjjTqpI5CosC64huLE+AJoIlKlm5hpLm82mOzNdg
         nft4v423wJ8AsyVMJYmiDyhhx5xEAIcHROaKiW96Mw+Epf19YdlOP15XtXMMB2SKOVv5
         ewpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392083; x=1695996883;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skLeq2nvBBzvxmp6HC9K0CtNMA60gxj69dP9a0fIJ7E=;
        b=TJ5HwJzYUnwL8xlR7COfFGaiP844EBJhRC3qq257bH1ANivy1e6Nzz9OXL8wqKhSS8
         d1oEKesSXGy8mEEgA0zoA/jsKGQlYagyZd5oFLBW7D+mCGEHBbdys89qmjCirPhhOfEB
         tRSroeZvVohmvX1TNm6mktwqdMrA56vXG2gz6OX69jZQaGkQzmlqQqfe1P36UQleHW3x
         1bAgS80VzMFaIDpTGmKAWF0zqFT7wQxVN61a6XGe9bRYYw2F2KO0N3iPlPlqG9n1FZdb
         7o1bxnvs28TrojPKNVh3t5pf9jsYcbh6W58runx1kDeRlSuNPyJocnfA1Yjq1Now/WlK
         vCjw==
X-Gm-Message-State: AOJu0YyhboIKIutq5kUL2r9VGQ+Th6Sgv/a5x1l6Vh0BWVYldrB55TAe
        tVmrUdzHg8ETB7uryThoMffJQtnUDMU=
X-Google-Smtp-Source: AGHT+IHGEKaO3rWGreaxGu0dBwobfLPtVwzBLmXdynPYF2t4jqOrtSRkm0ruzRSlktcpNdGu4nDDbA==
X-Received: by 2002:a05:600c:c5:b0:401:be77:9a50 with SMTP id u5-20020a05600c00c500b00401be779a50mr8484681wmm.8.1695392082896;
        Fri, 22 Sep 2023 07:14:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a7bc04b000000b003fee6e170f9sm4698555wmc.45.2023.09.22.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:14:42 -0700 (PDT)
Message-ID: <pull.1590.git.1695392082207.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:14:42 +0000
Subject: [PATCH] Documentation/git-status: add missing line breaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
    Documentation/git-status: add missing line breaks
    
    Most of the content in git help status is well formatted, as you can see
    here:
    
           In the following table, these three classes are shown in separate sections, and these characters are used for X and Y fields for the first two sections that show tracked paths:
    
           •   ' ' = unmodified
    
           •   M = modified
    
           •   T = file type changed (regular file, symbolic link or submodule)
    
           •   A = added
    
           •   D = deleted
    
           •   R = renamed
    
           •   C = copied (if config option status.renames is set to "copies")
    
           •   U = updated but unmerged
    
               X          Y     Meaning
               -------------------------------------------------
                        [AMD]   not updated
               M        [ MTD]  updated in index
               T        [ MTD]  type changed in index
               A        [ MTD]  added to index
               D                deleted from index
               R        [ MTD]  renamed in index
               C        [ MTD]  copied in index
               [MTARC]          index and work tree matches
               [ MTARC]    M    work tree changed since index
               [ MTARC]    T    type changed in work tree since index
               [ MTARC]    D    deleted in work tree
                           R    renamed in work tree
                           C    copied in work tree
               -------------------------------------------------
               D           D    unmerged, both deleted
               A           U    unmerged, added by us
               U           D    unmerged, deleted by them
               U           A    unmerged, added by them
               D           U    unmerged, deleted by us
               A           A    unmerged, both added
               U           U    unmerged, both modified
               -------------------------------------------------
               ?           ?    untracked
               !           !    ignored
               -------------------------------------------------
    
           Submodules have more state and instead report M the submodule has a different HEAD than recorded in the index m the submodule has modified content ? the submodule has untracked
           files since modified content or untracked files in a submodule cannot be added via git add in the superproject to prepare a commit.
    
           m and ? are applied recursively. For example if a nested submodule in a submodule contains an untracked file, this is reported as ? as well.
    
           If -b is used the short-format status is preceded by a line
    
               ## branchname tracking info
    
    
    Except for the part:
    
           Submodules have more state and instead report M the submodule has a different HEAD than recorded in the index m the submodule has modified content ? the submodule has untracked
    
    
    It appears that it wanted to be a table. With this patch, the html
    renders as:
    
    Submodules have more state and instead report
    
    M    the submodule has a different HEAD than
         recorded in the index
    m    the submodule has modified content
    ?    the submodule has untracked files
    
    since modified content or untracked files in a submodule cannot be added via git add in the superproject to prepare a commit.
    
    m and ? are applied recursively. For example if a nested submodule in a submodule contains an untracked file, this is reported as ? as well.
    
    If -b is used the short-format status is preceded by a line
    
    ## branchname tracking info
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1590%2Fjsoref%2Fgit-status-missing-line-break-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1590/jsoref/git-status-missing-line-break-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1590

 Documentation/git-status.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index a051b1e8f38..b27d127b5e2 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -245,10 +245,12 @@ U           U    unmerged, both modified
 ....
 
 Submodules have more state and instead report
+
 		M    the submodule has a different HEAD than
 		     recorded in the index
 		m    the submodule has modified content
 		?    the submodule has untracked files
+
 since modified content or untracked files in a submodule cannot be added
 via `git add` in the superproject to prepare a commit.
 

base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
-- 
gitgitgadget
