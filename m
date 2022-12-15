Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515BC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLOPHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLOPHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:07:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF82FBF9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i7so3347978wrv.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x8VZqUZAoXUdFKq6satrjW3r6Ehqpn75m/8swUeP3I=;
        b=JLCWmBvqMvChlAIE2uKJyhXtVtyfp7KqFHk3j8os0jiSpbTsBYHrS5JeUp/56VYr2l
         RZHZ2YaKLvF0VvXAT2fX9VECBpHojk9/Vt55QtaZrRWDRqG9JPSGVbLTS1TZPcmNvDv0
         C3vM1jPeA3FzLID/X9ioIlo8nNX9C9MYkpN70Fu1ZeMeJqdCYe2Hy/xlgG7o7G8t06pM
         S+KRIwUnPVHgtd1BOWoH7tql0lPyh94DFVTlluHe9JpnerC2G+eylaHF30pTacOvUIS+
         0Bp9wl9FBJDjTh+PoeAY2C+TPnmqvcRIicDH6YzVfs845yvVne7Kusgz8ns0Wd/l/ccP
         zfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x8VZqUZAoXUdFKq6satrjW3r6Ehqpn75m/8swUeP3I=;
        b=ohja7++rAJnGqfpuI2Z7td1G+cv7ekQzSNOLHmZMKtX/6v6r4dR+qXk1AUpgZiojO2
         zmYnJJUMCWWDq6CgNRK5799YPWZSKS6oMouue/9gUv8qdhBrEdgli3Zniz2OOW26MlDQ
         rqgV96EHX+8m3Q7h1dmjyieSGSd0/+v5boCSceMZvRkzvPlbaI/2KLFwuzOb/OLpH3xM
         6JkRff5tWSeCdJyPnZTGoBHuwwky6XoMZanSrbOQDWHOtylQIQNT3/YdVK4LJFVZRkfA
         0PdBQmlprblO6uYb5JSYfqEhoqsPhFDB2sJ5OL2uOPfuc64FQvusvsHvrrhyAZ6IqAE1
         ASBA==
X-Gm-Message-State: ANoB5pletovq2LAfIpaTVnVJ2KnE6zEv0smxw13prdlnbHD1UzagT2Le
        jGxSsiP2H7bMpXnSyIvT9nvZBfVd8Bs=
X-Google-Smtp-Source: AA0mqf5IY/OYSWYeB0usS+N79npK9kwWebDcPCeFeb9Ol+3uqz9P6KN8LnbY/8tnSKZENanBwMV72w==
X-Received: by 2002:a5d:5001:0:b0:242:86e7:72c2 with SMTP id e1-20020a5d5001000000b0024286e772c2mr24120594wrt.50.1671116821870;
        Thu, 15 Dec 2022 07:07:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0023677e1157fsm6339860wrw.56.2022.12.15.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:07:01 -0800 (PST)
Message-Id: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Dec 2022 15:06:56 +0000
Subject: [PATCH v3 0/4] Optionally skip hashing index on write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Writing the index is a critical action that takes place in multiple Git
commands. The recent performance improvements available with the sparse
index show how often the I/O costs around the index can affect different Git
commands, although reading the index takes place more often than a write.

The index is written through the hashfile API, both as a buffered write and
as a computation of its trailing hash. This trailing hash is an expectation
of the file format: several optional index extensions are provided using
indicators immediately preceding the trailing hash. 'git fsck' will complain
if the trailing hash does not match the contents of the file up to that
point.

However, computing the hash is expensive. This is even more expensive now
that we've moved to sha1dc instead of hardware-accelerated SHA1
computations.

This series provides a new config option, index.skipHash, that allows users
to disable computing the hash as Git writes the index. In this case, the
trailing hash is stored as the null hash (all bytes are zero).

The implementation is rather simple, but the patches organize different
aspects in a way that we could split things out:

 * Patch 1 adds a 'skip_hash' option to 'struct hashfile' that creates this
   as a general option to the hashwrite API.
 * The motivation in Patch 1 avoids the talk about the chunk-format API and
   instead focuses on the index as the first example that could make use of
   this.
 * Patch 2 creates the index.skipHash config option and updates 'git fsck'
   to ignore a null hash on the index. This is demonstrated by a very simple
   test.
 * Patch 3 creates a test helper to get the trailing hash of a file, and
   adds a concrete check on the trailing hash when index.skipHash=true.
 * Patch 4 (which could be deferred until later) adds index.skipHash=true as
   an implication of feature.manyFiles and as a setting in Scalar.

