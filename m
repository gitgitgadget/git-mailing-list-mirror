Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3630203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcGVTvJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:51:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:48805 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751619AbcGVTvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:51:09 -0400
Received: (qmail 22186 invoked by uid 102); 22 Jul 2016 19:51:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:51:09 -0400
Received: (qmail 9248 invoked by uid 107); 22 Jul 2016 19:51:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:51:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 15:51:05 -0400
Date:	Fri, 22 Jul 2016 15:51:05 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] reflog docs and date-formatting
Message-ID: <20160722195105.GA19542@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a repost of the patches in:

  http://thread.gmane.org/gmane.comp.version-control.git/299201/focus=299236

since I don't think they got picked up at all.

The contents are the same, but with one extra patch (the 4th) that was
posted mid-discussion.

The only other review comment is that patch 5 might want to editorialize
the weirdness of "raw-local" more. I think I'm comfortable leaving it
as-is based on my response in:

  http://article.gmane.org/gmane.comp.version-control.git/299312

but I could be persuaded otherwise.

The final patch, "--date=unix" doesn't _really_ solve Ted's problem,
because there's still no way to give multiple date formats in the same
line, nor use "%gd" as both the reflog index and as the date. So I'm
assuming he'll still build "%gt" or similar on top of this, and only in
the long run will we get to "%(reflog-date:unix)" or whatever.

So I think it's still valuable as a minor feature for other formatting
needs, and as a potential building block for later. The earlier patches
are all immediately useful as clarifications.

  [1/6]: doc/rev-list-options: clarify "commit@{Nth}" for "-g" option
  [2/6]: doc/rev-list-options: explain "-g" output formats
  [3/6]: doc/pretty-formats: describe index/time formats for %gd
  [4/6]: doc/pretty-formats: explain shortening of %gd
  [5/6]: date: document and test "raw-local" mode
  [6/6]: date: add "unix" format

-Peff
