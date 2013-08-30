From: Thorsten Glaser <t.glaser@tarent.de>
Subject: [PATCH] fix shell syntax error in template
Date: Fri, 30 Aug 2013 12:40:30 +0200
Message-ID: <20130830104308.AAF467001B5@tglase.lan.tarent.de>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Fri Aug 30 12:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFMI9-0007x0-8S
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 12:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab3H3Ku4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 06:50:56 -0400
Received: from ugs.tarent.de ([193.107.123.165]:38603 "EHLO ugs.tarent.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721Ab3H3Ku4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 06:50:56 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2013 06:50:56 EDT
Received: from localhost (localhost [127.0.0.1])
	by ugs.tarent.de (Postfix) with ESMTP id 5DAFE60612D21;
	Fri, 30 Aug 2013 12:43:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ugs.tarent.de (Postfix) with ESMTP id 3ADAA60612D22;
	Fri, 30 Aug 2013 12:43:09 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.1 (20080629) (Debian) at tarent.de
Received: from ugs.tarent.de ([127.0.0.1])
	by localhost (ugs.tarent.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 76gWaWqhi+3E; Fri, 30 Aug 2013 12:43:09 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
	by ugs.tarent.de (Postfix) with ESMTPS id 063D960612D21;
	Fri, 30 Aug 2013 12:43:09 +0200 (CEST)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
	id AAF467001B5; Fri, 30 Aug 2013 12:43:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233437>

an if clause must not be empty; add a "colon" command

Signed-off-by: Thorsten Glaser <t.glaser@tarent.de>
---
 templates/hooks--pre-push.sample | 1 +
 1 file changed, 1 insertion(+)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 15ab6d8..1f3bceb 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -30,6 +30,7 @@ do
 	if [ "$local_sha" = $z40 ]
 	then
 		# Handle delete
+		:
 	else
 		if [ "$remote_sha" = $z40 ]
 		then
-- 
1.8.4.rc3
