Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33661C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjIRW3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRW3P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:29:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012691
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:29:09 -0700 (PDT)
Received: (qmail 12936 invoked by uid 109); 18 Sep 2023 22:29:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:29:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4672 invoked by uid 111); 18 Sep 2023 22:29:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:29:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:29:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 0/8] fsmonitor unused parameter cleanups
Message-ID: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few cleanups of the fsmonitor code to remove or annotate
unused parameters (working towards my goal of making us compile clean
with -Wunused-parameter). I think they should all be pretty
non-controversial, but I'm cc-ing folks active in the area in case patch
2 steps on the toes of any unpublished works in progress.

  [1/8]: fsmonitor: prefer repo_git_path() to git_pathdup()
  [2/8]: fsmonitor/win32: drop unused parameters
  [3/8]: fsmonitor: mark some maybe-unused parameters
  [4/8]: fsmonitor/win32: mark unused parameter in fsm_os__incompatible()
  [5/8]: fsmonitor: mark unused parameters in stub functions
  [6/8]: fsmonitor/darwin: mark unused parameters in system callback
  [7/8]: fsmonitor: mark unused hashmap callback parameters
  [8/8]: run-command: mark unused parameters in start_bg_wait callbacks

 builtin/fsmonitor--daemon.c             | 10 ++++++----
 compat/fsmonitor/fsm-health-darwin.c    |  8 ++++----
 compat/fsmonitor/fsm-ipc-win32.c        |  2 +-
 compat/fsmonitor/fsm-listen-darwin.c    |  4 ++--
 compat/fsmonitor/fsm-listen-win32.c     | 24 ++++++++++--------------
 compat/fsmonitor/fsm-path-utils-win32.c |  7 ++++---
 compat/fsmonitor/fsm-settings-win32.c   |  2 +-
 fsmonitor-ipc.c                         | 10 +++++-----
 fsmonitor-settings.c                    |  3 ++-
 t/helper/test-simple-ipc.c              |  3 ++-
 10 files changed, 37 insertions(+), 36 deletions(-)

-Peff
