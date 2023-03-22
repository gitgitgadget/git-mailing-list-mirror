Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEBC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCVRhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCVRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:37:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551A54C98
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:36:37 -0700 (PDT)
Received: (qmail 10395 invoked by uid 109); 22 Mar 2023 17:36:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:36:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15854 invoked by uid 111); 22 Mar 2023 17:36:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:36:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] minor cleanups to fast-export --anonymize
Message-ID: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My goal here was cleaning up some -Wunused-parameter warnings, but doing
so required a few preparatory cleanups, one of which actually fixes a
really minor bug (in patch 4).

  [1/6]: fast-export: drop const when storing anonymized values
  [2/6]: fast-export: simplify initialization of anonymized hashmaps
  [3/6]: fast-export: factor out anonymized_entry creation
  [4/6]: fast-export: de-obfuscate --anonymize-map handling
  [5/6]: fast-export: drop data parameter from anonymous generators
  [6/6]: fast-export: drop unused parameter from anonymize_commit_message()

 builtin/fast-export.c            | 81 ++++++++++++++++++--------------
 t/t9351-fast-export-anonymize.sh |  2 +
 2 files changed, 47 insertions(+), 36 deletions(-)

-Peff
