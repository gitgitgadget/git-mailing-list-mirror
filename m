Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC37C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiLNQSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiLNQSW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:18:22 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED82714C
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:18:20 -0800 (PST)
Received: (qmail 25878 invoked by uid 109); 14 Dec 2022 16:18:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 16:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19937 invoked by uid 111); 14 Dec 2022 16:18:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 11:18:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 11:18:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] minor ref-filter error-reporting bug-fixes
Message-ID: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few small inconsistencies in the error-reporting
from ref-filter's atom parsers. Mostly I noticed this while dealing with
unused parameters in one of the parsers, which led to noticing a few
other small bugs. And I hope the result is a little cleaner, as it
should reduce the number of strings needing translation.

  [1/5]: ref-filter: reject arguments to %(HEAD)
  [2/5]: ref-filter: factor out "%(foo) does not take arguments" errors
  [3/5]: ref-filter: factor out "unrecognized %(foo) arg" errors
  [4/5]: ref-filter: truncate atom names in error messages
  [5/5]: ref-filter: convert email atom parser to use err_bad_arg()

 ref-filter.c            | 44 +++++++++++++++++++++++++++++------------
 t/t6300-for-each-ref.sh | 18 +++++++++++++++++
 2 files changed, 49 insertions(+), 13 deletions(-)

-Peff
