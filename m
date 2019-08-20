Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6694C1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfHTPLJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHTPLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so12771485wrj.12
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ixdGTdA+F5/NYqrv6S58AM4+T/gEupor20mznp324LM=;
        b=XjqoRixKiZbVrS504W48C4Yfp1IQl89Io2d9LkyvTqiokaS/a5rT8fHLef0Lc+OJL/
         sMMtl4mnYh+n5Qw4t0KCZ6LlgBkKoDxBBsj3T62drWo5T4DzXZshHz00qwmqIxzJpGG3
         25sltkTj7D4bocAKHdeTRrlIoIDR6hidt5Q8AC+kU7xh5W1sJdxnsp4T8oZOroscSdd9
         4WzU72uZlGgmMiZUiVDvZa5gvngXD3wbqbWBLs5h8/3Y9P8Yu9DPwkeZZDTD3V2tAHZJ
         ohDQZn4cB2/nnvEjIvrebWSpLD7i0wqFLLgTyA95JphlkO+w7a43CCojBsAMSyMGsRko
         Qcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ixdGTdA+F5/NYqrv6S58AM4+T/gEupor20mznp324LM=;
        b=YwPsex7cP7Gf9VdrO2g7pTbYjY4pGnK6W2aWD4qk1rfmZTNd/4u3DXLoKOQMc5MfTJ
         H4a1p0FTdfApTlXYIHpezMhCmKFSlQnFsrM9KYXIjhFOPWYTxn3UjrUpkMveNc5kxxm9
         ZEOGJRWGIY9T5h4C/g1DXhD9xFa0NyYVcGOopljhqEGDe1aO08qGh0EDiZy4PM+9Cwnj
         qV2LM5FCQHpNqA0kHOSopsHtvHwBVEAZgAJ0EsUVIHP4Dhohcg4N80N1cBqCW9x1g3Nv
         YM67GBLGAyMsKpZaHCw+cEfNmZin3s5TGRrSHnPx7nJPKvO40PkkhniPqLaOKALjishW
         cF4w==
X-Gm-Message-State: APjAAAX9nQmKH+SkNBDJb/v9Aq7dcngehtSjbBhbEwx19+PYTDJcKMGn
        sN7dUa7lNwMvNIynUgMGQtrSojej
X-Google-Smtp-Source: APXvYqzqv0NKG0aFjP2gh49eXZ+DkxweMTBkga7cUGDS7Tr8C2SFYpRnZDbLcliM6Ir4UEa8iY3lUA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr35241474wrv.95.1566313866719;
        Tue, 20 Aug 2019 08:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm22914398wrd.26.2019.08.20.08.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:06 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:06 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:10:56 GMT
Message-Id: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC includes a potential direction to make the sparse-checkout more
user-friendly. While there, I also present a way to use a limited set of
patterns to gain a significant performance boost in very large repositories.

Sparse-checkout is only documented as a subsection of the read-tree docs
[1], which makes the feature hard to discover. Users have trouble navigating
the feature, especially at clone time [2], and have even resorted to
creating their own helper tools [3].

This RFC attempts to solve these problems using a new builtin. Here is a
sample workflow to give a feeling for how it can work:

In an existing repo:

