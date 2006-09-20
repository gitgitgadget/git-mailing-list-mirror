From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] describe: fall back to 'HEAD' if no appropriate tag exists
Date: Wed, 20 Sep 2006 23:25:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609202324210.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Sep 20 23:26:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9ZD-0007MY-7c
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWITVZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWITVZK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:25:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:40384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932124AbWITVZJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 17:25:09 -0400
Received: (qmail invoked by alias); 20 Sep 2006 21:25:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 20 Sep 2006 23:25:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27404>


Now, if no tag exists to say something like '<tag>-gfffffff', say
'HEAD-gfffffff' instead of erroring out.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/describe.c b/describe.c
index ab192f8..8b08a3f 100644
--- a/describe.c
+++ b/describe.c
@@ -136,7 +136,7 @@ static void describe(const char *arg, in
 			return;
 		}
 	}
-	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+	printf("HEAD-g%s\n", find_unique_abbrev(cmit->object.sha1, abbrev));
 }
 
 int main(int argc, char **argv)
-- 
1.4.2.1.ga0df5-dirty
