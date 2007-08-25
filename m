From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/2] gitweb: Lift any characters restriction on searched
	strings
Date: Sun, 26 Aug 2007 00:18:47 +0200
Message-ID: <20070825221847.11739.46741.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP3y0-0000qA-Df
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbXHYWSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbXHYWSt
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:18:49 -0400
Received: from rover.dkm.cz ([62.24.64.27]:58946 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbXHYWSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:18:48 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2007 18:18:48 EDT
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id D94248B594;
	Sun, 26 Aug 2007 00:18:47 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56655>

Everything is already fully quoted along the way so I believe this to be
unnecessary at this point. It would pose trouble for regexp searches.

Cc: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 677f4fb..1ac4523 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -476,9 +476,6 @@ if (defined $searchtype) {
 our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
-	if ($searchtype ne 'grep' and $searchtype ne 'pickaxe' and $searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
-		die_error(undef, "Invalid search parameter");
-	}
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
