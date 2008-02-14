From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] diff.c: replace a 'strdup' with 'xstrdup'.
Date: Thu, 14 Feb 2008 06:50:00 +0100
Message-ID: <20080214065000.083c3617.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 06:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPWtz-0003Gr-It
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 06:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbYBNFoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 00:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYBNFoG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 00:44:06 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:36296 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYBNFoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 00:44:05 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D3DFD1AB2BF;
	Thu, 14 Feb 2008 06:44:02 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 98A921AB2C4;
	Thu, 14 Feb 2008 06:44:02 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73847>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	By the way perhaps the 

 		return error("%s: lacks value", var);

	should also be changed to

		return config_error_nonbool(var);

	or the check could be removed because there is
	already a check line 171 just before
	'parse_lldiff_command' is called.

diff --git a/diff.c b/diff.c
index cd8bc4d..e5db293 100644
--- a/diff.c
+++ b/diff.c
@@ -88,7 +88,7 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 
 	if (!value)
 		return error("%s: lacks value", var);
-	drv->cmd = strdup(value);
+	drv->cmd = xstrdup(value);
 	return 0;
 }
 
-- 
1.5.4.20.gc135a-dirty