$ git sparse-checkout init
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout add
/myFolder/*
^D
$ ls
myFile1.txt myFile2.txt myFolder
$ ls myFolder
a.c a.h
$ git sparse-checkout disable
$ ls
hiddenFolder myFile1.txt myFile2.txt myFolder

At clone time:

$ git clone --sparse origin repo
$ cd repo
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout add
/myFolder/*
^D
$ ls
myFile1.txt myFile2.txt myFolder

Here are some more specific details:

 * git sparse-checkout init enables core.sparseCheckout and populates the
   sparse-checkout file with patterns that match only the files at root.
   
   
 * git clone learns the --sparse argument to run git sparse-checkout init 
   before the first checkout.
   
   
 * git sparse-checkout add reads patterns from stdin, one per line, then
   adds them to the sparse-checkout file and refreshes the working
   directory.
   
   
 * git sparse-checkout disable removes the patterns from the sparse-checkout
   file, disables core.sparseCheckout, and refills the working directory.
   
   
 * git sparse-checkout list lists the contents of the sparse-checkout file.
   
   

The documentation for the sparse-checkout feature can now live primarily
with the git-sparse-checkout documentation.

Cone Mode
=========

What really got me interested in this area is a performance problem. If we
have N patterns in the sparse-checkout file and M entries in the index, then
we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
quadratic growth is not sustainable in a repo with 1,000+ patterns and
1,000,000+ index entries.

To solve this problem, I propose a new, more restrictive mode to
sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
matches at a directory level. This can then use hashsets for fast
performance -- O(M) instead of O(N*M). My hashset implementation is based on
the virtual filesystem hook in the VFS for Git custom code [4].

In cone mode, a user specifies a list of folders which the user wants every
file inside. In addition, the cone adds all blobs that are siblings of the
folders in the directory path to that folder. This makes the directories
look "hydrated" as a user drills down to those recursively-closed folders.
These directories are called "parent" folders, as a file matches them only
if the file's immediate parent is that directory.

When building a prototype of this feature, I used a separate file to contain
the list of recursively-closed folders and built the hashsets dynamically
based on that file. In this implementation, I tried to maximize the amount
of backwards-compatibility by storing all data in the sparse-checkout file
using patterns recognized by earlier Git versions.

For example, if we add A/B/C as a recursive folder, then we add the
following patterns to the sparse-checkout file:

/*
!/*/*
/A/*
!/A/*/*
/A/B/*
!/A/B/*/*
/A/B/C/*

The alternating positive/negative patterns say "include everything in this
folder, but exclude everything another level deeper". The final pattern has
no matching negation, so is a recursively closed pattern.

Note that I have some basic warnings to try and check that the
sparse-checkout file doesn't match what would be written by a cone-mode add.
In such a case, Git writes a warning to stderr and continues with the old
pattern matching algorithm. These checks are currently very barebones, and
would need to be updated with more robust checks for things like regex
characters in the middle of the pattern. As review moves forward (and if we
don't change the data storage) then we could spend more time on this.

Thanks, -Stolee

[1] https://git-scm.com/docs/git-read-tree#_sparse_checkoutSparse-checkout
documentation in git-read-tree.

[2] https://stackoverflow.com/a/4909267/127088Is it possible to do a sparse
checkout without checking out the whole repository first?

[3] http://www.marcoyuen.com/articles/2016/06/07/git-sparse.htmlA blog post
of a user's extra "git-sparse" helper.

[4] 
https://github.com/git/git/compare/fc5fd706ff733392053e6180086a4d7f96acc2af...01204f24c5349aa2fb0c474546d768946d315dab
The virtual filesystem hook in microsoft/git.

Derrick Stolee (8):
  sparse-checkout: create builtin with 'list' subcommand
  sparse-checkout: create 'init' subcommand
  clone: add --sparse mode
  sparse-checkout: 'add' subcommand
  sparse-checkout: create 'disable' subcommand
  sparse-checkout: add 'cone' mode
  sparse-checkout: use hashmaps for cone patterns
  sparse-checkout: init and add in cone mode

Jeff Hostetler (1):
  trace2:experiment: clear_ce_flags_1

 .gitignore                            |   1 +
 Documentation/config/core.txt         |   7 +-
 Documentation/git-clone.txt           |   8 +-
 Documentation/git-read-tree.txt       |   2 +-
 Documentation/git-sparse-checkout.txt | 146 ++++++++++
 Makefile                              |   1 +
 builtin.h                             |   1 +
 builtin/clone.c                       |  27 ++
 builtin/sparse-checkout.c             | 389 ++++++++++++++++++++++++++
 cache.h                               |   8 +-
 config.c                              |  10 +-
 dir.c                                 | 154 +++++++++-
 dir.h                                 |  27 ++
 environment.c                         |   2 +-
 git.c                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 195 +++++++++++++
 unpack-trees.c                        |  12 +-
 17 files changed, 976 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-316%2Fderrickstolee%2Fsparse-checkout%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-316/derrickstolee/sparse-checkout/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/316
-- 
gitgitgadget