The end result is that index writes speed up significantly, enough that 'git
update-index --force-write' improves by 1.75x.

Similar patches appeared in my earlier refs RFC [1].

[1]
https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/


Updates since v2
================

 * Patch 2 now has additional details about why to use the config option in
   its message. The discussion about why the index is special is included in
   the commit message.


Updates since v1
================

 * In Patch 1, use hashcler() instead of memset().
 * In Patches 2 and 4, be explicit about which Git versions will exhibit
   different behavior when reading an index with a null trailing hash.
 * In Patch 2, used a more compact way of loading from config.
 * In Patch 2 (and following) dropped the sub-shell in t1600-index.sh.
 * In Patch 3, dropped back-ticks when using a multi-line pipe.
 * In Patch 4, use "! cmp" instead of "! test_cmp"


Updates since RFC
=================

 * The config name is now index.skipHash to make it more clear that the
   default is to not skip the hash, and choosing this option requires a true
   value.
 * Use oidread() instead of an ad-hoc loop.
 * Patches 3 and 4 are new. 3 adds some extra test verification that wasn't
   in the RFC.
 * I think that patch 4 is helpful to see now, but I could understand if we
   wanted to defer that patch until after index.skipHash has had more time
   to bake.

Thanks, -Stolee

Derrick Stolee (4):
  hashfile: allow skipping the hash function
  read-cache: add index.skipHash config option
  test-lib-functions: add helper for trailing hash
  features: feature.manyFiles implies fast index writes

 Documentation/config/feature.txt |  5 +++++
 Documentation/config/index.txt   | 11 +++++++++++
 csum-file.c                      | 14 +++++++++++---
 csum-file.h                      |  7 +++++++
 read-cache.c                     | 15 ++++++++++++++-
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 20 ++++++++++++++++++++
 t/test-lib-functions.sh          |  8 ++++++++
 10 files changed, 80 insertions(+), 4 deletions(-)


base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1439%2Fderrickstolee%2Fhashfile-skip-hash-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1439/derrickstolee/hashfile-skip-hash-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1439

Range-diff vs v2:

 1:  b582d681581 = 1:  b582d681581 hashfile: allow skipping the hash function
 2:  c8a2fd3a470 ! 2:  00738c81a12 read-cache: add index.skipHash config option
     @@ Commit message
          critical that the sparse index was created specifically to reduce the
          size of the index to make these writes (and reads) faster.
      
     +    This trade-off between file stability at rest and write-time performance
     +    is not easy to balance. The index is an interesting case for a couple
     +    reasons:
     +
     +    1. Writes block users. Writing the index takes place in many user-
     +       blocking foreground operations. The speed improvement directly
     +       impacts their use. Other file formats are typically written in the
     +       background (commit-graph, multi-pack-index) or are super-critical to
     +       correctness (pack-files).
     +
     +    2. Index files are short lived. It is rare that a user leaves an index
     +       for a long time with many staged changes. Outside of staged changes,
     +       the index can be completely destroyed and rewritten with minimal
     +       impact to the user.
     +
          Following a similar approach to one used in the microsoft/git fork [1],
          add a new config option (index.skipHash) that allows disabling this
          hashing during the index write. The cost is that we can no longer
     @@ Documentation/config/index.txt: index.version::
      +
      +index.skipHash::
      +	When enabled, do not compute the trailing hash for the index file.
     -+	Instead, write a trailing set of bytes with value zero, indicating
     ++	This accelerates Git commands that manipulate the index, such as
     ++	`git add`, `git commit`, or `git status`. Instead of storing the
     ++	checksum, write a trailing set of bytes with value zero, indicating
      +	that the computation was skipped.
      ++
      +If you enable `index.skipHash`, then Git clients older than 2.13.0 will
 3:  813e81a0582 = 3:  86370af1351 test-lib-functions: add helper for trailing hash
 4:  e640dff53dd = 4:  6490bd445eb features: feature.manyFiles implies fast index writes

-- 
gitgitgadget
