Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C596C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJRBBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJRBAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:00:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CF4760CF
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:00:52 -0700 (PDT)
Received: (qmail 28714 invoked by uid 109); 18 Oct 2022 01:00:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:00:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13356 invoked by uid 111); 18 Oct 2022 01:00:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:00:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:00:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/12] more unused-parameter fixes / annotations
Message-ID: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's another batch of UNUSED markings. I've floated the less-obvious
ones to the top. Patches 4-12 are trivially correct in the sense that
the compiler would tell us if we were wrong about it being unused. But I
tried where appropriate to reason out why ignoring a parameter wasn't an
unintentional bug.

  [01/12]: diffstat_consume(): assert non-zero length
  [02/12]: submodule--helper: drop unused argc from module_list_compute()
  [03/12]: update-index: drop unused argc from do_reupdate()
  [04/12]: mark unused parameters in trivial compat functions
  [05/12]: object-file: mark unused parameters in hash_unknown functions
  [06/12]: string-list: mark unused callback parameters
  [07/12]: date: mark unused parameters in handler functions
  [08/12]: apply: mark unused parameters in handlers
  [09/12]: apply: mark unused parameters in noop error/warning routine
  [10/12]: convert: mark unused parameter in null stream filter
  [11/12]: diffcore-pickaxe: mark unused parameters in pickaxe functions
  [12/12]: ll-merge: mark unused parameters in callbacks

 apply.c                     | 18 +++++++++---------
 archive.c                   |  2 +-
 builtin/gc.c                |  2 +-
 builtin/remote.c            |  2 +-
 builtin/submodule--helper.c | 18 +++++++++---------
 builtin/update-index.c      |  6 +++---
 compat/nonblock.c           |  2 +-
 convert.c                   |  4 ++--
 date.c                      |  6 +++---
 diff.c                      |  3 +++
 diffcore-pickaxe.c          |  4 ++--
 exec-cmd.c                  |  2 +-
 git-compat-util.h           | 16 ++++++++++------
 ll-merge.c                  | 18 +++++++++---------
 merge-ort.c                 |  2 +-
 object-file.c               | 15 ++++++++++-----
 reflog-walk.c               |  2 +-
 string-list.c               |  2 +-
 t/helper/test-path-utils.c  |  3 ++-
 19 files changed, 70 insertions(+), 57 deletions(-)

-Peff
