From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Mention that git-branch -M can cause problems for tracking branches
Date: Fri, 2 Nov 2007 10:17:34 +0100
Message-ID: <20071102091734.GC10141@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:17:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Insf1-0007Vv-UI
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbXKBJRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbXKBJRi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:17:38 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:57102 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXKBJRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:17:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 4D53A19BCBA;
	Fri,  2 Nov 2007 10:17:36 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26387-19; Fri,  2 Nov 2007 10:17:34 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 8BEAF19BD51;
	Fri,  2 Nov 2007 10:17:34 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D5D4F6DF893; Fri,  2 Nov 2007 10:17:22 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 76E935B8001; Fri,  2 Nov 2007 10:17:34 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63080>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-branch.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

 I made a patch to discard the overwritten branch's configuration
 section, which Spearce felt was too lossy a behaviour. However, since
 it confused me, I think it should at least be mentioned in the manpage.
 Maybe the warning message from git should also be added to improve its
 "googlability".

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5e81aa4..def4e85 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -165,6 +165,11 @@ If you are creating a branch that you want to immediately checkout, it's
 easier to use the git checkout command with its `-b` option to create
 a branch and check it out with a single command.
 
+When a branch is renamed so that it overwrites an existing branch unintended
+problems can arise. This is because git refuses to discard the configuration
+section of the overwritten branch. As a result git can become confused if, for
+example, the branches involved were used for tracking two different remote
+branches. The only way to fix this is to edit the configuration file manually.
 
 Author
 ------
-- 
1.5.3.4.1481.g854da-dirty

-- 
Jonas Fonseca
