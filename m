From: Brian Moyle <bmoyle@pobox.com>
Subject: [PATCH] Fix sed subst. in cogito cmd-complete script
Date: Wed, 24 Jan 2007 13:45:40 -0800
Message-ID: <20070124214540.GB30675@santaclara.siphon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 23:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9qMM-0003Bd-Eh
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 23:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXAXWMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbXAXWMr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 17:12:47 -0500
Received: from 69.90.210.36.available.our-websites.com ([69.90.210.36]:60671
	"EHLO santaclara.siphon.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752077AbXAXWMr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 17:12:47 -0500
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jan 2007 17:12:47 EST
Received: by santaclara.siphon.net (Postfix, from userid 504)
	id B92DA6C796; Wed, 24 Jan 2007 13:45:40 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37686>

Apparently, the "\c" confuses sed (v4.1.2).  Removing the '\'.

Signed-off-by: Brian Moyle <bmoyle@pobox.com>
---
 contrib/cg-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/cg-completion.bash b/contrib/cg-completion.bash
index 428f320..4011cce 100644
--- a/contrib/cg-completion.bash
+++ b/contrib/cg-completion.bash
@@ -23,7 +23,7 @@ __cg_branches()
 
 __cg_cmdlist()
 {
-	(cg help && cg help tag && cg help branch && cg help admin) | grep --regexp "cg-[^ ]* " | sed 's/^.*\cg-\([^ ]*\) .*$/\1/' | grep -v COMMAND
+	(cg help && cg help tag && cg help branch && cg help admin) | grep --regexp "cg-[^ ]* " | sed 's/^.*cg-\([^ ]*\) .*$/\1/' | grep -v COMMAND
 
 }
 
-- 
1.4.4.4
