From: Jeff King <peff@peff.net>
Subject: [PATCH] git-gc: improve wording of --auto notification
Date: Thu, 18 Oct 2007 21:12:11 -0400
Message-ID: <20071019011211.GC3290@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com> <47176AB9.7010409@midwinter.com> <20071019001648.GO14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IigPd-0006yp-5a
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbXJSBMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbXJSBMP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:12:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1660 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902AbXJSBMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:12:14 -0400
Received: (qmail 6002 invoked by uid 111); 19 Oct 2007 01:12:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 21:12:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 21:12:11 -0400
Content-Disposition: inline
In-Reply-To: <20071019001648.GO14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61589>

The previous message had too much of a "boy, you should
really turn off this annoying gc" flair to it. Instead,
let's make sure the user understands what is happening, that
they can run it themselves, and where to find more info.

Suggested by Brian Gernhardt.

Signed-off-by: Jeff King <peff@peff.net>
---

Shawn said:
> A patch against spearce/master to revert the prior message and insert
> something that is perhaps more reasonable would be most appreciated.

Geez, you really _are_ the maintainer now, prodding your minions to
write trivial patches for you. :) I don't see any point in reverting the
other patch separately, since we can just improve the message.

I tried not to use the word "avoid" since I think we don't want to imply
that auto-gc sucks. It doesn't, but some people might prefer to run it
manually, and we should let them know it's an option. I'm open to
wording improvements.

 builtin-gc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index f99b212..3a2ca4f 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -206,9 +206,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		if (!need_to_gc())
 			return 0;
 		fprintf(stderr, "Packing your repository for optimum "
-			"performance. If you would rather run\n"
-			"\"git gc\" by hand, run \"git config gc.auto 0\" "
-			"to disable automatic cleanup.\n");
+			"performance. You may also\n"
+			"run \"git gc\" manually. See "
+			"\"git help gc\" for more information.\n");
 	} else {
 		/*
 		 * Use safer (for shared repos) "-A" option to
-- 
1.5.3.4.1249.g895be-dirty
