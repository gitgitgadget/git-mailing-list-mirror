Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3251F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfFJXfY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:24 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36457 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbfFJXfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:24 -0400
Received: by mail-ed1-f49.google.com with SMTP id k21so13635454edq.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=+6RhozrWuAU+g9XzrrAB/FqocJQ7yncsJIu13nDQ81A=;
        b=mZD7SS1p0mDieK9aGgKONHaXbZTq3PWM57L5aHAJMKTLcBgBPYudJJB3S8uNBa017w
         Za6bxDHG1oxTcPS2J91GW3zbA059O7DhKcrbud3Sr4fZdCy4dNUCXAFsfhuTWHoersMl
         k8Gxme7816RcdfFboVgn4ZbgkEGhPVYcfymMUvMZC4fzAdDFzv7rfsmjQNB/fbF5c6h0
         ve5WD3TkqWTp23svNysCpiwqZNVwDbjYehQ2xI3zcDj59WPuhui7msfatBuBnNs+LY4T
         w3OSZNBqYC1dTY/iwlYW1SBTLcRvwcNTyeW7rRFCJDyBdLd1I7WIx52qJoFYeAKExNjm
         shpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=+6RhozrWuAU+g9XzrrAB/FqocJQ7yncsJIu13nDQ81A=;
        b=KlaYTmMy/lj42IsYDSPmlJZKzB75Y/gGc7wptJx/gJaWEuiOg36GYRd4EH6Ur4Educ
         FAC3J2q3I99txRQ1e+oUuV3QjYBe/veLYckjznbdMvOUNam23C4iooH7jQ1CcZyQMM/9
         2mQ7F9CuRXfMJVsm1DbU8aNgWVYQHJICz2JmK3nZdEY2ASf9kcuOCvlktJ2ksxVQhPju
         MkdUdRGDpFxL1p4yxtOYv2E69eNTRsgutNPNi3wcc1MTCN8tP3fWwknDgBYwozla89Yq
         y5yxjqaFef05hWCpk4Afys+6b2ll3BBzI7WPL1+5bFqXafwKmBprPXf6vl6LXN/BA59t
         AZZw==
X-Gm-Message-State: APjAAAXMQQJl1TPEjn3L1wdy9JdQFOoZQ1Hm6mVsiEWVDYgqBv5mj6eM
        l5HhV6OjKf2W6hRh5xYJNHH4GP+A
X-Google-Smtp-Source: APXvYqzhNJzOsRjoFPORAo/eIwwdidUJKVXhL+VMpv6LkpOOSJL6Ekn2JwoL7vvcVeH36R40xSlSIA==
X-Received: by 2002:a50:f599:: with SMTP id u25mr43973487edm.195.1560209721774;
        Mon, 10 Jun 2019 16:35:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s27sm2800321eda.36.2019.06.10.16.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:21 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:21 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:09 GMT
Message-Id: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/11] Create 'expire' and 'repack' verbs for git-multi-pack-index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index provides a fast way to find an object among a large
list of pack-files. It stores a single pack-reference for each object id, so
duplicate objects are ignored. Among a list of pack-files storing the same
object, the most-recently modified one is used.

Create new subcommands for the multi-pack-index builtin.

 * 'git multi-pack-index expire': If we have a pack-file indexed by the
   multi-pack-index, but all objects in that pack are duplicated in
   more-recently modified packs, then delete that pack (and any others like
   it). Delete the reference to that pack in the multi-pack-index.
   
   
 * 'git multi-pack-index repack --batch-size=': Starting from the oldest
   pack-files covered by the multi-pack-index, find those whose "expected
   size" is below the batch size until we have a collection of packs whose
   expected sizes add up to the batch size. We compute the expected size by
   multiplying the number of referenced objects by the pack-size and
   dividing by the total number of objects in the pack. If the batch-size is
   zero, then select all packs. Create a new pack containing all objects
   that the multi-pack-index references to those packs.
   
   

This allows us to create a new pattern for repacking objects: run 'repack'.
After enough time has passed that all Git commands that started before the
last 'repack' are finished, run 'expire' again. This approach has some
advantages over the existing "repack everything" model:

 1. Incremental. We can repack a small batch of objects at a time, instead
    of repacking all reachable objects. We can also limit ourselves to the
    objects that do not appear in newer pack-files.
    
    
 2. Highly Available. By adding a new pack-file (and not deleting the old
    pack-files) we do not interrupt concurrent Git commands, and do not
    suffer performance degradation. By expiring only pack-files that have no
    referenced objects, we know that Git commands that are doing normal
    object lookups* will not be interrupted.
    
    

 * Note: if someone concurrently runs a Git command that uses
   get_all_packs(), then that command could try to read the pack-files and
   pack-indexes that we are deleting during an expire command. Such commands
   are usually related to object maintenance (i.e. fsck, gc, pack-objects)
   or are related to less-often-used features (i.e. fast-import,
   http-backend, server-info).

We are using this approach in VFS for Git to do background maintenance of
the "shared object cache" which is a Git alternate directory filled with
packfiles containing commits and trees. We currently download pack-files on
an hourly basis to keep up-to-date with the central server. The cache
servers supply packs on an hourly and daily basis, so most of the hourly
packs become useless after a new daily pack is downloaded. The 'expire'
command would clear out most of those packs, but many will still remain with
fewer than 100 objects remaining. The 'repack' command (with a batch size of
1-3gb, probably) can condense the remaining packs in commands that run for
1-3 min at a time. Since the daily packs range from 100-250mb, we will also
combine and condense those packs.

This series is the same as v6 of an earlier series [1].

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.92.git.gitgitgadget@gmail.com/T/#u

Derrick Stolee (11):
  repack: refactor pack deletion for future use
  Docs: rearrange subcommands for multi-pack-index
  multi-pack-index: prepare for 'expire' subcommand
  midx: simplify computation of pack name lengths
  midx: refactor permutation logic and pack sorting
  multi-pack-index: implement 'expire' subcommand
  multi-pack-index: prepare 'repack' subcommand
  midx: implement midx_repack()
  multi-pack-index: test expire while adding packs
  midx: add test that 'expire' respects .keep files
  t5319-multi-pack-index.sh: test batch size zero

 Documentation/git-multi-pack-index.txt |  32 +-
 builtin/multi-pack-index.c             |  14 +-
 builtin/repack.c                       |  14 +-
 midx.c                                 | 440 +++++++++++++++++++------
 midx.h                                 |   2 +
 packfile.c                             |  28 ++
 packfile.h                             |   7 +
 t/t5319-multi-pack-index.sh            | 184 +++++++++++
 8 files changed, 602 insertions(+), 119 deletions(-)


base-commit: af96fe3392fb078cb5447bcb94f2ed8d79d0a4a8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-261%2Fderrickstolee%2Fmidx-expire%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-261/derrickstolee/midx-expire/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/261
-- 
gitgitgadget
