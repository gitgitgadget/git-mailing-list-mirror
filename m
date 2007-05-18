From: skimo@liacs.nl
Subject: [PATCH 05/16] unpack-trees.c: verify_uptodate: remove dead code
Date: Fri, 18 May 2007 21:24:54 +0200
Message-ID: <11795163061911-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp856-0002MY-77
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585AbXERTZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbXERTZf
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:35 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55762 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757585AbXERTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:23 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPD3o005200;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 858ED7DDA4; Fri, 18 May 2007 21:25:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47648>

From: Sven Verdoolaege <skimo@kotnet.org>

This code was killed by commit fcc387db9bc453dc7e07a262873481af2ee9e5c8.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 unpack-trees.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 906ce69..cac2411 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -414,10 +414,6 @@ static void verify_uptodate(struct cache_entry *ce,
 			return;
 		errno = 0;
 	}
-	if (o->reset) {
-		ce->ce_flags |= htons(CE_UPDATE);
-		return;
-	}
 	if (errno == ENOENT)
 		return;
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
-- 
1.5.2.rc3.783.gc7476-dirty
