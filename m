From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: make pointer selection visible in highlighted lines
Date: Wed, 27 Nov 2013 20:06:01 +0200
Message-ID: <20131127180601.GA31211@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 27 19:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VljbR-0007Km-LV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 19:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab3K0SMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 13:12:41 -0500
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:43763
	"EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751980Ab3K0SMl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 13:12:41 -0500
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2013 13:12:41 EST
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa06-05.prod.phx3.secureserver.net with 
	id ui631m00F4CavkR01i69Vg; Wed, 27 Nov 2013 11:06:13 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238449>

Custom tags have higher priority than sel, and when they define
their own background, it makes selection invisible. Especially
inconvenient for filesep (to select filenames), but may aslo affect
other tags.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5cd00d8..9f350ab 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2385,6 +2385,7 @@ proc makewindow {} {
     $ctext tag conf found -back $foundbgcolor
     $ctext tag conf currentsearchhit -back $currentsearchhitbgcolor
     $ctext tag conf wwrap -wrap word
+    $ctext tag raise sel
 
     .pwbottom add .bleft
     if {!$use_ttk} {
-- 
1.8.4.2.1566.g3c1a064
