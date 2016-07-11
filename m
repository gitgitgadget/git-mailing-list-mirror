Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F87D2018E
	for <e@80x24.org>; Mon, 11 Jul 2016 05:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440AbcGKFDc (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 01:03:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:42695 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750829AbcGKFDb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 01:03:31 -0400
Received: (qmail 13372 invoked by uid 102); 11 Jul 2016 05:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:03:33 -0400
Received: (qmail 28956 invoked by uid 107); 11 Jul 2016 05:03:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:03:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 01:03:28 -0400
Date:	Mon, 11 Jul 2016 01:03:28 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/5] doc/rev-list-options: clarify "commit@{Nth}" for "-g"
 option
Message-ID: <20160711050327.GA32514@sigill.intra.peff.net>
References: <20160711050201.GA18031@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160711050201.GA18031@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When "log -g" shows "HEAD@{1}", "HEAD@{2}", etc, calling
that "commit@{Nth}" is not really accurate. The "HEAD" part
is really the refname. By saying "commit", a reader may
misunderstand that to mean something related to the specific
commit we are showing, not the ref whose reflog we are
traversing.

While we're here, let's also switch these instances to use
literal backticks, as our style guide recommends. As a
bonus, that lets us drop some asciidoc quoting.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..6720ff3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -252,9 +252,9 @@ list.
 +
 With `--pretty` format other than `oneline` (for obvious reasons),
 this causes the output to have two extra lines of information
-taken from the reflog.  By default, 'commit@\{Nth}' notation is
+taken from the reflog.  By default, `ref@{Nth}` notation is
 used in the output.  When the starting commit is specified as
-'commit@\{now}', output also uses 'commit@\{timestamp}' notation
+`ref@{now}`, output also uses `ref@{timestamp}` notation
 instead.  Under `--pretty=oneline`, the commit message is
 prefixed with this information on the same line.
 This option cannot be combined with `--reverse`.
-- 
2.9.0.406.g77f030d

