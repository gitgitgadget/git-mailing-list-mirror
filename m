From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] diff-highlight: make perl strict and warnings fatal
Date: Mon, 13 Feb 2012 17:28:10 -0500
Message-ID: <20120213222810.GA19521@sigill.intra.peff.net>
References: <20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4Ne-0006NW-KP
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab2BMW2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 17:28:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34493
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab2BMW2N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:28:13 -0500
Received: (qmail 1853 invoked by uid 107); 13 Feb 2012 22:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 17:35:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 17:28:10 -0500
Content-Disposition: inline
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190682>

These perl features can catch bugs, and we shouldn't be
violating any of the strict rules or creating any warnings,
so let's turn them on.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/diff-highlight |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index d893898..c3302dd 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,5 +1,8 @@
 #!/usr/bin/perl
 
+use warnings FATAL => 'all';
+use strict;
+
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
 my $HIGHLIGHT   = "\x1b[7m";
-- 
1.7.8.4.17.g2df81
