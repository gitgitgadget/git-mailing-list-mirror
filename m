From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gitk: fix for "gitk <ambiguous-name> --"
Date: Tue, 3 Jul 2007 23:55:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707032353330.4071@racer.site>
References: <20070703202301.GA24071@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707032248570.4071@racer.site>
 <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-7336571-1183503324=:4071"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:55:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5rHT-0002Bh-J0
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbXGCWzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbXGCWzd
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:55:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:60928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754042AbXGCWzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:55:32 -0400
Received: (qmail invoked by alias); 03 Jul 2007 22:55:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 04 Jul 2007 00:55:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fGH0Hqe4f8EdgtYf51GqqDfcWRm0bTKTMAwh2gQ
	KYFulcA9xQqA0J
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51549>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-7336571-1183503324=:4071
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


If you have an ambiguous ref, i.e. a file in the working directory bears
the same name, you have to use "--" at the end to disambiguate ref from
file. This works with "git rev-list". Make it work with gitk, too.

Noticed by Uwe Kleine-König.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Uwe, did your name come out right? I recently had to manually fix 
	pine, and realised only then what a tedious work it is to teach 
	pine about utf-8. Hopefully it worked out.

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 2d6a6ef..a248f5a 100755
--- a/gitk
+++ b/gitk
@@ -7440,7 +7440,7 @@ set cmdline_files {}
 set i [lsearch -exact $revtreeargs "--"]
 if {$i >= 0} {
     set cmdline_files [lrange $revtreeargs [expr {$i + 1}] end]
-    set revtreeargs [lrange $revtreeargs 0 [expr {$i - 1}]]
+    set revtreeargs [lrange $revtreeargs 0 $i]
 } elseif {$revtreeargs ne {}} {
     if {[catch {
 	set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
-- 
1.5.3.rc0.2640.g59df9-dirty


--8323584-7336571-1183503324=:4071--
