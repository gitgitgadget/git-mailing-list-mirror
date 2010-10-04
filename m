From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: [PATCH] contrib/ciabot: git-describe commit instead of HEAD
Date: Mon,  4 Oct 2010 10:02:42 +0200
Message-ID: <1286179362-23597-1-git-send-email-sven.eckelmann@gmx.de>
Cc: git@vger.kernel.org, Sven Eckelmann <sven.eckelmann@gmx.de>
To: gitster@pobox.com, esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Oct 04 10:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fz2-000332-2R
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 10:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab0JDIBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 04:01:04 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:34558 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752936Ab0JDIBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 04:01:02 -0400
Received: (qmail invoked by alias); 04 Oct 2010 08:01:00 -0000
Received: from vpnclient-202-062.hrz.tu-chemnitz.de (EHLO sven-desktop.lazhur.ath.cx) [134.109.202.62]
  by mail.gmx.net (mp006) with SMTP; 04 Oct 2010 10:01:00 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX1/U4Px4y5nUnM7POZhTyZPAhmt9GQj8N5J8kWFdfy
	QF+6M+1BuP6nL3
X-Mailer: git-send-email 1.7.2.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158009>

For each commit a shorter version of the name will be generated. This is
either the truncated hash or the output of git-describe. The
call to git-describe was only made with an empty shell variable instead
of an actual commit hash. Thus it only described the current HEAD and
not each commit we want to submit to cia.vc.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
I send this patch already two and four weeks ago and got no reaction.
This is a resent in case it was forgotton.

 contrib/ciabot/ciabot.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index d0627e0..9775dff 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -122,7 +122,7 @@ def report(refname, merged):
     branch = os.path.basename(refname)
 
     # Compute a shortnane for the revision
-    rev = do("git describe ${merged} 2>/dev/null") or merged[:12]
+    rev = do("git describe '"+ merged +"' 2>/dev/null") or merged[:12]
 
     # Extract the neta-information for the commit
     rawcommit = do("git cat-file commit " + merged)
-- 
1.7.2.3
