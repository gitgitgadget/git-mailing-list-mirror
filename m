From: David Fries <david@fries.net>
Subject: [PATCH] reset --mixed message update, tell the user what will work
Date: Sat, 17 Jul 2010 22:37:24 -0500
Message-ID: <20100718033722.GA15631@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 18 05:48:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaKrD-0005FL-7e
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 05:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0GRDrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 23:47:49 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:37975 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab0GRDrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 23:47:48 -0400
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Jul 2010 23:47:48 EDT
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o6I3bT6e016228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 17 Jul 2010 22:37:30 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id o6I3bPsO016226
	for git@vger.kernel.org; Sat, 17 Jul 2010 22:37:25 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (SpacedOut.fries.net [127.0.0.1]); Sat, 17 Jul 2010 22:37:30 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151202>

Instead of,
fatal: mixed reset is not allowed in a bare repository
print,
fatal: mixed reset is not allowed in a bare repository, use --soft
To tell the user what they can do, instead of just what they can't.
---
When I was first learning how to use git and I needed to reset my bare
repository I would make it a full repository just so I could use
git-reset, a message like the above would have saved me effort back
then.

 builtin/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..ebbefe0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
-		die("%s reset is not allowed in a bare repository",
+		die("%s reset is not allowed in a bare repository, use --soft",
 		    reset_type_names[reset_type]);
 
 	/* Soft reset does not touch the index file nor the working tree
-- 
1.7.1
