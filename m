Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3EDEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGCGnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGCGnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:43:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E0CC
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:43:48 -0700 (PDT)
Received: (qmail 13985 invoked by uid 109); 3 Jul 2023 06:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:43:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2598 invoked by uid 111); 3 Jul 2023 06:43:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:43:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:43:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/14] more -Wunused-parameter annotations
Message-ID: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's another set of patches to silence -Wunused-parameter warnings.
With the exception of the first patch, these are all just adding
annotations (though I tried to document in each one any digging I did on
"this isn't a bug that we're not using it, right?").

So I don't think these should be controversial. But I wanted to mention
that I'll be offline for a month starting July 5th. So if there is any
substantive review after that, I'll be rather slow to respond. :)

  [01/14]: test-ref-store: drop unimplemented reflog-expire command
  [02/14]: do_for_each_ref_helper(): mark unused repository parameter
  [03/14]: http: mark unused parameters in curl callbacks
  [04/14]: http-push: mark unused parameter in xml callback
  [05/14]: am: mark unused keep_cr parameters
  [06/14]: count-objects: mark unused parameter in alternates callback
  [07/14]: revisions: drop unused "opt" parameter in "tweak" callbacks
  [08/14]: fsck: mark unused parameters in various fsck callbacks
  [09/14]: merge-tree: mark unused parameter in traverse callback
  [10/14]: replace: mark unused parameter in ref callback
  [11/14]: replace: mark unused parameter in each_mergetag_fn callback
  [12/14]: rev-parse: mark unused parameter in for_each_abbrev callback
  [13/14]: tag: mark unused parameters in each_tag_name_fn callbacks
  [14/14]: t/helper: mark unused callback void data parameters

 builtin/am.c                     |  4 ++--
 builtin/count-objects.c          |  2 +-
 builtin/diff-tree.c              |  2 +-
 builtin/fsck.c                   | 10 +++++-----
 builtin/index-pack.c             |  3 ++-
 builtin/log.c                    |  6 ++----
 builtin/merge-tree.c             |  4 +++-
 builtin/mktag.c                  |  8 ++++----
 builtin/replace.c                |  4 ++--
 builtin/rev-parse.c              |  2 +-
 builtin/tag.c                    |  4 ++--
 builtin/unpack-objects.c         |  3 ++-
 fsck.c                           |  4 ++--
 http-push.c                      |  2 +-
 http.c                           |  9 ++++++---
 object-file.c                    | 10 +++++-----
 refs.c                           |  2 +-
 revision.c                       |  2 +-
 revision.h                       |  2 +-
 t/helper/test-dump-split-index.c |  2 +-
 t/helper/test-oid-array.c        |  2 +-
 t/helper/test-ref-store.c        |  6 ------
 22 files changed, 46 insertions(+), 47 deletions(-)

-Peff
