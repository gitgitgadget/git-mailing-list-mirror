From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Active_nr is unsigned, hence can't be < 0
Date: Thu,  7 Jun 2007 22:44:59 +0200
Message-ID: <118124910076-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwOr5-00084c-8v
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 22:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762575AbXFGUpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 16:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764282AbXFGUpF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 16:45:05 -0400
Received: from pan.madism.org ([88.191.52.104]:52101 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762575AbXFGUpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 16:45:04 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 82B18C039;
	Thu,  7 Jun 2007 22:45:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DD2A43D93; Thu,  7 Jun 2007 22:45:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49387>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 sha1_name.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7df01af..858f08c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -682,8 +682,6 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 		namelen = namelen - (cp - name);
 		if (!active_cache)
 			read_cache();
-		if (active_nr < 0)
-			return -1;
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
-- 
1.5.2.1
