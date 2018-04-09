Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0B61F424
	for <e@80x24.org>; Mon,  9 Apr 2018 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeDIHeu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 03:34:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51977 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeDIHes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 03:34:48 -0400
Received: by mail-it0-f68.google.com with SMTP id b5-v6so9672967itj.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/cKPAjtr9t5XjoO6TWc3iNHCblDNmT69uuvStrikJJM=;
        b=dszvAiV0iQxGeGT/yjUKvUfmA5cSumsaIR+TJ+2hOewqtM4BQqDPi0/dDfem/HjHli
         ivzlfaw8/iusva+doF0EPwsquPvd2Zl4/7ez1NbxkZLg0+mLTHCwecVs8oQBO3TvOnVS
         OUYMTd2ZGHcWx+hoQF4kqsZU0fXDiXp9HobTClwq8d/7iw1fnh0mDnSEYsR2BXNs9kZQ
         ahU8YXK61N4B5D7QmVKEGrjJfY5Trke67wNhYxVDlXpsqIPY1MCXgjoKALFFc3+c7pYN
         xxJc3EcTVEtUVg3cGTUH2FsM7grJ7RYgQxhzH3yCY8t6xjakzfML0uHXK4FYHyl8CwEJ
         HrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/cKPAjtr9t5XjoO6TWc3iNHCblDNmT69uuvStrikJJM=;
        b=igRDhf1rL7+Ky7/kWKhaSnznAc2qjU8P0kLoIf87I1u+mxn+achn3WJCgAQ5P0UuLB
         ETAwvjK35MevyRNZJR9715HW7/SWCOR/sl2aYfVwtkWhRFY1UFvIo6eD3Uiv85UlOd3Y
         HzmSfbUjRuS3OXqiNcF+wGSP8dFVFKStNGdI1nIWV9tIs03tlMAdtYVFMvt4kSTExQbm
         lJqS6CrzhcvfleF8L9FhurZHC3ZIbOHPJki8QZ1MKm0wWLj01ZFnH1W2uQmSq55Gw4ZR
         Oa2QOiO4KW6d6lw3kxRdiOe4JLJO86HeSuiobPfXx1cAO6HCvHptURYxNi8P556kWxtD
         F58Q==
X-Gm-Message-State: ALQs6tA7ja50H44dE/igTHaSuAUgu/mlr5LdyNwhcmGNdO82cLAd/jWC
        SfZAoRMKjPdnQsDQ0RmQv6aMQA==
X-Google-Smtp-Source: AIpwx4+RFi0IsVIlBNxk4KzK+4bN1n5NkQBbQeti/n4RwMjwNTtfo5/ZFCFSxe5S9VYvTI5KwVgtAw==
X-Received: by 2002:a24:6f4f:: with SMTP id x76-v6mr27548383itb.77.1523259287768;
        Mon, 09 Apr 2018 00:34:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id a24sm9113485ioc.42.2018.04.09.00.34.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 Apr 2018 00:34:47 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] git-worktree.txt: recommend 'git worktree remove' over manual deletion
Date:   Mon,  9 Apr 2018 03:33:59 -0400
Message-Id: <20180409073400.19415-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cc73385cf6 (worktree remove: new command, 2018-02-12) implemented
and documented 'git worktree remove', it forgot to update existing
instructions suggesting manual deletion. Fix this oversight by
recommending 'git worktree remove' instead.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e7eb24ab85..bc9cd8b60f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -27,11 +27,12 @@ out more than one branch at a time.  With `git worktree add` a new working
 tree is associated with the repository.  This new working tree is called a
 "linked working tree" as opposed to the "main working tree" prepared by "git
 init" or "git clone".  A repository has one main working tree (if it's not a
-bare repository) and zero or more linked working trees.
+bare repository) and zero or more linked working trees. When you are done
+with a linked working tree, remove it with `git worktree remove`.
 
-When you are done with a linked working tree you can simply delete it.
-The working tree's administrative files in the repository (see
-"DETAILS" below) will eventually be removed automatically (see
+If a working tree is deleted without using `git worktree remove`, then
+its associated administrative files, which reside in the repository
+(see "DETAILS" below), will eventually be removed automatically (see
 `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
@@ -106,7 +107,7 @@ OPTIONS
 	By default, `add` refuses to create a new working tree when
 	`<commit-ish>` is a branch name and is already checked out by
 	another working tree and `remove` refuses to remove an unclean
-	working tree. This option overrides that safeguard.
+	working tree. This option overrides these safeguards.
 
 -b <new-branch>::
 -B <new-branch>::
@@ -278,8 +279,7 @@ $ pushd ../temp
 # ... hack hack hack ...
 $ git commit -a -m 'emergency fix for boss'
 $ popd
-$ rm -rf ../temp
-$ git worktree prune
+$ git worktree remove ../temp
 ------------
 
 BUGS
-- 
2.17.0.484.g0c8726318c

