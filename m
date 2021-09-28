Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB13C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3780D60E54
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhI1PME (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbhI1PMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444CDC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k7so6765459wrd.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZIl+58gm8X2P9YdkLamBfkCWqd8Vj932cJhEja9U5TI=;
        b=Qvvy4x1M8wWowJ0kRJJbg/Jt4iqVkn4PMk7P/ZiEY/h0lXrEVFMPXfmuiFr8cnvnKs
         PemMN4sclgAD44TOWYpvVqVND9N7hT2gAbmRbtAvPNsryPHQIjf8FH1NslXy6kP3LaeH
         tPWHTodSFiOIKTjShko4Xl0jVLug8st2g+owh1wdGEdl3b2waxGxrc0Jgr0neY3JPTTs
         xG5H9pCibmsLYVSwtXhizDJwaOyYLy6JpKTZv3JYMwJ0cecekMbYqSJo+dmdJaGC7nEg
         aln/SElLw4rQoTvrtH+lyP+kBbcwXYJbA8JrM+IVz1aLixuWXe5I316v2eUJsvcS9UDv
         +FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ZIl+58gm8X2P9YdkLamBfkCWqd8Vj932cJhEja9U5TI=;
        b=KJh4E6Go4NM1zcpVltqReHl0vk+YSn1dbe18epX7fZMFwWUboOw4SuZASJ56AdVMkw
         L/160OQk+BljWsB0dj8omb29BLF6WWO5zF/jjAZMo5B5F4+NRQyDcygu6sFM2ZwccVpN
         s0RyhOzLfojfPjyDCws1XfRnY/Thi4BmLWAuT9+6DEt7ifn4TW6MtgFUd5hUEMxWfUeT
         +U1DBANwD1w8PhUooReSZny2Qj7X9w/mcpmUKRx0rTQq4N5o6uYPRMYZdFT9D9fQ8HZp
         4F5ttIvhadWGSXk95g3v1XfUz+1/POdRpzvh49eLA6OzJtGiTM/Jl5yst1S0a2n4C/m/
         EsLw==
X-Gm-Message-State: AOAM533zJtAELE2mfrhiTfDQ0KyTY1SQR5qIcnPpxP+yzStWykszuwjk
        DXTTL9Bi4SLxTmjOp/9lkM04AT9dM3c=
X-Google-Smtp-Source: ABdhPJxpG9WVLD6WUnwMAZvd/XQUzCp36DwnvK3EIid69cnbAmJ7JUhgriUykBRz0kii/1HPEr2mVg==
X-Received: by 2002:a5d:4fc3:: with SMTP id h3mr651250wrw.380.1632841818808;
        Tue, 28 Sep 2021 08:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm3475586wmf.3.2021.09.28.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:18 -0700 (PDT)
Message-Id: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:09:57 +0000
Subject: [PATCH v3 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reftable format is described in Documentation/technical/reftable.txt.

This is a fully reentrant implementation of reading and writing the reftable
file format, and should be suitable for embedding in libgit2 too. It does
not hook the code up to git to function as a ref storage backend yet.

v2:

 * fold in OpenBSD fixes by Carlo Belón.

Han-Wen Nienhuys (19):
  hash.h: provide constants for the hash IDs
  reftable: RFC: add LICENSE
  reftable: add error related functionality
  reftable: utility functions
  reftable: add blocksource, an abstraction for random access reads
  reftable: (de)serialization for the polymorphic record type.
  Provide zlib's uncompress2 from compat/zlib-compat.c
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: generic interface to tables
  reftable: read reftable files
  reftable: reftable file level tests
  reftable: add a heap-based priority queue for reftable records
  reftable: add merged table view
  reftable: implement refname validation
  reftable: implement stack, a mutable database of reftable files.
  reftable: add dump utility
  Add "test-tool dump-reftable" command.

 Makefile                                   |   53 +-
 ci/lib.sh                                  |    1 +
 compat/.gitattributes                      |    1 +
 compat/zlib-uncompress2.c                  |   95 ++
 config.mak.uname                           |    4 +
 configure.ac                               |   13 +
 contrib/buildsystems/CMakeLists.txt        |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm |   11 +-
 hash.h                                     |    6 +
 object-file.c                              |    7 +-
 reftable/LICENSE                           |   31 +
 reftable/basics.c                          |  128 ++
 reftable/basics.h                          |   60 +
 reftable/basics_test.c                     |   98 ++
 reftable/block.c                           |  439 ++++++
 reftable/block.h                           |  127 ++
 reftable/block_test.c                      |  120 ++
 reftable/blocksource.c                     |  148 +++
 reftable/blocksource.h                     |   22 +
 reftable/constants.h                       |   21 +
 reftable/dump.c                            |  107 ++
 reftable/error.c                           |   41 +
 reftable/generic.c                         |  169 +++
 reftable/generic.h                         |   32 +
 reftable/iter.c                            |  194 +++
 reftable/iter.h                            |   69 +
 reftable/merged.c                          |  362 +++++
 reftable/merged.h                          |   35 +
 reftable/merged_test.c                     |  292 ++++
 reftable/pq.c                              |  105 ++
 reftable/pq.h                              |   33 +
 reftable/pq_test.c                         |   82 ++
 reftable/publicbasics.c                    |   58 +
 reftable/reader.c                          |  801 +++++++++++
 reftable/reader.h                          |   66 +
 reftable/readwrite_test.c                  |  652 +++++++++
 reftable/record.c                          | 1212 +++++++++++++++++
 reftable/record.h                          |  139 ++
 reftable/record_test.c                     |  412 ++++++
 reftable/refname.c                         |  209 +++
 reftable/refname.h                         |   29 +
 reftable/refname_test.c                    |  102 ++
 reftable/reftable-blocksource.h            |   49 +
 reftable/reftable-error.h                  |   62 +
 reftable/reftable-generic.h                |   47 +
 reftable/reftable-iterator.h               |   39 +
 reftable/reftable-malloc.h                 |   18 +
 reftable/reftable-merged.h                 |   72 +
 reftable/reftable-reader.h                 |  101 ++
 reftable/reftable-record.h                 |  114 ++
 reftable/reftable-stack.h                  |  128 ++
 reftable/reftable-tests.h                  |   23 +
 reftable/reftable-writer.h                 |  148 +++
 reftable/reftable.c                        |  115 ++
 reftable/stack.c                           | 1396 ++++++++++++++++++++
 reftable/stack.h                           |   41 +
 reftable/stack_test.c                      |  949 +++++++++++++
 reftable/system.h                          |   32 +
 reftable/test_framework.c                  |   23 +
 reftable/test_framework.h                  |   53 +
 reftable/tree.c                            |   63 +
 reftable/tree.h                            |   34 +
 reftable/tree_test.c                       |   61 +
 reftable/writer.c                          |  690 ++++++++++
 reftable/writer.h                          |   50 +
 t/helper/test-reftable.c                   |   21 +
 t/helper/test-tool.c                       |    4 +-
 t/helper/test-tool.h                       |    2 +
 t/t0032-reftable-unittest.sh               |   15 +
 69 files changed, 10938 insertions(+), 12 deletions(-)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/error.c
 create mode 100644 reftable/generic.c
 create mode 100644 reftable/generic.h
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/readwrite_test.c
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-blocksource.h
 create mode 100644 reftable/reftable-error.h
 create mode 100644 reftable/reftable-generic.h
 create mode 100644 reftable/reftable-iterator.h
 create mode 100644 reftable/reftable-malloc.h
 create mode 100644 reftable/reftable-merged.h
 create mode 100644 reftable/reftable-reader.h
 create mode 100644 reftable/reftable-record.h
 create mode 100644 reftable/reftable-stack.h
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable-writer.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0032-reftable-unittest.sh


base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1081%2Fhanwen%2Fjust-library-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1081/hanwen/just-library-v3
Pull-Request: https://github.com/git/git/pull/1081

Range-diff vs v2:

  1:  8534c69cf84 =  1:  b2f8dc32bfc hash.h: provide constants for the hash IDs
  2:  52968d8e83f =  2:  2597ddfeae1 reftable: RFC: add LICENSE
  3:  84c8b396df5 =  3:  41b1ff1293f reftable: add error related functionality
  4:  fa58f3d73e7 =  4:  c03043c5e63 reftable: utility functions
  5:  e9206532126 =  5:  317a6aaa357 reftable: add blocksource, an abstraction for random access reads
  6:  651e195fe77 =  6:  55e66b7a74f reftable: (de)serialization for the polymorphic record type.
  7:  e595dbc6c84 !  7:  4f6ecd3646a Provide zlib's uncompress2 from compat/zlib-compat.c
     @@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
       	FILENO_IS_A_MACRO = UnfortunatelyYes
       endif
       ifeq ($(uname_S),OpenBSD)
     -+	NO_UNCOMPRESS2 = YesPlease
      +	# Versions < 7.0 need compatibility layer
      +	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
      +		NO_UNCOMPRESS2 = UnfortunatelyYes
  8:  97f7ee04886 =  8:  04f2d74df51 reftable: reading/writing blocks
  9:  8d2e8be5795 =  9:  f6c2da61208 reftable: a generic binary tree implementation
 10:  965af6ec065 = 10:  277a1f662e3 reftable: write reftable files
 11:  4e259380fda = 11:  f97182dec1f reftable: generic interface to tables
 12:  a43d3512164 = 12:  13de5d03a71 reftable: read reftable files
 13:  f0e159cd853 = 13:  8efc3c2b6ab reftable: reftable file level tests
 14:  5a5c108d601 = 14:  e89b16a37e6 reftable: add a heap-based priority queue for reftable records
 15:  905ffa58f36 = 15:  40a91b14be8 reftable: add merged table view
 16:  e9598889af2 = 16:  46c2ddf07cf reftable: implement refname validation
 17:  8b0ee68c636 ! 17:  3db887bc078 reftable: implement stack, a mutable database of reftable files.
     @@ reftable/stack.c (new)
      +
      +int read_lines(const char *filename, char ***namesp)
      +{
     -+	int fd = open(filename, O_RDONLY, 0644);
     ++	int fd = open(filename, O_RDONLY);
      +	int err = 0;
      +	if (fd < 0) {
      +		if (errno == ENOENT) {
 18:  a9bebe45bde = 18:  795a15000fb reftable: add dump utility
 19:  104fbc7502f = 19:  7b3215aef39 Add "test-tool dump-reftable" command.

-- 
gitgitgadget
