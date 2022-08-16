Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDA9C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 17:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHPRL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHPRL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 13:11:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E30659EE
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 10:11:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n7so2187132wrv.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=F3eTAaJwXFoVYmZxgODgDF4kbZRnmblSLGbmeFh6rc8=;
        b=gAKVJ9ThJMLvc7W1RbNfmVAZ064FXwdK8p/a23fBgk8wz5TTfE9UJSWJafQ8LEuuhR
         /q2hYjpM2bHAQA4PeEPlWrlSCQlG7fd5mlxvrG2PI5jqHfWVdE2cVdJBuGA4lQJPSuFI
         R00uQnnHccBGbBNbR6/exZsEKNOLDWV/mn1GQ+LxleJ1NbNuXU9EK8Q2sWLVxw/Nu3el
         spHajAr675P+FF6zs0DsoTMfKv3LoQ03Htjmno3PwHQzo5HjAOZgrBUYYs3C5siLOFoZ
         P3W8RlS8CWmr55xyHnqEQzneG/5DOXH3LSUnjqQ9I/EHHQ3f+0sIO0j2eETf4NzEzrSy
         BpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=F3eTAaJwXFoVYmZxgODgDF4kbZRnmblSLGbmeFh6rc8=;
        b=Np9Rkb2ngURXNlM5jIqnRB1jFNetwsfBHyLmS+BVRlEWOi/zOGFABsniGhThVZOUvh
         vkvrB9Nt3RZQ0/lkDJB0/mmbAbAvy+hUz/+EEXvrAZuaFrp1qbyrdJDapFskDa4HgaR5
         M8zmkfHlbYkIWOhoMCfLU88blgNkCzFdtjlo8efJgiDvC+CKDRVMXUoysVNPbKRFcn4Q
         fu1yAapcjwHW6jg9YsUH7IcCjzDS5+ap7gxybcvCotu32604l68kuB+mCUaYv9CvGcLP
         CG2KHoPLFlaED7OUFeb7xf518ajm3UeJrzLvcOrRHAjivqv2UQV/O+oix9IK0U0njPjp
         AakQ==
X-Gm-Message-State: ACgBeo1N5TzBMfAWFqjwsRw+ffRX68Veppln/P3gPKv3j+4e2AU9j94S
        EzB2Qx3oCkyaJkrOqkkrq+G3KvYwRBA=
X-Google-Smtp-Source: AA6agR5y1Rozd9uL8iDK3LI5u8aiVufzdL+wbzPaF98I+GUhqP/GAAIkvX8VXgRs6k2zt/rqsCqLQQ==
X-Received: by 2002:a05:6000:4e:b0:21f:15fd:2d16 with SMTP id k14-20020a056000004e00b0021f15fd2d16mr12199295wrx.563.1660669913244;
        Tue, 16 Aug 2022 10:11:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe0d2000000b0021ea1bcc300sm10668484wri.56.2022.08.16.10.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:11:52 -0700 (PDT)
Message-Id: <pull.1315.v2.git.1660669912043.gitgitgadget@gmail.com>
In-Reply-To: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Rub=C3=A9n?= Justo via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 17:11:51 +0000
Subject: [PATCH v2] allow "-" as short-hand for "@{-1}" in "branch -d"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        rjusto <rjusto@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: rjusto <rjusto@gmail.com>

Align "branch -d" with the intuitive use of "-" as a short-hand
for "@{-1}", like in "checkout", "rebase" and "merge" commands.

$ git branch -d -      # short-hand for: "git branch -d @{-1}"
$ git branch -D -      # short-hand for: "git branch -D @{-1}"

So I can do:

$ git checkout work_to_review
$ git checkout -
$ git merge - # or git rebase -
$ git branch -d -

Signed-off-by: rjusto <rjusto@gmail.com>
---
    branch: allow "-" as a short-hand for "previous branch"
    
    Align "branch" with the intuitive use of "-" as a short-hand for
    "@{-1}", like in "checkout" and "merge" commands.
    
    $ git branch -d - # short-hand for: "git branch -d @{-1}" $ git branch
    -D - # short-hand for: "git branch -D @{-1}"
    
    Signed-off-by: rjusto rjusto@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1315%2Frjusto%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1315/rjusto/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1315

Range-diff vs v1:

 1:  3ba75097ea0 ! 1:  0fe48ada15b branch: allow "-" as a short-hand for "previous branch"
     @@ Metadata
      Author: rjusto <rjusto@gmail.com>
      
       ## Commit message ##
     -    branch: allow "-" as a short-hand for "previous branch"
     +    allow "-" as short-hand for "@{-1}" in "branch -d"
      
     -    Align "branch" with the intuitive use of "-" as a short-hand
     -    for "@{-1}", like in "checkout" and "merge" commands.
     +    Align "branch -d" with the intuitive use of "-" as a short-hand
     +    for "@{-1}", like in "checkout", "rebase" and "merge" commands.
      
          $ git branch -d -      # short-hand for: "git branch -d @{-1}"
          $ git branch -D -      # short-hand for: "git branch -D @{-1}"
      
     +    So I can do:
     +
     +    $ git checkout work_to_review
     +    $ git checkout -
     +    $ git merge - # or git rebase -
     +    $ git branch -d -
     +
          Signed-off-by: rjusto <rjusto@gmail.com>
      
       ## builtin/branch.c ##
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       			die(_("Couldn't look up commit object for HEAD"));
       	}
       
     -+	if ((argc == 1) && !strcmp(argv[0], "-")) {
     ++	if ((argc == 1) && !strcmp(argv[0], "-"))
      +		argv[0] = "@{-1}";
     -+	}
      +
       	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
       		char *target = NULL;


 builtin/branch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e998..7f7589bd4a8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -241,6 +241,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			die(_("Couldn't look up commit object for HEAD"));
 	}
 
+	if ((argc == 1) && !strcmp(argv[0], "-"))
+		argv[0] = "@{-1}";
+
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
gitgitgadget
