From: Jeff King <peff@peff.net>
Subject: Re: git-gui console app ?
Date: Fri, 10 Aug 2007 10:21:04 -0400
Message-ID: <20070810142104.GA10997@sigill.intra.peff.net>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local> <20070804120342.GC9716@coredump.intra.peff.net> <20070804123834.GA3036@Mac2.local> <20070805101953.GI12507@coredump.intra.peff.net> <20070810133132.GA3770@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Colson <eco@ecocode.net>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Aug 10 16:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJVMa-00047F-Ah
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 16:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbXHJOVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 10:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbXHJOVK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 10:21:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4448 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbXHJOVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 10:21:09 -0400
Received: (qmail 2743 invoked by uid 111); 10 Aug 2007 14:21:14 -0000
X-Spam-Status: No, hits=-1.0 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 10 Aug 2007 10:21:13 -0400
Received: (qmail 12092 invoked by uid 1000); 10 Aug 2007 14:21:04 -0000
Content-Disposition: inline
In-Reply-To: <20070810133132.GA3770@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55542>

On Fri, Aug 10, 2007 at 03:31:32PM +0200, Jonas Fonseca wrote:

> Not quite a one-liner, but I've implemented something that will show
> diffs of staged/unstaged changes as well as the content of untracked
> files when pressing Enter on a file in the status view. To update the
> status of a file (unstaged->staged, untracked->staged, etc) you now
> have to press 'u'.

Nice. This was exactly what I had envisioned. Minor help text fixup is
below.

-Peff

-- >8 --
status window: mention 'u' instead of Enter

Commits ca1d71ea and 89d917a bound the Enter functionality
to 'u' (and Enter now shows the diff).

Signed-off-by: Jeff King <peff@peff.net>
---
 tig.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tig.c b/tig.c
index d9c9df8..40670e2 100644
--- a/tig.c
+++ b/tig.c
@@ -3156,15 +3156,15 @@ status_select(struct view *view, struct line *line)
 
 	switch (line->type) {
 	case LINE_STAT_STAGED:
-		text = "Press Enter to unstage file for commit";
+		text = "Press 'u' to unstage file for commit";
 		break;
 
 	case LINE_STAT_UNSTAGED:
-		text = "Press Enter to stage file for commit  ";
+		text = "Press 'u' to stage file for commit  ";
 		break;
 
 	case LINE_STAT_UNTRACKED:
-		text = "Press Enter to stage file for addition";
+		text = "Press 'u' to stage file for addition";
 		break;
 
 	case LINE_STAT_NONE:
-- 
1.5.2.4
