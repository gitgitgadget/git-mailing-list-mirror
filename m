Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31CC1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162457AbeBNTAo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:00:44 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:50043 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162210AbeBNTAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:43 -0500
Received: by mail-qk0-f201.google.com with SMTP id y66so4815109qke.16
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aQatDqEueelbRf/ydqzoWtlLUEGMyfNJAzhNy+Ojn50=;
        b=ut/yOkWj+COad5Lci5tS08ToyjwUwubjFkw9e8O9RRHKINcYc4dzUDZeG22xdYambA
         bTlAaE2CcDeBMA374cLCvxKYB1S37prNJD3S/4GYN7jAsLt1MjIY1uWO/GsCznGYFNMR
         O+Gcq/sSzyHYCxryC8X9+0TMIVcULAL9oUijo+Jsw+gnWPXjErguWHoyvfwtUFDma/iS
         1y2ENae6imX8cRUumS3OJzFtl7lYqxEFmChScd+5XI7fDwSBbPyDK/uEV2AdRVausG5K
         QVSzXxZbHcOilouAIrqkbnGkEboSA9/lhsiqevR3/KeE2WRMp8tnWOV1oemFCLbv/hkS
         oCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aQatDqEueelbRf/ydqzoWtlLUEGMyfNJAzhNy+Ojn50=;
        b=VV+uIqcK/4B8KlDSQG+2E/W7S/MSOLO4HrM8bXg5PsBD3N8Jijj1SAlYohdRpd5oWV
         OJD+Vtg30rwPkWUbZBGvRgs8PRTDMcd42nWzwYumBSDByxkHRUIE9U4AYa5Vsmi+PKx3
         yGgQoJJ2xc2j82WwNb8dpcVSO9hCXx4rN48LhKfJNuLBO7PKfbAKp0MA4B3AiFM6jec5
         /lCDMzTMr9F/BnMoBAqOps9cNJhUvC14OSLePjg9tsFePUpEtSN+vb6kg+tZiWisB5Cr
         PabIxLjEMqltYkRhUY0Ktr9AumsYntXNTkASgsDxo90QCcKzqCqOOaA25eLw+MWEu7K+
         VowA==
X-Gm-Message-State: APf1xPBAcuqDqNqOie0Yiua6UYmPsCV8ij6f5z/Q+mKUHQkHEqBcRkCx
        h++S9uyFzMzmFPw/dESItS5EWXOBTO4PWLyq+tO9Rd6LZ7kIoruQndQZvoUHk8/7aZ1wKq1DltM
        hBbnRGnEyAVXsIiG/DB2DlXD51kXGs24R4cOIPRG5olQSPiINy0nhXHW4Rw==
X-Google-Smtp-Source: AH8x2269TlGdxWziWd/MekzKOZKBIXgZp7TRD/A3tdei/sqY+ItzB4AWPiKQoM7oo3t8gCPRWU2Pz3aPk/Q=
MIME-Version: 1.0
X-Received: by 10.200.33.162 with SMTP id 31mr22196qty.27.1518634841951; Wed,
 14 Feb 2018 11:00:41 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:22 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180214185959.221906-1-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 00/37] removal of some c++ keywords
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One person was interested enough for me to go back through and also
rename all the paired 'old' variables to match the new names for the
variables which were named 'new'.

Brandon Williams (37):
  object_info: change member name from 'typename' to 'type_name'
  object: rename function 'typename' to 'type_name'
  blame: rename 'this' variables
  pack-objects: rename 'this' variables
  rev-parse: rename 'this' variable
  diff: rename 'this' variables
  apply: rename 'try' variables
  apply: rename 'new' variables
  checkout: rename 'new' variables
  help: rename 'new' variables
  pack-redundant: rename 'new' variables
  reflog: rename 'new' variables
  remote: rename 'new' variables
  combine-diff: rename 'new' variables
  commit: rename 'new' variables
  diff-lib: rename 'new' variable
  diff: rename 'new' variables
  diffcore-delta: rename 'new' variables
  entry: rename 'new' variables
  http: rename 'new' variables
  imap-send: rename 'new' variables
  line-log: rename 'new' variables
  read-cache: rename 'new' variables
  ref-filter: rename 'new' variables
  remote: rename 'new' variables
  split-index: rename 'new' variables
  submodule: rename 'new' variables
  trailer: rename 'new' variables
  unpack-trees: rename 'new' variables
  init-db: rename 'template' variables
  environment: rename 'template' variables
  diff: rename 'template' variables
  environment: rename 'namespace' variables
  wrapper: rename 'template' variables
  tempfile: rename 'template' variables
  trailer: rename 'template' variables
  replace: rename 'new' variables

 apply.c                                | 122 +++++++--------
 blame.c                                |  33 +++--
 builtin/cat-file.c                     |   4 +-
 builtin/checkout.c                     | 196 ++++++++++++-------------
 builtin/diff-tree.c                    |   2 +-
 builtin/fast-export.c                  |   8 +-
 builtin/fsck.c                         |   4 +-
 builtin/grep.c                         |   2 +-
 builtin/help.c                         |  10 +-
 builtin/index-pack.c                   |  12 +-
 builtin/init-db.c                      |  30 ++--
 builtin/merge.c                        |   2 +-
 builtin/mktree.c                       |   4 +-
 builtin/pack-objects.c                 |   8 +-
 builtin/pack-redundant.c               |  54 +++----
 builtin/prune.c                        |   2 +-
 builtin/reflog.c                       |   8 +-
 builtin/remote.c                       |  66 ++++-----
 builtin/replace.c                      |  46 +++---
 builtin/rev-parse.c                    |  34 ++---
 builtin/tag.c                          |   2 +-
 builtin/unpack-objects.c               |  10 +-
 builtin/verify-commit.c                |   2 +-
 bulk-checkin.c                         |   2 +-
 cache.h                                |   4 +-
 combine-diff.c                         |  12 +-
 commit.c                               |  20 +--
 contrib/examples/builtin-fetch--tool.c |   2 +-
 diff-lib.c                             |  38 ++---
 diff.c                                 |  62 ++++----
 diffcore-delta.c                       |  16 +-
 entry.c                                |  40 ++---
 environment.c                          |  24 +--
 fast-import.c                          |  16 +-
 fsck.c                                 |   2 +-
 git-compat-util.h                      |   4 +-
 http-push.c                            |   2 +-
 http.c                                 |  10 +-
 imap-send.c                            |  14 +-
 line-log.c                             |  56 +++----
 log-tree.c                             |   2 +-
 object.c                               |   6 +-
 object.h                               |   2 +-
 pack-check.c                           |   2 +-
 packfile.c                             |   8 +-
 reachable.c                            |   2 +-
 read-cache.c                           |  40 ++---
 ref-filter.c                           |  20 +--
 remote.c                               |  20 +--
 sequencer.c                            |   2 +-
 sha1_file.c                            |  28 ++--
 sha1_name.c                            |   6 +-
 split-index.c                          |  16 +-
 split-index.h                          |   2 +-
 submodule.c                            |  32 ++--
 submodule.h                            |   2 +-
 tag.c                                  |   2 +-
 tempfile.c                             |  12 +-
 tempfile.h                             |  34 ++---
 trailer.c                              |  44 +++---
 unpack-trees.c                         |   6 +-
 walker.c                               |   4 +-
 wrapper.c                              |  40 ++---
 63 files changed, 659 insertions(+), 658 deletions(-)

-- 
2.16.1.291.g4437f3f132-goog

