Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A85A202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdCOVdC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:33:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:44837 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdCOVdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:33:02 -0400
Received: (qmail 3861 invoked by uid 109); 15 Mar 2017 21:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:26:20 +0000
Received: (qmail 8917 invoked by uid 111); 15 Mar 2017 21:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:26:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:26:17 -0400
Date:   Wed, 15 Mar 2017 17:26:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] minor pack-name cleanups
Message-ID: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started by cleaning up some unchecked snprintf() calls, but grew a
few related cleanups nearby.  I doubt the snprintf truncation affected
anybody in practice, but I think the result is nicer to read.

  [1/6]: index-pack: factor out pack/idx finalization
  [2/6]: move odb_* declarations out of git-compat-util.h
  [3/6]: sha1_file.c: make pack-name helper globally accessible
  [4/6]: index-pack: drop fixed-size buffer for pack filenames
  [5/6]: fast-import: replace fixed buffer with odb_pack_name
  [6/6]: odb_pack_keep(): stop generating keepfile name

 builtin/index-pack.c | 48 +++++++++++++++++++++---------------------------
 cache.h              | 21 +++++++++++++++++++++
 environment.c        |  6 ++----
 fast-import.c        | 26 +++++++++++++-------------
 git-compat-util.h    |  2 --
 sha1_file.c          | 17 ++++++-----------
 6 files changed, 63 insertions(+), 57 deletions(-)

-Peff
