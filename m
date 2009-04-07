From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] NO_PERL support
Date: Tue, 7 Apr 2009 03:31:56 -0400
Message-ID: <20090407073155.GA7243@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403192700.GA14965@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:33:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5oK-0000gI-8b
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbZDGHcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbZDGHcA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:32:00 -0400
Received: from peff.net ([208.65.91.99]:47844 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbZDGHb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:31:59 -0400
Received: (qmail 670 invoked by uid 107); 7 Apr 2009 07:31:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:31:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:31:56 -0400
Content-Disposition: inline
In-Reply-To: <20090403192700.GA14965@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115917>

On Fri, Apr 03, 2009 at 03:27:01PM -0400, Jeff King wrote:

> OK, here is a series based on Robin's patch that I think is suitable for
> inclusion in mainstream git. The first two are related cleanups, the
> third is a rebase of what I sent earlier today, and the fourth covers
> the matching tests.
> 
>   1/4: commit: abort commit if interactive add failed
>   2/4: tests: remove exit after test_done call
>   3/4: Makefile: allow building without perl
>   4/4: tests: skip perl tests if NO_PERL is defined

And here is a 5/4 that I missed when looking at Robin's patch.

-- >8 --
Subject: [PATCH] Makefile: disable perl entirely for empty PERL_PATH

This matches the TCLTK_PATH behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 584a757..6e0fe24 100644
--- a/Makefile
+++ b/Makefile
@@ -1109,6 +1109,10 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
 
+ifeq ($(PERL_PATH),)
+NO_PERL=NoThanks
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-- 
1.6.2.2.450.gd6aa9.dirty
