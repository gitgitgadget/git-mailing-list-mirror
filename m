From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Deprecate git-lost-found
Date: Thu, 8 Nov 2007 00:41:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080041120.4362@racer.site>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
 <7vlk998u6r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpvSo-0002RV-LP
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbXKHAl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbXKHAl1
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:41:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:35108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753068AbXKHAl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:41:27 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:41:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp018) with SMTP; 08 Nov 2007 01:41:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196rZ8DWJB6ATRnAFuy63JzPTcTSAvuxeWVGgc3vk
	qk71fWa7AU8BcV
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk998u6r.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63914>


"git fsck" learnt the option "--lost-found" in v1.5.3-rc0~5, to make
"git lost-found" obsolete.  It is time to deprecate "git lost-found".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/RelNotes-1.5.4.txt |    3 +++
 Documentation/git-lost-found.txt |    4 ++++
 git-lost-found.sh                |    2 ++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index 133fa64..65dd1b0 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -46,6 +46,9 @@ Updates since v1.5.3
 
  * Various Perforce importer updates.
 
+ * git-lost-found was deprecated in favor of git-fsck's --lost-found
+   option.
+
 Fixes since v1.5.3
 ------------------
 
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index bc73911..7f808fc 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+
+*NOTE*: this command is deprecated.  Use gitlink:git-fsck[1] with
+the option '--lost-found' instead.
+
 Finds dangling commits and tags from the object database, and
 creates refs to them in the .git/lost-found/ directory.  Commits and
 tags that dereference to commits are stored in .git/lost-found/commit,
diff --git a/git-lost-found.sh b/git-lost-found.sh
index a5a32e7..9cedaf8 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -5,6 +5,8 @@ SUBDIRECTORY_OK='Yes'
 OPTIONS_SPEC=
 . git-sh-setup
 
+echo "WARNING: '$0' is deprecated in favor of 'git fsck --lost-found'" >&2
+
 if [ "$#" != "0" ]
 then
     usage
-- 
1.5.3.5.1597.g7191
