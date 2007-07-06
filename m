From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] git-branch: default to --track
Date: Fri, 6 Jul 2007 22:54:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707062252390.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 07 00:01:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6vre-0000kf-Ay
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 00:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002AbXGFWBT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760426AbXGFWBT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 18:01:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:41279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756361AbXGFWBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 18:01:19 -0400
Received: (qmail invoked by alias); 06 Jul 2007 22:01:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 07 Jul 2007 00:01:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186HytMMOU6f20S6Wq7QJzSCkeEMBbVnyGpU2yyUB
	5ntPbdJ/rGNBsn
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51790>


"git branch --track" will setup config variables when branching from 
a remote branch, so that if you say "git pull" while being on that
branch, it automatically fetches the correct remote, and merges the
correct branch.

Often people complain that this is not the default for "git branch". 
Make it so.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	With 1.5.3 knocking at the door, maybe it is too late to include
	this. However, I am in favour of changing the default behaviour
	here.

 builtin-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index ae450b0..507b47c 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -22,7 +22,7 @@ static const char builtin_branch_usage[] =
 static const char *head;
 static unsigned char head_sha1[20];
 
-static int branch_track_remotes;
+static int branch_track_remotes = 1;
 
 static int branch_use_color;
 static char branch_colors[][COLOR_MAXLEN] = {
