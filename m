Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D555E1FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 19:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbdAATTh (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 14:19:37 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53796 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932183AbdAATTg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 14:19:36 -0500
Received: from genre.crustytoothpaste.net (unknown [173.243.43.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0CE1A280AC;
        Sun,  1 Jan 2017 19:19:32 +0000 (UTC)
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/17] object_id part 6
Date:   Sun,  1 Jan 2017 19:18:30 +0000
Message-Id: <20170101191847.564741-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another series in the continuing conversion to struct object_id.

This series converts more of the builtin directory and some of the
refs code to use struct object_id. Additionally, it implements an
nth_packed_object_oid function which provides a struct object_id
version of the nth_packed_object function.

There is a small known conflict with next, but it can easily be fixed up.

brian m. carlson (17):
  builtin/commit: convert to struct object_id
  builtin/diff-tree: convert to struct object_id
  builtin/describe: convert to struct object_id
  builtin/fast-export: convert to struct object_id
  builtin/fmt-merge-message: convert to struct object_id
  builtin/grep: convert to struct object_id
  builtin/branch: convert to struct object_id
  builtin/clone: convert to struct object_id
  builtin/merge: convert to struct object_id
  Convert remaining callers of resolve_refdup to object_id
  builtin/replace: convert to struct object_id
  reflog-walk: convert struct reflog_info to struct object_id
  refs: convert each_reflog_ent_fn to struct object_id
  sha1_file: introduce an nth_packed_object_oid function
  Convert object iteration callbacks to struct object_id
  builtin/merge-base: convert to struct object_id
  wt-status: convert to struct object_id

 builtin/branch.c        |  26 ++++-----
 builtin/cat-file.c      |   8 +--
 builtin/clone.c         |  10 ++--
 builtin/commit.c        |  46 ++++++++--------
 builtin/count-objects.c |   4 +-
 builtin/describe.c      |  50 +++++++++---------
 builtin/diff-tree.c     |  38 +++++++-------
 builtin/fast-export.c   |  58 ++++++++++-----------
 builtin/fmt-merge-msg.c |  70 ++++++++++++-------------
 builtin/fsck.c          |  26 ++++-----
 builtin/grep.c          |  24 ++++-----
 builtin/merge-base.c    |  30 +++++------
 builtin/merge.c         | 136 ++++++++++++++++++++++++------------------------
 builtin/notes.c         |  18 +++----
 builtin/pack-objects.c  |   6 +--
 builtin/prune-packed.c  |   4 +-
 builtin/prune.c         |   8 +--
 builtin/receive-pack.c  |   4 +-
 builtin/reflog.c        |   2 +-
 builtin/replace.c       | 112 +++++++++++++++++++--------------------
 cache.h                 |   5 +-
 reachable.c             |  30 +++++------
 ref-filter.c            |   4 +-
 reflog-walk.c           |  26 ++++-----
 refs.c                  |  24 ++++-----
 refs.h                  |   2 +-
 refs/files-backend.c    |  24 ++++-----
 revision.c              |  12 ++---
 sha1_file.c             |  22 +++++---
 sha1_name.c             |   2 +-
 transport.c             |   4 +-
 wt-status.c             |  52 +++++++++---------
 32 files changed, 448 insertions(+), 439 deletions(-)

-- 
2.11.0

