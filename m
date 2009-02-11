From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH] Make sure that the commit message has Unix format   
             line
Date: Wed, 11 Feb 2009 08:45:27 +0100 (CET)
Message-ID: <34467.77.61.241.211.1234338327.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 09:18:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXAIX-00077w-RS
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 09:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZBKIQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 03:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZBKIQy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 03:16:54 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:53014 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751468AbZBKIQy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 03:16:54 -0500
X-Greylist: delayed 1883 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Feb 2009 03:16:54 EST
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id AF71958BDCE; Wed, 11 Feb 2009 08:45:27 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Wed, 11 Feb 2009 08:45:27 +0100 (CET)
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
References: 
In-Reply-To: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109383>

>From 2ad66e099fb35ad9a0d97e553843434b68ec82c9 Mon Sep 17 00:00:00 2001 From: Ferry Huberts <ferry.huberts@pelagic.nl>
Date: Wed, 11 Feb 2009 08:29:36 +0100
Subject: [PATCH] Make sure that the commit message has Unix format line delimiters

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../egit/ui/internal/actions/CommitAction.java     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java index 5996596..a14011a 100644 ---
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java +++
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java @@ -128,7 +128,7 @@ public void
run(IAction act) {
 		if (commitDialog.open() != IDialogConstants.OK_ID)
 			return;

-		String commitMessage = commitDialog.getCommitMessage();
+		String commitMessage = commitDialog.getCommitMessage().replaceAll("\n\r|\r\n", "\n");
 		amending = commitDialog.isAmending();
 		try {
 			performCommit(commitDialog, commitMessage);
-- 
1.6.1.9.g97c34
