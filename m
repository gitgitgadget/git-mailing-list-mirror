From: koreth@midwinter.com
Subject: [PATCH] Add a message explaining that automatic GC is about to start
Date: Wed, 17 Oct 2007 21:41:43 -0700
Message-ID: <20071018044143.GA24043@midwinter.com>
References: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNCv-0007gA-Ff
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXJRElo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXJRElo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:41:44 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50384 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750990AbXJREln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:41:43 -0400
Received: (qmail 24220 invoked by uid 1001); 18 Oct 2007 04:41:43 -0000
Content-Disposition: inline
In-Reply-To: <20071018032307.GA7313@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61465>

---

On Wed, Oct 17, 2007 at 11:23:07PM -0400, Jeff King wrote:
> It would have been nicer if it said something like "Your repository
> looks crufty. Running git-gc --auto..." using whatever terms users would
> be comfortable with. Instead, it just started with "Counting objects"
> and a long wait.

And as an added bonus, we can tell people how to turn off automatic GC
and how to invoke it by hand.

 builtin-gc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 23ad2b6..b1159d6 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -211,6 +211,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		prune = 0;
 		if (!need_to_gc())
 			return 0;
+		fprintf(stderr, "Packing your repository for optimum "
+			"performance. If you would rather run\n"
+			"\"git gc\" by hand, run \"git config gc.auto 0\" "
+			"to disable automatic cleanup.\n");
 	}
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
-- 
1.5.3.rc2.4.g726f9
