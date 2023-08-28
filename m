Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF7C71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjH1VqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjH1VqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:46:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3ADA8
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:46:05 -0700 (PDT)
Received: (qmail 506 invoked by uid 109); 28 Aug 2023 21:46:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:46:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4500 invoked by uid 111); 28 Aug 2023 21:46:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:46:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:46:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/22] YAUPS: Yet Another Unused Parameter Series
Message-ID: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm back with another exciting installment of -Wunused-parameter warning
fixes. Most of these are pretty boring and obvious; the first two are
the most interesting in terms of rationale.

I promise we're closing in on the finish line here. I only have about 20
patches left after this, at which point we should be able to turn on the
warning by default for developer builds.

  [01/22]: sequencer: use repository parameter in short_commit_name()
  [02/22]: sequencer: mark repository argument as unused
  [03/22]: ref-filter: mark unused parameters in parser callbacks
  [04/22]: pack-bitmap: mark unused parameters in show_object callback
  [05/22]: worktree: mark unused parameters in each_ref_fn callback
  [06/22]: commit-graph: mark unused data parameters in generation callbacks
  [07/22]: ls-tree: mark unused parameter in callback
  [08/22]: stash: mark unused parameter in diff callback
  [09/22]: trace2: mark unused us_elapsed_absolute parameters
  [10/22]: trace2: mark unused config callback parameter
  [11/22]: test-trace2: mark unused argv/argc parameters
  [12/22]: grep: mark unused parameter in output function
  [13/22]: add-interactive: mark unused callback parameters
  [14/22]: negotiator/noop: mark unused callback parameters
  [15/22]: worktree: mark unused parameters in noop repair callback
  [16/22]: imap-send: mark unused parameters with NO_OPENSSL
  [17/22]: grep: mark unused parmaeters in pcre fallbacks
  [18/22]: credential: mark unused parameter in urlmatch callback
  [19/22]: fetch: mark unused parameter in ref_transaction callback
  [20/22]: bundle-uri: mark unused parameters in callbacks
  [21/22]: gc: mark unused descriptors in scheduler callbacks
  [22/22]: update-ref: mark unused parameter in parser callbacks

 add-interactive.c       |  8 ++++----
 builtin/fetch.c         |  2 +-
 builtin/gc.c            |  6 +++---
 builtin/ls-tree.c       |  3 ++-
 builtin/stash.c         |  2 +-
 builtin/update-ref.c    | 14 +++++++-------
 builtin/worktree.c      |  8 ++++----
 bundle-uri.c            |  6 +++---
 commit-graph.c          |  8 +++++---
 credential.c            |  4 ++--
 grep.c                  | 12 +++++++-----
 imap-send.c             | 10 ++++++++--
 negotiator/noop.c       | 12 +++++++-----
 pack-bitmap.c           |  5 +++--
 ref-filter.c            |  8 +++++---
 sequencer.c             | 27 ++++++++++++++-------------
 t/helper/test-trace2.c  |  6 +++---
 trace2/tr2_sysenv.c     |  3 ++-
 trace2/tr2_tgt_event.c  | 23 +++++++++++++----------
 trace2/tr2_tgt_normal.c | 20 ++++++++++++--------
 worktree.c              |  6 ++++--
 21 files changed, 110 insertions(+), 83 deletions(-)

-Peff
