From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow gitk to continue and show error message in new repos
Date: Sun, 29 Jul 2007 22:28:40 +0200
Message-ID: <20070729202840.GA9362@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 22:28:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFFNf-0006so-5O
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 22:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935015AbXG2U2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 16:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935219AbXG2U2o
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 16:28:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:63794 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935015AbXG2U2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 16:28:43 -0400
Received: from tigra.home (Facac.f.strato-dslnet.de [195.4.172.172])
	by post.webmailer.de (mrclete mo29) (RZmta 10.3)
	with ESMTP id u07268j6TFlghq ; Sun, 29 Jul 2007 22:28:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D1F84277BD;
	Sun, 29 Jul 2007 22:28:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 67E92C21D; Sun, 29 Jul 2007 22:28:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz2KC8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54136>

If there is no commit made yet, gitk just dumps a Tcl error on stderr,
which sometimes is hard to see. Noticed when gitk was run from Xfce
file manager (thunar's custom action).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f74ce51..fc7cc8c 100755
--- a/gitk
+++ b/gitk
@@ -427,7 +427,7 @@ proc readrefs {} {
 	    lappend idotherrefs($id) $name
 	}
     }
-    close $refd
+    catch { close $refd }
     set mainhead {}
     set mainheadid {}
     catch {
-- 
1.5.3.rc3.48.g5b618
