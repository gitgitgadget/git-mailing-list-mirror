Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF8C202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbdJSUX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:23:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752581AbdJSUX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:23:28 -0400
Received: (qmail 2620 invoked by uid 109); 19 Oct 2017 20:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:23:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11910 invoked by uid 111); 19 Oct 2017 20:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:23:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:23:26 -0400
Date:   Thu, 19 Oct 2017 16:23:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: [PATCH 0/5] fix "diff --color-moved --ignore-space-at-eol"
Message-ID: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
 <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
 <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
 <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
 <xmqqzi8niu1r.fsf@gitster.mtv.corp.google.com>
 <20171019054246.jii62lq2druohbpo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019054246.jii62lq2druohbpo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 01:42:46AM -0400, Jeff King wrote:

> It's late here, so I'll wait for comments from Stefan and then try to
> wrap it up with a commit message and test tomorrow.

Here it is.

The fix is in patch 4. The earlier ones are just beefing up the test
coverage, and the last one is a minor cleanup we can do on top.

  [1/5]: t4015: refactor --color-moved whitespace test
  [2/5]: t4015: check "negative" case for "-w --color-moved"
  [3/5]: t4015: test the output of "diff --color-moved -b"
  [4/5]: diff: fix whitespace-skipping with --color-moved
  [5/5]: diff: handle NULs in get_string_hash()

 diff.c                     |  17 ++--
 t/t4015-diff-whitespace.sh | 213 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 188 insertions(+), 42 deletions(-)

-Peff
