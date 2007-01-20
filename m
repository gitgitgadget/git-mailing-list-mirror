From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sat, 20 Jan 2007 10:49:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 20 10:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Cqj-0004K5-TV
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 10:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbXATJtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 04:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbXATJtR
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 04:49:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:41688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965240AbXATJtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 04:49:17 -0500
Received: (qmail invoked by alias); 20 Jan 2007 09:49:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 20 Jan 2007 10:49:15 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37263>


Embarassing thinko.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 reflog-walk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index d4b49c7..d58ff9b 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -70,7 +70,7 @@ static int get_reflog_recno_by_time(struct complete_reflogs *array,
 	unsigned long timestamp)
 {
 	int i;
-	for (i = array->nr - 1; i >= 0; i++)
+	for (i = array->nr - 1; i >= 0; i--)
 		if (timestamp >= array->items[i].timestamp)
 			return i;
 	return -1;
-- 
1.5.0.rc1.gd85c
