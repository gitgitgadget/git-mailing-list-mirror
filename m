From: Sven Marnach <sven.marnach@ipvs.uni-stuttgart.de>
Subject: [PATCH] gitk: pretty print tag objects
Date: Mon, 31 Mar 2008 22:29:29 +0200
Message-ID: <20080331202929.GA4094@pantoffel-wg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 22:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgQeW-0003LK-EG
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 22:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893AbYCaU3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755256AbYCaU3g
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 16:29:36 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:37183 "EHLO
	relay.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbYCaU3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 16:29:35 -0400
Received: from ix.urz.uni-heidelberg.de (cyrus1.urz.uni-heidelberg.de [129.206.119.235])
	by relay.uni-heidelberg.de (8.14.1/8.14.1) with ESMTP id m2VKTUHP015844
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 22:29:30 +0200
Received: from extmail.urz.uni-heidelberg.de (extmail.urz.uni-heidelberg.de [129.206.100.140])
	by ix.urz.uni-heidelberg.de (8.8.8/8.8.8) with ESMTP id WAA21758068
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 22:29:31 +0200
Received: from bagheera.suspekt (dslb-084-056-235-054.pools.arcor-ip.net [84.56.235.54])
	(authenticated bits=0)
	by extmail.urz.uni-heidelberg.de (8.13.4/8.13.1) with ESMTP id m2VKTH3b025212
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 22:29:19 +0200
Received: from sven by bagheera.suspekt with local (Exim 4.69)
	(envelope-from <sven@pantoffel-wg.de>)
	id 1JgQdF-00028x-EW
	for git@vger.kernel.org; Mon, 31 Mar 2008 22:29:29 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78602>

Currently, tag objects are shown as the raw tag object contents.  By
pretty printing them, the time stamp is shown in a more readable
format (and this is actually the only difference to the raw format).

Signed-off-by: Sven Marnach <sven.marnach@ipvs.uni-stuttgart.de>
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 84ab02e..4581893 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7843,7 +7843,7 @@ proc showtag {tag isnew} {
     set linknum 0
     if {![info exists tagcontents($tag)]} {
 	catch {
-	    set tagcontents($tag) [exec git cat-file tag $tagobjid($tag)]
+	    set tagcontents($tag) [exec git cat-file -p $tagobjid($tag)]
 	}
     }
     if {[info exists tagcontents($tag)]} {
-- 
debian.1.5.5_rc2.1
