Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85F41F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbeGKWtT (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:19 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:49845 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbeGKWtT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:19 -0400
Received: by mail-io0-f201.google.com with SMTP id k9-v6so11311874iob.16
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mcWW84QJ0rIwjQLJKiUCF7wjMf8LgMuQgJQQqt2jl0U=;
        b=gtH6lfbp98fSZJhenffJnbNppAm4h5KiGEZtOCFSFKRE9nF4Cd6hwd5z+ANd6XOIMA
         ygrW6L1vSMp3wFlKKCuxFPmhxADTf2+J3RHFatXU1WFA2HzjxmHM/wV2jF9v3CF4z4Oa
         FSXrJVtEcZPri8+OWsUyR5+445j7QoXEgnSQBLUrGSBU/Sx9DimcpR2YTVT1TDG9KuhC
         lSp39uVftivW/yTXkcpan40SuyGjng1Ar/kI/huDfmuxHh4bN2G/ArK5wzr6wiXVgXj2
         mcULa6yoPJop7B8JOT+ZPDvhKQMusIBEFUveDnemz61KzkVMu8luZZSIIJmqBae6vHGB
         h3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mcWW84QJ0rIwjQLJKiUCF7wjMf8LgMuQgJQQqt2jl0U=;
        b=Ff8Ye7IWso2PKpCm/lXsfrVlC+qF5Tmu/VfgjTi64wdEOPKw94ahBkMrS0cHx2rzgg
         AC+7KgUok1MFG4T52tEnc/FlCBKKZpZNuZCBMT7yYDJShPS7RKS16MiUbE/TziMhBvR1
         GY5Qy6ouUHd2YZteVS5zj4ry5mVKNbH2gPDezDKX74EfKBxMd1E1v3vBNDbrPD1h6fMF
         LDoSJ4vlD7q14kHaib880L1yKEd/EaIXVFY3B8JGFPI97ZBOsJpCeGjqcjFfqM+aAyMW
         AecmHhZqKkdcGEWIKhMI4suIsiA62gWRSfSGwd7oi5zvcCkTt/+7zjeLNi8jjlTNoFzH
         br9A==
X-Gm-Message-State: AOUpUlH1ZgBdXbtsTu4TMhC22szggUgDafLscwxMWVy53Smmsu3uuMIi
        GAub5jt+555FU68S7wvXl5sAZhSyfpLNlt243a+Go0ZFouBFxZLcmCceIQL7vnvfSjI2EDHIlvX
        8/bjPh0De3bUYDOoCCiDUJN4Cp+6dFBMOLahvBCa1WAnHiSJJL1DPY4jBaoQw58yB5Ol7ilGmho
        So
X-Google-Smtp-Source: AAOMgpf/qfNOGoL6HCjsyCpREWZ9f2yKqnlbdEue5Ew+OIqmXFxCovX0Q9SrSaaJMCVzQD2MJdJPUxdFsc+P3VuEl76x
MIME-Version: 1.0
X-Received: by 2002:a6b:6114:: with SMTP id v20-v6mr265176iob.126.1531348967831;
 Wed, 11 Jul 2018 15:42:47 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:36 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <cover.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 0/6] Object store refactoring: commit graph
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on _both_ ds/commit-graph-fsck and sb/object-store-lookup,
following Stolee's suggestion.

(It also seems better to build it this way to me, since both these
branches are going into "next" according to the latest What's Cooking.)

Junio wrote in [1]:

> I've added SQUASH??? patch at the tip of each of the above,
> rebuilt 'pu' with them and pushed the result out.  It seems that
> Travis is happier with the result.
>
> Please do not forget to squash them in when/if rerolling.  If there
> is no need to change anything else other than squashing them, you
> can tell me to which commit in your series the fix needs to be
> squashed in (that would save me time to figure it out, obviously).

I'm rerolling because I also need to update the last patch with the new
lookup_commit() function signature that Stefan's sb/object-store-lookup
introduces. I have squashed the SQUASH??? patch into the corresponding
patch in this patch set.

Changes from v2:
 - now also based on sb/object-store-lookup in addition to
   ds/commit-graph-fsck (I rebased ds/commit-graph-fsck onto
   sb-object-store-lookup, then rebased this patch set onto the result)
 - patches 1-5 are unchanged
 - patch 6:
   - used "PRItime" instead of "ul" when printing a timestamp (the
     SQUASH??? patch)
   - updated invocations of lookup_commit() to take a repository object

[1] https://public-inbox.org/git/xmqqpnzt1myi.fsf@gitster-ct.c.googlers.com/

Jonathan Tan (6):
  commit-graph: refactor preparing commit graph
  object-store: add missing include
  commit-graph: add missing forward declaration
  commit-graph: add free_commit_graph
  commit-graph: store graph in struct object_store
  commit-graph: add repo arg to graph readers

 Makefile                   |   1 +
 builtin/commit-graph.c     |   2 +
 builtin/fsck.c             |   2 +-
 cache.h                    |   1 -
 commit-graph.c             | 108 +++++++++++++++++++++----------------
 commit-graph.h             |  11 ++--
 commit.c                   |   6 +--
 config.c                   |   5 --
 environment.c              |   1 -
 object-store.h             |   6 +++
 object.c                   |   5 ++
 ref-filter.c               |   2 +-
 t/helper/test-repository.c |  82 ++++++++++++++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 t/t5318-commit-graph.sh    |  35 ++++++++++++
 16 files changed, 207 insertions(+), 62 deletions(-)
 create mode 100644 t/helper/test-repository.c

-- 
2.18.0.203.gfac676dfb9-goog

