Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDEFC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiCVRaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiCVRaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:30:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E59465C0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so9385292wrr.9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GlkcejTdyZaq7T7lKi0DvuL2FatrqLht/A7gvPZZgCM=;
        b=po68P9nYU7BzlINufe5HOph3hd327LNM9J+mATST4HW6FNoFKkn/lcTV6zlMNUsMJl
         xel/o+B5b2H72V6i5rbsQIFfsrG3IflZRuW0LzuZyauhVHMOM47k4mXp15nhXMkUlSoi
         mk2mwdLz0IuIVgufMiaQIjTFGPALxtlgWp6+k7AoCvr6FJNGCn6gbEjeSlQmOhUG5mGS
         qGrM4RHWlouJSCH33KFuBWOAsCgVvN4p6fheJm1NzNZPoDONiZei+TvufoPlj8fe24PK
         nzDbW9B2oJ/2eKUNlfgZjclhbiU0Gz7yKDKgRxYVTef7S3lJ7jeYyjaZnLc70sBhBAhj
         joqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GlkcejTdyZaq7T7lKi0DvuL2FatrqLht/A7gvPZZgCM=;
        b=pnlBlj/FiACmiFKNbnn344r47i50Kqq0S7hwBckVMf13KV6CMqChkct+qXSiaVTTtr
         eboQUdR1jtXdvlj5mv5zykVb4ftpO0ctdwRpiOQBPoOCPjJvqJ8q6f6vGl1+RXrn81D5
         zaTS2pYk/YUJct1QmwtR+BQaPkTkI9VJIzrHc8RPjcH1kc7tOeCClIiI1tHt4Ryf2Kwe
         oHOhgO2eZxDAl9k46jHZexHrbhLQIJ7BjksBYkZ2Tgo01nv3aMQe6JgC36W3SlN4xEJb
         XPJ3Ts36UoIYBOA5Nsqe8OLFQfAGK+jBBU5dG9ZPxYVsRxovzKU6UqzpDg8WFuRpDXuB
         6bvA==
X-Gm-Message-State: AOAM5304SF5zaBpVTu31vxyGKtUbEeMzIFP1zRe/88vEp+iDK+JkDMgj
        QA6PNrCM+3sqsYyRwsr7BdPRCkgfUNY=
X-Google-Smtp-Source: ABdhPJwx2nfZxOpwiqILzVsiE9LqxyammOw7l7ojJAQR0WUIYQN25YOUZAyiecUG/MUUTDnryXWAag==
X-Received: by 2002:a5d:64ce:0:b0:204:1177:e1c4 with SMTP id f14-20020a5d64ce000000b002041177e1c4mr9134520wri.692.1647970120808;
        Tue, 22 Mar 2022 10:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm2497222wmn.46.2022.03.22.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:28:39 -0700 (PDT)
Message-Id: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:28:34 +0000
Subject: [PATCH 0/5] Partial bundle follow ups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


For Junio
=========

This is based on master, which recently took ds/partial-bundles.

There are a couple conflicts with 'seen':

 * rc/fetch-refetch adds the "--refetch" option right next to where I remove
   an instance of CL_ARG__FILTER.
 * tb/cruft-packs updates the add_unseen_recent_objects_to_traversal()
   method, but this series changes one call from using "&revs" to using
   "revs".

Hopefully these are easy conflicts to resolve.


Series Goals
============

These are a few cleanups that were discussed as part of ds/partial-bundles.

 * Patch 1 removes the CL_ARG__FILTER macro.
 * Patches 2-3 help parse --filter directly into a revs.filter member
   instead of copying it from another filter_options.
 * Patches 4-5 add output of the hash function capability in 'git bundle
   verify'. It also moves the capability output to the end, since it looks a
   bit strange in the current location when there are boundary commits.


Series Non-Goals
================

Some items were discussed that I either attempted and dropped, or delayed
for another series:

 * create_bundle() in bundle.c does two commit walks: first to discover the
   boundary commits to write into the bundle header, and then another that
   happens when constructing the pack-file. It looks like this could be
   avoided if there will not be any boundary, but there are additional
   checks in write_bundle_refs() that look for the SHOWN bit on the commit
   objects in order to determine if a requested ref would be excluded by the
   rev-list options. This behavior seems important, so I did not remove it.

 * 'git clone --bare partial.bdl" should work when partial.bdl is a partial
   bundle. However, this requires changing the way we configure partial
   cloned repositories to not rely on a remote in order to understand an
   object filter. I'm working on this as a parallel series that will likely
   require more discussion than these small cleanups.

 * Ævar pointed out some newly-visible memory leaks due to moving the filter
   out of a static global. After looking at the recommended change, it seems
   that we actually need to be more careful about freeing the revs and not
   just revs.filter.

Thanks, -Stolee

Derrick Stolee (5):
  list-objects-filter: remove CL_ARG__FILTER
  pack-objects: move revs out of get_object_list()
  pack-objects: parse --filter directly into revs.filter
  bundle: move capabilities to end of 'verify'
  bundle: output hash information in 'verify'

 Documentation/git-bundle.txt  | 10 +++++-----
 builtin/fetch-pack.c          |  4 ++--
 builtin/pack-objects.c        | 37 +++++++++++++++++------------------
 bundle.c                      | 11 ++++++-----
 list-objects-filter-options.h |  5 +----
 revision.c                    |  4 ++--
 t/t6020-bundle-misc.sh        | 26 ++++++++++++++++--------
 7 files changed, 52 insertions(+), 45 deletions(-)


base-commit: f01e51a7cfd75131b7266131b1f7540ce0a8e5c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1186%2Fderrickstolee%2Fpartial-bundle-follow-up-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1186/derrickstolee/partial-bundle-follow-up-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1186
-- 
gitgitgadget
