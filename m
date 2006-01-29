From: Chuck Lever <cel@netapp.com>
Subject: [PATCH] "stg pull" says "popping all patches" even when it doesn't
Date: Sun, 29 Jan 2006 13:08:36 -0500
Message-ID: <20060129180835.1868.43455.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 19:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Gyr-0000uG-Dy
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWA2SIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWA2SIg
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:08:36 -0500
Received: from citi.umich.edu ([141.211.133.111]:62546 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751092AbWA2SIg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 13:08:36 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 0D48A1BC08;
	Sun, 29 Jan 2006 13:08:36 -0500 (EST)
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15223>

Running "stg pull" says it pops all patches, but it really means it is
popping all *applied* patches.  Change the informational message to match
the behavior.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/pull.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 25832a5..843b579 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -64,7 +64,7 @@ def func(parser, options, args):
     # pop all patches
     applied = crt_series.get_applied()
     if len(applied) > 0:
-        print 'Popping all patches...',
+        print 'Popping all applied patches...',
         sys.stdout.flush()
         crt_series.pop_patch(applied[0])
         print 'done'
