From: "Josh England" <jjengla@sandia.gov>
Subject: [PATCH] Documentation for post-checkout and post-merge hooks
Date: Tue, 25 Sep 2007 16:49:23 -0600
Message-ID: <1190760563-32453-3-git-send-email-jjengla@sandia.gov>
References: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
 <1190760563-32453-2-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 00:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJEK-00046D-Js
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbXIYWuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXIYWuA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:50:00 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:1572 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbXIYWt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:49:58 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 25 Sep 2007 16:49:46 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from ES24SNLNT.srn.sandia.gov (ec06snlnt.sandia.gov
 [134.253.164.50] (may be forged)) by mailgate.sandia.gov (
 8.14.0/8.14.0) with ESMTP id l8PMnjZW009500 for <git@vger.kernel.org>;
 Tue, 25 Sep 2007 16:49:45 -0600
Received: from ef01snlnt.srn.sandia.gov ([134.253.164.107]) by
 ES24SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Tue, 25
 Sep 2007 16:49:45 -0600
Received: from truth ([134.253.45.6]) by ef01snlnt.srn.sandia.gov with
 Microsoft SMTPSVC(6.0.3790.3959); Tue, 25 Sep 2007 16:49:45 -0600
Received: by truth (sSMTP sendmail emulation); Tue, 25 Sep 2007 16:49:24
 -0600
X-Mailer: git-send-email 1.5.3.2.89.g296e
In-Reply-To: <1190760563-32453-2-git-send-email-jjengla@sandia.gov>
X-OriginalArrivalTime: 25 Sep 2007 22:49:45.0732 (UTC)
 FILETIME=[5E7EBC40:01C7FFC6]
X-TMWD-Spam-Summary: TS=20070925224946; SEV=2.2.2; DFV=B2007092518;
 IFV=2.0.4,4.0-9; AIF=B2007092518; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364639393038412E303033343A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092518_5.02.0125_4.0-9
X-WSS-ID: 6AE74F003HO3445750-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59186>

Signed-off-by: Josh England <jjengla@sandia.gov>
---
 Documentation/hooks.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index c39edc5..37a3e5a 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -87,6 +87,31 @@ parameter, and is invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
 
+post-checkout
+-----------
+
+This hook is invoked when a `git-checkout` is run after having updated the
+worktree.  The hook is given two parameters: the ref of the previous HEAD and
+the ref of the new HEAD, which may or may not have changed.  This hook cannot
+affect the outcome of `git-checkout`.
+
+This hook can be used to perform repository validity checks, auto-display
+differences from the previous HEAD if different, or set working dir metadata
+properties.
+
+post-merge
+-----------
+
+This hook is invoked by `git-merge`, which happens when a `git pull`
+is done on a local repository.  The hook takes a single parameter, a status
+flag specifying whether or not the merge being done was a squash merge.
+This hook cannot affect the outcome of `git-merge`.
+
+This hook can be used in conjunction with a corresponding pre-commit hook to
+save and restore any form of metadata associated with the working tree
+(eg: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.pl
+for an example of how to do this.
+
 [[pre-receive]]
 pre-receive
 -----------
-- 
1.5.3.2.89.g296e
