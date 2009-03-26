From: rocketraman@fastmail.fm
Subject: [PATCH 1/2] Add feature release instructions to MaintNotes addendum
Date: Wed, 25 Mar 2009 21:56:14 -0400
Message-ID: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 03:04:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmexO-00033h-4A
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 03:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbZCZCDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 22:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbZCZCDB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 22:03:01 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:23306 "HELO
	smtp105.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753739AbZCZCDA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 22:03:00 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2009 22:03:00 EDT
Received: (qmail 84200 invoked from network); 26 Mar 2009 01:56:17 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp105.rog.mail.re2.yahoo.com with SMTP; 26 Mar 2009 01:56:17 -0000
X-YMail-OSG: 672x46QVM1lR_kztOWlUReluSwi7AK2uWZoMQ.Sim1ksvAdpSTdUMTR9wQ_GPa9tdA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id E901D21C051C
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:56:16 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4IvXyKiHqhU for <git@vger.kernel.org>;
	Wed, 25 Mar 2009 21:56:16 -0400 (EDT)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id ABAA721C051A
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:56:15 -0400 (EDT)
Received: by zeus (sSMTP sendmail emulation); Wed, 25 Mar 2009 21:56:15 -0400
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114704>

From: Raman Gupta <raman@rocketraman.com>

Based on a mailing list discussion, add the operations for creating a
feature release.

Signed-off-by: Raman Gupta <raman@rocketraman.com>
---
 Documentation/howto/maintain-git.txt |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 4357e26..f6ee0c5 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -244,6 +244,35 @@ by doing the following:
    repo.or.cz
 
 
+A feature release of git is made by tagging 'master' with a tag
+matching vX.Y.Z, where X.Y.Z is the feature release version.
+
+ - Optionally, track the current 'maint' branch to support
+   new releases for the older codebase if necessary.
+
+     $ git branch maint-X.Y.(Z-1) maint
+
+ - The 'maint' branch is updated to the new release.
+
+     $ git checkout maint
+     $ git merge master
+
+   This is equivalent to deleting maint and recreating it from
+   master, but it preserves the maint reflog.
+
+ - The 'next' branch may be rebuilt from the tip of 'master'
+   using the surviving topics on 'next'.
+
+     $ git branch -f next master
+
+   (Again, this approach preserves the reflog and per-branch
+   configuration of 'next')
+
+     $ git merge ai/topic_in_next1
+     $ git merge ai/topic_in_next2
+     ...
+
+
 Some observations to be made.
 
  * Each topic is tested individually, and also together with
-- 
1.6.2
