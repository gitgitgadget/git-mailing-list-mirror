From: mhagger@alum.mit.edu
Subject: [PATCH] git symbolic-ref: documentation fix
Date: Wed,  7 Dec 2011 16:20:16 +0100
Message-ID: <1323271216-18237-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 16:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJf1-0000Kf-KX
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab1LGPnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 10:43:51 -0500
Received: from ssh.berlin.jpk.com ([212.222.128.135]:54790 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756176Ab1LGPnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 10:43:50 -0500
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Dec 2011 10:43:50 EST
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RYJA2-00021f-8n; Wed, 07 Dec 2011 16:11:54 +0100
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186466>

From: Michael Haggerty <mhagger@alum.mit.edu>

The old "git symbolic-ref" manpage seemed to imply in one place that
symlinks are still the default way to represent symbolic references
and in another that symlinks are deprecated.  Fix the text and shorten
the justification for the change of implementation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-symbolic-ref.txt |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 75b1ae5..a45d4c4 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -43,12 +43,9 @@ In the past, `.git/HEAD` was a symbolic link pointing at
 `refs/heads/master`.  When we wanted to switch to another branch,
 we did `ln -sf refs/heads/newbranch .git/HEAD`, and when we wanted
 to find out which branch we are on, we did `readlink .git/HEAD`.
-This was fine, and internally that is what still happens by
-default, but on platforms that do not have working symlinks,
-or that do not have the `readlink(1)` command, this was a bit
-cumbersome.  On some platforms, `ln -sf` does not even work as
-advertised (horrors).  Therefore symbolic links are now deprecated
-and symbolic refs are used by default.
+But symbolic links are not entirely portable, so they are now
+deprecated and symbolic refs (as described above) are used by
+default.
 
 'git symbolic-ref' will exit with status 0 if the contents of the
 symbolic ref were printed correctly, with status 1 if the requested
-- 
1.7.8
