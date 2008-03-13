From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] help: warn if specified 'man.viewer' is unsupported,
 instead of erroring out
Date: Thu, 13 Mar 2008 07:10:40 +0100
Message-ID: <20080313071040.bbf5528b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Thu Mar 13 07:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZgZs-0004gb-8e
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 07:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYCMGFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 02:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYCMGFA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 02:05:00 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:59500 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbYCMGE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 02:04:59 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B36A01AB2DB;
	Thu, 13 Mar 2008 07:04:58 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 564E51AB2D6;
	Thu, 13 Mar 2008 07:04:58 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77038>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	This was suggested by Xavier Maillard.

diff --git a/help.c b/help.c
index 5da8c9c..ecaca77 100644
--- a/help.c
+++ b/help.c
@@ -139,7 +139,7 @@ static int add_man_viewer(const char *value)
 	else if (!strcasecmp(value, "konqueror"))
 		do_add_man_viewer(exec_man_konqueror);
 	else
-		return error("'%s': unsupported man viewer.", value);
+		warning("'%s': unsupported man viewer.", value);
 
 	return 0;
 }
-- 
1.5.4.3.395.g492b.dirty
