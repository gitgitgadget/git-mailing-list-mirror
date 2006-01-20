From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] update using-topic-branches
Date: Fri, 20 Jan 2006 11:00:18 -0800
Message-ID: <200601201900.k0KJ0Ia2023842@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:00:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F01Uq-0001uf-3W
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 20:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWATTAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 14:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWATTAY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 14:00:24 -0500
Received: from fmr23.intel.com ([143.183.121.15]:24248 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750790AbWATTAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 14:00:24 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k0KJ0JB5008081
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 19:00:19 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k0KCBYQl010247
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 12:11:34 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id 4969B19F63
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 11:00:19 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k0KJ0Ia2023842;
	Fri, 20 Jan 2006 11:00:18 -0800
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14975>

Update documentation to warn users not to create noise in then Linux
history by creating pointless "Auto-update from upstream" merge
commits.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
index b3d592f..2c98194 100644
--- a/Documentation/howto/using-topic-branches.txt
+++ b/Documentation/howto/using-topic-branches.txt
@@ -9,7 +9,7 @@ GIT as a Linux subsystem maintainer.
 
 -Tony
 
-Last updated w.r.t. GIT 0.99.9f
+Last updated w.r.t. GIT 1.1
 
 Linux subsystem maintenance using GIT
 -------------------------------------
@@ -92,6 +92,14 @@ These can be easily kept up to date by m
  $ git checkout test && git merge "Auto-update from upstream" test linus
  $ git checkout release && git merge "Auto-update from upstream" release linus
 
+Important note!  If you have any local changes in these branches, then
+this merge will create a commit object in the history (with no local
+changes git will simply do a "Fast forward" merge).  Many people dislike
+the "noise" that this creates in the Linux history, so you should avoid
+doing this capriciously in the "release" branch, as these noisy commits
+will become part of the permanent history when you ask Linus to pull
+from the release branch.
+
 Set up so that you can push upstream to your public tree (you need to
 log-in to the remote system and create an empty tree there before the
 first push).
